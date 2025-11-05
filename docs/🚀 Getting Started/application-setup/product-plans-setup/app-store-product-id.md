---
title: App Store - Where can I find the PRODUCT ID to associate with a Plan?
excerpt: >-
  This section describes where to find the PRODUCT ID in the App Store Connect
  Console
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    Learn more on how to configure a subscription in the App Store Connect
    Console
  pages:
    - type: basic
      slug: app-store-configuring-in-app-subscriptions
      title: App Store - Configuring In-App Subscriptions
---
It is necessary to create Products and Plans in the App stores BEFORE creating them in Purchasely. Also it's mandatory to declare those plans in the Purchasely console in order to use them in the Paywalls. 

The PRODUCT ID can be found in the App stores and then mapped in the [console](https://console.purchasely.io/). 

# Subscriptions

To fetch the Store Product ID, you have to login to the [Apple App Store Connect](https://appstoreconnect.apple.com/login), choose the name of the app, then navigate to side pane, 

**Monetize** -> **Subscriptions** -> Click the **Subscription group** that contains the [plan](https://start.purchasely.com/docs/app-store-configuring-in-app-subscriptions#creating-a-subscription) you have created and then in the following screen, you will find a list as shown below. 

Copy the `Product ID`

<Image align="center" className="border" border={true} src="https://files.readme.io/03c1101-image.png" />

And paste the `Product ID` in the [Purchasely console](https://start.purchasely.com/docs/product-plans-setup) and **Save**.

<Image align="center" className="border" border={true} src="https://files.readme.io/8342c3a-image.png" />

<br />

> 🚧 Difference of ordering between the App Store Connect and the Purchasely Console
>
> When ordering subscriptions within a Subscription Group in the App Store, the value provided is a rank. Subscriptions are ordered by rank ascending.
>
> In the App Store the highest value subscriptions have the lowest ranks.\
> In the App Store the highest value subscriptions have the lowest ranks.
>
> <Image align="center" className="border" border={true} src="https://files.readme.io/b0fb09e-image.png" />
>
> In the Purchasely Console, Plans are ordered by Level descending. Highest value plans have therefore the highest Levels.
>
> ![](https://files.readme.io/cab45b6-image.png)

> 👍 Introductory Offer
>
> You don't have to declare anything in the Purchasely console regarding the introductory offer. 
>
> ![](https://files.readme.io/35ca27d-image.png)

# Promotional offers

To do a retention or winback campaign for iOS users, you have to create a Promotional Offer in the App Store and declare them in the Purchasely console;

To fetch the `Offer ID`, you have to login to the [Apple App Store Connect](https://appstoreconnect.apple.com/login), choose the name of the app, then navigate to side pane, 

**Monetize** -> **Subscriptions** -> select the **Subscription group** and the Subscription that contains the promotional offer [plan](https://start.purchasely.com/docs/app-store-configuring-in-app-subscriptions#creating-a-subscription) and then click **View all Subscription Pricing**.

<Image align="center" className="border" border={true} src="https://files.readme.io/f613238-image.png" />

and then in the following screen, choose the **Promotional Offers** tab you will find a list as shown below. Copy the `Offer id `

<Image align="center" className="border" border={true} src="https://files.readme.io/781913d-image.png" />

Paste the [Offer ID](https://start.purchasely.com/docs/retention-winback) in the Purchasely console and **Save**.

<Image align="center" className="border" border={true} src="https://files.readme.io/81505c2-image.png" />

# In-App Purchases

To fetch the Store Product ID of an In-App Purchase you created, you have to login to the [Apple App Store Connect](https://appstoreconnect.apple.com/login), choose the name of the app, then navigate to side pane, 

**Monetize** -> **Subscriptions** -> Click the **In App Purchases** that contains the [plan](https://start.purchasely.com/docs/app-store-configuring-in-app-subscriptions#creating-a-subscription) you have created and then in the following screen, you will find a list as shown below.

<Image align="center" className="border" border={true} src="https://files.readme.io/e70b028-image.png" />

Paste the `Product ID` in the field `App Store Product id` and **Save**.

<Image align="center" className="border" border={true} src="https://files.readme.io/b5a1033-image.png" />
