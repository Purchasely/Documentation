---
title: Understanding the Offer mode
excerpt: This article explains about how the offer mode works in the Screen composer
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    Check Dynamic Offering to learn more about how to associate multiple
    offering to a same Paywall
  pages:
    - type: basic
      slug: dynamic-offering
      title: Dynamic Offering
---
**Offer mode** in Purchasely screen composer allows you to display an alternative copy or price for your offers. This feature is perfect for new user acquisition, retention and winback an expired user and lets you leverage the same Screen / Paywall both for end-users who are eligible to an Offer and those who are not.

## When is Offer Mode displayed?

**Offer Mode** is displayed only when the end-user is eligible for the Offer associated with the plan—either an Introductory Offer or a Promotional Offer configured in the Offering. If no specific text has been defined for Offer Mode, the SDK automatically falls back to the Regular Mode text. 

<br />

## How to customize a paywall for offer mode:

Once you have prepared a paywall for Regular Mode, you turn on the offer mode radio button on the top of the screen and customize each and every text element you have filled for the regular mode you can customize it for offer mode. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/f6fb5b7e2d3812d0e7e282c89635cf14bab293bb44bf898e5cd4fea955d2c5e6-Screen_Recording_2025-03-17_at_11.19.04.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


## How to display the offer price for different regions ?

Purchasely provides you with tags to automatically to fetch the offer price and offer duration. 

Use the following tag to show the the[ introductory offer](https://docs.purchasely.com/docs/app-store-configuring-in-app-subscriptions#adding-introductory-offers-and-free-trials) or [new user acquisition offer](https://docs.purchasely.com/docs/play-store-configuring-in-app-subscriptions#creating-offer-plans) & [promotional offer](https://docs.purchasely.com/docs/promotional-offers-configuration) or [developer determined offer](https://docs.purchasely.com/docs/developer-determined-offers-configuration) price. 

[block:parameters]
{
  "data": {
    "h-0": "Tag",
    "h-1": "Usage",
    "h-2": "Example",
    "0-0": "`OFFER_PRICE`",
    "0-1": "Displays the winback offer price.",
    "0-2": "For a winback offer :  \n_  Don't miss the intro offer of **{{OFFER_PRICE}}** for the first week.  \n_  \nThe output will be:  \n_  Don't miss the intro offer of $0.99/week for the first week._",
    "1-0": "`OFFER_AMOUNT`",
    "1-1": "Displays the winback offer amount.",
    "1-2": "For a winback offer :  \n_  Don't miss the intro offer of **{{OFFER_AMOUNT}}** for the first month.  \n_  \nThe output will be:  \n_  Don't miss the intro offer of $5.99 for the first month._",
    "2-0": "`OFFER_PERIOD`",
    "2-1": "Displays the winback offer period.",
    "2-2": "For an extension of a free trial:  \n_  Don't miss the free trial for a **{{OFFER_PERIOD}}**.  \n_  \nThe output will be:  \n_  Don't miss the free trial for a week._",
    "3-0": "`OFFER_DURATION`",
    "3-1": "Displays the winback offer duration.",
    "3-2": "For a winback:  \n_  Hurry up intro offer for **{{OFFER_AMOUNT}}**/ **{{OFFER_DURATION}}**.  \n_  \nThe output will be:  \n_  Hurry up intro offer for $0.99 / 1week._",
    "4-0": "`OFFER_PRICE_COMPARISON`",
    "4-1": "Displays the price difference between the discounted offer and the regular price of the plan for the higher duration.",
    "4-2": "With:  \n  \n- offer price: $99.99/year\n- monthly: $9.99/month  \n   **{{OFFER_PRICE_COMPARISON}}** will display $19.89",
    "5-0": "`OFFER_DISCOUNT_PERCENTAGE`",
    "5-1": "Displays the discount percentage between the discounted offer and the regular price of the plan.",
    "5-2": "With:  \n  \n- offer price: $99.99/year\n- monthly: $9.99/month  \n   **{{OFFER_DISCOUNT_PERCENTAGE(plan1,plan2)}}** will display 17%"
  },
  "cols": 3,
  "rows": 6,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


<br />

## Get user eligibility to introductory offer

Purchasely SDK provides a method to retrieve easily from your application if a user is eligible to a introductory offer (or free trial)  
More information in the [dedicated article](eligibility-intro-offer)