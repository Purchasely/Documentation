---
title: Kotlin/Java
excerpt: Our Android SDK has multiple dependencies according to your needs
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: sdk-implementation-1
      title: SDK Implementation
---
<AndroidSdkInstallation />

## Huawei Mobile Services

Huawei requires you to provide the SHA-1 of your certificate and add their configuration file to your project (agconnect-services.json). Please refer to their documentation : [https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides-V5/config-agc-0000001050033072-V5](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides-V5/config-agc-0000001050033072-V5)

To integrate Huawei Mobile Services, you need to add dependencies to huawei repository and plug-in as referred in their documentation : [https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides-V5/integrating-sdk-0000001050035023-V5](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides-V5/integrating-sdk-0000001050035023-V5)

```groovy project/build.gradle
// Edit file android/build.gradle
buildscript {
    repositories {
        maven {url 'https://developer.huawei.com/repo/'}
    }
    dependencies {
        classpath 'com.huawei.agconnect:agcp:1.6.0.300'
    }
}

allprojects {
    repositories {
        //Huawei only
        maven {url 'https://developer.huawei.com/repo/'}
    }
}
```

Finally you can Purchasely Huawei dependency

```groovy project/app/build.gradle
//Add this line after android plugin
apply plugin: 'com.huawei.agconnect'

dependencies {
    //Add this line to integrate Huawei Mobile Services with Purchasely
    implementation 'io.purchasely:huawei-services:<<current_major_version>>.+'
}
```

This dependency contains the class `GoogleStore` that you must add to `Purchasely.Builder` to be used by the SDK

```kotlin Kotlin
Purchasely.Builder(applicationContext)
  .apiKey("<<X-API-KEY>>")
  .stores(listOf(HuaweiStore()))
  .build()
  .start { isConfigured, error ->
    if(isConfigured) {
      // Purchasely setup is complete 
      )
    }
```

## Amazon App Store

You only need to add one dependency

`implementation 'io.purchasely:amazon:<<current_major_version>>.+'`

This dependency contains the class `AmazonStore` that you must add to `Purchasely.Builder` to be used by the SDK

```kotlin Kotlin
Purchasely.Builder(applicationContext)
  .apiKey("<<X-API-KEY>>")
  .stores(listOf(AmazonStore()))
  .build()
  .start { isConfigured, error ->
    if(isConfigured) {
      // Purchasely setup is complete 
      )
    }
```
