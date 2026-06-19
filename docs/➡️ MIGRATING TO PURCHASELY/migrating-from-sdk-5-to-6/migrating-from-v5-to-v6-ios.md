---
title: Migrating to v6 — iOS
excerpt: Breaking changes and migration steps to upgrade the Purchasely iOS SDK from v5.x to v6.0.0-rc.1
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
This guide covers the **native iOS SDK** (Swift & Objective‑C). For other platforms, see the [Android guide](migrating-from-v5-to-v6-android) or the platform pages listed on the [migration overview](migrating-from-sdk-5-to-6).

Version 6.0.0-rc.1 introduces a fluent initialization builder, a granular per‑action interceptor API, clearer naming, and a consolidated paywall display surface built around `PLYPresentationBuilder`. `PLYPresentation` becomes a protocol (most call sites compile unchanged).

***

## Summary of breaking changes

| v5 | v6 |
|----|----|
| Default running mode `.full` | Default running mode **`.observer`** ⚠️ |
| `Purchasely.start(withAPIKey:…)` | `Purchasely.apiKey(…)…start()` (fluent builder) |
| `setPaywallActionsInterceptor { … }` | `Purchasely.interceptAction(.x) { … }` returning `PLYInterceptResult` |
| `PLYPresentationInfo` | `PLYInterceptorInfo` |
| `Purchasely.fetchPresentation(...)` | `PLYPresentationBuilder.…build().preload { … }` |
| `Purchasely.display(for:displayMode:)` | `Purchasely.display(for:transition:)` |
| `Purchasely.closeDisplayedPresentation()` | `Purchasely.closeAllScreens()` |
| `controller.PresentationView` | `presentation.swiftUIView` |
| `readyToOpenDeeplink(_:)` | `allowDeeplink(_:)` |
| `isDeeplinkHandled(deeplink:)` | `handleDeeplink(_:)` |
| `PLYProductViewControllerResult` | `PLYPresentationOutcome` |

***

## 1. SDK initialization — fluent builder

`Purchasely.start(withAPIKey:appUserId:runningMode:storekitSettings:logLevel:initialized:)` is **removed**. Start with `Purchasely.apiKey(_:)`, chain modifiers, finish with `start()`.

### Default running mode is now `.observer` ⚠️

The default `runningMode` changed from `.full` to `.observer`. **If you want Purchasely to handle and validate purchases, set `.full` explicitly.**

> 🚧 This change is silent — your code compiles without errors. If you relied on the implicit `.full` default, your app will **stop validating transactions** until you add `.runningMode(.full)`.

### Before (v5)

```swift
Purchasely.start(withAPIKey: "YOUR_API_KEY",
                 appUserId: "user_123",
                 runningMode: .full,
                 logLevel: .debug) { success, error in
    // SDK initialized
}
```

### After (v6) — Swift async (recommended)

```swift
do {
    try await Purchasely
        .apiKey("YOUR_API_KEY")
        .appUserId("user_123")
        .runningMode(.full)     // ← required for purchase handling & validation
        .logLevel(.debug)
        .start()
} catch {
    // PLYError.configuration if the apiKey is empty, or any other error
}
```

### After (v6) — completion handler (Objective‑C‑compatible)

```swift
Purchasely
    .apiKey("YOUR_API_KEY")
    .runningMode(.full)
    .start { error in
        // error is nil on success; callback dispatches on the main actor
    }
```

```objc
// Objective-C
[[[[Purchasely apiKey:@"YOUR_API_KEY"]
    appUserId:@"user_123"]
    runningMode:PLYRunningModeFull]
    startWithInitialized:^(NSError * _Nullable error) {
        // error is nil on success
    }];
```

### Chain modifiers and defaults

| Modifier | Default |
|----------|---------|
| `appUserId(_:)` | `nil` (anonymous) |
| `runningMode(_:)` | `.observer` ⚠️ (was `.full` in v5) |
| `storekitSettings(_:)` | `.storeKit2` |
| `logLevel(_:)` | `.error` |
| `environment(_:)` | `.prod` |
| `themeMode(_:)` | `.system` |
| `allowDeeplink(_:)` | `true` — deeplinks display immediately; pass `false` to defer until `Purchasely.allowDeeplink(true)` |
| `allowCampaigns(_:)` | `true` — campaigns display immediately; pass `false` to defer until `Purchasely.allowCampaigns(true)` |
| `handleDeeplink(_:)` | unset — pass a cold‑start deeplink to display once the SDK has started |

