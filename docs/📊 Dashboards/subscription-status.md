---
title: Subscription Status
---
# About this chart

The Subscription Status chart shows the composition of your active subscriptions by renewal status at each point in time. It breaks every active subscription into one of three states — auto-renewing, canceled but still active, or in a grace period after a failed payment — so you can monitor the health of your subscriber base at a glance.

It counts the same active subscriptions as the [Subscription Base Evolution](subscription-base-evolution) chart, split by status. The definition of "active", the filters and the way each bar reads the end of its period are the same.

<DashboardV1CountingChange />

# How to read the chart

The chart is a stacked bar chart. Each bar represents a time period (day, week, or month) and is divided into three colored segments.

| Segment                  | Color  | Meaning                                                                                                                                                               |
| ------------------------ | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `AUTO_RENEWING`          | Green  | The subscriber has not canceled. The subscription will renew automatically at the end of the current billing period.                                                  |
| `AUTO_RENEWING_CANCELED` | Orange | The subscriber turned off auto-renewal. The subscription is still active and the user retains access until the end of the current paid period, but it will not renew. |
| `IN_GRACE_PERIOD`        | Pink   | A renewal payment failed and the store (Apple, Google, etc.) is retrying the charge. The subscriber still has full access during this window.                         |

The height of each segment shows its count relative to the others. Reading the ratio between segments over time reveals trends: a growing orange segment means more subscribers are opting out of renewal; a growing pink segment signals increasing payment failures.

A data table below the chart lists the exact counts per date and status.

# Controls

## Show

Filter which subscriptions are included in the chart.

| Option                        | What it includes                                                                                      |
| ----------------------------- | ----------------------------------------------------------------------------------------------------- |
| All active subscriptions      | Every active subscription, whether paid or free (default)                                             |
| Free Subscriptions only       | Only subscriptions currently in a free phase: free trial, or free offer                               |
| Paid Subscriptions only       | Only subscriptions currently in a paid phase: full price, or a paid offer                             |
| Full-price Subscriptions only | Only subscriptions paying the standard price (excludes introductory offers and promotional discounts) |

## Grouped by

The bars are grouped by Subscription Status (`AUTO_RENEWING`, `AUTO_RENEWING_CANCELED`, `IN_GRACE_PERIOD`). This is the only grouping for this chart.

## Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution.

* **Daily** — One bar per day. Best for spotting sudden shifts (e.g., after a pricing change or a billing incident).
* **Weekly** — One bar per week. Good for smoothing out day-to-day noise while retaining enough detail.
* **Monthly** — One bar per month. Best for long-term trend analysis and executive reporting.

## Filters

<DashboardFilters />

| Filter           | Description                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| Platforms        | iOS, Android, or both                                                       |
| Countries        | Filter by store country: the country of the store account used for the purchase |
| Screens          | Filter by the paywall screen that triggered the subscription                |
| Placements       | Filter by where in the app the paywall was shown                            |
| Audiences        | Filter by the audience the user matched at the time of the activation event |
| A/B tests        | Filter by the A/B test variant attached to the subscription                 |
| Campaigns        | Filter by campaign attribution                                              |
| Plans            | Filter by specific subscription plan                                        |
| Plan periodicity | Filter by billing cycle (weekly, monthly, yearly, etc.)                     |
| Offer types      | Filter by how the subscription started (direct, trial, intro offer, promo code, promotional offer) |

# Common use cases

