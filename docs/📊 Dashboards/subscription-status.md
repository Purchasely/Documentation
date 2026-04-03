---
title: Subscription Status
---
# About this chart

The Subscription Status chart shows the composition of your active subscriptions by renewal status at each point in time. It breaks every active subscription into one of three states -- auto-renewing, canceled but still active, or in a grace period after a failed payment -- so you can monitor the health of your subscriber base at a glance.

# ⚠️ Change from dashboard v1: counting subscriptions, not subscribers

The previous version of this dashboard counted **unique subscribers** (users). Dashboard v2 now counts **unique subscriptions**, each identified by a unique subscription ID.

This changes the numbers in two ways:

* **Restored subscriptions across devices:** In v1, when a subscription was restored on a new device by a different anonymous user, it was counted multiple times — once for each anonymous user associated with it. In v2, the subscription is counted only once regardless of how many devices or anonymous users it passes through.
* **Multiple subscriptions per user:** In v1, a user holding two active subscriptions simultaneously was counted once (one user). In v2, each subscription is counted individually, so the same user contributes two to the total.

**Example:** Alice holds both a monthly Music plan and a yearly Premium plan. In v1, Alice counted as 1 subscriber. In v2, she counts as 2 active subscriptions. Conversely, if a single subscription was restored across 3 anonymous devices in v1, it appeared as 3 subscribers — in v2 it correctly counts as 1 subscription.

# How to read the chart

The chart is a **stacked bar chart**. Each bar represents a time period (day, week, or month) and is divided into three colored segments.

| Segment                     | Color         | Meaning                                                                                                                                                               |
| --------------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **AUTO_RENEWING**           | Green         | The subscriber has not canceled. The subscription will renew automatically at the end of the current billing period.                                                  |
| **AUTO_RENEWING_CANCELLED** | Orange        | The subscriber turned off auto-renewal. The subscription is still active and the user retains access until the end of the current paid period, but it will not renew. |
| **IN_GRACE_PERIOD**         | Purple / Blue | A renewal payment failed and the store (Apple, Google, etc.) is retrying the charge. The subscriber still has full access during this window.                         |

The height of each segment shows its count relative to the others. Reading the ratio between segments over time reveals trends: a growing orange segment means more subscribers are opting out of renewal; a growing purple segment signals increasing payment failures.

A **data table** below the chart lists the exact counts per date and status.

# Controls

## Show

Filter which subscriptions are included in the chart.

| Option                            | What it includes                                                                                      |
| --------------------------------- | ----------------------------------------------------------------------------------------------------- |
| **All active subscriptions**      | Every active subscription, whether paid or free (default)                                             |
| **Free Subscriptions only**       | Only subscriptions currently in a free phase (trial, free plan)                                       |
| **Paid Subscriptions only**       | Only subscriptions that are currently in a paid phase                                                 |
| **Full-price Subscriptions only** | Only subscriptions paying the standard price (excludes introductory offers and promotional discounts) |

## Grouped by

The bars are grouped by **Subscription Status** (AUTO_RENEWING, AUTO_RENEWING_CANCELLED, IN_GRACE_PERIOD). This is the primary grouping for this chart.

## Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution.

* **Daily** -- One bar per day. Best for spotting sudden shifts (e.g., after a pricing change or a billing incident).
* **Weekly** -- One bar per week. Good for smoothing out day-to-day noise while retaining enough detail.
* **Monthly** -- One bar per month. Best for long-term trend analysis and executive reporting.

## Filters

Click **Filters** to narrow the data. You can combine multiple filters.

| Filter               | Description                                                      |
| -------------------- | ---------------------------------------------------------------- |
| **Platforms**        | iOS, Android, or both                                            |
| **Screens**          | Filter by the paywall screen that triggered the subscription     |
| **Placements**       | Filter by where in the app the paywall was shown                 |
| **Audiences**        | Filter by audience segment the user belonged to at purchase time |
| **A/B tests**        | Filter by A/B test the user was enrolled in                      |
| **Campaigns**        | Filter by campaign attribution                                   |
| **Plans**            | Filter by specific subscription plan                             |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.)          |
| **Countries**        | Filter by user country                                           |

# Common use cases

* **Track voluntary churn risk** -- Watch the AUTO_RENEWING_CANCELLED segment over time. A steady increase in the orange proportion means more subscribers are turning off auto-renewal, which is a leading indicator of future churn. Investigate whether a recent app update, price change, or content gap is driving cancellations.

* **Monitor billing health** -- The IN_GRACE_PERIOD segment reflects failed payments that are being retried by the store. A spike may indicate a payment processing issue, expired credit cards after a holiday season, or a store-side outage. Cross-reference with your store dashboards to confirm.