> 📘 The pre‑`start` class funcs `setEnvironment(_:)`, `setShowPromotedInAppPurchasePaywall(_:)`, `setAppTechnology(_:)`, `setSdkBridgeVersion(_:)`, `setThemeMode(_:)` are **deprecated** (removal in v7). Use the chain modifiers instead.

***

## 2. Action interceptor — per‑action API

The global `setPaywallActionsInterceptor` is **removed**. Register one interceptor per action; each returns an explicit `PLYInterceptResult`.

### Before (v5)

```swift
Purchasely.setPaywallActionsInterceptor { action, params, info, proceed in
    switch action {
    case .login:    showLogin { loggedIn in proceed(loggedIn) }
    case .purchase: customPurchase(params?.plan) { success in proceed(!success) }
    default:        proceed(true)
    }
}
```

### After (v6) — Swift async (recommended)

```swift
Purchasely.interceptAction(.login) { info, params in
    let loggedIn = await showLoginScreen()
    return loggedIn ? .notHandled : .success
}

Purchasely.interceptAction(.purchase) { info, params in
    guard let plan = params?.plan else { return .notHandled }
    do {
        try await customPurchase(plan)
        return .success
    } catch {
        return .failed
    }
}
```

### After (v6) — completion handler

```swift
Purchasely.interceptAction(.login) { info, params, completion in
    showLoginScreen { loggedIn in
        completion(loggedIn ? .notHandled : .success)
    }
}
```

### Result semantics

| `PLYInterceptResult` | Meaning | SDK behavior |
|----------------------|---------|--------------|
| `.success` | App handled the action successfully | Chain advances to next action |
| `.failed` | App tried but failed | Remaining actions from this interaction are skipped |
| `.notHandled` | App doesn't want to handle this | SDK executes the action itself |

> 📘 `.notHandled` for `.purchase` / `.restore` in observer mode logs a warning and skips — the SDK cannot execute purchases in observer mode.

`processAction(false)` → `.success`, `processAction(true)` → `.notHandled`. Remove interceptors with `Purchasely.removeActionInterceptor(.login)` / `Purchasely.removeAllActionInterceptors()`.

### `PLYPresentationInfo` → `PLYInterceptorInfo`

`PLYPresentationInfo` is removed; the new `PLYInterceptorInfo` is passed automatically:

| `PLYPresentationInfo` (removed) | `PLYInterceptorInfo` (new) |
|---------------------------------|----------------------------|
| `info.presentationId` | `info.presentation?.id` |
| `info.placementId` | `info.presentation?.placementId` |
| `info.audienceId` | `info.presentation?.audienceId` |
| `info.abTestId` / `info.abTestVariantId` | `info.presentation?.abTestId` / `…abTestVariantId` |
| `info.campaignId` | `info.presentation?.campaignId` |
| `info.contentId` / `info.controller` | `info.contentId` / `info.controller` |

The `paywallActionsInterceptor:` parameter is also removed from `start()` — register interceptors separately, and the `PLYPaywallActionsInterceptor` typealias no longer exists.

***

## 3. Presentation display — `PLYPresentationBuilder`

The `Purchasely.fetchPresentation(...)` family and the UIViewController‑returning methods are **removed**. Build a request with `PLYPresentationBuilder`, then `preload` and/or `display`.

### Before (v5)

```swift
Purchasely.fetchPresentation(for: "onboarding") { presentation, error in
    presentation?.display(from: self)
}
```

### After (v6)

```swift
do {
    let presentation = try await PLYPresentationBuilder
        .forPlacementId("onboarding")
        .build()
        .preload()
    presentation.display(from: self)
} catch {
    // handle error
}
```

Mapping the legacy callbacks to builder hooks:

| Legacy callback | Fires when | Builder hook |
|-----------------|------------|--------------|
| `fetchCompletion:` | The presentation was fetched | `.preload { presentation, error in … }` |
| `loadedCompletion:` | The paywall is on screen | `.onPresented { presentation, error in … }` |
| `completion:` | The product view controller was dismissed | `.onDismissed { outcome in … }` |

`PLYPresentationBuilder` supports content id, color overrides, header‑button overrides and lifecycle callbacks:

