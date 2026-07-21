---
title: Subscription Events
---
# About this chart

The Subscription Events chart is a raw event explorer that plots the volume of server-side subscription lifecycle events over time. Each event type appears as a separate colored line on a time-series chart, letting you compare event volumes side by side. It is designed for deep operational analysis rather than high-level KPI tracking — use it when you need to understand exactly what is happening in your subscription lifecycle at the event level.

Event names correspond to Purchasely server events (the same events delivered via webhooks), making it easy to cross-reference chart data with your backend logs or third-party integrations.

<DashboardV1CountingChange />

# How to read the chart

The chart is a **multi-line time-series graph**. Each line represents one event type, plotted over the selected date range and granularity.

* The **Y-axis** shows event count.
* The **X-axis** shows time (days, weeks, or months depending on granularity).
* A **legend** at the bottom lists every plotted event type with its corresponding color.

When many event types are selected, the chart can become dense. Use the category chips and search bar at the top to focus on the events that matter for your analysis.

### &#x20;Event categories

Events are organized into color-coded categories. Click a category chip to select or deselect all events in that group at once. You can also use the search bar to find a specific event by name.

| Category                                    | Color         | Events                                                                                                                                                                                                                      |
| ------------------------------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Activation / Plan Change / Reactivation** | Blue          | Activate, Deactivate, SubscriptionStarted, SubscriptionReactivated, SubscriptionUpgraded, SubscriptionDowngraded, SubscriptionCrossgraded, SubscriptionDeferred, SubscriptionReceived                                       |
| **Renewal / Recovery**                      | Green         | SubscriptionRenewed, RenewedAutomatic, RenewalValidated, SubscriptionRecoveredFromBillingRetry, SubscriptionRecoveredFromGracePeriod                                                                                        |
| **Billing Issue**                           | Yellow/Orange | EnteredBillingRetry, GracePeriodStarted, GracePeriodTerminated                                                                                                                                                              |
| **Cancellation / Refund / Pause**           | Red           | SubscriptionTerminated, SubscriptionCancelledDuringGracePeriod, SubscriptionCancelledDuringPause, SubscriptionRefundBeforeExpiry, SubscriptionPaused, SubscriptionWithPause, SubscriptionUnpaused, SubscriptionWillNotPause |

> **Note:** Pause-related events (SubscriptionPaused, SubscriptionUnpaused, SubscriptionWithPause, SubscriptionWillNotPause) are **Google Play only**. They will not appear for App Store subscriptions.
> | **Entitlement / Transfer** | Purple | SubscriptionTransferred |
> | **Trial / Intro / Promo offer** | Pink/Orange | TrialStarted, TrialConverted, TrialNotConverted, IntroOfferStarted, IntroOfferConverted, IntroOfferNotConverted, PromoCodeStarted, PromoCodeConverted, PromoCodeNotConverted, PromotionalOfferStarted, PromotionalOfferConverted, PromotionalOfferNotConverted |
> | **Transaction Revenue** | Blue | TransactionProcessed |

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
| **Countries**        | Filter by user country                                                   |
| **Screens**          | Filter by the paywall screen that triggered the subscription             |
| **Placements**       | Filter by where in the app the paywall was shown                         |
| **Audiences**        | Filter by audience segment the user belonged to at the time of the event |
| **A/B tests**        | Filter by A/B test the user was enrolled in                              |
| **Plans**            | Filter by specific subscription plan                                     |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.)                  |

### Download CSV

Click the **Download CSV** button to export the currently displayed data. The export respects your active filters, selected events, and granularity.

# Common use cases

* **Spot billing issue spikes** — Select the Billing Issue category and watch for sudden increases in EnteredBillingRetry or GracePeriodStarted. A spike may indicate a store-side payment processing issue or a wave of expired credit cards.

* **Monitor trial-to-paid conversion health** — Plot TrialStarted alongside TrialConverted and TrialNotConverted. If TrialNotConverted starts growing faster than TrialConverted, your trial experience may need attention.

* **Validate a new paywall deployment** — After launching a new paywall or A/B test, filter by Screen or A/B test and check that SubscriptionStarted and Activate volumes are in line with expectations.

* **Track refund trends** — Select SubscriptionRefundBeforeExpiry and monitor it over time. A rising trend could signal product satisfaction issues or policy abuse.

* **Diagnose churn by comparing cancellation events** — Plot SubscriptionTerminated, SubscriptionCancelledDuringGracePeriod, and SubscriptionCancelledDuringPause together to understand where in the lifecycle users are dropping off.

* **Measure promo offer effectiveness** — Compare PromotionalOfferStarted with PromotionalOfferConverted and PromotionalOfferNotConverted to evaluate whether your promotional offers are driving sustained subscriptions or just temporary uptake.

# Frequently asked questions

### What is the difference between this chart and the other dashboard charts?

Most dashboard charts (MRR, Active Subscriptions, Retention) show aggregated KPIs. The Subscription Events chart shows raw event volumes — it is the most granular view available. Use it when you need to drill into the mechanics of your subscription lifecycle rather than track a summary metric.

### Do these events match the webhook events I receive?

Yes. The event names on this chart correspond directly to Purchasely server events (webhook events). If you see a SubscriptionRenewed event in the chart, it maps to the same `SUBSCRIPTION_RENEWED` event your backend receives via webhooks. This makes it straightforward to cross-reference dashboard data with your server logs.

### Why do I see both "Activate" and "SubscriptionStarted"?

These are distinct events in the Purchasely lifecycle. `Activate` is an entitlement event — it signals that the user should gain access to premium content. `SubscriptionStarted` is a lifecycle event that records the beginning of a new subscription. They typically fire together for new subscriptions, but `Activate` can also fire on its own during recoveries or transfers. Similarly, `Deactivate` and `SubscriptionTerminated` are related but not identical.

### Can I see revenue data in this chart?

The TransactionProcessed event is available under the Transaction Revenue category. While it tracks the occurrence of revenue-generating transactions, the chart plots event counts, not monetary amounts. For actual revenue figures, use the dedicated MRR or Revenue dashboards.

### How should I use the category chips vs. the search bar?

Use category chips when you want to explore a functional area (e.g., all billing-related events). Use the search bar when you already know the specific event name you are looking for (e.g., "TrialConverted"). You can combine both — select a category, then use search to add individual events from other categories.

### Why does a line disappear or appear flat?

If an event type has zero occurrences over the selected date range, its line will sit at zero or may not be visible behind other lines. Try narrowing the date range, switching to daily granularity, or deselecting high-volume events to make lower-volume lines easier to read.
