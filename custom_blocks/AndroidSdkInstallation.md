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

`implementation 'io.purchasely:core:6.0.1'`

This dependency contains everything you need to make purchasely run **except** the store and player

<Callout icon="📘" theme="info">
  ### Versioning

  All your dependencies **must** always be at the **same version** for example if you specify one

  ```Text project/app/build.gradle
  implementation 'io.purchasely:core:6.0.1'
  implementation 'io.purchasely:google-play:6.0.1'
  implementation 'io.purchasely:player:6.0.1'
  ```
</Callout>

## Google Play Billing - Only for Subscription Apps

Our SDK integrates Google Play Billing Client version 8.3.0, you must not use another dependency with an older version in your project.

`implementation 'io.purchasely:google-play:6.0.1'`

This dependency contains the class `GoogleStore` that you must add to `Purchasely.Builder` to be used by the SDK.

## Video Player

If you have videos in your paywall, you must provide a video player to play them.<br />Purchasely core dependency does not include a video player to avoid dependency conflicts, specifically with [Media3 Exoplayer](https://developer.android.com/guide/topics/media/exoplayer)

We do provide a player dependency which will be detected automatically by our SDK if you do not have a video player in your application<br />`implementation 'io.purchasely:player:6.0.1'`

If you already have your own player that support HLS video, you can also provide your own player view, more information in [Displaying a video on Android](display-video-on-android)
