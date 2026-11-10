---
title: Subscription Base Evolution
---
# About this chart

The Subscription Base Evolution chart shows the total count of active subscriptions over time as a bar chart. It helps you track the growth or decline of your subscriber base, spot trends across segments, and understand how your acquisition and retention efforts translate into active subscriptions at the end of any given day, week, or month.

<DashboardV1CountingChange />

# How to read the chart

Each bar represents the number of **active subscriptions at the end of the corresponding time period**. A subscription is active if it has a valid entitlement at that point in time: auto-renewing, cancelled but not yet expired, or in a grace period (the user keeps access while the store retries billing). A subscription in billing retry, paused, expired or refunded is not active.

| Element                  | Description                                                                                                                                              |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Bar height**           | The number of subscriptions active at the end of that period                                                                                             |
| **Tooltip**              | Hover over a bar to see the exact date and count breakdown. When grouped, each segment appears as a separate value                                      |
| **Data table**           | Below the chart, a table lists each period with its corresponding count. Use the **Export CSV** button to download the raw data                          |
| **Chart / Table toggle** | Icons in the top-right corner let you switch between the visual chart and the tabular view                                                               |

When a **Grouped by** dimension is applied, the bars are stacked or split by segment, and the tooltip and data table reflect the breakdown. Groups beyond the ten largest over the selected range are combined into **Other**.

To split the same base by **subscription status** (auto-renewing, auto-renewing cancelled, in grace period), use the [Subscription Status](subscription-status) chart: it is this chart grouped by status.

> 📘 **A stock, not a flow**
>
> This chart counts how many subscriptions exist at a point in time. Never add the bars together. Each bar reads the end of its calendar period; the last bar reads the end date of your range, so a range ending today shows today's base.

# How the count is built

1. Purchasely reads every activation and deactivation event of your subscriptions, looking back before the start of your date range by the plan length plus 60 days (at most 425 days), so that the subscriptions active at the start are known.
2. Each subscription is cut into segments: a segment opens on an activation event and closes on the next deactivation event, or on the next activation event that changes the offer (for example a free trial converting to a paid price).
3. A segment counts in a period when it opened before the end of the period and closed after it. A subscription that starts and ends inside the same period is not active at its close and does not appear in that bar.
4. The price of a segment (free, discounted, full price) is the price of the event that opened it. The **Show** control keeps the segments of the selected price.

# Controls

### Show

Filter the type of subscriptions included in the chart:

| Option                            | What it includes                                                                                   |
| --------------------------------- | -------------------------------------------------------------------------------------------------- |
| **All active subscriptions**      | Every active subscription, paid and free combined                                                  |
| **Paid subscriptions only**       | Subscriptions currently paying: full price, or a paid offer                                        |
| **Full-price subscriptions only** | Paid subscriptions at the standard price                                                           |
| **Discounted subscriptions only** | Subscriptions currently on a paid introductory offer, promo code or promotional offer at a reduced price |
| **Free subscriptions only**       | Subscriptions currently in a free trial or on a free offer (promotional offer or promo code at no cost) |

A subscription moves from one option to another when its price changes: a free trial that converts on the 10th is counted under **Free** at the end of the previous period and under **Paid** at the end of this one.

### Grouped by

Break down the bars by a dimension to compare segments side by side:

| Dimension               | Description                                                                                                         |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **None**                | Single bar per period, no breakdown                                                                                 |
| **Platform**            | Split by iOS, Android, or other platforms                                                                           |
| **Placement**           | Split by where in the app the paywall was shown                                                                     |
| **Audience**            | Split by the audience the user matched at the time of the activation event                                          |
| **Country**             | Split by **store country**: the country of the App Store or Play Store account used for the purchase. "Unknown" means the store did not report a country |
| **Screen**              | Split by the paywall screen that triggered the subscription                                                         |
| **Plan**                | Split by subscription plan                                                                                          |
| **Plan periodicity**    | Split by billing cycle (weekly, monthly, yearly, etc.)                                                              |
| **Campaign**            | Split by campaign attribution                                                                                       |
| **A/B test variant**    | Split by the A/B test variant attached to the activation event                                                      |
| **Offer types**         | Split by how the subscription started (direct, trial, intro offer, promo code, promotional offer)                   |
| **Payment types**       | Split by current price: free offer, paid offer or full price                                                        |

### Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution of the bars.

* **Daily** — One bar per day. Best for spotting short-term fluctuations and the impact of specific events.
* **Weekly** — One bar per week. Good for smoothing out day-of-week noise while keeping reasonable detail.
* **Monthly** — One bar per month. Best for long-term trend analysis and executive reporting.

### Date range

Use the date picker to select the time window displayed on the chart. Both the chart and the data table update to reflect the selected range. The first bar includes the subscriptions that were already active before the range.

### Filters

<DashboardFilters />

| Filter               | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| **Platforms**        | iOS, Android, or both                                        |
| **Countries**        | Filter by store country (see Grouped by)                     |
| **Screens**          | Filter by the paywall screen that triggered the subscription |
| **Placements**       | Filter by where in the app the paywall was shown             |
| **Audiences**        | Filter by the audience the user matched                      |
| **A/B tests**        | Filter by the A/B test variant attached to the subscription  |
| **Campaigns**        | Filter by campaign attribution                               |
| **Plans**            | Filter by specific subscription plan                         |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.)      |
| **Offer types**      | Filter by how the subscription started (direct, trial, intro offer, promo code, promotional offer) |

