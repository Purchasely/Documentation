---
title: Screens and conversions
---
# About this chart

The Screens & Conversions chart is part of the Funnel Analytics section. It combines paywall view volume with conversion rates in a single visualization, letting you understand how many users see your paywalls and what proportion converts to a paid subscription. This is one of the most important charts for growth teams optimizing their monetization funnel.

The chart displays six KPI cards at the top, a primary metric as blue bars (left Y-axis), and a secondary metric as a green line (right Y-axis). Together, they give you a complete picture of acquisition volume and efficiency over time.

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

## KPI cards

Six summary metrics appear at the top of the chart for the selected date range:

| KPI | Description |
|-----|-------------|
| **Number of Screens viewed** | Total paywall views across all users. One user viewing the same paywall three times counts as three views. |
| **Number of unique Screens viewers** | Distinct users who saw at least one paywall during the period. |
| **AVG Number of Screens viewed per user** | Average views per unique viewer (total views / unique viewers). A high value may indicate repeated paywall exposure. |
| **CVR to offer price** | Percentage of unique viewers who started a trial, intro offer, or promotional offer. |
| **CVR to regular price** | Percentage of unique viewers who reached a full-price paid subscription (including conversions from trials and intro offers). |
| **Total CVR** | Combined conversion rate across all offer types. |

> **Note:** The "Total CVR" card may appear as `dashboard.total_conversions` in some console versions. This is a known display issue; the underlying data is correct.

## Bar + line chart

The chart overlays two metrics on a shared time axis:

| Element | Axis | What it shows |
|---------|------|---------------|
| **Blue bars** | Left Y-axis | Primary metric: Screens viewed count or Unique viewers count (depending on your selection) |
| **Green line** | Right Y-axis | Secondary metric: a conversion rate (CVR to regular price, CVR to offer price, or Total CVR) |

Reading both together is the key insight: bars show your traffic volume, the line shows your conversion efficiency. A day with tall bars but a dipping line means you drove more traffic without converting proportionally. A rising line with shrinking bars means your paywall is more effective but fewer users are reaching it.

## Cohort-based attribution

**This is the most important concept to understand on this chart.** All conversions are attributed using a **cohort model**: each conversion is counted in the period where the user **last viewed a paywall**, not when the conversion actually occurred. This applies to both "CVR to offer price" and "CVR to regular price".

> **Example:** a user views your paywall on March 1st. They tap the purchase button and start a 7-day free trial on March 1st. One week later, on March 8th, the trial ends and the user converts to a full-price subscription.
>
> - The **conversion to offer price** (trial start) is attributed to **March 1st** — the day the paywall was viewed.
> - The **conversion to regular price** (trial-to-paid conversion) is also attributed to **March 1st** — the day the paywall was viewed, even though the actual payment happened on March 8th.
>
> Both conversion events are tied back to the cohort date when the user was last exposed to the paywall.

This design lets you accurately measure the effectiveness of a paywall on the day it was shown, rather than scattering conversions across future dates when payments happen to process. It also means that **conversion rates for recent periods are always incomplete**: users who started a trial last week have not yet had the chance to convert to full price, so the "CVR to regular price" for that period will appear artificially low and will increase over time as those trials mature.

## Understanding conversion rate events

| Metric | SDK events counted |
|--------|--------------------|
| **CVR to offer price** | `INTRO_OFFER_STARTED` + `TRIAL_STARTED` + `PROMOTIONAL_OFFER_STARTED` |
| **CVR to regular price** | `SUBSCRIPTION_STARTED` + `INTRO_OFFER_CONVERTED` + `TRIAL_CONVERTED` + `PROMOTIONAL_OFFER_CONVERTED` |

Both rates are computed against **unique viewers** (not total views).

The primary metric (Screens viewed / Unique viewers) is based on the `PRESENTATION_VIEWED` SDK event.

# Controls

## Primary metric dropdown

Select what the blue bars represent:

| Option | Description |
|--------|-------------|
| **Screens viewed** | Total paywall views (every view counts, including repeat views by the same user) |
| **Unique viewers** | Distinct users who viewed at least one paywall per time period |

## Grouped by (primary metric)

Break down the bars into segments:

| Group | Description |
|-------|-------------|
| **None** | Single aggregated bar per period |
| **Audience** | Split by audience segment |
| **Country** | Split by user country |
| **Screen** | Split by paywall screen |
| **Placement** | Split by where in the app the paywall was triggered |
| **Platform** | Split by iOS / Android |
| **A/B test variant** | Split by variant assignment |

"Grouped by" stacks or clusters the bars so you can see how the primary metric is distributed across a single dimension.

## Secondary metric dropdown

Select what the green line represents:

