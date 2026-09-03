---
title: Migrating to v6 — Cordova
excerpt: >-
  Breaking changes and migration steps to upgrade the Purchasely Cordova SDK
  from v5.x to v6.0.0
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
This guide covers the **Cordova** plugin (JavaScript). For the underlying native changes, see the [iOS guide](migrating-from-v5-to-v6-ios) and the [Android guide](migrating-from-v5-to-v6-android), or the platform pages listed on the [migration overview](migrating-from-sdk-5-to-6).

Cordova v6 is a **true breaking builder API**, at parity with the React Native and Flutter SDKs — it is **not** a source-compatible, method-based update. The v5 flat presentation methods (`fetchPresentation*`, `present*`) and the single global action interceptor are **removed, not deprecated**. The new surface is built around three entry points: `Purchasely.builder(apiKey)`, `Purchasely.presentation`, and `Purchasely.interceptAction(kind, handler)`.

> 📘 Scope
>
> Every "Before" example reflects the public **v5** API as shipped in the last v5.x release. If a snippet does not match what your project compiled against, reach out to the Customer Success team.

> 💡 Let the AI help you migrate
>
> The Purchasely AI plugin and the `purchasely-integrate`, `purchasely-review` and `purchasely-debug` skills can read your integration and rewrite the v5 calls to the v6 builder API for you. Point them at the files that call `Purchasely.start`, `presentPresentationForPlacement`, `fetchPresentation`, `setPaywallActionInterceptor`, etc.

***

## Summary of breaking changes

| v5                                                              | v6                                                                                     |
| ---------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| `Purchasely.start(apiKey, stores, …)` (positional)               | `Purchasely.builder(apiKey).…start()` — new fluent builder (recommended) ⚠️            |
| Default running mode `Full`                                      | Default running mode `Observer` ⚠️                                                     |
| `Purchasely.RunningMode.paywallObserver` / `.transactionOnly`     | **removed** — use `Purchasely.RunningMode.observer` (values are name strings)          |
| `fetchPresentation*` / `presentPresentation*` (flat methods)     | `Purchasely.presentation.placement(id) \| .screen(id) \| .defaultSource()` → `.build()` → `.preload()` / `.display()` ⚠️ |
| `presentSubscriptions()` / `presentProductWithIdentifier()` / `presentPlanWithIdentifier()` / `showPresentation()` / `hidePresentation()` | **removed** (no alias) |
| `Purchasely.backPresentation()` (standalone)                      | `request.back()` (request-scoped)                                                       |
| `isFullscreen` boolean on `present*`                              | `request.display(transition)` — a `TransitionType` string, a boolean, or a transition object |
| `outcome.result` (`PurchaseResult` ordinal) + `plan`              | 5-field outcome `{ presentation, purchaseResult, plan, closeReason, error }` — **no legacy `result` field** ⚠️ |
| `setPaywallActionInterceptor(cb)` + `onProcessAction(bool)`       | per-kind `Purchasely.interceptAction(kind, handler)` returning a `Purchasely.InterceptResult` ⚠️ |
| `Purchasely.PaywallAction` (snake_case keys)                     | `Purchasely.PresentationAction` (renamed; **keys are now camelCase** — e.g. `closeAll`, `openPresentation`) |
| `Purchasely.readyToOpenDeeplink(bool)`                            | `Purchasely.allowDeeplink(bool)` (+ new `Purchasely.allowCampaigns(bool)`)              |
| `Purchasely.isDeeplinkHandled(url, s, e)`                         | `Purchasely.handleDeeplink(url, s, e)`                                                  |
| `Purchasely.synchronize()` (fire-and-forget)                     | `Purchasely.synchronize(success, error)` (reports completion)                          |
| `Purchasely.setDefaultPresentationResultHandler(cb)`             | `Purchasely.setDefaultPresentationDismissHandler(cb)` (5-field outcome)                |

