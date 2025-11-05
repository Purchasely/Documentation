---
title: Tags
excerpt: >-
  This section provides details about the Price Tags available in the Screen &
  Paywall Builder
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# What are tag used for?

Purchasely has a tagging system to fetch information about the price and duration of subscriptions and one-time purchases, as well as the Introductory Offer (for user acquisition) and Promotional Offer (winback/retention) prices and durations. 

Thanks to these tags, you don't have to hard code price for each and every stores in your screens and paywalls. 

Using these tags will also ease to make your paywall compliant with the App Store Guidelines.

> 📘 You should be transparent about the plan price in your paywalls. If you have any introductory offer or promotional offer, you should mention how much the user will pay after the offer ended.

## Where can you use tags?

Tags can be used in any label on a Screen. You can add them by simply clicking on the `+ TAGS` below the input text.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/89a4eed-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


- When using them inside a button, we strongly advise you to map them with the Plan  associated with the button by choosing `Use button's plan`

  [block:image]{"images":[{"image":["https://files.readme.io/08764fe-image.png",null,""],"align":"center","border":true}]}[/block]

  => This way, if you change the Plan associated with the button / picker (or run an Price A/B test), you won't need to update the tag.

  - If you want to reference another Plan (e.g.:to show a strikethrough price) than the one associated with the button / picker, you can choose any other Plan configured in the Purchasely Console.

    [block:image]{"images":[{"image":["https://files.readme.io/3d21534-image.png",null,"The tag $59.99 references a different Plan than the one associated to the plan picker"],"align":"center","border":true,"caption":"The tag $59.99 references a different Plan than the one associated to the plan picker"}]}[/block]
- When using them outside of a button, you need to reference the associated Plan explicitly.

  [block:image]{"images":[{"image":["https://files.readme.io/386aba7-image.png",null,""],"align":"center","border":true}]}[/block]

<br />

## General tags:

These tags are most common tags that used in all the paywalls. Purchasely checks if your paywall has either the `PRICE` tag or `AMOUNT`/`DURATION` or `AMOUNT`/`PERIOD` tag in the purchase buttons. 

