---
title: Product & plans setup
excerpt: >-
  This section explains how to manage the catalogue of In-App Purchases and
  Subscriptions in the Purchasely Console
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    It's time to start with the integration of the SDK! Follow the SDK Quick
    Start guide 👇
  pages:
    - type: basic
      slug: sdk-quick-start
      title: SDK Quick start
---
# General process

Purchasely offers the possibility to add new In-App Purchase to your catalogue in the app remotely, without needing any app submission.

The general process for adding new In-App Subscriptions and In-App Purchases to your app is the following:

1. Create the In-App Subscription or In-App Purchase in each store. 
2. Create a <<glossary:Plan>> in the Purchasely Console and attach it to a <<glossary:Product>>
3. Map the <<glossary:Plan>> with the App store In-App Subscription by pasting the `store product Id` (also called `SKU Id` further)

<br />

# Configuring a <<glossary:Product>>

The first step before creating a <<glossary:Plan>> is to create the <<glossary:Product>> to which the <<glossary:Plan>> will be associated.

A <<glossary:Product>> is the equivalent of a Subscription Group in the App Store Connect Console. If you don't know what a Subscription Group is, [here is everything you need to know about them](understanding-subscription-groups-in-the-app-store).

Follow these steps:

1. Browse to the section [Products & Plans in the Purchasely Console](https://console.purchasely.io/products-plans)
2. Click on the button + Add new Product in the upper right corner

   [block:image]{"images":[{"image":["https://files.readme.io/6abf6b9-image.png",null,""],"align":"center","border":true}]}[/block]
3. Fill in the fields:
   - `Name`: display name in the Purchasely Console
   - `Id`: the internal Id you want to give to the <<glossary:Product>>
   - `Description` (optional): only used in the Purchasely Console, to record whatever information you need to remember for that <<glossary:Product>>

# Configuring a <<glossary:Plan>>

1. Create the new In-App Purchase or In-App Subscription in each App store.  
   You can follow these guides:
   - [App Store - Configuring In-App Subscriptions](app-store-configuring-in-app-subscriptions)
   - [App Store - Configuring In-App Purchases](app-store-configuring-in-app-purchases)
   - [Play Store - Configuring In-App Subscriptions](play-store-configuring-in-app-subscriptions)
   - [Play Store - Configuring In-App Purchases](play-store-configuring-in-app-purchases)
2. Create a <<glossary:Plan>> in the Purchasely Console

   [block:image]{"images":[{"image":["https://files.readme.io/8564870-image.png",null,""],"align":"center","border":true}]}[/block]
3. Fill in the fields: 
   - `Name`: the display name in the Purchasely Console
   - `Id`: the internal Id you want to give to the <<glossary:Plan>>
   - `Description` (optional): will only be displayed in the Purchasely Console
   - `Type`: choose a value among the following
     - Renewing Subscription: used for In-App Subscription which renew automatically at the end of each billing cycle.  
       _99.9% of the subscriptions are like this in the App stores._
     - Non-renewing Subscription: In-App Subscription which does not renew automatically.  
       _Almost no app uses them._
     - Consumable: In-App Purchase that can be purchased several times.  
       _Eg: a stack of coins that can be bought again one consumed._  
       ⚠️ Note: Consumable cannot be <<glossary:restore>>d.
     - Non Consumable: In-App Purchase that can be purchased only once and remains forever.  
       _Eg: a book or  an album._  
       Contrary to Consumable, Non Consumable can be <<glossary:restore>>>>d.
   - `Level`: used to order <<glossary:Plan>>s inside a <<glossary:Product>> to define upgrade/downgrade policies. [See below](https://purchasely.readme.io/docs/product-plans-setup#ordering-the-s-inside-a)
   - `Default paywall` (optional): this parameter is used for [Promoting In-App Purchases on the App Store](promoting-iap).
   - Then for each App store or payment platform (Stripe), you can associate the `App store product id` that you can gather directly from the store.
     - [Where can I find the App Store PRODUCT ID?](app-store-product-id)
     - [Where can I find the Play Store PRODUCT ID?](play-store-product-id)

<br />

# Ordering the <<glossary:Plan>>s inside a <<glossary:Product>>

The parameter `Level` associated to a <<glossary:Plan>> allows to define upgrade/downgrade/crossgrade policies within a <<glossary:Product>> for the Play Store, like it's possible for the App Store.

![](https://files.readme.io/4c7c3f3-image.png)

<br />

When switching from Plan A to Plan B within the same <<glossary:Product>>, the migration policy applied will be based on their levels:

- **Upgrade** (`Level` Plan A \< `Level` Plan B) - 2 different policies are applied for each store:
  - _App Store_: The user is immediately upgraded and receives a refund of the prorated amount of their original subscription.
  - _Play Store_: The user is immediately upgraded and the remaining **time** will be prorated and credited to the user
- **Downgrade** (`Level` Plan A > Level Plan B): The subscription continues until the next renewal date, then is renewed at the lower level and price.
- **Crossgrade**: (`Level` Plan A = `Level` Plan B): 
  - [_App Store_:](https://developer.apple.com/help/app-store-connect/reference/auto-renewable-subscription-information/#:~:text=next%20renewal%20date.-,Crossgrade,-When%20someone%20switches) 
    - If Plan A periodicity = Plan B Periodicity (e.g. Monthly -> Yearly): The crossgrade happens immediately and the user is refunded for the time that was left on Plan A
    - If Plan A periodicity != Plan B Periodicity (e.g. Monthly -> Monthly): The crossgrade happens when Plan A expires
  - _Play Store_: The new subscription begins immediately without changing the current billing cycle. The new price will be applied at the beginning of the next billing cycle ([IMMEDIATE_WITHOUT_PRORATION](https://developer.android.com/reference/com/android/billingclient/api/BillingFlowParams.ProrationMode))

In short:

- the Plans offering more benefits and with higher prices should have higher levels
- the Plans offering less benefits with lower prices should have lower levels
- Plans with equivalent benefits or prices should have the same levels
- if you want the same migrations policies as in the App Store, you should rank Plans in the same order as in the corresponding Subscription Group (reading top down)

<br />

> 🚧 Difference of ordering between the App Store Connect and the Purchasely Console
> 
> When ordering subscriptions within a Subscription Group in the App Store, the value provided is a `rank`. Subscriptions are ordered by `rank`** ascending**. 
> 
> [block:image]{"images":[{"image":["https://files.readme.io/cd6d2d7-image.png",null,"In the App Store the highest value subscriptions have the lowest ranks."],"align":"center","border":true,"caption":"In the App Store the highest value subscriptions have the lowest ranks."}]}[/block]
> 
> In the Purchasely Console, Plans are ordered by `Level` **descending**. Highest value plans have therefore the highest `Levels`.