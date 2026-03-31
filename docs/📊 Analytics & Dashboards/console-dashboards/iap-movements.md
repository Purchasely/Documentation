---
title: IAP-movements
---
# About this chart

The IAP Movements chart tracks the volume of **In-App Purchase (IAP)** transactions over time, broken down by app store. It helps you monitor purchase activity for your one-time products — consumables and non-consumables — across Apple App Store and Google Play Store.

> **IAP vs. Subscriptions**
>
> This chart covers **one-time purchases only** (consumables and non-consumables). It does not include subscription transactions. For subscription volume and movement tracking, refer to the dedicated subscription charts such as Paid Subscriptions Movements and Subscription Events.
>
> - **Consumables**: items that can be purchased multiple times (e.g., coin packs, extra lives, tokens).
> - **Non-consumables**: items purchased once and owned permanently (e.g., a premium filter, an unlock of a feature, ad removal).

# How to read the chart

The chart is a **stacked bar chart** showing the number of purchased items per time period, with each bar split by platform.

| Element | Description |
|---------|-------------|
| **Green segment** | Purchases made on the **Apple App Store** (iOS) |
| **Blue segment** | Purchases made on the **Google Play Store** (Android) |
| **Other segments** | If your app is also distributed on Huawei AppGallery, Amazon Appstore, or uses Stripe for web payments, transactions from those stores will appear as additional segments |
| **Y-axis** | Total count of purchased items |
| **X-axis** | Date range, with intervals matching the selected granularity |
| **Bar height** | Total purchases across both platforms for that period |

Hover over any bar to see the exact count per platform for that date or period.

Below the chart, a **data table** lists every time period with its corresponding purchased items count. Use the **Download CSV** button to export this data for further analysis.

The chart title updates dynamically based on the selected granularity: "Daily purchased items by store", "Weekly purchased items by store", or "Monthly purchased items by store".

# Controls

## Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution of the bars.

- **Daily** — One bar per day. Best for spotting short-term spikes tied to promotions or events.
- **Weekly** — One bar per week. Smooths out daily noise while preserving weekly patterns.
- **Monthly** — One bar per month. Best for long-term trend analysis and executive reporting.

## Filters

Click **Filters** to narrow the data. You can combine multiple filters.

| Filter | Description |
|--------|-------------|
| **Countries** | Filter by the country where the purchase was made |
| **Plans** | Filter by specific IAP product plan (e.g., a particular coin pack or feature unlock) |
| **Platforms** | Apple (App Store), Google (Play Store), or both |
| **Product types** | Filter by consumable or non-consumable products |

## Data table and export

The table below the chart displays the same data in tabular form.

| Column | Description |
|--------|-------------|
| **Dates** | The time period (day, week, or month depending on granularity) |
| **Purchased Items** | Total number of IAP transactions during that period |

Click **Download CSV** to export the table for use in spreadsheets or BI tools.

# Common use cases

- **Track the impact of a promotion or sale** — Switch to daily granularity and look for spikes around the dates when you ran a limited-time offer on a consumable or non-consumable product. Compare the spike to the baseline before and after.
- **Compare platform performance** — Use the stacked bars to see whether Apple or Google dominates your IAP revenue mix. If one platform lags significantly, investigate whether pricing, paywall placement, or store visibility differs.
- **Monitor consumable vs. non-consumable trends separately** — Use the Product types filter to isolate consumables and view their purchase frequency independently. Consumable volume should be recurring if users are engaged; a decline may signal engagement issues.
- **Validate a new IAP product launch** — After launching a new non-consumable or consumable, filter by that specific plan to monitor adoption day by day and confirm it is generating transactions as expected.
- **Spot seasonal or weekly patterns** — Use weekly or monthly granularity to identify recurring patterns such as higher purchase volumes on weekends or during holiday periods, then align your marketing efforts accordingly.

# Frequently asked questions

## What counts as an "In-App Purchase" in this chart?

This chart counts **one-time purchases** processed through Apple App Store, Google Play Store, or other connected stores. These are either consumable items (purchased and used up, can be re-purchased) or non-consumable items (purchased once and owned permanently). Auto-renewing and non-renewing subscriptions are excluded and tracked in the subscription-specific charts.

## Are refunded purchases still counted?

Yes. This chart counts all purchase transactions at the time they occur, regardless of whether they are later refunded. A purchase that is subsequently refunded still appears in the bar for its purchase date. To monitor refund volumes, use the dedicated IAP Refunds chart.

## Why do I see purchases on only one platform?

If your app is available on both iOS and Android but purchases appear for only one platform, check the following: the IAP products may not be configured in both stores, the Purchasely SDK may not be processing IAPs on both platforms, or you may have the Platforms filter active and set to a single platform.

## What is the difference between "Plans" and "Product types" in the filters?

**Product types** is a broad category filter that lets you choose between consumable and non-consumable products. **Plans** is a specific filter that lets you select individual IAP products (e.g., "100 Coins Pack" or "Premium Unlock"). Use Product types to compare categories, and Plans to drill into a specific product.

## Can I see revenue amounts in this chart?

No. The IAP Movements chart tracks **transaction volume** (count of purchased items), not revenue. Each bar represents how many items were purchased, regardless of their price. For revenue analysis, refer to the Revenue dashboard.

## Why might daily totals not match weekly or monthly totals exactly?

Small discrepancies can occur when a purchase is processed near a time-boundary (e.g., midnight between two days, or the boundary between two weeks). The timestamp used for bucketing may place the transaction in different periods depending on the granularity. These differences are minor and expected.