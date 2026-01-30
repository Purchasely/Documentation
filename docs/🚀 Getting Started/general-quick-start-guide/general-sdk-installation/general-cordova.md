---
title: Cordova
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
We rely on [NPM](https://www.npmjs.com/package/@purchasely/cordova-plugin-purchasely) to distribute our Cordova SDK

# Main dependency

```shell
cordova plugin add @purchasely/cordova-plugin-purchasely
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

We do include a store by default in our SDK, with Android you can choose to use Google and/or Huawei and/or Amazon.  
See below to add the store you want to use

> 📘 Versioning
>
> All your dependencies **must** always be at the **same version** for example
>
> ```json package.json
> "dependencies": {
>   "@purchasely/cordova-plugin-purchasely": "<<current_cordova_version>>",
>   "@purchasely/cordova-plugin-purchasely-google": "<<current_cordova_version>>"
> },
> ```

<br />