* **Track voluntary churn risk** — Watch the `AUTO_RENEWING_CANCELED` segment over time. A steady increase in the orange proportion means more subscribers are turning off auto-renewal, which is a leading indicator of future churn. Investigate whether a recent app update, price change, or content gap is driving cancellations.
* **Monitor billing health and trigger involuntary churn mitigation** — The `IN_GRACE_PERIOD` segment reflects failed payments that are being retried by the store. A spike may indicate a payment processing issue, expired credit cards after a holiday season, or a store-side outage. Cross-reference with your store dashboards to confirm. If this segment is consistently high, consider setting up an [involuntary churn mitigation campaign](retention-winback#4-involuntary-churn-mitigation) to proactively notify users that their payment has failed and direct them to their store payment settings to update their payment method — before the subscription gets suspended.
* **Measure the effect of a retention campaign** — Filter by Audience or Campaign and compare the status breakdown before and after launching a win-back campaign, a cancel-flow survey, or a discounted offer. A shrinking orange segment after the campaign indicates it is working.
* **Compare plans or periodicities** — Use the Plan or Plan periodicity filter to see whether monthly subscribers cancel at a higher rate than yearly ones. This can inform pricing strategy and whether to promote annual commitments more aggressively.
* **Spot platform differences** — Filter by Platform to check if iOS and Android show different cancellation or grace period patterns. Differences may reflect store-specific billing behavior or audience composition.
* **Detect seasonal patterns** — Switch to Monthly granularity and look at cancellation ratios across several months. Seasonal apps (fitness, education, tax) often see predictable cancellation waves that can be anticipated with targeted retention efforts.

# Frequently asked questions

### What does `AUTO_RENEWING_CANCELED` actually mean? Has the user already churned?

No. A subscription in `AUTO_RENEWING_CANCELED` status is still active. The subscriber turned off auto-renewal (either through the app store settings or your cancel flow), but they continue to have full access until the end of their current paid period. They only churn when that period expires without a reactivation. This status is a leading indicator of churn, not churn itself.

### Why does `IN_GRACE_PERIOD` matter if the user still has access?

Grace period subscriptions represent a billing problem, not a user intent problem. The subscriber did not choose to cancel — their payment simply failed. App stores (Apple and Google) retry the charge for a window you configure in App Store Connect or the Play Console. During this time the user retains access. If the retry succeeds, the subscription returns to `AUTO_RENEWING` (or `AUTO_RENEWING_CANCELED` if the subscriber had turned off auto-renewal). If it fails permanently, the subscription churns.

Monitoring this segment helps you detect payment infrastructure issues early and decide whether to trigger in-app messaging to prompt users to update their payment method. You can automate this with an [involuntary churn mitigation campaign](https://docs.purchasely.com/docs/retention-winback#4-involuntary-churn-mitigation).

### What is the difference between grace period and account hold?

These are two distinct stages of a failed payment on app stores, and they affect the chart differently:

| Stage                                                                 | Access              | Chart impact                                                     | Duration                                                                  |
| --------------------------------------------------------------------- | ------------------- | ---------------------------------------------------------------- | ------------------------------------------------------------------------- |
| Grace period                                                          | User retains access | Counted in the `IN_GRACE_PERIOD` segment                         | A duration you choose in App Store Connect or the Play Console            |
| Account hold (Google Play) / Billing retry without access (App Store) | User loses access   | **Not counted in this chart** (subscription is no longer active) | On Google Play, account hold is by default 60 days minus the grace period |

On Google Play, this two-stage flow is explicit: IN_GRACE_PERIOD → ON_HOLD → EXPIRED. On the App Store, the equivalent is the billing retry period, which may or may not preserve access depending on grace period configuration.

A subscription that recovers from a grace period simply returns to `AUTO_RENEWING`; it is not a reactivation. A subscription that recovers from account hold or billing retry re-enters the active base and is counted as a reactivation (see [Subscription Reactivations](subscription-reactivations)).

### Can a subscription move between statuses?

Yes. A subscription can transition between statuses over its lifetime:

* `AUTO_RENEWING` → `AUTO_RENEWING_CANCELED` when the user turns off auto-renewal.
* `AUTO_RENEWING_CANCELED` → `AUTO_RENEWING` if the user re-enables auto-renewal before the period ends.
* `AUTO_RENEWING` → `IN_GRACE_PERIOD` when a renewal payment fails.
* `IN_GRACE_PERIOD` → `AUTO_RENEWING` when the store successfully retries the charge.

These transitions are why the chart is valuable over time — it shows the dynamic health of your subscriber base, not just a static snapshot.

### Does this chart include expired or churned subscriptions?

No. The chart only shows **active** subscriptions — those where the user currently has access to the service. Once a subscription expires (the paid period ends without renewal, or the grace period concludes without a successful payment), it is no longer counted in this chart. Subscriptions in account hold or billing retry without access, and paused subscriptions, are also excluded, since the user has lost access at that point.

### How is this different from the Subscription Retention chart?

The [Subscription Retention](subscription-retention) chart tracks cohorts of subscriptions over time to measure how many remain active after N periods. The Subscription Status chart does not use cohorts. Instead, it shows the current composition of all active subscriptions at each point in time, broken down by renewal state. Retention tells you _how long_ subscribers stay; status tells you _what condition_ they are in right now.

### What is a healthy ratio between the three statuses?

There is no universal benchmark because the ratio depends on your app category, billing cycle mix, and user base. However, as a general guideline: the `AUTO_RENEWING` segment should be the dominant portion (typically 80%+ of active subscriptions). If `AUTO_RENEWING_CANCELED` consistently exceeds 15–20%, investigate your cancel reasons. If `IN_GRACE_PERIOD` exceeds 5%, review your payment recovery strategy and consider setting up an [involuntary churn mitigation campaign](retention-winback#4-involuntary-churn-mitigation).
