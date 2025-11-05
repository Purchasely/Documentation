---
name: App Store Conf - StoreKit 2
---
To make StoreKit 2 work, you need to grant the Purchasely Platform with a specific access.

The Private key Id, Private key file and the Issuer Id are required by Apple APIs. We use them for :

- StoreKit 2 APIs: to allow our server to verify your purchases
- Promotional offers: to generate the signature allowing the purchase

<br />

The configuration of StoreKit 2 requires to follow a few steps:

1. Open App Store Connect
2. Go to the section Users and Access > Integrations > In-App Purchase
3. Click on the _+_ button to generate a new API key
4. Choose a name for the key and click "Generate"
5. Download the API key file (.p8), and note the Key ID and Issuer ID.  
   Keep the file secure, as you won't be able to download it again

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/14c8dcf-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]