| Option | Description |
|--------|-------------|
| **CVR to regular price** | Conversion rate to full-price paid subscriptions |
| **CVR to offer price** | Conversion rate to trials, intro offers, and promotional offers |
| **Total CVR** | Combined conversion rate |

## Split by (secondary metric)

Break down the green line into multiple lines, one per segment:

| Split | Description |
|-------|-------------|
| **None** | Single aggregated line |
| **Audience** | One line per audience segment |
| **Country** | One line per country |
| **Screen** | One line per paywall screen |
| **Placement** | One line per placement |
| **Plan** | One line per subscription plan |
| **Platform** | One line per platform |
| **A/B test variant** | One line per variant |

"Split by" draws separate lines so you can compare conversion rates across a dimension. For example, splitting CVR by Screen shows which paywall converts best.

## Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution.

- **Daily** -- One data point per day. Best for spotting day-to-day fluctuations and diagnosing short-term changes.
- **Weekly** -- One data point per week. Good for trend analysis with less noise.
- **Monthly** -- One data point per month. Best for executive reporting and long-term trends.

## Filters

Click **Filters** to narrow the dataset. Standard filter options include Platform, Country, Screen, Placement, Audience, Plan, and A/B test.

# Common use cases

- **Compare paywall performance** -- Set "Grouped by" to Screen on the primary metric and "Split by" to Screen on the secondary metric. This shows which paywall gets the most views AND which converts best. A paywall with low volume but high CVR is a candidate for broader rollout.

- **Evaluate an A/B test** -- Filter by the A/B test or use "Split by A/B test variant" on the secondary metric. Compare the CVR lines for each variant over the test period to determine which paywall design wins.

- **Diagnose a conversion drop** -- If Total CVR suddenly drops, split the secondary metric by Platform, Country, or Screen to isolate which segment is responsible. Then cross-reference with release notes or paywall changes.

- **Measure audience targeting effectiveness** -- Group the primary metric by Audience and split the secondary metric by Audience. Compare whether high-intent audiences (e.g., power users) see fewer paywalls but convert at higher rates than broad audiences.

- **Assess paywall frequency** -- Monitor the "AVG Number of Screens viewed per user" KPI card. If this number is very high but CVR is flat or declining, users may be experiencing paywall fatigue. Consider reducing display frequency or testing new creatives.

- **Track placement ROI** -- Group by Placement to see which in-app locations generate the most paywall views, then split CVR by Placement to see which locations drive the highest conversion. A placement with high views but low CVR may need a different paywall design or trigger logic.

# Frequently asked questions

## Why does CVR to regular price drop for recent dates?

This is expected behavior due to the cohort attribution model. Users who recently viewed a paywall may have started a trial or intro offer but have not yet converted to a regular-price subscription. Their conversion will only be counted once it occurs (e.g., after a 7-day trial ends), and it will be attributed back to the cohort when they last saw the paywall.

As a result, the most recent days or weeks will always show a lower CVR to regular price. The further back you look, the more complete the data becomes. Allow at least one full billing cycle (typically 7-30 days depending on your trial length) before drawing conclusions about regular-price conversion performance.

## What is the difference between "Grouped by" and "Split by"?

"Grouped by" applies to the **primary metric** (bars) and breaks it into stacked or clustered segments within each time period. "Split by" applies to the **secondary metric** (line) and draws separate lines for each segment. They operate independently, so you can group bars by Placement while splitting the CVR line by Platform.

## Why is my Total CVR lower than I expected?

Conversion rates are calculated against **unique viewers**, not total app users or total views. If many users see your paywall but few convert, the denominator (unique viewers) is large. Also remember that cohort attribution means recent periods will have incomplete conversion data. Check the KPI cards at the top: if "Number of unique Screens viewers" is very high relative to conversions, the issue is likely conversion efficiency rather than a data problem.

## Can I see revenue data in this chart?

No. The Screens & Conversions chart focuses exclusively on funnel metrics (views and conversion rates). For revenue analysis, use the Revenue or MRR charts, which track monetary values.

## How does "Unique viewers" deduplication work?

A user who views multiple paywalls within the same time period is counted once as a unique viewer for that period. The deduplication resets at each period boundary. For example, in daily granularity, a user who views a paywall on Monday and again on Tuesday counts as one unique viewer on each day. In monthly granularity, the same user counts as one unique viewer for the entire month.

## Why do the numbers change when I switch granularity?

Unique viewer counts can differ across granularities because deduplication windows change. In daily view, a user appearing on three separate days counts as three unique-viewer entries (one per day). In monthly view, the same user counts as one. This affects both the KPI cards and the conversion rate denominators. Choose a granularity that matches your analysis timeframe and avoid comparing absolute numbers across different granularities.