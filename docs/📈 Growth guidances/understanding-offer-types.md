---
title: Understanding Offer Types
excerpt: >-
  This section provides an overlook of the different Offer Types that are
  available in the different app stores
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
When working with In-App Purchases and In-App Subscriptions, the price and offers are defined directly in the different app stores (App Store Connect and Google Play Store) and not via the Purchasely Platform.

Prices in the App Store work with a system of price points. It is not possible to define precisely the price you want, you need to choose among the price points proposed.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/eb35558-image.png",
        null,
        "Screenshot from the App Store Connect Console"
      ],
      "align": "center",
      "border": true,
      "caption": "Screenshot from the App Store Connect Console"
    }
  ]
}
[/block]


<br />

The stores propose different mechanisms to define the prices of your subscriptions, leverage discounted prices or offer free periods. They will help you acquire new subscribers, retain existing ones and win-back lapsed ones.  
Let us dig into them.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/7a89bc89c42bf73332ce1ea2c4bd0f0671ec4363b363d1a86595fe845a064375-Capture_decran_2025-08-14_a_11.31.54.png",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


# Regular Offer

This Offer is associated to the regular price that a subscriber shall pay when they are not benefitting from any promotion. 

- The price can be defined per territory in the currency of the territory
- You can either define the price in your preferred currency for a particular territory and then convert it automatically for all the other territories in which the Plan is available, or define specific prices per territory.

<br />

### Setting the price

To set the regular price subscription, follow the guides:

