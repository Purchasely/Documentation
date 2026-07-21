---
title: IAP refunds
---
# About this chart

The IAP Refunds chart tracks the percentage of one-time in-app purchases (consumables and non-consumables) that were eventually refunded, plotted over time by purchase date. It helps you monitor refund trends for non-subscription products, detect spikes that may signal product issues or store policy changes, and compare refund behavior across platforms, plans, and countries.

Unlike the Subscription Refunds chart which focuses on recurring subscriptions, this chart is dedicated to one-time in-app purchases. Consumable purchases (e.g., coin packs, tokens) and non-consumable purchases (e.g., lifetime unlocks, permanent upgrades) may exhibit very different refund patterns and should be analyzed separately using the available filters.

> ❗️ **Pre-requisite: Server-to-server notifications**
>
> Refund data is only available if your app's Server-to-Server (S2S) notifications are properly configured and connected to Purchasely. Without this, Purchasely has no way of being notified when a refund is granted by the store, and this chart will remain empty. 
>
> 📚 See [Apple App Store configuration](app-store-configuration#8-the-server-to-server-end-point---only-for-subscription-apps) and [Google Play Store configuration](play-store-configuration#server-to-server-notifications) for setup instructions.

# How to read the chart

The chart is a **line chart** with the refund rate (%) on the vertical axis and time on the horizontal axis. Each data point represents in-app purchases made during that period and shows what share of them have been refunded to date.

A **data table** below the chart provides the raw numbers for each period:

| Column              | Description                                                                                   |
| ------------------- | --------------------------------------------------------------------------------------------- |
| **Dates**           | The period when the purchases were made (not when the refund was issued)                      |
| **Refund Rate (%)** | Percentage of purchases from that period that have been refunded so far (Refunds / Purchases) |
| **Refunds**         | Absolute count of refunded purchases for that period                                          |
| **Purchases**       | Total number of in-app purchases made during that period                                      |

**Important:** because refunds can be issued days, weeks, or months after the original purchase, values for past periods may change retroactively as new refunds come in. A refund rate near 0% for recent dates is expected and does not indicate a problem -- refunds simply have not had enough time to occur yet. Allow at least 14-30 days before considering a period's refund rate stable. One-time purchases typically have a shorter refund window than subscriptions (Apple allows refund requests within 14 days for most IAPs; Google Play has a shorter self-service window), but store policies vary and edge cases can extend this timeline.

# Controls

### Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution.

* **Daily** -- One data point per day. Best for spotting sudden spikes tied to a specific release or promotional event.
* **Weekly** -- One data point per week. Good for smoothing day-to-day noise while still catching trends.
* **Monthly** -- One data point per month. Best for long-term trend analysis and executive reporting.

### Filters

<DashboardFilters />

| Filter            | Description                                         |
| ----------------- | --------------------------------------------------- |
| **Countries**     | Filter by user country                              |
| **Plans**         | Filter by specific in-app purchase plan             |
| **Platforms**     | iOS, Android, or both                               |
| **Product types** | Filter by product type (consumable, non-consumable) |

### Download CSV

Click **Download CSV** to export the data table for further analysis in a spreadsheet or BI tool. The export includes all columns (Dates, Refund Rate, Refunds, Purchases) for the currently selected granularity and filters.

# Common use cases

* **Compare refund rates across platforms** -- Filter by Platform to compare iOS and Android. Apple and Google have different refund policies and timelines. Apple processes refund requests through Apple Support, while Google Play offers a shorter self-service refund window. Significant differences in refund rate between platforms are common and expected for in-app purchases.
* **Separate consumable from non-consumable refund behavior** -- Use the Product types filter to analyze consumables and non-consumables independently. Consumable products (e.g., coin packs) may have different refund patterns than non-consumables (e.g., lifetime unlocks). A high refund rate on consumables could indicate buyer's remorse or fraud, while high refunds on non-consumables may suggest unclear product value.
* **Detect a problematic app release** -- A sudden spike in refund rate for purchases made around a specific date may indicate a bug that prevents users from accessing their purchased content. Use daily granularity to pinpoint the exact date and cross-reference it with your release timeline.
* **Monitor the impact of a pricing change** -- After adjusting prices on in-app purchase products, monitor whether refund rates increase for the affected plans. Filter by Plan and compare the periods before and after the change to assess price sensitivity.
* **Identify high-refund regions** -- Filter by Country to spot markets with unusually high refund rates. Some regions have higher refund tendencies due to local consumer protection regulations, payment culture, or fraud patterns. This insight can help you adjust your monetization strategy per market.

# Frequently asked questions

### Why is the refund rate 0% for recent dates?

This is expected behavior. The date axis represents when the purchase was **made**, not when the refund was issued. Refunds typically occur days or weeks after the original purchase. Recent periods have not had enough time to accumulate refunds. Wait at least 14-30 days before drawing conclusions about a period's refund rate.

<br />

> ❗️ **Pre-requisite: Server-to-server notifications**
>
> Refund data is only available if your app's Server-to-Server (S2S) notifications are properly configured and connected to Purchasely. Without this, Purchasely has no way of being notified when a refund is granted by the store, and this chart will remain empty.
>
> 📚 See [Apple App Store configuration](app-store-configuration#8-the-server-to-server-end-point---only-for-subscription-apps) and [Google Play Store configuration](play-store-configuration#server-to-server-notifications) for setup instructions.

### Why do past values keep changing?

Because refund data is anchored to the purchase date, a refund issued today for a purchase made two months ago will retroactively increase the refund rate for that earlier period. This is by design -- it gives you an accurate picture of the true refund rate for each purchase cohort. Values stabilize over time as the window for potential refunds closes.

### How is the Refund Rate calculated?

Refund Rate = (Refunds / Purchases) x 100, where both values correspond to the same period based on purchase date. For example, if 1,000 in-app purchases were made in January and 20 of them have been refunded to date, the refund rate for January is 2.0%. Each refunded purchase counts as one refund regardless of whether it was a full or partial refund.

### Why do consumables and non-consumables have different refund rates?

Consumable and non-consumable products have fundamentally different user expectations. Consumables are used immediately (e.g., in-game currency), so users may request refunds quickly if the purchased item does not meet expectations or if they made an accidental purchase. Non-consumables represent permanent unlocks, so refund requests may come later if the user feels the product does not deliver long-term value. Use the Product types filter to analyze each category separately and set appropriate benchmarks.

### Why is my iOS refund rate different from Android?

Apple and Google handle in-app purchase refunds differently. Apple processes refund requests through Apple Support and has historically been more permissive with refund approvals. Google Play has its own refund policies and timelines. These policy differences naturally lead to different refund rate baselines for each platform. Filter by Platform to analyze each one separately and avoid comparing absolute rates across platforms.
