---
title: Funnel
---
# About this chart

The Funnel chart follows the **subscriptions that started during the selected period** and shows what became of them, as a **Sankey diagram**: bands flow from left to right, from the entry groups (one per placement, paywall, plan, platform or country) to the first step (started directly at full price, or started with an offer) and then to the outcome (first renewal, conversion, or end). Wider bands mean more subscriptions followed that path.

Each step counts **subscriptions**, once each. The chart reads the events of those subscriptions whatever their date: a trial that converts today raises the conversion figure of the month the subscription started in. Sandbox subscriptions and subscriptions received through Family Sharing (the family members' copies, not the purchaser's own) are excluded.

# How to read the chart

| Node                            | What it counts                                                                                                                                                                              |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Entry nodes (left)**          | The subscriptions that started in the period, split by the chosen dimension                                                                                                                 |
| **Start paying full price**     | Subscriptions that started directly at the regular price, without any offer                                                                                                                 |
| **Trial started**               | Subscriptions that started with an offer: free trial, intro offer, promo code or promotional offer. The label says "trial", the count covers all four                                      |
| **Start paying full price (2)** | Offers that converted to the regular price. Together with the direct starts, this is the paying population of the cohort                                                                    |
| **First renewal**               | Subscriptions that renewed at least once after a regular-price period, whether they started at full price or converted from an offer                                                       |
| **Ended subscription**          | Offers that ended without converting, and regular-price starts that ended without ever renewing. Churn after a renewal is not in this chart (see Paid Subscription Movements or Retention) |

The percentage on a band is its share of the node it leaves. Offers still running at the time of reading are in "Trial started" but in no outcome yet.

Below the diagram, a **table** gives the counts per entry group.

| Column                    | Description                                                                                       |
| ------------------------- | ------------------------------------------------------------------------------------------------- |
| **Name**                  | The entry group (placement, paywall, plan, platform or country)                                   |
| **Subscription started**  | Started directly at the regular price                                                             |
| **Trial started**         | Started with an offer of any kind                                                                 |
| **Trial converted**       | Offers that converted to the regular price                                                        |
| **Unique paying users**   | Not computed by this chart; the column stays empty here                                           |
| **1st renewal**           | Subscriptions that renewed at least once after a regular-price period                             |

The CSV export also carries **Trial ended** (offers that ended without converting) and **Subscription ended** (regular-price starts that ended without renewing).

# Controls

### Choose a dimension

Select which dimension defines the entry nodes. Only one dimension is active at a time. The value is the one attached to the subscription when it was purchased.

| Dimension     | What entry nodes represent                                                                                                            |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| **Placement** | The placement the paywall was shown at. "Unknown" when the purchase was not made through a tracked placement                          |
| **Paywall**   | The paywall screen the subscription was purchased from. "Unknown" when there is none (restored or store-side purchase)                |
| **Plan**      | The subscription plan                                                                                                                 |
| **Platform**  | iOS, Android, Huawei, Amazon or Stripe                                                                                                |
| **Country**   | The store country of the account that purchased. Countries under 5 % of the starts are merged into "Other countries" on the diagram, the table keeps them all |

### Date range

The date range selects the **subscriptions that started** in it. Everything that happened to them since is counted, whatever the date. The Daily / Weekly / Monthly selector displayed on the page has no effect on this chart: there is one funnel for the whole range.

### Filters

| Filter               | Description                                                                       |
| -------------------- | --------------------------------------------------------------------------------- |
| **Platforms**        | iOS, Android, Huawei, Amazon, Stripe                                              |
| **Countries**        | Store country: the country of the store account used for the purchase             |
| **Plans**            | Specific subscription plans                                                        |
| **Plan periodicity** | Billing cycle (weekly, monthly, yearly, etc.)                                      |

### Download CSV

Click **Download CSV** to export the table, with the two extra "ended" columns, for a spreadsheet or BI tool.

# Common use cases

* **Compare paywall performance** — Set the dimension to "Paywall" and compare, for each screen, the share of subscriptions that start at full price versus with an offer, and the share of offers that convert. Read a period old enough for its offers to have ended.
* **Evaluate offer conversion by plan** — Set the dimension to "Plan": a plan with a wide "Trial started" band and a narrow conversion band points at a pricing or offer-length problem.
* **Spot platform differences** — Set the dimension to "Platform" to compare how iOS and Android cohorts split between direct starts and offers, and how they convert.
* **Find markets where the funnel leaks** — Set the dimension to "Country" to see where offers convert least, and where a localized price or a different offer could help.
* **Measure the effect of a new offer** — Compare the cohort that started before the launch with the one that started after, once both are old enough for their offers to have ended.

# Frequently asked questions

### Why do the last weeks show almost no conversions or renewals?

Because the cohort is dated at the subscription start. Conversions happen when the offer ends, renewals one billing period later. Read a period once it is older than your longest offer plus one billing period.

### Why did a past month change?

A subscription of that cohort converted, renewed, ended or came back since your last visit. The chart always shows the current state of each cohort.

### Do "Subscription started" and "Trial started" add up to my new subscriptions?

They add up to the subscriptions whose original purchase is in the range, reactivations included: a lapsed subscriber who comes back on the same subscription counts as a start of the original cohort, not of the comeback.

### Why is "Trial started" high when I offer no free trial?

The step counts every offer type: introductory offers, promo codes and promotional offers as well as free trials.

### Why is "Ended subscription" so much lower than my churn?

It only counts regular-price starts that never renewed, and offers that did not convert. A subscription that churns after one or more renewals is not in this chart. Use Paid Subscription Movements or Retention for churn.

### What does "Unknown" mean in the entry nodes?

The subscription has no value for the selected dimension: no placement or paywall when the purchase was made outside a Purchasely paywall or restored from the store, no store country when the store did not provide one. This is expected and not a data error.

### Why do the numbers in the table not add up across columns?

The columns are steps, not a partition. "Trial converted" is a subset of "Trial started"; "1st renewal" includes both direct starts and converted offers; offers still running appear in "Trial started" only.

<br />
