---
title: Migrating to v6 — Flutter
excerpt: Migration guide for the Purchasely Flutter SDK from v5.x to v6.0.0
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
This guide covers the **Flutter SDK** (Dart). Version 6.0.0 adapts the Flutter plugin to the Purchasely 6.0 native SDKs (iOS `Purchasely 6.0.0`, Android `io.purchasely:core 6.0.1`). For the native layers this plugin bridges to, see the [iOS guide](migrating-from-v5-to-v6-ios) or the [Android guide](migrating-from-v5-to-v6-android), or the platform pages listed on the [migration overview](migrating-from-sdk-5-to-6).

Three areas are breaking: **starting the SDK**, **displaying / preloading / closing a presentation**, and the **action interceptor** — they all move to a fluent builder API. Everything else on the `Purchasely` class (purchases, restore, identity, catalog, subscriptions, user attributes, events, dynamic offerings, consent and config) remains source-compatible except for the removed v5 aliases listed below. A paywall is now called a **Presentation** (or *Screen*).

> 🚧 Default running mode changed to `observer`
>
> With the 6.0 native SDKs the default `PLYRunningMode` is **`PLYRunningMode.observer`** — the host app keeps control of the purchase flow unless it opts into `full`. This change is **silent**: your code compiles without errors, but if you relied on the implicit `full` default, your app will stop handling and validating purchases until you add `.runningMode(PLYRunningMode.full)`. See [SDK initialization](#2-sdk-initialization--fluent-builder).

> 📘 Breaking type renames (v5 → v6)
>
> These v5 types were renamed or restructured — update all usages: `PresentPresentationResult` → `PLYPresentationOutcome`, `PLYPaywallAction` → `PLYPresentationActionKind`, `PLYPaywallInfo` → `PLYInterceptorInfo`, `PLYPaywallActionParameters` → `PLYActionPayload` (+ typed `PLY*Payload` subclasses), `PaywallActionInterceptorResult` → handler returning `PLYInterceptResult`.

***

## Requirements

Pin all Purchasely packages to the **exact same** version. Mismatched versions cause runtime errors.

```yaml
dependencies:
  purchasely_flutter: 6.0.0
  purchasely_google: 6.0.0          # required if you distribute on Google Play
  purchasely_android_player: 6.0.0  # optional, video paywalls on Android
```

Host build requirements:

| Platform | Requirement |
|----------|-------------|
| iOS | minimum deployment target **13.4** |
| Android | `minSdk 23`, `compileSdk 36` |

> 📘 Native dependency
>
> 6.0.0 targets the published Purchasely 6.0 native releases — Android `io.purchasely:core` / `google-play` / `player` `6.0.1` on **Maven Central**, iOS `Purchasely` `6.0.0` on the **CocoaPods trunk**. The project builds from the public repositories with no `mavenLocal()` and no development pod.

***

## Summary of breaking changes

| v5 | v6 |
|----|----|
| Default running mode `PLYRunningMode.full` | Default running mode **`PLYRunningMode.observer`** ⚠️ |
| `Purchasely.start(apiKey: …)` | `Purchasely.apiKey('…').…start()` (fluent builder) |
| `PLYRunningMode` (4 values: `full` / `observer` / `paywallObserver` / `transactionOnly`) | `PLYRunningMode` (2 values: `observer` / `full`) |
| `Purchasely.fetchPresentation(...)` | `PLYPresentationBuilder.…build().preload()` |
| `Purchasely.presentPresentationForPlacement(...)` | `PLYPresentationBuilder.placement(id).build().display([PLYTransition])` |
| `Purchasely.presentPresentationWithIdentifier(...)` / `presentProductWithIdentifier(...)` / `presentPlanWithIdentifier(...)` | `PLYPresentationBuilder.screen(id).…build().display([PLYTransition])` |
| `Purchasely.presentPresentation(presentation)` | `request.preload()` then `display()` |
| `Purchasely.closePresentation()` / `hidePresentation()` | `presentation.close()` |
| `Purchasely.showPresentation()` | `presentation.display()` |
| `Purchasely.getPresentationView(...)` | `PLYPresentationView(request: …)` widget |
| `PresentPresentationResult` (display result) | `PLYPresentationOutcome` (5 fields, resolved at dismiss) |
| `setPaywallActionInterceptorCallback` + `onProcessAction(bool)` | `Purchasely.interceptAction(kind, handler)` returning `PLYInterceptResult` |
| `PLYPaywallAction` / `PLYPaywallInfo` / `PLYPaywallActionParameters` | `PLYPresentationActionKind` / `PLYInterceptorInfo` / `PLYActionPayload` (+ typed `PLY*Payload`) |
| `setDefaultPresentationResultHandler(cb)` | `Purchasely.setDefaultPresentationDismissHandler(cb)` |
| `Transition(…, heightPercentage: x)` | `PLYTransition.drawer(height: PLYTransitionDimension.percentage(x))` — `heightPercentage` removed |
| `readyToOpenDeeplink(_)` | `allowDeeplink(_)` (old name **removed**) |
| `isDeeplinkHandled(_)` | `handleDeeplink(_)` (old name **removed**) |
| `synchronize()` returning `Future<void>` (fire-and-forget) | `synchronize()` returning **`Future<bool>`**, throws on failure |
| `presentSubscriptions()` | **removed** — build your own from `userSubscriptions()` |
| `displaySubscriptionCancellationInstruction()` | **removed** |

> 📘 Everything not in the table above keeps source-compatible `Purchasely.*` signatures — see [What stays the same](#what-stays-the-same).

***

## 1. Update dependencies & host build configuration

Pin the packages listed in [Requirements](#requirements), then:

```shell
flutter pub get
```

On Android, make sure the host app builds with `compileSdk 36` and `minSdk 23` (or higher). On iOS, raise the deployment target to **13.4** if needed (in `ios/Podfile` and the Xcode project), then run `pod install --repo-update` in `ios/`.

***

## 2. SDK initialization — fluent builder

`Purchasely.start(apiKey: … runningMode: … storeKit1: … logLevel: … androidStores: … userId: …)` is **removed**. Start with `Purchasely.apiKey('…')`, chain modifiers, finish with `start()`. `start()` returns a `Future<bool>` (`true` on success).

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

Purchasely.readyToOpenDeeplink(true); // removed in v6; use allowDeeplink
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

> 🚧 Default running mode is now `PLYRunningMode.observer`
>
> The default `runningMode` changed from `full` to `observer`. **If you want Purchasely to handle and validate purchases, set `PLYRunningMode.full` explicitly.** In `observer` mode, the host app owns the purchase flow. The old `PLYRunningMode.transactionOnly` and `PLYRunningMode.paywallObserver` values no longer exist — only `observer` and `full` remain.

### Chain modifiers and defaults

| Modifier | Default | Notes |
|----------|---------|-------|
| `appUserId(_)` | `null` (anonymous) | |
| `runningMode(_)` | `PLYRunningMode.observer` ⚠️ (was `full` in v5) | set `PLYRunningMode.full` to let Purchasely own the purchase flow |
| `logLevel(_)` | `PLYLogLevel.error` | `debug` \| `info` \| `warn` \| `error` |
| `stores([_])` | `[PLYStore.google]` | Android only: `PLYStore.google` \| `huawei` \| `amazon` |
| `storekitVersion(_)` | `PLYStorekitVersion.storeKit2` | iOS only: `storeKit2` \| `storeKit1` (replaces `storeKit1: bool`) |
| `allowDeeplink(_)` | unset (native SDK default) | can also be toggled later with `Purchasely.allowDeeplink(bool)` |
| `allowCampaigns(_)` | `true` | campaign display gate |

***

## 3. Action interceptor — per-action API

`setPaywallActionInterceptorCallback` + `onProcessAction(bool)` are **removed**. Register **one handler per action kind** with `Purchasely.interceptAction(kind, handler)`; the handler returns an explicit `PLYInterceptResult` (`success` / `failed` / `notHandled`) instead of calling `onProcessAction(true/false)`.

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

Mapping from v5: `onProcessAction(false)` → `PLYInterceptResult.success`, `onProcessAction(true)` → `PLYInterceptResult.notHandled`.

### Action kinds & payloads

Action kinds (`PLYPresentationActionKind`): `close`, `closeAll`, `login`, `navigate`, `purchase`, `restore`, `openPresentation`, `openPlacement`, `promoCode`, `webCheckout`. Each kind has a typed payload (`PLYPurchasePayload`, `PLYNavigatePayload`, `PLYClosePayload`, `PLYCloseAllPayload`, `PLYOpenPresentationPayload`, `PLYOpenPlacementPayload`, `PLYWebCheckoutPayload`); payload-less kinds (`login`, `restore`, `promoCode`) carry no extra fields. `PLYPurchasePayload` exposes real objects: `plan` is a `PLYPlan`, `subscriptionOffer` is a nullable `PLYSubscriptionOffer`, and `offer` is a nullable `PLYPromoOffer`.

> 📘 Observer-mode bridge
>
> In `observer` mode, intercept `purchase` / `restore`, run your own billing flow, then return `PLYInterceptResult.success` (or `.failed`). On Android, `PLYPurchasePayload.subscriptionOffer` is a nullable `PLYSubscriptionOffer` carrying `subscriptionId`, `basePlanId`, `offerId`, and `offerToken`.

***

## 4. Displaying, preloading & closing presentations

The `Purchasely.presentPresentation*` and `fetchPresentation` family are **removed**. Build a request with `PLYPresentationBuilder` (`.placement(id)`, `.screen(id)`, `.contentId(id)`), then `.build()` to get a `PLYPresentationRequest` with a lifecycle: `preload()` and `display([PLYTransition])`. `display` shows the screen and resolves at **dismiss** with a `PLYPresentationOutcome`.

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

### The `PLYPresentationOutcome`

The old single-value display result is replaced by a 5-field `PLYPresentationOutcome` resolved at dismiss:

| Field | Type | Meaning |
|-------|------|---------|
| `presentation` | `PLYPresentation?` | The displayed presentation (`null` if it never reached display) |
| `purchaseResult` | `PLYPurchaseResult?` | `purchased` \| `restored` \| `cancelled` \| `null` (no purchase action) |
| `plan` | `PLYPlan?` | The purchased plan — fully typed, read `outcome.plan?.vendorId`, `.name`, `.amount`, … |
| `closeReason` | `PLYCloseReason?` | `button` \| `backSystem` \| `programmatic` |
| `error` | `PLYPresentationError?` | Display error (`code`, `message`) |

> 📘 `closeReason` parity
>
> Both native 6.0 SDKs expose `closeReason`, and Flutter surfaces it on both platforms (`button` / `backSystem` / `programmatic`). iOS maps its `interactiveDismiss` (swipe-down / nav-pop) to `backSystem` to stay aligned with Android's `BACK_SYSTEM`. The only field still `null` on iOS is the loaded presentation `contentId` (`PLYPresentation` does not expose it on iOS); Android 6.0 reports it.

> 📘 Plan offer fields
>
> Android 6.0 renamed introductory-price helpers to offer-price helpers. Flutter exposes the v6 names on `PLYPlan` (`hasOfferPrice`, `offerPrice`, `offerAmount`, `offerDuration`, `offerPeriod`) and keeps the old `intro*` fields populated as **deprecated** compatibility aliases.

### Targeting a specific screen / product

```dart
// A specific presentation by screen id (was presentPresentationWithIdentifier)
await PLYPresentationBuilder.screen('SCREEN_ID').build().display(const PLYTransition.modal());

// A specific product / content inside a screen (was presentProductWithIdentifier)
await PLYPresentationBuilder.screen('SCREEN_ID').contentId('CONTENT_ID').build().display();
```

### Transitions — `heightPercentage` removed

`display([PLYTransition])` accepts an optional `PLYTransition` (replaces the old `isFullscreen: bool`). `PLYTransition.heightPercentage` was **removed**: drawer and popin transitions are now sized with `PLYTransitionDimension`, expressed as a `percentage` (`0.0`–`1.0`) or fixed `pixel` value. Leave a dimension `null` to size to content ("hug").

```dart
// Before (v5 / removed):
// Transition(type: TransitionType.drawer, heightPercentage: 0.5);

// After — factory constructors (preferred):
const PLYTransition.drawer(height: PLYTransitionDimension.percentage(0.5));
const PLYTransition.drawer(height: PLYTransitionDimension.pixel(300));

const PLYTransition.popin(
  width: PLYTransitionDimension.pixel(320),
  height: PLYTransitionDimension.percentage(0.6),
  dismissible: false,
);

// After — explicit constructor (equivalent):
const PLYTransition(
  type: PLYTransitionType.drawer,
  height: PLYTransitionDimension.percentage(0.5),
);
```

Available factory constructors on `PLYTransition`:

| Constructor | Description |
|-------------|-------------|
| `PLYTransition.fullScreen()` | Full-screen (default) |
| `PLYTransition.modal({bool? dismissible})` | Modal sheet |
| `PLYTransition.push()` | Push / navigation |
| `PLYTransition.drawer({PLYTransitionDimension? height, bool? dismissible, PLYTransitionColors? backgroundColors})` | Bottom drawer with optional height |
| `PLYTransition.popin({PLYTransitionDimension? width, PLYTransitionDimension? height, bool? dismissible, PLYTransitionColors? backgroundColors})` | Floating pop-in with optional dimensions |

### Preloading (pre-fetch)

`Purchasely.fetchPresentation(...)` is **removed**. Build a `PLYPresentationRequest`, `preload()` it to fetch the screen from the network, then `display()` when ready (no extra network call).

**Before (v5):**

```dart
final presentation = await Purchasely.fetchPresentation(placementId: '<YOUR_PLACEMENT_ID>');
final result = await Purchasely.presentPresentation(presentation);
```

**After (v6) — Pattern A, separate preload and display** (preload early, display later):

```dart
final request = PLYPresentationBuilder.placement('<YOUR_PLACEMENT_ID>').build();

final presentation = await request.preload(); // resolves when the screen is loaded

if (presentation.type == PLYPresentationType.deactivated) {
  return; // No paywall to display for this placement
}
if (presentation.type == PLYPresentationType.client) {
  return; // Display your own paywall (BYOS) — plan summaries are in presentation.plans
}

// Later, when ready to show it; resolves at dismiss
final outcome = await presentation.display(const PLYTransition.fullScreen());
```

**After (v6) — Pattern B, chained preload and display** (one expression):

```dart
final outcome = await PLYPresentationBuilder.placement('<YOUR_PLACEMENT_ID>')
    .build()
    .preload()
    .display(const PLYTransition.drawer(height: PLYTransitionDimension.percentage(0.5)));
```

> 📘 `preload()` on `PLYPresentationRequest` returns `Future<PLYPresentation>`. The `display([PLYTransition?])` method is available both on `PLYPresentation` directly (Pattern A) and via a `Future<PLYPresentation>` extension (Pattern B).

Presentation types (`PLYPresentationType`): `normal` (default Purchasely paywall), `fallback` (requested one not found), `deactivated` (no paywall for this placement), `client` (your own paywall — BYOS). For a `client` presentation, `Purchasely.clientPresentationDisplayed(presentation)` and `Purchasely.clientPresentationClosed(presentation)` are **kept with the same names** — pass the `PLYPresentation` returned by `preload()` when you display/close your own paywall.

### Presentation lifecycle (display / close / back)

The imperative `Purchasely.showPresentation()` / `hidePresentation()` / `closePresentation()` methods are **removed** — there is no global close anymore. Use the methods on the loaded `PLYPresentation` handle (from `preload()`, or from `outcome.presentation`):

```dart
final presentation = await PLYPresentationBuilder.placement('ONBOARDING').build().preload();

presentation.display();  // show (returns a future that resolves at dismiss)
presentation.close();    // dismiss programmatically (was Purchasely.closePresentation())
presentation.back();     // navigate back inside a multi-step (Flow) presentation
```

***

## 5. Inline (embedded) presentations

`Purchasely.getPresentationView(...)` is **removed**. To render a presentation inline inside your widget tree, use the `PLYPresentationView` widget with a `PLYPresentationRequest`. The widget preloads the request and hands the result to the native inline view.

### Before (v5)

```dart
final presentation = await Purchasely.fetchPresentation(placementId: 'onboarding');
// ...embed via Purchasely.getPresentationView(presentation: presentation, ...)
```

### After (v6)

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

## 6. Deeplinks, campaigns & default dismiss handler

The v5 deeplink methods are **removed** (they no longer compile):

| v5 (removed) | v6 |
|--------------|----|
| `Purchasely.readyToOpenDeeplink(_)` | `Purchasely.allowDeeplink(_)` |
| `Purchasely.isDeeplinkHandled(_)` | `Purchasely.handleDeeplink(_)` |

```dart
// Allow deeplinks and campaigns at start:
await Purchasely.apiKey('<YOUR_API_KEY>')
    .allowDeeplink(true)
    .allowCampaigns(true)
    .start();

// These runtime gates are independent and can be toggled later:
await Purchasely.allowDeeplink(true);
await Purchasely.allowCampaigns(false);

// v6 deeplink handler:
final handled = await Purchasely.handleDeeplink('app://ply/presentations/');
```

### Default dismiss handler

`Purchasely.setDefaultPresentationResultHandler(cb)` is replaced by `Purchasely.setDefaultPresentationDismissHandler(cb)`, which receives a `PLYPresentationOutcome`. It is the path for presentations opened by the SDK itself — campaigns, deeplinks, promoted in-app purchases — which have no host-side `display()` call to await.

```dart
await Purchasely.setDefaultPresentationDismissHandler((outcome) {
  print('SDK presentation dismissed: ${outcome.presentation?.screenId} / '
      '${outcome.purchaseResult} / ${outcome.closeReason}');
});
```

### Where the dismiss outcome is delivered (routing)

A dismissed presentation produces one `PLYPresentationOutcome`. There are three ways to receive it:

| Channel | What it is |
|---------|------------|
| `await display()` | the **return value** — you await the call and get the outcome inline |
| `onDismissed` | a **per-presentation** callback attached to *this* request/presentation |
| `setDefaultPresentationDismissHandler` | a single **global** handler for the whole app |

**Routing rule:** at dismiss, the outcome goes to the **`onDismissed` handler if one is set, otherwise to the global default handler**. The deciding factor is the *presence of `onDismissed`* — not whether you awaited the future. Awaiting `display()` always gives you the outcome as a return value, but it does **not** by itself suppress the global handler.

```dart
await Purchasely.setDefaultPresentationDismissHandler((outcome) {
  print('caught globally: ${outcome.purchaseResult}');
});

// (A) fire-and-forget, no onDismissed → the GLOBAL handler receives it.
PLYPresentationBuilder.placement('PLACEMENT').build().display();

// (B) local onDismissed set → the LOCAL handler receives it, global stays silent.
PLYPresentationBuilder.placement('PLACEMENT')
    .onDismissed((outcome) => print('caught locally'))
    .build()
    .display();

// (C) await without onDismissed → the return value AND the global handler both
//     receive it (set an onDismissed if you want the global to stay silent).
final outcome =
    await PLYPresentationBuilder.placement('PLACEMENT').build().display();

// (D) await + onDismissed → return value + local handler receive it, global silent.
```

> 📘 Rule of thumb: pick *one* channel per presentation — await it, **or** set `onDismissed`, **or** leave both off and let the global handler catch it.

***

## 7. `synchronize()` & removed APIs

### `synchronize()` now reports completion (breaking signature)

The 6.0 native SDKs expose success/error callbacks on `synchronize()`. `Purchasely.synchronize()` now returns **`Future<bool>`** (was `Future<void>`): it resolves with `true` when the synchronization actually completes and throws a `PlatformException` on failure, instead of the previous fire-and-forget behaviour.

#### Before (v5)

```dart
Purchasely.synchronize(); // fire-and-forget, resolved immediately
```

#### After (v6)

```dart
try {
  final synced = await Purchasely.synchronize(); // true when sync completes
  // Subscriptions cache is refreshed; safe to chain a subscriber-targeted presentation
} on PlatformException catch (e) {
  print('Synchronize failed: ${e.message}');
}
```

### Removed: native subscriptions & cancellation survey UI

The built-in subscription management and cancellation survey UI was **removed** from the 6.0 native SDKs on both platforms:

* `Purchasely.presentSubscriptions()` is **removed entirely** from the Flutter API (Dart, iOS, Android). It is no longer a no-op — the method no longer exists. There is no drop-in replacement.
* `Purchasely.displaySubscriptionCancellationInstruction()` is **removed** too.

Build your own subscriptions screen from the data APIs that remain:

```dart
final active = await Purchasely.userSubscriptions();         // active subscriptions
final history = await Purchasely.userSubscriptionsHistory(); // expired subscriptions
```

### What stays the same

Only the paywall surface (start, display / preload / close / back, the action interceptor, default dismiss handler) has breaking API changes. Every other `Purchasely.*` method remains source-compatible except the removed v5 aliases:

* **Purchases**: `purchaseWithPlanVendorId`, `signPromotionalOffer`.
* **Restore**: `restoreAllProducts`, `silentRestoreAllProducts`, `userDidConsumeSubscriptionContent`.
* **Identity**: `userLogin`, `userLogout`, `isAnonymous`, `anonymousUserId`.
* **Catalog**: `allProducts`, `productWithIdentifier`, `planWithIdentifier`, `isEligibleForIntroOffer`.
* **Subscriptions data**: `userSubscriptions`, `userSubscriptionsHistory`.
* **User attributes**: `setUserAttributeWithString` / `WithInt` / `WithDouble` / `WithBoolean` / `WithDate` / `WithStringArray` / `WithIntArray` / `WithDoubleArray` / `WithBooleanArray`, `incrementUserAttribute`, `decrementUserAttribute`, `userAttribute`, `userAttributes`, `clearUserAttribute`, `clearUserAttributes`, `clearBuiltInAttributes`, `setAttribute`, `setUserAttributeListener` / `clearUserAttributeListener`.
* **Events**: `listenToEvents` / `stopListeningToEvents`, `listenToPurchases` / `stopListeningToPurchases`.
* **Dynamic offerings**: `setDynamicOffering`, `getDynamicOfferings`, `removeDynamicOffering`, `clearDynamicOfferings`.
* **Consent**: `revokeDataProcessingConsent`.
* **Config / misc**: `setLanguage`, `setThemeMode`, `setLogLevel`, `synchronize` (new signature — see above), `allowDeeplink`, `allowCampaigns`, `handleDeeplink`, `setDebugMode`.

***

## New in v6: Apple commitment plans (iOS 26.4+)

v6 surfaces Apple's "monthly subscription with N-month commitment" (installment) billing. **This is Apple-only**: on Android and other platforms the fields below are always empty / `null`, so guard on them before use.

* `PLYPlan.commitmentInfo` — `List<PLYCommitmentInfo>` (empty when the plan has no commitment). Populated wherever a plan is exposed: `allProducts`, `planWithIdentifier`, the `purchase` interceptor payload, and the presentation outcome plan. Each `PLYCommitmentInfo` carries: `billingPlanType` (`PLYBillingPlanType`: `unspecified` / `upFront` / `monthly`), `billingPrice` (`double?`), `billingPeriod` (ISO 8601 duration, e.g. `"P1M"`), `totalPrice` (`double?`), `totalPeriod` (e.g. `"P1Y"`), `totalDuration` (`int?`, number of billing cycles).
* `PLYSubscription.commitmentProgress` — `PLYCommitmentProgress?` on `userSubscriptions()` / `userSubscriptionsHistory()` results: `billingPeriodNumber` (`int?`), `totalBillingPeriods` (`int?`), `commitmentExpiresDate` (ISO 8601 `String?`), `commitmentPrice` (`double?`).
* `PLYDynamicOffering` gains an optional `billingPlanType` (`PLYBillingPlanType`, defaults to `unspecified`) to force a commitment plan type when calling `setDynamicOffering`.

```dart
final plan = await Purchasely.planWithIdentifier('my_plan');
for (final c in plan?.commitmentInfo ?? const []) {
  print('${c.billingPlanType}: ${c.billingPrice} every ${c.billingPeriod}, '
      'total ${c.totalPrice} over ${c.totalDuration} cycles');
}

// Force the monthly-commitment variant of a plan in a placement:
await Purchasely.setDynamicOffering(
  PLYDynamicOffering('ref', 'my_plan', null, PLYBillingPlanType.monthly),
);
```

***

## Removed APIs

| v5 API (removed) | v6 replacement |
|------------------|----------------|
| `Purchasely.start(apiKey: …, androidStores: …, storeKit1: …, logLevel: …, runningMode: …, userId: …)` | `Purchasely.apiKey('…').appUserId(userId).runningMode(PLYRunningMode.full).logLevel(PLYLogLevel.error).stores([PLYStore.google]).storekitVersion(PLYStorekitVersion.storeKit2).start()` |
| `Purchasely.fetchPresentation(placementId: id)` | `PLYPresentationBuilder.placement(id).build().preload()` |
| `Purchasely.presentPresentationForPlacement(id, isFullscreen: …)` | `PLYPresentationBuilder.placement(id).build().display(const PLYTransition.fullScreen())` |
| `Purchasely.presentPresentationWithIdentifier(presentationId, …)` | `PLYPresentationBuilder.screen(id).build().display(const PLYTransition.modal())` |
| `Purchasely.presentPresentation(presentation)` | preload then display the same request: `final req = PLYPresentationBuilder.placement(id).build(); await req.preload(); await req.display();` |
| `Purchasely.presentProductWithIdentifier(productId, …)` | `PLYPresentationBuilder.screen(id).contentId(contentId).build().display()` |
| `Purchasely.presentPlanWithIdentifier(planId, …)` | `PLYPresentationBuilder.screen(id).build().display()` |
| `Purchasely.getPresentationView(...)` | the `PLYPresentationView(request: …)` widget |
| `Purchasely.closePresentation()` / `hidePresentation()` | `presentation.close()` (on the loaded `PLYPresentation`) |
| `Purchasely.showPresentation()` | `presentation.display()` (on the loaded `PLYPresentation`) |
| `Purchasely.setDefaultPresentationResultHandler(cb)` / `setDefaultPresentationResultCallback(cb)` | `Purchasely.setDefaultPresentationDismissHandler((outcome) => …)` |
| `Purchasely.setPaywallActionInterceptorCallback(cb)` + `Purchasely.onProcessAction(bool)` | `Purchasely.interceptAction(kind, handler)` returning `PLYInterceptResult` |
| `Purchasely.readyToOpenDeeplink(bool)` | `Purchasely.allowDeeplink(bool)` |
| `Purchasely.isDeeplinkHandled(deeplink)` | `Purchasely.handleDeeplink(deeplink)` |
| `Purchasely.presentSubscriptions()` | none — build your own from `userSubscriptions()` / `userSubscriptionsHistory()` |
| `Purchasely.displaySubscriptionCancellationInstruction()` | none |
| `PLYRunningMode.transactionOnly` / `PLYRunningMode.paywallObserver` | none — only `observer` and `full` remain |
| `Transition.heightPercentage` | `PLYTransitionDimension.percentage(…)` / `.pixel(…)` on `PLYTransition.drawer` / `.popin` |

> 📘 `Purchasely.clientPresentationDisplayed(presentation)` and `Purchasely.clientPresentationClosed(presentation)` are **kept with the same names** — pass the `PLYPresentation` returned by `preload()` (type `PLYPresentationType.client`).

***

## Migration checklist

* [ ] Pin `purchasely_flutter` / `purchasely_google` / `purchasely_android_player` to `6.0.0` and run `flutter pub get`
* [ ] Bump host builds: Android `minSdk 23` / `compileSdk 36`, iOS deployment target `13.4`
* [ ] Replace `Purchasely.start(apiKey: …)` with `Purchasely.apiKey('…').…start()`
* [ ] If you use Full mode, add explicit `.runningMode(PLYRunningMode.full)` — the default changed to `observer` ⚠️
* [ ] Remove `PLYRunningMode.transactionOnly` / `PLYRunningMode.paywallObserver` — only `observer` and `full` remain
* [ ] Replace `storeKit1: bool` with `.storekitVersion(PLYStorekitVersion.…)` and `androidStores: [...]` with `.stores([PLYStore.…])`
* [ ] Rename v5 types: `PresentPresentationResult` → `PLYPresentationOutcome`, `PLYPaywallAction` → `PLYPresentationActionKind`, `PLYPaywallInfo` → `PLYInterceptorInfo`, `PLYPaywallActionParameters` → `PLYActionPayload`
* [ ] Replace `setPaywallActionInterceptorCallback` + `onProcessAction` with per-kind `Purchasely.interceptAction(kind, handler)` returning `PLYInterceptResult`
* [ ] Replace `presentPresentationForPlacement` / `presentPresentationWithIdentifier` / `presentProductWithIdentifier` / `presentPlanWithIdentifier` / `fetchPresentation` with `PLYPresentationBuilder.…build().display()` / `.preload()`
* [ ] Read display results from the 5-field `PLYPresentationOutcome` (resolved at dismiss)
* [ ] Replace `closePresentation()` / `hidePresentation()` / `showPresentation()` with `presentation.close()` / `presentation.display()`
* [ ] Replace `Transition(…, heightPercentage: x)` with `PLYTransition.drawer(height: PLYTransitionDimension.percentage(x))`
* [ ] Replace `getPresentationView(...)` with the `PLYPresentationView(request: …)` widget
* [ ] Replace `readyToOpenDeeplink(bool)` with `allowDeeplink(bool)` and `isDeeplinkHandled(uri)` with `handleDeeplink(uri)` (v5 names removed)
* [ ] Replace `setDefaultPresentationResultHandler(cb)` with `setDefaultPresentationDismissHandler(cb)` and check the outcome routing (`await` / `onDismissed` / global)
* [ ] Update `synchronize()` call sites: it now returns `Future<bool>` and throws a `PlatformException` on failure
* [ ] Remove `presentSubscriptions()` / `displaySubscriptionCancellationInstruction()` — build your own UI from `userSubscriptions()` / `userSubscriptionsHistory()`
* [ ] Migrate `intro*` plan helpers to the `offer*` equivalents (`intro*` kept as deprecated aliases)
* [ ] Verify: init resolves `true`, a placement and a screen presentation display, the outcome carries the expected `purchaseResult` / `closeReason`, and in Observer mode your `purchase` / `restore` interceptors resolve a `PLYInterceptResult` exactly once

***

## Need a hand?

The Purchasely AI plugin and the `purchasely-integrate`, `purchasely-review` and `purchasely-debug` skills can scan your project and rewrite the old paywall calls to the new builder API. Point them at the files that call `Purchasely.start(...)`, `presentPresentationForPlacement(...)`, `fetchPresentation(...)`, `setPaywallActionInterceptorCallback(...)`, etc.
