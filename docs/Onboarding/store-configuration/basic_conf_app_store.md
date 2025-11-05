---
title: App Store
excerpt: ''
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Where can I find the App Bundle ID?

<AppStoreConfAppBundleID />

The `Bundle ID` is used by the Purchasely Platform to validate that receipts are indeed coming from your app.

1. Open App Store Connect, go to My Apps and select the desired app
2. Navigate to the section General > App information
3. Copy the value displayed in the field Bundle ID and paste in the the field APP BUNDLE ID of the Purchasely Console

<Image align="center" className="border" border={true} src="https://files.readme.io/5e36152-image.png" />

# Where can I find the App ID?

<AppStoreConfAppID />

<br />

It is required to set up promo code deeplinks in paywalls.

1. Open App Store Connect, go to My Apps and select the desired app
2. Navigate to the section General > App information
3. Copy the value of the field Apple ID

<br />

<Image align="center" className="border" border={true} src="https://files.readme.io/6d6080e-image.png" />

# Where can I find the Shared App Secret?

<AppStoreConfSharedAppSecret />

The `Shared App Secret` is used by Purchasely Platform and required to decode and validate receipts for this specific app

1. Open App Store Connect, go to My Apps and select the desired app
2. Navigate to the section General > App information and browse down the screen
3. Click on the link Manage in the section App-Specific Shared Secret

   <Image align="center" className="border" border={true} src="https://files.readme.io/f2055de-image.png" />
4. Copy the value displayed on the following screen

   <Image align="center" className="border" border={true} src="https://files.readme.io/c471118-image.png" />

⚠️ Don't forget to update the value in the Purchasely Console each time you regenerate a new App-Specific Shared Secret.

<br />

# How can I create a StoreKit 2 private key file, Issuer ID and Key ID?

<AppStoreConfStoreKit2 />

To make StoreKit 2 work, you need to grant the Purchasely Platform with a specific access.

The Private key Id, Private key file and the Issuer Id are required by Apple APIs. We use them for :

* StoreKit 2 APIs: to allow our server to verify your purchases
* Promotional offers: to generate the signature allowing the purchase

<br />

The configuration of StoreKit 2 requires to follow a few steps:

1. Open App Store Connect
2. Go to the section Users and Access > Integrations > In-App Purchase
3. Click on the *+* button to generate a new API key
4. Choose a name for the key and click "Generate"
5. Download the API key file (.p8), and note the Key ID and Issuer ID.\
   Keep the file secure, as you won't be able to download it again

<Image align="center" className="border" border={true} src="https://files.readme.io/14c8dcf-image.png" />
