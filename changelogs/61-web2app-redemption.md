---
title: 6.1 - Web2App Redemption
author: Kevin Herembourg
hidden: false
metadata:
  robots: noindex
published_at: '2026-09-07T07:00:00.000Z'
type: added
---
Purchasely SDK 6.1.0 is a minor release that opens the web-to-app funnel to your app, lets you own the anonymous user id, and routes API traffic through a proxy where Purchasely API is unreachable.

This version also adds two redemption analytics events and, on iOS, an opt-in diagnostics channel that lets Purchasely support find the cause of a paywall problem without a reproduction.

## Highlights

- Web-to-app funnel redemption callback
- Two new redemption analytics events
- Set your own anonymous user id
- Purchasely API proxy for regions such as mainland China

***

## Version per platform

Detailed changelogs are available on each platform's GitHub repository:

| Platform         | SDK Version                                                            |
| :--------------- | :--------------------------------------------------------------------- |
| **iOS**          | [6.1.0](https://github.com/Purchasely/Purchasely-iOS/releases)         |
| **Android**      | [6.1.0](https://github.com/Purchasely/Purchasely-Android/releases)     |
| **Flutter**      | [6.1.0](https://github.com/Purchasely/Purchasely-Flutter/releases)     |
| **React Native** | [6.1.0](https://github.com/Purchasely/Purchasely-ReactNative/releases) |
| **Cordova**      | [6.1.0](https://github.com/Purchasely/Purchasely-Cordova/releases)     |

***

# 🚀 Features

## 🌐 Web-to-App Funnel Redemption

A user buys a subscription on the web, taps the link in the confirmation email, and lands in your app. The SDK now reports the result of that redemption to your app, and lets your app draw the result screen instead of the built-in alert.

Register the listener **before** `start()`. A redemption can settle during `start()`, from a cold start that the link itself triggered, or from a token that a previous launch left pending.

<Tabs>
  <Tab title="iOS">
    ```swift
    try await Purchasely
        .apiKey("YOUR_API_KEY")
        .webRedemptionDelegate(self, appHandlesRedemptionAlert: false)
        .start()
    ```
  </Tab>

  <Tab title="Android">
    ```kotlin
    Purchasely.Builder(applicationContext)
        .apiKey("YOUR_API_KEY")
        .webRedemptionListener(appHandlesRedemptionAlert = false) { result -> }
        .build()

    Purchasely.start { error -> }
    ```
  </Tab>
</Tabs>

The SDK calls your listener on the main thread, exactly once per settled redemption. Set `appHandlesRedemptionAlert` to `true` alert and show your own screen.

A successful redemption also restores the built-in and custom user attributes from the web funnel, before the entitlements refrd every audience already sees them.

Two rules are worth knowing:

- A redemption deeplink is **not** subject to `allowDeeplink`. A user who taps the link in their email always gets their subscr
- On iOS, when a link has expired, `errorMessage` can contain a masked email address, so you can tell the user where the fresh link went. Show it to the user. Do not forward it to your analytics.

New page: [Web-to-app funnels (redemption)](doc:web2app)

## 📊 Two New Redemption Events

`REDEMPTION_CONSUMED` and `REDEMPTION_FAILED`. Neither event existed before 6.1.0.

Both platforms also emit `REDEMPTION_CONSUMED` when a user re-taps a link that was already redeemed. A replay is a success, and the `replay` flag tells the two cases apart.

If your app switches exhaustively over the event type, add the two cases.

Reference: [UI and SDK events](doc:ui-sdk-events-list)

## 🆔 Set Your Own Anonymous User ID

Give Purchasely the anonymous id your app already uses, so both systems report the same person. Both platforms take a `UUID` and store it uppercase, so the same id produces the same value on iOS and on Android.

**First launch, or any device that holds no anonymous id yet.** Pass the id. The SDK applies it at `start()`.

<Tabs>
  <Tab title="iOS">
    ```swift
    try await Purchasely
        .apiKey("YOUR_API_KEY")
        .appAnonymousUserId(myUUID)
        .start()
    ```
  </Tab>

  <Tab title="Android">
    ```kotlin
    Purchasely.Builder(applicationContext)
        .apiKey("YOUR_API_KEY")
        .anonymousUserId(myUuid)
        .build()
    ```
  </Tab>
</Tabs>

**Device that already holds an anonymous id.** Add the `override` parameter. Without it, the SDK keeps the stored id and ignores your value.

<Tabs>
  <Tab title="iOS">
    ```swift
    try await Purchasely
        .apiKey("YOUR_API_KEY")
        .appAnonymousUserId(myUUID, override: true)
        .start()
    ```
  </Tab>

  <Tab title="Android">
    ```kotlin
    Purchasely.Builder(applicationContext)
        .apiKey("YOUR_API_KEY")
        .anonymousUserId(myUuid, override = true)
        .build()
    ```
  </Tab>
</Tabs>

<Callout icon="⚠️" theme="warn">
  ### `override: true` splits the user history.

  An app that updates from 6.0 or from 5.x already holds an anonymous id that the SDK generated. On that install, the plain cal

  When you pass `override: true`, the backend keeps every event, purchase and subscription recorded against the previous id. Thtwo identities, so the device loses access to the earlier history. The SDK logs a warning each time the flag replaces a storedid.
</Callout>

Neither platform offers a setter. Identity is part of the initialization, by design.

## 🌏 API Proxy

**iOS and Android.** Route Purchasely API traffic through a proxy when `api.purchasely.io` is unreachable, for example in mainland China, where the paywall host and the tracking host stay reachable. Purchasely operates a proxy at `https://svc.purchasely.io`, and you can host your own.

<Tabs>
  <Tab title="iOS">
    ```swift
    // Purchasely's own proxy
    try await Purchasely
        .apiKey("YOUR_API_KEY")
        .proxy()
        .start()

    // Your own proxy
    try await Purchasely
        .apiKey("YOUR_API_KEY")
        .proxy(api: URL(string: "https://svc.purchasely.io")!)
        .start()
    ```
  </Tab>

  <Tab title="Android">
    ```kotlin
    Purchasely.Builder(applicationContext)
        .apiKey("YOUR_API_KEY")
        .proxy(api = "https://svc.purchasely.io")
        .build()
    ```
  </Tab>
</Tabs>

The SDK overrides the API host only. This setting does not affect the paywall host or the tracking host.

The value must be an `https` base URL with a host, and carry no query, no fragment and no credentials. The SDK refuses any other value with an error log and keeps the production host, so a misconfiguration never breaks the SDK.

The setting applies at `start()`. Neither platform offers a runtime setter.

<Callout icon="⚠️" theme="warn">
  ### `proxy()` with no argument does not mean the same thing on the two platforms.

  On iOS, `proxy()` selects Purchasely's own proxy at `https://svc.purchasely.io`. On Android, `proxy()` passes `api = null`, which clears the proxy and routes back to `api.purchasely.io`.

  Pass the host explicitly on both platforms to avoid the ambiguity.
</Callout>

***

# 🍎 iOS

## ✨ Features & Improvements

- Web-to-app redemption delegate, with `appHandlesRedemptionAlert` to draw your own result screen
- `REDEMPTION_CONSUMED` and `REDEMPTION_FAILED` analytics events
- `appAnonymousUserId(_:)` and `appAnonymousUserId(_:override:)` on the initialization builder
- User attributes from the web funnel restored on a successful redemption
- SDK diagnostics: traces, logs and MetricKit crash reports, off by default and enabled remotely by Purchasely

## ⚠️ Action Required

`PrivacyInfo.xcprivacy` now declares three more data types: performance data, other diagnostic data, and crash data. All three \` purpose. None is linked to the user, and none is used for tracking.

Update your App Store privacy answers if your report copies the SDK privacy manifest.

## 🐛 Fixes & Reliability

- A cancelled web checkout no longer wedges the action queue. Before the fix, every later tap on the paywall did nothing.
- A flow delivers its shared outcome once, from the step that closed it.
- A close action ends itself instead of waiting on the outcome delivery.
- A deeplink no longer strands the queue when the screen has no product.
- The renderer no longer degrades the paywall through Auto Layout constraint churn, which could make a paywall slow and then un
- Closing a paywall closes only that paywall, not the whole SDK window.
- The host key window is restored without a change to `isHidden`, which removes the black frame at the end of a dismissal.
- An analytics event keeps its nested object properties.

***

# 🤖 Android

## ✨ Features & Improvements

- Web-to-app redemption listener, with `appHandlesRedemptionAlert` to draw your own result screen
- `REDEMPTION_CONSUMED` and `REDEMPTION_FAILED` analytics events
- `anonymousUserId(id, override)` on the `Builder` and on the Kotlin DSL
- User attributes from the web funnel restored on a successful redemption
- `proxy(api:)` on the `Builder` and on the Kotlin DSL, to route API traffic through a proxy

## 🐛 Fixes & Reliability

- `Purchasely.start(callback)` always invokes its callback exactly once. Four paths could return without a result, or invoke the callback twice. An app that gated its UI on that callback could wait forever.
- The redemption listener reports when the user dismisses the outcome alert, not before it.