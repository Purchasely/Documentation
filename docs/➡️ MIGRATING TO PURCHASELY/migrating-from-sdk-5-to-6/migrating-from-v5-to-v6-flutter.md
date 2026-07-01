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

Version 6.0.0-rc.1 (the first Flutter release candidate) adapts the Flutter plugin to the Purchasely 6.0 native SDKs (iOS `Purchasely 6.0.0-rc.2`, Android `io.purchasely:core 6.0.0-rc.2`). The paywall surface — starting the SDK, displaying / preloading / closing a presentation, and the action interceptor — moves to a fluent builder API. Everything else on the `Purchasely` class (purchases, restore, identity, catalog, subscriptions, user attributes, events, dynamic offerings, consent and config) remains source‑compatible.

> 📘 Breaking type renames (v5 → v6)
>
> These v5 types were renamed or restructured — update all usages: `PresentPresentationResult` → `PLYPresentationOutcome`, `PLYPaywallAction` → `PLYPresentationActionKind`, `PLYPaywallInfo` → `PLYInterceptorInfo`, `PLYPaywallActionParameters` → `PLYActionPayload` (+ typed `PLY*Payload` subclasses), `PaywallActionInterceptorResult` → handler returning `PLYInterceptResult`.

***

## Summary of breaking changes

| v5 | v6 |
|----|----|
| Default running mode `PLYRunningMode.full` | Default running mode **`PLYRunningMode.observer`** ⚠️ |
| `Purchasely.start(apiKey:…)` | `Purchasely.apiKey('…').…start()` / `PurchaselyBuilder.apiKey('…').…start()` (fluent builder) |
| `PLYRunningMode` (4 values: full/observer/paywallObserver/transactionOnly) | `PLYRunningMode` (2 values: `observer` / `full`) |
| `Purchasely.fetchPresentation(...)` | `PLYPresentationBuilder.…build().preload()` |
| `Purchasely.presentPresentationForPlacement(...)` | `PLYPresentationBuilder.placement(id).build().display([PLYTransition])` |
| `Purchasely.presentPresentationWithIdentifier(...)` | `PLYPresentationBuilder.screen(id).build().display([PLYTransition])` |
| `Purchasely.presentPresentation(presentation)` | `request.preload()` then `request.display()` |
| `Purchasely.closePresentation()` / `hidePresentation()` | `presentation.close()` |
| `Purchasely.showPresentation()` | `presentation.display()` |
| `Purchasely.getPresentationView(...)` | `PLYPresentationView(request: …)` widget |
| `PresentPresentationResult` (display result) | `PLYPresentationOutcome` (5 fields) |
| `PLYPaywallAction` (action kind) | `PLYPresentationActionKind` |
| `PLYPaywallInfo` (interceptor info) | `PLYInterceptorInfo` |
| `PLYPaywallActionParameters` (action payload) | `PLYActionPayload` (+ typed `PLY*Payload` subclasses) |
| `setPaywallActionInterceptorCallback` + `onProcessAction(bool)` | `Purchasely.interceptAction(kind, handler)` returning `PLYInterceptResult` |
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

`Purchasely.start(apiKey:…runningMode:storeKit1:logLevel:androidStores:userId:)` is **removed**. Start with `Purchasely.apiKey('…')` (or `PurchaselyBuilder.apiKey('…')`), chain modifiers, finish with `start()`. `start()` returns a `Future<bool>` (`true` on success).

### Default running mode is now `PLYRunningMode.observer` ⚠️

The default `runningMode` changed from `full` to `observer`. **If you want Purchasely to handle and validate purchases, set `PLYRunningMode.full` explicitly.**

> 🚧 This change is silent — your code compiles without errors. If you relied on the implicit `full` default, your app will **stop handling and validating purchases** until you add `.runningMode(PLYRunningMode.full)`. In `observer` mode, presentations also no longer auto‑close after a purchase or restore.

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

final bool configured = await Purchasely.apiKey('<YOUR_API_KEY>')
    .appUserId('user_id')                          // optional, defaults to anonymous
    .runningMode(PLYRunningMode.full)              // ← required for purchase handling & validation
    .logLevel(PLYLogLevel.error)                   // debug | info | warn | error
    .allowDeeplink(true)                           // allow the SDK to open deeplinks
    .allowCampaigns(true)                          // optional campaign display gate
    .stores([PLYStore.google])                     // Android only: google | huawei | amazon
    .storekitVersion(PLYStorekitVersion.storeKit2) // iOS only: storeKit2 (default) | storeKit1
    .start();