```swift
PLYPresentationBuilder.from(placementId: "onboarding")
    .backgroundColor(.systemBackground)
    .onPresented { _, _ in /* paywall is on screen */ }
    .onDismissed { outcome in /* user closed; outcome carries purchase result */ }
    .build()
    .display(completion: nil)
```

From Objective‑C, use the factories `forPlacementId:` / `forScreenId:`.

> 📘 `displayCloseButton(_:)` / `displayBackButton(_:)` are **suppression‑only** on iOS: passing `false` hides a button the backend would show; passing `true` does **not** force a backend‑hidden button to appear. They are build‑time only — set them before `build()`.

### `Purchasely.display(...)` simplified

The four `display(...)` overloads are replaced by two one‑line conveniences. The parameter is renamed from `displayMode:` to `transition:`:

```swift
// Fire-and-forget (Swift + Objective-C)
Purchasely.display(for: placementId, transition: nil)     // backend-defined display mode
Purchasely.display(for: placementId, transition: .modal)  // override

// Async/await (Swift only)
let presentation = try await Purchasely.display(for: placementId, transition: .modal)
```

For a direct Screen, a completion, or richer configuration, use `PLYPresentationBuilder.forScreenId(...)` directly.

### `PLYPresentationOutcome` — the dismissal result

`onDismissed` delivers a `PLYPresentationOutcome` carrying five fields:

| Field | Type | Meaning |
|-------|------|---------|
| `purchaseResult` | `PLYPurchaseResult` | `.purchased` / `.cancelled` / `.restored` / `.none` |
| `plan` | `PLYPlan?` | The purchased plan, when applicable |
| `presentation` | `PLYPresentation?` | The presentation that produced this outcome |
| `closeReason` | `PLYCloseReason` | **New** — why the paywall closed |
| `error` | `Error?` | Reserved (always `nil` in 6.0) |

```swift
.onDismissed { outcome in
    switch outcome.closeReason {
    case .button:             /* user tapped close/back */
    case .interactiveDismiss: /* swiped down or popped */
    case .programmatic:       /* app called close */
    case .none:               /* purchased/restored, or not applicable */
    @unknown default: break
    }
}
```

***

## 4. `PLYPresentation` is now a protocol

`PLYPresentation` changed from a class to a public `@objc` protocol. **Reading members and calling methods works unchanged** — every property (`id`, `placementId`, `plans`, `metadata`, …) and method (`display(from:)`, `close()`, `back()`, …) is a protocol requirement that resolves identically.

Where you may need a change:

* **Objective‑C** signatures `(PLYPresentation *)` → `(id<PLYPresentation>)`. Method bodies typically need no other edits.
* **Swift** delegate signatures may write `any PLYPresentation` (both `PLYPresentation` and `any PLYPresentation` compile).
* The public delegate protocols `PLYUIHandler`, `PLYCustomScreenViewControllerDelegate`, `PLYCustomScreenViewDelegate` now declare `any PLYPresentation`.

***

## 5. SwiftUI — `swiftUIView`

The PascalCase `controller.PresentationView` bridge is removed. The eight `PLYPresentationView?`‑returning factory methods — `Purchasely.productView(…)`, `planView(…)`, `presentationView(…)` and their `contentId:` variants — are **removed** too (they were the SwiftUI counterpart to the UIViewController‑returning methods in §3, and still carried the legacy `(PLYProductViewControllerResult, PLYPlan?)` completion block). Read `swiftUIView` off the preloaded presentation instead, and take the dismissal result from `onDismissed`:

```swift
PLYPresentationBuilder
    .forScreenId(id)
    .onDismissed { outcome in /* outcome carries purchaseResult + plan */ }
    .build()
    .preload { presentation, error in
        if let view = presentation?.swiftUIView {
            self.paywallView = view   // SwiftUI View
        }
    }
```

Named `swiftUIView` (not `view`) to disambiguate from `UIKit.UIView`. Returns `nil` for `.deactivated` presentations. UIKit consumers continue to use `presentation.controller`.

***

## 6. Closing presentations

`Purchasely.closeDisplayedPresentation()` is **removed** — use `Purchasely.closeAllScreens()` (available since 5.7.2), which handles every display path:

```swift
Purchasely.closeAllScreens()   // was Purchasely.closeDisplayedPresentation()
```

***

## 7. Deeplinks (deprecated renames)

The old methods still compile but are deprecated (removal in v7):

