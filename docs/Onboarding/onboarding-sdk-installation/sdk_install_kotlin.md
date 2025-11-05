---
title: Kotlin
excerpt: ''
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
## Requirements

- minSdkVersion: 21
- compileSdkVersion: 33
- Kotlin: 1.8.+
- Gradle 7.+
- Android Gradle Plugin: 4.+
- JDK 17

We rely on [Maven](https://central.sonatype.com/search?q=io.purchasely) to distribute our Android so make sure you are fetching your dependencies from Maven Central

```groovy build.gradle
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```

## Core dependency

This is the main and required dependency to make Purchasely work

`implementation 'io.purchasely:core:4.+'`

This dependency contains everything you need to make purchasely run **except** the store and player

> 📘 Versioning
> 
> All your dependencies **must** always be at the **same version** for example
> 
> ```Text project/app/build.gradle
> implementation 'io.purchasely:core:4.2.1'
> implementation 'io.purchasely:google-play:4.2.1'
> implementation 'io.purchasely:player:4.2.1'
> ```

## Google Play Billing

Our SDK integrates Google Play Billing Client version 5.2.1, you must not use with your project another dependency with an older version.

`implementation 'io.purchasely:google-play:4.+'`

This dependency contains the class `GoogleStore` that you must add to `Purchasely.Builder` to be used by the SDK

## Video Player

If you have videos in your paywall, you must provide a video player to play them.  
Purchasely core dependency does not include a video player to avoid dependency conflicts, specifically with [Media3 Exoplayer](https://developer.android.com/guide/topics/media/exoplayer)

We do provide a player dependency which will be detected automatically by our SDK if you do not have a video player in your application  
`implementation 'io.purchasely:player:4.+'`

If you already have your own player that support HLS video, you can also provide your own player view, more information [here](https://help.purchasely.io/en/articles/5963004-displaying-a-video-on-android-devices)

<AndroidSdkInstallation />