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

The line chart plots MRR over the selected date range. Each point is a snapshot of one day: the first day of each month in monthly granularity, each Monday in weekly granularity, every day in daily granularity. Hover over any point to see the exact date and MRR value. The **Selected Date MRR** card is a snapshot of the last day of your range, so it differs from the last monthly point, which is the 1st of that month.

### Data table

Below the chart, a table lists each date and its corresponding MRR value in the dashboard currency of your app settings.

### How MRR is calculated

MRR normalizes every active subscription to a 30-day equivalent using this formula:

```
MRR = (amount_in_usd / number_of_days_between(purchased_at, next_renewal_at)) * 30
```

The calculation uses the actual dates of each subscription period (`purchased_at` to `next_renewal_at`), not the plan's configured periodicity. This means the MRR of a subscription may shift slightly from one renewal to the next depending on the exact number of days in each billing cycle.

MRR always uses **30-day months** as the normalization base.

> **Note:** Free trials contribute $0 to MRR. When a trial converts to a paid subscription, the MRR contribution begins on the conversion date.
>
> MRR follows **paid periods, not access**. A pause, a billing retry or a cancellation does not change MRR until the paid period ends; the next charge, with its own amount and dates, does.

### Examples

| Subscription                                                                | Calculation      | MRR        |
| --------------------------------------------------------------------------- | ---------------- | ---------- |
| $7 weekly plan                                                              | (7 / 7) * 30     | **$30.00** |
| $100 yearly plan (366-day year)                                             | (100 / 366) * 30 | **$8.20**  |
| $10 monthly plan with $1/week intro offer — during intro period             | (1 / 7) * 30     | **$4.29**  |
| $10 monthly plan with $1/week intro offer — after intro ends (31-day month) | (10 / 31) * 30   | **$9.68**  |
| Refunded subscription                                                       | the refund is spread over the refunded period | **$0.00** over that period, retroactively |

Paid promotional offers are accounted for at their actual price during the offer period, then switch to the standard price calculation after conversion.

# Controls

### Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution of the chart.

* **Daily** — One data point per day. Best for spotting short-term fluctuations.
* **Weekly** — One data point per week. Good for smoothing daily noise while keeping weekly trends visible.
* **Monthly** — One data point per month. Best for long-term trend analysis and executive reporting.

### Filters

<DashboardFilters />

| Filter               | Description                                                      |
| -------------------- | ---------------------------------------------------------------- |
| **Platforms**        | iOS, Android, or both                                            |
| **Plans**            | Filter by specific subscription plan                             |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.)          |
| **Countries**        | Filter by store country: the country of the store account used for the purchase |
| **Screens**          | Filter by the paywall screen that triggered the subscription     |
| **Placements**       | Filter by where in the app the paywall was shown                 |
| **Audiences**        | Filter by the audience the user matched at purchase time         |
| **A/B tests**        | Filter by the A/B test variant attached to the subscription      |

> 📘 There is no Campaign filter on this chart: an MRR per campaign has no meaning, the recurring revenue of a subscription is not attributable to one campaign over time.

# Common use cases

* **Track overall revenue health** — Monitor the MRR line over several months to confirm sustained growth or detect early signs of contraction before they show up in raw revenue reports.
* **Measure the impact of a pricing change** — Compare the MRR trend before and after a price adjustment. Because MRR normalizes billing periods, you get a clean signal even if you changed plan durations at the same time.
* **Evaluate a paywall** — Filter by Screen or Placement to isolate the MRR contribution of a specific paywall and assess its long-term revenue impact.
* **Compare platforms** — Filter by Platform to see whether iOS or Android subscribers generate more recurring revenue and allocate growth investment accordingly.
* **Assess plan mix shifts** — Filter by Plan periodicity to see how the balance between weekly, monthly, and yearly MRR evolves over time. A shift toward longer plans typically indicates stronger subscriber commitment.
* **Quantify A/B test outcomes** — Filter by A/B test to compare the MRR generated by each variant and decide which paywall configuration drives higher long-term value.

# Frequently asked questions

### Why is the last monthly point different from the Selected Date MRR card?

The monthly line plots a snapshot on the 1st of each month, while the Selected Date card is a snapshot of the last day of your date range. Both are correct values of different days. Switch to daily granularity to read MRR on a specific date.

### Why does MRR differ from my raw revenue?

MRR is not a sum of actual payments received. It normalizes every subscription to a 30-day equivalent. A $100 yearly subscription contributes roughly $8.20/month to MRR, not $100 in the month it was charged. Conversely, a $7 weekly plan contributes $30/month to MRR even though actual monthly payments total around $28-$35 depending on the number of weeks. MRR is designed to reflect the recurring run rate of your business, not cash flow.

### Why do weekly subscriptions show a high MRR?

A $7/week subscription translates to (7/7) * 30 = $30 MRR. That is higher than a $10/month plan, which yields roughly $9.68 MRR depending on the month length. This is accurate: the weekly subscriber is paying at a faster rate. If they stay subscribed for a full month, they will pay $28-$35 in actual revenue, which is indeed higher than the $10 monthly subscriber.

### How do refunds affect MRR?

A refund is recorded as a negative transaction spread over the period it refunds. The MRR of that period is therefore **restated**: the refunded revenue is removed from the dates it covered, back to the start of the period, not from the date the store processed the refund. Your MRR of a past month can change after a refund; this is expected, the revenue was given back.

### How are the comparison percentages calculated?

Each comparison card (1 month, 3 months, 6 months) takes the MRR snapshot one, three or six months before the calendar boundary of your last period (the 1st of the month in monthly granularity) and computes the percentage change relative to the Selected Date MRR, which is the snapshot of the last day of your range. For example, if your current MRR is 76,052 and MRR one month ago was 76,638, the change is ((76,052 - 76,638) / 76,638) * 100 = -0.76%.

### Does the MRR calculation use the plan's configured periodicity?

No. MRR is computed from the actual `purchased_at` and `next_renewal_at` dates of each subscription, not from the plan's periodicity setting in the console. This means the calculation reflects the real billing cycle, including any variations caused by store-level billing adjustments.

### Why did my MRR change even though I had no new subscribers?

MRR can shift without new acquisitions. Common reasons include: subscriptions transitioning from an intro offer to full price (increasing MRR), paid periods ending without a new charge (billing retry, pause, cancellation), refunds restating a past period, or renewals landing on a period with a different number of days. All of these change the per-subscription MRR contribution.

### How do Google Play paused subscriptions affect MRR?

MRR follows paid periods, not access. A paused subscription keeps contributing until the end of the period it had paid for; during the pause itself no charge occurs, so nothing follows until the subscription resumes and is charged again. The same holds for billing retry: the last charge contributes until its renewal date.

### How do price changes affect MRR?

When a price change is pending (particularly opt-in increases on Google Play), MRR continues to reflect the **current price** until the new price actually takes effect at the next renewal. If the user rejects an opt-in price increase and the subscription is canceled, MRR will drop to $0 at expiration. The pending price change itself has no impact on MRR.

### How do proration modes affect MRR on plan changes?

For subscription upgrades and downgrades, MRR is calculated using the actual amount charged and the actual service period dates. Different proration modes on Google Play (e.g., `CHARGE_PRORATED_PRICE`, `WITH_TIME_PRORATION`) may result in a non-standard first period for the new plan, which affects the per-day MRR calculation. This is temporary and normalizes at the next full billing cycle.
