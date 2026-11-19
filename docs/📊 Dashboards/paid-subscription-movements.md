---
title: Paid Subscription Movements
---
# About this chart

The Paid Subscriptions Movements chart tracks the flow of **paid subscriptions** entering and leaving your app over time. It combines **new paid subscriptions** (inflows) and **churned paid subscriptions** (outflows) into a single view, making it easy to see whether your paying subscriber base is growing, shrinking, or stable.

The chart is always restricted to **paying** subscriptions: full price, or a paid offer (paid intro offer, promo code, promotional offer). Free trials and free offers are not in this chart until they convert.

The chart uses a **bar + line layout**:

| Visual element                | What it represents                                                                |
| ----------------------------- | --------------------------------------------------------------------------------- |
| **Blue bars** (upward)        | New paid subscriptions gained during the period                                   |
| **Red/coral bars** (downward) | Churned paid subscriptions lost during the period                                 |
| **Black line**                | Balance (New minus Churn) for each period                                         |
| **Orange dashed line**        | Average balance: the mean of the balance over all the periods displayed, drawn flat |
| **Light line**                | Trend, showing the overall direction of the balance over the selected time period |

A **data table** below the chart lists each period with its New, Churn, and Balance values. Negative balances are highlighted in red. You can export the table as CSV.

<DashboardV1CountingChange />

# How to read the chart

**New** counts all subscriptions that **entered the paid base** during the period:

* a direct full-price purchase;
* the start of a paid offer (paid intro offer, promo code, promotional offer). A paid offer counts as New on the day it starts, not when it later converts to full price;
* the conversion of a free trial or free offer to a paid price;
* a reactivation of an expired subscription, a recovery after a billing retry, or a resume after a Google Play pause.

**Churn** counts all paid subscriptions that **lost access** during the period:

* voluntary: a cancelled subscription that reached its expiry date, a cancellation during a grace period, a Google Play pause;
* involuntary: entering billing retry, a grace period that ended without payment, an expiration after an unpaid period;
* a refund.

**What does not move the chart:** a change from one paid plan to another, a grace period (the subscriber keeps access), a paid offer converting to full price, a subscription transferred to another user, family-shared subscriptions.

**Balance** is New minus Churn for each period. A positive balance means your paying base grew; a negative balance means it shrank.

**Average balance** is the mean of the balance across all the periods displayed. It is one flat line for the whole range: at daily granularity it is an average per day, at monthly granularity an average per month.

**Trend** fits a line through the balance values to reveal the underlying direction for the selected time period. If the trend line slopes upward, your paying base is growing on average. If it slopes downward, churn is outpacing acquisition.

Hover over any point on the chart to see a tooltip with the exact Date, New count, Churn count, Balance, Average balance, and Trend value.

> 📘 **Comparing iOS and Android**
>
> Unlike the Subscription Activations chart, the New count of this chart is comparable across stores. A returning iOS customer appears here as a reactivation and a returning Android customer as a new activation (Google does not link a new purchase to an expired one), but both are counted in New.

# Controls

### Grouped by

Break the data into segments to compare movements across dimensions.

| Group                | What it shows                                                                                   |
| -------------------- | ----------------------------------------------------------------------------------------------- |
| **None**             | Aggregate view across all subscriptions                                                          |
| **Platform**         | iOS vs. Android vs. other stores                                                                 |
| **Placement**        | Where in the app the paywall was shown                                                           |
| **Audience**         | Audience the user matched at the time of the movement                                            |
| **Country**          | **Store country**: the country of the App Store or Play Store account used for the purchase. "Unknown" means the store did not report a country |
| **Screen**           | The paywall screen that triggered the subscription                                               |
| **Plan**             | Specific subscription plan                                                                       |
| **Plan periodicity** | Billing cycle (weekly, monthly, yearly, etc.)                                                    |
| **Campaign**         | Campaign attribution                                                                             |
| **Offer types**      | How the subscription started (direct, intro offer, promo code, promotional offer)                |
| **Payment types**    | Full price or paid offer. Free offers never appear here, the chart only counts paying subscriptions |
| **Event types**      | The movement itself: entries (activation, trial or offer converted, paid offer started, reactivation) and exits (voluntary churn, involuntary churn, refund) |

When a group is selected, the chart displays separate series for each value within that dimension. Groups beyond the ten largest over the selected range are combined into **Other**.

### Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution.

* **Daily** -- One bar per day. Best for spotting day-to-day fluctuations and diagnosing short-term issues.
* **Weekly** -- One bar per week. Good for week-over-week comparisons while reducing daily noise.
* **Monthly** -- One bar per month. Best for long-term trend analysis and executive reporting.

### Filters

<DashboardFilters />

