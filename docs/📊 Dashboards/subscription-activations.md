---
title: Subscription Activations
---
# About this chart

The Subscription Activations chart counts how many **subscriptions enter a given segment for the first time** during a given period. The definition of "activation" depends on the segment you select — it can be the start of a free trial, the start of a paid intro offer, or the first full-price payment. It gives you a clear, day-by-day (or week-by-week, month-by-month) view of acquisition volume so you can spot trends, measure campaign impact, and compare acquisition channels.

This chart is distinct from the "New" column in the Paid Subscriptions Movements chart. Paid Subscriptions Movements only tracks subscriptions that have generated a payment -- free trials are excluded until they convert. Subscription Activations counts first-time entries into the selected segment, which — depending on the segment — may occur before any payment is processed (e.g. a free trial start).

> ⚠️ **Important: activations and reactivations depend on the store and on your subscriber import**
>
> An activation is the first time a **subscription** enters the selected segment. A **reactivation** is the same subscription coming back after it expired, was revoked or went unpaid. Reactivations are shown in the [Subscription Reactivations](subscription-reactivations) chart and are never counted as activations.
>
> **iOS (App Store).** All purchases inside one subscription group share the same original transaction identifier. A customer who lets a subscription expire and subscribes again in the same group continues the same subscription: Purchasely records a reactivation. This works only if Purchasely knows the previous subscription. If your [historical subscriber import](subscribers-base-import) did not include lapsed subscribers, a returning customer looks new and is counted as an activation.
>
> **Android (Play Store).** Google links a new purchase to the previous one only while the previous one has not expired (re-signup after cancellation, upgrade, downgrade). After a subscription has fully expired, a new purchase is a brand-new subscription with no link to the past. A returning Android customer is therefore counted as an **activation**, usually at full price because Google does not grant a second free trial on the same product. Importing your history does not change this: Google itself does not link the two purchases, and expired Play subscriptions cannot be imported.
>
> **Consequence.** iOS and Android activations are not comparable one to one: Android activations include returning customers, and Android reactivations only cover billing recoveries, unpauses and re-signups before expiry. To compare stores, look at activations and reactivations together.

You can choose the segment you're interested in. An activation is counted the first time a subscription enters the selected segment:

* All activations - the first time a subscription starts (free trial, paid intro offer, or full-price)
* Free Trials only - the first time a subscription starts a free trial
* Paid Intro Offers only - the first time a subscription starts a paid introductory offer
* Full-price Subscriptions only - the first time a subscription is paid at full price (whether it started directly at full price, or after a trial / intro offer converted)

> 📘 The same subscription can appear in different segments at different dates.
>
> For example, a subscription that starts with a free trial in January and converts to full price in February will count as an activation in January under "All activations" and "Free Trials only", and as an activation in February under "Full-price Subscriptions only".

<DashboardV1CountingChange />

# How to read the chart

The chart is a **bar chart with two overlaid lines**.

| Element         | Description                                                         |
| --------------- | ------------------------------------------------------------------- |
| **Blue bars**   | The count of subscription activations for each time period         |
| **Orange line** | A trend line showing the general direction of activations over time |
| **Dotted line** | The average number of activations across the visible date range     |

The trend and average lines are computed from the period totals; they do not add activations.

Below the chart, a **data table** lists each time period with its corresponding activation count. You can toggle between chart and table views.

When the trend line sits above the average line, acquisition is accelerating. When it dips below, acquisition is slowing down.

# How the count is built

1. For each subscription, Purchasely looks for its earliest eligible event: a start (full price, free trial, intro offer, promo code, promotional offer) or a conversion to paid. To find it, the calculation looks back before your start date by the plan length plus 60 days, at most 425 days.
2. Platform, country and segment are applied **before** this earliest event is chosen.
3. Plan, plan periodicity, screen, placement, audience, campaign, A/B test and offer type filters are applied **after**: they can remove an activation, but they can never make a later event of the same subscription count instead.
4. The event is counted on the day Purchasely recorded it, in the daily, weekly or monthly bucket that contains that day.

Not counted: reactivations, recoveries after a billing retry or grace period, unpauses, refunds and plan changes. Family-shared subscriptions are excluded.

