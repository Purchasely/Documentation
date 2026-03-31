---
title: Paid Subscription Movements
---
# About this chart

The Paid Subscriptions Movements chart tracks the flow of paid subscriptions entering and leaving your app over time. It combines new subscriptions (inflows) and churned subscriptions (outflows) into a single view, making it easy to see whether your subscriber base is growing, shrinking, or stable.

The chart uses a **bar + line layout**:

| Visual element | What it represents |
|---|---|
| **Blue bars** (upward) | New paid subscriptions gained during the period |
| **Red/coral bars** (downward) | Churned paid subscriptions lost during the period |
| **Black line** | Balance (New minus Churn) for each period |
| **Orange dashed line** | Average daily balance, smoothing out day-to-day noise |
| **Light line** | Trend, showing the overall direction of the balance over time |

A **data table** below the chart lists each period with its New, Churn, and Balance values. Negative balances are highlighted in red. You can export the table as CSV.

> ⚠️ **Change from dashboard v1: counting subscriptions, not subscribers**
>
> The previous version of this dashboard counted **unique subscribers** (users). Dashboard v2 now counts **unique subscriptions**, each identified by a unique subscription ID.
>
> This changes the numbers in two ways:
>
> - **Restored subscriptions across devices:** In v1, when a subscription was restored on a new device by a different anonymous user, it was counted multiple times — once for each anonymous user associated with it. In v2, the subscription is counted only once regardless of how many devices or anonymous users it passes through.
> - **Multiple subscriptions per user:** In v1, a user holding two active subscriptions simultaneously was counted once (one user). In v2, each subscription is counted individually, so the same user contributes two to the total.
>
> **Example:** Alice holds both a monthly Music plan and a yearly Premium plan. In v1, Alice counted as 1 subscriber. In v2, she counts as 2 active subscriptions. Conversely, if a single subscription was restored across 3 anonymous devices in v1, it appeared as 3 subscribers — in v2 it correctly counts as 1 subscription.

# How to read the chart

**New** counts all paid subscriptions that started during the period. This includes first-time purchases, reactivations of previously expired subscriptions, and subscriptions resuming after a billing retry recovery. If a user switches from one plan to another, the new plan may appear here as a new subscription.

**Churn** counts all paid subscriptions that terminated during the period. This includes voluntary cancellations that reached their expiry date, involuntary churn from failed billing retries, and refunds. If a user switches from one plan to another, the old plan may appear here as a churn event.

**Balance** is simply New minus Churn for each period. A positive balance means your subscriber base grew; a negative balance means it shrank.

**Average daily balance** divides each period's balance by the number of days it covers (always 1 for daily granularity, 7 for weekly, variable for monthly). This helps compare periods of different lengths and smooths out spikes caused by weekends, holidays, or one-off events.

**Trend** fits a line through the balance values to reveal the underlying direction. If the trend line slopes upward, your subscriber base is growing on average. If it slopes downward, churn is outpacing acquisition.

Hover over any point on the chart to see a tooltip with the exact Date, New count, Churn count, Balance, Average Daily Balance, and Trend value.

# Controls

## Show

Select which subscriptions to include. The default is **All paid subscriptions**, which encompasses every subscription regardless of how it started (trial conversion, intro offer, promo offer, or direct full-price purchase).

## Grouped by

Break the data into segments to compare movements across dimensions.

| Group | What it shows |
|---|---|
| **None** | Aggregate view across all subscriptions |
| **Platform** | iOS vs. Android vs. other stores |
| **Placement** | Where in the app the paywall was shown |
| **Audience** | Audience segment the user belonged to at purchase time |
| **Country** | User country |
| **Screen** | The paywall screen that triggered the subscription |
| **Plan** | Specific subscription plan |
| **Plan periodicity** | Billing cycle (weekly, monthly, yearly, etc.) |
| **Offer types** | How the subscription started (trial, intro offer, promo offer, standard) |
| **Event types** | Subscription lifecycle event type |

When a group is selected, the chart displays separate series for each value within that dimension.

## Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution.

- **Daily** -- One bar per day. Best for spotting day-to-day fluctuations and diagnosing short-term issues.
- **Weekly** -- One bar per week. Good for week-over-week comparisons while reducing daily noise.
- **Monthly** -- One bar per month. Best for long-term trend analysis and executive reporting.

## Filters

Click **Filters** to narrow the data. You can combine multiple filters.

