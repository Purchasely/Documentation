---
title: Analyzing and optimizing your Paywall conversion
excerpt: >-
  This section provides an outlook of how to leverage Purchasely Conversion
  Dashboard to optimize your paywall conversion
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Why optimizing your paywall conversion matters?

Optimizing your paywall conversion is crucial for a mobile subscription app as it directly impacts revenue generation and user retention. A well-designed paywall maximizes the number of free users who convert into paying customers, improving your app's profitability. By enhancing the user experience with clear value propositions and tailored offers, you reduce friction in the decision-making process. 

Additionally, understanding and refining your paywall allows you to target the right audience segments, driving sustainable growth. Ultimately, better conversion rates mean higher lifetime value and increased customer loyalty.

<br />

# How Purchasely can help you optimizing your paywall conversion?

Purchasely helps optimize your paywall conversion by offering a no-code platform that allows you to easily design, test, and personalize your in-app paywalls without needing developer resources. Its A/B testing capabilities let you experiment with different designs, pricing, and messaging to identify what drives the highest conversions. 

Purchasely supports dynamic pricing and localization, ensuring that you can tailor offers to different user segments. This flexibility helps boost conversions and revenue from mobile subscriptions.

Additionally, the [Conversion dashboard](dashboard-conversion) provides you with valuable insights on Paywalls views and conversions. It is a flexible toolbox including filters, group by and split by components that allow you to both understand your conversion from a global perspective (at the app level) and to narrow the view for a particular Paywall, Placement, Audience, Country etc...

<br />

<br />

# Analyzing and optimizing your conversion rate globally inside your app

## Measuring Screens viewed

To measure the global number of Screens viewed on a specific period, no filter are set in the top bar. You can adjust your visualization period

![](https://files.readme.io/03b86d71c66384536579b9eaf29371e4513f57569121c8182b647943de4daeb1-image.png)

The dashboard provides the following high level KPIs, matching the period and filter

![](https://files.readme.io/b2e7377d5347e8e4c9e116cb4f6f0b2540279567c0b51625bbaa9278dcfefe6f-image.png)

The number of Screens viewed corresponds to the bars of the chart and is associated to the left axis

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/5c1933c585d5c57469663dc5243a2296a0d4e5f47b3bc029c07f1a2813e8e0e2-image.png",
        null,
        "Screens viewed. The left Y-axis is the one to refer to"
      ],
      "align": "center",
      "border": true,
      "caption": "Screens viewed. The left Y-axis is the one to refer to"
    }
  ]
}
[/block]


<br />

> 📘 Average Screens viewed per User
> 
> This KPI is particularly useful to measure the commercial pressure to which your free users are exposed.  
> _It should be above 1 to make sure that at least every free user is exposed to a Paywall_

### Breaking down the Screens views by Screen

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/3dfca5b7be29ee6b565c3fccefd51d6c308b079d1b69886d9059656e618a3ca6-image.png",
        null,
        "Screens viewed grouped by Screens"
      ],
      "align": "center",
      "border": true,
      "caption": "Screens viewed grouped by Screens"
    }
  ]
}
[/block]


This view provides insights on the volumes of impressions for each Screen:

💡 Put your effort on optimizing the Screens that are the most viewed

💡 Don't spend too much time on Screen that are rarely displayed

<br />

### Breaking down the Screens views by Placement

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/5e19b937cceedcdf962fe9d69850ecb7373eaa4a99137b947df9e54cf7f8f66f-image.png",
        null,
        "Screens viewed grouped by Placement"
      ],
      "align": "center",
      "border": true,
      "caption": "Screens viewed grouped by Placement"
    }
  ]
}
[/block]


This view provides insights on the touch points (Placements) where users are exposed to a Paywall and the corresponding traffic for each Placement

💡 Focus on tailoring the messaging for the most displayed Placement

💡 On the other hand, avoid spending too much time on tailoring the messaging for the Placements that have few traffic.

