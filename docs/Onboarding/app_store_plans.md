---
title: App Store - Plans
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
# What is a Plan?

A Plan is a generic term in the Purchasely Platform to refer to In-App Subscriptions & In-App Purchases.

Purchasely manages 4 types of Plans:

1. Renewing subscriptions
2. Non-renewing subscriptions
3. Consumables
4. Non consumables

Plans are grouped inside Products. Products are the equivalent of Subscription Groups in the App Store Connect Console.

Plans can be created in the section [Products & Plans](https://console.purchasely.io/products-plans) of the Console.

# What is the Plan ID used for?

This ID is a unique identifier for your plan that you can use with Purchasely SDK to trigger a purchase and it will also be returned with our webhooks. You can choose the identifier you want, we suggest to use the same than the one you have set up with your subscription on AppStore Connect.

# Where can I find the App Store Product ID in the App Store Connect Console?

## For a Consumable or Non Consumable

1. Connect to the App Store Connect Console
2. Navigate to the following section:  
   _App Store Connect > My Apps > [YOUR APP] > In-App Purchase >_
3. Copy the value of the PRODUCT ID

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/8d593af-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


## For a subscription

1. Connect to the App Store Connect Console
2. Navigate to the following section:  
   _App Store Connect > My Apps > [YOUR APP] > Subscriptions >_
3. Select the Subscription Group to which your subscription is associated
4. Copy the value of the PRODUCT ID

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/a77c016-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


# How to create a subscription in the App Store Connect Console?

1. Connect to the App Store Connect Console
2. Navigate to the following section:  
   _App Store Connect > My Apps > [YOUR APP] > Subscriptions _
3. Select the Subscription Group in which you want to create your Subscription. 

   ⚠️ If you haven't create a Subscription Group yet, or don't know what a Subscription Group is, we strongly invite you to read this: [Understanding subscription groups](https://purchasely.readme.io/docs/understanding-subscription-groups-in-the-app-store).
4. Click on the + blue button
5. Fill in the fields Reference Name & Product ID.  
   The value of the Product ID will have to be reported in the Purchasely Console

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/ead0c3e-image.png",
        null,
        ""
      ],
      "align": "center",
      "sizing": "500px",
      "border": true
    }
  ]
}
[/block]


6. For a renewing subscription, adjust the subscription duration
7. Adjust the Availability for countries and regions in which the subscription should be available
8. Adjust the Subscription prices.  
   To know more about the different types of Prices available on the App Store, read this: [Different types of Prices available for Subscriptions](https://purchasely.readme.io/docs/different-types-of-prices-available-for-subscriptions)
9. Save

> 🚧 You need to fill and sign the Paid Applications Agreement
> 
> If you don't have any paid app or in-app purchases, you need to fill in and sign the **Paid Applications Agreement**.
> 
> [Learn more](https://developer.apple.com/help/app-store-connect/manage-agreements/sign-and-update-agreements/)

# How to create a Consumable or Non Consumable in the App Store Connect Console?

1. Connect to the App Store Connect Console
2. Navigate to the following section:  
   _App Store Connect > My Apps > [YOUR APP] > In-App Purchases _
3. Click on the + blue button
4. Select the type between 

- **Consumable**: an In-App Purchase that can be consumed and rebought, like a stack of coins or a package of lives in a game
- **Non Consumable**: an In-App Purchase that users can only buy once and keep for their entire life, like an audio book (when it's bought and not rented) or a new level in a video game.

5. and fill in the fields Reference Name & Product ID.  
   The value of the Product ID will have to be reported in the Purchasely Console

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/e5212eb-image.png",
        null,
        ""
      ],
      "align": "center",
      "sizing": "500px",
      "border": true
    }
  ]
}
[/block]


6. Adjust the Availability for countries and regions in which the In-App Purchase should be available
7. Adjust the In-App Purchase prices.  
   To know more about the different types of Prices available on the App Store, read this: [Different types of Prices available for Subscriptions](https://purchasely.readme.io/docs/different-types-of-prices-available-for-subscriptions)
8. Save

> 🚧 You need to fill and sign the Paid Applications Agreement
> 
> If you don't have any paid app or in-app purchases, you need to fill in and sign the **Paid Applications Agreement**.
> 
> [Learn more](https://developer.apple.com/help/app-store-connect/manage-agreements/sign-and-update-agreements/)

# Do In-App Purchases and In-App Subscriptions need to be validated by the App Store Review Team?

Yes!

As long as they are not validated, they can only be purchased in a Sandbox environment.

When submitting the version of your application that contains In-App Purchases or In-App Subscriptions for the first time, the Products will need to be submitted for review at the same time as the new version of the application.

When the app already proposes In-App Purchases and In-App Subscription, the Products can be submitted for review without a new version of the app.