```

### Chain modifiers and defaults

| Modifier | Default | Notes |
|----------|---------|-------|
| `appUserId(_)` | `null` (anonymous) | |
| `runningMode(_)` | `PLYRunningMode.observer` ⚠️ (was `full` in v5) | set `PLYRunningMode.full` to let Purchasely own the purchase flow |
| `logLevel(_)` | `PLYLogLevel.error` | `debug` \| `info` \| `warn` \| `error` |
| `stores([_])` | `[]` | Android only: `PLYStore.google` \| `huawei` \| `amazon` |
| `storekitVersion(_)` | `PLYStorekitVersion.storeKit2` | iOS only: `storeKit2` \| `storeKit1` (was `storeKit1: bool`) |
| `allowDeeplink(_)` | `true` | deeplinks display immediately; pass `false` to defer |
| `allowCampaigns(_)` | `true` | campaign display gate |

> 📘 `start()` returns `Future<bool>` — `true` on success. Wrap it in `try/catch` to surface a configuration error (e.g. an empty API key).

***

## 3. Displaying a presentation — `PLYPresentationBuilder`

The `Purchasely.presentPresentation*` and `fetchPresentation` family are **removed**. Build a request with `PLYPresentationBuilder`, then `display([PLYTransition])` (or `preload()` first — see [Preloading](#4-preloading-pre-fetch)). `PLYPresentationBuilder.placement(id).build()` returns a `PLYPresentationRequest`; `display([PLYTransition])` shows the screen and resolves at **dismiss** with a `PLYPresentationOutcome`.

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
final outcome = await PLYPresentationBuilder.placement('<YOUR_PLACEMENT_ID>')
    .contentId('my_content_id')
    .build()
    .display(const PLYTransition.fullScreen());

// outcome: presentation, purchaseResult, plan, closeReason, error
if (outcome.error != null) {
  print('Display error: ${outcome.error!.message}');
} else if (outcome.purchaseResult == PLYPurchaseResult.purchased ||
    outcome.purchaseResult == PLYPurchaseResult.restored) {
  print('Purchased ${outcome.plan?.name}');
} else {
  print('Dismissed: ${outcome.closeReason}'); // button | backSystem | programmatic
}
```

### Targeting a specific screen / product

```dart
// A specific presentation by screen id (was presentPresentationWithIdentifier)
await PLYPresentationBuilder.screen('SCREEN_ID').build().display(const PLYTransition.modal());

// A specific product / content inside a screen (was presentProductWithIdentifier)
await PLYPresentationBuilder.screen('SCREEN_ID').contentId('CONTENT_ID').build().display();
```

### Transitions

`display([PLYTransition])` accepts an optional `PLYTransition` (replaces the old `isFullscreen: bool`):

```dart
const PLYTransition.fullScreen();              // full-screen
const PLYTransition.modal();                   // modal sheet
const PLYTransition.modal(dismissible: false); // block ambient dismiss
const PLYTransition.push();                    // pushed onto the navigation stack
const PLYTransition.drawer(height: PLYTransitionDimension.percentage(0.5));
const PLYTransition.popin(
  width: PLYTransitionDimension.pixel(320),
  height: PLYTransitionDimension.percentage(0.6),
);
```

`PLYTransitionDimension` accepts `.percentage(value)` (0.0–1.0) or `.pixel(value)`. The old `heightPercentage` field has been **removed** — use the factory constructors above.

### `PLYPurchaseResult` → `PLYPresentationOutcome`

The old single‑value display result is replaced by a 5‑field `PLYPresentationOutcome` resolved at dismiss:

| Field | Type | Meaning |
|-------|------|---------|
| `presentation` | `PLYPresentation?` | The displayed presentation (`null` if it never reached display) |
| `purchaseResult` | `PLYPurchaseResult?` | `purchased` \| `restored` \| `cancelled` \| `null` (no purchase action) |
| `plan` | `PLYPlan?` | The purchased plan, when applicable |
| `closeReason` | `PLYCloseReason?` | `button` \| `backSystem` \| `programmatic` (when no purchase) |
| `error` | `PLYPresentationError?` | Display error; mutually exclusive with `closeReason` |

> 📘 `closeReason` parity
>
> Both native 6.0 SDKs now expose `closeReason`, surfaced on both platforms (`button` / `backSystem` / `programmatic`). iOS maps its `interactiveDismiss` (swipe‑down / nav‑pop) to `backSystem`. The only field still `null` on iOS is the loaded presentation `contentId` (`PLYPresentation` does not expose it on iOS); Android 6.0 reports it.

> 📘 Plan offer fields
>
> Android 6.0 renamed introductory‑price helpers to offer‑price helpers. Flutter now exposes the v6 names on `PLYPlan` (`hasOfferPrice`, `offerPrice`, `offerAmount`, `offerDuration`, `offerPeriod`) and keeps the old `intro*` fields populated as **deprecated** aliases.

***

## 4. Preloading (pre-fetch)

