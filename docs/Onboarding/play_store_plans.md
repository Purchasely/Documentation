---
title: Play Store - Plans
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

This ID is a unique identifier for your plan that you can use with Purchasely SDK to trigger a purchase and it will also be returned with our webhooks. You can choose the identifier you want, we suggest to use the same than the one you have set up with your subscription on Google Play Console.

# Where can I find the Play Store Product ID in the Google Play  Console?

## For a Consumable or Non Consumable

1. Connect to the Google Play   Console
2. Navigate to the following section:  
   _Google Play Console > [YOUR APP] > In-App Product >_
3. Copy the value of the `PRODUCT ID`

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/8253c9e-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


4. Paste the value in the field `APP STORE PRODUCT ID` in the Purchasely Console

## For a subscription

1. Connect to the App Store Connect Console
2. Navigate to the following section:  
   _Google Play Console > [YOUR APP] > Subscriptions >_
3. Select the desired subscription 
4. Copy the value of the `PRODUCT ID` `**(1)**` and paste it in the field `PLAY STORE PRODUCT ID` in the Purchasely Console
5. Copy the value of the `BASE PLAN ID` `**(2)**` and paste it in the field BASE PLAN ID in the Purchasely Console

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/5004d77-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


6. Activate the `BACKWARD COMPATIBILITY` in the Purchasely Console only if it is activated in the Google Play Console `**(3)**`

# How to create a subscription in the Google Play Console?

1. Connect to the Google Play Console
2. Navigate to the following section:  
   _Google Play Console > [YOUR APP] > Subscriptions >_
3. Click on the blue button Create subscription in the upper right corner
4. Fill in the fields `NAME` & `PRODUCT ID`, then click on the button Create.  
   The value of the `PRODUCT ID` will have to be reported in the Purchasely Console in the field `GOOGLE PLAY STORE PRODUCT ID`

   ![](https://files.readme.io/eb10187-image.png)
5. Click on the link Add base plan at the bottom of the next screen

   [block:image]{"images":[{"image":["https://files.readme.io/9aaacab-image.png",null,""],"align":"center","border":true}]}[/block]
6. Fill-in the field `BASE PLAN ID`  
   Note: this value will have to be reported in the field `BASE PLAN ID` in the Purchasely Console.
7. Adjust the type of subscription:
   1. auto-renewing: this is the standard type of subscription. They automatically renew when the current billing cycle ends
   2. prepaid: this type of subscription do not auto-renew automatically. It is very rarely used in subscription apps, except in India, where auto-renewing subscriptions are not proposed for sales.
8. Adjust the Price and avaibility for each country or region
9. Save

# How to create an In-App Product in the Google Play Console?

1. Connect to the App Store Connect Console
2. Navigate to the following section:  
   _Google Play Console > [YOUR APP] > In-App Products _
3. Click on the blue button Create product in the upper right corner
4. Fill in the field `Product ID`.  
   The value of the Product ID will have to be reported in the Purchasely Console

   [block:image]{"images":[{"image":["https://files.readme.io/482aa6b-image.png",null,""],"align":"center","border":true}]}[/block]

<!----->

6. Fill in the Product details (`Name` & `Description`)

   [block:image]{"images":[{"image":["https://files.readme.io/f1f3809-image.png",null,""],"align":"center","border":true}]}[/block]
7. Set the Price either by selecting a pricing template or setting the price directly.  
   ⚠️ Multi-quantity products in a single transaction cannot be managed by the Purchasely Platform. You should therefore not check the box
8. Save

> 📘 Difference between consumable and non-consumable products in the Google Play Store
> 
> In the Google Play Console, In-App Product are not associated with a type (consumable / non consumable) like in the App Store.
> 
> Depending on which type (consumable / non consumable) you associate to the Plan in the Purchasely Console, the Purchasely SDK will indicate to the Google Play Store that the In-App Product has been consumed or not when completing the transaction.