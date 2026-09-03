---
title: 6.1 - Web2App Redemption
author: Kevin Herembourg
hidden: true
published_at: '2026-09-03T12:04:45.750Z'
type: added
---
SDK 6.1.0 is available for iOS and Android. It replaces iOS 6.0.1 and Android 6.0.2.

This release is asymmetric. Each entry says which platform it applies to.

## Web-to-app funnels

### Redemption callback

**iOS and Android.** A user buys a subscription on the web, taps the link in their email, and lands in your app. The SDK now tells your app the result, and lets your app draw the result screen instead of the built-in alert.

```swift iOS
Purchasely.apiKey("...")
    .webRedemptionDelegate(self, appHandlesRedemptionAlert: false)
    .start()
```

```kotlin Android
Purchasely.Builder(context)
    .apiKey("...")
    .webRedemptionListener(appHandlesRedemptionAlert = false) { result -> }
    .build()
```

The SDK calls you on the main thread, exactly once per settled redemption. Set `appHandlesRedemptionAlert` to `true` to suppress the built-in alert and show your own screen.

A successful redemption can also restore the built-in and custom user attributes from the web funnel, before the entitlements refresh, so every later event and every audience already sees them.

Two things worth knowing, both documented on the new page:

- A redemption deeplink is **not** subject to `allowDeeplink`. A user who taps a link in their email always gets their subscription.
- On iOS, when a link has expired the `errorMessage` can contain a masked email address, so you can tell the user where the fresh link went. Show it to the user; do not forward it to your analytics.

New page: [Web-to-app funnels (redemption)](doc:web2app)

### Two new analytics events

**iOS and Android.** `REDEMPTION_CONSUMED` and `REDEMPTION_FAILED`. Neither existed before 6.1.0 on either platform. Both platforms also emit the consumed event when a user re-taps an already-redeemed link: a replay is a success, and the `replay` flag tells the two apart.

If your app switches exhaustively over the event type, add the two cases.

Reference: [UI and SDK events](doc:ui-sdk-events-list)

## Set the anonymous user id yourself

**iOS and Android.** Give Purchasely the anonymous id your app already uses, so both systems report the same person. The SDK applies it at start, and only when the device holds no anonymous id yet.

```swift iOS
Purchasely.apiKey("...")
    .appAnonymousUserId(myUUID)
    .start()
```

```kotlin Android
Purchasely.Builder(context)
    .apiKey("...")
    .anonymousUserId(myUuid)
    .build()
```

Both platforms take a UUID, and both store it uppercase, so the same id produces the same value on iOS and on Android. Use the `override` form to replace an id that already exists. Neither platform offers a setter: identity is part of the initialization.

## Route the API traffic through a proxy

Use it when `api.purchasely.io` is unreachable, for example in mainland China. Purchasely operates a proxy, and you can host your own.

```kotlin Android
Purchasely.Builder(context)
    .apiKey("...")
    .proxy(api = "https://svc.purchasely.io")
    .build()
```

Only `https` is accepted. A bad value is refused with a log, and the SDK keeps the production host. `paywall.purchasely.io` and `tracking.purchasely.io` always stay on production.

## SDK diagnostics

**iOS only in 6.1.0.** The iOS SDK can now report its own traces, logs and crashes to Purchasely, so our support team can find the cause of a paywall problem in your app without asking you for a reproduction.

- Crash detection uses MetricKit and installs **no** crash handler, so it never interferes with Crashlytics, Sentry or any other crash reporter in your app. It reports only a crash the SDK caused.
- It is off by default. Purchasely enables it per app, per build environment and per signal family. There is no SDK API to turn it on, and we can turn it off remotely with no release on your side.
- The SDK sends no personal data, and free text from a crash report is sanitized.

**Action for iOS apps:** `PrivacyInfo.xcprivacy` now declares three more data types, all with the `AppFunctionality` purpose, neither linked to the user nor used for tracking: performance data, other diagnostic data, and crash data. Update your App Store privacy answers if your report copies the SDK manifest.

This collection falls under Processing #1 of the Data Processing Register, so it is not revocable through the consent API.

New page: [SDK diagnostics and observability](doc:sdk-diagnostics-and-observability)

## Fixes

**iOS**

- A cancelled web checkout no longer wedges the action queue. Before the fix, every later tap on the paywall did nothing.
- A flow delivers its shared outcome once, from the step that closed it.
- A close action ends itself instead of waiting on the outcome delivery.
- A deeplink no longer strands the queue when the screen has no product.
- The renderer no longer degrades the paywall through Auto Layout constraint churn, which could make a paywall slow and then unresponsive.
- Closing a paywall closes only that paywall, not the whole SDK window.
- The host key window is restored without a change to `isHidden`, which removes the black frame at the end of a dismissal.
- An analytics event keeps its nested object properties. Before the fix, the SDK dropped them.

**Android**

- `Purchasely.start(callback)` always invokes its callback exactly once. Four paths could return without a result, or invoke the callback twice. An app that gated its UI on that callback could wait forever.
- The redemption listener reports when the user dismisses the outcome alert, not before it.

## Dependencies

**Android.** `androidx.media3` 1.9.1 to 1.11.0, and `androidx.constraintlayout` 2.2.1 to 2.2.2. An app that pins either one itself should check the bump.

## Upgrading

Full steps for every platform, including React Native, Flutter and Cordova: [Upgrading from SDK 6.0 to 6.1](doc:upgrading-6-0-to-6-1)