---
title: Google Play Billing v8
excerpt: Gradle fixes when a non-KTX Billing dependency is present
deprecated: false
hidden: false
metadata:
  robots: index
---
<Callout icon="far fa-info" theme="info">
  ### Only applies to SDK 5.X

  This article only applies if you are on SDK 5.X, if you migrated to our SDK 6 you can ignore this article as it integrates this version of Google Play Billing directly
</Callout>

## Symptoms

After migrating to **Google Play Billing 8.x**, some apps may experience that prices are not displayed in Purchasely Screens.

In this situation:

- the SDK initialization fails to retrieve the Google Subscriptions.y
- the blocking call is typically `queryProductDetails()` (Google products fetch)

This prevents all In-App Purchase features from working with Purchasely

***

## Root cause (likely)

This issue can happen when the project includes the dependency:

- `com.android.billingclient:billing` (**non-KTX**)

while the Purchasely SDK relies on:

- `com.android.billingclient:billing-ktx`.

<Callout icon="⚠️" theme="warn">
  We suspect an internal behavior change in **Google Play Billing v8 non-KTX** that can cause a request to hang indefinitely (no success callback, no error callback).
</Callout>

***

## ⚠️ Minimum Purchasely SDK version: 5.4.0

The two fixes below need **`io.purchasely:google-play` 5.4.0 or later**.

Purchasely SDK 5.3.x and earlier call `enablePendingPurchases()` without an argument. Google Play Billing 8 removed this method. The build gives no error, but at run time the SDK throws a `NoSuchMethodError`, the `BillingClient` never connects, and the Screens show no prices. The two fixes below do not correct this. You must update the SDK.

| Purchasely Android SDK | Google Play Billing 8 | Artifact built with Kotlin |
| ---------------------- | --------------------- | -------------------------- |
| 5.3.x and earlier      | ❌ `NoSuchMethodError` at run time | 2.0 |
| 5.4.0                  | ✅ with the fixes below | 2.0 |
| 5.5.x and 5.6.0        | ✅ with the fixes below | 2.1 |
| 5.7.x                  | ✅ with the fixes below | 2.2 |
| 6.x                    | ✅ Billing 8 included   | 2.3 |

An older Kotlin compiler cannot read the metadata of an artifact built with a newer Kotlin version. If your project is on Kotlin 2.0, for example a React Native project before version 0.79, use SDK **5.4.0**.

<Callout icon="far fa-lightbulb" theme="info">
  On React Native, Flutter and Cordova, this version is the version of the native Android artifact. Check which native version your bridge package pins.
</Callout>

## ✅ Fix #1 — Use `billing-ktx` (recommended)

Make sure your app uses the Kotlin variant of Google Play Billing:

```gradle
dependencies {
    implementation("com.android.billingclient:billing-ktx:8.3.0")
}
```

## ✅ Fix #2 — Force Gradle resolution to Billing v8 (workaround)

If another dependency forces billing (non-KTX), you can force dependency resolution to ensure both artifacts are aligned:

```gradle
configurations.all {
    resolutionStrategy {
        force("com.android.billingclient:billing:8.3.0")
        force("com.android.billingclient:billing-ktx:8.3.0")
    }
}
```

If the issue persists after applying these fixes, please contact our support team with:

- Purchasely SDK version
- Google Play Billing version
- a list of dependencies bringing Billing into the project (e.g., RevenueCat)

<br />
