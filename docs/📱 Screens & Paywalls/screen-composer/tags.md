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

> 📘 You should be transparent about the plan price in your Paywalls. If you have any introductory offer or promotional offer, you should mention how much the user will pay after the offer ended.

## Where can you use tags?

Tags can be used in any label on a Screen. You can add them by simply clicking on the `{{TAGS}}` inside the text field. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/1a358a8da1b12806e775d9a6030a7bdbe95a4c8076d0fc112c949c888315daf1-tags.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


You can also directly type them in plain text. To do so, put the name of the tag between 2 pairs of curly brackets. Eg: `{{PRICE}}`

<br />

## What are the options when using tags?

You can use 2 types of tags.

- Tags with no parameters refer to the Plan directly mapped with the parent element (eg: the picker to which the text belongs or the purchase button) or to the default Plan configured for this Screen. To use this kind of tags, simply click on the blue button inside the widget.

  [block:image]{"images":[{"image":["https://files.readme.io/02cf5c8eb4587ec6d48d21004892ddafe625c941022de32d3ea266070cb96e89-tags_no_param.gif","",""],"align":"center"}]}[/block]

  => This way, if you change the Plan associated with the button / picker (or run an Price A/B test), you won't need to update the tag.
- Tags with parameters are mapped with a specific Plan. They appear with the reference of the Plan selected between brackets. If you want to use them, simply select the desired Plan in the widget. 

  [block:image]{"images":[{"image":["https://files.readme.io/e8418dc4efcb59916fd79b06f439868751db70af03bb0e5697b8f1dcb168a0ab-tags_parameters.gif","",""],"align":"center"}]}[/block]

  They can be used to reference another Plan in a picker or button than the one which it is mapped with, or to associate a Plan which is not the default one. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/3d21534-image.png",
        null,
        "The tag $59.99 references a different Plan than the one associated to the plan picker"
      ],
      "align": "center",
      "border": true,
      "caption": "The strikethrough price is a reference to another Plan than the one associated with the picker"
    }
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