| v5 (deprecated) | v6 |
|-----------------|----|
| `Purchasely.readyToOpenDeeplink(_:)` | `Purchasely.allowDeeplink(_:)` |
| `Purchasely.isDeeplinkHandled(deeplink:)` | `Purchasely.handleDeeplink(_:)` |

```swift
let handled = Purchasely.handleDeeplink(url)
```

> 📘 In v6, deeplinks display **immediately** by default. Call `Purchasely.allowDeeplink(false)` to defer them (e.g. during onboarding) and `allowDeeplink(true)` when ready. You can also hand a cold‑start deeplink to the SDK at initialization: `Purchasely.apiKey("…").handleDeeplink(url).start { error in }`.
>
> Unlike Android, iOS does **not** intercept deeplinks automatically — you still pass them via `Purchasely.handleDeeplink(_:)` from your `AppDelegate` / `SceneDelegate`.

### Product / plan deeplinks removed (breaking)

The `ply/products/*` and `ply/plans/*` deeplink formats are **removed** in v6. Deep‑link to a placement or a presentation instead — configure the target screen in the Console:

| v5 (removed) | v6 |
|--------------|----|
| `app_scheme://ply/products/PRODUCT_ID/PRESENTATION_ID` | `app_scheme://ply/presentations/PRESENTATION_ID` |
| `app_scheme://ply/plans/PLAN_ID/PRESENTATION_ID` | `app_scheme://ply/presentations/PRESENTATION_ID` |
| `app_scheme://ply/products/PRODUCT_ID` | `app_scheme://ply/placements/PLACEMENT_ID` |
| `app_scheme://ply/plans/PLAN_ID` | `app_scheme://ply/placements/PLACEMENT_ID` |

***

## 8. Display mode sizing (new)

`PLYDisplayMode` exposes new sizing for drawer / popin: `height`, `width` (popin only) and `dismissible`. `PLYDimension` is now public:

```swift
let drawer = PLYDisplayMode.drawer(height: .value(400))                 // 400px tall
let popin  = PLYDisplayMode.popin(width: .percentage(0.9), height: .value(500))
let blocked = PLYDisplayMode.modal(dismissible: false)                  // block ambient dismiss
```

When `dismissible` is `false`, ambient dismiss (background tap, swipe‑down, iPad form‑sheet tap‑outside) is blocked; the close button and programmatic dismiss still work.

***

## Migration checklist

### Breaking (must fix to compile)

* [ ] Replace `Purchasely.start(withAPIKey:…)` with the fluent chain `Purchasely.apiKey("…")…start()`
* [ ] If using Full mode, add explicit `.runningMode(.full)` (default changed to `.observer`)
* [ ] Replace `setPaywallActionsInterceptor { … }` with per‑action `Purchasely.interceptAction(.x) { … }`
* [ ] Map `processAction(false)` → `.success`, `processAction(true)` → `.notHandled`
* [ ] Replace `PLYPresentationInfo` with `PLYInterceptorInfo`
* [ ] Remove the `paywallActionsInterceptor:` parameter from `start()` and any `PLYPaywallActionsInterceptor` typealias
* [ ] Replace `Purchasely.fetchPresentation(...)` with `PLYPresentationBuilder.…build().preload { … }`
* [ ] Replace `controller.PresentationView` with `presentation.swiftUIView`
* [ ] Replace `Purchasely.productView(…)` / `planView(…)` / `presentationView(…)` with `PLYPresentationBuilder.…build().preload { presentation, _ in presentation?.swiftUIView }`
* [ ] Repoint any `ply/products/*` or `ply/plans/*` deeplinks to `ply/presentations/<id>` or `ply/placements/<id>`
* [ ] Replace `Purchasely.closeDisplayedPresentation()` with `Purchasely.closeAllScreens()`
* [ ] Update `Purchasely.display(...)` to `Purchasely.display(for: placementId, transition: …)`
* [ ] In Objective‑C, change `PLYPresentation *` to `id<PLYPresentation>`

### Deprecated (fix before v7)

* [ ] Migrate the pre‑`start` `set*` class funcs to chain modifiers
* [ ] Replace `readyToOpenDeeplink(_:)` with `allowDeeplink(_:)` and `isDeeplinkHandled(deeplink:)` with `handleDeeplink(_:)`
* [ ] Build and verify no deprecation warnings remain
