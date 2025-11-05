---
name: reactnative sdk installation
---
We rely on [NPM](https://www.npmjs.com/package/react-native-purchasely) to distribute our React Native SDK

# Main dependency

```shell
npm install react-native-purchasely --save
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
> ```json package.json
> "dependencies": {
>   "react-native-purchasely": "<<current_rn_version>>",
>   "@purchasely/react-native-purchasely-google": "<<current_rn_version>>",
>   "@purchasely/react-native-purchasely-android-player": "<<current_rn_version>>",
> },
> ```

## Google Play Billing

To add Google as a store, you can use our NPM dependency

```shell
npm install @purchasely/react-native-purchasely-google --save
```

Then you must add Google in the list of stores

```typescript React Native
await Purchasely.start({
  apiKey: '<<X-API-KEY>>',
  storeKit1: false, // set to false to use StoreKit2, true to use StoreKit1,
  androidStores: ['Google']
});
```

## Video Player

A video player is not provided by default on Android to avoid conflict with another dependency you may have\
We provide one in an external dependency that is detected and handled automatically

```shell
npm install @purchasely/react-native-purchasely-android-player --save
```
