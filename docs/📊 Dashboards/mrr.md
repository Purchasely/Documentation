---
title: MRR
---
# About this chart

The MRR chart tracks your Monthly Recurring Revenue over time. It normalizes all subscription revenue to a 30-day equivalent, regardless of actual billing period, so you can compare the recurring value of weekly, monthly, and yearly plans on a common scale. Use it to monitor revenue momentum, detect growth or contraction trends, and measure the impact of pricing or acquisition changes.

# How to read the chart

### KPI cards

Four cards appear at the top of the chart:

| Card                  | Description                                                                   |
| --------------------- | ----------------------------------------------------------------------------- |
| **Selected Date MRR** | The MRR value at the end of the selected date range                           |
| **1 month before**    | MRR one month prior, with the percentage change compared to the selected date |
| **3 months before**   | MRR three months prior, with the percentage change                            |
| **6 months before**   | MRR six months prior, with the percentage change                              |

Percentage changes are shown in green (positive) or red (negative). These comparison periods let you quickly assess short-term and medium-term revenue trends in a single glance.

### Line chart

The line chart plots MRR over the selected date range. Hover over any point to see the exact date and MRR value.

### Data table

Below the chart, a table lists each date and its corresponding MRR value in your account currency.

### How MRR is calculated

MRR normalizes every active subscription to a 30-day equivalent using this formula:

```
MRR = (amount_in_usd / number_of_days_between(purchased_at, next_renewal_at)) * 30
```

The calculation uses the actual dates of each subscription period (`purchased_at` to `next_renewal_at`), not the plan's configured periodicity. This means the MRR of a subscription may shift slightly from one renewal to the next depending on the exact number of days in each billing cycle.

MRR always uses **30-day months** as the normalization base.

> **Note:** Free trials contribute $0 to MRR. When a trial converts to a paid subscription, the MRR contribution begins on the conversion date.

### Examples

| Subscription                                                                | Calculation      | MRR        |
| --------------------------------------------------------------------------- | ---------------- | ---------- |
| $7 weekly plan                                                              | (7 / 7) * 30     | **$30.00** |
| $100 yearly plan (366-day year)                                             | (100 / 366) * 30 | **$8.20**  |
| $10 monthly plan with $1/week intro offer — during intro period             | (1 / 7) * 30     | **$4.29**  |
| $10 monthly plan with $1/week intro offer — after intro ends (31-day month) | (10 / 31) * 30   | **$9.68**  |
| Refunded subscription                                                       | $0 revenue       | **$0.00**  |

Paid promotional offers are accounted for at their actual price during the offer period, then switch to the standard price calculation after conversion.

# Controls

### Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution of the chart.

* **Daily** — One data point per day. Best for spotting short-term fluctuations.
* **Weekly** — One data point per week. Good for smoothing daily noise while keeping weekly trends visible.
* **Monthly** — One data point per month. Best for long-term trend analysis and executive reporting.

### Filters

Click **Filters** to narrow the data. You can combine multiple filters.

| Filter               | Description                                                      |
| -------------------- | ---------------------------------------------------------------- |
| **Platforms**        | iOS, Android, or both                                            |
| **Plans**            | Filter by specific subscription plan                             |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.)          |
| **Countries**        | Filter by user country                                           |
| **Screens**          | Filter by the paywall screen that triggered the subscription     |
| **Placements**       | Filter by where in the app the paywall was shown                 |
| **Audiences**        | Filter by audience segment the user belonged to at purchase time |
| **A/B tests**        | Filter by A/B test the user was enrolled in                      |
| **Campaigns**        | Filter by campaign attribution                                   |

# Common use cases

* **Track overall revenue health** — Monitor the MRR line over several months to confirm sustained growth or detect early signs of contraction before they show up in raw revenue reports.
* **Measure the impact of a pricing change** — Compare the MRR trend before and after a price adjustment. Because MRR normalizes billing periods, you get a clean signal even if you changed plan durations at the same time.
* **Evaluate acquisition campaigns** — Filter by Campaign or Screen to isolate the MRR contribution of a specific paywall or marketing initiative and assess its long-term revenue impact.
* **Compare platforms** — Filter by Platform to see whether iOS or Android subscribers generate more recurring revenue and allocate growth investment accordingly.
* **Assess plan mix shifts** — Filter by Plan periodicity to see how the balance between weekly, monthly, and yearly MRR evolves over time. A shift toward longer plans typically indicates stronger subscriber commitment.
* **Quantify A/B test outcomes** — Filter by A/B test to compare the MRR generated by each variant and decide which paywall configuration drives higher long-term value.

# Frequently asked questions

### Why does MRR differ from my raw revenue?

MRR is not a sum of actual payments received. It normalizes every subscription to a 30-day equivalent. A $100 yearly subscription contributes roughly $8.20/month to MRR, not $100 in the month it was charged. Conversely, a $7 weekly plan contributes $30/month to MRR even though actual monthly payments total around $28-$35 depending on the number of weeks. MRR is designed to reflect the recurring run rate of your business, not cash flow.

### Why do weekly subscriptions show a high MRR?

A $7/week subscription translates to (7/7) * 30 = $30 MRR. That is higher than a $10/month plan, which yields roughly $9.68 MRR depending on the month length. This is accurate: the weekly subscriber is paying at a faster rate. If they stay subscribed for a full month, they will pay $28-$35 in actual revenue, which is indeed higher than the $10 monthly subscriber.

### How do refunds affect MRR?

When a subscription is refunded, its revenue contribution drops to $0, and its MRR becomes $0 for the affected period. This means a refund immediately reduces your MRR on the date it is processed.

### How are the comparison percentages calculated?

Each comparison card (1 month, 3 months, 6 months) takes the MRR value at the end of that earlier period and computes the percentage change relative to the current selected date MRR. For example, if your current MRR is 76,052 and MRR one month ago was 76,638, the change is ((76,052 - 76,638) / 76,638) * 100 = -0.76%.

### Does the MRR calculation use the plan's configured periodicity?

No. MRR is computed from the actual `purchased_at` and `next_renewal_at` dates of each subscription, not from the plan's periodicity setting in the console. This means the calculation reflects the real billing cycle, including any variations caused by store-level billing adjustments.

### Why did my MRR change even though I had no new subscribers?

MRR can shift without new acquisitions. Common reasons include: subscriptions transitioning from an intro offer to full price (increasing MRR), subscriptions entering a billing retry period, refunds being processed, or renewals landing on a period with a different number of days. All of these change the per-subscription MRR contribution.

### How do Google Play paused subscriptions affect MRR?

During a pause (Google Play only), the subscription contributes **$0 to MRR** — the user has no access and no billing occurs. When the subscription automatically resumes, MRR is recalculated based on the new billing cycle. If you see periodic MRR dips concentrated on Android, paused subscriptions may be the cause.

### How do price changes affect MRR?

When a price change is pending (particularly opt-in increases on Google Play), MRR continues to reflect the **current price** until the new price actually takes effect at the next renewal. If the user rejects an opt-in price increase and the subscription is canceled, MRR will drop to $0 at expiration. The pending price change itself has no impact on MRR.

### How do proration modes affect MRR on plan changes?

For subscription upgrades and downgrades, MRR is calculated using the actual amount charged and the actual service period dates. Different proration modes on Google Play (e.g., `CHARGE_PRORATED_PRICE`, `WITH_TIME_PRORATION`) may result in a non-standard first period for the new plan, which affects the per-day MRR calculation. This is temporary and normalizes at the next full billing cycle.
