---
title: Subscription Retention
---
# About this page

The Subscription Retention page helps you measure subscriber loyalty, identify when users tend to churn, and evaluate the long-term impact of your acquisition and retention strategies. It contains two complementary views:

* The **Cohort Retention Table** — a detailed, per-cohort breakdown of how subscriptions retain over time
* The **Cohort Layer Cake** — a stacked area chart showing the evolution of the active paid subscriptions of the selected cohorts

> 📘 **Cohort entry = the subscription starts to pay as the Segment**
>
> Each cohort counts **paid subscriptions**. A subscription is in the Segment while its payments match the Segment. It enters a cohort when it starts to match. A free trial or a free offer is not a payment. A failed payment, such as a grace period start or a billing retry, is not a payment. A subscription that never pays is not counted.
>
> A subscription leaves the Segment when it pays another way or gets a free period. This counts as a churn. If it comes back, it enters a new cohort. A reactivation after churn also starts a new cohort entry. So a subscription can enter several cohorts. For example, it churns in March and recovers through billing retry in May. Both cohorts count it.

<DashboardV1CountingChange />

The **Segment** control sets which payments keep a subscription in the chart:

* **All subscriptions**: payments at full price or with a paid offer
* **Full-price subscriptions**: full-price payments only

# Cohort Retention Table

### What it shows

The Cohort Retention Table is a **cohort retention matrix**. Each row represents a group (cohort) of subscriptions that entered the Segment during the same time period.

| Column                                           | Description                                                                                                                            |
| ------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------- |
| **Segment**                                      | The cohort time period (e.g., "2026, day 083" in daily view, or "2026, week 12" in weekly view) |
| **Paid subscriptions (started and reactivated)** | The initial size of the cohort. It counts paid subscriptions that entered the Segment during that period |
| **Revenue**                                      | Total revenue of this cohort, counted from the cohort entry until the subscription churns or leaves the Segment |
| **ARPPU**                                        | Average Revenue Per Paid Subscription for this cohort (Revenue / Paid subscriptions)                                                   |
| **Day 0, Day 1, Day 2...**                       | How many subscriptions from this cohort are still active and still in the Segment after N periods (or Week 0, Month 0, etc. depending on granularity) |

### How to read it

The diagonal staircase pattern is normal: recent cohorts have fewer columns because not enough time has elapsed to measure later periods.

Look for:

* **Consistent retention rates across cohorts** — a sign that your product experience is stable
* **A cohort with a sharper drop than its neighbors** — something changed for that group (pricing, paywall, acquisition channel)
* **Improving retention in recent cohorts** — your retention efforts are paying off
* **Sharp drops at specific periods** (Day 7, Day 30, Day 365) — these align with renewal dates and indicate cancellations or payment failures

# Cohort Layer Cake

### What it shows

The Cohort Layer Cake is a **stacked area chart** where each colored layer represents a cohort. The X-axis is calendar time, and the Y-axis shows the absolute number of retained subscriptions. All cohorts are stacked on top of each other. The total height counts the paid subscriptions of the selected cohorts that are still active and still in the Segment. Active free trials are not in the chart. Subscriptions whose cohort is before the selected range are not in the chart.

### How to read it

| What to look for | What it means |
| --- | --- |
| **Overall shape trending upward** | Your subscriber base is growing — new cohorts are adding more subscribers than older ones are losing |
| **Overall shape trending downward** | Churn is outpacing acquisition — you're losing subscribers faster than you're gaining new ones |
| **Flat or plateau** | Acquisition and churn are roughly balanced |
| **Older layers (bottom) thinning gradually** | Normal churn behavior — older cohorts naturally shrink over time |
| **A layer thinning faster than others** | That cohort had worse retention — investigate what changed during that period (paywall, pricing, acquisition channel) |
| **Recent layers (top) appearing large** | Strong recent acquisition — but watch whether they retain as well as older cohorts |

### Practical insights

The Layer Cake answers questions that the retention table cannot easily show:

* **Is my subscriber base actually growing?** The table shows retention rates per cohort, but doesn't give you the big picture. The Layer Cake instantly shows whether the active paid subscriptions of the selected cohorts are going up or down.
* **Which cohorts still contribute meaningfully?** Old cohorts that have thinned to a sliver are no longer material. Thick, stable layers at the bottom indicate a healthy, loyal subscriber core.
* **What's the balance between acquisition and retention?** If the chart keeps growing, new cohort layers are thick enough to compensate for natural churn in older ones. If it shrinks despite large new cohorts, retention is the problem.

# Controls

### Show

Switch between two display modes:

| Mode                                 | What it shows                                                                                                             |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------- |
| **Subscriptions retained (rates)**   | Percentage of the cohort still active at each period (e.g., 96.7% means 96.7% of the original cohort is still subscribed) |
| **Subscriptions retained (numbers)** | Absolute count of subscriptions still active at each period                                                               |

