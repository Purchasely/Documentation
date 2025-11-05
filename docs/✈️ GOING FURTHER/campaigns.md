---
title: Driving engagement and retention with Campaigns
excerpt: This page provides details about the Campaigns feature
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The **Campaigns** feature lets you create powerful no-code automations that will display a Purchasely Screen for a particular Audience at the App start.

They are particularly useful to:

* Convert users by proposing limited-time offers or discounts
* Implement retention strategies leveraging Promotional Offers targeting active subscribers about to Churn (voluntarily or involuntarily)
* Create win-back strategies leveraging Promotional Offer for lapsed subscribers
* Run user research or collect user insights by publishing surveys to targeted users

<br />

**⚠️ The Minimum SDK version required to use this feature is 5.1.0**

# Configuring a Campaign

![](https://files.readme.io/5e6c2bb732f089f51d64514f13f3525df0742f497c8189483aa57f5aea57f5c0-image.png)

<br />

## How to set up a Campaign ?

For each campaign, you can define:

* **WHO** will be targeted by associating it with an Audience
* **WHEN** the campaign should trigger and define capping parameters
* **WHAT** Screen(s) should be displayed by selecting a Purchasely Screen or running an A/B test.

<br />

### Name and ID:

Set the name of your campaign and id. The name and ID you set here, helps you track the campaign performance within Purchasely. 

💡Adding a category lets you better organize the list of campaigns. 

<Image align="center" className="border" border={true} src="https://files.readme.io/8aefde9f6d1dbf09521a0caed643b7fe47d47dac5d0b1b16c1cccf7d609eb1ce-Screen_Recording_2025-03-17_at_08.18.47.gif" />

### WHO - Audience:

Choose the [audience](https://docs.purchasely.com/docs/audiences) whom you would like to run this campaign for.

<Image align="center" className="border" border={true} src="https://files.readme.io/39f15535bfa0e07b78da0bb8dd36249eebe44661cc65c629cbf5d5d0bea21add-who.gif" />

If you haven't configured the desired audience yet, you can click on `+ Create new audience` and define your audience in the modale.

<br />

### When: Scheduling,Trigger, Capping

You can customize the following parameters to fine-tune your campaign behavior:

1. **Start date and time & end date & time** : Define the campaign’s activation and expiration times to automate promotional events (e.g., Black Friday sales) without requiring manual intervention in the Purchasely Console.\
   All times are expressed in UTC/GMT.
2. **Trigger**:By default, a campaign starts when the APP\_STARTED event is triggered. This event occurs:
   * When the app is launched for the first time.
   * After the app is restarted following termination by the operating system (typically due to prolonged inactivity).
   * When the user manually relaunches the app.
     > ℹ️ `APP_STARTED` and other events
     >
     > For now, the `APP_STARTED` event is the only one allowed but new events will be possible to use as a trigger in the months to come.
3. **Frequency cap**: Control how often the campaign is displayed to prevent overexposure and user fatigue. This configuration ensures a seamless and non-intrusive campaign experience for users while maximizing engagement.\
   The frequency cap can be configured in two ways:

   * **Session-based**: Limits campaign display based on app session count. 

     *Example: If set to trigger every 3 sessions, the campaign will appear at most once every 3 app launches.*

     <Image align="center" className="border" border={true} src="https://files.readme.io/79a76de98e475eeb7b6f87a7cf4502b584181da11166167e052555be65036a62-image.png" />

     Note: the SDK generates a new session after 30 minutes of inactivity
   * **Period-based**: Enforces a minimum time gap between consecutive displays.

     *Example: If set to a 2-day interval, the campaign will not be shown again until at least 48 hours have passed since the last display.*

     <Image align="center" className="border" border={true} src="https://files.readme.io/eac0d395868e99e591d7f9062d723345a35d57545e56d88ebb2b9edfb0a1e008-image.png" />

     <br />
4. **Impression cap**: Restricts the total number of times a user can see the campaign throughout its duration.

   *Example: If set to 3, the campaign will not be displayed to a user after they have seen it three times, regardless of triggers or frequency cap settings.*

   <Image align="center" className="border" border={true} src="https://files.readme.io/131318f1eb1915ffaf86d87db20f74746d78bd086982a539b789fbfb986ff9cc-image.png" />

   <br />
5. **Exposure window**: Defines the maximum time a user remains eligible to see the campaign after their first exposure. This is particularly useful for creating limited-time offers that expire after a defined period.

   It can be combined with a [countdown](countdown) component integrated into the Campaign Screen to reinforce urgency.

   *Example: If set to 24 hours, the campaign will only be available to a user for 24 hours after their first exposure, even if the overall campaign period is longer.*

   <Image align="center" className="border" border={true} src="https://files.readme.io/d8a6662f73141d9eb4541c10a897b8115b2d43113764eebd1e6cec850129e14e-image.png" />

   <br />

All the above-mentioned parameters can be combined to create highly customized campaign behaviors, allowing precise control over timing, frequency, exposure limits, and user experience.

### What: screen, A/B test:

In this section, you set up the Screen to be displayed or the you can run an A/B test.

This Screen does not need to be necessarily a Paywall. It can also be an onboarding Screen, a User Survey or any type of Screen

 For an A/B test, it can be either UI or Price A/B test. The following illustration shows how to choose a screen to display for this campaign. 

<Image align="center" className="border" border={true} src="https://files.readme.io/4b17afabacd455129049496f3408d5a87f06c5e46308b2fba51ae0082883408c-Screen_Recording_2025-03-17_at_09.15.05.gif" />

Once you are completed with your set up, click the Start button at the end of this page, to start the campaign.

Once a campaign has been started, you can still adjust the capping parameters (**start/end date & time**, **frequency capping**, **impression cap**, **exposure window**) but you **can't change** the **campaign's name** or **campaign's ID**  nor the associated **Audience** or **Screen**.

The results of the A/B test can be consulted in the [A/B test section of the Console](https://console.purchasely.io/ab-tests).

# Campaign prioritization

Active campaigns can prioritized. This allows allow to define which Campaign a User should be exposed to when they are eligible several Campaigns at the same time.

For a user, if a Campaign is currently capped, the SDK will automatically go to the next eligible Campaign.

You can prioritize Campaigns by drag & dropping them in the desired order. 

<Image align="center" className="border" border={true} src="https://files.readme.io/d4203fd8d566dce53a10e4907f5f25b0583b8af691da0dd4db42fad5e34d0f6f-campaigns_prioritization.gif" />

Campaigns above have a higher priority.

<br />

# Allowing the SDK to display of a Campaign

Your app might have a launch routine that requires to be fulfilled before another screen can be displayed. It can be splash screen, on boarding, login, displaying an ad interstitial etc...

For that reason, the display of a Campaign is **deferred until you authorize it**. 

Once your app is ready, notify the Purchasely SDK by using the following code:

```swift
Purchasely.readyToOpenDeeplink(true)
```
```kotlin Kotlin
Purchasely.readyToOpenDeeplink = true
```
```javascript React Native
Purchasely.readyToOpenDeeplink(true);
```
```java Flutter
Purchasely.readyToOpenDeeplink(true);
```
```swift Cordova
Purchasely.readyToOpenDeeplink(true);
```
```csharp Unity
_purchasely.SetIsReadyToOpenDeeplink(true);
```

> ❗️ Mandatory step
>
> Without this configuration, campaigns will not be triggered

# Following campaigns results

The Campaigns features allow you to follow the monetization KPIs for each Campaign created.

<Image align="center" className="border" border={true} src="https://files.readme.io/252364ade6b6fb37d613e910d2886464932fc7216e32f23bf75178d6911cae12-image.png" />

The KPIs include the number of Screens displayed, Unique Viewers, Conversions and Aggregated Revenue.

Let's dig into them.

### Screens displayed

This KPI counts the total Screens displayed for a given Campaign.

It leverages the [UI / SDK event](ui-sdk-events-list) `PRESENTATION_VIEWED` and counts the **total number of events** carrying a property `campaign_id` matching the campaign.

Each occurence of the event is counted, meaning that a same user seeing several different Screens associated to the Campaign or seeing the same Screen several times is counted.

<br />

### Unique Viewers

This KPI counts the total Unique Viewers for a given Campaign.

It leverages the [UI / SDK event](ui-sdk-events-list) `PRESENTATION_VIEWED` and counts the **total number of unique users** who have generated an event carrying the property `campaign_id` matching the campaign.

A same User viewing several Screens or several times the same Screen is counted only once.

<br />

### Conversions to Offer

This KPIs counts the **total number of Unique Users who converted to an Offer price** through a Screen associated with the Campaign. 

**`#CONVERSIONS_TO_OFFER`**= events that meet the following conditions

```sql
offer_type IN ('FREE_TRIAL', 'INTRO_OFFER', 'PROMO_CODE', 'PROMOTIONAL_OFFER')
AND event_type IN (
  'SUBSCRIPTION_STARTED',     -- Activations
  'SUBSCRIPTION_REACTIVATED', -- Reactivations
  'SUBSCRIPTION_UPGRADED',    -- Upgrades
  'SUBSCRIPTION_DOWNGRADED',  -- Downgrades
  'SUBSCRIPTION_CROSSGRADED', -- Crossgrades
)
```

A same User triggering several conversion events is counted only once.

The Conversion Rate to Offer displayed equals the`#CONVERSIONS_TO_OFFER` / `#UNIQUE VIEWERS`

### Conversions to Regular

This KPIs counts the **total number of Unique Users who converted to a Regular price** through a Screen associated with the Campaign.

**`#CONVERSIONS_TO_REGULAR`**= events that meet the following conditions

```sql
offer_type = 'NONE'
AND event_type IN (
  -- Offer conversions
  'TRIAL_CONVERTED',
  'INTRO_OFFER_CONVERTED',
  'PROMOTIONAL_OFFER_CONVERTED',
  'PROMO_CODE_CONVERTED',
  -- Regular conversions without an offer
  'SUBSCRIPTION_STARTED',
  'SUBSCRIPTION_REACTIVATED',
  'SUBSCRIPTION_UPGRADED',
  'SUBSCRIPTION_DOWNGRADED',
  'SUBSCRIPTION_CROSSGRADED',
)
```

A same User triggering several conversion events is counted only once.

The Conversion Rate to Regular displayed equals the`#CONVERSIONS_TO_REGULAR` / `#UNIQUE VIEWERS`

### Conversions to OTP

This KPIs counts the **total number of Unique Users who purchased a One-Time Purchase** (either a consumable or non consumable) through a Screen associated with the Campaign. It leverages the event `TRANSACTION_PROCESSED` with the carrying the property `purchase_type` = `CONSUMABLE` or `NON_CONSUMABLE` and the property `campaign_id` matching the campaign.

* **`#CONVERSIONS_TO_OTP`**=\
  `#TRANSACTION_PROCESSED (with purchase_type = CONSUMABLE or NON_CONSUMABLE)`        // transactions associated with a One-Time Purchase.

A same User triggering several conversion events is counted only once.

The Conversion Rate to OTP displayed equals the`#CONVERSIONS_TO_OTP` / `#UNIQUE VIEWERS`

<br />

### Aggregated revenue

The revenue are aggregated depending on the Plan type (`SUBSCRIPTION` or `OTP`) and for subscriptions, depending on the type of Price paid by the subscriber (`OFFER` or `REGULAR`).

It leverages the event TRANSACTION\_PROCESSED carrying a property `campaign_id` matching the campaign and groups them by purchase\_type and offer\_type.

* **`AGGREGATED_REVENUE_OFFER`** =\
  SUM OF `amount_in_xxx` values for all `TRANSACTION_PROCESSED` events  `(with purchase_type = RENEWING_SUBSCRIPTION or NON_RENEWING_SUBSCRIPTION and offer_type != NONE)`
* **`AGGREGATED_REVENUE_REGULAR`** =\
  SUM OF `amount_in_xxx` values for all `TRANSACTION_PROCESSED` `(with purchase_type = RENEWING_SUBSCRIPTION or NON_RENEWING_SUBSCRIPTION and offer_type = NONE)`
* **`AGGREGATED_REVENUE_OTP`** =\
  SUM OF `amount_in_xxx` values for all `TRANSACTION_PROCESSED` `(with purchase_type = CONSUMABLE or NON_CONSUMABLE)`

For auto-renewing subscriptions, revenue include both the initial transaction and all the subsequent renewing until the actual termination of the subscription.

<br />

<br />

<CampaignsExamples />