# Types of tags

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
    "0-2": "For a renewing plan:  \n_  Subscription starting from **{{PRICE}}**._  \nThe output will be:  \n_  Subscription starting from $6.99/month._  \n  \nFor consumables / non-consumables :  \n_  Enjoy a lifetime plan at **{{PRICE}}**._  \nThe output will be:  \n_  Enjoy a lifetime at $83.99._",
    "1-0": "`AMOUNT`",
    "1-1": "Displays the plan price.",
    "1-2": "For a renewing plan:  \n  _Subscription starting from **{{AMOUNT}}**_  \n  \nThe output will be:  \n  _Subscription starting from $6.99._  \n  \nFor consumables / non-consumables :  \n  _Enjoy a lifetime plan at **{{AMOUNT}}**._  \n  \nThe output will be:  \n  _Enjoy a lifetime plan at $83.99._",
    "2-0": "`PERIOD`",
    "2-1": "Displays the period of the plan.",
    "2-2": "For a renewing plan:  \n_  Subscription starting from **{{AMOUNT}}/{{PERIOD}}**._  \n  \nThe output will be:  \n_  Subscription starting from $6.99/month._",
    "3-0": "`DURATION`",
    "3-1": "Displays the duration of the plan.",
    "3-2": "For a renewing plan:  \n  _Subscription starting from **{{AMOUNT}}** for **{{DURATION}}**.  \n_  \nThe output will be:  \n_  Subscription starting from $6.99 for 1 month._"
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
    "0-2": "For a renewing plan:  \n_  Subscription starting from **{{PRICE}}** is **{{DAILY_AMOUNT}}**/day during **{{DAYS_DURATION}}**.  \n_  \nThe output will be:  \n_  Subscription starting from $6.99/week is $0.99/day only during 7 days._",
    "1-0": "`WEEKS_DURATION`",
    "1-1": "Displays the subscription duration in weeks.",
    "1-2": "For a renewing plan:  \n_Subscription starting from **{{PRICE}}** is **{{WEEKLY_AMOUNT}}**/week during **{{WEEKS_DURATION}}**.  \n_  \nThe output will be:  \n_  Subscription starting from $6.99/month is $1.75/week during 4 weeks._",
    "2-0": "`MONTHS_DURATION`",
    "2-1": "Displays the subscription duration in months.",
    "2-2": "For a renewing plan:  \n_  Subscription starting from **{{PRICE}}** is **{{MONTHLY_AMOUNT}}**/month during **{{MONTHS_DURATION}}**.  \n_  \nThe output will be:  \n_  Subscription starting from $24.99/year is $2.08/month only during 12 months._",
    "3-0": "`QUARTERS_DURATION`",
    "3-1": "Displays the subscription duration in quarters.",
    "3-2": "For a renewing plan:  \n_  Subscription starting from **{{PRICE}}** is **{{QUARTERLY_AMOUNT}}**/quarter during **{{QUARTERS_DURATION}}**._  \n  \nThe output will be:  \n_  Subscription starting from 24€99/year is $6.24/quarter only during 4 quarters._",
    "4-0": "`YEARS_DURATION`",
    "4-1": "Displays the subscription duration in years.  \nIf the subscription is less than a year, the output will be 0.",
    "4-2": "For a renewing plan:  \n_  Subscription starting from **{{PRICE}}** is **{{YEARLY_AMOUNT}}**/year for **{{YEARS_DURATION}}**._  \n  \nThe output will be:  \n_  Subscription starting from $119.99/year is $119.99/year only for 1 year._"
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
    "0-2": "For a renewing plan:  \n_  Subscription costs **{{DAILY_AMOUNT}}** only per day.  \n_  \nThe output will be:  \n_  Subscription costs $0.49 only per day._",
    "1-0": "`WEEKLY_AMOUNT`",
    "1-1": "Displays the cost of a plan per week.",
    "1-2": "For a renewing plan:  \n_  Subscription costs **{{WEEKLY_AMOUNT}}** only per week._  \n  \nThe output will be:  \n_  Subscription that costs $2.78 only per week._",
    "2-0": "`MONTHLY_AMOUNT`",
    "2-1": "Displays the cost of a plan per month.",
    "2-2": "For a renewing plan:  \n_  Subscription costs **{{MONTHLY_AMOUNT}} **only per month.  \n_  \nThe output will be:  \n_  Subscription costs $6.99 only per month._",
    "3-0": "`QUARTERLY_AMOUNT`",
    "3-1": "Displays the cost of a plan per quarter.",
    "3-2": "For a renewing plan:  \n_  Subscription costs **{{QUARTERLY_AMOUNT}}** only per quarter._  \n  \nThe output will be:  \n_  Subscription costs $18.99 only per quarter._",
    "4-0": "`YEARLY_AMOUNT`",
    "4-1": "Displays the cost of a plan per year.",
    "4-2": "For a renewing plan:  \n_  Subscription costs **{{YEARLY_AMOUNT}}** only per year.  \n_  \nThe output will be:  \n_  Subscription costs $25.99 only per year._",
    "5-0": "`OFFER_DAILY_AMOUNT`",
    "5-1": "Displays the cost of the Introductory Offer or Promotional Offer of a Plan per day.",
    "5-2": "For a renewing plan:  \n_  Special offer: **{{OFFER_DAILY_AMOUNT}}** only per day.  \n_  \nThe output will be:  \n_  Special offer: $0.49 only per day._",
    "6-0": "`OFFER_WEEKLY_AMOUNT`",
    "6-1": "Displays the cost of the Introductory Offer or Promotional Offer of a Plan per week.",
    "6-2": "For a renewing plan:  \n_  Subscription costs **{{OFFER_WEEKLY_AMOUNT}}** only per week._  \n  \nThe output will be:  \n_  Subscription that costs $2.78 only per week._",
    "7-0": "`OFFER_MONTHLY_AMOUNT`",
    "7-1": "Displays the cost of the Introductory Offer or Promotional Offer of a Plan per month.",
    "7-2": "For a renewing plan:  \n_  Subscription costs **{{OFFER_MONTHLY_AMOUNT}}**only per month.  \n_  \nThe output will be:  \n_  Subscription costs $6.99 only per month._",
    "8-0": "`OFFER_QUARTERLY_AMOUNT`",
    "8-1": "Displays the cost of the Introductory Offer or Promotional Offer of a Plan per quarter.",
    "8-2": "For a renewing plan:  \n_  Subscription costs **{{OFFER_QUARTERLY_AMOUNT}}** only per quarter._  \n  \nThe output will be:  \n_  Subscription costs $18.99 only per quarter._",
    "9-0": "`OFFER_YEARLY_AMOUNT`",
    "9-1": "Displays the cost of the Introductory Offer or Promotional Offer of a Plan per year.",
    "9-2": "For a renewing plan:  \n_  Subscription costs **{{OFFER_YEARLY_AMOUNT}}** only per year.  \n_  \nThe output will be:  \n_  Subscription costs $25.99 only per year._"
  },
  "cols": 3,
  "rows": 10,
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
    "0-2": "With:  \n  \n- yearly: $99.99/year\n- monthly: $9.99/month  \n  _  \n   **{{PERCENTAGE_COMPARISON(YEARLY,MONTHLY)}}** will display 17%  \n    **{{PERCENTAGE_COMPARISON(MONTHLY,YEARLY)}}** will display 20%_",
    "1-0": "`DISCOUNT_PERCENTAGE`",
    "1-1": "Displays the discount percentage between the actual plan in the purchase button and the plan chosen.  \nThe order in which the plans are selected does not matter.",
    "1-2": "With:  \n  \n- yearly: $99.99/year\n- monthly: $9.99/month  \n  _  \n  **{{DISCOUNT_PERCENTAGE(YEARLY,MONTHLY)}}** will display 17%  \n  **{{DISCOUNT_PERCENTAGE(MONTHLY,YEARLY)}}** will display 17%_",
    "2-0": "`RAISE_PERCENTAGE`",
    "2-1": "Displays the raise of price in percentage between the actual plan in the purchase button and the plan chosen.  \nThe order in which the plans are selected does not matter.",
    "2-2": "With:  \n  \n- yearly: $99.99/year\n- monthly: $9.99/monthThe output will be:  \n  _  **{{RAISE_PERCENTAGE(YEARLY,MONTHLY)}}** will display 20%  \n    **{{RAISE_PERCENTAGE(MONTHLY,YEARLY)}}** will display 20%_",
    "3-0": "`PRICE_COMPARISON`",
    "3-1": "Displays the price difference between the plan in the purchase button and the plan chosen.  \nThe price difference is computed with the periodicity of the first plan selected.",
    "3-2": "With:  \n  \n- yearly: $99.99/year\n- monthly: $9.99/month\n\n  _The output will be:  \n  **{{PRICE_COMPARISON(YEARLY,MONTHLY)}}** will display $19.89  \n    => the monthly plan costs $19.89 more than the yearly plan on a yearly base  \n      **{{PRICE_COMPARISON(MONTHLY,YEARLY)}}** will display $1.66  \n    => the monthly plan costs $1.66 more than the yearly plan on a monthly base_"
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

## Countdown tag

These set of tags are very useful to create dynamic countdowns. You can integrate them in any label of your Screen. 3 different types of Timers are offered:

- [Relative countdown](#timer-relative)
- [Absolute countdown](#timer-absolute)
- [User countdown](#timer-user-countdown)

Timers are not only a simple tag but rather a _set of tags_ composed of different sub-tags (`TIMER(MONTHS)`, `TIMER(DAYS)`, `TIMER(MINUTES)`, `TIMER(SECONDS)`) that can be manipulated independently. 

Depending on the format you associate to the Tag, they will appear in the text field with the following format:

![](https://files.readme.io/fd75492fac841c3cab8c4e8944bd4b21ca81813e0fa640520a6645ada12e34d2-image.png)

They are actually a composition of several tags. In the case above:

- one for hours
- one for minutes
- one for seconds

By default, the tags are separated by colon (":"). You can replace the colons by any string you want directly in the text field:

![](https://files.readme.io/e64ffadbb3bef77f124e4b896f6349365761e55b1bd7d8d3d255c2c11c102801-image.png)

<br />

For more information and capabilities about Countdowns. have a look at the [Countdown component](countdown)