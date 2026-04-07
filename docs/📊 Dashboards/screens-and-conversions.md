---
title: Screens and conversions
---
# About this chart

The Screens & Conversions chart is part of the Funnel Analytics section. It combines paywall view volume with conversion rates in a single visualization, letting you understand how many users see your paywalls and what proportion converts to a paid subscription. This is one of the most important charts for growth teams optimizing their monetization funnel.

The chart displays six KPI cards at the top, a primary metric as blue bars (left Y-axis), and a secondary metric as a green line (right Y-axis). Together, they give you a complete picture of acquisition volume and efficiency over time.

<br />

# ⚠️ Cohort-based attribution

**This is the most important concept to understand on this chart.** All conversions are attributed using a **cohort model**: each conversion is counted in the period where the user **last viewed a paywall**, not when the conversion actually occurred. This applies to both "CVR to offer price" and "CVR to regular price".

> **Example:** a user views your paywall on March 1st. They tap the purchase button and start a 7-day free trial on March 1st. One week later, on March 8th, the trial ends and the user converts to a full-price subscription.
>
> * The **conversion to offer price** (trial start) is attributed to **March 1st** — the day the paywall was viewed.
> * The **conversion to regular price** (trial-to-paid conversion) is also attributed to **March 1st** — the day the paywall was viewed, even though the actual payment happened on March 8th.
>
> Both conversion events are tied back to the cohort date when the user was last exposed to the paywall.

This design lets you accurately measure the effectiveness of a paywall on the day it was shown, rather than scattering conversions across future dates when payments happen to process. It also means that **conversion rates for recent periods are always incomplete**: users who started a trial last week have not yet had the chance to convert to full price, so the "CVR to regular price" for that period will appear artificially low and will increase over time as those trials mature.

# How to read the chart

### KPI cards

Six summary metrics appear at the top of the chart for the selected date range:

| KPI                                       | Description                                                                                                                   |
| ----------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **Number of Screens viewed**              | Total paywall views across all users. One user viewing the same paywall three times counts as three views.                    |
| **Number of unique Screens viewers**      | Distinct users who saw at least one paywall during the period.                                                                |
| **AVG Number of Screens viewed per user** | Average views per unique viewer (total views / unique viewers). A high value may indicate repeated paywall exposure.          |
| **CVR to offer price**                    | Percentage of unique viewers who started a trial, intro offer, or promotional offer.                                          |
| **CVR to regular price**                  | Percentage of unique viewers who reached a full-price paid subscription (including conversions from trials and intro offers). |
| **Total CVR**                             | Combined conversion rate across all offer types.                                                                              |

> **Note:** The "Total CVR" card may appear as `dashboard.total_conversions` in some console versions. This is a known display issue; the underlying data is correct.

### Bar + line chart

The chart overlays two metrics on a shared time axis:

| Element                                      | Axis |  What it shows                                                                                   |
| ------------------------------------------- | ----- | ------------------------------------------------------------------------------------------------------------- |
| **Blue bars** | Left Y-axis | Primary metric: Screens viewed count or Unique viewers count (depending on your selection) |
| **Green line** | Right Y-axis | Secondary metric: a conversion rate (Overall conversion rate, Conversion rate to intro or promo offer, or Conversion rate to full price).  
        Conversions are not attributed to the date they occur, but to the date the user last viewed a paywall |

Reading both together is the key insight: bars show your traffic volume, the line shows your conversion efficiency. A day with tall bars but a dipping line means you drove more traffic without converting proportionally. A rising line with shrinking bars means your paywall is more effective but fewer users are reaching it.

<br />

### Understanding conversion rate events

| Metric                                      | Events counted as a conversion                                                                                   |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| **Overall conversion rate**                 | # `SUBSCRIPTION_STARTED` + # `SUBSCRIPTION_REACTIVATED`                                                          |
| **Conversion rate to intro or promo offer** | # `INTRO_OFFER_STARTED` + # `TRIAL_STARTED` + # `PROMOTIONAL_OFFER_STARTED`                                      |
| **Conversion rate to full price**           | # `INTRO_OFFER_CONVERTED` + # `TRIAL_CONVERTED` + # `PROMOTIONAL_OFFER_CONVERTED` + # `SUBSCRIPTION_REACTIVATED` |

