---
title: Dashboard - Trials
excerpt: This page provides details on the Trials dashboard
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The Trials dashboard allows you to follow the evolution of the Introductory Offers Conversion Rate by Cohort.

<Image align="center" className="border" border={true} src="https://files.readme.io/49fb91b9f6da5c5ca66f6eb673956783714b92040082f86d5399defd1198b0b0-image.png" />

For each period within a range, you can visualize:

* the number of Introductory Offers that were started and converted - in green, left Y-axis
* the number of Introductory Offers that were started and not converted - in red, left Y-axis
* the Conversion Rate of your Introductory Offers, which is computed by cohort (based on the start period) - black curve, right Y-axis

<br />

The left chart displays Free trials, the right chart displays Paid trials. 

For the last periods, you will notice that several colors are displayed:

* blue: Introductory Offers still active (not converted yet) with the Subscription status `Auto-renewing`
* orange: Introductory offers still active (not converted yet) with the Subscription status `Auto-renewing disabled`
* light orange: Introductory Offers in Grace Period - they are unlikely to convert but can still convert if the billing issue is solved
* light red: Introductory Offers in billing retry (not active anymore) - they are unlikely to convert but can still convert if the billing issue is solved

<Image align="center" className="border" border={true} src="https://files.readme.io/eef4c4063189be48018eb2729619d4da8e137d4e8559917b7da39b39f80d9915-image.png" />

As long as the Grace Period and Billing Retry period are not finished, the conversion rates can therefore slightly change recent periods.

> 🚧 The drop in conversion rate for the last cohort(s) is normal
>
> The conversion rate is computed with the following formula:
>
> `NUMBER OF INTRODUCTORY OFFERS CONVERTED / NUMBER OF INTRODUCTORY OFFERS STARTED`
>
> In other words, the numerator on relies on Introductory Offers that have been effectively Converted, which can only be sure once the Introductory Offer end date has been reached.
>
> This means that as long as there still are subscriptions with an ongoing Introductory Offer in the cohort, they are not counted in the numerator of the formula, which decreases the rate. 
>
> The conversion rate for a cohort becomes final once all the Introductory Offers outcome has been decided, therefore after the Introductory Offer duration + Billing retry duration (30 days on the Play Store, 60 days on the App Store).
