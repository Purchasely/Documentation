---
title: Subscription Events
---
# About this chart

The Subscription Events chart is a raw event explorer that plots the volume of server-side subscription lifecycle events over time. Each event type appears as a separate colored line on a time-series chart, letting you compare event volumes side by side. It is designed for deep operational analysis rather than high-level KPI tracking — use it when you need to understand exactly what is happening in your subscription lifecycle at the event level.

It counts **events, not subscriptions**: one count per event, on the day Purchasely recorded it, with no deduplication. A subscription that renews contributes one SubscriptionRenewed, one TransactionProcessed and one Activate on the same day. Sandbox events are excluded, and so is every event of a family-shared subscription: FamilySharedRevoked, which only ever concerns a shared subscription, therefore always reads zero.

Event names correspond to Purchasely server events (the same events delivered via webhooks), making it easy to cross-reference chart data with your backend logs or third-party integrations.

# How to read the chart

The chart is a **multi-line time-series graph**. Each line represents one event type, plotted over the selected date range and granularity.

* The **Y-axis** shows event count.
* The **X-axis** shows time (days, weeks, or months depending on granularity).
* A **legend** at the bottom lists every plotted event type with its corresponding color.

When many event types are selected, the chart can become dense. Use the category chips and search bar at the top to focus on the events that matter for your analysis.

### &#x20;Event categories

Events are organized into color-coded categories. Click a category chip to select or deselect all events in that group at once. You can also use the search bar to find a specific event by name.

| Category                           | Events                                                                                                                                                                                                                                                       |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Activation / Plan change**       | SubscriptionStarted, SubscriptionReactivated, SubscriptionUpgraded, SubscriptionDowngraded, SubscriptionCrossgraded                                                                                                                                          |
| **Renewal / Recovery**             | SubscriptionRenewed, InstallmentPaid, SubscriptionUnpaused, SubscriptionRecoveredFromBillingRetry, SubscriptionRecoveredFromGracePeriod, SubscriptionRefundReversed, OneTimePurchaseRefundReversed                                                           |
| **Billing issue**                  | GracePeriodStarted, GracePeriodTerminated, EnteredBillingRetry                                                                                                                                                                                               |
| **Cancellation / Refund / Pause**  | RetentionMessageRequested, RenewalEnabled, RenewalDisabled, SubscriptionWillPause, SubscriptionWillNotPause, SubscriptionTerminated, FamilySharedRevoked, SubscriptionRefundedRevoked, InstallmentRefunded, SubscriptionCancelledDuringGracePeriod, SubscriptionCancelledDuringPause, SubscriptionPaused |
| **Billing information**            | TransactionProcessed                                                                                                                                                                                                                                         |
| **Entitlement / Transfer**         | Activate, Deactivate, SubscriptionTransferred, SubscriptionReceived, OneTimePurchaseTransferred, OneTimePurchaseReceived                                                                                                                                     |
| **Trial / Intro / Promo offer**    | TrialStarted, TrialConverted, TrialNotConverted, IntroOfferStarted, IntroOfferConverted, IntroOfferNotConverted, PromoCodeStarted, PromoCodeConverted, PromoCodeNotConverted, PromotionalOfferStarted, PromotionalOfferConverted, PromotionalOfferNotConverted, SubscriptionDeferred |

> **Note:** Pause events (SubscriptionPaused, SubscriptionUnpaused, SubscriptionWillPause, SubscriptionWillNotPause, SubscriptionCancelledDuringPause) are **Google Play only**. InstallmentPaid and InstallmentRefunded are **App Store only** (monthly-commitment plans).

Select **ALL** (gray chip) to plot every event type simultaneously.

# Controls

### Category chips and search

At the top of the chart, color-coded category chips let you quickly toggle groups of related events. Click a chip to select all events in that category; click it again to deselect. The search bar filters the event list by name, which is useful when you know exactly which event you are looking for.

### Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution.

* **Daily** — One data point per day. Best for spotting short-lived spikes or anomalies.
* **Weekly** — One data point per week. Smooths out daily noise while preserving trends.
* **Monthly** — One data point per month. Best for long-term pattern analysis.

### Filters

<DashboardFilters />

