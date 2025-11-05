---
title: Configuring Offer Codes in the Google Play Console
excerpt: >-
  This page describes how to create offer codes or promo codes in the Google
  Play Console
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The offer code in the Google Play Console provides users using a free paid app, in-app product, or subscription with a promo code. The offer code is linked to the base plan of a subscription in the Google Play Console. 

> 🚧 Warning
>
> In order to create codes, the subscription to which these codes are linked must be backward-compatible.

 In the Play Console, select your app, Go to Monetise -> Products -> Promo codes, and click Create Promo Code

<Image align="center" className="border" border={true} src="https://files.readme.io/8f96cad-image.png" />

<br />

Promo code in Google Play Console can be created in three steps:

1. [Setting up promotion details](#setting-up-promotion-details)
2. [Selecting promotion Type](#selecting-promotion-type)
3. [Choosing promo code type](#choosing-promo-code-type)

## Setting up promotion details

1. **Promotion name**: promotion name to identify the promo in the console. 
2. **Start date and time**: start date and time of the promotion code.
3. **End date and time**: end date and time of the promotion code.

<Image align="center" className="border" border={true} src="https://files.readme.io/a2531bf-image.png" />

<br />

## Selecting Promotion Type

1. **In-app product**- Consumable or Non-Consumable
2. **Subscription**- Auto-renewing subscription only (Promotion can't be created for prepaid products)
3. To renew your subscription, you have to choose the number of days of the free trial. 

For this demo, we choose Promotion type as Subscription. 

<Image align="center" className="border" border={true} src="https://files.readme.io/78c66d5-image.png" />

<br />

## Choosing promo code type

1. **Code Type**- Can be either One-time codes or Custom code
2. **Number of codes**- Number of  times the code is redeemed
   1. Must be greater than or equal to 2000 for custom codes.
   2. For one-time code- it can be greater than or equal to 1.

If you’re adding a custom code, enter the code and the redemption limit. 

<Image align="center" className="border" border={true} src="https://files.readme.io/f3706d4-image.png" />

Finally, click create on the pop-up that appears as below:

<br />

<Image align="center" className="border" border={true} src="https://files.readme.io/62a9ca9-image.png" />

<br />

> 🚧 Warning
>
> Custom codes must be unique per app, meaning you can’t reuse a custom code in the same app for a different campaign.
>
> Custom codes must be alphanumeric and are not case-sensitive.
>
> We recommend adding a year or date to the end of your custom code to make it easier to track when each code is enabled.