> There is **no v5 source-compatibility shim** for any of the rows above: renamed methods were renamed, not aliased, and removed methods no longer resolve. `closeAllScreens`/`closePresentation` and `addEventListener`/`addEventsListener` are the only pairs kept as deprecated aliases — see [Other v6 changes](#10-other-v6-changes-worth-knowing).

***

## 1. Update the plugins

Both Cordova plugins must be pinned to the **same** version:

```shell
cordova plugin add @purchasely/cordova-plugin-purchasely@6.0.0
cordova plugin add @purchasely/cordova-plugin-purchasely-google@6.0.0
```

This pulls the native SDKs:

| Platform | Native artifact |
|----------|-----------------|
| iOS | `pod 'Purchasely', '6.1.0'` (CocoaPods) |
| Android | `io.purchasely:core:6.1.0` + `io.purchasely:google-play:6.1.0` (Maven Central) |

> 📘 6.0.0 is a stable release
>
> The Cordova plugin is now published to npm's `latest` dist-tag (it is no longer a `@next`/release-candidate build). Every `io.purchasely:*` dependency must still resolve to the same version — a stray `6.0.0` in one place and `6.0.1` in another can silently upgrade `core` and produce a `NoSuchMethodError` at runtime.

Minimum OS versions for v6: **iOS 13.4**, **Android API 23** (`compileSdk 36`). There is **no video player plugin on Cordova** (`io.purchasely:player` is not bridged).

***

## 2. `start()` — options object or the new fluent builder

The v5 positional argument list is **removed**. v6 offers two valid forms: the existing **options object** and a new **fluent builder** (parity with the RN/Flutter `Purchasely.builder(apiKey)`), both exposed by the same underlying `start` call. Only `apiKey` is required.

```javascript
// Before (v5) — positional, no longer supported
Purchasely.start('API_KEY', ['Google'], false, null,
    Purchasely.LogLevel.DEBUG, Purchasely.RunningMode.paywallObserver, // removed
    onConfigured, onError);
```

```javascript
// After (v6) — recommended: fluent builder, returns a Promise<boolean>
const isConfigured = await Purchasely.builder('API_KEY')
    .appUserId(null)                            // optional, defaults to anonymous
    .runningMode(Purchasely.RunningMode.full)   // .observer (default) | .full — set .full to handle purchases
    .logLevel(Purchasely.LogLevel.DEBUG)
    .allowDeeplink(true)                        // optional, default true
    .allowCampaigns(true)                       // optional, default true
    .stores([Purchasely.Store.google])          // Store.google | Store.huawei | Store.amazon
    .storekitVersion(Purchasely.StorekitVersion.storeKit2) // iOS only
    .start();                                   // or .start(success, error) for the callback style
```

```javascript
// After (v6) — options object also still valid (unchanged shape)
Purchasely.start(
    {
        apiKey: 'API_KEY',
        stores: [Purchasely.Store.google],
        storeKit1: false,                          // iOS only
        appUserId: null,
        logLevel: Purchasely.LogLevel.DEBUG,
        runningMode: Purchasely.RunningMode.full,  // .observer (default) | .full
        allowDeeplink: true,
        allowCampaigns: true,
    },
    (isConfigured) => {},
    (error) => console.error(error)
);
```

Recognised options/builder methods: `apiKey` (required), `appUserId`, `logLevel`, `runningMode`, `stores`, `storeKit1` / `storekitVersion` (iOS), `allowDeeplink`, `allowCampaigns`, `deeplink` (cold-start URL). `.start()` on the builder resolves a `Promise<boolean>` when called with no arguments, and falls back to the classic `(success, error)` callback style when they are passed.

### Running mode — default is now Observer

The **native default running mode changed from Full to Observer**, and `RunningMode` values are now **name strings** (`'observer'` / `'full'`) — the native iOS and Android enums use different raw values, so the bridge maps by name. `Purchasely.RunningMode.paywallObserver` and `.transactionOnly` were **removed** — use `Purchasely.RunningMode.observer`. Pass `runningMode: Purchasely.RunningMode.full` (or `.runningMode(Purchasely.RunningMode.full)` on the builder) if Purchasely must own the purchase flow and validate receipts.

> 🚧 Behavioral consequence — automatic screen close
>
> In Observer mode, presentations **no longer auto-close** after a purchase or restore. If your app relied on auto-close, pass `Purchasely.RunningMode.full`, or close the screen yourself with `Purchasely.closeAllScreens()`.

***

## 3. Displaying a presentation — the presentation builder

`fetchPresentation` / `fetchPresentationForPlacement` / `presentPresentation` / `presentPresentationForPlacement` / `presentPresentationWithIdentifier` are **removed with no alias**. v6 replaces them with a single request lifecycle: pick a source, chain options, `.build()` a request, then `.preload()` and/or `.display()` it.

```javascript
// Before (v5) — removed
Purchasely.presentPresentationForPlacement('ONBOARDING', null, true, onResult, onError);
```

```javascript
// After (v6)
const outcome = await Purchasely.presentation
    .placement('ONBOARDING')          // or .screen(id) / .defaultSource() / .default()
    .contentId('my_content_id')       // optional
    .backgroundColor('#000000')       // optional — the only style modifier wired on Cordova
    .onLoaded((presentation, error) => {})       // fires only on the preload() path — see below
    .onPresented((presentation, error) => {})
    .onCloseRequested(() => {})
    .onDismissed((outcome) => {})
    .build()
    .display(Purchasely.TransitionType.fullScreen); // or a transition object, or omit entirely

// outcome: { presentation, purchaseResult, plan, closeReason, error }
```

Entry points: `.placement(id)`, `.screen(id)`, `.defaultSource()` (canonical, cross-platform default presentation) and `.default()` (alias kept for iOS-name parity). The request returned by `.build()` exposes:

| Method | Returns | Notes |
|--------|---------|-------|
| `request.preload()` | `Promise<loadedPresentation>` | Fetches without displaying. The resolved object carries the presentation data **plus** `display()`, `close()`, `back()` methods that delegate back to the same request. |
| `request.display(transition?)` | `Promise<outcome>` | Displays (fetching first if not preloaded); resolves at **dismiss** with the 5-field outcome. |
| `request.close()` | — | Dismisses via `closeAllScreens()` — on Cordova this always closes **every** displayed presentation, not only this request. |
| `request.back()` | — | Navigates back within the displayed presentation (was the standalone `Purchasely.backPresentation()`). |

> 📘 `onLoaded` only fires on the `preload()` path
>
> `onLoaded(presentation, error)` fires once the screen has finished loading — but only when you called `preload()` first. A bare `display()` (no prior `preload()`) has no separate "loaded" event; it goes straight to `onPresented`. `onPresented` and `onCloseRequested` fire on **both** the direct `display()` path and the `preload()` → `display()` path.

### Transitions

`TransitionType`: `fullScreen`, `modal`, `drawer`, `popin`, `push`, `inlinePaywall`. `DimensionType`: `pixel`, `percentage` (`width` is popin-only; `height` drives drawer + popin).

```javascript
await Purchasely.presentation.placement('ONBOARDING').build().display({
    type: Purchasely.TransitionType.drawer,
    dismissible: true,
    height: { type: Purchasely.DimensionType.percentage, value: 0.8 }, // 0.0–1.0
    backgroundColor: '#000000'
});
```

A boolean is still accepted as a shorthand (`true` → `fullScreen`, `false` → `modal`). On **iOS** only a percentage `height` (plus `dismissible` / `backgroundColor`) is applied to drawer/popin; **Android** honors the full set.

> 🚧 Removed presentation methods
>
> `presentSubscriptions()`, `presentProductWithIdentifier()`, `presentPlanWithIdentifier()`, `showPresentation()` and `hidePresentation()` were **removed with no alias** — they no longer exist. Use the `presentation` builder for display, and `request.close()` / `request.back()` (or top-level `Purchasely.closeAllScreens()`) to control what's displayed. See [section 9](#9-removed-native-subscriptions-ui) for the subscriptions UI removal specifically.

***

## 4. The outcome — 5 fields, no legacy `result`

`display()` resolves with a single outcome object. Unlike some other Purchasely platforms, Cordova's outcome has **no legacy `result` field kept for compatibility** — the v5 `PurchaseResult` ordinal is gone entirely.

```javascript
const outcome = await Purchasely.presentation.placement('ONBOARDING').build().display();

// outcome: { presentation, purchaseResult, plan, closeReason, error }
if (outcome.error) {
    console.error(outcome.error.message);
} else if (outcome.purchaseResult === 'purchased' || outcome.purchaseResult === 'restored') {
    console.log('Purchased ' + (outcome.plan && outcome.plan.name));
} else if (outcome.purchaseResult === 'cancelled') {
    console.log('User cancelled');
} else if (outcome.closeReason === Purchasely.CloseReason.backSystem) {
    console.log('Dismissed by system back / interactive swipe');
}
```

| Field | Type | Description |
|-------|------|-------------|
| `presentation` | object \| `null` | The presentation that produced the outcome. `presentation.screenId` is the **authoritative** id. |
| `purchaseResult` | string \| `null` | `'purchased'` \| `'cancelled'` \| `'restored'` — **omitted** (`null`) when no purchase happened. |
| `plan` | object \| `null` | The purchased/restored plan, when applicable. |
| `closeReason` | string \| `null` | Compare against `Purchasely.CloseReason.button` / `.backSystem` / `.programmatic` — **do not hardcode the string**: `backSystem`'s wire value is `'back_system'` (snake_case). `null` when a purchase closed the screen. |
| `error` | object \| `null` | Populated when the presentation failed to load/display; mutually exclusive with `closeReason`. |

> 📘 iOS interactive dismiss
>
> An iOS swipe-to-dismiss / interactive pop maps to `Purchasely.CloseReason.backSystem`, same as the Android system back button/gesture. A close **after a successful purchase** omits `closeReason` entirely — check `purchaseResult` first.

***

## 5. Action interceptor — now per action

`Purchasely.setPaywallActionInterceptor(callback)` + `Purchasely.onProcessAction(bool)` were **removed**. v6 intercepts actions **per kind**: register one handler per action with `Purchasely.interceptAction(kind, handler)`. The handler receives `(info, parameters)` and returns — or resolves a `Promise` to — a `Purchasely.InterceptResult` instead of calling `onProcessAction(true/false)`. Action kinds are on `Purchasely.PresentationAction` (renamed from the v5 `PaywallAction` constant, and its **keys are now camelCase**).

```javascript
// Before (v5) — removed
Purchasely.setPaywallActionInterceptor((result) => {
    if (result.action === Purchasely.PaywallAction.login) {
        showLogin((userId) => { Purchasely.userLogin(userId, () => {}); Purchasely.onProcessAction(true); });
    } else {
        Purchasely.onProcessAction(true);
    }
});
```

```javascript
// After (v6) — one handler per kind, returns an InterceptResult
Purchasely.interceptAction(Purchasely.PresentationAction.login, (info, parameters) => {
    return new Promise((resolve) => {
        showLogin((userId) => {
            Purchasely.userLogin(userId, () => {});
            resolve(Purchasely.InterceptResult.success);   // the app fully handled login
        });
    });
});

Purchasely.interceptAction(Purchasely.PresentationAction.navigate, (info, parameters) => {
    if (parameters && parameters.url) {
        window.open(parameters.url, '_system');
    }
    return Purchasely.InterceptResult.notHandled;          // let the SDK proceed too
});

Purchasely.interceptAction(Purchasely.PresentationAction.purchase, (info, parameters) => {
    return Purchasely.InterceptResult.notHandled;          // let the SDK run the purchase
});

// Cleanup
Purchasely.removeActionInterceptor(Purchasely.PresentationAction.purchase);
Purchasely.removeAllActionInterceptors();
```

### Result semantics

| `InterceptResult` | Meaning | SDK behavior |
|-------------------|---------|--------------|
| `success` | App handled the action successfully | Chain advances |
| `failed` | App tried but failed | Remaining actions are skipped |
| `notHandled` | App doesn't want to handle this | SDK executes the action itself |

`onProcessAction(false)` → `Purchasely.InterceptResult.success`; `onProcessAction(true)` → `Purchasely.InterceptResult.notHandled`.

### Action kinds (all 10)

`Purchasely.PresentationAction`: `close`, `closeAll`, `login`, `navigate`, `purchase`, `restore`, `openPresentation`, `openPlacement`, `promoCode`, `webCheckout`.

> 📘 Keys are camelCase, wire values stay snake_case
>
> The v5 `PaywallAction` constant used snake_case keys (`close_all`, `open_presentation`, …). v6's `PresentationAction` keys are **camelCase** (parity with RN/Flutter) — e.g. `Purchasely.PresentationAction.closeAll`, `.openPresentation`, `.promoCode`, `.webCheckout`. The strings the native bridges emit on the wire are unchanged (still snake_case internally) — always reference the constant, never hardcode the raw string.

Handlers may return a value or a `Promise` — async work (e.g. showing your own login screen) is supported; registering the same kind again replaces its handler, and each intercept resolves independently.

> 📘 Observer-mode purchase flow
>
> In `observer` mode, intercept `purchase` / `restore`, run your own billing flow, then return `Purchasely.InterceptResult.success` and dismiss the screen with `Purchasely.closeAllScreens()` (Observer mode does not auto-close). The SDK synchronizes the transaction automatically on a success result — you can also call `Purchasely.synchronize(success, error)` explicitly if you need to sequence a subscriber-targeted follow-up.

***

## 6. Deeplinks & campaigns

```javascript
// Before (v5)
Purchasely.readyToOpenDeeplink(true);
Purchasely.isDeeplinkHandled(url, onHandled, onError);

// After (v6)
Purchasely.allowDeeplink(true);
Purchasely.handleDeeplink(url, onHandled, onError);
Purchasely.allowCampaigns(true);   // new — allow/defer campaign deeplinks independently
```

The old `readyToOpenDeeplink` / `isDeeplinkHandled` names were **removed** (renamed, not aliased). Deeplinks and campaigns now display **immediately by default** — call `Purchasely.allowDeeplink(false)` / `Purchasely.allowCampaigns(false)` during a splash/onboarding/login routine and flip them back to `true` when ready. Both are independent flags and can also be passed in the `start(...)` options object or the builder (`allowDeeplink` / `allowCampaigns`).

***

## 7. `setDefaultPresentationResultHandler` → `setDefaultPresentationDismissHandler`

The global handler for presentations the app did **not** open itself (campaigns, deeplinks, Promoted In-App Purchases) was renamed and now delivers the same rich 5-field outcome as `display()`. Stop receiving these with `Purchasely.removeDefaultPresentationDismissHandler()`.

```javascript
// Before (v5)
Purchasely.setDefaultPresentationResultHandler((result) => {
    console.log(result.result, result.plan);
});

// After (v6)
Purchasely.setDefaultPresentationDismissHandler((outcome) => {
    // `presentation` identifies which campaign/deeplink closed
    console.log(outcome.presentation && outcome.presentation.screenId);
    console.log(outcome.purchaseResult, outcome.closeReason);
    if (outcome.purchaseResult === 'purchased' || outcome.purchaseResult === 'restored') {
        console.log('Purchased ' + (outcome.plan && outcome.plan.vendorId));
    }
}, (error) => console.error(error));
```

There is **no legacy `result` field** on this outcome either — read `purchaseResult` (string) and `closeReason` (compare against `Purchasely.CloseReason.*`, not a hardcoded string).

***

## 8. `synchronize` now reports completion

```javascript
// Before (v5): fire-and-forget, no callbacks
Purchasely.synchronize();

// After (v6): optional success / error callbacks, resolved when the native
// synchronize finishes.
Purchasely.synchronize(
    () => console.log('Purchasely synchronized'),
    (error) => console.error('Sync failed', error)
);
```

Calling `Purchasely.synchronize()` with no arguments still works (the callbacks are optional).

***

## 9. Removed: native subscriptions UI

The native subscriptions-list UI was removed from both SDKs in v6, so `Purchasely.presentSubscriptions()` was **removed entirely** from the JavaScript surface — it is no longer a no-op; the method no longer exists. Build your own management screen from the data APIs that remain:

```javascript
Purchasely.userSubscriptions((subscriptions) => { /* active subscriptions */ },
    (error) => console.error(error));
Purchasely.userSubscriptionsHistory((history) => { /* expired subscriptions */ },
    (error) => console.error(error));
```

***

## 10. Other v6 changes worth knowing

These are additive or low-impact, but worth a pass while you're migrating:

* **`closeAllScreens`** is now the canonical name; `closePresentation()` is kept as a **deprecated alias** (same behavior).
* **`addEventListener` / `removeEventListener`** are now the canonical names (RN parity); `addEventsListener` / `removeEventsListener` (the original Cordova spelling) are kept as **deprecated aliases**.
* **`userLogout(clearUserAttributes)`** takes a new optional boolean (default `true`) controlling whether logout also clears locally cached custom user attributes.
* **`userSubscriptions(success, error, invalidateCache)`** and **`userSubscriptionsHistory(success, error, invalidateCache)`** gained a third `invalidateCache` parameter to force a fresh network fetch instead of a cached list.
* New read accessors: **`getBuiltInAttribute(key, success, error)`** / **`getBuiltInAttributes(success, error)`**, **`isAnonymous(success, error)`**, **`userAttributes(success, error)`** (bulk read of every custom attribute).
* **`incrementUserAttribute(key, value)`** / **`decrementUserAttribute(key, value)`** default `value` to `1` when omitted.
* **`signPromotionalOffer`** is iOS-only; on **Android it is a no-op** that resolves with no signature (no signing is required there).
* **`Purchasely.Attribute`** gained `ONESIGNAL_USER_ID`.
* **`Purchasely.PresentationType`**: `normal` (0, the requested Screen), `fallback` (1, a Screen but not the one requested), `deactivated` (2, no paywall configured for this placement — e.g. an inactive A/B test or audience), `client` (3, Build-Your-Own-Screen — use the plan list to build your own UI).
* **Apple commitment** (iOS 26.4+, Apple only): `Purchasely.BillingPlanType` (`unspecified: 0`, `upFront: 1`, `monthly: 2`) is now the 4th argument of `setDynamicOffering(reference, planVendorId, offerVendorId, billingPlanType, success, error)`. A `plan` may carry a `commitmentInfo` array, and a `subscription` may carry `commitmentProgress` — both absent on Android and on non-commitment plans.
* Newly exported constants: `LogLevel`, `RunningMode`, `Attribute`, `PurchaseResult`, `PlanType`, `SubscriptionSource`, `InterceptResult`, `PresentationType`, `CloseReason`, `TransitionType`, `DimensionType`, `Store`, `StorekitVersion`, `PresentationAction`, `BillingPlanType`, `ThemeMode`, `DataProcessingLegalBasis`, `DataProcessingPurpose`.

***

## 11. Cordova-specific gaps vs RN/Flutter (deferred to v6.1)

A few builder-parity features that ship on React Native and/or Flutter are **not yet wired on Cordova**. These are deliberate, tracked deferrals (Linear project *"Cordova — parité & compléments v6.1"*), not oversights in this guide:

* **Inline `PLYPresentationView`** — not available on Cordova. There is no declarative native view through a WebView plugin the way RN/Flutter expose one.
* **Style modifiers `.progressColor()` / `.displayCloseButton()` / `.displayBackButton()`** — not wired on the Cordova presentation builder. Only `.backgroundColor()` is.
* **`automaticDeeplinkHandling`** (an Android-only `start()` option on other platforms) — not exposed on Cordova.
* **BYOS `clientPresentationDisplayed` / `clientPresentationClosed`** — not available on Cordova.
* **Event transport** — Cordova uses `cordova.exec` keep-alive callbacks rather than a `NativeEventEmitter`; the event/outcome payload *shapes* match RN/Flutter, only the transport differs.

***

## What stays the same

Every other `Purchasely.*` method keeps its v5 name and signature, except the renames called out above:

* **Purchases / restore**: `purchaseWithPlanVendorId`, `signPromotionalOffer`, `restoreAllProducts`, `silentRestoreAllProducts`, `userDidConsumeSubscriptionContent`.
* **Identity**: `userLogin`, `userLogout` (gained an optional param — see [section 10](#10-other-v6-changes-worth-knowing)), `getAnonymousUserId`.
* **Catalog**: `allProducts`, `productWithIdentifier`, `planWithIdentifier`, `isEligibleForIntroOffer`, `setDynamicOffering`, `getDynamicOfferings`, `removeDynamicOffering`, `clearDynamicOfferings`.
* **Subscriptions data**: `userSubscriptions`, `userSubscriptionsHistory` (both gained an `invalidateCache` param).
* **User attributes**: every `setUserAttributeWith*`, `userAttribute`, `clearUserAttribute`, `clearUserAttributes`, `clearBuiltInAttributes`, `setAttribute`.
* **Config / misc**: `setLanguage`, `setThemeMode`, `setLogLevel`, `setDebugMode`, `revokeDataProcessingConsent`.

***

## Migration checklist

### Breaking (must fix)

* [ ] Pin `@purchasely/cordova-plugin-purchasely` and `@purchasely/cordova-plugin-purchasely-google` to `6.0.0`
* [ ] Replace the positional `Purchasely.start(apiKey, stores, …)` with the options-object or `Purchasely.builder(apiKey)` form
* [ ] Replace `Purchasely.RunningMode.paywallObserver` with `Purchasely.RunningMode.observer`; add `runningMode: Purchasely.RunningMode.full` if you rely on Full mode (default changed to Observer)
* [ ] Replace `fetchPresentation*` / `presentPresentation*` flat calls with `Purchasely.presentation.placement(id)/.screen(id)/.defaultSource()` → `.build()` → `.preload()` / `.display(transition)`
* [ ] Remove `presentSubscriptions()` / `presentProductWithIdentifier()` / `presentPlanWithIdentifier()` / `showPresentation()` / `hidePresentation()` — build your own UI from `userSubscriptions()` / `userSubscriptionsHistory()` and the presentation builder
* [ ] Stop reading `outcome.result` — read `outcome.purchaseResult` (string) instead; there is no legacy field
* [ ] Replace `setPaywallActionInterceptor` + `onProcessAction` with per-action `Purchasely.interceptAction(kind, handler)` returning a `Purchasely.InterceptResult`; rename `Purchasely.PaywallAction` → `Purchasely.PresentationAction` (now camelCase keys)
* [ ] Rename `readyToOpenDeeplink` → `allowDeeplink`, `isDeeplinkHandled` → `handleDeeplink`
* [ ] Rename `setDefaultPresentationResultHandler` → `setDefaultPresentationDismissHandler`

### Verify

1. `Purchasely.builder(...).start()` (or `Purchasely.start(options, …)`) fires its success callback / resolves (no error).
2. A placement-based presentation displays (`Purchasely.presentation.placement(id).build().display()`) and resolves the 5-field outcome.
3. Each `interceptAction` handler returns (or resolves to) a `Purchasely.InterceptResult` on every path.
4. Deeplinks use `allowDeeplink` / `handleDeeplink` and the dismiss handler uses `setDefaultPresentationDismissHandler`.
5. If you use Full mode, `Purchasely.RunningMode.full` is passed — purchases validate and screens auto-close after purchase.

<br />