- [App Store](app-store-configuring-in-app-subscriptions#setting-subscription-price)
- [Play Store](play-store-configuring-in-app-subscriptions)

<br />

### Price change

You can plan in time price changes for a Plan. When you update the Price, you can choose wether the new pricing should apply only to new subscribers or to currently active subscribers too. 

More info:

- [Developer's guideline for managing prices and scheduling price changes (App Store)](https://developer.apple.com/help/app-store-connect/manage-app-pricing/schedule-price-changes)
- [Developer's guideline for price changes (Play Store)](https://developer.apple.com/help/app-store-connect/manage-app-pricing/schedule-price-changes)

In the latter case, active subscribers will have a price upgrade.

> 🚧 Beware with price upgrades
> 
> If you choose to increase the price of your subscription for active subscribers, there is a threshold on the App Store above which active subscribers will be prompted to give their consent for this price increase. If they don't, **their subscription will be automatically terminated**.
> 
> Have a close look at each app store guidelines before doing so, as we've already seen customers who lost a significant part of their subscription base by trying to upgrade de price too aggressively:
> 
> - [App Store guidelines about price upgrades and user consent](https://developer.apple.com/help/app-store-connect/manage-subscriptions/manage-pricing-for-auto-renewable-subscriptions/)
> - [Play Store guidelines about price upgrades and user consent](https://developer.android.com/google/play/billing/price-changes#communicate)

<br />

<br />

## Regular Offer in Purchasely

### Targeting users paying the regular price

To determine the Offer Type of a subscriber, you can leverage the [User Attribute](user-attributes-list) `Active Offer Type`  
(SDK version >= 4.2.0)

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/32179e8-Screenshot_2024-07-12_at_10.57.55.png",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

The same User Attribute exists for lapsed subscribers. It is called `Expired Sub. Offer Type` (SDK version >= 4.4.0). This reflects the Offer Type the user was benefitting from when the subscription expired.  
_E.g.: a user who did not convert their free trial will have the value `Expired Sub. Offer Type` = `Free Trial`._

<br />

### Webhooks

For [Server Events](server-events) sent on the webhook, the attribute `offer_type` has the value `NONE` when the user doesn't benefit from any offer at the time.

<br />

# Introductory Offer

This type of Offer allow you to **acquire new subscribers** by proposing a free trial and/or a discount limited in time.

- To avoid having users who terminate their subscription with the sole purpose of benefitting from the Introductory Offer again, the app stores integrate a mechanism to limit the eligibility of a User to this offer.
- The Purchasely SDK is able to determine the User eligibility to the Introductory Offer and depending on it, [adapt the Labels and Prices displayed in the Paywalls](labels-regular-price-vs-offer-prices). 

[More details on configuring an Introductory Offer in the App Store](app-store-configuring-in-app-subscriptions#adding-introductory-offers-and-free-trials)

[More details on configuring an Introductory Offer in the Play Store](play-store-configuring-in-app-subscriptions#creating-offer-plans)

<br />

## Introductory Offer in Purchasely

### Targeting users benefiting from an Introductory Offer

To determine the Offer Type of a subscriber, you can leverage the [User Attribute](user-attributes-list) `Active Offer Type`  
(SDK version >= 4.2.0) 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/758e5ca-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


This user attribute can take the following values:

- `Intro Offer`: User is benefitting from an Introductory Offer with a discounted price other than free
- `Free Trial`: User is benefitting from an Introductory Offer which consists in a free trial

<br />

The same User Attribute exists for lapsed subscribers. It is called `Expired Sub. Offer Type` (SDK version >= 4.4.0). This reflects the Offer Type the user was benefitting from when the subscription expired.  
_E.g.: a user who did not convert their free trial will have the value `Expired Sub. Offer Type` = `Free Trial`._

<br />

### Webhooks

For [Server Events](server-events) sent on the webhook, the attribute `offer_type` has the value `FREE_TRIAL` or `INTRO_OFFER` when the user is currently benefiting from an Introductory Offer.

<br />

### Associated Offer events

The [Offer Events](offer-events) associated to Introductory Offers are:

- `TRIAL_STARTED` / `TRIAL_CONVERTED` / `TRIAL_NOT_CONVERTED`
- `INTRO_OFFER_STARTED` / `INTRO_OFFER_CONVERTED` / `INTRO_OFFER_NOT_CONVERTED`

When the Introductory Offer is converted, users start paying the price associated to the Regular Offer (unless they've redeemed an Offer Code or have been retained with a Promotional Offer).

When the Introductory Offer is not converted, the subscription is terminated.

<br />

> 📘 Free Trial followed by an Introductory Offer
> 
> On Google it is possible to configure a Free Trial immediately followed by an Introductory Offer.
> 
> In this case, when the user will switch from the Free Trial to the Introductory Offer, 2 Offer events will be sent: `TRIAL_CONVERTED` and `INTRO_OFFER_STARTED`.

<br />

# Offer Code

This type of Offer provides a free or discounted price for subscriptions for a specific duration. 

- They require to create a code (either one time codes or generic codes) that can be redeemed by users inside the app or in the app stores. 
- It can be configured to be used by any type of subscriber (New, Active or Expired).
- It can either replace the Introductory Offer or come in addition to it (once the Introductory Offer is finished)

[More details on managing Offer Codes](offer-code)

<br />

## Offer Code in Purchasely

### Targeting users benefiting from an Offer Code

To determine the Offer Type of a subscriber, you can leverage the [User Attribute](user-attributes-list) `Active Offer Type`  
(SDK version >= 4.2.0) 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/5016a48-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


This user attribute can take the value `Promo Code`

<br />

The same User Attribute exists for lapsed subscribers. It is called `Expired Sub. Offer Type` (SDK version >= 4.4.0). This reflects the Offer Type the user was benefitting from when the subscription expired.  
_E.g.: a user who did not convert their Offer Code will have the value `Expired Sub. Offer Type` = `Promo Code`._

<br />

### Webhooks

For [Server Events](server-events) sent on the webhook, the attribute `offer_type` has the value `PROMO_CODE` when the user is currently benefiting from an Offer Code.

<br />

### Associated Offer events

The [Offer Events](offer-events) associated to Offer Codes are:

- `PROMO_CODE_STARTED` / `PROMO_CODE_CONVERTED` / `PROMO_CODE_NOT_CONVERTED`

When the Offer Code is converted, users start paying the price associated to the Regular Offer (unless they've redeemed another Offer Code or have been retained with a Promotional Offer).

When the Offer Code is not converted, the subscription is terminated.

<br />

# Promotional Offer

### App Store

In the App Store, this type of Offer provides a free period or discounted price for **auto-renewable** subscriptions (**non-renewing** subscription are not concerned).

- It can only be targeted to users having an active or lapsed **auto-renewable** subscription **in the same subscription group**.  This means that in the following cases, a user won't be able to benefit from a promotional offer (and it will fallback on the Introductory Offer if the user is eligible, on the regular price otherwise):
  - a new subscriber
  - a user who already purchased a consumable, non-consumable, non-renewing subscription but no auto-renewable subscription (it only works for auto-renewable subscriptions)
  - a user who already subscribed to an auto-renewable subscription, but in another subscription group (it only works if the auto-renewable subscription promoted by the promotional offer is in the same subscription group of a auto-renewable subscription already paid by your user)
- Even if the user never only subscribed to a Free Trial, he will be able to benefit from a promotional offer (it is a way to extend the free trial)

> 🚧 Minimal versions of iOS, macOS and tvOS
> 
> Customers can redeem promotional offers only on devices running **iOS 12.2** and later, **macOS 10.14.4** and later, and **tvOS 12.2** and later.

> 🚧 Targeting
> 
> It is the your responsibility to choose which Users you want to target the Offer to. In the Purchasely Console, you can do that by [creating Audience](audiences) leveraging the [User Subscription Attributes](user-attributes-list#built-in-active-subscription-attributes). This means that if you present the Offer to a non eligible User, it will fallback on the Introductory Offer if the user is eligible, on the regular price otherwise.

<br />

[More details on configuring a promotional offer in the App Store and Purchasely](promotional-offers-configuration)

<br />

### Play Store

In the Play Store, this type of Offer can be reproduced with the eligibility criteria set to "Developer determined".

<br />

> 🚧 Targeting
> 
> It is the your responsibility to choose which Users you want to target the Offer to. In the Purchasely Console, you can do that by [creating Audience](audiences) leveraging the [User Subscription Attributes](user-attributes-list#built-in-active-subscription-attributes). This means that if you present the Offer to a User, the Play Store will consider they are eligible to purchase it.

<br />

[More details on configuring developer determined offers in the Play Store and Purchasely](developer-determined-offers-configuration)

<br />

## Promotional Offer in Purchasely

### Targeting users benefiting from a Promotional Offer

To determine the Offer Type of a subscriber, you can leverage the [User Attribute](user-attributes-list) `Active Offer Type`  
(SDK version >= 4.2.0).

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/a2e1825-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


This user attribute can take the value `Promotional Offer`

<br />

The same User Attribute exists for lapsed subscribers. It is called `Expired Sub. Offer Type` (SDK version >= 4.4.0). This reflects the Offer Type the user was benefitting from when the subscription expired.  
_E.g.: a user who did not convert their Promotional Offer will have the value `Expired Sub. Offer Type` = `Promotional Offer`._

<br />

### Webhooks

For [Server Events](server-events) sent on the webhook, the attribute `offer_type` has the value `PROMOTIONAL_OFFER` when the user is currently benefiting from a Promotional Offer.

<br />

### Associated Offer events

The [Offer Events](offer-events) associated to Offer Codes are:

- `PROMOTIONAL_OFFER_STARTED` / `PPROMOTIONAL_OFFER_CONVERTED` / `PROMOTIONAL_OFFER_NOT_CONVERTED`

When the Promotional Offer is converted, users come back to paying the price associated to the Regular Offer (unless they've redeemed an Offer Code or have been retained with another Promotional Offer).

When the Promotional Offer is not converted, the subscription is terminated.