| Filter               | Description                                                                        |
| -------------------- | ---------------------------------------------------------------------------------- |
| **Platforms**        | iOS, Android, or both                                                              |
| **Countries**        | Filter by store country (see Grouped by)                                           |
| **Screens**          | Filter by the paywall screen that triggered the subscription                       |
| **Placements**       | Filter by where in the app the paywall was shown                                   |
| **Audiences**        | Filter by the audience the user matched at the time of the movement                |
| **A/B tests**        | Filter by the A/B test variant attached to the movement                            |
| **Campaigns**        | Filter by campaign attribution                                                     |
| **Plans**            | Filter by specific subscription plan                                               |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.)                            |
| **Offer types**      | Filter by how the subscription started (direct, intro offer, promo code, promotional offer) |

> 📘 Platforms and countries are applied before the movements are classified; all other filters are applied on the movement event itself.

# Common use cases

* **Monitor subscriber base health** -- Check the balance line and trend daily or weekly to confirm that new subscriptions consistently outnumber churn. A persistently negative balance signals a retention problem that needs attention before it compounds.

* **Measure the impact of a campaign or feature launch** -- After launching a new paywall, running a promotion, or shipping a major feature, watch the New bars for a spike and the Churn bars for any unintended side effects. Group by Placement, Screen or Campaign to isolate the impact of a specific touchpoint.

* **Compare churn across plan periodicities** -- Group by Plan periodicity to see whether monthly subscribers churn more than yearly subscribers. If monthly churn is disproportionately high, consider incentivizing longer commitments through intro offers or discounted annual plans.

* **Detect platform-specific issues** -- Group by Platform to compare iOS and Android movements. A sudden spike in churn on one platform may indicate a billing issue, a broken app update, or a store policy change affecting renewals.

* **Separate voluntary from involuntary churn** -- Group by Event types. A rise in involuntary churn points at payment failures (expired cards, store outages) rather than at your product, and calls for an [involuntary churn mitigation campaign](retention-winback#4-involuntary-churn-mitigation).

* **Identify seasonal patterns** -- Use monthly granularity over a long date range to spot recurring trends. Many apps see higher acquisition in Q4 (holiday season) and higher churn in Q1. Understanding these cycles helps you plan campaigns and forecast revenue.

* **Evaluate the effectiveness of a retention initiative** -- After deploying a win-back campaign or grace period change, filter by the targeted audience or plan and track whether the Churn bars decrease in the following periods compared to the same periods before the initiative.

# Frequently asked questions

### Does a plan change appear as New or Churn?

No. A subscriber who switches from one paid plan to another keeps the same subscription in this chart: the switch is neither a Churn nor a New. The only exception is a switch that converts a free trial or free offer into a paid plan, which counts as New like any other conversion.

### What does a negative balance mean?

A negative balance for a period means more subscriptions were lost than gained. A single negative period is not necessarily alarming -- it can happen after a promotional spike subsides or during a seasonal dip. However, a sustained negative balance across multiple periods indicates that churn is structurally outpacing acquisition and requires investigation.

### How is the average balance different from the balance?

The Balance is the difference between New and Churn for one period. The Average balance is the mean of those balances over all the periods displayed, drawn as a flat line. It tells you whether the period you are looking at is above or below the average of the range.

### Does the chart include subscriptions in grace period and billing retry?

A subscription in **grace period** keeps access and is still paid. It does not appear as Churn, and its recovery does not appear as New. If the grace period ends without payment, the subscription appears as Churn on that day.

A subscription entering **billing retry** has lost access. It appears as Churn on the day it enters retry. If the retry later succeeds, the subscription appears as New on that day. A payment failure that recovers therefore shows as one Churn and one New.

### Why does New minus Churn not match the change in my active paid base?

The movements and the [Subscription Base Evolution](subscription-base-evolution) chart follow different rules. Movements count only classified store events, and count each event's own price: entering billing retry is a Churn on its date, and a subscription moving from a paid price to a free offer without losing access is not a Churn. To know your paid base on a given date, use the Subscription Base Evolution chart, not a previous value plus the movements.

### Why do the numbers differ between daily and monthly granularity?

They do not. For an identical date range, the monthly New and Churn equal the sum of the daily values. Only the first and last periods can be partial, because they are labelled by the start of their calendar period while only the events inside your date range are counted.

### How do Google Play paused subscriptions appear in this chart?

Pause is a Google Play-only feature. When a subscription is paused, it appears as **Churn** (the user loses access). When it resumes, it appears as **New** (access is restored). This inflates both New and Churn numbers without representing genuine acquisition or loss. Group by Event types or filter by Platform to isolate this effect.

### How does a refund appear?

A refund that revokes access appears as **Churn** on the day of the refund. If the store later reverses the refund, access is restored but the subscription does not appear again as New.

### How do Google Play prepaid plans appear?

Prepaid plans do not auto-renew. Each prepaid period expiration appears as **Churn**, and each top-up appears as **New** — even if the user intends to continue. This creates a recurring +1/-1 pattern for every prepaid subscriber at each renewal. If your app offers prepaid plans, expect higher New and Churn volumes on Android compared to auto-renewing equivalents.
