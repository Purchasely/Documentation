---
title: Revenue
---
# About this chart

The Revenue page shows the gross money your users paid over time. It helps you track how much your app collects, spot revenue trends, and compare platforms, countries or plans.

The page holds two charts that share the same filters:

* **Subscriptions** — purchases and renewals of your subscription plans
* **In-App Purchases** — consumables and non-consumables

Each chart is a **stacked bar chart**: one bar per period (day, week, or month), split by the dimension chosen in its **Grouped by** selector: Platform (default), Country or Plan. The Y-axis shows revenue in the dashboard currency of your app settings. The X-axis shows dates.

# How to read the chart

Each bar represents the total gross revenue for a given period. The height of the full bar is the combined revenue; the colored segments show the contribution of each platform, country or plan, depending on the grouping.

| Element          | Description                                                                                            |
| ---------------- | ------------------------------------------------------------------------------------------------------ |
| **Bar height**   | Total gross revenue for that period                                                                    |
| **Segments**     | One per platform (Apple, Google, Huawei, Amazon, Stripe), per store country or per plan               |
| **Chart title**  | Adapts to the selected granularity: "Daily revenues", "Weekly revenues", or "Monthly revenues"         |
| **Negative bar** | Refunds exceeded charges that day                                                                      |

Key characteristics of this chart:

* **Gross revenue** — Amounts shown are what users paid, including VAT and before app store commissions (typically 15-30%) are deducted. This is not your net revenue. When a store price excludes tax (US stores for example), the tax of the store country is added.
* **Transaction-date attribution** — A charge is counted on the day it occurred. A refund is counted as a **negative amount on the day the store processed it**, not on the day of the original purchase.
* **Actual transactions, not MRR** — This chart shows real money collected from purchases and renewals. It is not a normalized Monthly Recurring Revenue (MRR) metric. A yearly subscription shows its full amount on the transaction date rather than being spread across 12 months.

# Controls

### Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution of the chart.

| Granularity | What it shows                                                                             |
| ----------- | ----------------------------------------------------------------------------------------- |
| **Daily**   | One bar per day. Best for identifying day-to-day fluctuations and spotting anomalies.     |
| **Weekly**  | One bar per week. Smooths out daily noise while keeping enough detail for trend analysis. |
| **Monthly** | One bar per month. Best for high-level reporting and long-term trend comparison.          |

### Filters

<DashboardFilters />

| Filter               | Description                                                                                              |
| -------------------- | -------------------------------------------------------------------------------------------------------- |
| **Platforms**        | Apple, Google, Huawei, Amazon, Stripe                                                                    |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.); subscriptions only                              |
| **Offer types**      | Filter by the offer of the transaction (intro offer, promotional offer, promo code, standard price); subscriptions only |
| **Countries**        | Filter by store country: the country of the App Store or Play Store account used for the purchase       |
| **Plans**            | Filter by specific plan                                                                                  |

# Common use cases

* **Track overall revenue trajectory** — Use the monthly view to see whether revenue is growing, plateauing, or declining over time. This is the simplest way to monitor the health of your subscription business.
* **Compare platform revenue share** — With Grouped by Platform, look at the relative size of each segment. If one platform is underperforming, you may need to investigate pricing, paywall optimization, or user acquisition on that platform.
* **Identify the impact of a pricing or paywall change** — Switch to daily granularity around the launch date and compare revenue before and after; group by Plan to isolate the plans concerned.
* **Measure seasonality and promotional effects** — Use weekly or monthly granularity to spot recurring patterns (holiday spikes, back-to-school dips) or the revenue impact of promotional campaigns.
* **Analyze revenue by plan** — Group by Plan, or filter by Plan periodicity to compare revenue from weekly, monthly, and yearly subscribers. This helps decide which billing cycles to promote on your paywalls.
* **Evaluate country-level performance** — Group by Country to see which markets generate the most revenue and whether localized pricing strategies are working.

# Frequently asked questions

### What is the difference between this Revenue chart and the MRR chart?

The Revenue chart shows **actual transaction amounts on the date they occurred**. If a user pays 49.99 for a yearly subscription on March 1, the full 49.99 appears in the March 1 bar.

The MRR (Monthly Recurring Revenue) chart **normalizes revenue to a monthly rate**. That same 49.99 yearly subscription would contribute approximately 4.17 per month to MRR. MRR is a forward-looking metric that reflects the expected monthly run rate, while Revenue reflects real cash collected.

Use Revenue to understand actual cash flow. Use MRR to understand the normalized, recurring value of your subscriber base.

### Is the revenue shown gross or net?

Revenue is **gross** — it reflects what users paid. App store commissions (Apple typically takes 15-30%, Google similarly) are not deducted. To estimate your net revenue, apply the appropriate commission rate for your situation (standard vs. Small Business Program, first year vs. subsequent years, etc.).

### Why does my revenue spike on certain days?

Spikes typically correspond to **renewal dates**. If you acquired a large cohort of monthly subscribers on a particular date, their renewals will create a recurring spike roughly every 30 days. Yearly subscribers create annual spikes. Promotional campaigns or featured placements in the app stores can also cause one-time spikes.

### What currency is used?

The currency displayed is the dashboard currency configured in your app settings. Every transaction is stored in USD and converted to that currency at the exchange rate of the day before the transaction.

### Can I see revenue broken down by something other than platform?

Yes. Each chart has a **Grouped by** selector: Platform, Country or Plan. Combine it with the filters to narrow the segment, for example yearly plans grouped by Country.

### Why does my revenue differ from the store payout report?

The chart is gross and tax included, dated at the transaction. The store report is net of commission, on a payout calendar. Expect roughly 15-30% less in the store report, and shifts of a few days around month ends.

### Where do the amounts come from?

From the price the store reports for each transaction. When a store gives no price, Purchasely estimates the amount from the plan pricing in the store country. If the store later provides the real price, the amount is refined.

> **Note:** If your app is also distributed on Huawei AppGallery, Amazon Appstore, or uses Stripe for web payments, transactions from those stores will appear as additional segments in the chart.

<br />

### How do chargebacks and voided purchases affect revenue?

A refund or a chargeback appears as a **negative amount on the day the store notified it**, not on the day of the original purchase. Past periods therefore do not change; the day of the refund goes down, and can go negative. On Google Play, voided purchase notifications cover both refunds and chargebacks for subscriptions. A voided one-time purchase on Google Play is not deducted today.

### How do proration charges appear on plan changes?

When a user upgrades or downgrades, the store may issue a prorated charge for the transition period. This charge does not correspond to a full billing cycle and may appear as a smaller-than-expected transaction. Different proration modes on Google Play (immediate charge, time-based proration, deferred) affect when and how much is charged, which can cause temporary spikes or dips in daily revenue.

<br />
