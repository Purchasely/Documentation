---
title: Migrating to v6 — Cordova
excerpt: >-
  Breaking changes and migration steps to upgrade the Purchasely Cordova SDK
  from v5.x to v6.0.0-rc.2
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
This guide covers the **Cordova** plugin (JavaScript). For other platforms, see the [iOS guide](migrating-from-v5-to-v6-ios) or the [Android guide](migrating-from-v5-to-v6-android).

> 📘 Cordova keeps a method-based JavaScript API
>
> Unlike the native iOS/Android and the Flutter SDKs, the Cordova plugin **does not introduce a builder API**. The native bridges were rewired to the v6 SDKs behind the existing `cordova.exec` actions, so most of the JavaScript surface keeps the same method names and signatures. But **three surfaces are breaking**: `start()` now takes a single **options object**, the **action interceptor** is now **per-action**, and the presentation **`isFullscreen` boolean became a display mode**. This guide lists every JS-visible change a host app must apply.

***

## Summary of breaking changes

| v5                                                   | v6                                                                                     |
| ---------------------------------------------------- | -------------------------------------------------------------------------------------- |
| `Purchasely.start(apiKey, stores, …)` (positional)   | `Purchasely.start(options, success, error)` — single **options object** ⚠️            |
| Default running mode `Full`                          | Default running mode `Observer` ⚠️                                                    |
| `Purchasely.RunningMode.paywallObserver` / `.transactionOnly` | **removed** — use `Purchasely.RunningMode.observer` (values are now name strings) |
| `setPaywallActionInterceptor(cb)` + `onProcessAction(bool)` | per-action `Purchasely.interceptAction(kind, handler)` returning an `InterceptResult` ⚠️ |
| `Purchasely.PaywallAction`                           | `Purchasely.PresentationAction` (renamed; same string values)                          |
| `isFullscreen` boolean on `present*`                 | **display mode** — a `TransitionType` string, a boolean, or a transition object        |
| `Purchasely.presentSubscriptions()`                  | **removed** (native subscriptions UI removed)                                          |
| `presentProductWithIdentifier()` / `presentPlanWithIdentifier()` / `showPresentation()` / `hidePresentation()` | **removed** |
| `Purchasely.readyToOpenDeeplink(bool)`               | `Purchasely.allowDeeplink(bool)` (+ new `Purchasely.allowCampaigns(bool)`)             |
| `Purchasely.isDeeplinkHandled(url, s, e)`            | `Purchasely.handleDeeplink(url, s, e)`                                                 |
| `Purchasely.synchronize()` (fire-and-forget)         | `Purchasely.synchronize(success, error)` (reports completion)                          |
| `Purchasely.setDefaultPresentationResultHandler(cb)` | `Purchasely.setDefaultPresentationDismissHandler(cb)` (rich outcome)                   |

> There is **no v5 source-compatibility shim**: the renamed methods above were renamed, not aliased, and the removed ones no longer resolve.

***

## 1. Update the plugins

Both Cordova plugins must be pinned to the **same** version:

```shell
cordova plugin add @purchasely/cordova-plugin-purchasely@6.0.0-rc.2
cordova plugin add @purchasely/cordova-plugin-purchasely-google@6.0.0-rc.2
```

This pulls the native SDKs:

| Platform | Native artifact |
|----------|-----------------|
| iOS | `pod 'Purchasely', '6.0.0-rc.2'` (CocoaPods) |
| Android | `io.purchasely:core:6.0.0-rc.2` + `io.purchasely:google-play:6.0.0-rc.2` (Maven Central) |

> ⚠️ Every `io.purchasely:*` dependency must resolve to the same pre-release. A stray `6.0.0` (release) ranks *above* `6.0.0-rc.2` in Gradle and silently upgrades `core`, producing a `NoSuchMethodError` at runtime.

Minimum OS versions for v6: **iOS 13.4**, **Android API 23** (`compileSdk 36`). There is **no video player plugin on Cordova** (`io.purchasely:player` is not bridged).

