---
title: Campaign configuration
excerpt: >-
  Learn how to configure a Campaign: define the audience, set triggers and
  placements, schedule start/end dates, tune capping parameters, select a
  Screen or A/B test, and manage campaign priority.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---

This page walks you through every parameter available when creating or editing a [Campaign](campaigns).

![](https://files.readme.io/5e6c2bb732f089f51d64514f13f3525df0742f497c8189483aa57f5aea57f5c0-image.png)

# Name and ID

Set the name and ID of your campaign. Both are used to track performance within Purchasely.

💡 Adding a **category** lets you better organize the list of campaigns.

<Image align="center" className="border" border={true} src="https://files.readme.io/8aefde9f6d1dbf09521a0caed643b7fe47d47dac5d0b1b16c1cccf7d609eb1ce-Screen_Recording_2025-03-17_at_08.18.47.gif" />

# WHO — Audience

Choose the [Audience](audiences) you would like to target with this campaign.

<Image align="center" className="border" border={true} src="https://files.readme.io/39f15535bfa0e07b78da0bb8dd36249eebe44661cc65c629cbf5d5d0bea21add-who.gif" />

If you haven't configured the desired audience yet, click `+ Create new audience` and define it directly from the modal.

# WHEN — Trigger, scheduling and capping

The **WHEN** section controls trigger-based delivery. It determines **when** the campaign fires in response to an event, and how often a user can see it.

## Trigger

By default, a campaign starts when the `APP_STARTED` event is triggered. This event occurs:

* When the app is launched for the first time.
* After the app is restarted following termination by the operating system (typically due to prolonged inactivity).
* When the user manually relaunches the app.

> ℹ️ `APP_STARTED` and other events
>
> For now, `APP_STARTED` is the only event available as a trigger. New events will be supported in the months to come.

## Scheduling (start & end date)

Define the campaign's activation and expiration times to automate promotional events (e.g. Black Friday sales) without requiring manual intervention in the Console.

All times are expressed in **UTC/GMT**.

## Frequency cap

Control how often the campaign is displayed to prevent overexposure and user fatigue. The frequency cap can be configured in two ways:

**Session-based** — Limits campaign display based on app session count.

*Example: If set to trigger every 3 sessions, the campaign will appear at most once every 3 app launches.*

<Image align="center" className="border" border={true} src="https://files.readme.io/79a76de98e475eeb7b6f87a7cf4502b584181da11166167e052555be65036a62-image.png" />

Note: the SDK generates a new session after 30 minutes of inactivity.

**Period-based** — Enforces a minimum time gap between consecutive displays.

*Example: If set to a 2-day interval, the campaign will not be shown again until at least 48 hours have passed since the last display.*

<Image align="center" className="border" border={true} src="https://files.readme.io/eac0d395868e99e591d7f9062d723345a35d57545e56d88ebb2b9edfb0a1e008-image.png" />

## Impression cap

Restricts the total number of times a user can see the campaign throughout its entire duration.

*Example: If set to 3, the campaign will not be displayed to a user after they have seen it three times, regardless of trigger or frequency cap settings.*

<Image align="center" className="border" border={true} src="https://files.readme.io/131318f1eb1915ffaf86d87db20f74746d78bd086982a539b789fbfb986ff9cc-image.png" />

## Exposure window

Defines the maximum time a user remains eligible to see the campaign after their first exposure. This is particularly useful for creating limited-time offers that expire after a defined period.

It can be combined with a [countdown](countdown) component integrated into the Campaign Screen to reinforce urgency.

*Example: If set to 24 hours, the campaign will only be available to a user for 24 hours after their first exposure, even if the overall campaign period is longer.*

<Image align="center" className="border" border={true} src="https://files.readme.io/d8a6662f73141d9eb4541c10a897b8115b2d43113764eebd1e6cec850129e14e-image.png" />

> ⚠️ **Capping applies to trigger-based delivery only**
>
> Frequency cap, impression cap, and exposure window are enforced only when the campaign is delivered through a trigger (`APP_STARTED`). They do **not** apply when the campaign is delivered through a Placement.

All the above parameters can be combined to create highly customized campaign behaviors, allowing precise control over timing, frequency, exposure limits, and user experience.

# WHERE — Placements

The **WHERE** section lets you associate the campaign with one or more [Placements](displaying-screens-placements).

When a Placement is called by your app, the SDK evaluates every campaign targeting that Placement. If the current user matches the campaign's audience, the campaign's screen is displayed instead of the Placement's default rules.

## Why use Placements in a Campaign?

**Schedule content on Placements ahead of time.** Assign start and end dates to the campaign and associate it with your Placements. The screen will appear automatically during the scheduled window and disappear when the campaign ends — perfect for Black Friday, seasonal promotions, or any commercial operation with known dates.

**Centralize display ordering across Placements.** Without campaigns, each Placement maintains its own ordered list of audience / screen rules. If you need the same priority order across several Placements, you must manually reorder every list. By moving those rules into campaigns, you define the priority **once** and it applies everywhere the campaign is associated.

## How Placement-based campaigns interact with Placement rules

When a Placement is called, the SDK resolves which screen to show in the following order:

1. **Campaign rules first.** All active campaigns targeting that Placement are evaluated in campaign priority order. The first campaign whose audience matches the current user wins.
2. **Placement-local rules second.** If no campaign matches, the Placement falls back to its own locally-defined audience / screen rules (the existing behavior).

In other words, campaigns associated with a Placement **override** the Placement's own rules for the audiences they target.

# WHAT — Screen or A/B test

In this section you select the Screen to be displayed, or configure an A/B test.

The Screen does not need to be a paywall — it can also be an onboarding screen, a user survey, or any other type of Purchasely Screen.

For an A/B test, it can be either a UI or a Price A/B test.

<Image align="center" className="border" border={true} src="https://files.readme.io/4b17afabacd455129049496f3408d5a87f06c5e46308b2fba51ae0082883408c-Screen_Recording_2025-03-17_at_09.15.05.gif" />

Once you are done with your setup, click the **Start** button at the bottom of the page to activate the campaign.

The results of an A/B test can be consulted in the [A/B test section of the Console](https://console.purchasely.io/ab-tests).

## What can be changed after a campaign is started?

Once a campaign has been started, you can still adjust the capping parameters (**start/end date & time**, **frequency cap**, **impression cap**, **exposure window**) and the associated **Placements**, but you **cannot change** the campaign's **name**, **ID**, **Audience**, or **Screen**.

# Campaign prioritization

Active campaigns can be prioritized. This allows you to define which campaign a user should be exposed to when they are eligible for several campaigns at the same time.

If a campaign is currently capped for a user, the SDK automatically moves to the next eligible campaign in priority order.

You can reorder campaigns by drag-and-dropping them in the desired order. Campaigns higher in the list have a higher priority.

<Image align="center" className="border" border={true} src="https://files.readme.io/d4203fd8d566dce53a10e4907f5f25b0583b8af691da0dd4db42fad5e34d0f6f-campaigns_prioritization.gif" />

# Following campaign results

The Campaigns feature allows you to follow monetization KPIs for each campaign you create.

<Image align="center" className="border" border={true} src="https://files.readme.io/252364ade6b6fb37d613e910d2886464932fc7216e32f23bf75178d6911cae12-image.png" />

The KPIs include the number of Screens displayed, Unique Viewers, Conversions, and Aggregated Revenue. Here is how each one is computed.

## Screens displayed

This KPI counts the total screens displayed for a given campaign. It leverages the [UI / SDK event](ui-sdk-events-list) `PRESENTATION_VIEWED` and counts the **total number of events** carrying a `campaign_id` property matching the campaign.

Each occurrence of the event is counted — a same user seeing several screens associated with the campaign or seeing the same screen several times is counted multiple times.

## Unique Viewers

This KPI counts the total unique viewers for a given campaign. It leverages `PRESENTATION_VIEWED` and counts the **total number of unique users** who generated an event with the matching `campaign_id`.

A same user viewing several screens or the same screen several times is counted only once.

## Conversions to Offer

Counts the **total number of unique users who converted to an Offer price** through a screen associated with the campaign.

**`#CONVERSIONS_TO_OFFER`** = events meeting the following conditions:

```sql
offer_type IN ('FREE_TRIAL', 'INTRO_OFFER', 'PROMO_CODE', 'PROMOTIONAL_OFFER')
AND event_type IN (
  'SUBSCRIPTION_STARTED',
  'SUBSCRIPTION_REACTIVATED',
  'SUBSCRIPTION_UPGRADED',
  'SUBSCRIPTION_DOWNGRADED',
  'SUBSCRIPTION_CROSSGRADED'
)
```

A same user triggering several conversion events is counted only once.

Conversion Rate to Offer = `#CONVERSIONS_TO_OFFER` / `#UNIQUE_VIEWERS`

## Conversions to Regular

Counts the **total number of unique users who converted to a Regular price** through a screen associated with the campaign.

**`#CONVERSIONS_TO_REGULAR`** = events meeting the following conditions:

```sql
offer_type = 'NONE'
AND event_type IN (
  'TRIAL_CONVERTED',
  'INTRO_OFFER_CONVERTED',
  'PROMOTIONAL_OFFER_CONVERTED',
  'PROMO_CODE_CONVERTED',
  'SUBSCRIPTION_STARTED',
  'SUBSCRIPTION_REACTIVATED',
  'SUBSCRIPTION_UPGRADED',
  'SUBSCRIPTION_DOWNGRADED',
  'SUBSCRIPTION_CROSSGRADED'
)
```

A same user triggering several conversion events is counted only once.

Conversion Rate to Regular = `#CONVERSIONS_TO_REGULAR` / `#UNIQUE_VIEWERS`

## Conversions to OTP

Counts the **total number of unique users who purchased a One-Time Purchase** (consumable or non-consumable) through a screen associated with the campaign. It leverages the event `TRANSACTION_PROCESSED` with `purchase_type` = `CONSUMABLE` or `NON_CONSUMABLE` and the matching `campaign_id`.

A same user triggering several conversion events is counted only once.

Conversion Rate to OTP = `#CONVERSIONS_TO_OTP` / `#UNIQUE_VIEWERS`

## Aggregated revenue

Revenue is aggregated depending on the Plan type (`SUBSCRIPTION` or `OTP`) and, for subscriptions, depending on the type of price paid (`OFFER` or `REGULAR`).

It leverages `TRANSACTION_PROCESSED` events carrying a matching `campaign_id` and groups them by `purchase_type` and `offer_type`:

* **`AGGREGATED_REVENUE_OFFER`** = SUM of `amount_in_xxx` for all `TRANSACTION_PROCESSED` events with `purchase_type` = `RENEWING_SUBSCRIPTION` or `NON_RENEWING_SUBSCRIPTION` and `offer_type` ≠ `NONE`.
* **`AGGREGATED_REVENUE_REGULAR`** = SUM of `amount_in_xxx` for all `TRANSACTION_PROCESSED` events with `purchase_type` = `RENEWING_SUBSCRIPTION` or `NON_RENEWING_SUBSCRIPTION` and `offer_type` = `NONE`.
* **`AGGREGATED_REVENUE_OTP`** = SUM of `amount_in_xxx` for all `TRANSACTION_PROCESSED` events with `purchase_type` = `CONSUMABLE` or `NON_CONSUMABLE`.

For auto-renewing subscriptions, revenue includes both the initial transaction and all subsequent renewals until the actual termination of the subscription.
