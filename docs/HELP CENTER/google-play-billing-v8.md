---
title: Google Play Billing v8
excerpt: Gradle fixes when a non-KTX Billing dependency is present
deprecated: false
hidden: false
metadata:
  robots: index
---
```kotlin Gradle
configurations.all {
    resolutionStrategy {
        force("com.android.billingclient:billing:8.3.0")
        force("com.android.billingclient:billing-ktx:8.3.0")
    }
}
```


## Symptoms

After migrating to **Google Play Billing 8.x**, some apps may experience that prices are not displayed in Purchasely Screens.

In this situation:

- the SDK initialization fails to retrieve the Google Subscriptions.y
- the blocking call is typically `queryProductDetails()` (Google products fetch)

This prevents all In-App Purchase features from working with Purchasely

---

## Root cause (likely)

This issue can happen when the project includes the dependency:

- `com.android.billingclient:billing` (**non-KTX**)

while the Purchasely SDK relies on:

- `com.android.billingclient:billing-ktx`.

> ⚠️ We suspect an internal behavior change in **Google Play Billing v8 non-KTX** that can cause a request to hang indefinitely (no success callback, no error callback).

---

## ✅ Fix #1 — Use `billing-ktx` (recommended)

Make sure your app uses the Kotlin variant of Google Play Billing:

```gradle
dependencies {
    implementation("com.android.billingclient:billing-ktx:8.3.0")
}

✅ Fix #2 — Force Gradle resolution to Billing v8 (workaround)

If another dependency forces billing (non-KTX), you can force dependency resolution to ensure both artifacts are aligned:

configurations.all {
    resolutionStrategy {
        force("com.android.billingclient:billing:8.3.0")
        force("com.android.billingclient:billing-ktx:8.3.0")
    }
}

If the issue persists after applying these fixes, please contact our support team with:

Purchasely SDK version

Google Play Billing version

a list of dependencies bringing Billing into the project (e.g., RevenueCat)