***

## 2. `start()` now takes an options object

The v5 positional argument list is replaced by a **single configuration object**, followed by the `success` / `error` callbacks. Only `apiKey` is required.

```javascript
// Before (v5) — positional
Purchasely.start('API_KEY', ['Google'], false, null,
    Purchasely.LogLevel.DEBUG, Purchasely.RunningMode.paywallObserver, // removed
    onConfigured, onError);

// After (v6) — options object
Purchasely.start(
    {
        apiKey: 'API_KEY',
        stores: [Purchasely.Store.google],        // Store.google | Store.huawei | Store.amazon
        storeKit1: false,                          // iOS only
        appUserId: null,
        logLevel: Purchasely.LogLevel.DEBUG,
        runningMode: Purchasely.RunningMode.full,  // .observer (default) | .full — set .full to handle purchases
        allowDeeplink: true,                       // optional
        allowCampaigns: true,                      // optional
    },
    (isConfigured) => {},
    (error) => console.error(error)
);
```

Recognised options: `apiKey` (required), `appUserId`, `logLevel`, `runningMode`, `stores`, `storeKit1` / `storekitVersion` (iOS), `allowDeeplink`, `allowCampaigns`, `deeplink` (cold-start URL).

### Running mode — default is now Observer

In v6 the **native default running mode changed from Full to Observer**, and `RunningMode` values are now **name strings** (`'observer'` / `'full'`) — the native iOS and Android enums use different raw values, so the bridge maps by name. `Purchasely.RunningMode.paywallObserver` and `transactionOnly` were **removed** — use `Purchasely.RunningMode.observer`. Pass `runningMode: Purchasely.RunningMode.full` if Purchasely must own the purchase flow and validate receipts.

> 🚧 Behavioral consequence — automatic screen close
>
> In Observer mode, presentations **no longer auto-close** after a purchase or restore. If your app relied on auto-close, pass `Purchasely.RunningMode.full`, or close the screen yourself with `Purchasely.closePresentation()`.

***

## 3. Displaying a presentation — display mode replaces `isFullscreen`

`fetchPresentation` / `fetchPresentationForPlacement` / `presentPresentation` / `presentPresentationForPlacement` / `presentPresentationWithIdentifier` keep their names, but the `isFullscreen` **boolean** argument on the `present*` methods became a **display mode**. Pass a `Purchasely.TransitionType` string, a boolean (still accepted: `true` → `fullScreen`, `false` → `modal`), or a full transition object for drawer/popin sizing.

```javascript
// Before (v5)
Purchasely.presentPresentationForPlacement('ONBOARDING', null, true, onResult, onError);

// After (v6) — display-mode string
Purchasely.presentPresentationForPlacement('ONBOARDING', null,
    Purchasely.TransitionType.fullScreen, onResult, onError);

// After (v6) — transition object (drawer/popin sizing)
Purchasely.presentPresentationForPlacement('ONBOARDING', null, {
    type: Purchasely.TransitionType.drawer,
    dismissible: true,
    height: { type: Purchasely.DimensionType.percentage, value: 0.8 }, // 0.0–1.0
    backgroundColor: '#000000'
}, onResult, onError);
```

`TransitionType`: `fullScreen`, `modal`, `drawer`, `popin`, `push`, `inlinePaywall`. `DimensionType`: `pixel`, `percentage` (`width` is popin-only; `height` drives drawer + popin). On **iOS** only a percentage `height` (plus `dismissible` / `backgroundColor`) is applied to drawer/popin; **Android** honors the full set.

The `present*` methods also accept an optional final `callbacks` object — `{ onPresented(presentation, error), onCloseRequested() }` — to observe the presentation lifecycle; `success` still receives the final dismiss outcome. New in v6: `presentPresentationForDefault(...)` / `fetchPresentationForDefault(...)` (the audience-targeted default presentation, no placement id) and `backPresentation()` to navigate back within a displayed presentation.