# Controls

### Segments

Filter by the type of subscription activation:

| Option                            | What it includes                                                                                                                                                                                                                         |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **All activations**               | Every new subscription start: free trials, paid intro offers, and full-price purchases                                                                                                                                                   |
| **Free Trials only**              | Only subscriptions that started with a free trial period                                                                                                                                                                                 |
| **Paid Intro Offers only**        | Only subscriptions that started with a discounted introductory offer (not free)                                                                                                                                                          |
| **Full-price Subscriptions only** | The moment a subscription is first paid at full price. This includes subscriptions that started directly at full price, but also free trials and intro offers that have converted — the activation is counted when the first full-price payment occurs |

### Grouped by

Break down the activations by a dimension to compare segments side by side:

| Dimension            | Description                                                                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **None**             | No breakdown -- shows total activations as a single series                                                                                                                                 |
| **Platform**         | Split by iOS, Android, etc.                                                                                                                                                                |
| **Placement**        | Split by the in-app location where the paywall was shown                                                                                                                                   |
| **Audience**         | Split by the audience the user matched at the time of the activation event                                                                                                                 |
| **Country**          | Split by **store country**: the country of the App Store or Play Store account used for the purchase, which can differ from the user's location. "Unknown" means the store did not report a country |
| **Screen**           | Split by the paywall screen that triggered the subscription                                                                                                                                |
| **Plan**             | Split by subscription plan                                                                                                                                                                 |
| **Plan periodicity** | Split by billing cycle (weekly, monthly, yearly, etc.)                                                                                                                                     |
| **Offer types**      | Split by how the subscription started (direct, free trial, intro offer, promo code, promotional offer)                                                                                     |
| **Event types**      | Split by the subscription event that counted as the activation (subscription started, trial started, trial converted, intro offer started or converted, ...)                                |
| **Payment types**    | Split by what the customer paid at activation: **Free offer** (free trial or free offer), **Paid offer** (discounted intro or promotional price) or **Full price**. This is a price classification, not a payment method |

Groups beyond the ten largest over the selected range are combined into **Other**.

### Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution.

* **Daily** -- One bar per day. Best for spotting short-term spikes or drops (e.g., after a campaign launch).
* **Weekly** -- One bar per week. Good for smoothing out day-of-week noise while keeping reasonable detail.
* **Monthly** -- One bar per month. Best for long-term trend analysis and executive reporting.

### Filters

<DashboardFilters />

| Filter               | Description                                                                                          |
| -------------------- | ---------------------------------------------------------------------------------------------------- |
| **Platforms**        | iOS, Android, or both                                                                                |
| **Countries**        | Filter by store country (see Grouped by)                                                             |
| **Screens**          | Filter by the paywall screen that triggered the subscription                                         |
| **Placements**       | Filter by where in the app the paywall was shown                                                     |
| **Audiences**        | Filter by the audience the user matched at the time of the activation event                          |
| **A/B tests**        | Filter by the A/B test variant attached to the activation event                                      |
| **Campaigns**        | Filter by campaign attribution                                                                       |
| **Plans**            | Filter by specific subscription plan                                                                 |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.)                                              |
| **Offer types**      | Filter by how the subscription started (direct, free trial, intro offer, promo code, promotional offer) |

> 📘 Platforms and countries are applied before the activation event is chosen; all other filters are applied after it and can only remove activations. See "How the count is built" above.

# Common use cases

* **Measure the impact of a new paywall** -- Launch a new paywall screen, then filter by Screen or use the Grouped by Screen dimension to compare activation volumes before and after the change.
* **Compare acquisition channels** -- Use the Show dropdown to isolate Free Trials, Paid Intro Offers, or Full-price Subscriptions. The Full-price segment is especially useful for understanding when subscriptions actually start paying — it counts the first full-price payment, including trial and intro offer conversions. If most activations come from free trials, your acquisition funnel is trial-dependent; if full-price activations are growing, your value proposition is converting effectively.
* **Evaluate a marketing campaign** -- Look for a spike in activations on the day a campaign launches. Filter by Campaign or Placement to attribute the lift to a specific initiative.
* **Spot platform differences** -- Group by Platform to see whether iOS or Android drives more activations. Remember that Android activations include returning customers (see the callout at the top).
* **Understand the price mix at activation** -- Group by Payment types to see the share of activations that start free, discounted or at full price. A high share of free or discounted starts may signal over-reliance on offers.
* **Track seasonal patterns** -- Switch to Monthly granularity and look at multi-month trends. Subscription apps often see activation spikes around holidays, back-to-school periods, or New Year resolutions.

