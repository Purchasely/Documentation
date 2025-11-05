---
name: flutter sdk installation
---
We rely on [Pub.dev](https://pub.dev/packages/purchasely_flutter/install) to distribute our Flutter SDK

# Main dependency

```shell
flutter pub add purchasely_flutter
```

Don't forget to change the minimum OS versions to match Purchasely requirements (iOS 11 / Android 21)

```yaml iOS
// Podfile

...

platform :ios, '11.0'

...
```
```groovy Android
// Edit file android/build.gradle
buildscript {
    ext {
        minSdkVersion = 21 //min version must not be below 21
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

We do include a store by default in our SDK, with Android you can choose to use Google and/or Huawei and/or Amazon.\
See below to add the store you want to use

> 📘 Versioning
>
> All your dependencies **must** always be at the **same version** for example
>
> ```yaml pubspec.yaml
> dependencies:
>   purchasely_flutter: ^<<current_flutter_version>>
>   purchasely_google: ^<<current_flutter_version>>
>   purchasely_android_player: ^<<current_flutter_version>>
> ```

## Google Play Billing

To add Google as a store, you can use our NPM dependency

```shell
flutter pub add purchasely_google
```

Then you must add Google in the list of stores

```typescript Flutter
await Purchasely.start(
        apiKey: '<<X-API-KEY>>',
        androidStores: ['Google'], // default is Google, don't forget to add the dependency to the same version
        storeKit1: false, // set to false to use StoreKit2, true to use StoreKit1
);
```

## Video Player

A video player is not provided by default on Android to avoid conflict with another dependency you may have\
We provide one in an external dependency that is detected and handled automatically

```shell
flutter pub add purchasely_android_player
```