> 🚧 Removed present methods
>
> `presentProductWithIdentifier()`, `presentPlanWithIdentifier()`, `showPresentation()` and `hidePresentation()` were **removed**. Use placement/screen-based presentation, and `closePresentation()` / `backPresentation()` to control the displayed presentation. `presentSubscriptions()` was also removed — see section 8.

***

## 4. Action interceptor — now per-action

`Purchasely.setPaywallActionInterceptor(callback)` + `Purchasely.onProcessAction(bool)` were **removed**. v6 intercepts actions **per kind**: register one handler per action with `Purchasely.interceptAction(kind, handler)`. The handler receives `(info, parameters)` and returns — or resolves a `Promise` to — a `Purchasely.InterceptResult` instead of calling `onProcessAction(true/false)`. Action kinds are on `Purchasely.PresentationAction` (the v5 `PaywallAction` constant was renamed).

```javascript
// Before (v5)
Purchasely.setPaywallActionInterceptor((result) => {
    if (result.action === Purchasely.PaywallAction.login) {
        showLogin((userId) => { Purchasely.userLogin(userId, () => {}); Purchasely.onProcessAction(true); });
    } else {
        Purchasely.onProcessAction(true);
    }
});

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

`onProcessAction(false)` → `Purchasely.InterceptResult.success`, `onProcessAction(true)` → `Purchasely.InterceptResult.notHandled`.

### Action kinds

`Purchasely.PresentationAction`: `close`, `close_all`, `login`, `navigate`, `purchase`, `restore`, `open_presentation`, `open_placement`, `promo_code`, `web_checkout`. Handlers may return a value or a `Promise` — async work (e.g. showing your own login screen) is supported; registering the same kind again replaces its handler, and each intercept resolves independently.

> 📘 Observer-mode purchase flow
>
> In `observer` mode, intercept `purchase` / `restore`, run your own billing flow, then return `Purchasely.InterceptResult.success` and dismiss the screen with `Purchasely.closePresentation()` (Observer mode does not auto-close). The SDK synchronizes the transaction automatically on a success result — you can also call `Purchasely.synchronize(success, error)` explicitly if you need to sequence a subscriber-targeted follow-up.

***

## 5. Deeplinks & campaigns

```javascript
// Before (v5)
Purchasely.readyToOpenDeeplink(true);
Purchasely.isDeeplinkHandled(url, onHandled, onError);

// After (v6)
Purchasely.allowDeeplink(true);
Purchasely.handleDeeplink(url, onHandled, onError);
Purchasely.allowCampaigns(true);   // new — allow/defer campaign deeplinks independently
```

The old `readyToOpenDeeplink` / `isDeeplinkHandled` names were **removed** (renamed, not aliased). Deeplinks and campaigns now display **immediately by default** — call `Purchasely.allowDeeplink(false)` / `Purchasely.allowCampaigns(false)` during a splash/onboarding/login routine and flip them back to `true` when ready. Both are independent flags and can also be passed in the `start(...)` options object (`allowDeeplink` / `allowCampaigns`).

***

## 6. `setDefaultPresentationResultHandler` → `setDefaultPresentationDismissHandler`

The global handler for presentations the app did **not** open itself (campaigns, deeplinks, Promoted In-App Purchases) was renamed and now delivers a single rich outcome object. Stop receiving these with `Purchasely.removeDefaultPresentationDismissHandler()`.

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
    if (outcome.result == Purchasely.PurchaseResult.PURCHASED) {
        console.log('Purchased ' + outcome.plan.vendorId);
    }
}, (error) => console.error(error));
```

The legacy `result` (PurchaseResult code) and `plan` fields are **kept** for source compatibility; the v6 fields `purchaseResult` (string), `closeReason` (`button` / `back_system` / `programmatic`), and `presentation` are added.

***

## 7. `synchronize` now reports completion

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

## 8. Removed: native subscriptions UI

