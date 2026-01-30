---
title: Copy of Cordova
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
<CordovaSDKInstallation />

## Other stores

Our Cordova SDK does not contains other stores to avoid unnecessary integrations. You have to specifically declare which stores you want.\
To add our stores dependencies to your project, you just need to add them to the `app/build.gradle` file of your android folder in your project. The version must be the same than purchasely main dependency

```typescript build.gradle
dependencies {
    //Amazon App Store
    implementation 'io.purchasely:amazon:<<current_android_version>>'
    
    //Huawei Mobile Services
    implementation 'io.purchasely:huawei-services:<<current_android_version>>'
}
```