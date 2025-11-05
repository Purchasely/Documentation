---
title: Understanding the different types of User Attributes
excerpt: This section provides details on user attributes
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: More details on how to leverage User Attributes to create Audiences
  pages:
    - type: basic
      slug: audiences
      title: Configuring Audiences
---
User attributes are user-specific information that you can pass through your mobile application and it can be used to segment your user base, thanks to the Audience feature. Purchasely offers different types of Built-in User Attributes and also lets you create Custom User Attributes. 

The different types of attributes are:

- Built-in User Attributes
  1. [Natives attributes](#built-in-native-attributes)
  2. [Engagement attributes](#built-in-engagement-attributes)
  3. [Active Subscription attributes](#built-in-active-subscription-attributes)
  4. [Expired Subscription attributes](#built-in-expired-subscription-attributes)
- [Custom User Attributes](custom-user-attributes)

<br />

## Built-in Native attributes

This set of attributes are built-in (automatically gathered by the SDK) and concern the device, the app or the users.

[block:parameters]
{
  "data": {
    "h-0": "Name",
    "h-1": "Explanation",
    "h-2": "SDK requirement",
    "0-0": "**App version**",
    "0-1": "Your application version the user currently using. Eg: 3.6.1.",
    "0-2": "",
    "1-0": "**App Install date**",
    "1-1": "Installation date of the application",
    "1-2": "5.1.0",
    "2-0": "**Device type**",
    "2-1": "The user device type. It will be one of the following: **_Phone, Pad, TV, Computer, Car_ **and** unknown**.",
    "2-2": "",
    "3-0": "**Language**",
    "3-1": "This parameter is generally defined at the device level, but can be overriden at the app level in the phone settings.  \nApp language: **_en,fr,ja_**.",
    "3-2": "",
    "4-0": "**Store Country**",
    "4-1": "User iOS store country:  \n  \n**JPN,USA,RUS**.",
    "4-2": "Only for iOS for SDK versions \\< 4.4.0.  \n  \niOS & Android for SDK versions ≥ 4.4.0 ",
    "5-0": "**Store name**",
    "5-1": "App store name: _**Apple App Store, Google Play Store**_.",
    "5-2": "",
    "6-0": "**OS version**",
    "6-1": "User device OS version Eg: 17.3.1.",
    "6-2": "",
    "7-0": "**SDK version**",
    "7-1": "Purchasely SDK version Eg: 4.2.1.",
    "7-2": "",
    "8-0": "**Anonymous id**",
    "8-1": "If the user didn't create an account, Purchasely creates anonymous id.  \nThis attribute is meant to be used rather for testing purposes to target a specific anonymous user.",
    "8-2": "",
    "9-0": "**User id**",
    "9-1": "User id assigned by the application. It's created when the user creates an account in your application.",
    "9-2": "",
    "10-0": "**Is logged in**",
    "10-1": "If the user has already created an account in your app or not.",
    "10-2": "",
    "11-0": "**Country(IP)**",
    "11-1": "User location country determined from the IP address.",
    "11-2": "",
    "12-0": "**Cumulated revenue in USD**",
    "12-1": "The cumulated revenue for expired and active subscription. The currency is in dollars only.",
    "12-2": "4.4.0"
  },
  "cols": 3,
  "rows": 13,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


## Built-in Engagement Attributes

_SDK requirement: 4.2.0 and above_

These attributes correspond to data about the user engagement in your application. The elements we take into account are app sessions, interaction with paywalls and placements. 

You can leverage them to determine how engaged is a user how they've been exposed to paywalls and screens managed by the Purchasely SDK.

[block:parameters]
{
  "data": {
    "h-0": "Name",
    "h-1": "Explanation",
    "h-2": "SDK requirement",
    "0-0": "**App sessions**",
    "0-1": "Number of times the app was launched by the user. A new session is counted:  \n  \n- When the SDK is initialized (restarted after being killed by the user or the operating system).\n- When the application has been in background for more than 30 minutes",
    "0-2": "4.2.0",
    "1-0": "**Consecutive days opened**",
    "1-1": "Total number of days the user visited consecutively, if they missed one day then the counter will restart.",
    "1-2": "4.2.0",
    "2-0": "**Total number of Screens displayed**",
    "2-1": "Total number of paywalls or other screens (created with Purchasely) displayed to the user.",
    "2-2": "4.2.0",
    "3-0": "**Total number of Screens dismissed**",
    "3-1": "Total number of paywalls or other screens (created with Purchasely) closed by the user.",
    "3-2": "4.2.0",
    "4-0": "**Screen display count**",
    "4-1": "Number of times a given Screen (created with Purchasely) has been displayed. Each Screen displayed can be counted individually.",
    "4-2": "5.1.0",
    "5-0": "**Screen dismiss count**",
    "5-1": "Number of times a given Screen (created with Purchasely) has been dismissed. Each Screen dismissed by the user can be counted individually.",
    "5-2": "5.1.0",
    "6-0": "**Placement display count**",
    "6-1": "Number of times a given Placement has been displayed. Each Placement displayed can be counted individually.",
    "6-2": "5.1.0",
    "7-0": "**Placement dismiss count**",
    "7-1": "Number of times a given Placement has been dismissed. Each Placement dismissed by the user can be counted individually.",
    "7-2": "5.1.0",
    "8-0": "**Last app session date**",
    "8-1": "Latest date and time there was an activity in the application.",
    "8-2": "4.2.0",
    "9-0": "**Last Screen displayed**",
    "9-1": "Latest  Screen that was displayed to the user.",
    "9-2": "4.2.0",
    "10-0": "**Last Screen displayed date**",
    "10-1": "Date and time at which the latest Screen was displayed to the user.",
    "10-2": "4.2.0",
    "11-0": "**Last Screen dismissed**",
    "11-1": "Latest Screen that was dismissed by the user.",
    "11-2": "4.2.0",
    "12-0": "**Last Screen dismissed date**",
    "12-1": "Date and time at which the latest Screen was closed by the user.",
    "12-2": "4.2.0",
    "13-0": "**Last Screen converted**",
    "13-1": "Latest Screen from which the user started their subscription or trial.",
    "13-2": "4.2.0",
    "14-0": "**Last placement displayed**",
    "14-1": "Latest Placement that was displayed to the user.",
    "14-2": "4.2.0",
    "15-0": "**Last Placement converted**",
    "15-1": "Latest Placement from which the user started their subscription or trial.",
    "15-2": "4.2.0",
    "16-0": "**Screen last displayed at**",
    "16-1": "Latest display date and time for each given Screen",
    "16-2": "5.1.0",
    "17-0": "**Screen last dismissed at**",
    "17-1": "Latest dismissed date and time for each given Screen",
    "17-2": "5.1.0",
    "18-0": "**Placement last displayed at**",
    "18-1": "Latest display date and time for each given Placement",
    "18-2": "5.1.0",
    "19-0": "**AB Test**",
    "19-1": "A/B test IDs and associated variant ID for each A/B test the user has been exposed to",
    "19-2": "5.1.0",
    "20-0": "**Last AB Test exposed**",
    "20-1": "Latest A/B test ID the user has been exposed to",
    "20-2": "5.1.0",
    "21-0": "**Last AB Test Variant exposed**",
    "21-1": "Latest A/B test Variant ID the user has been associated with",
    "21-2": "5.1.0"
  },
  "cols": 3,
  "rows": 22,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


<br />

## Built-in Active Subscription Attributes

_SDK requirement: 4.2.0 and above_  
_OS Version requirement: iOS 15 and above_

These attributes allow you to target any subscribers that are active at the given moment.

[block:parameters]
{
  "data": {
    "h-0": "Name",
    "h-1": "Explanation",
    "h-2": "SDK requirement",
    "0-0": "**Active offer type**",
    "0-1": "The type of special offer the user is enjoying right now. It can be either one of the following:  \n  \n_**Free trial**_: User is in free trial  \n  \n_**Promotional Offer**_: User is benefitting from a promotional offer.  \n  \n_**Intro Offer**_: User is benefitting from a discounted introductory price (not free).  \n  \n_**Promo code**_: User has redeemed a Promo code and the associated promotion is still valid.  \n  \n**_None_**: User is paying the full price (regular price) for the subscription.",
    "0-2": "4.2.0",
    "1-0": "**Active plan**",
    "1-1": "The name of the plan the user is currently in and actively renewing.  \n  \nIt is either one of the plans you have created in products and plans in the Purchasely console.",
    "1-2": "4.2.0",
    "2-0": "**Active promotional offer**",
    "2-1": "The name of the promotional offer (if any) the user is currently benefitting.  \n  \nIf the value is set, the attribute Active offer type will be set to Promotional offer.  \n  \nIt is either one of the promotional offers created in the products and plans in the Purchasely console.",
    "2-2": "4.2.0",
    "3-0": "**Has active subscription**",
    "3-1": "If the user has an active subscription.  \n  \nIt can be either **_true_** or **_false_**.",
    "3-2": "4.2.0",
    "4-0": "**Has expired subscription**",
    "4-1": "If the user had a subscription in the past.  \n  \nIt can be either **_true_** or **_false_**.  \n  \nTo target lapsed users, you will need to build an audience combining Has active subscription = false.  \n  \nand  \n  \nHas expired subscription = true.",
    "4-2": "4.2.0",
    "5-0": "**Has non consumable (or lifetime sub)**",
    "5-1": "If the user has purchased non consumable. This type of plan is also used to model Lifetime subscriptions.  \n  \nIt can be either **_true_** or **_false_**.",
    "5-2": "4.2.0",
    "6-0": "**Start date**",
    "6-1": "The start date and time of the subscription (= time of the initial purchase)",
    "6-2": "4.2.0",
    "7-0": "**Next renewal date**",
    "7-1": "The date and time of the next billing of the user subscription.  \n  \nIf the user is in **Free trial** or **Intro offer**, the next renewal date will be filled in with the end date of the **Free trial** or **Intro offer**.",
    "7-2": "4.2.0",
    "8-0": "**Subscription status**",
    "8-1": "The status of the subscription. It can be either one of the below:  \n  \n_**Auto Renewing**_: Subscribers with an active auto-renewing subscription.  \n  \n**_Auto Renewing canceled_**: Subscribers who have canceled the auto-renewing of their subscription.  \n  \n**_Grace period_**: Subscribers who are past their billing date but still enjoying their premium features.",
    "8-2": "4.2.0"
  },
  "cols": 3,
  "rows": 9,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


<br />

## Built-in Expired Subscription Attributes

_SDK requirement: 4.4.0 and above_  
_OS Version requirement: iOS 15 and above_

These attributes allow you to target users that have expired at the given moment. 

For this set of attributes to work, it is mandatory that the transaction has been processed (`full` mode) OR observed (`paywallObserver` mode) by the Purchasely Platform, so that we can keep a record of the subscription in our database.

A new record in the database is made every time:

- a user subscribes to a new subscription
- a subscriber upgrades or downgrades their subscription
- the subscriber opens a version of the app integrating the Purchasely SDK after the subscription has been updated (e.g: renewed, terminated, subscription status changed from auto-renewing to cancelled etc...)
- the subscriber restores their subscription from a version of the app integrating the Purchasely SDK
- the subscriber has been [imported](subscribers-base-import) in our database when we started the partnership

Depending on whether an import has been made or not and on the duration of the partnership - the longer the more likely we are to have an exhaustive view of your base - the Purchasely Platform might not have a comprehensive overview of all your lapsed subscribers. However, all the lapsed subscribers we will have in our database will be accurate. In other words, the data we have cannot be wrong.

<ExpiredSubscriptionAttributesLimitations />

> 📘 Expired subscriptions
> 
> These attributes can be set and filled-in even for users who still have an active subscription. If the user has terminated their subscription, then resubscribed later, the first subscription will be considered as an expired subscription. Even if the user resubscribed to the same plan.
> 
> If a user has several expired subscription, only the last one will be reflected in the attributes.
> 
> However, the **Expired Sub. Cumulated Revenue** corresponds the sum of all the revenue generated by each expired subscription into consideration.

<br />

[block:parameters]
{
  "data": {
    "h-0": "Name",
    "h-1": "Explanation",
    "h-2": "SDK requirement",
    "0-0": "**Has expired subscription**",
    "0-1": "If the user had a subscription in the past.  \n  \nIt can be either **_true_** or **_false_**.  \n  \nTo target lapsed subscribers, you will need to build an audience combining Has active subscription = false.  \n  \nand  \n  \nHas expired subscription = true.",
    "0-2": "4.2.0",
    "1-0": "**Expired sub. Status**",
    "1-1": "The lapsed subscription status. It will be either one of the following:  \n  \n_**Onhold**_: The user is in the billing retry state.  \n  \n_**Deactivated**_: The user voluntarily terminated their subscription.  \n  \n_**Revoked**_: The user requested for the refund and revoked their subscription.  \n  \n_**Paused**_: The user has paused the subscription instead of terminated it. It is available only for Android users.  \n  \n**_Unpaid_**: The billing retry has ended. ",
    "1-2": "4.4.0",
    "2-0": "**Expired subscription offer type**",
    "2-1": "The offer type of the expired subscription when it got terminated. It can have one of the following values:  \n  \n**Free Trial**: User was in Free Trial.  \n  \n**Promotional Offer**: User was benefitting from a promotional offer.  \n  \n**Intro Offer**: User was benefitting from a discounted introductory price (not free)  \n  \n**Promo Code**: User was benifiting from a Promo Code.  \n  \n**None**: User was paying the full price (regular price) for the subscription",
    "2-2": "4.4.0",
    "3-0": "**Expired subscription plan**",
    "3-1": "The name of the plan for which the user's subscription expired or its the last subscription the user had.  The value is one of the plans you have created in Products and Plans in the Purchasely console.",
    "3-2": "4.4.0",
    "4-0": "**Expired subscription promotional offer**",
    "4-1": "The name of the promotional offer the user had before their subscription expired.  \n  \nIf the value is set, the attribute** Expired subscription offer type** will be set to Promotional offer.  \n  \nThe value is the promotional offers you have created in the products and plans in the Purchasely console.",
    "4-2": "4.4.0",
    "5-0": "**Expired subscription Start date**",
    "5-1": "The start date of the last subscription the user had.",
    "5-2": "4.4.0",
    "6-0": "**Expired subscription Expiry date**",
    "6-1": "The exact date of the user subscription expired.",
    "6-2": "4.4.0",
    "7-0": "**Expired subscription duration (days)**",
    "7-1": "The duration of the subscription, from the start date to the end date, in days.",
    "7-2": "4.4.0",
    "8-0": "**Expired subscription duration (weeks)**",
    "8-1": "The duration of the subscription, from the start date to the end date, in weeks.",
    "8-2": "4.4.0",
    "9-0": "**Expired subscription duration (months)**",
    "9-1": "The duration of the subscription, from the start date to the end date, in months.",
    "9-2": "4.4.0"
  },
  "cols": 3,
  "rows": 10,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


## Custom Attributes

<CustomUserAttributesDefinition />

[More details on how to manage Custom User Attributes and manipulate them in the app code](custom-user-attributes)