The native subscriptions-list UI was removed from both SDKs in v6, so `Purchasely.presentSubscriptions()` was **removed entirely** from the JavaScript surface — it is no longer a no-op; the method no longer exists. Build your own management screen from the data APIs that remain:

```javascript
Purchasely.userSubscriptions((subscriptions) => { /* active subscriptions */ },
    (error) => console.error(error));
Purchasely.userSubscriptionsHistory((history) => { /* expired subscriptions */ },
    (error) => console.error(error));
```

***

## What stays the same

Only the **paywall surface** (start, presentation display mode, the action interceptor) has breaking API changes. Every other `Purchasely.*` method keeps its v5 name and signature, except the deeplink renames:

* **Presentation**: `fetchPresentation` / `fetchPresentationForPlacement`, `presentPresentation` / `presentPresentationForPlacement` / `presentPresentationWithIdentifier` (only their `isFullscreen` argument became a display mode — see section 3), `closePresentation`.
* **Purchases / restore**: `purchaseWithPlanVendorId`, `signPromotionalOffer`, `restoreAllProducts`, `silentRestoreAllProducts`, `userDidConsumeSubscriptionContent`.
* **Identity**: `userLogin`, `userLogout`, `getAnonymousUserId`.
* **Catalog**: `allProducts`, `productWithIdentifier`, `planWithIdentifier`, `isEligibleForIntroOffer`.
* **Subscriptions data**: `userSubscriptions`, `userSubscriptionsHistory`.
* **User attributes**: every `setUserAttributeWith*`, `userAttribute`, `clearUserAttribute`, `clearUserAttributes`, `setAttribute`.
* **Events**: `addEventsListener` / `removeEventsListener`, `addUserAttributeListener` / `removeUserAttributeListener`.
* **Config / misc**: `setLanguage`, `setThemeMode`, `setLogLevel`, `setDebugMode`, `revokeDataProcessingConsent`.

***

## Migration checklist

### Breaking (must fix)

* [ ] Pin `@purchasely/cordova-plugin-purchasely` and `@purchasely/cordova-plugin-purchasely-google` to `6.0.0-rc.2`
* [ ] Replace the positional `Purchasely.start(apiKey, stores, …)` with the options-object form `Purchasely.start({ apiKey, … }, success, error)`
* [ ] Replace `Purchasely.RunningMode.paywallObserver` with `Purchasely.RunningMode.observer`; add `runningMode: Purchasely.RunningMode.full` if you rely on Full mode (default changed to Observer)
* [ ] Replace the `isFullscreen` boolean on `present*` with a `Purchasely.TransitionType` (or a transition object)
* [ ] Replace `setPaywallActionInterceptor` + `onProcessAction` with per-action `Purchasely.interceptAction(kind, handler)` returning a `Purchasely.InterceptResult`; rename `Purchasely.PaywallAction` → `Purchasely.PresentationAction`
* [ ] Remove `presentSubscriptions()` / `presentProductWithIdentifier()` / `presentPlanWithIdentifier()` / `showPresentation()` / `hidePresentation()` — build your own UI from `userSubscriptions()` / `userSubscriptionsHistory()` and placement/screen presentation
* [ ] Rename `readyToOpenDeeplink` → `allowDeeplink`, `isDeeplinkHandled` → `handleDeeplink`
* [ ] Rename `setDefaultPresentationResultHandler` → `setDefaultPresentationDismissHandler`

### Verify

1. `Purchasely.start(...)` fires its success callback (no error).
2. A placement-based presentation displays (`presentPresentationForPlacement`) with the new display-mode argument.
3. Each `interceptAction` handler returns (or resolves to) a `Purchasely.InterceptResult` on every path.
4. Deeplinks use `allowDeeplink` / `handleDeeplink` and the dismiss handler uses `setDefaultPresentationDismissHandler`.
5. If you use Full mode, `Purchasely.RunningMode.full` is passed — purchases validate and screens auto-close after purchase.

<br />