| Filter | Description |
|---|---|
| **Platforms** | iOS, Android, or both |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.) |
| **Offer types** | Filter by how the subscription started (trial, intro offer, promo offer, standard) |
| **Countries** | Filter by user country |
| **Screens** | Filter by the paywall screen that triggered the subscription |
| **Placements** | Filter by where in the app the paywall was shown |
| **Audiences** | Filter by audience segment at purchase time |
| **Plans** | Filter by specific subscription plan |

# Common use cases

- **Monitor subscriber base health** -- Check the balance line and trend daily or weekly to confirm that new subscriptions consistently outnumber churn. A persistently negative balance signals a retention problem that needs attention before it compounds.

- **Measure the impact of a campaign or feature launch** -- After launching a new paywall, running a promotion, or shipping a major feature, watch the New bars for a spike and the Churn bars for any unintended side effects. Group by Placement or Screen to isolate the impact of a specific touchpoint.

- **Compare churn across plan periodicities** -- Group by Plan periodicity to see whether monthly subscribers churn more than yearly subscribers. If monthly churn is disproportionately high, consider incentivizing longer commitments through intro offers or discounted annual plans.

- **Detect platform-specific issues** -- Group by Platform to compare iOS and Android movements. A sudden spike in churn on one platform may indicate a billing issue, a broken app update, or a store policy change affecting renewals.

- **Identify seasonal patterns** -- Use monthly granularity over a long date range to spot recurring trends. Many apps see higher acquisition in Q4 (holiday season) and higher churn in Q1. Understanding these cycles helps you plan campaigns and forecast revenue.

- **Evaluate the effectiveness of a retention initiative** -- After deploying a win-back campaign or grace period change, filter by the targeted audience or plan and track whether the Churn bars decrease in the following periods compared to the same periods before the initiative.

# Frequently asked questions

## Why does a plan change appear as both New and Churn?

When a subscriber switches from Plan A to Plan B, the system records the end of Plan A (counted as Churn) and the start of Plan B (counted as New). The net effect on the Balance is zero, but the individual bars show activity in both directions. This is expected behavior. If plan changes are frequent, they can inflate both the New and Churn bars while leaving the Balance relatively flat.

For **deferred plan changes** (primarily Google Play), both the +1 churn and +1 new appear on the date the downgrade is *initiated*, even though the user continues using the old plan until the next renewal date. This can temporarily overstate both New and Churn volumes before the actual plan switch takes effect.

## What does a negative balance mean?

A negative balance for a period means more subscriptions were lost than gained. A single negative period is not necessarily alarming -- it can happen after a promotional spike subsides or during a seasonal dip. However, a sustained negative balance across multiple periods indicates that churn is structurally outpacing acquisition and requires investigation.

## How is the average daily balance different from the balance?

The Balance is the raw difference between New and Churn for the entire period. The Average Daily Balance divides that number by the number of days in the period. This matters most at monthly granularity, where months have different lengths. For example, a Balance of +300 in February (28 days) and +310 in March (31 days) looks similar, but the average daily balance reveals February was actually stronger (+10.7/day vs. +10.0/day).

## Does the chart include subscriptions in billing retry?

A subscription in billing retry has not yet terminated -- it is still considered active. It will not appear as Churn unless the retry period expires without a successful payment. If the billing retry succeeds, the subscription continues as normal and no movement is recorded. If it fails, the termination is counted as Churn on the date the retry period ends.

## Why do the numbers differ between daily and monthly granularity?

Summing daily New and Churn values across a month may not exactly match the monthly totals. This is because a subscription that churns and reactivates within the same month appears as both a Churn and a New event in daily view, but the net effect may be collapsed in monthly view. This is standard behavior and consistent with how the Subscription Retention chart handles granularity differences.

## Can I export the data for further analysis?

Yes. Click the **Export CSV** button below the data table to download all visible rows with their Date, New, Churn, and Balance columns. The export respects your current filters, grouping, and granularity settings.

## How do Google Play paused subscriptions appear in this chart?

Pause is a Google Play-only feature. When a subscription is paused, it appears as **Churn** (the user loses access). When it automatically resumes, it appears as **New** (access is restored). This inflates both New and Churn numbers without representing genuine acquisition or loss. Filter by Platform to isolate this effect on Android.

## How do Google Play prepaid plans appear?

Prepaid plans do not auto-renew. Each prepaid period expiration appears as **Churn**, and each top-up appears as **New** — even if the user intends to continue. This creates a recurring +1/-1 pattern for every prepaid subscriber at each renewal. If your app offers prepaid plans, expect higher New and Churn volumes on Android compared to auto-renewing equivalents.
