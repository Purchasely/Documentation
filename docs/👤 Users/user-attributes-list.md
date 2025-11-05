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

* Built-in User Attributes
  1. [Natives attributes](#built-in-native-attributes)
  2. [Engagement attributes](#built-in-engagement-attributes)
  3. [Active Subscription attributes](#built-in-active-subscription-attributes)
  4. [Expired Subscription attributes](#built-in-expired-subscription-attributes)
* [Custom User Attributes](custom-user-attributes)

<br />

## Built-in Native attributes

This set of attributes are built-in (automatically gathered by the SDK) and concern the device, the app or the users.

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Name
      </th>

      <th>
        Explanation
      </th>

      <th>
        SDK requirement
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        **App version**
      </td>

      <td>
        Your application version the user currently using. Eg: 3.6.1.
      </td>

      <td>

      </td>
    </tr>

    <tr>
      <td>
        **Device type**
      </td>

      <td>
        The user device type. It will be one of the following: ***Phone, Pad, TV, Computer, Car* **and**unknown**.
      </td>

      <td>

      </td>
    </tr>

    <tr>
      <td>
        **Language**
      </td>

      <td>
        This parameter is generally defined at the device level, but can be overriden at the app level in the phone settings.\
        App language: ***en,fr,ja***.
      </td>

      <td>

      </td>
    </tr>

    <tr>
      <td>
        **Store Country**
      </td>

      <td>
        User iOS store country:  

        * \*JPN,USA,RUS\*\*.
      </td>

      <td>
        Only for iOS for SDK versions \< 4.4.0.  

        iOS & Android for SDK versions ≥ 4.4.0 
      </td>
    </tr>

    <tr>
      <td>
        **Store name**
      </td>

      <td>
        App store name: ***Apple App Store, Google Play Store***.
      </td>

      <td>

      </td>
    </tr>

    <tr>
      <td>
        **OS version**
      </td>

      <td>
        User device OS version Eg: 17.3.1.
      </td>

      <td>

      </td>
    </tr>

    <tr>
      <td>
        **SDK version**
      </td>

      <td>
        Purchasely SDK version Eg: 4.2.1.
      </td>

      <td>

      </td>
    </tr>

    <tr>
      <td>
        **Anonymous id**
      </td>

      <td>
        If the user didn't create an account, Purchasely creates anonymous id.\
        This attribute is meant to be used rather for testing purposes to target a specific anonymous user.
      </td>

      <td>

      </td>
    </tr>

    <tr>
      <td>
        **User id**
      </td>

      <td>
        User id assigned by the application. It's created when the user creates an account in your application.
      </td>

      <td>

      </td>
    </tr>

    <tr>
      <td>
        **Is logged in**
      </td>

      <td>
        If the user has already created an account in your app or not.
      </td>

      <td>

      </td>
    </tr>

    <tr>
      <td>
        **Country(IP)**
      </td>

      <td>
        User location country determined from the IP address.
      </td>

      <td>

      </td>
    </tr>

    <tr>
      <td>
        **Cumulated revenue in USD**
      </td>

      <td>
        The cumulated revenue for expired and active subscription. The currency is in dollars only.
      </td>

      <td>
        4.4.0
      </td>
    </tr>
  </tbody>
</Table>

## Built-in Engagement Attributes

*SDK requirement: 4.2.0 and above*

These attributes correspond to data about the user engagement in your application. The elements we take into account are app sessions, interaction with paywalls and placements. 

You can leverage them to determine how engaged is a user how they've been exposed to paywalls and screens managed by the Purchasely SDK.

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Name
      </th>

      <th>
        Explanation
      </th>

      <th>
        SDK requirement
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        **App sessions**
      </td>

      <td>
        Number of times the app was launched by the user. A new session is counted:  

        * When the SDK is initialized (restarted after being killed by the user or the operating system).
        * When the application has been in background for more than 30 minutes
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Consecutive days opened**
      </td>

      <td>
        Total number of days the user visited consecutively, if they missed one day then the counter will restart.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Number of paywalls / screens dismissed**
      </td>

      <td>
        Total number of paywalls or other screens (created in Purchasely paywall builder) was closed by the user.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Number of paywalls / screens displayed**
      </td>

      <td>
        Total number of paywalls or other screens(created in Purchasely paywall builder) was displayed to the user.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Last app session date**
      </td>

      <td>
        It is the latest date and time there was an activity in the application.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Last paywall / screen dismissed**
      </td>

      <td>
        Its the latest paywall screen that was closed by the user.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Last paywall / screen dismissed date**
      </td>

      <td>
        Its the date and time latest paywall screen that was closed by the user.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Last paywall / screen displayed**
      </td>

      <td>
        Its the latest paywall screen that was displayed to the user.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Last paywall / screen displayed date**
      </td>

      <td>
        Its the date and time latest paywall screen that was displayed to the user.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Last paywall converted**
      </td>

      <td>
        It is the paywall from which user started their subscription or trial.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Last placement converted**
      </td>

      <td>
        It is the placement from which user started their subscription or trial.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Last placement displayed**
      </td>

      <td>
        It's the latest placement that was displayed to the user.
      </td>

      <td>
        4.2.0
      </td>
    </tr>
  </tbody>
</Table>

<br />

## Built-in Active Subscription Attributes

*SDK requirement: 4.2.0 and above*\
*OS Version requirement: iOS 15 and above*

These attributes allow you to target any subscribers that are active at the given moment.

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Name
      </th>

      <th>
        Explanation
      </th>

      <th>
        SDK requirement
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        **Active offer type**
      </td>

      <td>
        The type of special offer the user is enjoying right now. It can be either one of the following:  

        * **Free trial**\_: User is in free trial  
        * **Promotional Offer**\_: User is benefitting from a promotional offer.  
        * **Intro Offer**\_: User is benefitting from a discounted introductory price (not free).  
        * **Promo code**\_: User has redeemed a Promo code and the associated promotion is still valid.  
        * \**None*\*\*: User is paying the full price (regular price) for the subscription.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Active plan**
      </td>

      <td>
        The name of the plan the user is currently in and actively renewing.  

        It is either one of the plans you have created in products and plans in the Purchasely console.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Active promotional offer**
      </td>

      <td>
        The name of the promotional offer (if any) the user is currently benefitting.  

        If the value is set, the attribute Active offer type will be set to Promotional offer.  

        It is either one of the promotional offers created in the products and plans in the Purchasely console.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Has active subscription**
      </td>

      <td>
        If the user has an active subscription.  

        It can be either ***true*** or ***false***.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Has expired subscription**
      </td>

      <td>
        If the user had a subscription in the past.  

        It can be either ***true*** or ***false***.  

        To target lapsed users, you will need to build an audience combining Has active subscription = false.  

        and  

        Has expired subscription = true.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Has non consumable (or lifetime sub)**
      </td>

      <td>
        If the user has purchased non consumable. This type of plan is also used to model Lifetime subscriptions.  

        It can be either ***true*** or ***false***.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Start date**
      </td>

      <td>
        The start date and time of the subscription (= time of the initial purchase)
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Next renewal date**
      </td>

      <td>
        The date and time of the next billing of the user subscription.  

        If the user is in **Free trial** or **Intro offer**, the next renewal date will be filled in with the end date of the **Free trial** or **Intro offer**.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Subscription status**
      </td>

      <td>
        The status of the subscription. It can be either one of the below:  

        * **Auto Renewing**\_: Subscribers with an active auto-renewing subscription.  
        * \**Auto Renewing canceled*\*\*: Subscribers who have canceled the auto-renewing of their subscription.  
        * \**Grace period*\*\*: Subscribers who are past their billing date but still enjoying their premium features.
      </td>

      <td>
        4.2.0
      </td>
    </tr>
  </tbody>
</Table>

<br />

## Built-in Expired Subscription Attributes

*SDK requirement: 4.4.0 and above*\
*OS Version requirement: iOS 15 and above*

These attributes allow you to target users that have expired at the given moment. 

For this set of attributes to work, it is mandatory that the transaction has been processed (`full` mode) OR observed (`paywallObserver` mode) by the Purchasely Platform, so that we can keep a record of the subscription in our database.

A new record in the database is made every time:

* a user subscribes to a new subscription
* a subscriber upgrades or downgrades their subscription
* the subscriber opens a version of the app integrating the Purchasely SDK after the subscription has been updated (e.g: renewed, terminated, subscription status changed from auto-renewing to cancelled etc...)
* the subscriber restores their subscription from a version of the app integrating the Purchasely SDK
* the subscriber has been [imported](subscribers-base-import) in our database when we started the partnership

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

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Name
      </th>

      <th>
        Explanation
      </th>

      <th>
        SDK requirement
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        **Has expired subscription**
      </td>

      <td>
        If the user had a subscription in the past.  

        It can be either ***true*** or ***false***.  

        To target lapsed subscribers, you will need to build an audience combining Has active subscription = false.  

        and  

        Has expired subscription = true.
      </td>

      <td>
        4.2.0
      </td>
    </tr>

    <tr>
      <td>
        **Expired sub. Status**
      </td>

      <td>
        The lapsed subscription status. It will be either one of the following:  

        * **Onhold**\_: The user is in the billing retry state.  
        * **Deactivated**\_: The user voluntarily terminated their subscription.  
        * **Revoked**\_: The user requested for the refund and revoked their subscription.  
        * **Paused**\_: The user has paused the subscription instead of terminated it. It is available only for Android users.  
        * \**Unpaid*\*\*: The billing retry has ended. 
      </td>

      <td>
        4.4.0
      </td>
    </tr>

    <tr>
      <td>
        **Expired subscription offer type**
      </td>

      <td>
        The offer type of the expired subscription when it got terminated. It can have one of the following values:  

        * \*Free Trial\*\*: User was in Free Trial.  
        * \*Promotional Offer\*\*: User was benefitting from a promotional offer.  
        * \*Intro Offer\*\*: User was benefitting from a discounted introductory price (not free)  
        * \*Promo Code\*\*: User was benifiting from a Promo Code.  
        * \*None\*\*: User was paying the full price (regular price) for the subscription
      </td>

      <td>
        4.4.0
      </td>
    </tr>

    <tr>
      <td>
        **Expired subscription plan**
      </td>

      <td>
        The name of the plan for which the user's subscription expired or its the last subscription the user had.  The value is one of the plans you have created in Products and Plans in the Purchasely console.
      </td>

      <td>
        4.4.0
      </td>
    </tr>

    <tr>
      <td>
        **Expired subscription promotional offer**
      </td>

      <td>
        The name of the promotional offer the user had before their subscription expired.  

        If the value is set, the attribute**Expired subscription offer type** will be set to Promotional offer.  

        The value is the promotional offers you have created in the products and plans in the Purchasely console.
      </td>

      <td>
        4.4.0
      </td>
    </tr>

    <tr>
      <td>
        **Expired subscription Start date**
      </td>

      <td>
        The start date of the last subscription the user had.
      </td>

      <td>
        4.4.0
      </td>
    </tr>

    <tr>
      <td>
        **Expired subscription Expiry date**
      </td>

      <td>
        The exact date of the user subscription expired.
      </td>

      <td>
        4.4.0
      </td>
    </tr>

    <tr>
      <td>
        **Expired subscription duration (days)**
      </td>

      <td>
        The duration of the subscription, from the start date to the end date, in days.
      </td>

      <td>
        4.4.0
      </td>
    </tr>

    <tr>
      <td>
        **Expired subscription duration (weeks)**
      </td>

      <td>
        The duration of the subscription, from the start date to the end date, in weeks.
      </td>

      <td>
        4.4.0
      </td>
    </tr>

    <tr>
      <td>
        **Expired subscription duration (months)**
      </td>

      <td>
        The duration of the subscription, from the start date to the end date, in months.
      </td>

      <td>
        4.4.0
      </td>
    </tr>
  </tbody>
</Table>

## Custom Attributes

<CustomUserAttributesDefinition />

[More details on how to manage Custom User Attributes and manipulate them in the app code](custom-user-attributes)
