---
title: Flutter
deprecated: false
hidden: false
metadata:
  robots: index
next:
  pages:
    - slug: sdk-initialization
      title: SDK initialization
      type: basic
---
We rely on [Pub.dev](https://pub.dev/packages/purchasely_flutter/install) to distribute our Flutter SDK

# Main dependency

```shell
flutter pub add purchasely_flutter
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
        compileSdkVersion = 33
        targetSdkVersion = 33
    }
}

allprojects {
    repositories {
        mavenCentral()
    }
}
```

# Android setup

We do include a store by default in our SDK, with Android you can choose to use Google and/or Huawei and/or Amazon.  
See below to add the store you want to use

> 📘 Versioning
>
> All your dependencies **must** always be at the **same version** for example
>
> ```yaml pubspec.yaml
> dependencies:
>   purchasely_flutter: ^6.0.0-rc.1
>   purchasely_google: ^6.0.0-rc.1
>   purchasely_android_player: ^6.0.0-rc.1
> ```

<br />

## Video Player

A video player is not provided by default on Android to avoid conflict with another dependency you may have  
We provide one in an external dependency that is detected and handled automatically

```shell
flutter pub add purchasely_android_player
```

<br />