<br />

The primary metric (Screens viewed / Unique viewers) is based on the `PRESENTATION_VIEWED` SDK event.

# Controls

### Primary metric dropdown

Select what the blue bars represent:

| Option             | Description                                                                      |
| ------------------ | -------------------------------------------------------------------------------- |
| **Screens viewed** | Total paywall views (every view counts, including repeat views by the same user) |
| **Unique viewers** | Distinct users who viewed at least one paywall per time period                   |

### Grouped by (primary metric)

Break down the bars into segments:

| Group                | Description                                         |
| -------------------- | --------------------------------------------------- |
| **None**             | Single aggregated bar per period                    |
| **Audience**         | Split by audience segment                           |
| **Country**          | Split by user country                               |
| **Screen**           | Split by paywall screen                             |
| **Placement**        | Split by where in the app the paywall was triggered |
| **Platform**         | Split by iOS / Android                              |
| **A/B test variant** | Split by variant assignment                         |

"Grouped by" stacks or clusters the bars so you can see how the primary metric is distributed across a single dimension.

### Secondary metric dropdown

Select what the green line represents:

<Table>
  <thead>
    <tr>
      <th>
        Option
      </th>

      <th>
        Description
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        **Overall conversion rate**
      </td>

      <td>
        This aggregates the conversion to:

        * subscriptions starting with an introductory or promotional offer
        * subscription starting directly in full-price
      </td>
    </tr>

    <tr>
      <td>
        **Conversion rate to full price**
      </td>

      <td>
        Conversion rate to full-price paid subscriptions
      </td>
    </tr>

    <tr>
      <td>
        **Conversion rate to intro or promo offer**
      </td>

      <td>
        Conversion rate to trials, intro offers, and promotional offers
      </td>
    </tr>
  </tbody>
</Table>

Note: the overall conversion rate is not the sum of the conversion rate to full price and conversion rate to intro or promo offer because some subscriptions starting in intro and promo offer eventually convert to a full-price subscription. In the overall rate, they are only counted once.

### Split by (secondary metric)

Break down the green line into multiple lines, one per segment:

| Split                | Description                    |
| -------------------- | ------------------------------ |
| **None**             | Single aggregated line         |
| **Audience**         | One line per audience segment  |
| **Country**          | One line per country           |
| **Screen**           | One line per paywall screen    |
| **Placement**        | One line per placement         |
| **Plan**             | One line per subscription plan |
| **Platform**         | One line per platform          |
| **A/B test variant** | One line per variant           |

"Split by" draws separate lines so you can compare conversion rates across a dimension. For example, splitting CVR by Screen shows which paywall converts best.

### Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution.

* **Daily** -- One data point per day. Best for spotting day-to-day fluctuations and diagnosing short-term changes.
* **Weekly** -- One data point per week. Good for trend analysis with less noise.
* **Monthly** -- One data point per month. Best for executive reporting and long-term trends.

### Filters

Click **Filters** to narrow the dataset. Standard filter options include Platform, Country, Screen, Placement, Audience, Plan, and A/B test.

# Common use cases

* **Compare paywall performance** -- Set "Grouped by" to Screen on the primary metric and "Split by" to Screen on the secondary metric. This shows which paywall gets the most views AND which converts best. A paywall with low volume but high CVR is a candidate for broader rollout.

* **Evaluate an A/B test** -- Filter by the A/B test or use "Split by A/B test variant" on the secondary metric. Compare the CVR lines for each variant over the test period to determine which paywall design wins.

* **Diagnose a conversion drop** -- If Total CVR suddenly drops, split the secondary metric by Platform, Country, or Screen to isolate which segment is responsible. Then cross-reference with release notes or paywall changes.

* **Measure audience targeting effectiveness** -- Group the primary metric by Audience and split the secondary metric by Audience. Compare whether high-intent audiences (e.g., power users) see fewer paywalls but convert at higher rates than broad audiences.

* **Assess paywall frequency** -- Monitor the "AVG Number of Screens viewed per user" KPI card. If this number is very high but CVR is flat or declining, users may be experiencing paywall fatigue. Consider reducing display frequency or testing new creatives.

