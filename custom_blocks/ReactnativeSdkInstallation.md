---
name: reactnative sdk installation
---
We rely on [NPM](https://www.npmjs.com/package/react-native-purchasely) to distribute our React Native SDK

# Main dependency

```shell
npm install react-native-purchasely@6.0.0 --save
```

Don't forget to change the minimum OS versions to match Purchasely requirements (iOS 13.4 / Android minSdk 23)

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

# Android setup

We do include a store by default in our SDK, with Android you can choose to use Google and/or Huawei and/or Amazon.<br />See below to add the store you want to use

<Callout icon="📘" theme="info">
  ### Versioning

  All your dependencies **must** always be at the **same version** for example

  ```json package.json
  "dependencies": {
    "react-native-purchasely": "6.0.0",
    "@purchasely/react-native-purchasely-google": "6.0.0",
    "@purchasely/react-native-purchasely-android-player": "6.0.0",
  },
  ```
</Callout>

## Google Play Billing

To add Google as a store, you can use our NPM dependency

```shell
npm install @purchasely/react-native-purchasely-google@6.0.0 --save
```

Then you must add Google in the list of stores when starting the SDK with the builder

```typescript React Native
await Purchasely.builder('<<X-API-KEY>>')
  .runningMode('full')
  .logLevel('error')
  .stores(['google']) // don't forget to add the matching dependency at the same version
  .storekitVersion('storeKit2') // iOS only: 'storeKit2' (default) | 'storeKit1'
  .start();
```

<br />

<Callout icon="⚠️" theme="warn">
  **Google Play Billing v8**

  If you use Google Play Billing in version 8, please [read this](google-play-billing-v8) to make it work with Purchasely
</Callout>

## Video Player

A video player is not provided by default on Android to avoid conflict with another dependency you may have<br />We provide one in an external dependency that is detected and handled automatically

```shell
npm install @purchasely/react-native-purchasely-android-player@6.0.0 --save
```

<br />

## Android build error: "incompatible version of Kotlin"

The Android SDK requires a **Kotlin 2.2.x** toolchain or later. Both the bare React Native template and Expo still default to an earlier version, so the first Android build after the installation can stop with:

```text
Module was compiled with an incompatible version of Kotlin.
The binary version of its metadata is 2.3.0, expected version is 2.1.0.
```

<Callout icon="⚠️" theme="warn">
  **Kotlin version**

  This affects bare React Native **and** Expo projects. Two edits are needed, not one: the Kotlin version, and the version on the Kotlin Gradle Plugin classpath. Both are documented in [React Native — Kotlin version required by SDK 6](react-native-kotlin-version).
</Callout>

<br />
