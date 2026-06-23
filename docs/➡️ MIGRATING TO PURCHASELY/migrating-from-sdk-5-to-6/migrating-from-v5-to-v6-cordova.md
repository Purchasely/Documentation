---
title: Migrating to v6 — Cordova
excerpt: >-
  Breaking changes and migration steps to upgrade the Purchasely Cordova SDK
  from v5.x to v6.0.0-rc.1
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

> 📘 Cordova keeps the same method-based JavaScript API
>
> Unlike the native iOS/Android and the React Native / Flutter SDKs, the Cordova plugin **does not introduce a new builder API**. The native bridges were rewired to the v6 SDKs behind the existing `cordova.exec` actions, so the JavaScript surface stays method-based and almost unchanged. This guide lists the **only** JS-visible changes a host app must apply.

***

## Summary of breaking changes

| v5                                              | v6                                                          |
| ----------------------------------------------- | ---------------------------------------------------------- |
| Default running mode `Full`                     | Default running mode `Observer` ⚠️                         |
| `Purchasely.RunningMode.paywallObserver`        | `Purchasely.RunningMode.observer`                          |
| `Purchasely.readyToOpenDeeplink(bool)`          | `Purchasely.allowDeeplink(bool)`                           |
| `Purchasely.isDeeplinkHandled(url, s, e)`       | `Purchasely.handleDeeplink(url, s, e)`                     |
| `Purchasely.synchronize()` (fire-and-forget)    | `Purchasely.synchronize(success, error)` (reports completion) |
| `Purchasely.setDefaultPresentationResultHandler(cb)` | `Purchasely.setDefaultPresentationDismissHandler(cb)` (rich outcome) |
| `Purchasely.presentSubscriptions()`             | **no-op** (native subscriptions UI removed)                |

> 📘 Everything else is unchanged — `start`, `fetchPresentation` / `fetchPresentationForPlacement`, `presentPresentation`, `presentPresentationForPlacement`, `setPaywallActionInterceptor` + `onProcessAction`, `userLogin` / `userLogout`, `allProducts`, `purchaseWithPlanVendorId`, `restoreAllProducts`, `userSubscriptions(History)`, every `setUserAttributeWith*`, `setThemeMode`, `revokeDataProcessingConsent`, … keep the **same name and signature**.

> There is **no v5 source-compatibility shim**: the renamed methods above were renamed, not aliased.

***

## 1. Update the plugins

Both Cordova plugins must be pinned to the **same** version:

```shell
cordova plugin add @purchasely/cordova-plugin-purchasely@6.0.0-rc.1
cordova plugin add @purchasely/cordova-plugin-purchasely-google@6.0.0-rc.1
```

This pulls the native SDKs:

| Platform | Native artifact |
|----------|-----------------|
| iOS | `pod 'Purchasely', '6.0.0-rc.1'` (CocoaPods) |
| Android | `io.purchasely:core:6.0.0-rc.1` + `io.purchasely:google-play:6.0.0-rc.1` (Maven Central) |

> ⚠️ Every `io.purchasely:*` dependency must resolve to the same pre-release. A stray `6.0.0` (release) ranks *above* `6.0.0-rc.1` in Gradle and silently upgrades `core`, producing a `NoSuchMethodError` at runtime.

Minimum OS versions for v6: **iOS 13.4**, **Android API 23** (`compileSdk 36`). There is **no video player plugin on Cordova** (`io.purchasely:player` is not bridged).

***

## 2. Running mode — default is now Observer

In v6 the **native default running mode changed from Full to Observer**. The Cordova `start` call always passes a running mode explicitly, so this is mostly transparent — but make sure you pass `full` if Purchasely must own the purchase flow, and use the renamed `observer` constant:

```javascript
// Before (v5)
Purchasely.start('API_KEY', ['Google'], false, null,
    Purchasely.LogLevel.DEBUG, Purchasely.RunningMode.paywallObserver, // removed
    onConfigured, onError);

// After (v6)
Purchasely.start('API_KEY', ['Google'], false, null,
    Purchasely.LogLevel.DEBUG,
    Purchasely.RunningMode.full,   // .observer | .full  (was .paywallObserver | .full)
    (isConfigured) => {},
    (error) => console.error(error));
```

`Purchasely.RunningMode.paywallObserver` was **removed** — use `Purchasely.RunningMode.observer` (same value `2`).

> 🚧 Behavioral consequence — automatic screen close
>
> In Observer mode, presentations **no longer auto-close** after a purchase or restore. If your app relied on auto-close, pass `Purchasely.RunningMode.full`, or close the screen yourself with `Purchasely.closePresentation()`.

***

## 3. Deeplinks renamed

```javascript
// Before (v5)
Purchasely.readyToOpenDeeplink(true);
Purchasely.isDeeplinkHandled(url, onHandled, onError);

// After (v6)
Purchasely.allowDeeplink(true);
Purchasely.handleDeeplink(url, onHandled, onError);
```

`allowDeeplink` maps to native `allowDeeplink(_:)` and `handleDeeplink` to native `handleDeeplink(_:)` / `handleDeeplink(uri, activity)`. Deeplinks now display **immediately by default** — call `Purchasely.allowDeeplink(false)` during a splash/onboarding/login routine and flip it back to `true` when ready.

***

## 4. `setDefaultPresentationResultHandler` → `setDefaultPresentationDismissHandler`

The global handler for presentations the app did **not** open itself (campaigns, deeplinks, Promoted In-App Purchases) was renamed and now delivers a single rich outcome object:

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

The legacy `result` (PurchaseResult code) and `plan` fields are **kept** for source compatibility; the v6 fields `purchaseResult` (string), `closeReason`, and `presentation` are added.

***

## 5. `synchronize` now reports completion

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

## 6. `presentSubscriptions` is a no-op

The native subscriptions-list UI was removed from both SDKs in v6. `Purchasely.presentSubscriptions()` now logs a warning and does nothing. Build your own management screen from `Purchasely.userSubscriptions(...)` / `Purchasely.userSubscriptionsHistory(...)`.

***

## 7. Observer-mode purchase flow (unchanged JS pattern)

The action interceptor API (`setPaywallActionInterceptor` + `onProcessAction`) is unchanged. In Observer mode, run your own billing, synchronize, then close the screen:

```javascript
Purchasely.setPaywallActionInterceptor((result) => {
    if (result.action === Purchasely.PaywallAction.purchase) {
        // run your own billing flow, then:
        Purchasely.synchronize();          // upload the receipt to Purchasely
        Purchasely.onProcessAction(false); // you handled the purchase
        Purchasely.closePresentation();    // Observer mode does not auto-close
    } else {
        Purchasely.onProcessAction(true);  // let Purchasely proceed
    }
});
```

***

## 8. Verification checklist

After upgrading, build and run the example app and verify:

1. `Purchasely.start(...)` fires its success callback (no error).
2. A placement-based presentation displays (`presentPresentationForPlacement`).
3. The action interceptor resolves every action with `onProcessAction(true|false)`.
4. Deeplinks use `allowDeeplink` / `handleDeeplink` and the dismiss handler uses `setDefaultPresentationDismissHandler`.
5. If you use Full mode, `Purchasely.RunningMode.full` is passed — purchases validate and screens auto-close after purchase.

<br />
