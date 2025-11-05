---
title: Offer Events
excerpt: ''
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Offer Events focus on the incentives associated with your subscriptions.

These events cover trials, introductory offers, promo codes, and promotional offers.

# ACTIVATION

[block:parameters]
{
  "data": {
    "h-0": "Event",
    "h-1": "Description",
    "h-2": "Useful to",
    "0-0": "`TRIAL_STARTED`  \n`INTRO_OFFER_STARTED`  \n`PROMO_CODE_STARTED`",
    "0-1": "A free trial, an introductory offer or a promo code has started",
    "0-2": "1. Engage user with the premium contents / features\n2. Build trust by reminding users when their introductory offer will end",
    "1-0": "`TRIAL_CONVERTED`  \n`INTRO_OFFER_CONVERTED`  \n`PROMO_CODE_CONVERTED`",
    "1-1": "The incentive has been converted to a regular price subscription",
    "1-2": "1. Build trust by thanking the user for their loyalty\n2. Build trust by reminding the user when their current billing cycle will end",
    "2-0": "`TRIAL_NOT_CONVERTED`  \n`INTRO_OFFER_NOT_CONVERTED`  \n`PROMO_CODE_NOT_CONVERTED`",
    "2-1": "The incentive did not convert to a regular price subscription",
    "2-2": "1. Send a survey to understand why they did not convert\n2. Offer a free trial extension to give a second chance to the user to try the premium membership\n3. Offer a promotion to try the premium membership for a discounted price"
  },
  "cols": 3,
  "rows": 3,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/26fb2f4d4bb54a8378c30b7b294919897904a4db3e90b800d3c27209201360b9-Capture_decran_2024-11-14_a_10.51.04.png",
        null,
        null
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

# RETENTION & WIN-BACK

| Event                             | Description                                                                                               | Useful to                                                                                                                                                                                                                                                                                       |
| :-------------------------------- | :-------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `PROMOTIONAL_OFFER_STARTED`       | A subscription has been renewed or reactivated with a promotional offer. The promotional offer is active. | 1. Build trust by thanking the user for their loyalty 2. Build trust by reminding users when their promotional offer will end                                                                                                                                                                   |
| `PROMOTIONAL_OFFER_CONVERTED`     | The promotional offer has been converted to a regular price subscription                                  | 1. Build trust by thanking the user for their loyalty 2. Build trust by reminding the user when their current billing cycle will end 3. Measure the number of conversions of promotional offers and compute the conversion rate (= `PROMOTIONAL_OFFER_CONVERTED` / `PROMOTIONAL_OFFER_STARTED`) |
| `PROMOTIONAL_OFFER_NOT_CONVERTED` | The promotional offer has not been converted and the subscription has been terminated                     | 1. Send a survey to understand why they did not convert                                                                                                                                                                                                                                         |