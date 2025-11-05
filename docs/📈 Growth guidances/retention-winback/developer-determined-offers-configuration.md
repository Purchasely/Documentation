---
title: Configuring developer determined offers
excerpt: >-
  This section provides details on how to configure developer determined offer
  in the Google Play Store and leverage them to offer promotions to your users
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
In this article we are going to describe the process to create promotional offers on [Google Play Console](https://play.google.com/console/) and [Purchasely Console](https://console.purchasely.io/)

# Google developer determined offers

Promotional offers for Google are Developer Determined Offer which can be set on your base plans for a subscription. It requires the usage of Google Play Billing v5 which is included in Purchasely SDK 4.0.0

<Image align="center" src="https://files.readme.io/7181896-image.png" />

<br />

> 🚧 Eligible to all users
>
> **Developer determined offer are available for all your users all the time**. As the name suggest, it is up to you to decide when to make this offer available.\
> Unfortunately Purchasely SDK cannot know the offer type, so by default this offer will be presented to all your users by our SDK.\
> To avoid this, you can add the tag **`ignore-offer`** (see below for more details)

To create an offer, go to your [application subscription](https://play.google.com/console/u/0/developers/app/subscriptions) and select *Add offer*

<Image align="center" className="border" border={true} src="https://files.readme.io/c9fdb46-Promotional_offers_4.webp" />

Then chose the base plan to apply this offer to

<Image align="center" className="border" border={true} src="https://files.readme.io/13ebb46-Promotional_offers_3.webp" />

Your offer must contain the following information:

* **Offer id**: you can chose anything, it will be the one you will fill in [Purchasely console](#purchasely-console)
* **Eligibility criteria**: Developer determined
* **Tags**: ignore-offer (see notice below) The tag should be exactly as mentioned. 
* **Phases**: you can add up to 2 phases, one free trial and one price discount

<Image align="center" className="border" border={true} src="https://files.readme.io/6e257d2-Promotional_offers_5.webp" />

<Image align="center" className="border" border={true} src="https://files.readme.io/dea1727-Promotional_offers_6.webp" />

<br />

<PromotionalOffersWarningTagIgnoreoffer />

# Purchasely Console

When your promotional offer has been created on AppStore Connect and/or Google Play Console, the final step is to declare it in Purchasely Console to use it with your paywall

First, click on the three dots of your plan and *Manage promotional offers*\
The plan MUST be the App Store or Play Store product that you used to declare your offer

<Image align="center" className="border" border={true} src="https://files.readme.io/9961a4a-SCR-20240620-puqr.png" />

Set a name, an identifier for Purchasely and the identifiers you have set in AppStore Connect and Google Play Console. Finally click Save to apply your changes

<Image align="center" className="border" border={true} src="https://files.readme.io/713b1d9-Promotional_offers_2.png" />

Then you can create a paywall for your offer, we have created a new action button for that: **Winback/retention offer**\
You need to select your plan and offer to be applied as the action for this button\
You can use the field "Offer" of the different labels to set offers [tags](tags) like `OFFER_PRICE` and `OFFER_DURATION` (same principle than trial offer)

<Image align="center" className="border" border={true} src="https://files.readme.io/ddcf33a-Promotional_offers.avif" />

You are responsible for displaying this paywall to users you want to target, so you should create a specific [placement](displaying-screens-placements) for them. You can also target them using [Audience](segmenting-your-user-base)

We will send specific events to your [webhook](webhook) or external integration:\
`PROMOTIONAL_OFFER_STARTED`

`PROMOTIONAL_OFFER_CONVERTED`

`PROMOTIONAL_OFFER_NOT_CONVERTED`

The information about the promotional offer will also be in the payload of events like the one above and `ACTIVATE`

`offer_type: "PROMOTIONAL_OFFER"`
