---
name: android sdk installation
---
## Requirements

- minSdkVersion: 23
- compileSdkVersion: 36
- Kotlin: 2.2.+
- Gradle 8.+
- Android Gradle Plugin: 8.+
- JDK 11

We rely on [Maven](https://central.sonatype.com/search?q=io.purchasely) to distribute our Android so make sure you are fetching your dependencies from Maven Central

```groovy build.gradle
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```

<Callout icon="📘" theme="info">
  ### Android TV

  Our SDK is compatible with Android TV and thus declare in its manifest:<br />`<uses-feature
          android:name="android.software.leanback"
          android:required="false" />`

  `<uses-feature
          android:name="android.hardware.touchscreen"
          android:required="false" />`
</Callout>

## Core dependency

This is the main and required dependency to make Purchasely work

`implementation 'io.purchasely:core:6.3.0'`

This dependency contains everything you need to make purchasely run **except** the store and player

<Callout icon="📘" theme="info">
  ### Versioning

  All your dependencies **must** always be at the **same version** for example if you specify one

  ```Text project/app/build.gradle
  implementation 'io.purchasely:core:6.3.0'
  implementation 'io.purchasely:google-play:6.3.0'
  implementation 'io.purchasely:player:6.3.0'
  ```
</Callout>

## Google Play Billing - Only for Subscription Apps

Our SDK integrates Google Play Billing Library version 9.1.0 (from SDK 6.3.0). Gradle resolves your app to this version. You must not use another dependency with an older version in your project.

If your app calls the Billing Library directly, do not use the APIs that Billing 9 removes: `SkuDetails`, `SkuDetailsParams`, `BillingClient.SkuType` and `QueryPurchaseHistoryParams`. Read the [Billing 9 migration guide](https://developer.android.com/google/play/billing/migrate-gpblv9).

`implementation 'io.purchasely:google-play:6.3.0'`

This dependency contains the class `GoogleStore` that you must add to `Purchasely.Builder` to be used by the SDK.

## Video Player

If you have videos in your paywall, you must provide a video player to play them.<br />Purchasely core dependency does not include a video player to avoid dependency conflicts, specifically with [Media3 Exoplayer](https://developer.android.com/guide/topics/media/exoplayer)

We do provide a player dependency which will be detected automatically by our SDK if you do not have a video player in your application<br />`implementation 'io.purchasely:player:6.3.0'`

If you already have your own player that support HLS video, you can also provide your own player view, more information in [Displaying a video on Android](display-video-on-android)

## R8 and ProGuard

The SDK includes its own R8 rules. You do not need to add rules for the SDK.

From SDK 6.3.0, these rules keep only the code that the SDK reaches by name, so your minified app is smaller. Add your own keep rules in these cases:

- Your code reaches SDK classes by reflection.
- Your app uses Lottie directly.

Your own player class that you give with `Purchasely.playerView` does not need a keep rule.
