---
title: Configuring promotional offers
excerpt: >-
  This page describes how to create promotional offers in Apple App Store
  Connect
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
In this article we are going to describe the process to create promotional offers on [AppStore Connect](https://appstoreconnect.apple.com/)and [Purchasely Console](https://console.purchasely.io/)

> 🚧 Eligibility
> 
> **You are responsible for the eligibility** of those promotional offers, you must create a specific paywall and display it only for the users you want to target (see Purchasely console below for more details)

# Apple promotional offers

## Console configuration

Purchasely **must have** an Apple certificate to sign promotional offers, the configuration is exactly the same than for [StoreKit 2](app-store-configuration#5-6-7-storekit-2-configuration-optional), so if you already did it you can skip that part and move to [next section](#appstore-connect-configuration)

Allowing Purchasely to sign promotional offers requires a [few steps](https://developer.apple.com/documentation/appstoreserverapi/creating_api_keys_to_use_with_the_app_store_server_api). Once completed, you can update your application settings in Purchasely console.

### **Enable App Store Connect API access**

- Sign in to [App Store Connect](https://appstoreconnect.apple.com/access/api/subs)
- Go to "Users and Access"
- Select "Keys" under the "In-App Purchase" section
- Click on the "+" button to generate a new API key
- Choose a name for the key and click "Generate"
- Download the API key file (`.p8`), and note the **Key ID** and **Issuer ID**. Keep the file secure, as you won't be able to download it again

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/86eacec-Promotional_offers.png",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


### Setup on Purchasely Console

- Connect to [Purchasely Console](https://console.purchasely.io/)
- Go to "App Settings"
- Select Apple App Store" under the "Store configuration" section
- Fill in the **Private Key Id** from the key you generated
- Upload your Private Key File (`.p8`)
- Fill your **Issuer Id**
- Click on **Save** in the top right corner

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/5edaa0a-Promotional_offers_1.png",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


## AppStore Connect configuration

A promotional offer is only available for current and previous subscribers of the selected subscription. You can create it from [AppStore Connect](https://appstoreconnect.apple.com/) in the same page where you manage your subscription price and introductory offers

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/8989a1f-Promotional_offers.webp",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


From that page select Promotional Offers tab and then click on the + button to create a new one

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/6851786-Promotional_offers_image.avif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Setup the discount you wish to offer, it can be:

- free (example: 3 months free then $9,99/month)
- pay up front (example: $14,99 for 3 months then $9,99/month)
- pay as your go (example: $4,99/month for 3 months then $9,99/month)

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/91ac30e-Promotional_offers_1.webp",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Once created, copy the ID you have set for this offer to paste in [Purchasely Console](promotional-offers.md#h_81922e6fd5-1)

# Purchasely Console

## Mapping your Promotional Offer with a Plan

When your promotional offer has been created on AppStore Connect and/or Google Play Console, the final step is to declare it in Purchasely Console to use it with your paywall

First, click on the three dots of your plan and _Manage promotional offers_  
The plan MUST be the App Store or Play Store product that you used to declare your offer

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/9961a4a-SCR-20240620-puqr.png",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Set a name, an identifier for Purchasely and the identifiers you have set in AppStore Connect and Google Play Console. Finally click Save to apply your changes

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/713b1d9-Promotional_offers_2.png",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


## Associating a Promotional Offer with a Paywall

Then you can create a paywall for your offer, we have created a new action button for that: **Winback/retention offer**  
You need to select your plan and offer to be applied as the action for this button  
You can use the field "Offer" of the different labels to set offers [tags](tags) like `OFFER_PRICE` and `OFFER_DURATION` (same principle than trial offer)

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/ddcf33a-Promotional_offers.avif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


You are responsible for displaying this paywall to users you want to target, so you should create a specific [placement](displaying-screens-placements) for them. You can also target them using [Audience](segmenting-your-user-base)

We will send specific events to your [webhook](webhook) or external integration:  
`PROMOTIONAL_OFFER_STARTED`

`PROMOTIONAL_OFFER_CONVERTED`

`PROMOTIONAL_OFFER_NOT_CONVERTED`

The information about the promotional offer will also be in the payload of events like the one above and `ACTIVATE`

`offer_type: "PROMOTIONAL_OFFER"`