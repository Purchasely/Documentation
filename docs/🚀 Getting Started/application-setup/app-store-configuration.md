---
title: Apple App Store configuration
excerpt: >-
  This section describes how to connect the App Store with the Purchasely
  Console
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: You can now proceed with the Google Play Store configuration
  pages:
    - type: basic
      slug: play-store-configuration
      title: Google Play Store configuration
---
In order to connect your Apple App Store account with Purchasely, you have to provide the following parameters from your App Store Connect application's console:

1. [App bundle ID](#1-app-bundle-id)
2. [App ID](#2-app-id)
3. [App scheme](#3-app-scheme-optional)
4. [Shared App Secret](#4-shared-app-secret)
5. [StoreKit 2 - Private key ID](#5-6-7-storekit-2-configuration)
6. [StoreKit 2 - Private key file](#5-6-7-storekit-2-configuration)
7. [StoreKit 2 - Issuer ID](#5-6-7-storekit-2-configuration)
8. [The Server to Server End point](#8-the-server-to-server-end-point)

<Image align="center" className="border" border={true} src="https://files.readme.io/dc034ad-image.png" />

<br />

# 1. App Bundle ID

<AppStoreConfAppBundleID />

<br />

# 2. App ID

<AppStoreConfAppID />

<br />

# 3. App scheme (optional)

The `App scheme` is required to make the paywalls preview work and enable deeplink automations.

Enter your `App scheme`  (without the `://`) in the Purchasely Console in the field `App Scheme` . A universal link can also be used.

* [More details on how to configure it for your iOS app](https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app)
* [More details on how to manage deeplinks with the Purchasely SDK](deeplinks-management)

# 4. Shared App Secret

<AppStoreConfSharedAppSecret />

<br />

# 5, 6, 7. StoreKit 2 configuration

<br />

> ❗️ StoreKit 1 is deprecated
>
> Since StoreKit1 is deprecated, please configure StoreKit2 and [use it in your app](sdk-initialization).

<br />

<AppStoreConfStoreKit2 />

<br />

Then, in the Purchasely Console:

1. Paste the value of the Key ID generated in the field `Private Key ID`
2. Upload the API Key file (`.p8`) previously downloaded in the field `Private Key File`
3. Paste the value of the `Issuer ID` in the field `Issuer ID`

<Image align="center" className="border" border={true} src="https://files.readme.io/4979bcc-image.png" />

[More details on StoreKit 2](app-store-storekit-1-vs-storekit-2)

<br />

# 8. The Server to Server End Point

<AppStoreConfS2SNotifications />

## What are App Store Server Notifications used for?

<AppStoreConfS2SWhatFor />

<br />

## What if you are already using the App Store Server Notifications for your subscription infrastructure?

App Store Connect only allows setting one endpoint url for S2S in production and sandbox mode. To circumvent this limitation, you can enable our S2S Forwardings integration in Purchasely Console.

If you are already using S2S notification with your existing Subscription Infrastructure, you can activate [Server to server notifications forwarding](s2s-notifications-forwarding) in the Purchasely Console.

[More details on activating Server to server notifications forwarding](s2s-notifications-forwarding)
