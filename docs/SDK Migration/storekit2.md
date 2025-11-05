---
title: From StoreKit1 to StoreKit2
excerpt: ''
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Purchasely, by default, uses StoreKit 2 to initiate and process purchases on iOS 15+. 

However, if you wish to only use StoreKit 1, you can set that parameter with [Purchasely.start()](sdk-initialization#start). Users with devices below minimum requirements will continue to use StoreKit 1 under the hood.

# Configuration

Configuring StoreKit 2 with App Store Connect to allow Purchasely to verify transactions requires a [few steps](https://developer.apple.com/documentation/appstoreserverapi/creating_api_keys_to_authorize_api_requests). Once completed, you can update your application settings in Purchasely console. This configuration is essential for using StoreKit 2 with Purchasely SDK.

## Enable App Store Connect API access

* Sign in to [App Store Connect](https://appstoreconnect.apple.com/access/api/subs)
* Go to "Users and Access"
* Select "Keys" under the "In-App Purchase" section
* Click on the "+" button to generate a new API key
* Choose a name for the key and click "Generate"
* Download the API key file (`.p8`), and note the **Key ID** and **Issuer ID**. Keep the file secure, as you won't be able to download it again

<Image align="center" className="border" border={true} src="https://files.readme.io/78c6635-SCR-20230403-nktk.png" />

<br />

## Setup StoreKit2 on Purchasely Console

* Connect to [Purchasely Console](https://console.purchasely.io/)
* Go to "App Settings"
* Select Apple App Store" under the "Store configuration" section
* Fill in the **Private Key Id** from the key you generated
* Upload your Private Key File (.p8)
* Fill your **Issuer Id**
* Click on **Save** in the top right corner

<Image align="center" className="border" border={true} src="https://files.readme.io/d4fcacd-SCR-20230403-nefu.png" />

<br />

# Implementation

> 📘 SDK Initialization
>
> In [Purchasely.start()](sdk-initialization#start)method, either remove the `storekitSettings` parameter, or set it to `.storeKit2` to use StoreKit 2.

The only change you need to make is if you are in observer mode, if you are in full mode you're all set!

> ❗️ Handling purchases and restorations (Paywall Observer mode)
>
> If you are using the Purchasely SDK in [Paywall Observer mode](paywallobserver-mode), it is essential to call `Purchasely.syncPurchase()` once a purchase or restoration has been processed. This allows the SDK to be aware of new transactions and ensures accurate data reporting for A/B tests and paywall conversion.
>
> After processing a purchase or restoration, call
>
> ```swift Swift
> // Preferred: Synchronize all purchases of user
> Purchasely.synchronize()
>
> // Synchronize only for one apple product id
> try await Purchasely.syncPurchase(for: "apple product id")
> ```
> ```objectivec
> [Purchasely syncPurchaseFor:@"apple-product-id" completionHandler:^(NSError * _Nullable error) {
>     // Handle Error.    
> }];
> ```

# Requirements

## Purchasely SDK

* **iOS**: 4.0.1
* **Flutter**: 4.0.1
* **React Native**: 4.0.1
* **Unity**: 4.1.0
* **Cordova**: 4.1.0

## OS version (built with Xcode 14 or later)

* iOS 15
* iPadOS 15
* macOS 12
* tvOS 15
* watchOS 8
