---
title: Play Store - Configuring Pre-paid plan (Non renewing)
excerpt: >-
  This section provides details on how to configure Pre-paid plan in the Play
  Store with the Google Play Console
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Pre-paid base plan can also be called as Non renewing product, where users can purchase a plan Pre-paid to obtain subscription entitlement for a specified billing period that does not automatically renew. 

With these Pre-paid plans, users can

1. Users can subsequently top up to extend the plan's end date and maintain uninterrupted access to subscription content.
2. While topping up, they can purchase any Pre-paid base plan available for the same subscription, including  different durations and pricing.  
3. In addition to top-ups, users can also switch between Pre-paid and auto-renewing subscription plans as desired. 

## Creating Pre-paid plan:

<br />

1. Login to your [Google Play Console](https://play.google.com/console/u/0/developers) and select your app

<Image align="center" className="border" border={true} src="https://files.readme.io/3656d81-image.png" />

2. Then, Navigate to the following section:\
   *Google Play Console > All apps >[YOUR APP] > Monetize > Products > Subscriptions*

<Image align="center" className="border" border={true} src="https://files.readme.io/526757b-image.png" />

<br />

3. Click on the View subscription

<Image align="center" className="border" border={true} src="https://files.readme.io/85aafc4-image.png" />

4. Click on Add base plan button

<Image align="center" className="border" border={true} src="https://files.readme.io/4ca26ac-image.png" />

5. In the following page:
   1. `Base plan ID`: Before creating a base plan, carefully plan your base plan IDs. Base plan IDs must be unique to your app and can’t be changed or reused after they’ve been created.
   2. Type\`: to create a non renewing plan, you choose the type as **Pre-paid**. 
   3. `Duration`: denotes the duration of this plan, it can be minimum of 1 day to a maximum of 1 month.
   4. `Allow extension`:You can either choose to allow the extension or don't allow it. 

<Image align="center" className="border" border={true} src="https://files.readme.io/69c8f3e-image.png" />

Setting up `Tags` are optional. 

Once you have completed the Pre-paid set up, Click on **Set prices** to define price for this base plan.

<Image align="center" className="border" border={true} src="https://files.readme.io/8503e3e-image.png" />

Select the **regions** you want to sell this plan and click then click on the **Set price** button

<Image align="center" className="border" border={true} src="https://files.readme.io/4d426c5-image.png" />

Enter the **plan price** and click on **Update**. This price is tax excluded, once you select update, you will see the subscription price with tax.

<Image align="center" className="border" border={true} src="https://files.readme.io/7b7169a-image.png" />

If its good for you, please click on **Save**

<Image align="center" className="border" border={true} src="https://files.readme.io/63dfca2-image.png" />
