---
title: Migrating to v6 — iOS
excerpt: >-
  Breaking changes and migration steps to upgrade the Purchasely iOS SDK from
  v5.x to v6.0.0
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

Version 6.0.0 introduces a fluent initialization builder, a granular per‑action interceptor API, clearer naming, and a consolidated paywall display surface built around `PLYPresentationBuilder`. `PLYPresentation` becomes a protocol (most call sites compile unchanged).

> 🚧 The default running mode changed to Observer — silently
>
> In v6 the default `runningMode` is **`.observer`** (it was `.full` in v5). Your code compiles without errors, but if you relied on the implicit `.full` default, your app will **stop validating transactions** until you add `.runningMode(.full)` to your start chain.

***

## Requirements

No changes: v6.0.0 keeps the same minimum deployment targets and dependency requirements as v5.x. The SDK still ships as a prebuilt binary `Purchasely.xcframework` with no third‑party runtime dependencies (Lottie remains integrator‑supplied via the `PLYLottieBridge` runtime bridge, unchanged from v5).

***

## Summary of breaking changes

| v5                                                                     | v6                                                                     |
| ---------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| Default running mode `.full`                                           | Default running mode `.observer` ⚠️                                    |
| `Purchasely.start(withAPIKey:…)`                                       | `Purchasely.apiKey(…)…start()` (fluent builder)                        |
| `setPaywallActionsInterceptor { … }`                                   | `Purchasely.interceptAction(.x) { … }` returning `PLYInterceptResult`  |
| `PLYPresentationInfo`                                                  | `PLYInterceptorInfo`                                                   |
| `Purchasely.fetchPresentation(...)`                                    | `PLYPresentationBuilder.…build().preload { … }`                        |
| `presentationController(…)` / `productController(…)` / `planController(…)` | `PLYPresentationBuilder` (owns display end‑to‑end)                 |
| `presentationView(…)` / `productView(…)` / `planView(…)`               | `PLYPresentationBuilder` + `presentation.swiftUIView`                  |
| `controller.PresentationView`                                          | `presentation.swiftUIView`                                             |
| `Purchasely.display(for:displayMode:)`                                 | `Purchasely.display(for:transition:)`                                  |
| `setDefaultPresentationResultHandler { result, plan in … }`            | `setDefaultPresentationDismissHandler { outcome in … }`                |
| `PLYProductViewControllerResult` dismiss result                        | `PLYPresentationOutcome` (adds `closeReason`)                          |
| `PLYPresentation` (class)                                              | `PLYPresentation` (protocol)                                           |
| `PLYDisplayMode` / `PLYDisplayModeType`                                | `PLYTransition` / `PLYTransitionType`                                  |
| `PLYPresentation.id` / `.displayMode`                                  | `PLYPresentation.screenId` / `.transition`                             |
| `onClose(_:)` builder callback                                         | `onCloseRequested(_:)`                                                 |
| `Purchasely.closeDisplayedPresentation()`                              | `Purchasely.closeAllScreens()`                                         |
| `readyToOpenDeeplink(_:)` / `isDeeplinkHandled(deeplink:)`             | `allowDeeplink(_:)` / `handleDeeplink(_:)`                             |
| `ply/products/*` & `ply/plans/*` deeplinks                             | `ply/presentations/*` & `ply/placements/*` deeplinks                   |
| Campaigns suppressed by default                                        | Campaigns allowed by default (`allowCampaigns` defaults to `true`)     |
| `Purchasely.showController(_:type:from:)` / `PLYUIControllerType`      | `PLYPresentationBuilder.…build().display(…)`                           |
| `clientPresentationOpened(with:)`                                      | `clientPresentationDisplayed(with:)`                                   |
| `PLYAttribute.oneSignalPlayerId`                                       | `.oneSignalExternalId` / `.oneSignalUserId`                            |
| `PLYEvent.subscriptionsListViewed` / `.cancellationReasonPublished`    | Removed (no replacement — never fired at runtime)                      |

***

## 1. Install / pin the SDK

