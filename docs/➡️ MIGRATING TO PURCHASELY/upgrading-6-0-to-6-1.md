---
title: Upgrading from SDK 6.0 to 6.1
excerpt: >-
  This page provides everything you need to know to upgrade your Purchasely SDK
  integration to 6.1.0, on every platform
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Version 6.1.0 is a minor release of the Purchasely SDK. It is asymmetric: each platform gets a different set of changes.

This page covers every platform. Read the summary table first, then read the section of your platform.

## Who needs to do what

| Platform | Upgrade | Work to do |
| :--- | :--- | :--- |
| iOS | 6.0.1 to 6.1.0 | No breaking change. New APIs, one behaviour change on preview deeplinks, and three added privacy manifest entries. |
| Android | 6.0.2 to 6.1.0 | ONE breaking change, plus new APIs and two transitive dependency bumps. |
| React Native, Flutter, Cordova | None | No bridge release carries the native 6.1.0 yet. Nothing to do. |

***

## iOS

### 1. Check the dependency pin

Most pins need no change:

| Pin | Action |
| :--- | :--- |
| CocoaPods `pod 'Purchasely', '~> 6.0'` | No change. The pin resolves to 6.1.0. |
| SPM `from: "6.0.x"` | No change. Run a package update. |
| CocoaPods `pod 'Purchasely', '6.0.1'` | Edit the version to 6.1.0. |
| SPM `exact: "6.0.1"` or `.upToNextMinor(from:)` | Edit the version to 6.1.0. |

Only an exact pin, or a pin that stops at the next minor version, needs an edit.

### 2. New optional APIs

Both APIs sit on the builder. They are optional, so your current code keeps working.

```swift
Purchasely.apiKey("...")
    .webRedemptionDelegate(self, appHandlesRedemptionAlert: false)
    .appAnonymousUserId(myUUID)                  // taken only if no id exists yet
    .appAnonymousUserId(myUUID, override: true)  // replaces an existing id
    .start()
```

- `webRedemptionDelegate(_:appHandlesRedemptionAlert:)` gives your app the result of a Web2App redemption. See [Web-to-app funnels (redemption)](web2app).
- `appAnonymousUserId(_:)` and `appAnonymousUserId(_:override:)` take a `UUID?`. Pass `nil` to change nothing. The method never clears a stored id.

### 3. Two new events

The SDK now emits `redemptionConsumed` and `redemptionFailed`. If your app switches exhaustively over `PLYEvent`, add the two cases.

### 4. Behaviour change: a preview deeplink

The SDK now treats a deeplink of this shape as a preview:

```text
yourapp://ply/presentations/{id}?preview=1
```

Two things change:

- The SDK fetches through the `presentations/{id}` route, and it forwards the query string.
- The link bypasses the `allowDeeplink` gate.

Before 6.1.0, iOS rendered that link as a live paywall.

<Callout icon="🚧" theme="warn">
  ### Check this if you use `allowDeeplink(false)`

  An app that relied on `allowDeeplink(false)` to block a preview link no longer blocks it. An author who scans a QR code from the Console now gets the screen.
</Callout>

### 5. Privacy manifest

`PrivacyInfo.xcprivacy` now declares three more data types: `PerformanceData`, `OtherDiagnosticData` and `CrashData`. All three carry the `AppFunctionality` purpose. The SDK does not link them to the user, and it does not use them for tracking.

Update your App Store privacy answers if your report copies the SDK manifest. See [SDK diagnostics and observability](sdk-diagnostics-and-observability).

***

## Android

### 1. Bump the dependency

Bump every `io.purchasely:*` artifact to 6.1.0.

### 2. Breaking change: the redemption event payload types are opaque

`PLYRedemptionProperties` and `PLYRedemptionPurchaseContext` are now empty sealed interfaces. The data classes behind them are internal.

Code that read the fields directly no longer compiles, and it is binary incompatible:

```kotlin
// Before 6.1.0. This no longer compiles.
val context = event.properties.redemption?.purchaseContext
```

Read the payload from the event JSON instead:

```kotlin
// From 6.1.0.
val map = event.properties.toMap()
val json = event.properties.toJson()
```

The JSON is unchanged, byte for byte, and the JSON is the documented contract. The two Kotlin types became public only by accident, because Kotlin has no package-private visibility.

### 3. New optional APIs

```kotlin
Purchasely.Builder(context)
    .apiKey("...")
    .webRedemptionListener { result -> }
    .anonymousUserId("YOUR_ID", override = true)
    .proxy(api = "https://your-proxy.example.com")
    .build()
```

- `webRedemptionListener(...)` gives your app the result of a Web2App redemption. See [Web-to-app funnels (redemption)](web2app).
- `anonymousUserId(id, override)` takes a `String`. The value must be a canonical UUID, in either case, with an optional lowercase origin prefix such as `web_<uuid>`. The SDK refuses any other value, logs an error, and keeps its own id. The refusal never stops the initialization, and `override = true` does not force a malformed value through.
- `proxy(api)` routes the API traffic through your own host. Use it when the Purchasely API host is unreachable. The SDK refuses a bad value with a log, and it keeps the default host.

### 4. Two new events

The SDK now emits `REDEMPTION_CONSUMED` and `REDEMPTION_FAILED`.

### 5. Transitive dependency bumps

| Dependency | From | To |
| :--- | :--- | :--- |
| `androidx.media3` | 1.9.1 | 1.11.0 |
| `androidx.constraintlayout` | 2.2.1 | 2.2.2 |

An app that pins either dependency itself must check the bump.

***

## React Native, Flutter and Cordova

No bridge release carries the native 6.1.0 yet. The three bridges expose none of the new native APIs.

The two redemption events are also absent:

- The `PLYEventName` union of React Native does not carry them.
- The `PLYEvent` enum of Flutter does not carry them.

There is nothing to do until a bridge release ships. Purchasely updates this page then.

***

## The manual anonymous user id is not the same API on both platforms

<Callout icon="📘" theme="info">
  ### Read this if one id generator serves both platforms

  The manual anonymous user id shipped with a DIFFERENT API on each platform. The two signatures do not match, and the two platforms do not store the id in the same case. Read the table below before you share an id generator across iOS and Android.
</Callout>

| Point | iOS | Android |
| :--- | :--- | :--- |
| Signature | `appAnonymousUserId(_ value: UUID?, override: Bool)` | `anonymousUserId(anonymousUserId: String, override: Boolean)` |
| Parameter type | `UUID` | `String` |
| An origin prefix such as `web_<uuid>` | Refused by the type | Accepted |
| Stored case | UPPERCASE, because `UUID.uuidString` returns uppercase | As written |

This is the current state of the two APIs. Compare the two ids in the same case. Send the uppercase form from your backend when you compare an id with the iOS value.
