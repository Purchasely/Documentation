---
title: Creating retention & win-back strategies
excerpt: >-
  This section provides an overview of how you can leverage the Purchasely
  Platform to create powerful retention and win-back strategies
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Introduction

From the version 4.0 of the SDK onwards, Purchasely provides you with everything you need to create retention and win-back strategies, leveraging [Promotional Offers](promotional-offers), that allow you to offer a discounted price to:

- users with an active subscription in order to retain then and prevent them from churning
- lapsed subscribers (i.e.: users with an expired subscription) in order to win them back

<br />

![](https://files.readme.io/2788a8f-Product_demo_December_2_subscription_attributes.003.png)

<br />

![](https://files.readme.io/e3975f4-Product_demo_December_2_subscription_attributes.004.png)

![](https://files.readme.io/9341880-Product_demo_December_2_subscription_attributes.007.png)

<br />

<br />

# General principles

Purchasely provides you with Built-in User Attributes that allow to target users at every stage of their lifecycle

![](https://files.readme.io/63bc7bb-Product_demo_December_2_subscription_attributes.012.png)

Purchasely provides you with Built-in User Attributes that allow to target users at every stage of their lifecycle

- When they are not Premium Members yet, to try to turn them into loyal subscribers
- When they are in they are benefiting from the Introductory Offer
- When they are Premium Members paying the regular price
- When they're about to churn because they deactivated the Auto-renewing of their Subscription
- When they encounter a billing issue
- When their premium membership has expired and has not been renewed (win-back)

<br />

# Sample Use cases

### 1. Convincing free users to give a try to your subscription (freemium products)

![](https://files.readme.io/7fd1e8d-image.png)

Tips:

- Free users do not have an active subscription (User Attribute `Has Active Sub.` = `false`)
- The number of Paywalls dismissed is provided by the User Attribute `Number of paywalls / screens dismissed`
- By combining the 2 attributes inside an Audience, you can target specifically these sticky freemium users with a more agressive promotion

<br />

### 2. Converting free trial users to paid

![](https://files.readme.io/acc2185-image.png)

Tips:

- The User Attribute `Active Offer Type` (= `FREE_TRIAL` or `INTRO_OFFER`) carries the type of Offer the subscriber is currently benefiting
- The User Attribute `Active Subscription Status` (= `AUTO_RENEWING CANCELED`) tells you that the user will probably churn at the end of their introductory offer
- Leverage these 2 attributes to target them with a discount when they cancel the auto-renewing of their subscription.

### 3. Upsell monthly subscribers to yearly subscribers

![](https://files.readme.io/cf38624-image.png)

![](https://files.readme.io/7df213a-image.png)

Tips:

- The User Attribute `Active Plan` can be used to identify users on the shorter Plans (e.g.: Monthly or Weekly)
- The User Attribute `Active Sub. start date` provides you the date at which the Subscription was started
- Combine these attributes to identify loyal subscribers who started their subscription a few billing cycles ago and are likely to be interested in switching to an annual plan

### 4. Involuntary churn mitigation

![](https://files.readme.io/32baf53-image.png)

Tips:

- The User Attribute `Subscription Status` = `GRACE_PERIOD` can be used to identify users in grace period (i.e.: encountering a billing issue but still benefiting from the premium membership for a few days)
- The User Attribute `Expired Sub. Status` = `BILLING_RETRY` can be used to identify users in billing retry (i.e.: encountering a billing issue with no more access to the premium membership)

<br />

### 5. Winning-back lapsed subscribers

![](https://files.readme.io/f56d906-image.png)

Tips:

- The set of [User Attributes Expired Subscription](user-attributes-list#built-in-expired-subscription-attributes) provide you with all the details you need
- You can target loyal members with aggressive discount to try to win them back or leverage Promotional Offers to offer a second chance Introductory Offer (such as a Free trial).

<br />

# Process for configuring Win-back & Retention Strategies

Retention and Win-back strategies rely on Promotional Offers. The general process for setting up such strategies is the following:

1. Offer & Paywall Configuration
   1. [Create your Promotional Offers (App Store)](promotional-offers-configuration) or [Developer Determined Offer](developer-determined-offers-configuration) (Play Store) and map it with a Plan in the Purchasely Console
   2. [Associate your Promotional Offer with a Paywall](promotional-offers-configuration#associating-a-promotional-offer-with-a-paywall)
2. Targeting

   1. [Create an audience](audiences) by leveraging the appropriate [user attributes](user-attributes-list#built-in-active-subscription-attributes) in order to display the Paywall integrating your Promotional Offer to the relevant users

      ![](https://files.readme.io/23e32fd-image.png)
   2. [Map this Audience and Paywall with a Placement](leveraging-audiences)
3. Triggering

   - The trigger can be either done through your usual [Engagement / CRM Platform](engagement-crm) by activating the Integration with Purchasely and then using the Placement deeplink to link back the Push Notifications or In-App messages to the relevant offer
   - You can also create a Placement dedicated to such Promotions, that will map the Audiences and corresponding Paywalls, and will be deactivated for other users (_everyone else_) who are not concerned by any promotion

     [block:image]{"images":[{"image":["https://files.readme.io/5df123c-image.png",null,"The placement `PROMOTIONS` is called by the App every time the app gets launched. Users who belong to one of the associated audiences will see the corresponding Paywalls, users who are not will fall in Everyone else and therefore not see any Paywall (NONE)"],"align":"center","border":true,"caption":"The placement `PROMOTIONS` is called by the App every time the app gets launched. Users who belong to one of the associated audiences will see the corresponding Paywalls, users who are not will fall in Everyone else and therefore not see any Paywall (NONE)"}]}[/block]

       Note: to implement this strategy, you need to use the [pre-fetching method to display Placements into your app](pre-fetching)