`Purchasely.fetchPresentation(...)` is **removed**. Build a `PLYPresentationRequest`, `preload()` it to fetch the screen from the network, then `display()` the **same** request when ready (no extra network call).

### Before (v5)

```dart
final presentation = await Purchasely.fetchPresentation(placementId: '<YOUR_PLACEMENT_ID>');
final result = await Purchasely.presentPresentation(presentation);
```

### After (v6)

```dart
final request = PLYPresentationBuilder.placement('<YOUR_PLACEMENT_ID>').build();

final presentation = await request.preload(); // resolves when the screen is loaded

if (presentation.type == PLYPresentationType.deactivated) {
  return; // No paywall to display for this placement
}
if (presentation.type == PLYPresentationType.client) {
  // Display your own paywall (BYOS) — plan summaries are in presentation.plans
  return;
}

// Later, when ready to show it; resolves at dismiss
final outcome = await request.display(const PLYTransition.fullScreen());
```

You can also chain preload and display in a single expression:

```dart
final outcome = await PLYPresentationBuilder.placement('<YOUR_PLACEMENT_ID>')
    .build()
    .preload()
    .display(const PLYTransition.drawer(height: PLYTransitionDimension.percentage(0.5)));
```

### Presentation types

| Type (`PLYPresentationType`) | Description |
|------------------------------|-------------|
| `normal` | Default Purchasely paywall |
| `fallback` | Fallback paywall (requested one not found) |
| `deactivated` | No paywall for this placement |
| `client` | Your own paywall (BYOS) |

***

## 5. Presentation lifecycle (display / close / back)

The imperative `Purchasely.showPresentation()` / `hidePresentation()` / `closePresentation()` methods are **removed** — there is no global `closePresentation`. Use the methods on the loaded `PLYPresentation` handle (from `preload()`, or from `outcome.presentation`):

```dart
final presentation = await PLYPresentationBuilder.placement('ONBOARDING').build().preload();

presentation.display();  // show (returns a future that resolves at dismiss)
presentation.close();    // dismiss programmatically (was Purchasely.closePresentation())
presentation.back();     // navigate back inside a multi-step (Flow) presentation
```

***

## 6. Action interceptor — per‑action API

`setPaywallActionInterceptorCallback` + `onProcessAction(bool)` are **removed**. Register **one handler per action kind** with `Purchasely.interceptAction(kind, handler)`; the handler returns an explicit `PLYInterceptResult` instead of calling `onProcessAction(true/false)`.

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
  PLYPresentationActionKind.purchase,
  (info, payload) async {
    if (payload is PLYPurchasePayload) {
      final ok = await MyPurchaseSystem.purchase(payload.plan.productId);
      return ok ? PLYInterceptResult.success : PLYInterceptResult.failed;
    }
    return PLYInterceptResult.notHandled;
  },
);

await Purchasely.interceptAction(
  PLYPresentationActionKind.navigate,
  (info, payload) async {
    if (payload is PLYNavigatePayload) {
      // open payload.url with your router / url_launcher
      return PLYInterceptResult.success;
    }
    return PLYInterceptResult.notHandled;
  },
);

// Cleanup
await Purchasely.removeActionInterceptor(PLYPresentationActionKind.purchase);
await Purchasely.removeAllActionInterceptors();
```

### Result semantics

| `PLYInterceptResult` | Meaning | SDK behavior |
|----------------------|---------|--------------|
| `success` | App handled the action successfully | Chain advances |
| `failed` | App tried but failed | Remaining actions are skipped |
| `notHandled` | App doesn't want to handle this | SDK executes the action itself |

`onProcessAction(false)` → `PLYInterceptResult.success`, `onProcessAction(true)` → `PLYInterceptResult.notHandled`.

### Action kinds & payloads

Action kinds (`PLYPresentationActionKind`): `close`, `closeAll`, `login`, `navigate`, `purchase`, `restore`, `openPresentation`, `openPlacement`, `promoCode`, `webCheckout`. Each kind has a typed payload (`PLYPurchasePayload`, `PLYNavigatePayload`, `PLYClosePayload`, `PLYCloseAllPayload`, `PLYOpenPresentationPayload`, `PLYOpenPlacementPayload`, `PLYWebCheckoutPayload`); payload‑less kinds (`login`, `restore`, `promoCode`) carry no extra fields. `PLYPurchasePayload` exposes real objects: `plan` is a `PLYPlan`, `subscriptionOffer` is a nullable `PLYSubscriptionOffer`, and `offer` is a nullable `PLYPromoOffer`.

> 📘 Observer‑mode bridge
>
> In `observer` mode, intercept `purchase` / `restore`, run your own billing flow, then return `PLYInterceptResult.success`. The SDK synchronizes the transaction automatically on a success result — no manual `Purchasely.synchronize()` call is needed in this path. On Android, `PLYPurchasePayload.subscriptionOffer` is a nullable `PLYSubscriptionOffer` carrying `subscriptionId`, `basePlanId`, `offerId`, and `offerToken`.

***

## 7. Deeplinks, campaigns & default dismiss handler

The old methods still compile but are **deprecated** aliases:

| v5 (deprecated) | v6 |
|-----------------|----|
| `Purchasely.readyToOpenDeeplink(_)` | `Purchasely.allowDeeplink(_)` |
| `Purchasely.isDeeplinkHandled(_)` | `Purchasely.handleDeeplink(_)` |

```dart
// Allow deeplinks at start (or toggle later with Purchasely.allowDeeplink(bool)):
await Purchasely.apiKey('<YOUR_API_KEY>').allowDeeplink(true).start();

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

