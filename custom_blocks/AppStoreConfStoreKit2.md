---
name: App Store Conf - StoreKit 2
---
To make StoreKit 2 work, you need to grant the Purchasely Platform with a specific access.

Apple APIs require three values. They are the Key ID, the private key file (`.p8`) and the Issuer ID of an In-App Purchase key. We use them for:

* StoreKit 2 APIs: to allow our server to verify your purchases
* Promotional offers: to generate the signature allowing the purchase

<br />

The configuration of StoreKit 2 requires to follow a few steps:

1. Open App Store Connect
2. Go to the section Users and Access > Integrations > In-App Purchase
3. Click on the *+* button to generate a new In-App Purchase key
4. Choose a name for the key and click "Generate"
5. Download the key file (.p8), and note the Key ID and Issuer ID.\
   Keep the file secure, as you won't be able to download it again

Use an In-App Purchase key, not an App Store Connect API key (Users and Access > Integrations > App Store Connect API). Apple refuses an App Store Connect API key for these checks.

<Image align="center" className="border" border={true} src="https://files.readme.io/14c8dcf-image.png" />
