---
title: Flutter
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
We rely on [Pub.dev](https://pub.dev/packages/purchasely_flutter/install) to distribute our Flutter SDK

## Main dependency

```shell
flutter pub add purchasely_flutter:6.0.0-rc.1
```

Don't forget to change the minimum OS versions to match Purchasely requirements (iOS 13.4 / Android 23)

```yaml iOS
// Podfile

...

platform :ios, '13.4'

...
```
```groovy Android
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

## Android setup

We do include a store by default in our SDK, with Android you can choose to use Google and/or Huawei and/or Amazon.\
See below to add the store you want to use

> 📘 Versioning
>
> All your dependencies **must** always be at the **exact same version**. Pin each package to `6.0.0-rc.1` — do not use a floating range (`^6.0.0`, `5.+`, …).
>
> ```yaml pubspec.yaml
> dependencies:
>   purchasely_flutter: 6.0.0-rc.1
>   purchasely_google: 6.0.0-rc.1
>   purchasely_android_player: 6.0.0-rc.1
> ```

## Google Play Billing

To add Google as a store, you can use our pub.dev dependency

```shell
flutter pub add purchasely_google:6.0.0-rc.1
```

Then you must add Google in the list of stores when starting the SDK with the builder

```dart Flutter
await Purchasely.apiKey('<<X-API-KEY>>')
        .runningMode(PLYRunningMode.full)
        .logLevel(PLYLogLevel.error)
        .stores([PLYStore.google]) // don't forget to add the matching dependency at the same version
        .storekitVersion(PLYStorekitVersion.storeKit2) // iOS only: storeKit2 (default) | storeKit1
        .start();
```

## Video Player

A video player is not provided by default on Android to avoid conflict with another dependency you may have\
We provide one in an external dependency that is detected and handled automatically

```shell
flutter pub add purchasely_android_player:6.0.0-rc.1
```

<FlutterSdkInstallation />
