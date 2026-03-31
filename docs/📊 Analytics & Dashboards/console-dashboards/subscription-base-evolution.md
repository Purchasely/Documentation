---
title: Subscription Base Evolution
---
# About this chart

The Subscription Base Evolution chart shows the total count of active subscriptions over time as a bar chart. It helps you track the growth or decline of your subscriber base, spot trends across segments, and understand how your acquisition and retention efforts translate into active subscriptions on any given day, week, or month.

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

Each bar represents the number of **active subscriptions** at the end of the corresponding time period. A subscription is considered active if it has a valid entitlement at that point in time — this includes subscriptions currently in a grace period (where the user retains access while the store retries billing).

| Element | Description |
|---------|-------------|
| **Bar height** | The total count of active subscriptions for that period |
| **Tooltip** | Hover over a bar to see the exact date and count breakdown. When grouped, each segment appears as a separate value (e.g., "All: 14,137", "Free: 14,137") |
| **Data table** | Below the chart, a table lists each period with its corresponding count. Use the **Export CSV** button to download the raw data |
| **Chart / Table toggle** | Icons in the top-right corner let you switch between the visual chart and the tabular view |

When a **Grouped by** dimension is applied, the bars are stacked or split by segment, and the tooltip and data table reflect the breakdown.

# Controls

## Show

Filter the type of subscriptions included in the chart:

| Option | What it includes |
|--------|-----------------|
| **All active subscriptions** | Every subscription with a valid entitlement — paid and free combined |
| **Paid subscriptions only** | Subscriptions generating revenue (excludes free trials that have not yet converted and free plans) |
| **Full-price subscriptions only** | Paid subscriptions at standard price (excludes discounted and promotional offers) |
| **Discounted subscriptions only** | Subscriptions currently on an introductory offer or promotional offer at a reduced price |
| **Free subscriptions only** | Subscriptions on a free plan or in an active free trial period |

## Grouped by

Break down the bars by a dimension to compare segments side by side:

| Dimension | Description |
|-----------|-------------|
| **None** | Single bar per period — no breakdown |
| **Audience** | Split by audience segment the user belongs to |
| **Country** | Split by user country |
| **Screen** | Split by the paywall screen that triggered the subscription |
| **Placement** | Split by where in the app the paywall was shown |
| **Platform** | Split by iOS, Android, or other platforms |
| **Offer types** | Split by how the subscription started (trial, intro offer, promo offer, standard) |
| **Plan** | Split by subscription plan |
| **Plan periodicity** | Split by billing cycle (weekly, monthly, yearly, etc.) |

## Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution of the bars.

- **Daily** — One bar per day. Best for spotting short-term fluctuations and the impact of specific events.
- **Weekly** — One bar per week. Good for smoothing out day-of-week noise while keeping reasonable detail.
- **Monthly** — One bar per month. Best for long-term trend analysis and executive reporting.

## Date range

Use the date picker to select the time window displayed on the chart. Both the chart and the data table update to reflect the selected range.

## Filters

Click **Filters** to narrow the data. You can combine multiple filters.

| Filter | Description |
|--------|-------------|
| **Platforms** | iOS, Android, or both |
| **Countries** | Filter by user country |
| **Screens** | Filter by the paywall screen that triggered the subscription |
| **Placements** | Filter by where in the app the paywall was shown |
| **Audiences** | Filter by audience segment |
| **A/B tests** | Filter by A/B test the user was enrolled in |
| **Campaigns** | Filter by campaign attribution |
| **Plans** | Filter by specific subscription plan |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.) |

# Common use cases

- **Track overall subscriber growth** — Use the default "All active subscriptions" view in monthly granularity to see whether your total subscriber base is growing, plateauing, or declining over time.
- **Measure the paid-to-free ratio** — Switch between "Paid subscriptions only" and "Free subscriptions only" in the Show dropdown to understand how much of your base is monetized versus on free trials or free plans.
- **Compare platforms** — Group by Platform to see if your iOS and Android subscriber bases are growing at different rates, which can inform where to invest in acquisition.
- **Evaluate a campaign or paywall change** — Filter by a specific A/B test, Screen, or Campaign and compare the subscription base before and after the change to assess its impact on net subscriber growth.
- **Identify country-level trends** — Group by Country to find markets where your subscriber base is expanding or contracting, helping prioritize localization and marketing efforts.
- **Monitor plan mix over time** — Group by Plan or Plan periodicity to track whether users are shifting toward longer billing cycles (e.g., from monthly to yearly), which affects revenue predictability.

# Frequently asked questions

## What does "active" mean exactly?

A subscription is counted as active if it has a valid entitlement at the end of the measured period. This includes subscriptions that are currently in a **billing retry (grace) period** — the app store is retrying the charge, but the user still has access. A subscription stops being active when it is fully expired, cancelled without remaining access, or refunded.

## Why does the count change when I apply filters?

Filters restrict which subscriptions are included in the count. For example, filtering by "Platform = iOS" shows only iOS subscriptions. If you also filter by a specific Screen, only subscriptions that originated from that paywall on iOS are counted. Filters are cumulative — each additional filter further narrows the dataset.

## Is this chart showing new subscriptions or total subscriptions?

Total active subscriptions. This is a **stock metric** (how many subscriptions exist at a point in time), not a **flow metric** (how many were created during a period). If you are looking for new subscriptions started during a period, use the Subscription Funnel or Subscription Events charts instead.

## Why do I see a drop followed by a recovery in the daily view?

This typically indicates a batch of subscriptions exiting their **grace period** and moving to a terminated or unpaid state. While a subscription is in its grace period it remains active, but once the grace period expires without a successful charge, the subscription loses its active status and the count drops. If the store successfully retries the charge before the full retry window expires, those subscriptions are restored and the count recovers. In daily granularity these fluctuations are visible; in weekly or monthly views they tend to smooth out.

## Can the same subscription appear in multiple "Grouped by" segments?

No. Each subscription is assigned to exactly one segment per dimension. For example, when grouping by Platform, a subscription is either iOS or Android — it cannot appear in both. The segments within a grouped view always sum to the total.

## Why does "All active subscriptions" not equal "Paid" plus "Free"?

It should. "All active subscriptions" is the sum of paid and free subscriptions. If you notice a discrepancy, check whether additional filters are applied that may affect the comparison. Make sure you are looking at the same date range and granularity for both views.