v6.0.0 adds a first‑class **Swift Package Manager** channel alongside the existing CocoaPods and Carthage ones. All three are served by the [Purchasely-iOS distribution repo](https://github.com/Purchasely/Purchasely-iOS) and vendor the same binary `Purchasely.xcframework` — no source is compiled into your app.

**Swift Package Manager (new in 6.0.0):**

```swift
// In your Package.swift dependencies:
.package(url: "https://github.com/Purchasely/Purchasely-iOS.git", from: "6.0.0")
```

In Xcode: *File ▸ Add Package Dependencies…* and enter `https://github.com/Purchasely/Purchasely-iOS`.

**CocoaPods:**

```ruby
pod 'Purchasely', '~> 6.0'
```

**Carthage** continues to work unchanged (`binary "…/Purchasely.json"`).

***

## 2. SDK initialization — fluent builder

`Purchasely.start(withAPIKey:appUserId:runningMode:storekitSettings:logLevel:initialized:)` is **removed**. Start with `Purchasely.apiKey(_:)` (required — there is no path to `start()` without it), chain modifiers, finish with `start()`.

### Default running mode is now `.observer` ⚠️

The default `runningMode` changed from `.full` to `.observer`. **If you want Purchasely to handle and validate purchases, set&#x20;**`.full`**&#x20;explicitly.**

> 🚧 This change is silent
>
> Your code compiles without errors. If you relied on the implicit `.full` default, your app will **stop validating transactions** until you add `.runningMode(.full)`.

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

| Modifier                                   | Default                                                                                                    |
| ------------------------------------------ | ---------------------------------------------------------------------------------------------------------- |
| `appUserId(_:)`                            | `nil` (anonymous)                                                                                          |
| `runningMode(_:)`                          | `.observer` ⚠️ (was `.full` in v5)                                                                         |
| `storekitSettings(_:)`                     | `.storeKit2`                                                                                               |
| `logLevel(_:)`                             | `.error`                                                                                                   |
| `environment(_:)`                          | `.prod`                                                                                                    |
| `showsPromotedInAppPurchasePaywall(_:)`    | `true` in `.full` mode, else `false`                                                                       |
| `themeMode(_:)`                            | `.system`                                                                                                  |
| `allowDeeplink(_:)`                        | `true` — deeplinks are allowed by default; they run once the SDK is configured unless you pass `false`     |
| `allowCampaigns(_:)`                       | `true` (was `false` in v5) — see the campaigns note below                                                  |
| `handleDeeplink(_:)`                       | `nil` — hand the SDK a cold‑start deeplink; it is handled automatically once `start()` completes           |

> 🚧 Campaigns are now allowed by default
>
> `allowCampaigns` defaults to **`true`** in v6 (was `false` in v5). The backend `allow_campaigns` config seeds the gate during `start()`; an explicit `allowCampaigns(false)` is sticky and survives the backend seed. Campaign deeplinks now also **wait for configuration**: a campaign arriving before the config response is queued and drains once the SDK has configured. If you relied on the v5 default of campaigns being suppressed until explicitly enabled, add `.allowCampaigns(false)` to your start chain.

> 📘 Deprecated pre‑`start` class funcs (removal planned for v7)
>
> `setEnvironment(_:)`, `setShowPromotedInAppPurchasePaywall(_:)`, `setAppTechnology(_:)`, `setSdkBridgeVersion(_:)` and `setThemeMode(_:)` are **deprecated**. Migrate them to their chain‑modifier equivalents — values set through them before the chain entry are snapshotted into the builder, and chain modifiers override them.

***

## 3. Action interceptor — per‑action API

The global `setPaywallActionsInterceptor` is **removed**. Register one interceptor per action with `Purchasely.interceptAction()`; each returns an explicit `PLYInterceptResult` instead of an ambiguous boolean. Actions without an interceptor are executed by the SDK directly.

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

```objc
// Objective-C
[Purchasely interceptAction:PLYPresentationActionLogin
                    handler:^(PLYInterceptorInfo *info,
                              PLYPresentationActionParameters *params,
                              void (^completion)(PLYInterceptResult)) {
    [self showLoginWithCompletion:^(BOOL loggedIn) {
        completion(loggedIn ? PLYInterceptResultNotHandled : PLYInterceptResultSuccess);
    }];
}];
```

### Result semantics

| `PLYInterceptResult` | Meaning                             | SDK behavior                                        |
| -------------------- | ----------------------------------- | --------------------------------------------------- |
| `.success`           | App handled the action successfully | Chain advances to next action                       |
| `.failed`            | App tried but failed                | Remaining actions from this interaction are skipped |
| `.notHandled`        | App doesn't want to handle this     | SDK executes the action itself                      |

> 📘 Observer mode
>
> `.notHandled` for `.purchase` / `.restore` in observer mode logs a warning and skips — the SDK cannot execute purchases in observer mode.

`processAction(false)` → `.success`, <br />`processAction(true)` → `.notHandled`. <br />Remove interceptors with `Purchasely.removeActionInterceptor(.login)` / `Purchasely.removeAllActionInterceptors()`.

### `PLYPresentationInfo` → `PLYInterceptorInfo`

`PLYPresentationInfo` is removed; the new `PLYInterceptorInfo` is passed automatically and carries the full `PLYPresentation` (`info.presentation?.type`, `.plans`, `.metadata`, `.language`, …):

| `PLYPresentationInfo` (removed)          | `PLYInterceptorInfo` (new)                         |
| ---------------------------------------- | -------------------------------------------------- |
| `info.presentationId`                    | `info.presentation?.screenId`                      |
| `info.placementId`                       | `info.presentation?.placementId`                   |
| `info.audienceId`                        | `info.presentation?.audienceId`                    |
| `info.abTestId` / `info.abTestVariantId` | `info.presentation?.abTestId` / `…abTestVariantId` |
| `info.campaignId`                        | `info.presentation?.campaignId`                    |
| `info.contentId` / `info.controller`     | `info.contentId` / `info.controller`               |

The `paywallActionsInterceptor:` parameter is also removed from `start()` — register interceptors separately after initialization — and the `PLYPaywallActionsInterceptor` typealias no longer exists.

***

## 4. Presentation display — `PLYPresentationBuilder`

The four `Purchasely.fetchPresentation(...)` overloads are **removed**. Build a request with `PLYPresentationBuilder`, then `preload` and/or `display`.

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

| Legacy callback     | Fires when                                | Builder hook                                |
| ------------------- | ----------------------------------------- | ------------------------------------------- |
| `fetchCompletion:`  | The presentation was fetched              | `.preload { presentation, error in … }`     |
| `loadedCompletion:` | The paywall is on screen                  | `.onPresented { presentation, error in … }` |
| `completion:`       | The product view controller was dismissed | `.onDismissed { outcome in … }`             |

`PLYPresentationBuilder` supports content id, color overrides, header‑button overrides and lifecycle callbacks (`onPresented`, `onCloseRequested`, `onDismissed`). Use `.forScreenId(...)` for a specific Screen or `.default()` for the default one:

```swift
PLYPresentationBuilder.from(placementId: "onboarding")
    .backgroundColor(.systemBackground)
    .onPresented { _, _ in /* paywall is on screen */ }
    .onDismissed { outcome in /* user closed; outcome carries purchase result */ }
    .build()
    .display(completion: nil)
```

From Objective‑C, use the dedicated factories `forPlacementId:` / `forScreenId:` (the Swift `from(placementId:)` statics are not exposed to Objective‑C):

```objc
PLYPresentationBuilder *builder = [PLYPresentationBuilder forPlacementId:@"onboarding"];
[builder onDismissed:^(PLYPresentationOutcome *outcome) { /* … */ }];
[[builder build] displayWithCompletion:nil];
```

> 📘 Header‑button overrides
>
> `displayCloseButton(_:)` / `displayBackButton(_:)` are **suppression‑only** on iOS: passing `false` hides a button the backend would show; passing `true` does **not** force a backend‑hidden button to appear. They are build‑time only — set them before `build()`.

> 📘 Flow inheritance
>
> When the loaded presentation is the entry point of a flow, the builder's callbacks and color overrides are inherited by every subsequent step; settings are reset when the flow closes.

### `Purchasely.display(...)` simplified

The four `display(...)` overloads (placement / vendor‑id × async / completion) are replaced by two one‑line conveniences. The parameter is renamed from `displayMode:` to `transition:`, and `placementId` is required — there is no longer a vendor‑ID or completion variant on `Purchasely.display(...)`:

```swift
// Fire-and-forget (Swift + Objective-C)
Purchasely.display(for: placementId, transition: nil)     // backend-defined transition
Purchasely.display(for: placementId, transition: .modal)  // override

// Async/await (Swift only)
let presentation = try await Purchasely.display(for: placementId, transition: .modal)
```

For a direct Screen, a dismiss completion, or richer configuration, use `PLYPresentationBuilder` directly:

```swift
PLYPresentationBuilder.forScreenId(presentationId).build().display(transition: .modal, completion: nil)
```

### `PLYPresentationOutcome` — the dismissal result

The dismiss `completion:` used to deliver a `PLYProductViewControllerResult` enum. `onDismissed` now delivers a `PLYPresentationOutcome` carrying five fields:

| Field            | Type                | Meaning                                             |
| ---------------- | ------------------- | --------------------------------------------------- |
| `purchaseResult` | `PLYPurchaseResult` | `.purchased` / `.cancelled` / `.restored` / `.none` |
| `plan`           | `PLYPlan?`          | The purchased plan, when applicable                 |
| `presentation`   | `PLYPresentation?`  | The presentation that produced this outcome         |
| `closeReason`    | `PLYCloseReason`    | **New** — why the paywall closed                    |
| `error`          | `Error?`            | Reserved (always `nil` in 6.0)                      |

`outcome.closeReason` is a new non‑optional `PLYCloseReason` enum that tells a user close apart from a system dismissal or a programmatic close:

| Case                  | Fires when                                                                                            |
| --------------------- | ----------------------------------------------------------------------------------------------------- |
| `.button`             | User tapped a close or back button rendered by the paywall                                            |
| `.interactiveDismiss` | User dismissed with a system gesture — modal swipe‑down or navigation‑stack pop (incl. edge‑swipe)    |
| `.programmatic`       | Host app closed it (`Purchasely.closeAllScreens()`, `PLYPresentation.close()`)                        |
| `.none`               | No close happened / not applicable (e.g. a `.purchased` / `.restored` outcome)                        |

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

> 🚧 If you construct `PLYPresentationOutcome` yourself (e.g. in tests)
>
> The designated initializer changed — use the new five‑argument init: `PLYPresentationOutcome(purchaseResult:plan:presentation:closeReason:error:)`.

### Default handler renamed — `setDefaultPresentationDismissHandler`

The global handler for presentations you didn't instantiate yourself (campaigns, deeplinks, Promoted In‑App Purchases) is renamed and now delivers the full `PLYPresentationOutcome` instead of the legacy `(PLYProductViewControllerResult, PLYPlan?)` pair.

### Before (v5)

```swift
Purchasely.setDefaultPresentationResultHandler { result, plan in
    switch result {
    case .purchased: print("purchased \(plan?.vendorId ?? "?")")
    case .restored:  print("restored")
    case .cancelled: print("closed")
    @unknown default: break
    }
}
```

### After (v6)

```swift
Purchasely.setDefaultPresentationDismissHandler { outcome in
    switch outcome.purchaseResult {
    case .purchased: print("purchased \(outcome.plan?.vendorId ?? "?")")
    case .restored:  print("restored")
    case .cancelled: print("closed (\(outcome.closeReason))")
    case .none:      break
    @unknown default: break
    }
    // The app didn't instantiate this presentation, so the outcome carries it:
    print("from presentation \(outcome.presentation?.screenId ?? "?")")
}
```

> 📘 Mutually exclusive with per‑presentation callbacks
>
> This handler fires only for presentations that have neither an inline `onDismissed` (set via `PLYPresentationBuilder`) nor a per‑call completion block. Builder‑driven presentations deliver their outcome through their own callback only.

### Closing presentations

`Purchasely.closeDisplayedPresentation()` is **removed** — it didn't cover every display path. Use `Purchasely.closeAllScreens()` (available since 5.7.2), which handles every display path:

```swift
Purchasely.closeAllScreens()   // was Purchasely.closeDisplayedPresentation()
```

### Transition sizing (new)

`PLYTransition` (the renamed `PLYDisplayMode` — see §7) exposes new sizing for drawer / popin: `height`, `width` (popin only) and `dismissible`. `PLYDimension` is now public so you can construct sized transitions in code:

```swift
let drawer  = PLYTransition.drawer(height: .value(400))                 // 400px tall
let popin   = PLYTransition.popin(width: .percentage(0.9), height: .value(500))
let hug     = PLYTransition.drawer(height: nil)                         // size to content
let blocked = PLYTransition.modal(dismissible: false)                   // block ambient dismiss
```

When `dismissible` is `false`, ambient dismiss (background tap, swipe‑down, iPad form‑sheet tap‑outside) is blocked; the close button and programmatic dismiss still work. The Swift‑only legacy factories `drawer(heightPercentage:dismissible:)` and `popin(heightPercentage:dismissible:)` are kept as **deprecated** routers to the new `PLYDimension`‑based factories.

***

## 5. `PLYPresentation` is now a protocol

`PLYPresentation` changed from a class to a public `@objc` protocol. **Reading members and calling methods works unchanged** — every property (`screenId`, `placementId`, `plans`, `metadata`, …) and method (`display(from:)`, `close()`, `back()`, `executeConnection(_:)`, …) is a protocol requirement that resolves identically. Reference equality (`===`) on SDK‑returned values also still works.

Where you may need a change:

- **Objective‑C** signatures `(PLYPresentation *)` → `(id<PLYPresentation>)` — including the `PLYPresentationFetchCompletionBlock` block type. Method bodies typically need no other edits.
- **Swift** delegate signatures may write `any PLYPresentation` (both `PLYPresentation` and `any PLYPresentation` compile).
- The public delegate protocols `PLYUIHandler`, `PLYCustomScreenViewControllerDelegate`, `PLYCustomScreenViewDelegate` now declare `any PLYPresentation`; `PLYInterceptorInfo.presentation` is `(any PLYPresentation)?`.
- Subclassing `PLYPresentation` no longer compiles (protocols can't be subclassed) — conform to the protocol instead (rare: the v5 init was internal‑only).

***

## 6. Embedded paywalls & SwiftUI

All the manual‑embedding factory methods are **removed** — `PLYPresentationBuilder` owns presentation, display, and dismissal end‑to‑end:

- The eight UIViewController‑returning methods: `Purchasely.presentationController(…)`, `productController(…)`, `planController(…)` and their overloads.
- The eight SwiftUI `PLYPresentationView?`‑returning methods: `Purchasely.presentationView(…)`, `productView(…)`, `planView(…)` and their overloads.
- `Purchasely.showController(_:type:from:)` and the `PLYUIControllerType` enum.
- The PascalCase `controller.PresentationView` SwiftUI bridge.

For UIKit, use `presentation.controller` after `preload()`. For SwiftUI, read `presentation.swiftUIView` — a `PLYPresentationView?` accessor (named `swiftUIView`, not `view`, to disambiguate from `UIKit.UIView`; returns `nil` for `.deactivated` presentations). Take the dismissal result from `onDismissed`.

Whenever you take over the display this way, keep a strong reference to the `PLYPresentation` for as long as the controller or view is on screen, in a property rather than a local. If it is released, `onPresented`, `onCloseRequested` and `onDismissed` stop firing silently. `.build().display(completion: nil)` has no such requirement, because the SDK owns the display.

### Before (v5)

```swift
// UIKit
if let ctrl = Purchasely.presentationController(for: "onboarding", contentId: nil,
                                                completion: completion) {
    Purchasely.showController(ctrl, type: .productPage, from: self)
}

// SwiftUI
let view = Purchasely.presentationView(for: "onboarding",
                                       loaded: { _ in /* loaded */ }) { result, plan in
    // handle result / plan
}
```

### After (v6)

```swift
// UIKit — let the builder display it…
PLYPresentationBuilder
    .forPlacementId("onboarding")
    .onDismissed { outcome in /* your completion body */ }
    .build()
    .display(completion: nil)

// SwiftUI — …or preload and embed the view yourself
PLYPresentationBuilder
    .forPlacementId("onboarding")
    .onDismissed { outcome in /* outcome carries purchaseResult + plan */ }
    .build()
    .preload { presentation, error in
        if let view = presentation?.swiftUIView {
            self.paywallView = view   // SwiftUI View
        }
    }
```

***

## 7. Deeplinks

The old methods — deprecated during the 6.0 cycle — are **removed** in v6 (no alias). Update the call sites:

| v5 (removed)                              | v6                              |
| ----------------------------------------- | ------------------------------- |
| `Purchasely.readyToOpenDeeplink(_:)`      | `Purchasely.allowDeeplink(_:)`  |
| `Purchasely.isDeeplinkHandled(deeplink:)` | `Purchasely.handleDeeplink(_:)` |

### Before (v5)

```swift
Purchasely.readyToOpenDeeplink(true)
let handled = Purchasely.isDeeplinkHandled(deeplink: url)
```

### After (v6)

```swift
Purchasely.allowDeeplink(true)
let handled = Purchasely.handleDeeplink(url)
```

> 📘 Deeplinks are allowed by default
>
> In v6, deeplinks are allowed by default and run once the SDK is configured. Call `Purchasely.allowDeeplink(false)` to defer them (e.g. during onboarding) and `allowDeeplink(true)` when ready. You can also hand a cold‑start deeplink to the SDK at initialization — it is handled automatically once `start()` completes, and non‑Purchasely URLs are ignored: `Purchasely.apiKey("…").handleDeeplink(url).start { error in }`.

### Product / plan deeplinks removed

The `ply/products/*` and `ply/plans/*` deeplink formats are **removed** in v6 — a deeplink targeting one of these paths is no longer handled. Deep‑link to a placement or a presentation instead (both open the screen configured in the Console):

| v5 (removed)                                           | v6                                               |
| ------------------------------------------------------ | ------------------------------------------------ |
| `app_scheme://ply/products/PRODUCT_ID/PRESENTATION_ID` | `app_scheme://ply/presentations/PRESENTATION_ID` |
| `app_scheme://ply/plans/PLAN_ID/PRESENTATION_ID`       | `app_scheme://ply/presentations/PRESENTATION_ID` |
| `app_scheme://ply/products/PRODUCT_ID`                 | `app_scheme://ply/placements/PLACEMENT_ID`       |
| `app_scheme://ply/plans/PLAN_ID`                       | `app_scheme://ply/placements/PLACEMENT_ID`       |

Plan‑driven display continues to work for promoted / uncaught App Store purchases — that internal path is unaffected.

***

## 8. Renames & removals

These are pure renames — same shapes, same behavior. **No deprecated aliases are kept** (major release), so every call site must be updated to compile:

| v5 (removed)                                | v6 (new)                                       |
| ------------------------------------------- | ---------------------------------------------- |
| `PLYDisplayMode` (class)                    | `PLYTransition`                                |
| `PLYDisplayModeType` (enum)                 | `PLYTransitionType`                            |
| `PLYPresentation.id`                        | `PLYPresentation.screenId`                     |
| `PLYPresentation.displayMode`               | `PLYPresentation.transition`                   |
| `PLYPresentationBuilder.onClose(_:)`        | `PLYPresentationBuilder.onCloseRequested(_:)`  |
| `PLYPresentationRequest.onClose`            | `PLYPresentationRequest.onCloseRequested`      |
| `Purchasely.clientPresentationOpened(with:)`| `Purchasely.clientPresentationDisplayed(with:)`|

### Before (v5)

```swift
let mode: PLYDisplayMode = .modal(dismissible: false)
print(info.presentation?.id ?? "-")
let t = presentation.displayMode
PLYPresentationBuilder.forPlacementId("onboarding").onClose { /* … */ }
```

### After (v6)

```swift
let transition: PLYTransition = .modal(dismissible: false)
print(info.presentation?.screenId ?? "-")
let t = presentation.transition
PLYPresentationBuilder.forPlacementId("onboarding").onCloseRequested { /* … */ }
```

### `PLYAttribute.oneSignalPlayerId` removed

`PLYAttribute.oneSignalPlayerId` is **removed** (it was an iOS‑only case with no Android counterpart). Use OneSignal's External ID and/or (legacy) User ID:

```swift
// Before (v5)
Purchasely.setAttribute(.oneSignalPlayerId, value: oneSignalPlayerId)

// After (v6)
Purchasely.setAttribute(.oneSignalExternalId, value: oneSignalExternalId)
// and/or
Purchasely.setAttribute(.oneSignalUserId, value: oneSignalUserId)
```

> 🚧 Backend user‑property key change — action may be required
>
> `.oneSignalPlayerId` was sent under the backend user‑property key `onesignal_player_id`, whereas `.oneSignalExternalId` is sent under `onesignal_external_id`. Once you migrate, any audience segment, paywall targeting rule, or configuration keyed on `onesignal_player_id` will silently stop receiving data — repoint those rules to `onesignal_external_id` (and/or `onesignal_user_id`).

### Two `PLYEvent` cases removed

`PLYEvent.subscriptionsListViewed` and `PLYEvent.cancellationReasonPublished` are **removed** together with the legacy UIKit "My Subscriptions" screen. No SDK code path fired either event, so no integrator was receiving them at runtime — but if you pattern‑match on `PLYEvent` in an `eventTriggered` handler, remove those two `case` branches (they will no longer compile).

> 📘 Enum ordinal changes
>
> `PLYAttribute` and `PLYEvent` are `Int`‑backed `@objc` enums; the removed cases shift the raw `Int` ordinals of the cases after them. This only matters if you serialized the raw `Int` yourself (not supported usage) — code using case names or `event.name` is unaffected.

***

## 9. Observer mode notes

- The default running mode is now `.observer` — if you are intentionally in Observer mode, nothing to change at initialization; if you expect Purchasely to process purchases, add `.runningMode(.full)` (see §2).
- Interceptors returning `.notHandled` for `.purchase` / `.restore` in Observer mode log a warning and skip — the SDK cannot execute purchases in this mode (see §3).
- When displaying your own paywalls, the notification method is renamed — same signature, pass the same `PLYPresentation`:

### Before (v5)

```swift
Purchasely.clientPresentationOpened(with: presentation)
```

### After (v6)

```swift
Purchasely.clientPresentationDisplayed(with: presentation)
```

```objc
// Objective-C
[Purchasely clientPresentationDisplayedWith:presentation];
```

***

## Removed APIs

| v5 API (removed)                                                        | v6 replacement                                                          |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------ |
| `Purchasely.start(withAPIKey:…)` (all positional overloads)              | `Purchasely.apiKey(…)…start()` fluent chain                              |
| `Purchasely.setPaywallActionsInterceptor { … }`                          | `Purchasely.interceptAction(.x) { … }` per action                        |
| `paywallActionsInterceptor:` parameter of `start()`                      | Register interceptors separately after `start()`                         |
| `PLYPaywallActionsInterceptor` typealias                                  | — (use `interceptAction` directly)                                       |
| `PLYPresentationInfo`                                                     | `PLYInterceptorInfo`                                                     |
| `Purchasely.fetchPresentation(...)` (4 overloads)                         | `PLYPresentationBuilder.…build().preload { … }`                          |
| `Purchasely.presentationController(…)` / `productController(…)` / `planController(…)` | `PLYPresentationBuilder.…build().display(…)`                 |
| `Purchasely.presentationView(…)` / `productView(…)` / `planView(…)`       | `PLYPresentationBuilder.…build().preload { … }` + `presentation.swiftUIView` |
| `PLYPresentationViewController.PresentationView`                          | `presentation.swiftUIView`                                               |
| `Purchasely.showController(_:type:from:)` / `PLYUIControllerType`         | `PLYPresentationBuilder.…build().display(…)`                             |
| `Purchasely.display(with: presentationId, …)` / completion overloads      | `PLYPresentationBuilder.forScreenId(…).build().display(…)`               |
| `displayMode:` parameter of `Purchasely.display(...)`                     | `transition:`                                                            |
| `Purchasely.closeDisplayedPresentation()`                                 | `Purchasely.closeAllScreens()`                                           |
| `Purchasely.setDefaultPresentationResultHandler { result, plan in … }`    | `Purchasely.setDefaultPresentationDismissHandler { outcome in … }`       |
| `Purchasely.readyToOpenDeeplink(_:)`                                      | `Purchasely.allowDeeplink(_:)`                                           |
| `Purchasely.isDeeplinkHandled(deeplink:)`                                 | `Purchasely.handleDeeplink(_:)`                                          |
| `ply/products/*` / `ply/plans/*` deeplinks                                | `ply/presentations/<id>` / `ply/placements/<id>`                         |
| `PLYDisplayMode` / `PLYDisplayModeType`                                   | `PLYTransition` / `PLYTransitionType`                                    |
| `PLYPresentation.id` / `PLYPresentation.displayMode`                      | `PLYPresentation.screenId` / `PLYPresentation.transition`                |
| `PLYPresentationBuilder.onClose(_:)` / `PLYPresentationRequest.onClose`   | `onCloseRequested`                                                       |
| `Purchasely.clientPresentationOpened(with:)`                              | `Purchasely.clientPresentationDisplayed(with:)`                          |
| `PLYAttribute.oneSignalPlayerId`                                          | `PLYAttribute.oneSignalExternalId` / `.oneSignalUserId`                  |
| `PLYEvent.subscriptionsListViewed` / `.cancellationReasonPublished`       | — (never fired at runtime)                                               |

***

## Migration checklist

### Breaking (must fix to compile)

- [ ] Update your dependency pin to `6.0.0` (SPM `from: "6.0.0"` or CocoaPods `pod 'Purchasely', '~> 6.0'`)
- [ ] Replace `Purchasely.start(withAPIKey:…)` with the fluent chain `Purchasely.apiKey("…")…start()`
- [ ] If using Full mode, add explicit `.runningMode(.full)` (default changed to `.observer`) ⚠️
- [ ] Replace `setPaywallActionsInterceptor { … }` with per‑action `Purchasely.interceptAction(.x) { … }`
- [ ] Map `processAction(false)` → `.success`, `processAction(true)` → `.notHandled`
- [ ] Replace `PLYPresentationInfo` with `PLYInterceptorInfo`
- [ ] Remove the `paywallActionsInterceptor:` parameter from `start()` and any `PLYPaywallActionsInterceptor` typealias
- [ ] Replace `Purchasely.fetchPresentation(...)` with `PLYPresentationBuilder.…build().preload { … }`
- [ ] Replace `Purchasely.presentationController(…)` / `productController(…)` / `planController(…)` with `PLYPresentationBuilder`
- [ ] Replace `Purchasely.presentationView(…)` / `productView(…)` / `planView(…)` with `PLYPresentationBuilder.…build().preload { presentation, _ in presentation?.swiftUIView }`
- [ ] Replace `controller.PresentationView` with `presentation.swiftUIView`
- [ ] Replace `Purchasely.showController(_:type:from:)` / `PLYUIControllerType` call sites with `PLYPresentationBuilder`
- [ ] Update `Purchasely.display(...)` to `Purchasely.display(for: placementId, transition: …)` (parameter renamed from `displayMode:`; vendor‑ID / completion overloads removed — use the builder)
- [ ] Replace `Purchasely.setDefaultPresentationResultHandler { result, plan in … }` with `Purchasely.setDefaultPresentationDismissHandler { outcome in … }`
- [ ] Replace `Purchasely.closeDisplayedPresentation()` with `Purchasely.closeAllScreens()`
- [ ] Rename `PLYDisplayMode` → `PLYTransition` and `PLYDisplayModeType` → `PLYTransitionType` everywhere (no compat aliases)
- [ ] Rename `PLYPresentation.id` reads to `.screenId` and `.displayMode` to `.transition`
- [ ] Rename `PLYPresentationBuilder.onClose(_:)` / `PLYPresentationRequest.onClose` to `onCloseRequested`
- [ ] Rename `Purchasely.clientPresentationOpened(with:)` to `clientPresentationDisplayed(with:)` (Observer mode)
- [ ] In Objective‑C, change `PLYPresentation *` to `id<PLYPresentation>` in method and block signatures
- [ ] Replace `readyToOpenDeeplink(_:)` with `allowDeeplink(_:)` and `isDeeplinkHandled(deeplink:)` with `handleDeeplink(_:)` (old names removed)
- [ ] Repoint any `ply/products/*` or `ply/plans/*` deeplinks to `ply/presentations/<id>` or `ply/placements/<id>`
- [ ] If you relied on campaigns being suppressed by default (v5), add `.allowCampaigns(false)` — the v6 default is `true`
- [ ] Replace `Purchasely.setAttribute(.oneSignalPlayerId, value:)` with `.oneSignalExternalId` and/or `.oneSignalUserId` — and repoint backend rules keyed on `onesignal_player_id`
- [ ] Remove any `case .subscriptionsListViewed` / `case .cancellationReasonPublished` branches from your `PLYEvent` handler
- [ ] If you construct `PLYPresentationOutcome` in tests, use the five‑argument init `PLYPresentationOutcome(purchaseResult:plan:presentation:closeReason:error:)`

### Deprecated (fix before v7)

- [ ] Migrate the pre‑`start` class funcs (`setEnvironment(_:)`, `setShowPromotedInAppPurchasePaywall(_:)`, `setAppTechnology(_:)`, `setSdkBridgeVersion(_:)`, `setThemeMode(_:)`) to their chain‑modifier equivalents
- [ ] Build and verify no deprecation warnings remain

<br />