### Breaking down the Screens views by Country

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/23ec80a43cceaf395e91b8d2398076bfee6a3349dfa6d7a2b99505111b42c5f3-image.png",
        null,
        "Screens viewed grouped by Country"
      ],
      "align": "center",
      "border": true,
      "caption": "Screens viewed grouped by Country"
    }
  ]
}
[/block]


This view provides insights on the origins of your users by countries:

💡 Use this chart to identify the countries with the best potential of optimization

💡 Tailor the user experience for these countries by [localizing your Screens](localization) and adjusting the pricing with [Price A/B tests](ab-tests)

<br />

### Breaking down the Screens views by Audience

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/440ffd9bf7e8dc478bd7b235478d0f9db20f55eb7086b6a3fca263804e77f9e2-image.png",
        null,
        "Screens viewed groupes by Audience"
      ],
      "align": "center",
      "border": true,
      "caption": "Screens viewed groupes by Audience"
    }
  ]
}
[/block]


If you have built Audiences, this view will allow you to assess how often your different Audiences are exposed to Paywalls:

💡 Use it to identify the most relevant Audiences and then dig deeper for these particular Audiences by setting a specific filter

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/0ed7cef5cae354a6783c34277f536de06fe92926dee3fb1104b2b005c0497895-image.png",
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

## Visualizing Unique Viewers

The other secondary metric proposed is the number of Unique Viewers.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/effbd25458370893d759835909fbac4826f9fa0eb08e403fdc72061049dc576d-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


The difference between Unique Viewers and Screens viewed is the following:

when a same User views X Screens Y times the same screen, it will be counted:

- X \* Y Screens viewed
- 1 single Unique viewer

Both Unique Viewers and Screens viewed are useful but for different purposes:

- **Screens viewed**: when you want to understand user behavior and engagement with your Screens over time. This metric is useful for assessing how often users are encountering paywalls or Screens and testing the effectiveness of different designs, pricing, and offers, especially when experimenting with A/B testing or multiple Screen variants.
- **Unique viewers**: This metric is valuable when you're interested in understanding how many distinct users are exposed to your Screens, which helps in measuring the broader effectiveness of Paywall or Screen exposure in driving Conversions across your User base.

As with Screens viewed, Unique Viewers can be broken down by the same dimensions, by grouping them:

- by Screens
- by Placement
- by Platform
- by Country
- by Audience
- by A/B test variant

<br />

> 🚧 Important Notice When Grouping Unique Viewers by Different Dimensions
> 
> Be cautious when grouping Unique Viewers by different dimensions, as the same user may be counted multiple times, with the uniqueness applying to each specific dimension. 
> 
> For example:
> 
> - If User A views both Screen 1 and Screen 2:
>   - Without grouping, User A will be counted only once.
>   - When grouping by screen, User A will be counted once for Screen 1 and once for Screen 2.
> 
> As a result, the total number of Unique Viewers without grouping will differ from the number of Unique Viewers when grouped by screen (or any other dimension). This is not a bug or a data discrepancy — different groups are simply not meant to be summed up.
> 
> Note that this does not apply to the total number of Screens Viewed, which can be summed across groups.

## Visualizing Conversion

Conversion corresponds to the secondary metrics and is visualized as a curve associated to the right axis. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/de5d4ccac8938e7c810c7ce6adee3325418c3d0e663e423a7210ef265a9cce23-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


For the secondary metrics, you can chose among:

- CVR to regular price or offer price (Conversion Rates)
- Number of conversions to regular price or offer price (absolute numbers)
- CTR (Click-Through Rate) on purchase button or number of taps on purchase button (absolute number)

<br />

### Measuring Conversion Rates (CVR)

Conversion Rates are the ratio between the number of Conversions and the number of Unique Viewers:

_CVR = # Conversions / # Unique Viewers_

It is often the case that a higher number of Paywalls views or Unique viewers is correlated to a lower Conversion Rate (in other words, when the blue bars increase, the conversion curve goes down).

When the CVR goes down while the number of Paywalls viewed or Unique Viewers goes up, it might mean that the paid User Acquisition has decreased in quality.

