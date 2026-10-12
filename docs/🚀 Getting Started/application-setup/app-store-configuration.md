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
4. [Shared App Secret](#4-shared-app-secret) - only for subscription apps
5. [StoreKit 2 - Private key ID](#5-6-7-storekit-2-configuration) - only for subscription apps
6. [StoreKit 2 - Private key file](#5-6-7-storekit-2-configuration) - only for subscription apps
7. [StoreKit 2 - Issuer ID](#5-6-7-storekit-2-configuration) - only for subscription apps
8. [The Server to Server End point](#8-the-server-to-server-end-point---only-for-subscription-apps) - only for subscription apps
9. [App Store Connect API - Key ID](#9-10-app-store-connect-api-key-optional) - optional
10. [App Store Connect API - Private key file](#9-10-app-store-connect-api-key-optional) - optional

<Image align="center" border={true} src="https://files.readme.io/dc034ad-image.png" className="border" />

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

# 4. Shared App Secret - only for subscription apps

<AppStoreConfSharedAppSecret />

<br />

# 5, 6, 7. StoreKit 2 configuration - only for subscription apps

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

<Image align="center" border={true} src="https://files.readme.io/4979bcc-image.png" className="border" />

[More details on StoreKit 2](app-store-storekit-1-vs-storekit-2)

<br />

# 8. The Server to Server End Point - only for subscription apps

<AppStoreConfS2SNotifications />

## What are App Store Server Notifications used for?

<AppStoreConfS2SWhatFor />

<br />

## What if you are already using the App Store Server Notifications for your subscription infrastructure?

App Store Connect only allows setting one endpoint url for S2S in production and sandbox mode. To circumvent this limitation, you can enable our S2S Forwardings integration in Purchasely Console.

If you are already using S2S notification with your existing Subscription Infrastructure, you can activate [Server to server notifications forwarding](s2s-notifications-forwarding) in the Purchasely Console.

[More details on activating Server to server notifications forwarding](s2s-notifications-forwarding)

<br />

# 9, 10. App Store Connect API key (optional)

This key gives Purchasely read access to Apple data that the StoreKit 2 key cannot reach:

* **Apple catalog through MCP**: list your app's in-app purchases, subscription groups and subscriptions, then associate them with Purchasely products, plans and App Store distributions. Catalog discovery is read-only: it does not import products or start an automatic synchronization.
* **Apple's Retention Messaging report**: Apple's App Store Retention Messaging analytics report, used by [Apple Retention Messaging](apple-retention-messaging).

> 📘 Separate from StoreKit 2
>
> This key is not required to process purchases or validate subscriptions. Keep the StoreKit 2 configuration above. Although both keys use the `.p8` file extension, this key must come from **App Store Connect API**, not **In-App Purchase**.

## Create and download the key in Apple

1. Sign in to [App Store Connect](https://appstoreconnect.apple.com/) as an **Account Holder** or **Admin** to create a team key.
2. Open **Users and Access → Integrations → App Store Connect API → Team Keys**. If API access has not been enabled, the Account Holder must first use **Request Access**.
3. Click **Generate API Key** (or **+**) and name it, for example, `Purchasely`.
4. Under **Access**, select **Admin**. Apple accepts the analytics report request behind the Retention Messaging report only from an Admin key. For catalog access alone, a role that can read the app's in-app purchases and subscriptions is enough.
5. Generate the key, download its `.p8` private key file, and copy the **Key ID** and **Issuer ID**. Apple allows only one download of the private key, so store it securely.

Use a **team key** for this integration. Apple team keys cover all apps in the account; Purchasely only reads the app configured in Purchasely.

[Apple's guide to creating and managing App Store Connect API keys](https://developer.apple.com/help/app-store-connect/get-started/app-store-connect-api/)

## Configure the key in Purchasely

In the Purchasely Console, select your application and open **Setup → Platforms → Apple App Store**:

1. Check that **App ID** contains the numeric **Apple ID** from App Store Connect and that **Issuer ID** matches the team that issued the key. These fields are shared with the configuration above.
2. In **App Store Connect API**, enter the new **Key ID** in **App Store Connect Key ID**.
3. Upload the `.p8` file in **App Store Connect private key (.p8)**, or paste its complete contents, preserving the header, footer, and line breaks.
4. Save your changes.

Your Purchasely administrator needs **Setup → Platforms → View** to see the credentials and **Edit** to change them. To read the Apple catalog through MCP, grant **Setup → Apple catalog → View (MCP only)** when inviting or configuring the administrator, and include it in the MCP connection's consent. Renew the connection's consent if it was authorized before this permission was granted.