| Filter               | Description                                                              |
| -------------------- | ------------------------------------------------------------------------ |
| **Platforms**        | iOS, Android, or both                                                    |
| **Countries**        | Filter by store country: the country of the store account used for the purchase |
| **Screens**          | Filter by the paywall screen that triggered the subscription             |
| **Placements**       | Filter by where in the app the paywall was shown                         |
| **Audiences**        | Filter by the audience the user matched at purchase time                 |
| **A/B tests**        | Filter by the A/B test variant attached to the subscription              |
| **Plans**            | Filter by specific subscription plan                                     |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.)                  |

### Download CSV

Click the **Download CSV** button to export the currently displayed data. The export respects your active filters, selected events, and granularity.

# Common use cases

* **Spot billing issue spikes** — Select the Billing Issue category and watch for sudden increases in EnteredBillingRetry or GracePeriodStarted. A spike may indicate a store-side payment processing issue or a wave of expired credit cards.

* **Monitor trial-to-paid conversion health** — Plot TrialStarted alongside TrialConverted and TrialNotConverted. If TrialNotConverted starts growing faster than TrialConverted, your trial experience may need attention.

* **Validate a new paywall deployment** — After launching a new paywall or A/B test, filter by Screen or A/B test and check that SubscriptionStarted and TrialStarted volumes are in line with expectations.
* **Watch cancellation intent** — Plot RenewalDisabled against RenewalEnabled to see how many subscribers turn auto-renewal off and how many turn it back on before expiry; add RetentionMessageRequested to see how many reached the App Store cancellation sheet.

* **Track refund trends** — Select SubscriptionRefundedRevoked and monitor it over time. A rising trend could signal product satisfaction issues or policy abuse. For a refund rate by cohort, use the Subscription Refunds chart.

* **Diagnose churn by comparing cancellation events** — Plot SubscriptionTerminated, SubscriptionCancelledDuringGracePeriod, and SubscriptionCancelledDuringPause together to understand where in the lifecycle users are dropping off.

* **Measure promo offer effectiveness** — Compare PromotionalOfferStarted with PromotionalOfferConverted and PromotionalOfferNotConverted to evaluate whether your promotional offers are driving sustained subscriptions or just temporary uptake.

# Frequently asked questions

### What is the difference between this chart and the other dashboard charts?

Most dashboard charts (MRR, Active Subscriptions, Retention) show aggregated KPIs. The Subscription Events chart shows raw event volumes — it is the most granular view available. Use it when you need to drill into the mechanics of your subscription lifecycle rather than track a summary metric.

### Do these events match the webhook events I receive?

Yes. The event names on this chart correspond directly to Purchasely server events (webhook events). If you see a SubscriptionRenewed event in the chart, it maps to the same `SUBSCRIPTION_RENEWED` event your backend receives via webhooks. This makes it straightforward to cross-reference dashboard data with your server logs.

### Why do I see both "Activate" and "SubscriptionStarted"?

These are distinct events in the Purchasely lifecycle. `Activate` is an entitlement event — it signals that the user should have access to premium content, and it fires on every receipt that grants or keeps access: new subscriptions, renewals, recoveries, transfers. That is why its volume is close to SubscriptionStarted plus SubscriptionRenewed. `SubscriptionStarted` is a lifecycle event that records the beginning of a new subscription only. Similarly, `Deactivate` fires when access is actually removed, which is not every `SubscriptionTerminated`: a subscription already deactivated by a billing retry does not send a second one at its termination.

### Can I see revenue data in this chart?

The TransactionProcessed event is available under the Billing information category. While it tracks the occurrence of revenue-generating transactions, the chart plots event counts, not monetary amounts. For actual revenue figures, use the dedicated MRR or Revenue dashboards.

### How should I use the category chips vs. the search bar?

Use category chips when you want to explore a functional area (e.g., all billing-related events). Use the search bar when you already know the specific event name you are looking for (e.g., "TrialConverted"). You can combine both — select a category, then use search to add individual events from other categories.

### Do these counts match the other charts?

No. Subscription Activations, Paid Subscription Movements and Retention count subscriptions, deduplicated per day, with lifecycle rules. This chart counts raw events: the same subscription can appear under several event types on the same day.

### Why does a line disappear or appear flat?

If an event type has zero occurrences over the selected date range, its line will sit at zero or may not be visible behind other lines. Try narrowing the date range, switching to daily granularity, or deselecting high-volume events to make lower-volume lines easier to read.