### Segment

Focus on a subset of subscriptions:

| Segment                      | Description                                                                                                         |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **All subscriptions**        | All paid subscriptions. A subscription is in the chart while it pays, at full price or with a paid offer. A free trial or a free offer is not a payment. |
| **Full-price subscriptions** | A subscription is in the chart while it pays full price. A trial, an intro offer, or a promo offer that converts to full price enters at the conversion. |

A subscription that changes how it pays can leave the Segment and come back. For example, it pays full price, takes a promo offer, and returns to full price. In "Full-price subscriptions", the promo offer ends its first entry as a churn. The return to full price is a new entry. In "All subscriptions", nothing changes, because a promo offer is also a payment.

**Examples:**

| Case | All subscriptions | Full-price subscriptions |
| --- | --- | --- |
| Direct full-price start in January | January | January |
| Free trial on January 28, converts on February 4 | February | February |
| Paid intro offer in January, converts to full price in April | January | April |
| Full price in January, promo offer from June, full price again in December | January | January (churns in June), then December |
| Full price in January, one free month in May, full price again in June | January (churns in May), then June | January (churns in May), then June |
| Free trial, payment fails, never pays | Not counted | Not counted |
| Free trial, cancelled before conversion | Not counted | Not counted |

To know if a payment in the selected range is a new entry, the chart uses the payment type before it, as recorded with the payment.

<br />

### Granularity

Use the **Daily / Weekly / Monthly** selector to control the time resolution of cohorts and retention periods.

* **Daily** — One cohort per day, retention measured day by day. Best for short-term analysis (days to weeks).
* **Weekly** — One cohort per week, retention measured week by week. Good for spotting weekly patterns.
* **Monthly** — One cohort per month, retention measured month by month. Best for long-term trends.

### Filters

<DashboardFilters />

| Filter               | Description                                                                        |
| -------------------- | ---------------------------------------------------------------------------------- |
| **Platforms**        | iOS, Android, or both                                                              |
| **Plan periodicity** | Filter by billing cycle (weekly, monthly, yearly, etc.)                            |
| **Offer types**      | Filter by the most recent offer type of the subscription (trial, intro offer, promo offer, standard). A trial that converts counts as standard. All the cohort entries of a subscription use its most recent offer type. |
| **Countries**        | Filter by user country                                                             |
| **Screens**          | Filter by the paywall screen that triggered the subscription                       |
| **Placements**       | Filter by where in the app the paywall was shown                                   |
| **Audiences**        | Filter by audience segment the user belonged to at purchase time                   |
| **Plans**            | Filter by specific subscription plan                                               |
| **A/B tests**        | Filter by A/B test the user was enrolled in                                        |
| **Campaigns**        | Filter by campaign attribution                                                     |

# Common use cases

* **Measure the effect of paid offers on retention** — A subscription with a paid intro offer enters "All subscriptions" at the offer payment. It enters "Full-price subscriptions" at the conversion to full price. Switch the Segment dropdown to compare both views. A sharp drop in "All subscriptions" at the first full-price renewal shows users who leave when the offer ends. In "Full-price subscriptions", a move to a promo offer counts as a churn, so the retention shows how long subscribers keep paying full price. Free trials do not appear in either segment until they convert.
* **Measure the impact of a paywall change** — Filter by Screen or A/B test and compare cohort retention before and after the change.
* **Identify platform differences** — Filter by Platform to see if iOS and Android subscribers retain differently.
* **Spot billing cycle issues** — Look for sharp drops at Day 7 (weekly plans), Day 30 (monthly plans), or Day 365 (yearly plans) in the retention table. These indicate renewal failures or intentional cancellations.
* **Assess subscriber base health at a glance** — Check the Layer Cake. It shows if the active paid subscriptions of the selected cohorts grow, stay flat, or decline. You do not need to analyze each cohort.
* **Identify problematic cohorts visually** — In the Layer Cake, a layer that thins faster than its neighbors signals a cohort with worse-than-average retention. Cross-reference with the retention table to pinpoint the exact drop-off period.

# Frequently asked questions

### What is the difference between the Cohort Retention Table and the Cohort Layer Cake?

The retention table shows **how well each cohort retains** (as a percentage or count), period by period. The Layer Cake shows **the combined result** of all cohorts. It shows the size and composition of the active paid subscriptions of the selected cohorts at any point in time. The table is for diagnosing individual cohort performance; the Layer Cake is for understanding the big picture.

### Why do weekly cohort totals not match the monthly total?

When you add up the "Paid subscriptions" column across all weekly cohorts for a given month, the total may be **higher** than the single monthly cohort for the same period. This is not a data error.

