# Purchasely Flutter SDK Documentation

This guide covers the Purchasely Flutter SDK **v6** (`6.0.0`) for Dart apps. The plugin bridges to the Purchasely 6.0 native SDKs (iOS `Purchasely 6.1.0`, Android `io.purchasely:core 6.1.0`) and displays **Presentations** (Screens / paywalls) configured in the Console through placements, direct `screen` lookups, campaigns, deeplinks and Flows.

> 📘 SDK v6 — what changed
>
> v6 is a major release with breaking changes on the **paywall surface only**: **starting the SDK**, **displaying / preloading / closing a presentation**, and the **action interceptor**. Everything else on the `Purchasely` class — purchases, restore, identity, catalog, subscriptions, user attributes, events, dynamic offerings, consent and config — remains source-compatible. Deeplinks use the v6 names (`allowDeeplink`, `handleDeeplink`); the old v5 names were removed.
>
> The most impactful change for new integrations is that the **default running mode is now `PLYRunningMode.observer`** (it was Full in v5). If you want Purchasely to handle and validate purchases, set `.runningMode(PLYRunningMode.full)` explicitly. See [SDK Initialization](#sdk-initialization).

---

## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
3. [SDK Initialization](#sdk-initialization)
4. [Displaying Paywalls](#displaying-paywalls)
5. [Processing Transactions](#processing-transactions)
6. [Action Interceptor](#action-interceptor)
7. [User Identification](#user-identification)
8. [Subscription Status & Entitlements](#subscription-status--entitlements)
9. [Custom User Attributes](#custom-user-attributes)
10. [Event Listeners](#event-listeners)
11. [Pre-fetching Screens](#pre-fetching-screens)
12. [Deeplinks Management](#deeplinks-management)
13. [Platform-Specific Features](#platform-specific-features)
14. [Troubleshooting](#troubleshooting)
15. [Additional Resources](#additional-resources)

---

## Requirements

| Requirement | iOS | Android |
|-------------|-----|---------|
| Minimum OS Version | 13.4 | 23 (minSdkVersion) |
| compileSdkVersion | - | 36 |
| targetSdkVersion | - | 35 |

---

## Installation

We rely on [pub.dev](https://pub.dev/packages/purchasely_flutter) to distribute the Flutter SDK.

### Main Dependency

Pin the Purchasely Flutter SDK to the exact version:

```shell
flutter pub add purchasely_flutter:6.0.0
```

Don't forget to change the minimum OS versions to match Purchasely requirements (iOS 13.4 / Android minSdk 23).

### iOS Setup

Update your Podfile to set the minimum iOS version:

```ruby
# Podfile

...

platform :ios, '13.4'

...
```

Then run:

```shell
cd ios && pod install
```

The iOS native dependency (`Purchasely 6.1.0`) is published on the CocoaPods trunk, so it resolves from the public repositories with no extra configuration.

### Android Setup

Update your `android/build.gradle` file:

```groovy
// Edit file android/build.gradle
buildscript {
    ext {
        minSdkVersion = 23 //min version must not be below 23
        compileSdkVersion = 36
        targetSdkVersion = 35
    }
}

allprojects {
    repositories {
        mavenCentral()
    }
}
```

The Android native dependencies (`io.purchasely:core` / `google-play` / `player` `6.1.0`) are published on **Maven Central**, so they resolve from the public repositories with no `mavenLocal()`.

### Android Dependencies

> ⚠️ **Important**: The main Purchasely SDK (`purchasely_flutter`) does **NOT** include store implementations by default. This modular architecture lets you include only the stores you need and avoids dependency conflicts.

With Android, you can choose to use Google Play Store and/or Huawei AppGallery and/or Amazon Appstore. **You must install the corresponding dependency for each store you want to support.**

#### Google Play Billing (Required for Google Play Store)

If your app is distributed on the **Google Play Store**, you **must** install the Google Play Billing dependency:

```shell
flutter pub add purchasely_google:6.0.0
```

**Why is this required?**
- The Purchasely core SDK does not include the Google Play Billing library
- When you pass `.stores([PLYStore.google])` at initialization, the SDK looks for this dependency at runtime
- Without this dependency, purchases will not work on Android devices using Google Play Store
- The app may crash or fail to initialize properly on Android

> ⚠️ **Google Play Billing v8** — the `purchasely_google` artifact pulls in Google Play Billing Client v8. If you also depend on Google Play Billing directly, do not force an older billing dependency into your project.

#### Video Player (Required for Video Paywalls)

If your paywalls contain videos, you **must** install the Android video player dependency:

```shell
flutter pub add purchasely_android_player:6.0.0
```

**Why is this required?**
- The core SDK does not include a video player to avoid conflicts with other media libraries you may have (e.g., Media3/ExoPlayer)
- Without this dependency, videos in paywalls will not play on Android
- The external player is detected and handled automatically by the SDK

#### Version Matching (Critical)

> ⚠️ **All Purchasely packages must be pinned to the exact same version.** Mismatched versions cause runtime errors. Pin each package to `6.0.0` — do **not** use a floating range (`^6.0.0`, `5.+`, …).

```yaml
# pubspec.yaml
dependencies:
  purchasely_flutter: 6.0.0
  purchasely_google: 6.0.0
  purchasely_android_player: 6.0.0
```

#### Complete Android Installation Example

For a typical app distributed on Google Play Store with video paywalls:

```shell
# Install all required dependencies (same exact version)
flutter pub add purchasely_flutter:6.0.0
flutter pub add purchasely_google:6.0.0
flutter pub add purchasely_android_player:6.0.0
```

Then initialize with the Google store:

```dart
final bool configured = await Purchasely.apiKey('<<X-API-KEY>>')
    .runningMode(PLYRunningMode.full)
    .logLevel(PLYLogLevel.error)
    .stores([PLYStore.google]) // requires the purchasely_google package at the same version
    .storekitVersion(PLYStorekitVersion.storeKit2) // iOS only: storeKit2 (default) | storeKit1
    .start();
```

---

## SDK Initialization

In v6 the SDK is started with the fluent **`PurchaselyBuilder`**. The old `Purchasely.start(...)` method and the `PLYRunningMode` / `PLYLogLevel` enums (and the `storeKit1: true/false` boolean) have been **removed**.

Initialize the Purchasely SDK as early as possible in your application lifecycle.

> 🚧 Major v6 change — the default running mode is now `Observer`
>
> In v5 the implicit default was Full. In **v6 the default is `PLYRunningMode.observer`** — Purchasely observes transactions but your app keeps control of the purchase flow. **If you want Purchasely to handle the purchase flow and validate receipts, set `.runningMode(PLYRunningMode.full)` explicitly.** A behavioral consequence: in observer mode, presentations no longer auto-close after a purchase or restore — dismiss them yourself.

### Full Mode (Purchasely handles purchases)

In `PLYRunningMode.full`, Purchasely handles the entire purchase flow including transactions and receipts.

```dart
import 'package:purchasely_flutter/purchasely_flutter.dart';

// Everything is optional except the apiKey
// Example with default values
final bool configured = await Purchasely.apiKey('<<X-API-KEY>>')
    .appUserId(null)                              // optional if you already know your user id
    .runningMode(PLYRunningMode.full)             // PLYRunningMode.observer (default) | full
    .logLevel(PLYLogLevel.error)                  // set to PLYLogLevel.debug in development to see logs
    .stores([PLYStore.google])                    // Android only: google | huawei | amazon
    .storekitVersion(PLYStorekitVersion.storeKit2) // iOS only: storeKit2 (default) | storeKit1
    .allowDeeplink(true)                          // allow the SDK to open deeplinks (default true)
    .allowCampaigns(true)                         // independent campaign display gate (default true)
    .start();

if (!configured) {
  print('Purchasely SDK not configured');
  return;
}

print('Purchasely SDK configured successfully');
```

### Observer Mode (your app owns purchases)

Use `PLYRunningMode.observer` if you have an existing in-app purchase infrastructure and want to use Purchasely only for paywall display and analytics. This is the **default** mode in v6, so passing it makes the intent explicit.

```dart
final bool configured = await Purchasely.apiKey('<<X-API-KEY>>')
    .appUserId(null)
    .runningMode(PLYRunningMode.observer)          // PLYRunningMode.observer (default) | full
    .logLevel(PLYLogLevel.error)
    .stores([PLYStore.google])
    .storekitVersion(PLYStorekitVersion.storeKit2)
    .start();

if (!configured) {
  print('Purchasely SDK not configured');
  return;
}
```

### Enums

| Enum | Values |
|------|--------|
| `PLYRunningMode` | `observer` (default), `full` |
| `PLYLogLevel` | `debug`, `info`, `warn`, `error` |
| `PLYStorekitVersion` | `storeKit2` (default, iOS), `storeKit1` (iOS) |
| `PLYStore` | `google`, `huawei`, `amazon` (Android) |

### API Key

You can find your API Key in the Purchasely Console under **App settings > Backend & SDK configuration**.

---

## Displaying Paywalls

Purchasely paywalls are **Presentations** displayed using **placements** (a specific location in your app, e.g. onboarding, settings, premium feature) or by direct `screen` id.

`PLYPresentationBuilder.placement(id).build()` returns a **`PLYPresentationRequest`**. Calling `display([PLYTransition])` shows the presentation and resolves at **dismiss** with a `PLYPresentationOutcome`.

### Display a Placement

```dart
final outcome = await PLYPresentationBuilder.placement('ONBOARDING')
    .contentId('my_content_id') // optional
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
// A specific presentation by screen id
await PLYPresentationBuilder.screen('SCREEN_ID').build().display(const PLYTransition.modal());

// A specific content inside a screen
await PLYPresentationBuilder.screen('SCREEN_ID').contentId('CONTENT_ID').build().display();
```

### Selectors

```dart
PLYPresentationBuilder.placement('onboarding'); // by placement id
PLYPresentationBuilder.screen('screen_abc123'); // direct Console Screen lookup
PLYPresentationBuilder.defaultSource();         // default handler for deeplinks / campaigns
```

To display a Flow, use its deeplink `app_scheme://ply/flows/FLOW_ID`.

### Transitions

`display([PLYTransition])` accepts an optional `PLYTransition`:

```dart
const PLYTransition.fullScreen();         // full-screen
const PLYTransition.modal();              // modal sheet
const PLYTransition.modal(dismissible: false);
const PLYTransition.push();               // pushed onto the navigation stack
const PLYTransition.drawer(height: PLYTransitionDimension.percentage(0.5));
const PLYTransition.popin(
  width: PLYTransitionDimension.pixel(320),
  height: PLYTransitionDimension.percentage(0.6),
);
```

`PLYTransitionDimension` accepts `.percentage(value)` (0.0–1.0) or `.pixel(value)`. Leave a dimension `null` to size to content ("hug").

### Display Results

`display([PLYTransition])` resolves with a `PLYPresentationOutcome`:

| Field | Type | Description |
|-------|------|-------------|
| `presentation` | `PLYPresentation?` | The displayed presentation (or `null` if it never reached display) |
| `purchaseResult` | `PLYPurchaseResult?` | `purchased` \| `restored` \| `cancelled` \| `null` |
| `plan` | `PLYPlan?` | The purchased plan (when `purchaseResult` is `purchased` / `restored`) |
| `closeReason` | `PLYCloseReason?` | `button` \| `backSystem` \| `programmatic` (when no purchase) |
| `error` | `PLYPresentationError?` | Display error; mutually exclusive with `closeReason` |

`purchaseResult` is `null` when the user dismissed the screen without a purchase action.

### Presentation lifecycle (display / close / back)

A **loaded** `PLYPresentation` (returned by `preload()`, or from `outcome.presentation`) exposes imperative controls:

```dart
final presentation = await PLYPresentationBuilder.placement('ONBOARDING').build().preload();

presentation.display();  // show (returns a future that resolves at dismiss)
presentation.close();    // dismiss programmatically
presentation.back();     // navigate back inside a multi-step (Flow) presentation
```

> 📘 The v5 imperative methods `closePresentation()`, `closeAllScreens()`, `hidePresentation()`, `showPresentation()` have been **removed**. Use the loaded `PLYPresentation` handle instead.

---

## Processing Transactions

### Full Mode

In `PLYRunningMode.full`, the Purchasely SDK automatically launches the native in-app purchase flow when a user taps a purchase button and handles the transaction. You only need to update entitlements once you have confirmation the purchase was processed.

```dart
try {
  final outcome = await PLYPresentationBuilder.placement('onboarding')
      .build()
      .display(const PLYTransition.fullScreen());

  if (outcome.purchaseResult == PLYPurchaseResult.purchased ||
      outcome.purchaseResult == PLYPurchaseResult.restored) {
    print('User purchased ${outcome.plan?.name}');
    // Update entitlements to unlock the access to the contents
  }
} catch (e) {
  print(e);
}
```

You can also trigger a purchase programmatically (unchanged):

```dart
final plan = await Purchasely.purchaseWithPlanVendorId(
  vendorId: 'PURCHASELY_PLUS_MONTHLY',
);
```

### Observer Mode with Action Interceptor

In `PLYRunningMode.observer`, you handle purchases with your own infrastructure while using Purchasely for paywall display. Register an interceptor for the `purchase` action; the handler returns a `PLYInterceptResult` (there is no more `onProcessAction`). In observer mode the presentation does **not** auto-close, so dismiss it yourself with `info.presentation?.close()`.

```dart
import 'package:flutter/foundation.dart';
import 'package:purchasely_flutter/purchasely_flutter.dart';

await Purchasely.interceptAction(
  PLYPresentationActionKind.purchase,
  (info, payload) async {
    if (payload is! PLYPurchasePayload) {
      return PLYInterceptResult.notHandled;
    }
    try {
      // The store product id (sku) the user tapped on in the presentation
      final storeProductId = payload.plan.productId;

      if (defaultTargetPlatform == TargetPlatform.android) {
        // Only for Android you can retrieve the subscription offer details
        final basePlanId = payload.subscriptionOffer?.basePlanId;
        final offerId = payload.subscriptionOffer?.offerId;
        final offerToken = payload.subscriptionOffer?.offerToken;
      }

      final success = await MyPurchaseSystem.purchase(storeProductId);
      if (success) {
        // SDK auto-synchronizes on success in observer mode
        await info.presentation?.close(); // observer mode: dismiss it yourself
        return PLYInterceptResult.success;
      }
      return PLYInterceptResult.failed;
    } catch (e) {
      print(e);
      return PLYInterceptResult.failed;
    }
  },
);

await Purchasely.interceptAction(
  PLYPresentationActionKind.restore,
  (info, payload) async {
    try {
      await MyPurchaseSystem.restoreAllPurchases();
      // SDK auto-synchronizes on success in observer mode
      await info.presentation?.close();
      return PLYInterceptResult.success;
    } catch (e) {
      // Error restoring purchases
      return PLYInterceptResult.failed;
    }
  },
);
```

> 📘 `synchronize()` now reports completion. The 6.0 native SDKs expose success/error callbacks on `synchronize()`. The Dart `Purchasely.synchronize()` keeps its `Future<void>` signature but now **resolves when the synchronization actually completes** and **throws a `PlatformException` on failure**. `await` it (and optionally `try/catch`) before chaining a follow-up presentation that targets subscribers. Call this manually for transactions completed outside the interceptor (the SDK already auto-syncs when an interceptor returns the success result for a purchase or restore in observer mode).

---

## Action Interceptor

The v6 interceptor is registered **per action kind** with `Purchasely.interceptAction(kind, handler)`. The handler receives a typed payload and returns a `PLYInterceptResult` — there is no more `Purchasely.setPaywallActionInterceptorCallback(...)` or `Purchasely.onProcessAction(bool)`.

### Result values

| Result | Meaning |
|--------|---------|
| `PLYInterceptResult.success` | App handled the action; SDK skips its default behavior. |
| `PLYInterceptResult.failed` | App tried but failed; the action chain stops. |
| `PLYInterceptResult.notHandled` | SDK should continue with its default behavior. |

### Action kinds & payloads

`PLYPresentationActionKind`: `close`, `closeAll`, `login`, `navigate`, `purchase`, `restore`, `openPresentation`, `openPlacement`, `promoCode`, `webCheckout`.

| Action kind | Typed payload |
|-------------|---------------|
| `purchase` | `PLYPurchasePayload` (`plan: PLYPlan`, `subscriptionOffer: PLYSubscriptionOffer?`, `offer: PLYPromoOffer?`) |
| `restore` | — |
| `login` | — |
| `close` | `PLYClosePayload` |
| `closeAll` | `PLYCloseAllPayload` |
| `navigate` | `PLYNavigatePayload` (`url`, `title`) |
| `openPresentation` | `PLYOpenPresentationPayload` |
| `openPlacement` | `PLYOpenPlacementPayload` |
| `promoCode` | — |
| `webCheckout` | `PLYWebCheckoutPayload` |

### Implementation

```dart
import 'package:purchasely_flutter/purchasely_flutter.dart';

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

await Purchasely.interceptAction(
  PLYPresentationActionKind.login,
  (info, payload) async {
    // Present your own screen for the user to log in
    Purchasely.userLogin('MY_USER_ID');
    return PLYInterceptResult.success;
  },
);
```

### Removing interceptors

```dart
await Purchasely.removeActionInterceptor(PLYPresentationActionKind.purchase);
await Purchasely.removeAllActionInterceptors();
```

---

## User Identification

### Anonymous Users

The Purchasely SDK automatically generates and assigns an `anonymous_user_id` to each user, maintaining consistency as long as the app remains installed on the device.

```dart
final anonymousId = await Purchasely.anonymousUserId;
print('Anonymous User ID: $anonymousId');
```

### User Login

To authenticate users and associate purchases with their account:

```dart
final refresh = await Purchasely.userLogin('123456789');
if (refresh) {
  // You should call your backend to refresh user entitlements
  print('User logged in, refresh entitlements');
}
```

You can also provide the user id at initialization with `Purchasely.apiKey('…').appUserId('123456789').start()`.

### User Logout

```dart
// Logout user (clears user id and custom attributes)
Purchasely.userLogout();
```

### Login from Paywall

To handle the login button on a presentation, intercept the `login` action:

```dart
await Purchasely.interceptAction(
  PLYPresentationActionKind.login,
  (info, payload) async {
    // Present your own screen for the user to log in
    Purchasely.userLogin('MY_USER_ID'); // call before returning to update the screen
    return PLYInterceptResult.success;
  },
);
```

---

## Subscription Status & Entitlements

### Retrieve User Subscriptions

Purchasely offers a way to retrieve active subscriptions directly from your mobile app:

```dart
try {
  final List<PLYSubscription> subscriptions = await Purchasely.userSubscriptions();
  if (subscriptions.isNotEmpty) {
    print(subscriptions.first.plan);
    print(subscriptions.first.subscriptionSource);
    print(subscriptions.first.nextRenewalDate);
    print(subscriptions.first.cancelledDate);
  }
} catch (e) {
  print(e);
}
```

Expired subscriptions (the user's history) are available via `Purchasely.userSubscriptionsHistory()` — useful for analytics and engagement strategies.

```dart
final history = await Purchasely.userSubscriptionsHistory();
```

> **Note**: There is a **few seconds delay** for `Purchasely.userSubscriptions()` to be updated after a purchase or restoration. If you rely on this method right after a purchase, **wait for 3 seconds** before calling it.

> 🚧 Removed in v6 — `presentSubscriptions()` (BREAKING)
>
> The native subscriptions screen was removed from the 6.0 SDKs on both platforms, so `Purchasely.presentSubscriptions()` has been **removed entirely** from the Flutter API — the method no longer exists. There is no drop-in replacement: build your own subscriptions screen with `userSubscriptions()` / `userSubscriptionsHistory()`.
>
> The cancellation survey UI was likewise removed, so `Purchasely.displaySubscriptionCancellationInstruction()` has also been **removed** from Flutter v6.

---

## Custom User Attributes

Custom User Attributes allow you to segment users and personalize their journey.

### Supported Types

`String`, `int`, `double`, `bool`, `DateTime`, and arrays of those types.

### Setting Attributes

```dart
Purchasely.setUserAttributeWithString('gender', 'man');
Purchasely.setUserAttributeWithInt('age', 21);
Purchasely.setUserAttributeWithDouble('weight', 78.2);
Purchasely.setUserAttributeWithBoolean('premium', true);
Purchasely.setUserAttributeWithDate('subscription_date', DateTime.now());
Purchasely.setUserAttributeWithStringArray('tags', ['sport', 'news']);
```

### Retrieving Attributes

```dart
// Get all attributes
final attributes = await Purchasely.userAttributes();
print(attributes); // Map of key -> value

// Retrieve a specific attribute (DateTime values are parsed automatically when possible)
final dateAttribute = await Purchasely.userAttribute('subscription_date');
```

### Incrementing / Decrementing Counters

```dart
// Increment a user attribute (created if not set)
Purchasely.incrementUserAttribute('viewed_articles');
Purchasely.incrementUserAttribute('viewed_articles', value: 3);

// Decrement a user attribute
Purchasely.decrementUserAttribute('viewed_articles');
Purchasely.decrementUserAttribute('viewed_articles', value: 7);
```

### Clearing Attributes

```dart
// Remove one attribute
Purchasely.clearUserAttribute('size');

// Remove all attributes
Purchasely.clearUserAttributes();
```

> **Note**: `Purchasely.userLogout()` clears all custom user attributes.

---

## Event Listeners

### UI / SDK Events Listener

When users interact with Purchasely Screens, the SDK triggers events. Implement an event listener to forward these events to your analytics platforms.

```dart
Purchasely.listenToEvents((event) {
  print('Event received: ${event.name}');
  print('Event properties: ${event.properties}');
  // Forward to your analytics platform
});

// Stop listening when no longer needed:
Purchasely.stopListeningToEvents();
```

UI/SDK events are computed by the Purchasely Platform for conversion KPIs but cannot be routed to third-party integrations from the Console — forward them yourself from the app if you need them in your analytics.

### Custom User Attributes Listener

When a user submits answers to a survey configured in the Screen Composer, custom user attributes can be set automatically by the SDK. The `source` parameter tells you whether the change came from Purchasely or from your own app.

```dart
class MyUserAttributeListener implements UserAttributeListener {
  @override
  void onUserAttributeSet(String key, PLYUserAttributeType type, dynamic value,
      PLYUserAttributeSource source) {
    if (source == PLYUserAttributeSource.purchasely) {
      // Process attribute set by Purchasely (e.g., from surveys)
    }
  }

  @override
  void onUserAttributeRemoved(String key, PLYUserAttributeSource source) {}
}

Purchasely.setUserAttributeListener(MyUserAttributeListener());
```

The `PLYUserAttributeSource` enum indicates where the update originated:

- **purchasely**: The change was initiated internally by the Purchasely SDK (e.g., from surveys)
- **client**: The change was triggered directly by your app — you can usually ignore these since your app already has the data

---

## Pre-fetching Screens

Purchasely, by default, shows the paywall screen with a loading indicator while fetching it from the network. Using `PLYPresentationRequest.preload()`, you can pre-fetch the paywall from the network **before** displaying it for a better user experience.

### Benefits

- Display the Screen only after it has been loaded
- Handle network errors gracefully
- Show a custom loading screen
- Pre-load during app navigation

### Implementation

Build a `PLYPresentationRequest`, `preload()` it to fetch the screen from the network, then `display()` the **same** request when you are ready.

```dart
import 'package:purchasely_flutter/purchasely_flutter.dart';

try {
  final request = PLYPresentationBuilder.placement('ONBOARDING').build();

  // Preload resolves once the screen is loaded
  final presentation = await request.preload();

  if (presentation.type == PLYPresentationType.deactivated) {
    // No paywall to display for this placement
    return;
  }
  if (presentation.type == PLYPresentationType.client) {
    // Display your own paywall (BYOS) — plan summaries are in presentation.plans
    return;
  }

  // Display the preloaded presentation; resolves at dismiss
  final outcome = await request.display(const PLYTransition.fullScreen());

  switch (outcome.purchaseResult) {
    case PLYPurchaseResult.cancelled:
      print('User cancelled purchased');
      break;
    case PLYPurchaseResult.purchased:
      print('User purchased ${outcome.plan?.name}');
      break;
    case PLYPurchaseResult.restored:
      print('User restored ${outcome.plan?.name}');
      break;
    case null:
      print('User dismissed: ${outcome.closeReason}');
      break;
  }
} catch (e) {
  print(e);
}
```

You can also chain preload and display in a single expression:

```dart
final outcome = await PLYPresentationBuilder.placement('ONBOARDING')
    .build()
    .preload()
    .display(const PLYTransition.drawer(height: PLYTransitionDimension.percentage(0.5)));
```

### Presentation Types

| Type (`PLYPresentationType`) | Description |
|------------------------------|-------------|
| `normal` | Default Purchasely paywall |
| `fallback` | Fallback paywall (requested one not found) |
| `deactivated` | No paywall for this placement |
| `client` | Your own paywall (BYOS) |

---

## Deeplinks Management

To manage deeplinks you can do up to 3 things:

1. Allow the SDK to open deeplinks (and optionally pass a received deeplink to the SDK)
2. Optionally control when Purchasely is allowed to display content over your interface
3. Set a default presentation dismiss handler to receive the result of the user's action

### Allowing the Display

Deeplink display is allowed via the start builder (it also defaults to `true`):

```dart
await Purchasely.apiKey('<<X-API-KEY>>')
    .allowDeeplink(true)
    .start();
```

### Passing the Deeplink to the SDK

To let the Purchasely SDK analyze a deeplink received by the app, pass it with `handleDeeplink`:

```dart
final handled = await Purchasely.handleDeeplink('app://ply/presentations/');
print('Deeplink handled by Purchasely? $handled');
```

> 📘 `handleDeeplink` replaces the v5 `isDeeplinkHandled` name, which was removed in v6.

### Forbidding the Display

By **default**, Purchasely deeplinks are displayed **immediately** when they are received. To defer them (e.g. during a splash screen, onboarding or login), prevent the display and re-enable it once you are ready:

```dart
// Prevent the display (e.g. while your onboarding is on screen)
Purchasely.allowDeeplink(false);

// Re-enable it once ready — any queued deeplink displays immediately
Purchasely.allowDeeplink(true);
```

Campaigns follow the same principle through `allowCampaigns` (also `true` by default, independent from `allowDeeplink`):
`Purchasely.allowCampaigns(false)` / `Purchasely.allowCampaigns(true)`.

> 📘 `allowDeeplink` replaces the v5 `readyToOpenDeeplink` name, which was removed in v6.

### Setting the Default Presentation Dismiss Handler

When a paywall / screen is opened by the SDK itself (deeplink, campaign, promoted in-app purchase), you don't instantiate it yourself, so no per-display callback fires. Register a default dismiss handler to receive the resulting `PLYPresentationOutcome`:

```dart
await Purchasely.setDefaultPresentationDismissHandler((outcome) {
  print('SDK presentation dismissed: ${outcome.presentation?.screenId} / '
      '${outcome.purchaseResult} / ${outcome.closeReason}');
  if (outcome.plan != null) {
    print('Plan: ${outcome.plan?.name}');
  }
});
```

---

## Platform-Specific Features

### StoreKit Selection (iOS)

Choose between StoreKit 1 and StoreKit 2 for iOS with the `PLYStorekitVersion` enum (this replaces the old `storeKit1: true/false` boolean):

```dart
await Purchasely.apiKey('<<X-API-KEY>>')
    .storekitVersion(PLYStorekitVersion.storeKit2) // storeKit2 (default) | storeKit1
    .start();
```

> **Recommendation**: Use StoreKit 2 (`PLYStorekitVersion.storeKit2`, the default) for new integrations.

### Android Stores

Purchasely supports multiple Android stores via the `PLYStore` enum passed to `.stores([...])`:

```dart
await Purchasely.apiKey('<<X-API-KEY>>')
    .stores([PLYStore.google]) // PLYStore.google | PLYStore.huawei | PLYStore.amazon
    .start();
```

To use multiple stores (the first one available on the device is used):

```dart
.stores([PLYStore.google, PLYStore.huawei])
```

> **Note**: Install the corresponding dependency for each store you want to support, all at the same version.

### Android-Specific Purchase Parameters

When intercepting purchases on Android, you can access additional subscription offer parameters from the typed `PLYSubscriptionOffer?` on `PLYPurchasePayload`:

```dart
if (defaultTargetPlatform == TargetPlatform.android) {
  final basePlanId = payload.subscriptionOffer?.basePlanId;
  final offerId = payload.subscriptionOffer?.offerId;
  final offerToken = payload.subscriptionOffer?.offerToken;
}
```

### Inline (Embedded) Presentations

To render a presentation inline inside your widget tree — as opposed to full-screen / modal — use the `PLYPresentationView` widget with a `PLYPresentationRequest`. The widget preloads the request and hands the resulting presentation to the native inline view.

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

---

## Troubleshooting

### Common Issues

1. **SDK not configured**: Ensure you call `Purchasely.apiKey('…').start()` and that it resolves to `true` before any other SDK methods.

2. **Purchases not validating / paywall does not auto-close after purchase**: You are likely in the new default `Observer` mode. Set `.runningMode(PLYRunningMode.full)` for Purchasely to own the purchase flow. In observer mode, presentations do not auto-close — dismiss them with `info.presentation?.close()`.

3. **Purchases not working on Android**: Verify that you've added `purchasely_google` and that all Purchasely packages are pinned to the exact same version (`6.0.0`).

4. **Paywall not displaying**: Check that:
   - The placement / screen exists in your Purchasely Console
   - The SDK is properly initialized (the `start()` future returned `true`)
   - You have an active internet connection

5. **Observer purchase does not update access**: The SDK auto-syncs when your interceptor returns the success result for a purchase or restore. Call `await Purchasely.synchronize()` manually only for purchases completed outside the interceptor.

6. **iOS pod install issues**: Ensure your iOS deployment target is set to at least **13.4** in your Podfile.

7. **Deeplink does nothing**: Ensure `allowDeeplink` is `true` and, if you defer deeplinks, that you re-enable with `Purchasely.allowDeeplink(true)`.

### Debug Mode

Enable debug logging during development:

```dart
await Purchasely.apiKey('<<X-API-KEY>>')
    .logLevel(PLYLogLevel.debug) // use PLYLogLevel.error in production
    .start();
```

For the full list of v5→v6 breaking changes, see the [Migrating to v6 — Flutter](https://docs.purchasely.com/migrating-from-v5-to-v6-flutter) guide.

---

## Additional Resources

- [Purchasely Console](https://console.purchasely.io)
- [Pub.dev Package](https://pub.dev/packages/purchasely_flutter)
- [Purchasely Documentation](https://docs.purchasely.com)