# Frequently asked questions

### What counts as an "activation"?

An activation is the **first time a subscription enters the selected segment**. The moment it is counted depends on which segment you are viewing:

| Segment                           | Activation is counted when...                                                                                                                                          |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **All activations**               | The subscription starts — whether through a free trial, a paid intro offer, or a full-price purchase                                                                   |
| **Free Trials only**              | The subscription starts with a free trial                                                                                                                              |
| **Paid Intro Offers only**        | The subscription starts with a paid introductory offer                                                                                                                 |
| **Full-price Subscriptions only** | The subscription is first paid at full price — this may be the start of a direct full-price subscription, or the moment a trial or intro offer converts to full price  |

This means the same subscription can appear in different segments at different dates. For example, a subscription that starts with a free trial in January and converts to full price in February will count as an activation in January under "All activations" and "Free Trials only", and as an activation in February under "Full-price Subscriptions only".

### Why might activation numbers differ between Purchasely and the app stores?

Two different reasons, one per store.

On **iOS**, Purchasely can tell a returning customer from a new one as long as it knows the previous subscription. If your subscriber history was imported without lapsed subscribers, returning customers are counted as activations and your numbers are higher than App Store Connect's. Complete the [historical subscriber import](subscribers-base-import), including expired subscriptions, to fix it.

On **Android**, Google does not link a new purchase to a subscription that has fully expired, and expired Play subscriptions cannot be imported (Google rejects purchase tokens expired for more than 60 days). A returning Android customer is counted as an activation, with or without import. Depending on your churn and win-back dynamics, the share of returning customers among Android "activations" can be significant.

### Why are my Android activations higher than my iOS activations for similar acquisition?

Because Android activations include returning customers while iOS counts them as reactivations (see the callout at the top). Compare "activations + reactivations" across stores, or compare new users rather than activations.

### Why did filtering by campaign, screen or placement remove an activation I expected?

Purchasely first chooses each subscription's earliest eligible event, then checks its campaign, screen or placement. If that earliest event does not match your filter, the subscription is not counted, even if a later event of the same subscription would have matched.

### How is this different from the "New" count in Paid Subscriptions Movements?

Paid Subscriptions Movements tracks subscriptions that have entered a paid state. Free trials are not included in the "New" count of that chart until the trial converts to a paid subscription. Subscription Activations counts the first time a subscription enters the selected segment — which, for the "All activations" segment, includes free trials at their start date. Use Activations to measure acquisition volume across all entry points, and Paid Subscriptions Movements to measure paying subscriber growth.

### Why does the first or last weekly or monthly bar look small?

Bars are labelled by the start of their calendar period (weeks start on Monday), but only events inside your selected date range are counted. The first and last bars can therefore cover a partial week or month. For an identical date range, weekly totals equal the sum of daily totals.

### What is the "Payment types" dimension and why is it only available here?

Payment types classifies each activation by what the customer paid when it was counted: free (free trial or free offer), discounted (paid intro or promotional price) or full price. It is specific to the Subscription Activations chart because the price at acquisition is what tells you how your new subscriptions start. To see promo codes and offer types, use the Offer types dimension.

### Can I see activations for a specific A/B test variant?

Yes. Click Filters, then select the A/B test variant you want to analyze. The chart shows the activations whose activation event carries that variant. To compare variants, apply the filter for each variant separately and compare the resulting volumes and trends.

### Why did activations spike but revenue did not increase?

This typically happens when the spike comes from free trial starts or deeply discounted intro offers. Use the Show dropdown to isolate "Free Trials only" -- if that segment accounts for the spike, the revenue impact will only appear later, when those trials convert to paid subscriptions.
