---
title: Subscription Reactivations
---
# About this chart

The Subscription Reactivations chart tracks how many subscriptions regained access over time after having lost it. It helps you measure the effectiveness of win-back campaigns, detect organic re-engagement patterns, and understand whether former subscribers are returning to your app.

A reactivation is recorded when a **subscription already known to Purchasely** goes from a non-active state back to an active state: a re-subscription on the same store subscription, a **billing retry recovery** after a payment failure had removed access, or the end of a Google Play pause. The exception is **grace period recovery**, where the subscription never leaves the active state and is therefore not counted.

> ⚠️ **Important: what counts as "the same subscription" depends on the store**
>
> The chart recognises a returning subscriber through the store's own subscription identifier, not through your user.
>
> **iOS (App Store).** All purchases inside one subscription group share the same original transaction identifier. A customer who lets a subscription expire and subscribes again in the same group, even months later, continues the same subscription: Purchasely records a reactivation. This needs Purchasely to know the previous subscription: complete the [historical subscriber import](subscribers-base-import), including lapsed subscribers, or the returning customer looks new.
>
> **Android (Play Store).** Google issues a new purchase token for a purchase made after the subscription has fully expired, with no link to the old one. Purchasely therefore counts that purchase as a **new activation**, even when it knows the customer. Importing your history does not change this. The Android reactivations you see are recoveries after account hold, resumes after a pause, re-subscriptions before expiry, and renewals confirmed by Google just after the expiry time. The win-back of lapsed Android customers is not visible in this chart.
>
> **Consequence.** Do not compare iOS and Android reactivations one to one. Across stores, compare "activations + reactivations" from the Subscription Activations chart.

<DashboardV1CountingChange />

<br />

# How to read the chart

The chart displays a bar chart with overlaid trend lines. Each bar represents a time period (day, week, or month) depending on the selected granularity.

| Element     | Description                                                                 |
| ----------- | --------------------------------------------------------------------------- |
| Blue bars   | The count of reactivations during that period                               |
| Orange line | A trend line showing the general direction of reactivation volume over time |
| Dotted line | The average number of reactivations across the visible date range           |

Below the chart, a data table lists each period with its corresponding reactivation count for precise reference. A subscription counts once per day at most.

# Controls

### Show

Filter reactivations by the price the subscription came back at:

| Mode                          | What it shows                                                                                                                                            |
| ----------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| All Reactivations             | Both paid and free reactivations combined                                                                                                                |
| Free Reactivations only       | Only reactivations where the subscription came back at no cost: a free win-back offer, or the rare second free trial a store grants                     |
| Paid Reactivations only       | Only reactivations where the subscription came back with a paid intro offer, a paid promotional offer, or directly at full price                        |
| Full-price Reactivations only | Only reactivations where the subscription came back at full price, excluding any offer or trial                                                          |

### Grouped by

Break down reactivation data by a dimension to compare segments side by side:

| Group            | Description                                                                                                                                              |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| None             | No grouping; shows total reactivations as a single series                                                                                               |
| Platform         | Split by iOS, Android, etc.                                                                                                                              |
| Placement        | Split by the in-app location where the paywall was shown                                                                                                 |
| Audience         | Split by the audience the user matched                                                                                                                   |
| Country          | Split by **store country**: the country of the App Store or Play Store account used for the purchase                                                     |
| Screen           | Split by the paywall screen that triggered the reactivation                                                                                              |
| Plan             | Split by subscription plan                                                                                                                               |
| Plan periodicity | Split by billing cycle (weekly, monthly, yearly, etc.)                                                                                                   |
| Campaign         | Split by campaign attribution                                                                                                                            |
| A/B test variant | Split by the A/B test variant attached to the reactivation                                                                                               |
| Offer types      | Split by the offer the subscription came back with (none, trial, intro offer, promo code, promotional offer)                                             |
| Payment types    | Split by the price the subscription came back at: free offer, paid offer or full price                                                                   |
| Event types      | Split by the kind of return: **re-subscription** (`SUBSCRIPTION_REACTIVATED`), **billing retry recovery**, **unpause**. When the offer changed at the reactivation (a trial converting during a recovery), the row is labelled with the conversion (`TRIAL_CONVERTED`, `INTRO_OFFER_CONVERTED`, ...) |

Groups beyond the ten largest over the selected range are combined into **Other**.

### Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution of each bar.

* **Daily** — One bar per day. Best for spotting short-term spikes after a specific campaign or event.
* **Weekly** — One bar per week. Good for smoothing out day-to-day noise while retaining detail.
* **Monthly** — One bar per month. Best for long-term trend analysis and executive reporting.

### Filters

<DashboardFilters />

| Filter           | Description                                                          |
| ---------------- | -------------------------------------------------------------------- |
| Platforms        | iOS, Android, or both                                                |
| Countries        | Filter by store country (see Grouped by)                             |
| Screens          | Filter by the paywall screen that triggered the reactivation         |
| Placements       | Filter by where in the app the paywall was shown                     |
| Audiences        | Filter by the audience the user matched                              |
| A/B tests        | Filter by the A/B test variant attached to the reactivation          |
| Campaigns        | Filter by campaign attribution                                       |
| Plans            | Filter by specific subscription plan                                 |
| Plan periodicity | Filter by billing cycle (weekly, monthly, yearly, etc.)              |
| Offer types      | Filter by the offer the subscription came back with                  |

