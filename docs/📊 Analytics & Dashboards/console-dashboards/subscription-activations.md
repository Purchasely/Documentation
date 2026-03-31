---
title: Subscription Activations
---
# About this chart

The Subscription Activations chart counts how many new subscriptions started during a given period. An "activation" is the moment a user begins a subscription for the first time -- whether through a free trial, a paid introductory offer, or a direct full-price purchase. It gives you a clear, day-by-day (or week-by-week, month-by-month) view of acquisition volume so you can spot trends, measure campaign impact, and compare acquisition channels.

This chart is distinct from the "New" column in the Paid Subscriptions Movements chart. Paid Subscriptions Movements only tracks subscriptions that have generated a payment -- free trials are excluded until they convert. Subscription Activations counts every new subscription at the moment it starts, regardless of whether a payment has occurred yet.

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

The chart is a **bar chart with two overlaid lines**.

| Element | Description |
|---------|-------------|
| **Blue bars** | The count of new subscription activations for each time period |
| **Orange line** | A trend line showing the general direction of activations over time |
| **Dotted line** | The average number of activations across the visible date range |

Below the chart, a **data table** lists each time period with its corresponding activation count. You can toggle between chart and table views.

When the trend line sits above the average line, acquisition is accelerating. When it dips below, acquisition is slowing down.

# Controls

## Show

Filter by the type of subscription activation:

| Option | What it includes |
|--------|-----------------|
| **All activations** | Every new subscription start: free trials, paid intro offers, and direct full-price purchases |
| **Free Trials only** | Only subscriptions that started with a free trial period |
| **Paid Intro Offers only** | Only subscriptions that started with a discounted introductory offer (not free) |
| **Direct Full-price Subscriptions only** | Only subscriptions where the user paid full price from the start, with no trial or intro offer |

## Grouped by

Break down the activations by a dimension to compare segments side by side:

| Dimension | Description |
|-----------|-------------|
| **None** | No breakdown -- shows total activations as a single series |
| **Platform** | Split by iOS, Android, etc. |
| **Placement** | Split by the in-app location where the paywall was shown |
| **Audience** | Split by the audience segment the user belonged to at the time of activation |
| **Country** | Split by user country |
| **Screen** | Split by the paywall screen that triggered the subscription |
| **Plan** | Split by subscription plan |
| **Plan periodicity** | Split by billing cycle (weekly, monthly, yearly, etc.) |
| **Offer types** | Split by how the subscription started (trial, intro offer, promo offer, direct) |
| **Event types** | Split by the subscription event type |
| **Payment types** | Split by payment method. This dimension is unique to the Subscription Activations chart and lets you distinguish between standard in-app purchases, promo codes, and other payment methods |

## Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution.

- **Daily** -- One bar per day. Best for spotting short-term spikes or drops (e.g., after a campaign launch).
- **Weekly** -- One bar per week. Good for smoothing out day-of-week noise while keeping reasonable detail.
- **Monthly** -- One bar per month. Best for long-term trend analysis and executive reporting.

## Filters

Click **Filters** to narrow the data. You can combine multiple filters.

| Filter | Description |
|--------|-------------|
| **Platforms** | iOS, Android, or both |
| **Countries** | Filter by user country |
| **Screens** | Filter by the paywall screen that triggered the subscription |
| **Placements** | Filter by where in the app the paywall was shown |
| **Audiences** | Filter by audience segment the user belonged to at activation time |
| **A/B tests** | Filter by A/B test the user was enrolled in |
| **Campaigns** | Filter by campaign attribution |
| **Plans** | Filter by specific subscription plan |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.) |

# Common use cases

- **Measure the impact of a new paywall** -- Launch a new paywall screen, then filter by Screen or use the Grouped by Screen dimension to compare activation volumes before and after the change.
- **Compare acquisition channels** -- Use the Show dropdown to isolate Free Trials, Paid Intro Offers, or Direct Full-price Subscriptions. If most activations come from free trials, your acquisition funnel is trial-dependent; if direct purchases are growing, your value proposition is resonating without a discount.
- **Evaluate a marketing campaign** -- Look for a spike in activations on the day a campaign launches. Filter by Campaign or Placement to attribute the lift to a specific initiative.
- **Spot platform differences** -- Group by Platform to see whether iOS or Android drives more activations. Consistent gaps may indicate platform-specific paywall optimization opportunities.
- **Understand payment method distribution** -- Group by Payment types to see the share of activations coming from standard purchases vs. promo codes or other methods. A high share of promo code activations may signal over-reliance on discounts.
- **Track seasonal patterns** -- Switch to Monthly granularity and look at multi-month trends. Subscription apps often see activation spikes around holidays, back-to-school periods, or New Year resolutions.

# Frequently asked questions

## What counts as an "activation"?

An activation is recorded the moment a user starts a new subscription. This includes three scenarios: (1) the user begins a free trial, (2) the user starts a subscription with a paid introductory offer, or (3) the user purchases a subscription at full price. The activation is counted on the start date, not when a payment is processed.

## How is this different from the "New" count in Paid Subscriptions Movements?

Paid Subscriptions Movements tracks subscriptions that have entered a paid state. Free trials are not included in the "New" count of that chart until the trial converts to a paid subscription. Subscription Activations counts all new subscription starts immediately, including free trials. Use Activations to measure top-of-funnel acquisition volume, and Paid Subscriptions Movements to measure paying subscriber growth.

## Why do weekly totals not match the sum of daily totals?

When using Daily granularity, each bar represents a single day. Weekly bars aggregate an entire week. Due to how time boundaries are aligned (weeks start on Monday), partial weeks at the beginning or end of the selected date range may cause slight differences when you manually sum daily values and compare them to weekly values. This is normal behavior.

## What is the "Payment types" dimension and why is it only available here?

The Payment types grouping dimension lets you break down activations by how the subscription was paid for -- for example, standard in-app purchase, promo code redemption, or offer code. This dimension is specific to the Subscription Activations chart because it is most relevant at the point of acquisition, where understanding the payment method helps assess the quality and source of new subscribers.

## Can I see activations for a specific A/B test variant?

Yes. Click Filters, then select the A/B test you want to analyze. The chart will show only activations from users enrolled in that test. To compare variants, apply the filter for each variant separately and compare the resulting volumes and trends.

## Why did activations spike but revenue did not increase?

This typically happens when the spike comes from free trial starts or deeply discounted intro offers. Use the Show dropdown to isolate "Free Trials only" -- if that segment accounts for the spike, the revenue impact will only appear later, when those trials convert to paid subscriptions.