#### CVR to offer price

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/909ff337e8510284f1cfb4cd405513000736c5a68138b0f95b97c4d9afddacb4-image.png",
        null,
        "Conversion Rate to Offer price"
      ],
      "align": "center",
      "border": true,
      "caption": "Conversion Rate to Offer price"
    }
  ]
}
[/block]


This view provides insights on the proportion of your users which you've been able to convince to give a shot to and try your product for free.

The **CVR to Offer price** can be outlooked but it is not the main KPI to optimize as users in this stage do not generate substantial revenue yet (or no revenue at all if you are proposing a free trial).

#### CVR to regular price

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/dad2531ac6f537c03a6e56592627ecb46f4ec33cd4261363abe4610841b00620-image.png",
        null,
        "Conversion Rate to Regular price"
      ],
      "align": "center",
      "border": true,
      "caption": "Conversion Rate to Regular price"
    }
  ]
}
[/block]


This view provides insights on the proportion of your users which end up paying the regular price for your subscription.

The **CVR to Regular price** is the main monetization KPI that you should try to optimize.

#### Breaking down Conversion Rates by Plan

- [block:image]{"images":[{"image":["https://files.readme.io/450463d237cdfb5c802f3051275a36922e48c695a66a383bae97e077e94b5801-image.png",null,""],"align":"center","border":true}]}[/block]

  This view provides insights on the respective CVR for each Plan presented in your Paywalls.

#### Breaking down Conversion Rates by Placement

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/1e6d0be3ac3bda5ba765d15390eff5d827bb9bf69c2dc590f039692e14592998-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


This view provides insights on the CVR for each Placement

💡 Focus your efforts on improving the Placements which are the most viewed with the lower CVR for a bigger impact.

💡 Assess in parallel the CVR and the absolute number of Conversions for the different Placements

#### Breaking down Conversion Rates by Country

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/9d859e2008917f73f87273ac618fc344b968908cb5f7a6d6c47a0a46d18a67ab-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


This view provides insights on the CVR for each Country

💡 Focus your first efforts on improving it for the tier 1 countries (the ones with high volumes of Unique Viewers and high CVRs)

💡 Then tailor the Paywall copy or prices for Tier 2 countries (the ones with high volumes of Unique Viewers and low CVRs) by launching a set of Paywall experiments or A/B tests

#### Breaking down Conversion Rates by Platform

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/ee227cf0eefd6cfaec08ecbcf45369f5270bac5508fa69c2b9f8f73c7dc67856-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


This view provides insights on the CVR per Platform

💡 In most cases, iOS has a higher CVR because of iOS users generally have more financial means and a higher propensity to purchase compared to Android users

💡 Put more efforts on optimizing iOS CVR as you will get a better ROI on your actions

#### Breaking down Conversion Rates by Audience

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/a1402c61e9d629d0b4114ef9a4b0d21abbefe03ca23694dce03a02b25c46e3b7-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


This view provides insights on the CVR per Audience

💡 Tailor the copywriting of your Paywall specifically for each Audience

💡 Sell the value created by your app in a user centric manner rather than the features of the app

### Measuring the Number of Conversions

Numbers of Conversions are absolute numbers, as opposed to CVRs which are ratios. They are useful to measure the volume of Conversions absolutely, without taking the number of Screens viewed or Unique Viewers into consideration.

Contrary to CVRs, you should not observe the correlation where the Conversion go down when the Screens viewed go up. In most of the cases, Conversions (i.e.: the curves) should go up when Screens viewed or Unique Viewers (i.e.: the bars) go up.

#### Number of Conversions to offer price

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/6c3faa9e9b50c5e45d3bb57ef83cac3a14dbcacfc15e43156fcc6c1f622e4fdd-image.png",
        null,
        "Number of conversions to Offer price"
      ],
      "align": "center",
      "border": true,
      "caption": "Number of conversions to Offer price"
    }
  ]
}
[/block]


