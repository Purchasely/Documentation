---
title: Subscription Reactivations
---
# About this chart

The Subscription Reactivations chart tracks how many previously churned or terminated subscriptions have been re-started by the same user over time. It helps you measure the effectiveness of win-back campaigns, detect organic re-engagement patterns, and understand whether former subscribers are returning to your app.

A reactivation occurs when a user who had a fully terminated subscription starts subscribing again. This is distinct from a billing retry recovery, where a subscription temporarily lapses due to a payment failure and is automatically restored by the app store. Billing retries are not counted as reactivations.

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

The chart displays a **bar chart with overlaid trend lines**. Each bar represents a time period (day, week, or month) depending on the selected granularity.

| Element | Description |
|---------|-------------|
| **Blue bars** | The count of new reactivations during that period |
| **Orange line** | A trend line showing the general direction of reactivation volume over time |
| **Dotted line** | The average number of reactivations across the visible date range |

Below the chart, a **data table** lists each period with its corresponding reactivation count for precise reference.

# Controls

## Show

Filter reactivations by subscription type:

| Mode | What it shows |
|------|---------------|
| **All Reactivations** | Both paid and free (trial) reactivations combined |
| **Free Reactivations only** | Only reactivations where the user re-started with a zero-cost free trial |
| **Paid Reactivations only** | Only reactivations where the user re-started with a paid intro offer, a paid promotional offer, or directly at full price (excludes free trial restarts) |
| **Full-price Reactivations only** | Only reactivations where the user re-started at full price, excluding any offer or trial |

## Grouped by

Break down reactivation data by a dimension to compare segments side by side:

| Group | Description |
|-------|-------------|
| **None** | No grouping; shows total reactivations as a single series |
| **Platform** | Split by iOS, Android, etc. |
| **Placement** | Split by the in-app location where the paywall was shown |
| **Audience** | Split by the audience segment the user belonged to |
| **Country** | Split by the user's country |
| **Screen** | Split by the paywall screen that triggered the reactivation |
| **Plan** | Split by subscription plan |
| **Plan periodicity** | Split by billing cycle (weekly, monthly, yearly, etc.) |
| **Offer types** | Split by how the reactivation started (trial, intro offer, promo offer, standard) |
| **Event types** | Split by the type of reactivation event |

## Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution of each bar.

- **Daily** -- One bar per day. Best for spotting short-term spikes after a specific campaign or event.
- **Weekly** -- One bar per week. Good for smoothing out day-to-day noise while retaining detail.
- **Monthly** -- One bar per month. Best for long-term trend analysis and executive reporting.

## Filters

Click **Filters** to narrow the data. You can combine multiple filters.

| Filter | Description |
|--------|-------------|
| **Platforms** | iOS, Android, or both |
| **Screens** | Filter by the paywall screen that triggered the reactivation |
| **Placements** | Filter by where in the app the paywall was shown |
| **Audiences** | Filter by audience segment the user belonged to at reactivation time |
| **A/B tests** | Filter by A/B test the user was enrolled in |
| **Campaigns** | Filter by campaign attribution |
| **Countries** | Filter by user country |
| **Plans** | Filter by specific subscription plan |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.) |

# Common use cases

- **Measure win-back campaign performance** -- After launching a win-back push notification or email campaign, use the daily granularity to check for a spike in reactivations in the days following the campaign. Group by Audience to see which user segments responded best.
- **Compare reactivation quality across offer types** -- Use the Show dropdown to compare Free vs. Paid vs. Full-price reactivations. A high proportion of full-price reactivations suggests strong product-market fit, while heavy reliance on free trials may indicate users are not yet convinced of the value.
- **Identify platform differences** -- Group by Platform to see if iOS and Android users reactivate at different rates. Differences may point to platform-specific billing behaviors or varying effectiveness of re-engagement surfaces.
- **Evaluate paywall effectiveness for churned users** -- Group by Screen or Placement to determine which paywall designs or in-app locations are most effective at converting returning users. This can inform dedicated win-back paywall strategies.
- **Track seasonal re-engagement patterns** -- Use monthly granularity over a long date range to spot seasonal trends. Some apps see reactivation spikes around New Year, back-to-school, or other events relevant to their user base.
- **Benchmark reactivation trends against churn** -- Monitor the trend line and average line together. A rising trend line alongside stable or declining churn suggests your retention and win-back efforts are working. If both reactivations and churn are rising, you may be cycling the same users through repeated churn-and-return loops.

# Frequently asked questions

## What counts as a reactivation?

A reactivation is recorded when a user whose subscription was fully terminated (voluntary cancellation, involuntary churn after failed billing retries, or expiration) starts a new subscription for the same product. The key distinction is that the previous subscription must have been completely ended -- not just in a grace period or billing retry window.

## How is a reactivation different from a billing retry recovery?

A billing retry recovery happens when a subscription payment fails, the app store retries the charge over several days, and the payment eventually succeeds. During this period the subscription was never fully terminated -- it was in a retry or grace period. A reactivation, on the other hand, only occurs after the subscription has been definitively terminated and the user actively re-subscribes.

More specifically, on Google Play there are two recovery stages that are **not** reactivations:

| Recovery type | What happened | Reactivation? |
| :------------ | :------------ | :------------ |
| **Grace period recovery** | Payment failed, retried successfully while user still had access | No — subscription never left active state |
| **Account hold recovery** | Payment failed, user lost access, then payment succeeded during the hold window (up to 60 days) | No — the store restored the original subscription automatically |
| **Re-subscribe after expiration** | Subscription fully expired, user actively purchases again | **Yes** — this is a reactivation |

On the App Store, the equivalent distinction is between billing retry recovery (not a reactivation) and a new purchase after expiration (reactivation).

## Are high reactivation numbers always a good sign?

Not necessarily. A healthy reactivation rate shows that your product has lasting appeal and your win-back efforts are effective. However, if reactivations are growing in parallel with churn, it may indicate a revolving-door pattern where the same users repeatedly churn and return. In that case, focus on understanding why users leave in the first place rather than celebrating their return.

## Can a single user generate multiple reactivations?

Yes. If a user churns, reactivates, churns again, and reactivates again, each return is counted as a separate reactivation event. Monitoring users with multiple reactivations can help you identify pricing or value-perception issues.

## Why do I see a spike in reactivations without running any campaign?

Organic reactivations can happen for several reasons: app store featuring, seasonal interest in your app category, OS-level subscription management prompts reminding users of lapsed subscriptions, or external events that make your product relevant again. Group by Country or Platform to see if the spike is concentrated in a specific segment.

## How should I use the trend and average lines?

The average line gives you a baseline for what "normal" reactivation volume looks like over the selected period. The trend line shows whether reactivations are generally increasing or decreasing. If the trend line sits above the average, reactivations are accelerating. If it dips below, they are slowing down. Use both together to distinguish a temporary spike from a sustained improvement.