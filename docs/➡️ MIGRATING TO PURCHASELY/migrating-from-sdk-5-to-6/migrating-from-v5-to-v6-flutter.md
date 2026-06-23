---
title: Migrating to v6 — Flutter
excerpt: Migration guide for the Purchasely Flutter SDK from v5.x to v6.0
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
This guide covers the **Flutter SDK** (Dart). For the native layers this plugin bridges to, see the [iOS guide](migrating-from-v5-to-v6-ios) or the [Android guide](migrating-from-v5-to-v6-android), or the platform pages listed on the [migration overview](migrating-from-sdk-5-to-6).

Version 6.0.0-rc.1 adapts the Flutter plugin to the Purchasely 6.0 native SDKs (iOS `Purchasely 6.0.0-rc.1`, Android `io.purchasely:core 6.0.0-rc.1`). The paywall surface — starting the SDK, displaying / preloading / closing a presentation, and the action interceptor — moves to a fluent builder API. Everything else on the `Purchasely` class (purchases, restore, identity, catalog, subscriptions, user attributes, events, dynamic offerings, consent and config) remains source‑compatible.

> 📘 No "v6" naming in the Dart API
>
> Unlike some other wrappers, the public Dart symbols keep their **plain names** (`PurchaselyBuilder`, `PresentationBuilder`, `PresentationOutcome`, `Transition`, …). A paywall is now called a **Presentation** (or *Screen*).

***

## Summary of breaking changes

| v5 | v6 |
|----|----|
| Default running mode `PLYRunningMode.full` | Default running mode **`RunningMode.observer`** ⚠️ |
| `Purchasely.start(apiKey:…)` | `PurchaselyBuilder.apiKey('…')…start()` (fluent builder) |
| `PLYRunningMode` / `PLYLogLevel` | `RunningMode` / `LogLevel` |
| `Purchasely.fetchPresentation(...)` | `PresentationBuilder.…build().preload()` |
| `Purchasely.presentPresentationForPlacement(...)` | `PresentationBuilder.placement(id).build().display([Transition])` |
| `Purchasely.presentPresentationWithIdentifier(...)` | `PresentationBuilder.screen(id).build().display([Transition])` |
| `Purchasely.presentPresentation(presentation)` | `request.preload()` then `request.display()` |
| `Purchasely.closePresentation()` / `hidePresentation()` | `presentation.close()` |
| `Purchasely.showPresentation()` | `presentation.display()` |
| `Purchasely.getPresentationView(...)` | `PLYPresentationView(request: …)` widget |
| `PLYPurchaseResult` (display result) | `PresentationOutcome` (5 fields) |
| `setPaywallActionInterceptorCallback` + `onProcessAction(bool)` | `Purchasely.interceptAction(kind, handler)` returning `InterceptResult` |
| `setDefaultPresentationResultHandler(cb)` | `Purchasely.setDefaultPresentationDismissHandler(cb)` |
| `readyToOpenDeeplink(_)` | `allowDeeplink(_)` (old name kept as deprecated alias) |
| `isDeeplinkHandled(_)` | `handleDeeplink(_)` (old name kept as deprecated alias) |
| `presentSubscriptions()` | **removed** — build your own from `userSubscriptions()` |