This view provides insights on the number of conversions to an Offer price. Users convert to Offer prices when they start an Introductory offer, redeem an Offer code or a Promotional Offer. 

This metrics is therefore useful both for Conversion Paywalls and Paywalls meant to retain or win-back Users by proposing Promotional Offers.

#### Number of Conversions to regular price

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/ba19d5f1f90a796b8e273f3bedbbc50cf1389377cf2ee23cec85ac3926e20bf8-image.png",
        null,
        "Number of conversions to Regular price"
      ],
      "align": "center",
      "border": true,
      "caption": "Number of conversions to Regular price"
    }
  ]
}
[/block]


This view provides insights on the number of conversion to the Regular price (users who pay their subscription without benefiting from any particular Offer). This happens in 3 cases:

- when users convert their Introductory Offer / Promotional Offer / Offer code, without cancelling their subscription
- when no Introductory Offer have been configured for the subscription
- when the user starts a new subscription and has already benefited from the Introductory Offer (for the same subscription or [another subscription within the same subscription group](understanding-subscription-groups-in-the-app-store))

Contrary to the CVR, it is an absolute number which is shown here, which means that it should not decrease when the number of Screens displays increases.

<br />

### Visualizing purchase intents

#### Click-Through Rates (CTR) on purchase buttons

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/112ecc2b48febda467e8054a2e02adb44651a38eb379d6acbc4aece95e6351aa-image.png",
        null,
        "CTR on purchase buttons"
      ],
      "align": "center",
      "border": true,
      "caption": "CTR on purchase buttons"
    }
  ]
}
[/block]


This view allows you to assess how the proportion of unique viewers who have engaged with your Paywalls with the intent to make a purchase.

Surprisingly, there is an important drop-off between the intent and the finalization of the purchase which can go up to 85%.

#### Number of taps on a purchase button

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/82406a2d9d64758699560a99ec7cceb13a7499beecfa492a3e1aade3ae394ea0-image.png",
        null,
        "Number of taps on a purchase button"
      ],
      "align": "center",
      "border": true,
      "caption": "Number of taps on a purchase button"
    }
  ]
}
[/block]


This view allows you to assess how many unique users have engaged with your Paywalls with the intent to make a purchase.

This view can help you assess the potential of creating an automation equivalent to the "abandoned cart" in eCommerce.

# Analyzing and optimizing the Conversion for a specific Paywall, Placement, Audience, Platform

To narrow the data visualized in the chart for a particular Screen or Placement, you can use the filters on top of the screens.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/35011c9e47e1aae3d52d7d37849939134616b597a66488f71849a66b00938ee4-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Different filters can be combined together. 

# Comparing the Conversion for the different variants of an A/B Test

If you want to compare the performance of a specific A/B test, follow these instructions:

1. Set a filter for the desired A/B test

   [block:image]{"images":[{"image":["https://files.readme.io/ad0ba24151dc9fb787ff2e29ae50212ea033b7f826b8f140863ecff60db0b36c-image.png",null,"Tick the parent checkbox (the A/B test itself) which includes the 2 variants"],"align":"center","border":true,"caption":"Tick the parent checkbox (the A/B test itself) which includes the 2 variants"}]}[/block]
2. Group the primary metric (unique viewers) by A/B test variant
3. Split the secondary metrics by A/B test variant

You can now compare the 2 variants by period (day / week or month)

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/bae3db648e11c2ade761be3f8db3c6dfcceecc2855fb9641e4599fab132815a9-image.png",
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

# Optimizing the Conversion locally for a specific Country

You can identify your top countries by grouping the unique viewers by country and splitting the conversions by country too.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/d08662f69330689fcdbd302d8cba08d90a405bc9baebce18a84bc315a381517c-image.png",
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

Once you've identified which countries are worth optimizing, you can deepen your analysis for a particular country or set of countries, by setting the corresponding filter.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/6ed6372870d382efd26c2470318690da034f5464078253d42a463eed4a5924fd-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


All the data will then be filtered for this particular country / set of countries.