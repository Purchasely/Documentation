---
title: >-
  Play Store - Where can I find the Play Store Product ID and Base Plan ID to
  associate with a Plan?
excerpt: >-
  This section describes where to find the Play Store Product ID in the Play
  Store Console
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    Want to know how to configure a subscription in the Google Play Console?
    Follow the guide
  pages:
    - type: basic
      slug: play-store-configuring-in-app-subscriptions
      title: Play Store - Configuring In-App Subscriptions
---
It is necessary to create Products and Plans in the App stores BEFORE creating them in Purchasely. Also its mandatory to declare those plans in the Purchasely console in order to use them in the paywalls. 

The Play Store Product ID of your plan can be found in the Play Store Console and then mapped in the [console](https://console.purchasely.io/). 

 Source: Google

# Subscriptions

In the Play Store, the subscription objects are currently structured as shown below:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/315b6ee-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


To fetch the `Play Store Product ID`, you have to login to the [Google Play Console](https://play.google.com/console/developers/android/app?pli=1), choose the name of your app in the Home screen, then navigate to side pane, 

**Monetise** -> **Products** -> **Subscriptions** -> Click the **Subscription ** that contains the [base plan](https://start.purchasely.com/docs/play-store-configuring-in-app-subscriptions) you have created and then in the following screen, you will find a list as shown below. 

 Copy the `Product ID`and the `Base plan ID`

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/d32e5cf-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


And paste the `Product ID` and `base plan ID` in the [Purchasely console](https://start.purchasely.com/docs/product-plans-setup). 

![](https://files.readme.io/4273c5d-image.png)

> 👍 Introductory Offer
> 
> You don't have to declare anything in the Purchasely console regarding the offer plan. Offer type= New customer acquisition. 
> 
> [block:image]{"images":[{"image":["https://files.readme.io/dd8498c-image.png",null,""],"align":"center","border":true}]}[/block]

<br />

# Promotional offers

To do a retention or winback campaign for Android users, you have to create a promotional offer in the stores and declare them in the Purhcasely console. In Google Play Console, the offer type for winback or retention is **Developer Determined**.

To fetch the offer id, you have to login to the [Google Play Console](https://play.google.com/console/developers/android/app?pli=1), choose the name of the app, then navigate to side pane, 

**Monetise** -> **Products** ->**Subscriptions** -> Click the **Subscription ** that contains the [base plan](https://start.purchasely.com/docs/play-store-configuring-in-app-subscriptions) you have created and then in the following screen, you will find a list as shown below. 

Copy the `Offer plan ID`

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/c0b957a-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Paste the [Offer ID](https://start.purchasely.com/docs/retention-winback) in the Purchasely console

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/7e577a9-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


# In-App Purchases

To fetch the plan id of the In-App Purchases you created, you have to login to the [Google Play Console](https://play.google.com/console/developers/android/app?pli=1), choose the name of the app, then navigate to side pane, 

**Monetise** -> **Products** ->**In App Producs** -> that contains the [plan](https://start.purchasely.com/docs/app-store-configuring-in-app-subscriptions#creating-a-subscription) you have created and then in the following screen, you will find a list as shown below.

Copy the `Product ID` of the plan 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/738c0db-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


And paste it in the Purchasely console and **Save**.

[block:image]{"images":[{"image":["https://files.readme.io/998bfd3-image.png",null,null],"align":"center","border":true}]}[/block]