**The reason:** when a subscription payment fails, it enters a **billing retry period** — the app store retries the charge over several days. If the subscription churns in week 10 and recovers in week 11, it appears as "started" in one cohort and "reactivated" in the other. The same subscription is counted **twice** across two weekly cohorts. In monthly view, both events fall within the same month, so it is counted only **once**.

> **Example:** the six weekly cohorts covering March 2026 total 893 paid subscriptions (35 + 206 + 211 + 192 + 215 + 34). But the monthly March 2026 cohort shows only 835. The 58 extra subscriptions were counted in two weekly cohorts due to billing retry spanning across weeks.

This applies to any granularity comparison: daily totals won't match weekly totals, and weekly totals won't match monthly totals.

> 📘 **Grace period recovery vs. account hold recovery**
>
> The **billing retry** effect described above specifically applies to subscriptions that go through **account hold** (Google Play: `ON_HOLD`) or equivalent — where access is revoked and then restored. Grace period recovery does **not** create a new cohort entry because the subscription never leaves the "active" state. Only account hold recovery (where the billing date resets) generates a recovery event that can cause double-counting across weekly cohorts.

### Why does retention look higher when I switch to a wider granularity?

For the same reason. When a subscription churns and recovers within the same time bucket (e.g., within the same month), the net effect is zero — it never appears to have churned.

> **Example:** a subscription enters billing retry on Jan 5 and recovers on Jan 20.
>
> * **Weekly view:** churn and recovery land in different weeks — retention dips then recovers.
> * **Monthly view:** both events land in January — the subscription never appears to have churned. Retention stays flat.

The wider the time bucket, the more of these temporary churn-and-recovery pairs become invisible. This is standard behavior across analytics tools.

### Why does retention appear unusually high for some cohorts?

This typically happens when the chart granularity does not match the billing cycle of the subscriptions being analyzed. For example, if you set the chart to monthly granularity but include yearly subscriptions, those subscriptions are prepaid for 12 months and will naturally remain active across many monthly periods — pulling retention rates up and making them less meaningful.

For the most actionable insights, match the chart granularity with the plan periodicity filter. Use monthly granularity with monthly plans, weekly with weekly plans, and so on. If you need to analyze yearly subscriptions, prefer a monthly granularity so that each period represents a meaningful milestone in the subscription lifecycle.

### Which granularity should I use?

* **Daily** when you need precision on short-term retention and accurate cohort counts.
* **Weekly** for week-over-week trend analysis with a good balance of precision and readability.
* **Monthly** for long-term trends and executive reporting — but keep in mind that cohort sizes and retention rates will be slightly optimistic due to the billing retry smoothing effect described above.

As a rule of thumb: don't try to reconcile totals across granularities. The differences are an expected artifact of billing retry, not a data discrepancy.

### Why do prepaid subscriptions (yearly, quarterly) sometimes drop before their renewal date?

Even though a yearly subscription is paid upfront, it can still leave the active state before its renewal date if a refund is granted by Apple or Google. Refunds are reflected in the chart at the moment the store processes them, not at the end of the billing cycle.

This is why you may see a yearly cohort lose subscriptions during months 2, 3, or 6 — well before any renewal is expected. The same logic applies at other granularities: a monthly subscription viewed in weekly granularity can appear to churn mid-month if a refund is processed during that week.

### How do plan changes affect retention cohorts?

A plan change (upgrade, downgrade, or crossgrade) between plans of the same payment type does not churn the subscription. It does not start a new cohort entry. The chart follows the whole subscription chain. The subscription stays in its cohort and keeps its retention.

A plan change that changes how the subscription pays is different:

* A free trial changes to a paid plan. The subscription enters its cohort at the plan change.
* In "Full-price subscriptions", a full-price plan changes to a plan with a promo offer. The subscription leaves its cohort, and this counts as a churn. A later return to full price is a new entry.

### How do Google Play paused subscriptions affect retention?

Paused subscriptions (Google Play only) temporarily leave the active state and re-enter it when the pause ends. In retention cohorts, a paused subscription will appear as churned during the pause period and recovered when it resumes — similar to account hold recovery. This creates the same cross-cohort counting effect described in the granularity section above.

### Why does the Layer Cake show a dip even though my latest cohort is large?

A large new cohort adds a thick layer at the top, but if several older cohorts are shrinking simultaneously, the net effect can still be a decline. This signals that your retention across older cohorts is not strong enough to sustain growth from new acquisitions alone — a common early sign that you need to invest in retention strategies alongside acquisition.

### Can the same subscription appear in multiple layers of the Layer Cake?

Yes, for the same reasons described above. If a subscription churns and recovers through billing retry or account hold, it can appear in multiple cohorts — and therefore in multiple layers of the chart.