* **Measure the effect of a retention campaign** -- Filter by Audience or Campaign and compare the status breakdown before and after launching a win-back campaign, a cancel-flow survey, or a discounted offer. A shrinking orange segment after the campaign indicates it is working.

* **Compare plans or periodicities** -- Use the Plan or Plan periodicity filter to see whether monthly subscribers cancel at a higher rate than yearly ones. This can inform pricing strategy and whether to promote annual commitments more aggressively.

* **Spot platform differences** -- Filter by Platform to check if iOS and Android show different cancellation or grace period patterns. Differences may reflect store-specific billing behavior or audience composition.

* **Detect seasonal patterns** -- Switch to Monthly granularity and look at cancellation ratios across several months. Seasonal apps (fitness, education, tax) often see predictable cancellation waves that can be anticipated with targeted retention efforts.

# Frequently asked questions

## What does AUTO_RENEWING_CANCELLED actually mean? Has the user already churned?

No. A subscription in AUTO_RENEWING_CANCELLED status is still active. The subscriber turned off auto-renewal (either through the app store settings or your cancel flow), but they continue to have full access until the end of their current paid period. They only churn when that period expires without a reactivation. This status is a **leading indicator** of churn, not churn itself.

## Why does IN_GRACE_PERIOD matter if the user still has access?

Grace period subscriptions represent a billing problem, not a user intent problem. The subscriber did not choose to cancel -- their payment simply failed. App stores (Apple and Google) retry the charge for a limited window (typically 6 to 16 days depending on the store). During this time the user retains access. If the retry succeeds, the subscription returns to AUTO_RENEWING. If it fails permanently, the subscription churns. Monitoring this segment helps you detect payment infrastructure issues early and decide whether to trigger in-app messaging to prompt users to update their payment method.

## What is the difference between grace period and account hold?

These are two distinct stages of a failed payment on app stores, and they affect the chart differently:

| Stage                                                                         | Access                  | Chart impact                                                     | Duration                                                                  |
| :---------------------------------------------------------------------------- | :---------------------- | :--------------------------------------------------------------- | :------------------------------------------------------------------------ |
| **Grace period**                                                              | User **retains** access | Counted in the **IN_GRACE_PERIOD** segment (yellow)              | Configurable: 0–30 days (Google Play), 6–16 days (App Store)              |
| **Account hold** (Google Play) / **Billing retry without access** (App Store) | User **loses** access   | **Not counted** in this chart (subscription is no longer active) | Up to 60 days total (grace period + account hold combined on Google Play) |

On Google Play, this two-stage flow is explicit: `IN_GRACE_PERIOD` → `ON_HOLD` → `EXPIRED`. On the App Store, the equivalent is the billing retry period, which may or may not preserve access depending on grace period configuration.

A subscription that recovers from **grace period** simply returns to AUTO_RENEWING — no reactivation event is generated. A subscription that recovers from **account hold** generates a recovery event and resets the billing date.

## Can a subscription move between statuses?

Yes. A subscription can transition between statuses over its lifetime:

* AUTO_RENEWING to AUTO_RENEWING_CANCELLED when the user turns off auto-renewal.
* AUTO_RENEWING_CANCELLED back to AUTO_RENEWING if the user re-enables auto-renewal before the period ends.
* AUTO_RENEWING to IN_GRACE_PERIOD when a renewal payment fails.
* IN_GRACE_PERIOD back to AUTO_RENEWING when the store successfully retries the charge.

These transitions are why the chart is valuable over time -- it shows the dynamic health of your subscriber base, not just a static snapshot.

## Does this chart include expired or churned subscriptions?

No. The chart only shows **active** subscriptions -- those where the user currently has access to the service. Once a subscription expires (the paid period ends without renewal, or the grace period concludes without a successful payment), it is no longer counted in this chart.

## How is this different from the Subscription Retention chart?

The Subscription Retention chart tracks cohorts of subscriptions over time to measure how many remain active after N periods. The Subscription Status chart does not use cohorts. Instead, it shows the **current composition** of all active subscriptions at each point in time, broken down by renewal state. Retention tells you how long subscribers stay; status tells you what condition they are in right now.

## What is a healthy ratio between the three statuses?

There is no universal benchmark because the ratio depends on your app category, billing cycle mix, and user base. However, as a general guideline: the AUTO_RENEWING segment should be the dominant portion (typically 80%+ of active subscriptions). If AUTO_RENEWING_CANCELLED consistently exceeds 15-20%, investigate your cancel reasons. If IN_GRACE_PERIOD exceeds 5%, review your payment recovery strategy and consider in-app prompts to update payment methods.
