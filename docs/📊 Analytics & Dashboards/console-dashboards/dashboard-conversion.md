---
title: Dashboard - Conversion analysis
excerpt: This section provides details on the Conversion Dashboard
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    Want to dig deeper in how to use this dashboard to optimize your conversion?
    Click below 👇
  pages:
    - type: basic
      slug: optimizing-your-paywall-conversion
      title: Analyzing and optimizing your Paywall conversion
---
# Overview

[Purchasely’s Conversion Analysis](https://console.purchasely.io/dashboards/?tab=conversion) provides insights into the user purchase journey, allowing you to visualize and optimize conversion funnels. By offering customizable funnel analysis, advanced segmentation, and key performance metrics, this feature helps identify drop-off points and optimize the purchase process. It supports data-driven decision-making with actionable insights, enabling you to improve conversion rates for your Paywalls.

<Image align="center" className="border" border={true} src="https://files.readme.io/ba7fe14-image.png" />

<br />

The feature allows you to visualize on a single chart:

* bars which represent a Primary metric related to **Paywalls displayed**. 
* curves which represent a secondary metric related to **Conversion**. 

Visualizing these 2 metrics together on the same date allows you to see the potential correlations between the 2 metrics.

# Filters

On the top right of the Dashboard, you can leverage different filters, and define the period

<Image align="center" className="border" border={true} src="https://files.readme.io/90db201-image.png" />

The data displayed or visualize in the KPIs, chart and table below will be filtered accordingly.

Here are the filters available:

* **Paywalls**: filter the data for a specific Paywall or set of Paywalls.
* **Placements**:  filter the data for a specific Placement or set of Placements
* **Audiences**:  filter the data for a specific Audience or set of Audiences
* **A/B tests**:  filter the data for a specific A/B test, AB test variant or set of A/B tests or A/B test variants.
* **Countries**: filter the data for a specific country or set of countries.\
  The country used is the Store Country when available (SDK version >= 4.4.0) or IP Country if not.
* **Platforms**: filter the data for a specific Platform (iOS / Android)

<br />

You can also define the time unit (Daily / Weekly / Monthly) and the time range.

<Image align="center" className="border" border={true} src="https://files.readme.io/ef57117-image.png" />

<br />

If you don't set any filter, you'll rather have a global perspective on your users' behavior.

If you set filters for a particular **Paywall**, **Placement**, **Audience** or **Country**, you will rather have a detailed overview allowing you to optimize locally a particular Paywall, Placement, Audience or Country.

# Primary metric

The Primary metrics is related to Paywalls viewed. It leverages the [UI / SDK Event](ui-sdk-events-list) `PRESENTATION_VIEWED`.

You can choose among:

* **Paywalls viewed**- a same User who sees 2 different Paywalls or twice the same Paywall during a time unit (day/week/month) will be counted **twice**.
* **Unique viewers** - a same User who sees 2 different Paywalls or twice the same Paywall during a time unit (day/week/month) will be only counted **once**.

<Image align="center" className="border" border={true} src="https://files.readme.io/ea333ec-image.png" />

<br />

The Primary metrics corresponds to the units on the left axis.

<Image align="center" className="border" border={true} src="https://files.readme.io/ee39583-image.png" />

<br />

This Primary metrics can be grouped by different dimensions: **Audience** / **Country** / **Paywall** / **Placement** / **Platform**

<Image alt="Example of Paywalls viewed grouped by Country" align="center" border={true} src="https://files.readme.io/952de0b-image.png">
  Example of Paywalls viewed grouped by Country
</Image>

<Image alt="Example of Unique viewers grouped by Platform" align="center" border={true} src="https://files.readme.io/f32bb3e-image.png">
  Example of Unique viewers grouped by Platform
</Image>

<br />

Grouping the Primary metrics by a specific dimension allows you to visualize the share of each group. The top 10 groups are displayed in different colors and stacked together in the same bar.

# Secondary metrics

The secondary metric is related to Conversion. Conversion can be visualized as an absolute value or as a rate.

<Image align="center" className="border" border={true} src="https://files.readme.io/6edb478-image.png" />

<br />

The Secondary metrics corresponds to the units on the right axis.

<Image align="center" className="border" border={true} src="https://files.readme.io/bf0681b-image.png" />

<br />

It is computed by **cohort**: a conversion is attached back to the period (day / week / month depending on the periodicity defined in the filters) where the Paywall was last displayed to the user, not to the date to which the Conversion actually occurred.

*E.g.:*

* *a user views a Paywall on January 1st*
* *they click on the Purchase Button*
* *and start a 1 week free trial*
* *the free trial converts on January 8th*

*=> All the conversion metrics above will be attached to the cohort of January 1st because this is the time where the user lifecycle actually started.*

> 📘 Drop of the Conversion Rate to the Regular Offer for recent dates
>
> If your subscriptions start with an Introductory Offer, this means that for recent dates, the drop in Conversion rate to the Regular Offer is only due to the fact that some Users are still benefitting from their Introductory Offer and haven't reach the time where the Conversion to the Regular Offer actually happens. Nothing to worry about :)

<br />

The value for **Conversion Rates** is computed by Uniques viewers.

**Click Through Rate on Purchase Button** / **Taps on Purchase Button** leverage the [UI / SDK Event](ui-sdk-events-list) `PLAN_TAPPED`.

**Conversion Rate to Introductory or Promotional Offers** /  **Conversions to Introductory or Promotional Offers**leverage [Offer Events](offer-events):\
`# CONVERSIONS = # INTRO_OFFER_STARTED + # TRIAL_STARTED + # PROMOTIONAL_OFFER_STARTED` 

**Conversion Rate to Regular Offer** / **Conversions to Regular Offer** leverage [Offer Events](offer-events) and [Lifecycle Event](lifecycle-events):\
`# CONVERSIONS = # SUBSCRIPTION_STARTED + # INTRO_OFFER_CONVERTED + # TRIAL_CONVERTED + # PROMOTIONAL_OFFER_CONVERTED`

<br />

The secondary metric can be **split by** different dimensions: **Audience** / **Country** / **Paywall** / **Placement** / **Plan** / **Platform**. 

<Image alt="Example of conversions split by Plan" align="center" border={true} src="https://files.readme.io/7e705a0-image.png">
  Example of conversions split by Plan
</Image>

Splitting the Secondary metrics by a specific dimension allows you to visualize up to top 10 different series, each representing a different category of the select dimension. Only the 10 top categories are represented.

<br />

# Table & export

The table beneath the chart contains the raw and aggregated data for the Primary and Secondary metrics.

![](https://files.readme.io/dddf211-image.png)

When the Secondary metrics is split by a specific dimension, you can expand each line to get the conversion details for each category by clicking on the right arrow `>`

To download the full data in CSV, you can click on the `Download CSV` button

<Image align="center" className="border" border={true} src="https://files.readme.io/572eabe2e08f59fcfc93726da18ed0e8506fd7576ded6d40d3859e45954df070-image.png" />

The CSV will be generated server side and you will receive an email with 2 links to download the export when it's ready:

<Image align="center" className="border" width="250px" border={true} src="https://files.readme.io/547f500ce6939530d7f69c1d2e1197c0911693c36203e0ef702c2d12dac8448f-image.png" />

* The first CSV file contains the data about the Screens viewed
* The second CSV file contains the data about the Transactions
