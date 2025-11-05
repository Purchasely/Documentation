---
title: Dashboard - Subscriptions
excerpt: This page provides details on the Subscriptions dashboard
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The Subscriptions dashboard presents the evolution of different indicators **based on the date the subscription started** (original purchase date)

## Number of Subscriptions

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/cce2748ca72e78492b04c1ee190e3fb1883ca403275e117b4b566c54498d4f93-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

- **Daily/weekly/monthly active subscriptions**: this chart shows the evolution over time of the number of active subscriptions. 
  - Subscribers in `Introductory Offer` (either free trial or paid trail) and users with the Subscription status `Auto-renewing cancelled` or `Grace period are included`. 
  - Subscriptions in Billing retry are not included are they are not considered as active anymore.
- **Daily/weekly/monthly new subscriptions and churn**: this chart shows the evolution over time of the new subscriptions which started during the visualization period and those who were terminated over the same period. 
  - Subscriptions in `Introductory Offer` and those that have restarted after being terminated are counted as **New** (blue)
  - Subscriptions effectively terminated (which includes those in `Billing retry` and those who were `Refunded`) are counted as **Churn** (red)
  - Subscriptions in `Grace period` are excluded as they are considered as still active.
  - The black curve shows the net balance for each day/week/month (`New - Churn`)

<br />

> ❗️ Important details on "Active subscriptions" & "New subscriptions and churn" charts
> 
> - The filters applied on the chart filter on the ** current** subscription properties, and not the properties it had when it was created. e.g. Adding a filter on "Free Trial" offer type will filter on subscriptions that are currently in Free Trial, and not necessarily those that started with a free trial.
> - "New" and "Churn" figures also account for subscriptions that had a plan change, as a plan change creates a new subscription in Purchasely. A plan change will count as +1 in "new" and +1 in "churn" values.

<br />

- **Daily/weekly/monthly refund rates**: the proportion of subscriptions initially taken that were refunded. The date displayed is the date the subscription started not the day of the refund. That means you should expect past days to change.

<br />

## Revenues

This dashboard shows evolution of the revenue per platform / country or Plan

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/d8b61293506af65727dced6e08c15615100196183e446b12e15b2c0c96d28c5d-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


The amount displayed on top of the charts represents the overall revenues generated for the entire visualization range.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/0b332c5e6d65bf4963d0548bb728814373e0be0afc231578cfe60a366a1b29b7-image.png",
        null,
        ""
      ],
      "align": "center",
      "sizing": "300px",
      "border": true
    }
  ]
}
[/block]