---
title: Google Play Billing v8
excerpt: Gradle fixes when a non-KTX Billing dependency is present
deprecated: false
hidden: false
metadata:
  robots: index
---
## Symptoms

After migrating to **Google Play Billing 8.x**, some apps may experience that prices are not displayed in Purchasely Screens.

In this situation:

* the SDK initialization fails to retrieve the Google Subscriptions.y
* the blocking call is typically `queryProductDetails()` (Google products fetch)

This prevents all In-App Purchase features from working with Purchasely

***

## Root cause (likely)

This issue can happen when the project includes the dependency:

* `com.android.billingclient:billing` (**non-KTX**)

while the Purchasely SDK relies on:

* `com.android.billingclient:billing-ktx`.

<Callout icon="⚠️" theme="warn">
  We suspect an internal behavior change in **Google Play Billing v8 non-KTX** that can cause a request to hang indefinitely (no success callback, no error callback).
</Callout>

***

## ⚠️ Requirements for these fixes

Two conditions are necessary. Both are independent of your own code.

### 1. Purchasely SDK 5.4.0 or later

Purchasely SDK 5.3.x and earlier call `enablePendingPurchases()` without an argument. Google Play Billing 8 removed this method. The build gives no error. At run time the SDK throws a `NoSuchMethodError`, the `BillingClient` never connects, and the Screens show no prices.

### 2. A Kotlin 2.1 compiler or later in your project

Google Play Billing 8 is compiled with Kotlin metadata 2.2, and it brings `kotlin-stdlib` 2.2. A Kotlin 2.0 compiler refuses these artifacts:

```
Module was compiled with an incompatible version of Kotlin.
The binary version of its metadata is 2.2.0, expected version is 2.0.0.
```

This second condition comes from Google Play Billing. No Purchasely version removes it. If your project is on Kotlin 2.0, for example a React Native project before version 0.79, move your project to Kotlin 2.1 or later first.

| Purchasely Android SDK | Google Play Billing 8 | Minimum Kotlin compiler in your project |
| ---------------------- | --------------------- | --------------------------------------- |
| 5.3.x and earlier      | ❌ `NoSuchMethodError` at run time | not applicable |
| 5.4.0 to 5.7.x         | ✅ with the fixes below | 2.1 |
| 6.x                    | ✅ Billing 8 included   | 2.2 |

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

* Purchasely SDK version
* Google Play Billing version
* a list of dependencies bringing Billing into the project (e.g., RevenueCat)
