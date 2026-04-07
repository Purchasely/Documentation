---
title: Funnel
---
# About this chart

The Funnel chart visualizes the complete subscription journey as a **Sankey diagram** — a flow visualization where bands connect stages from left to right. It shows how subscriptions enter through a specific dimension (placement, paywall, plan, platform, or country), move through intermediate stages (offers, trials), and reach an outcome (conversion, full-price payment, renewal). Wider bands mean more subscriptions followed that path, giving you an immediate sense of where volume concentrates and where it drops off.

# How to read the chart

The diagram flows from left to right through subscription lifecycle stages.

| Element                        | Description                                                                                                                                    |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| **Entry nodes (left side)**    | Groups of subscriptions that started during the selected period, split by the chosen dimension (e.g., one node per placement, one per paywall) |
| **Flow bands**                 | Colored bands connecting stages. The width of each band is proportional to the number of subscriptions following that path                     |
| **Intermediate stages**        | Steps between entry and outcome — such as "Offers", "Direct", or "Trial Started" — showing how subscriptions progress                          |
| **Outcome nodes (right side)** | Final states: Converted, Start paying full price, Renewed, etc.                                                                                |

Color coding distinguishes paths: green typically represents conversions, blue/purple represents various intermediate flows, and orange highlights specific segments.

Below the Sankey diagram, a **data table** provides exact counts for each entry node across all funnel stages.

| Column                 | Description                                                                                                                                                                                                                                                                                                                                                                                  |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Name**               | The entry node label (e.g., placement name, paywall name, plan name)                                                                                                                                                                                                                                                                                                                         |
| **Started**            | Number of subscriptions that entered the funnel from this node                                                                                                                                                                                                                                                                                                                               |
| **Free Trial Started** | Number of subscriptions that entered a free trial                                                                                                                                                                                                                                                                                                                                            |
| **Converted**          | Number of subscriptions that converted from a trial to a paid subscription                                                                                                                                                                                                                                                                                                                   |
| **Paying Users**       | Despite the column label saying "Users", this column actually counts paying **subscriptions** (consistent with dashboard v2 counting methodology). It includes all subscriptions that are actively paying, whether they converted from a trial, started through an intro or promo offer, or began directly at full price. Note: the column label may be updated in a future console release. |
| **Renewed**            | Number of subscriptions that successfully renewed                                                                                                                                                                                                                                                                                                                                            |

# Controls

### Choose a dimension

Select which dimension defines the entry nodes on the left side of the Sankey diagram. Only one dimension can be active at a time.

| Dimension     | What entry nodes represent                                                                                                                                        |
| ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Placement** | Each node is a placement in your app (e.g., "Onboarding", "Settings", "Home offer"). Shows which in-app locations drive the most subscriptions through the funnel |
| **Paywall**   | Each node is a paywall screen. Shows how different paywall designs perform across funnel stages                                                                   |
| **Plan**      | Each node is a subscription plan (e.g., "Monthly Premium", "Yearly Pro"). Shows how plan choice correlates with conversion and renewal                            |
| **Platform**  | Each node is a platform (iOS, Android). Shows platform-level differences in funnel progression                                                                    |
| **Country**   | Each node is a country. Shows geographic differences in subscription behavior                                                                                     |

### Granularity

Use the **Daily / Weekly / Monthly** selector to control the time period over which funnel data is aggregated.

* **Daily** — Funnel data for a single day. Best for monitoring short-term changes or campaign launches.
* **Weekly** — Funnel data aggregated over a week. Good for stable trend analysis.
* **Monthly** — Funnel data aggregated over a month. Best for high-level reporting and strategic review.

### Filters

Click **Filters** to narrow the data included in the funnel. You can combine multiple filters to focus on a specific subset of subscriptions.

| Filter         | Description                                                  |
| -------------- | ------------------------------------------------------------ |
| **Countries**  | Filter by user country                                       |
| **Screens**    | Filter by the paywall screen that triggered the subscription |
| **Placements** | Filter by where in the app the paywall was shown             |
| **Audiences**  | Filter by audience segment                                   |
| **Plans**      | Filter by specific subscription plan                         |
| **Platforms**  | iOS, Android, or both                                        |

### Download CSV

Click **Download CSV** to export the data table as a CSV file for further analysis in a spreadsheet or BI tool.

# Common use cases

* **Compare paywall performance** — Set the dimension to "Paywall" to see which paywall designs move the most users from trial to conversion. A paywall with many trial starts but few conversions may need copy or offer adjustments.
* **Evaluate trial-to-paid conversion by plan** — Set the dimension to "Plan" to understand which subscription plans have the healthiest trial-to-paid flow. Plans with wide "Trial Started" bands but narrow "Converted" bands may indicate pricing friction.
* **Spot platform-level funnel differences** — Set the dimension to "Platform" to compare iOS and Android funnels side by side. Significant differences in conversion or renewal rates may point to platform-specific UX issues or store behavior.
* **Analyze geographic funnel behavior** — Set the dimension to "Country" to identify markets where the funnel drops off early. Countries with high starts but low conversions may benefit from localized pricing or offers.
* **Monitor the impact of a new offer or campaign** — Filter by a specific time period and compare the funnel shape before and after launching a new promotional offer, intro price, or campaign.

# Frequently asked questions

### What does "Unknown" mean in the entry nodes?

An "Unknown" entry node appears when subscriptions cannot be attributed to a specific value for the selected dimension. For example, if a subscription was not triggered from a tracked placement (e.g., it came from a direct store purchase or a legacy integration without placement tracking), it will appear under "Unknown" in the Placement dimension. This is expected and does not indicate a data error.

### Can I see the funnel for a single placement or paywall?

Yes. Use the **Filters** button to select a specific placement, paywall, or any other filter. The Sankey diagram and data table will update to show only subscriptions matching your filter criteria.

### Why do the numbers in the data table not add up across columns?

Each column represents a different stage in the funnel, and not all subscriptions progress through every stage. For example, subscriptions that start paying full price directly skip the "Free Trial Started" stage entirely. The columns are not meant to sum horizontally — they represent parallel paths through the funnel.

### How does granularity affect the funnel data?

Granularity controls the time window over which subscriptions are aggregated. A monthly view pools all subscriptions from the entire month into a single funnel, producing smoother and larger flows. A daily view shows a single day's subscriptions, which is useful for spotting short-term changes but produces thinner bands. The funnel shape may look different across granularities because subscription behavior varies by cohort size and time period.

### What is the difference between "Converted" and "Paying Users"?

"Converted" counts subscriptions that transitioned from a free trial to a paid subscription. "Paying Users" includes all users who are actively paying, whether they converted from a trial, started paying directly at full price, or came through an introductory or promotional offer. A subscription can be counted as a Paying User without being counted as Converted if it never went through a trial.

<br />
