---
title: Dashboard - Live
excerpt: This page provides details of the Live Dashboard
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
This page provides a real time snapshot of your subscriber base. 

You can use (and combine) the different filters available to narrow the data visualized

<Image align="center" className="border" border={true} src="https://files.readme.io/a63c66ff29a8f081f907747c7281905e82c3326c963ccc6529cbc1a6faa5723e-image.png" />

It is divided in several tabs.

## Tab Today

<Image align="center" className="border" border={true} src="https://files.readme.io/aecf47356cd5796fab23d663d6a852c079494e96c26b7e5dbe4c87d59475224e-image.png" />

The tab **Today** displays the pulse of your subscription business. It tells you what's happened to your subscribers base over the last 24 hours, and in particular:

* the number of new free trials (Introductory Offer)
* the number of new paid trial (Introductory Offer)
* the number of Offer Code / Promo code redeemed
* the number of Promotional Offer started
* the number of subscribers who started paying to the Regular Price (either after converting an Introductory Offer or straight away)
* the number of subscriptions renewed
* the number of new subscribers who entered in Grace Period after facing a billing issue
* the number of subscribers who churned - their subscription being terminated

<br />

## Tab Active subscriptions statuses

<Image align="center" className="border" border={true} src="https://files.readme.io/2475d22b3238406357307717781c6359c5ff451746859271d8f19ed73da780fc-image.png" />

The tab Active subscriptions statuses is the instant snapshot of your subscriber base. It displays the live number of **subscriptions**. 

A individual subscriber with several subscriptions will be counted as many times as they have subscriptions.

The dashboard is organized as follows:

* in columns, subscribers are organized by **Active subscription status**:
  * Column 1: subscribers who have the `auto-renewing enabled` 
  * Column 2: subscribers who have `canceled the auto-renewing` of their subscription 
  * Column 3: subscribers who are in `grace period` after facing a billing issue 
* in lines, subscribers are organized by **Active offer type**: ([more details](understanding-offer-types))
  * Line 1: subscribers paying the `Regular price`
  * Line 2: subscribers in `Free trial` (Introductory Offer)
  * Line 3: subscribers in `Paid trial` (Introductory Offer)
  * Line 4: subscribers customers benefitting from a `Promo code / Offer code`
  * Line 5: subscribers benefitting from a `Promotional Offer`

<br />

Below, pie-charts display the repartition of your subscriptions by store / subscription status / product / plan

<Image align="center" className="border" border={true} src="https://files.readme.io/91f4d0d0cb26779ead7245be97d95c173ee04535b633b7cc59a0414aeff416f4-image.png" />

<br />

## Tab Active subscribers

This tab tells you the proportion between **Connected subscribers** (who have signed-in / signed-up) and **Anonymous subscribers** (who did not create an account in your app).

![](https://files.readme.io/90c8f22a8633feca33abed59891afc787ae8dd2ca3088e481e49bd6d8566e8c3-image.png)

<br />

**Unknown users** are subscriptions which have been received through the S2S Notifications from the App stores. These receipts are not attached to any users and are therefore unknown, but still counted in the overall numbers. In general they result from subscriptions that have been purchased from an old version of the app which does not integrate the Purchasely SDK, or from subscriptions which have been purchased prior to the Purchasely SDK integration into your app.

[See Importing your active subscribers base for more details on Unknown users](subscribers-base-import)

<br />

## Tab Inactive subscriptions causes

This tab is an history of your subscriber base (since Purchasely was integrated into your app and plugged with your App stores accounts) and helps you understand the causes for which subscriptions are terminated:

* **Terminated** means that the user has terminated their subscription by canceling the auto-renewing
* **Refunded** means that the subscription has terminated after a refund
* **Unpaid** means that the subscription has been terminated after the billing retry period; the billing issue was still there and the billing retry attempts were stopped. The billing retry period lasts 60 days on the App Store and 30 days on the Play Store.
* **Paused** means that the subscription has been put on Pause. This feature only exists on the Play Store
* **Billing retry** means that the subscription has been terminated but is still in the billing retry period. Attempts are being made by the App store and the subscription can be resumed if one of the attempts succeeds.
* **Fraud attempts blocked** tells you the number of forged / invalid receipts that were received by the Purchasely platform and blocked. This forged receipts generally  occur on Android.