# Common use cases

* **Track overall subscriber growth** — Use the default "All active subscriptions" view in monthly granularity to see whether your total subscriber base is growing, plateauing, or declining over time.
* **Measure the paid-to-free ratio** — Switch between "Paid subscriptions only" and "Free subscriptions only" in the Show dropdown to understand how much of your base is monetized versus in a free trial or free offer.
* **Anticipate churn** — Open the [Subscription Status](subscription-status) chart. The "Auto-renewing cancelled" share is the part of your base that has already decided to leave; a win-back campaign targets it before expiry.
* **Compare platforms** — Group by Platform to see if your iOS and Android subscriber bases are growing at different rates, which can inform where to invest in acquisition.
* **Evaluate a campaign or paywall change** — Filter by a specific A/B test, Screen, or Campaign and compare the subscription base before and after the change to assess its impact on net subscriber growth.
* **Identify country-level trends** — Group by Country to find markets where your subscriber base is expanding or contracting, helping prioritize localization and marketing efforts.
* **Monitor plan mix over time** — Group by Plan or Plan periodicity to track whether users are shifting toward longer billing cycles (e.g., from monthly to yearly), which affects revenue predictability.

# Frequently asked questions

### What does "active" mean exactly?

A subscription is counted as active if it has a valid entitlement at the end of the measured period. This includes subscriptions that are cancelled but have not reached their expiry date, and subscriptions in a **grace period** (the store is retrying the charge and the user still has access). It does not include subscriptions in **billing retry** (the store is still retrying, but the user has lost access), paused subscriptions, expired or refunded subscriptions.

### Why does my "Free" base drop when nothing churned?

Because free trials converted. A subscription changes option in the Show control when its price changes: the day a trial converts, it leaves "Free subscriptions only" and enters "Paid subscriptions only". Check the Paid view, or the Subscription Activations chart with the full-price segment, before reading the drop as churn.

### Why is the last bar lower than the others in a weekly or monthly view?

Every bar reads the end of its calendar period, except the last one, which reads the end date of your range. A range ending on the 15th shows, in its last monthly bar, the base on the 15th. Extend the range to the end of the month to compare it with the previous months.

### Why does the count change when I apply filters?

Filters restrict which subscriptions are included in the count. For example, filtering by "Platform = iOS" shows only iOS subscriptions. If you also filter by a specific Screen, only subscriptions that originated from that paywall on iOS are counted. Filters are cumulative: each additional filter further narrows the dataset.

### Is this chart showing new subscriptions or total subscriptions?

Total active subscriptions. This is a **stock metric** (how many subscriptions exist at a point in time), not a **flow metric** (how many were created during a period). If you are looking for new subscriptions started during a period, use the Subscription Activations, Paid Subscriptions Movements or Subscription Reactivations charts instead. The movements do not add up exactly to the variations of this chart: they follow different rules (billing retry counts as churn on its date in Movements, for example).

### Why do I see a drop followed by a recovery in the daily view?

This typically indicates a batch of subscriptions exiting their **grace period** and moving to billing retry. While a subscription is in its grace period it remains active, but once the grace period expires without a successful charge, the subscription loses its active status and the count drops. If the store successfully retries the charge before the full retry window expires, those subscriptions are restored and the count recovers. In daily granularity these fluctuations are visible; in weekly or monthly views they tend to smooth out.

### Why does a weekly subscription never show up in my monthly chart?

A bar counts the subscriptions active at the end of the period. A subscription that starts and ends inside the same month, like a one-week subscription that is not renewed, is not active at the end of the month and does not appear in the monthly bar. Use Daily or Weekly granularity to see it.

### How do Google Play paused subscriptions affect the count?

Pause is a Google Play-only feature. When a subscription is paused:

* It is **removed** from the active subscription count (the user loses access during the pause).
* When it automatically resumes after the pause period, it **re-enters** the active count.

This creates a temporary dip in your subscription base that resolves when the pause period ends. If you see periodic dips concentrated on Android, filter by Platform to check whether paused subscriptions are the cause.

### How are Google Play prepaid plans counted?

Prepaid plans (Google Play only) do not auto-renew. Each top-up creates a new subscription record. As a result:

* A prepaid subscription **leaves** the active count when its prepaid period expires.
* If the user tops up, a **new** subscription enters the active count.

This can create a saw-tooth pattern for apps with a significant prepaid user base. The subscriber does not churn in the traditional sense (they intend to continue), but each top-up is technically a new subscription.

### Can the same subscription appear in multiple "Grouped by" segments?

No. Each subscription is assigned to exactly one segment per dimension at a given time. For example, when grouping by Platform, a subscription is either iOS or Android, never both. The segments within a grouped view always sum to the total.

### Why does "All active subscriptions" not equal "Paid" plus "Free"?

It does, except for subscriptions whose price could not be classified (older events without a payment type). Those are counted in "All active subscriptions" and in neither "Paid" nor "Free". If the gap is large, contact support with the app and the date.
