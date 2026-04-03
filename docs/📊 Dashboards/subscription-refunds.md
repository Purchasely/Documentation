---
title: Subscription Refunds
---
# About this chart

The Subscription Refunds chart tracks the percentage of subscriptions that were eventually refunded, plotted over time by subscription start date. It helps you monitor refund trends, detect spikes that may signal product or billing issues, and compare refund behavior across platforms, plans, and acquisition sources.

> ⚠️ **Change from dashboard v1: counting subscriptions, not subscribers**
>
> The previous version of this dashboard counted **unique subscribers** (users). Dashboard v2 now counts **unique subscriptions**, each identified by a unique subscription ID.
>
> This changes the numbers in two ways:
>
> * **Restored subscriptions across devices:** In v1, when a subscription was restored on a new device by a different anonymous user, it was counted multiple times — once for each anonymous user associated with it. In v2, the subscription is counted only once regardless of how many devices or anonymous users it passes through.
> * **Multiple subscriptions per user:** In v1, a user holding two active subscriptions simultaneously was counted once (one user). In v2, each subscription is counted individually, so the same user contributes two to the total.
>
> **Example:** Alice holds both a monthly Music plan and a yearly Premium plan. In v1, Alice counted as 1 subscriber. In v2, she counts as 2 active subscriptions. Conversely, if a single subscription was restored across 3 anonymous devices in v1, it appeared as 3 subscribers — in v2 it correctly counts as 1 subscription.

# How to read the chart

The chart is a **line chart** with the refund rate (%) on the vertical axis and time on the horizontal axis. Each data point represents subscriptions that **started** during that period and shows what share of them have been refunded to date.

A **data table** below the chart provides the raw numbers for each period:

| Column              | Description                                                                                           |
| ------------------- | ----------------------------------------------------------------------------------------------------- |
| **Dates**           | The period when the subscriptions started (not when the refund was issued)                            |
| **Refund Rate (%)** | Percentage of subscriptions from that period that have been refunded so far (Refunds / Subscriptions) |
| **Refunds**         | Absolute count of refunded subscriptions for that period                                              |
| **Subscriptions**   | Total number of subscriptions that started during that period                                         |

**Important:** because refunds can be issued weeks or months after the original purchase, values for past periods may change retroactively as new refunds come in. A refund rate near 0% for recent dates is expected and does not indicate a problem — refunds simply have not had enough time to occur yet. Allow at least 30-90 days before considering a period's refund rate stable.

# Controls

### Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution.

* **Daily** — One data point per day. Best for spotting sudden spikes tied to a specific release or event.
* **Weekly** — One data point per week. Good for smoothing day-to-day noise while still catching trends.
* **Monthly** — One data point per month. Best for long-term trend analysis and executive reporting.

### Filters

Click **Filters** to narrow the data. You can combine multiple filters.

| Filter               | Description                                                                        |
| -------------------- | ---------------------------------------------------------------------------------- |
| **Countries**        | Filter by user country                                                             |
| **Screens**          | Filter by the paywall screen that triggered the subscription                       |
| **Placements**       | Filter by where in the app the paywall was shown                                   |
| **Audiences**        | Filter by audience segment the user belonged to at purchase time                   |
| **Plans**            | Filter by specific subscription plan                                               |
| **Platforms**        | iOS, Android, or both                                                              |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.)                            |
| **Offer types**      | Filter by how the subscription started (trial, intro offer, promo offer, standard) |

# Common use cases

* **Compare refund rates across platforms** — Filter by Platform to compare iOS and Android. Apple and Google have different refund policies: Apple processes refund requests through Apple Support and may grant them more liberally, while Google Play offers a 48-hour self-service refund window. Significant differences in refund rate between platforms are common and expected.
* **Detect a problematic app release** — A sudden spike in refund rate for subscriptions that started around a specific date may indicate a bug or broken feature introduced in a new version. Use daily granularity to pinpoint the exact date.
* **Evaluate offer quality** — Filter by Offer types to compare refund rates for trial conversions vs. full-price subscriptions. If trial-converted subscriptions have a significantly higher refund rate, users may feel misled by the trial experience or pricing.
* **Assess paywall impact** — Filter by Screen or Placement to identify whether a specific paywall leads to higher refund rates, which may suggest the paywall is creating misleading purchase expectations.
* **Monitor country-specific behavior** — Filter by Country to spot regions with unusually high refund rates. Some markets have higher refund tendencies due to local consumer protection regulations or payment culture.
* **Track the effect of a pricing change** — After adjusting plan prices, monitor whether refund rates increase for the affected plans. Filter by Plan and compare the periods before and after the change.

# Frequently asked questions

### Why is the refund rate 0% for recent dates?

This is expected behavior. The date axis represents when the subscription **started**, not when the refund was issued. Refunds typically occur days, weeks, or even months after the original purchase. Recent periods have not had enough time to accumulate refunds. Wait at least 30-90 days before drawing conclusions about a period's refund rate.

### Why do past values keep changing?

Because refund data is anchored to the subscription start date, a refund issued today for a subscription that started three months ago will retroactively increase the refund rate for that earlier period. This is by design — it gives you an accurate picture of the true refund rate for each acquisition cohort. Values stabilize over time as the window for potential refunds closes.

### How is the Refund Rate calculated?

Refund Rate = (Refunds / Subscriptions) x 100, where both values correspond to the same period based on subscription start date. For example, if 500 subscriptions started in January and 15 of them have been refunded to date, the refund rate for January is 3.0%.

### Why is my iOS refund rate higher than Android?

Apple and Google handle refunds differently. Apple processes refund requests through Apple Support and historically has a more permissive refund policy. Google Play provides a 48-hour self-service refund window and processes later requests through Google Support. These policy differences naturally lead to different refund rate baselines for each platform. Filter by Platform to analyze each one separately.

### Can a refund happen without revoking access?

Yes. On Google Play, a refund does not automatically revoke the subscription entitlement. A developer (or Google Support) can issue a refund while letting the user keep access until the current period ends. On the App Store, refunds typically revoke access immediately. This means a refunded subscription on Android may still appear as "active" in other charts (Subscription Base, Subscription Status) until the current billing period expires. The refund rate in this chart counts the refund regardless of whether access was revoked.

### Can I see when the refund was actually issued?

No. This chart plots refund data by subscription start date to help you evaluate the quality of your acquisition cohorts. It does not show refund timing. If you need to track when refunds are processed, use the server events (REFUND lifecycle event) which include timestamps for both the original transaction and the refund.

### What counts as a refund?

A refund is counted when the app store (Apple or Google) processes a full or partial refund for a subscription transaction. This includes refunds initiated by the user through store support, refunds granted automatically by store policies, and refunds initiated by the developer. The chart reflects refund data as reported by the stores through their server notifications.