[block:parameters]
{
  "data": {
    "h-0": "Tag",
    "h-1": "Usage",
    "h-2": "Example",
    "0-0": "`PRICE`",
    "0-1": "Displays the plan price with the period.",
    "0-2": "For a renewing plan:  \n_  Subscription starting from **PRICE**._  \nThe output will be:  \n_  Subscription starting from $6.99/month._  \n  \nFor consumables / non-consumables :  \n_  Enjoy a lifetime plan at **PRICE**._  \nThe output will be:  \n_  Enjoy a lifetime at $83.99._",
    "1-0": "`AMOUNT`",
    "1-1": "Displays the plan price.",
    "1-2": "For a renewing plan:  \n  _Subscription starting from **AMOUNT**_  \n  \nThe output will be:  \n  _Subscription starting from $6.99._  \n  \nFor consumables / non-consumables :  \n  _Enjoy a lifetime plan at **AMOUNT**._  \n  \nThe output will be:  \n  _Enjoy a lifetime plan at $83.99._",
    "2-0": "`PERIOD`",
    "2-1": "Displays the period of the plan.",
    "2-2": "For a renewing plan:  \n_  Subscription starting from **AMOUNT/PERIOD**._  \n  \nThe output will be:  \n_  Subscription starting from $6.99 /month._",
    "3-0": "`DURATION`",
    "3-1": "Displays the duration of the plan.",
    "3-2": "For a renewing plan:  \n  _Subscription starting from **AMOUNT** for **DURATION**.  \n_  \nThe output will be:  \n_  Subscription starting from $6.99 for 1 month._"
  },
  "cols": 3,
  "rows": 4,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


<br />

> 🚧 Why does the preview display a `$XX.XX` instead of the actual price?
> 
> In some cases, tags cannot be displayed properly in the preview of the Console. They are replaced by XX.XX
> 
> The reason is that the Purchasely Console is not directly interfaced with the App stores. Therefore, it can only know the price of a SKUs in each territory once a transaction has been processed or observed by the Platform. 
> 
> As soon as it is the case, the XX.XX will be replace by the actual price in the appropriate currency. Eg: $9.99
> 
> Be reassured however, the SDK fetches the information directly from the App stores, and therefore always displays the correct price, in the appropriate currency (the one from the user's App store territory).

<br />

## Introductory offer tags

These tags displays the price and duration of the introductory offers or free trials you have created in the stores. 

<TagsIntroductoryOffersTags />

<br />

## Duration tags

These tags help you display the subscription duration in days, weeks , months and etc.

[block:parameters]
{
  "data": {
    "h-0": "Name",
    "h-1": "Usage",
    "h-2": "Example",
    "0-0": "`DAYS_DURATION`",
    "0-1": "Displays the subscription duration in days.",
    "0-2": "For a renewing plan:  \n_  Subscription starting from **PRICE** is **DAILY_AMOUNT**/day during **DAYS_DURATION**.  \n_  \nThe output will be:  \n_  Subscription starting from $6.99/week is $0.99/day only during 7 days._",
    "1-0": "`WEEKS_DURATION`",
    "1-1": "Displays the subscription duration in weeks.",
    "1-2": "For a renewing plan:  \n_Subscription starting from **PRICE** is **WEEKLY_AMOUNT**/week during **WEEKS_DURATION**.  \n_  \nThe output will be:  \n_  Subscription starting from $6.99/month is $1.75/week during 4 weeks._",
    "2-0": "`MONTHS_DURATION`",
    "2-1": "Displays the subscription duration in months.",
    "2-2": "For a renewing plan:  \n_  Subscription starting from **PRICE** is **MONTHLY_AMOUNT**/month during **MONTHS_DURATION**.  \n_  \nThe output will be:  \n_  Subscription starting from $24.99/year is $2.08/month only during 12 months._",
    "3-0": "`QUARTERS_DURATION`",
    "3-1": "Displays the subscription duration in quarters.",
    "3-2": "For a renewing plan:  \n_  Subscription starting from **PRICE** is **QUARTERLY_AMOUNT**/quarter during **QUARTERS_DURATION**._  \n  \nThe output will be:  \n_  Subscription starting from 24€99/year is $6.24/quarter only during 4 quarters._",
    "4-0": "`YEARS_DURATION`",
    "4-1": "Displays the subscription duration in years.  \nIf the subscription is less than a year, the output will be 0.",
    "4-2": "For a renewing plan:  \n_  Subscription starting from **PRICE** is **YEARLY_AMOUNT**/year for **YEARS_DURATION**._  \n  \nThe output will be:  \n_  Subscription starting from $119.99/year is $119.99/year only for 1 year._"
  },
  "cols": 3,
  "rows": 5,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


<br />

## Subscription cost per duration tags

These tags helps you to display subscription cost per day, week or month and etc. They are convenient to compare together several plans with different periodicities.  
_E.g.: compare the monthly price of a yearly subscription with a monthly subscription._

[block:parameters]
{
  "data": {
    "h-0": "Name",
    "h-1": "Usage",
    "h-2": "Example",
    "0-0": "`DAILY_AMOUNT`",
    "0-1": "Displays the cost of a plan per day.",
    "0-2": "For a renewing plan:  \n_  Subscription costs **DAILY_AMOUNT** only per day.  \n_  \nThe output will be:  \n_  Subscription costs $0.49 only per day._",
    "1-0": "`WEEKLY_AMOUNT`",
    "1-1": "Displays the cost of a plan per week.",
    "1-2": "For a renewing plan:  \n_  Subscription costs **WEEKLY_AMOUNT** only per week._  \n  \nThe output will be:  \n_  Subscription that costs $2.78 only per week._",
    "2-0": "`MONTHLY_AMOUNT`",
    "2-1": "Displays the cost of a plan per month.",
    "2-2": "For a renewing plan:  \n_  Subscription costs **MONTHLY_AMOUNT **only per month.  \n_  \nThe output will be:  \n_  Subscription costs $6.99 only per month._",
    "3-0": "`QUARTERLY_AMOUNT`",
    "3-1": "Displays the cost of a plan per quarter.",
    "3-2": "For a renewing plan:  \n_  Subscription costs **QUARTERLY_AMOUNT** only per quarter._  \n  \nThe output will be:  \n_  Subscription costs $18.99 only per quarter._",
    "4-0": "`YEARLY_AMOUNT`",
    "4-1": "Displays the cost of a plan per year.",
    "4-2": "For a renewing plan:  \n_  Subscription costs **YEARLY_AMOUNT** only per year.  \n_  \nThe output will be:  \n_  Subscription costs $25.99 only per year._"
  },
  "cols": 3,
  "rows": 5,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


<br />

## Price & Percentage comparison tags

These tags comes handy for your to calculate percentage difference and the price difference between 2 different plans and show them automatically in the respective currency. 

[block:parameters]
{
  "data": {
    "h-0": "Name",
    "h-1": "Usage",
    "h-2": "Example",
    "0-0": "`PERCENTAGE_COMPARISON`",
    "0-1": "Displays the percentage difference between the plan in the purchase button and the plan chosen.",
    "0-2": "With:  \n  \n- yearly: $99.99/year\n- monthly: $9.99/month  \n  _  \n  **PERCENTAGE_COMPARISON(YEARLY,MONTHLY)** will display 17%  \n  _  \n  **PERCENTAGE_COMPARISON(MONTHLY,YEARLY)** will display 20%",
    "1-0": "`DISCOUNT_PERCENTAGE`",
    "1-1": "Displays the discount percentage between the actual plan in the purchase button and the plan chosen.  \nThe order in which the plans are selected does not matter.",
    "1-2": "With:  \n  \n- yearly: $99.99/year\n- monthly: $9.99/month  \n  _  \n  **DISCOUNT_PERCENTAGE(YEARLY,MONTHLY)** will display 17%  \n  _  \n  **DISCOUNT_PERCENTAGE(MONTHLY,YEARLY)** will display 17%",
    "2-0": "`RAISE_PERCENTAGE`",
    "2-1": "Displays the raise of price in percentage between the actual plan in the purchase button and the plan chosen.  \nThe order in which the plans are selected does not matter.",
    "2-2": "With:  \n  \n- yearly: $99.99/year\n- monthly: $9.99/monthThe output will be:  \n  _  **RAISE_PERCENTAGE(YEARLY,MONTHLY)** will display 20%  \n    **RAISE_PERCENTAGE(MONTHLY,YEARLY)** will display 20%_",
    "3-0": "`PRICE_COMPARISON`",
    "3-1": "Displays the price difference between the plan in the purchase button and the plan chosen.  \nThe price difference is computed with the periodicity of the first plan selected.",
    "3-2": "With:  \n\\_- yearly: $99.99/year  \n  \n- monthly: $9.99/month  \n  _  \n  The output will be:  \n  _  **PRICE_COMPARISON(YEARLY,MONTHLY)** will display $19.89  \n    => the monthly plan costs $19.89 more than the yearly plan on a yearly base  \n      **PRICE_COMPARISON(MONTHLY,YEARLY)** will display $1.66  \n    => the monthly plan costs $1.66 more than the yearly plan on a monthly base\\_"
  },
  "cols": 3,
  "rows": 4,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


<br />

## Promotional offer tags

These tags displays the price and duration of the winback/retention offers you have created in the stores and in the Purchasely console. 

<TagsPromotionOffersTags />

## Timer tags

These set of tags are very useful to create dynamic countdowns. You can integrate them in any label of your Screen. 3 different types of Timers are offered:

- [Relative countdown](#timer-relative)
- [Absolute countdown](#timer-absolute)
- [User countdown](#timer-user-countdown)

Timers are not only a simple tag but rather a _set of tags_ composed of different sub-tags (`TIMER(MONTHS)`, `TIMER(DAYS)`, `TIMER(MINUTES)`, `TIMER(SECONDS)`) that can be manipulated independently. 

Depending on the format you associate to the Tag, they will appear in the text field with the following format:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/0541a1b-image.png",
        null,
        "Timer tags when the format D:hh:mm:ss has been selected"
      ],
      "align": "center",
      "border": true,
      "caption": "Timer tags when the format D:hh:mm:ss has been selected"
    }
  ]
}
[/block]


This allows you to keep only the desired tags or to insert static text in between:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/c2da2ac-image.png",
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

### **Timer (relative)**

This tag presents a relative timer indicating when the offer will expire. This timer resets each time the paywall is reopened. You can use this timer for limited offers. 

To use this tag, click on the tags and choose **Timer**

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/1938c1c-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Select the timer type as **relative**,

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/b86544e-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Fill in the count down in **seconds** and select the **format** you want to show it(M D hh mm ss .... etc) and click ok to set the timer. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/7b79a8a-image.png",
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

### **Timer (absolute)**

This tag presents an absolute timer for the offer expiration. This timer automatically calculates the remaining time left based on the countdown date set.

To use this tag, click on the tags and choose **Timer**

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/1938c1c-image.png",
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

Select the timer type as **absolute**

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/93e4a06-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Select the **count down end date**, the **timezone**,  and the **format** you want to show it(M D hh mm ss .... etc) and click ok to set the timer.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/6953663-image.png",
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

### **Timer (User countdown)**

This tag presents an user centric timer. This timer is set based on any date attribute related to the user and their subscription. Refer to all the date attributes [here](https://dash.readme.com/project/purchasely/v4.4.0/docs/user-attributes-list). You can also create a custom attribute and choose it to customize this timer.

<TagsTimerUserCountdown />

[More details on how to configure and leverage countdown to boost the conversion](timer-countdown)