> 📘 Three areas are breaking: **starting the SDK**, **displaying / preloading / closing a presentation**, and the **action interceptor**. Everything not in the table above keeps source‑compatible `Purchasely.*` signatures — see [What's unchanged](#what-stays-the-same).

***

## 1. Update dependencies

Pin all Purchasely packages to the **exact same** version. Mismatched versions cause runtime errors.

```yaml
dependencies:
  purchasely_flutter: 6.0.0-rc.1
  purchasely_google: 6.0.0-rc.1          # required if you distribute on Google Play
  purchasely_android_player: 6.0.0-rc.1  # optional, video paywalls on Android
```

Then:

```shell
flutter pub get
```

Build requirements:

| Platform | Requirement |
|----------|-------------|
| iOS | minimum deployment target **13.4** |
| Android | `minSdk 23`, `compileSdk 36`, `targetSdk 35` |

> 📘 Native dependency
>
> 6.0.0‑rc.1 targets the published Purchasely 6.0 native pre‑releases — Android `io.purchasely:core` / `google-play` / `player` on **Maven Central**, iOS `Purchasely` on the **CocoaPods trunk**. The project builds from the public repositories with no `mavenLocal()` and no development pod.

***

## 2. SDK initialization — fluent builder

`Purchasely.start(apiKey:…runningMode:storeKit1:logLevel:androidStores:userId:)` is **removed**. Start with `PurchaselyBuilder.apiKey(_)`, chain modifiers, finish with `start()`. `start()` returns a `Future<bool>` (`true` on success).

### Default running mode is now `RunningMode.observer` ⚠️

The default `runningMode` changed from `full` to `observer`. **If you want Purchasely to handle and validate purchases, set `RunningMode.full` explicitly.**

> 🚧 This change is silent — your code compiles without errors. If you relied on the implicit `full` default, your app will **stop handling and validating purchases** until you add `.runningMode(RunningMode.full)`. In `observer` mode, presentations also no longer auto‑close after a purchase or restore.

### Before (v5)

```dart
import 'package:purchasely_flutter/purchasely_flutter.dart';

bool configured = await Purchasely.start(
  apiKey: '<YOUR_API_KEY>',
  androidStores: ['Google'],
  storeKit1: false,
  logLevel: PLYLogLevel.error,
  runningMode: PLYRunningMode.full,
  userId: 'user_id',
);

Purchasely.readyToOpenDeeplink(true);
```

### After (v6)

```dart
import 'package:purchasely_flutter/purchasely_flutter.dart';

final bool configured = await PurchaselyBuilder.apiKey('<YOUR_API_KEY>')
    .appUserId('user_id')                        // optional, defaults to anonymous
    .runningMode(RunningMode.full)               // ← required for purchase handling & validation
    .logLevel(LogLevel.error)                    // debug | info | warn | error
    .allowDeeplink(true)                         // allow the SDK to open deeplinks
    .allowCampaigns(true)                        // optional campaign display gate
    .stores([PLYStore.google])                   // Android only: google | huawei | amazon
    .storekitVersion(StorekitVersion.storeKit2)  // iOS only: storeKit2 (default) | storeKit1
    .start();
```

### Chain modifiers and defaults

| Modifier | Default | Notes |
|----------|---------|-------|
| `appUserId(_)` | `null` (anonymous) | |
| `runningMode(_)` | `RunningMode.observer` ⚠️ (was `full` in v5) | set `RunningMode.full` to let Purchasely own the purchase flow |
| `logLevel(_)` | `LogLevel.error` | `debug` \| `info` \| `warn` \| `error` |
| `stores([_])` | `[]` | Android only: `PLYStore.google` \| `huawei` \| `amazon` |
| `storekitVersion(_)` | `StorekitVersion.storeKit2` | iOS only: `storeKit2` \| `storeKit1` (was `storeKit1: bool`) |
| `allowDeeplink(_)` | `true` | deeplinks display immediately; pass `false` to defer |
| `allowCampaigns(_)` | `true` | campaign display gate |

> 📘 `start()` returns `Future<bool>` — `true` on success. Wrap it in `try/catch` to surface a configuration error (e.g. an empty API key).

***

## 3. Displaying a presentation — `PresentationBuilder`

The `Purchasely.presentPresentation*` and `fetchPresentation` family are **removed**. Build a request with `PresentationBuilder`, then `display([Transition])` (or `preload()` first — see [Preloading](#4-preloading-pre-fetch)). `PresentationBuilder.placement(id).build()` returns a `PresentationRequest`; `display([Transition])` shows the screen and resolves at **dismiss** with a `PresentationOutcome`.

### Before (v5)

```dart
final result = await Purchasely.presentPresentationForPlacement(
  '<YOUR_PLACEMENT_ID>',
  contentId: 'my_content_id',
  isFullscreen: true,
);

switch (result.result) {
  case PLYPurchaseResult.purchased:
  case PLYPurchaseResult.restored:
    print('Purchased ${result.plan?.name}');
    break;
  case PLYPurchaseResult.cancelled:
    break;
}
```

### After (v6)

```dart
final outcome = await PresentationBuilder.placement('<YOUR_PLACEMENT_ID>')
    .contentId('my_content_id')
    .build()
    .display(const Transition.fullScreen());

// outcome: presentation, purchaseResult, plan, closeReason, error
if (outcome.error != null) {
  print('Display error: ${outcome.error!.message}');
} else if (outcome.purchaseResult == PurchaseResult.purchased ||
    outcome.purchaseResult == PurchaseResult.restored) {
  print('Purchased ${outcome.plan}');
} else {
  print('Dismissed: ${outcome.closeReason}'); // button | backSystem | programmatic
}
```

### Targeting a specific screen / product

```dart
// A specific presentation by screen id (was presentPresentationWithIdentifier)
await PresentationBuilder.screen('SCREEN_ID').build().display(const Transition.modal());

// A specific product / content inside a screen (was presentProductWithIdentifier)
await PresentationBuilder.screen('SCREEN_ID').contentId('CONTENT_ID').build().display();
```

### Transitions

`display([Transition])` accepts an optional `Transition` (replaces the old `isFullscreen: bool`):

```dart
const Transition.fullScreen();             // full-screen
const Transition.modal();                  // modal sheet
const Transition.modal(dismissible: false); // block ambient dismiss
const Transition.push();                   // pushed onto the navigation stack
```

`TransitionType` also exposes `drawer`, `popin` and `inlinePaywall` for advanced layouts (with `heightPercentage` and `backgroundColors`).

### `PLYPurchaseResult` → `PresentationOutcome`

The old single‑value display result is replaced by a 5‑field `PresentationOutcome` resolved at dismiss:

| Field | Type | Meaning |
|-------|------|---------|
| `presentation` | `Presentation?` | The displayed presentation (`null` if it never reached display) |
| `purchaseResult` | `PurchaseResult?` | `purchased` \| `restored` \| `cancelled` \| `null` (no purchase action) |
| `plan` | `Map<String, dynamic>?` | The purchased plan, when applicable |
| `closeReason` | `CloseReason?` | `button` \| `backSystem` \| `programmatic` (when no purchase) |
| `error` | `PresentationError?` | Display error; mutually exclusive with `closeReason` |

> 📘 `closeReason` parity
>
> Both native 6.0 SDKs now expose `closeReason`, surfaced on both platforms (`button` / `backSystem` / `programmatic`). iOS maps its `interactiveDismiss` (swipe‑down / nav‑pop) to `backSystem`. The only field still `null` on iOS is the loaded presentation `contentId` (`PLYPresentation` does not expose it on iOS); Android 6.0 reports it.

> 📘 Plan offer fields
>
> Android 6.0 renamed introductory‑price helpers to offer‑price helpers. Flutter now exposes the v6 names on `PLYPlan` (`hasOfferPrice`, `offerPrice`, `offerAmount`, `offerDuration`, `offerPeriod`) and keeps the old `intro*` fields populated as **deprecated** aliases.

***

## 4. Preloading (pre-fetch)

`Purchasely.fetchPresentation(...)` is **removed**. Build a `PresentationRequest`, `preload()` it to fetch the screen from the network, then `display()` the **same** request when ready (no extra network call).

### Before (v5)

```dart
final presentation = await Purchasely.fetchPresentation(placementId: '<YOUR_PLACEMENT_ID>');
final result = await Purchasely.presentPresentation(presentation);
```

### After (v6)

```dart
final request = PresentationBuilder.placement('<YOUR_PLACEMENT_ID>').build();

final presentation = await request.preload(); // resolves when the screen is loaded

if (presentation.type == PresentationType.deactivated) {
  return; // No paywall to display for this placement
}
if (presentation.type == PresentationType.client) {
  // Display your own paywall (BYOS) — plan summaries are in presentation.plans
  return;
}

// Later, when ready to show it; resolves at dismiss
final outcome = await request.display(const Transition.fullScreen());
```

### Presentation types

| Type (`PresentationType`) | Description |
|---------------------------|-------------|
| `normal` | Default Purchasely paywall |
| `fallback` | Fallback paywall (requested one not found) |
| `deactivated` | No paywall for this placement |
| `client` | Your own paywall (BYOS) |

***

## 5. Presentation lifecycle (display / close / back)

The imperative `Purchasely.showPresentation()` / `hidePresentation()` / `closePresentation()` methods are **removed** — there is no global `closePresentation`. Use the methods on the loaded `Presentation` handle (from `preload()`, or from `outcome.presentation`):

```dart
final presentation = await PresentationBuilder.placement('ONBOARDING').build().preload();

presentation.display();  // show (returns a future that resolves at dismiss)
presentation.close();    // dismiss programmatically (was Purchasely.closePresentation())
presentation.back();     // navigate back inside a multi-step (Flow) presentation
```

***

## 6. Action interceptor — per‑action API

`setPaywallActionInterceptorCallback` + `onProcessAction(bool)` are **removed**. Register **one handler per action kind** with `Purchasely.interceptAction(kind, handler)`; the handler returns an explicit `InterceptResult` instead of calling `onProcessAction(true/false)`.

### Before (v5)

```dart
Purchasely.setPaywallActionInterceptorCallback((info, action, parameters, processAction) {
  if (action == PLYPaywallAction.purchase) {
    MyPurchaseSystem.purchase(parameters.plan.productId);
    Purchasely.onProcessAction(false);
  } else {
    Purchasely.onProcessAction(true);
  }
});
```

### After (v6)

```dart
import 'package:purchasely_flutter/purchasely_flutter.dart';

await Purchasely.interceptAction(
  PresentationActionKind.purchase,
  (info, payload) async {
    if (payload is PurchasePayload) {
      final ok = await MyPurchaseSystem.purchase(payload.plan.productId);
      return ok ? InterceptResult.success : InterceptResult.failed;
    }
    return InterceptResult.notHandled;
  },
);

await Purchasely.interceptAction(
  PresentationActionKind.navigate,
  (info, payload) async {
    if (payload is NavigatePayload) {
      // open payload.url with your router / url_launcher
      return InterceptResult.success;
    }
    return InterceptResult.notHandled;
  },
);

// Cleanup
await Purchasely.removeInterceptor(PresentationActionKind.purchase);
await Purchasely.removeAllInterceptors();
```

### Result semantics

| `InterceptResult` | Meaning | SDK behavior |
|-------------------|---------|--------------|
| `success` | App handled the action successfully | Chain advances |
| `failed` | App tried but failed | Remaining actions are skipped |
| `notHandled` | App doesn't want to handle this | SDK executes the action itself |

`onProcessAction(false)` → `InterceptResult.success`, `onProcessAction(true)` → `InterceptResult.notHandled`.

### Action kinds & payloads

Action kinds (`PresentationActionKind`): `close`, `closeAll`, `login`, `navigate`, `purchase`, `restore`, `openPresentation`, `openPlacement`, `promoCode`, `webCheckout`. Each kind has a typed payload (`PurchasePayload`, `NavigatePayload`, `ClosePayload`, `CloseAllPayload`, `OpenPresentationPayload`, `OpenPlacementPayload`, `WebCheckoutPayload`); payload‑less kinds (`login`, `restore`, `promoCode`) carry no extra fields. `PurchasePayload` exposes real objects: `plan` is a `PLYPlan`, `subscriptionOffer` is a nullable `PLYSubscriptionOffer`, and `offer` is a nullable `PLYPromoOffer`.

> 📘 Observer‑mode bridge
>
> In `observer` mode, intercept `purchase` / `restore`, run your own billing flow, then call `Purchasely.synchronize()` and return `InterceptResult.success`. On Android, `PurchasePayload.subscriptionOffer` is a nullable `PLYSubscriptionOffer` carrying `subscriptionId`, `basePlanId`, `offerId`, and `offerToken`.

***

## 7. Deeplinks, campaigns & default dismiss handler

The old methods still compile but are **deprecated** aliases:

| v5 (deprecated) | v6 |
|-----------------|----|
| `Purchasely.readyToOpenDeeplink(_)` | `Purchasely.allowDeeplink(_)` |
| `Purchasely.isDeeplinkHandled(_)` | `Purchasely.handleDeeplink(_)` |

```dart
// Allow deeplinks at start (or toggle later with Purchasely.allowDeeplink(bool)):
await PurchaselyBuilder.apiKey('<YOUR_API_KEY>').allowDeeplink(true).start();

// v6 deeplink handler:
final handled = await Purchasely.handleDeeplink('app://ply/presentations/');
```

### Default dismiss handler

`Purchasely.setDefaultPresentationResultHandler(cb)` is replaced by `Purchasely.setDefaultPresentationDismissHandler(cb)`. Use it for presentations opened by the SDK itself: campaigns, deeplinks, and promoted in-app purchases.

```dart
await Purchasely.setDefaultPresentationDismissHandler((outcome) {
  print('SDK presentation dismissed: ${outcome.presentation?.screenId} / '
      '${outcome.purchaseResult} / ${outcome.closeReason}');
});
```

***

## 8. Inline (embedded) presentations

`Purchasely.getPresentationView(...)` is **removed**. To render a presentation inline inside your widget tree, use the `PLYPresentationView` widget with a `PresentationRequest`. The widget preloads the request and hands the result to the native inline view.

```dart
import 'package:purchasely_flutter/native_view_widget.dart';
import 'package:purchasely_flutter/purchasely_flutter.dart';

final request = PresentationBuilder.placement('onboarding')
    .onDismissed((outcome) => print('inline dismissed: ${outcome.purchaseResult}'))
    .build();

// In your build():
Expanded(
  child: PLYPresentationView(
    request: request,
    loadingBuilder: const Center(child: CircularProgressIndicator()),
    errorBuilder: (context, error) => Text('Error: ${error.message}'),
  ),
);
```

***

## 9. `synchronize()` now reports completion

The 6.0 native SDKs expose success/error callbacks on `synchronize()`. The Dart `Purchasely.synchronize()` keeps its `Future<void>` signature but now **resolves when the synchronization actually completes** and **throws a `PlatformException` on failure**, instead of the previous fire‑and‑forget behaviour:

```dart
try {
  await Purchasely.synchronize();
  // Subscriptions cache is refreshed; safe to chain a subscriber-targeted presentation
} on PlatformException catch (e) {
  print('Synchronize failed: ${e.message}');
}
```

No call‑site change is required for code that already `await`ed it.

***

## 10. Removed: native subscriptions & cancellation survey UI

The built‑in subscription management and cancellation survey UI was **removed** from the 6.0 native SDKs on both platforms.

* `Purchasely.presentSubscriptions()` is **removed entirely** from the Flutter API (Dart, iOS, Android). It is no longer a no‑op — the method no longer exists. There is no drop‑in replacement.
* `Purchasely.displaySubscriptionCancellationInstruction()` is **kept** for source compatibility but is now a **no‑op** on both platforms.

Build your own subscriptions screen from the data APIs that remain:

```dart
final active = await Purchasely.userSubscriptions();        // active subscriptions
final history = await Purchasely.userSubscriptionsHistory(); // expired subscriptions
```

***

## What stays the same

Only the **paywall surface** (start, display / preload / close / back, the action interceptor, default dismiss handler) has breaking API changes. Every other `Purchasely.*` method remains source‑compatible; deeplinks add v6 names with deprecated aliases:

* **Purchases**: `purchaseWithPlanVendorId`, `signPromotionalOffer`.
* **Restore**: `restoreAllProducts`, `silentRestoreAllProducts`, `userDidConsumeSubscriptionContent`.
* **Identity**: `userLogin`, `userLogout`, `isAnonymous`, `anonymousUserId`.
* **Catalog**: `allProducts`, `productWithIdentifier`, `planWithIdentifier`, `isEligibleForIntroOffer`.
* **Subscriptions data**: `userSubscriptions`, `userSubscriptionsHistory`, `displaySubscriptionCancellationInstruction` (now a no‑op). `presentSubscriptions()` is **removed** — see section 10.
* **User attributes**: `setUserAttributeWithString` / `WithInt` / `WithDouble` / `WithBoolean` / `WithDate` / `WithStringArray` / …, `incrementUserAttribute`, `decrementUserAttribute`, `userAttribute`, `userAttributes`, `clearUserAttribute`, `clearUserAttributes`, `setUserAttributeListener`.
* **Events**: `listenToEvents` / `stopListeningToEvents`, `listenToPurchases` / `stopListeningToPurchases`.
* **Dynamic offerings**: `setDynamicOffering`, `getDynamicOfferings`, `removeDynamicOffering`, `clearDynamicOfferings`.
* **Consent**: `revokeDataProcessingConsent`.
* **Config / misc**: `setLanguage`, `setThemeMode`, `setLogLevel`, `synchronize` (now awaitable — see section 9), `allowDeeplink`, `handleDeeplink`, `setDebugMode`. (`readyToOpenDeeplink` / `isDeeplinkHandled` remain deprecated aliases.)

***

## Migration checklist

### Breaking (must fix to compile)

* [ ] Pin `purchasely_flutter` / `purchasely_google` / `purchasely_android_player` to `6.0.0-rc.1`
* [ ] Replace `Purchasely.start(apiKey: …)` with `PurchaselyBuilder.apiKey('…')…start()`
* [ ] If using Full mode, add explicit `.runningMode(RunningMode.full)` (default changed to `observer`)
* [ ] Replace `storeKit1: bool` with `.storekitVersion(StorekitVersion.…)`; `androidStores: [...]` with `.stores([PLYStore.…])`
* [ ] Replace `presentPresentationForPlacement` / `WithIdentifier` / `fetchPresentation` with `PresentationBuilder.…build().display()` / `.preload()`
* [ ] Replace the `PLYPurchaseResult` display result with `PresentationOutcome`
* [ ] Replace `closePresentation()` / `hidePresentation()` / `showPresentation()` with `presentation.close()` / `.display()`
* [ ] Replace `getPresentationView(...)` with the `PLYPresentationView(request: …)` widget
* [ ] Replace `setPaywallActionInterceptorCallback` + `onProcessAction` with `Purchasely.interceptAction(kind, handler)` returning `InterceptResult`
* [ ] Replace `setDefaultPresentationResultHandler(cb)` with `Purchasely.setDefaultPresentationDismissHandler(cb)`
* [ ] Remove `presentSubscriptions()` — build your own UI from `userSubscriptions()` / `userSubscriptionsHistory()`

### Deprecated (fix before v7)

* [ ] Replace `readyToOpenDeeplink(_)` with `allowDeeplink(_)` and `isDeeplinkHandled(_)` with `handleDeeplink(_)`
* [ ] Migrate `intro*` plan helpers to the `offer*` equivalents

### Verify

1. `flutter pub get` succeeds with all packages at `6.0.0-rc.1`.
2. The init `Future<bool>` resolves `true`.
3. A placement‑based presentation displays; a `screen` presentation displays.
4. The `PresentationOutcome` resolves with the expected `purchaseResult` / `closeReason`.
5. In Observer mode, purchase and restore handlers resolve `InterceptResult` exactly once; `synchronize()` completes.
6. If you use Full mode, `.runningMode(RunningMode.full)` is set — purchases validate and screens auto‑close after purchase.

***

## Need a hand?

The Purchasely AI plugin and the `purchasely-integrate`, `purchasely-review` and `purchasely-debug` skills can scan your project and rewrite the old paywall calls to the new builder API. Point them at the files that call `Purchasely.start(...)`, `presentPresentationForPlacement(...)`, `fetchPresentation(...)`, `setPaywallActionInterceptorCallback(...)`, etc.