* **Track placement ROI** -- Group by Placement to see which in-app locations generate the most paywall views, then split CVR by Placement to see which locations drive the highest conversion. A placement with high views but low CVR may need a different paywall design or trigger logic.

# Frequently asked questions

### Why does Conversion rate to full price drop for recent dates?

This is expected behavior due to the cohort attribution model. Users who recently viewed a paywall may have started a trial or intro offer but have not yet converted to a regular-price subscription. Their conversion will only be counted once it occurs (e.g., after a 7-day trial ends), and it will be attributed back to the cohort when they last saw the paywall.

As a result, the most recent days or weeks will always show a lower Conversion rate to full price. The further back you look, the more complete the data becomes. Allow at least one full billing cycle (typically 7-30 days depending on your trial length) before drawing conclusions about regular-price conversion performance.

### Why don't full-price conversion numbers match the Paid Subscription Movements chart?

The two charts use different attribution models.

* In the **Paid Subscription Movements** chart, each transaction is attributed to the **date it was generated** — the actual day the payment or subscription event occurred.
* In the **Screens & Conversions** chart, conversions are attributed using a **cohort model**: each conversion is tied to the date the user last viewed a paywall, not when the conversion actually took place.

  For example, if a user views a paywall on April 1st and their trial converts to a full-price subscription on April 8th, the Paid Subscription Movements chart will show the conversion on April 8th, while the Screens & Conversions chart will attribute it to April 1st. This is why the same conversion can appear on different dates depending on which chart you are looking at, and why totals for a given day or week will not match between the two charts.

### Why is the Overall conversion rate not the sum of CVR to offer price and CVR to regular price?

Because some subscriptions that start with a trial, intro offer, or promotional offer eventually convert to full price. These subscriptions are counted once in the "CVR to offer price" column (when the offer starts) and once in the "CVR to regular price" column (when the user converts to full price), but they are counted only once in the Overall conversion rate. The Overall CVR represents the percentage of unique viewers who generated at least one conversion event — regardless of how many stages that conversion went through. It is not an addition of the two sub-rates, but rather a deduplicated metric.

### What is the difference between "Grouped by" and "Split by"?

"Grouped by" applies to the **primary metric** (bars) and breaks it into stacked or clustered segments within each time period. "Split by" applies to the **secondary metric** (line) and draws separate lines for each segment. They operate independently, so you can group bars by Placement while splitting the CVR line by Platform.

### Why is my Overall conversion rate lower than I expected?

Conversion rates are calculated against **unique viewers**, not total app users or total views. If many users see your paywall but few convert, the denominator (unique viewers) is large. Also remember that cohort attribution means recent periods will have incomplete conversion data. Check the KPI cards at the top: if "Number of unique Screens viewers" is very high relative to conversions, the issue is likely conversion efficiency rather than a data problem.

### How do pending or deferred purchases affect conversions?

On Google Play, a purchase can be **deferred** (e.g., the user chooses to pay later or uses a slow payment method). In this case, the user views the paywall and initiates a purchase, but the transaction is not immediately confirmed. The paywall view is counted in the cohort immediately, but the conversion is only recorded once the transaction is finalized. This can create a temporary gap where views increase but conversions lag behind — similar to the trial-to-paid delay, but caused by the payment processing timeline rather than an offer period.

### Can I see revenue data in this chart?

No. The Screens & Conversions chart focuses exclusively on funnel metrics (views and conversion rates). For revenue analysis, use the Revenue or MRR charts, which track monetary values.

### How does "Unique viewers" deduplication work?

A user who views multiple paywalls within the same time period is counted once as a unique viewer for that period. The deduplication resets at each period boundary. For example, in daily granularity, a user who views a paywall on Monday and again on Tuesday counts as one unique viewer on each day. In monthly granularity, the same user counts as one unique viewer for the entire month.

### Why do the numbers change when I switch granularity?

Unique viewer counts can differ across granularities because deduplication windows change. In daily view, a user appearing on three separate days counts as three unique-viewer entries (one per day). In monthly view, the same user counts as one. This affects both the KPI cards and the conversion rate denominators. Choose a granularity that matches your analysis timeframe and avoid comparing absolute numbers across different granularities.