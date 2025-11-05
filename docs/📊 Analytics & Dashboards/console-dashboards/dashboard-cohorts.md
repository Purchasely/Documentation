---
title: Dashboard - Cohorts
excerpt: This page provides details on the Cohorts Dashboard
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Cohorts help you see retention over time by cohorts of subscribers, depending on when their subscription started. This view is particularly useful when trying to assess the efficiency of the paid acquisition campaigns.

The first two columns show the period (month, week, day) and the total number of subscribers who started their subscription during that period.

The following columns show the number of percentage (rate) or absolute number (number) who were still active.

![](https://files.readme.io/8f247b178462f25b7c72289cc3198f95ad4fb22c9330a6f356f33c8816cbae29-image.png)

The graph above must be read as follows:

* For the cohort of March 2024, 
  * 1129 new subscriptions were started. 
  * At the end of the month (+0 MONTH), 98,23% of them were still active\
    (the slight difference with 100% corresponds to the subscriptions that were refunded).
  * The following month (+1 MONTH), 88,22% of this cohort of subscriptions were still active
  * The following one (+2 MONTH), they were 82,64%  still active 
  * etc...

<br />

You can switch between rates and numbers using the drop down list in the upper right corner

<Image align="center" className="border" width="300px" border={true} src="https://files.readme.io/379f8ae70a17ec04a6959cfbabbd8c19d3fb1fb3bb0f06cc7afcd37bf8c60d76-image.png" />

> 🚧 Analyze subscription
>
> To avoid bias in interpreting the numbers, you should analyze subscriptions with the same periodicity, by using the Periodicity filter.
>
> <Image align="center" className="border" border={true} src="https://files.readme.io/04bc3589b982cc30eac7d0ca1c22ccfa72d6d41588093c954b016e65920262af-image.png" />
>
> For instance, yearly subscriptions have by design a very good retention over the 12 first months and therefore contribute to increase the rates displayed.

<br />

> 🚧 Be cautious with the past cohorts prior to the implementation of Purchasely
>
> Don't look back in the history (prior to implementing Purchasely as it is strongly biased! The reason is the following:
>
> * When you start working with Purchasely, your active subscribers are [imported into the platform (either manually or automatically)](subscribers-base-import).
> * Only the subscribers that were still active when you started working with Purchasely are imported.
> * As a result, for past cohorts, the retention rates are much higher than the reality because the Purchasely platform is blind on all the lapsed subscribers which belong to this past cohorts.
> * Therefore it displays rates close to 100%
>
>   <Image align="center" className="border" border={true} src="https://files.readme.io/08d23fc4fe0d591a8e71a227fb870f313347e6dca9cccef22b1adf3bf1161dc7-image.png" />
>
>   <br />
>
> There is unfortunately nothing we can do about it, as the stores do not provide any API to get lapsed subscriptions data. 
>
> The bias disappears progressively over time after the Purchasely integration with the adoption of the app version which include the Purchasely SDK.
