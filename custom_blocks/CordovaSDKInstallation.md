---
name: Cordova SDK installation
---
We rely on [NPM](https://www.npmjs.com/package/@purchasely/cordova-plugin-purchasely) to distribute our Cordova SDK

# Main dependency

```shell
cordova plugin add @purchasely/cordova-plugin-purchasely@6.0.0
```

Don't forget to change the minimum OS versions to match Purchasely requirements (iOS 13.4 / Android 6)

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
        google()
        mavenCentral()
    }
}
```

# Android setup

We do not include a store by default in our SDK; with Android you can choose to use Google and/or Huawei and/or Amazon.<br />See below to add the store you want to use

<Callout icon="📘" theme="info">
  ### Versioning

  All your dependencies **must** always be at the **same version** for example

  ```json package.json
  "dependencies": {
    "@purchasely/cordova-plugin-purchasely": "6.0.0",
    "@purchasely/cordova-plugin-purchasely-google": "6.0.0"
  },
  ```
</Callout>

## Google Play Billing

To add Google as a store, you can use our NPM dependency

```shell
cordova plugin add @purchasely/cordova-plugin-purchasely-google@6.0.0
```

Then you must add Google in the list of stores

```javascript Cordova
Purchasely.start(
    '<<X-API-KEY>>',
    ['Google'],
    false, // false for StoreKit 2 (recommended), true for StoreKit 1
    null, // user id if user is connected
    Purchasely.LogLevel.DEBUG, // set to ERROR in production
    Purchasely.RunningMode.full, // ⚠️ v6 default is Observer — set .full to handle purchases
    (isConfigured) => {},
    (error) => { console.error(error); }
);
```

<br />

<Callout icon="⚠️" theme="warn">
  **Google Play Billing v8**

  If you use Google Play Billing in version 8, please [read this](google-play-billing-v8) to make it work with Purchasely
</Callout>

<br />