`Purchasely.getPresentationView(...)` is **removed**. To render a presentation inline inside your widget tree, use the `PLYPresentationView` widget with a `PLYPresentationRequest`. The widget preloads the request and hands the result to the native inline view.

```dart
import 'package:purchasely_flutter/native_view_widget.dart';
import 'package:purchasely_flutter/purchasely_flutter.dart';

final request = PLYPresentationBuilder.placement('onboarding')
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
* [ ] Rename v5 types: `PresentPresentationResult` → `PLYPresentationOutcome`, `PLYPaywallAction` → `PLYPresentationActionKind`, `PLYPaywallInfo` → `PLYInterceptorInfo`, `PLYPaywallActionParameters` → `PLYActionPayload`
* [ ] Remove `PLYRunningMode.transactionOnly` and `PLYRunningMode.paywallObserver` — only `observer` and `full` remain
* [ ] Replace `Purchasely.start(apiKey: …)` with `Purchasely.apiKey('…').…start()` (or `PurchaselyBuilder.apiKey('…').…start()`)
* [ ] If using Full mode, add explicit `.runningMode(PLYRunningMode.full)` (default changed to `observer`)
* [ ] Replace `storeKit1: bool` with `.storekitVersion(PLYStorekitVersion.…)`; `androidStores: [...]` with `.stores([PLYStore.…])`
* [ ] Replace `presentPresentationForPlacement` / `WithIdentifier` / `fetchPresentation` with `PLYPresentationBuilder.…build().display()` / `.preload()`
* [ ] Replace the `PLYPurchaseResult` display result with `PLYPresentationOutcome`
* [ ] Replace `closePresentation()` / `hidePresentation()` / `showPresentation()` with `presentation.close()` / `.display()`
* [ ] Replace `getPresentationView(...)` with the `PLYPresentationView(request: …)` widget
* [ ] Replace `setPaywallActionInterceptorCallback` + `onProcessAction` with `Purchasely.interceptAction(kind, handler)` returning `PLYInterceptResult`
* [ ] Replace `removeInterceptor(kind)` / `removeAllInterceptors()` with `removeActionInterceptor(kind)` / `removeAllActionInterceptors()`
* [ ] Replace `setDefaultPresentationResultHandler(cb)` with `Purchasely.setDefaultPresentationDismissHandler(cb)`
* [ ] Replace `Transition(type: TransitionType.drawer, heightPercentage: x)` with `PLYTransition.drawer(height: PLYTransitionDimension.percentage(x))`
* [ ] Remove `presentSubscriptions()` — build your own UI from `userSubscriptions()` / `userSubscriptionsHistory()`

### Deprecated (fix before v7)

* [ ] Replace `readyToOpenDeeplink(_)` with `allowDeeplink(_)` and `isDeeplinkHandled(_)` with `handleDeeplink(_)`
* [ ] Migrate `intro*` plan helpers to the `offer*` equivalents

### Verify

1. `flutter pub get` succeeds with all packages at `6.0.0-rc.1`.
2. The init `Future<bool>` resolves `true`.
3. A placement‑based presentation displays; a `screen` presentation displays.
4. The `PLYPresentationOutcome` resolves with the expected `purchaseResult` / `closeReason`.
5. In Observer mode, purchase and restore handlers resolve `PLYInterceptResult` exactly once; `synchronize()` completes.
6. If you use Full mode, `.runningMode(PLYRunningMode.full)` is set — purchases validate and screens auto‑close after purchase.

***

## Need a hand?

The Purchasely AI plugin and the `purchasely-integrate`, `purchasely-review` and `purchasely-debug` skills can scan your project and rewrite the old paywall calls to the new builder API. Point them at the files that call `Purchasely.start(...)`, `presentPresentationForPlacement(...)`, `fetchPresentation(...)`, `setPaywallActionInterceptorCallback(...)`, etc.
