---
title: Dashboard - Promotional Offers
excerpt: This page provides details on the Promotional Offers dashboard
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The Promotional Offers dashboard allows you to follow the evolution of the Promotional Offers Conversion Rate by Cohort.

<Image align="center" className="border" border={true} src="https://files.readme.io/76b0f4c33382edcc1d8d764e61fb7bc9ded40c876e9d2a6e584cd9574404d100-image.png" />

<br />

For each period within a range, you can visualize:

* the number of Promotional Offers that were started and converted - in green, left Y-axis
* the number of Promotional Offers that were started and not converted - in red, left Y-axis
* the Conversion Rate of your Promotional Offers, which is computed by cohort (based on the start period) - black curve, right Y-axis

There are several other colors displayed:

* blue: Promotional Offers still active (not converted yet) with the Subscription status `Auto-renewing`
* orange: Promotional offers still active (not converted yet) with the Subscription status `Auto-renewing disabled`
* light orange: Promotional Offers in Grace Period - they are unlikely to convert but can still convert if the billing issue is solved
* light red: Promotional Offers in billing retry (not active anymore) - they are unlikely to convert but can still convert if the billing issue is solved

As long as the Grace Period and Billing Retry period are not finished, the conversion rates can therefore slightly change recent periods.

> 🚧 The drop in conversion rate for the last cohort(s) is normal
>
> The conversion rate is computed with the following formula:
>
> `NUMBER OF PROMOTIONAL OFFERS CONVERTED / NUMBER OF PROMOTIONAL OFFERS STARTED`
>
> In other words, the numerator on relies on Promotional Offers that have been effectively Converted, which can only be sure once the Promotional Offer end date has been reached.
>
> This means that as long as there still are subscriptions with an ongoing Promotional Offer in the cohort, they are not counted in the numerator of the formula, which decreases the rate. 
>
> The conversion rate for a cohort becomes final once all the Promotional Offers outcome has been decided, therefore after the Promotional Offer duration + Billing retry duration (30 days on the Play Store, 60 days on the App Store).