# Common use cases

* **Measure win-back campaign performance on iOS** — After launching a win-back push notification or email campaign, use the daily granularity to check for a spike in reactivations in the days following the campaign. Group by Audience to see which user segments responded best. On Android, lapsed customers who come back appear in the Subscription Activations chart instead.
* **Separate voluntary returns from billing recoveries** — Group by Event types. Billing retry recoveries and unpauses reflect payment and store mechanics, not a decision to come back.
* **Compare reactivation quality across offer types** — Use the Show dropdown to compare Free vs. Paid vs. Full-price reactivations. A high proportion of full-price reactivations suggests strong product-market fit, while heavy reliance on free offers may indicate users are not yet convinced of the value.
* **Evaluate paywall effectiveness for churned users** — Group by Screen or Placement to determine which paywall designs or in-app locations are most effective at converting returning users. This can inform dedicated win-back paywall strategies.
* **Track seasonal re-engagement patterns** — Use monthly granularity over a long date range to spot seasonal trends. Some apps see reactivation spikes around New Year, back-to-school, or other events relevant to their user base.
* **Benchmark reactivation trends against churn** — Monitor the trend line and average line together. A rising trend line alongside stable or declining churn suggests your retention and win-back efforts are working. If both reactivations and churn are rising, you may be cycling the same users through repeated churn-and-return loops.

# Frequently asked questions

### What counts as a reactivation?

A reactivation is recorded when a subscription Purchasely already knows goes from a non-active state back to an active state: a re-subscription on the same store subscription, a billing retry recovery where access had been removed, or the end of a Google Play pause. Three cases do **not** count: a grace period recovery, because the subscription never leaves the active state; a refund reversal, which restores access without a reactivation event; and a purchase with a new store subscription, which is an activation (see the callout at the top for the store differences).

### Does a billing retry recovery count as a reactivation?

Yes. When a subscription payment fails and the subscription is suspended (e.g., account hold on Google Play, or equivalent on the App Store), the subscription leaves the active state. When the store successfully retries the charge and restores the subscription, this transition from non-active to active is counted as a reactivation.

The only exception is **grace period recovery**: during the grace period, the user retains access and the subscription remains active while the store retries the payment. If the payment succeeds during this window, no reactivation is recorded because the subscription was never suspended.

| Scenario                                            | Subscription suspended?       | Reactivation?                                  |
| --------------------------------------------------- | ----------------------------- | ---------------------------------------------- |
| Grace period recovery                               | No — user retains access      | **No**                                         |
| Account hold recovery (Google Play)                 | Yes — user loses access       | **Yes**                                        |
| Billing retry recovery after suspension (App Store) | Yes — subscription inactive   | **Yes**                                        |
| Re-subscribe after full expiration                  | Yes — subscription terminated | **iOS: yes**, same subscription group. **Android: no**, counted as an activation |

### Why do I see a termination and a reactivation on the same day for the same subscription?

On Google Play, Purchasely terminates a subscription at its expiry time when Google has not yet confirmed the renewal. When Google confirms it shortly after, the same subscription regains access and a reactivation is recorded. The subscriber never left. The same pair appears as one churn and one new in the Paid Subscription Movements chart.

### Why might reactivation numbers differ between Purchasely and the app stores?

On iOS, Purchasely recognises a returning subscriber as long as it knows the previous subscription. If your subscriber history was imported without lapsed subscribers, returning customers are counted as activations and reactivations are understated: complete the import, including expired subscriptions.

On Android, the difference is structural: Google does not link a new purchase to an expired subscription, so returning customers are activations for Purchasely whatever the import. The Play Console, which knows the user account behind both purchases, can count them as returning.

### Why are reactivation numbers on Android lower than on iOS?

Because of the store difference described at the top: a lapsed Android customer who buys again gets a new purchase token, and Purchasely counts an activation. Android reactivations only reflect billing recoveries, pauses, re-subscriptions before expiry and renewals confirmed just after the expiry time. Compare "activations + reactivations" across stores instead.

### Are high reactivation numbers always a good sign?

Not necessarily. A healthy reactivation rate shows that your product has lasting appeal and your win-back efforts are effective. However, if reactivations are growing in parallel with churn, it may indicate a revolving-door pattern where the same users repeatedly churn and return. Group by Event types first: a rise driven by billing retry recoveries is a payment issue, not a product signal.

### Can a single user generate multiple reactivations?

Yes. If a user churns, reactivates, churns again, and reactivates again on the same subscription, each return is counted as a separate reactivation event. Monitoring users with multiple reactivations can help you identify pricing or value-perception issues.

### Why do I see a spike in reactivations without running any campaign?

Organic reactivations can happen for several reasons: app store featuring, seasonal interest in your app category, OS-level subscription management prompts reminding users of lapsed subscriptions, or external events that make your product relevant again. Group by Country, Platform or Event types to see if the spike is concentrated in a specific segment or comes from billing recoveries.

### How should I use the trend and average lines?

The average line gives you a baseline for what "normal" reactivation volume looks like over the selected period. The trend line shows whether reactivations are generally increasing or decreasing. If the trend line sits above the average, reactivations are accelerating. If it dips below, they are slowing down. Use both together to distinguish a temporary spike from a sustained improvement.
