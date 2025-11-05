---
title: Understanding the Offer mode
excerpt: This article explains about how the offer mode works in the Screen composer
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Offer mode in Purchasely screen composer allows you to offer a special price or free trial to your users. This feature is perfect for new user acquisition, retention and winback an expired user. 

Purchasely helps you curate a paywall screen for users to whom you would like to give the offer or trial and also for users who are not eligible for the offer from one single screen. 

## How to customize a paywall for offer mode:

Once you have prepared a paywall for regular mode, you turn on the offer mode radio button on the top of the screen and customize each and every text element you have filled for the regular mode you can customize it for offer mode. 

<Image align="center" className="border" border={true} src="https://files.readme.io/f6fb5b7e2d3812d0e7e282c89635cf14bab293bb44bf898e5cd4fea955d2c5e6-Screen_Recording_2025-03-17_at_11.19.04.gif" />

### How to link different offers with your screens ?

For **[introductory offer(Apple App Store)](https://docs.purchasely.com/docs/app-store-configuring-in-app-subscriptions#adding-introductory-offers-and-free-trials)** or **[new user acquisition offer(Google Play Store)](https://docs.purchasely.com/docs/play-store-configuring-in-app-subscriptions#creating-offer-plans)**, once you have created the offer in the stores, using following tags you can display them in the paywall screens. 

For **[promotional offer(Apple App Store)](https://docs.purchasely.com/docs/promotional-offers-configuration#apple-promotional-offers)** or **[developer determined offer(Google Play Store)](https://docs.purchasely.com/docs/developer-determined-offers-configuration)**, once you have created the offer in the stores, [you have to add their id in the Purchasely](https://docs.purchasely.com/docs/promotional-offers-configuration#purchasely-console). Once done, you have to link the button or the picker with this offer.  To show the offer price, use the following tags

<br />

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Tag
      </th>

      <th>
        Usage
      </th>

      <th>
        Example
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        `OFFER_PRICE`
      </td>

      <td>
        Displays the winback offer price.
      </td>

      <td>
        For a winback offer :  

        * Don't miss the intro offer of **\{\{OFFER\_PRICE}}** for the first week.  
        * The output will be:\
          *Don't miss the intro offer of $0.99/week for the first week.*
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_AMOUNT`
      </td>

      <td>
        Displays the winback offer amount.
      </td>

      <td>
        For a winback offer :  

        * Don't miss the intro offer of **\{\{OFFER\_AMOUNT}}** for the first month.  
        * The output will be:\
          *Don't miss the intro offer of $5.99 for the first month.*
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_PERIOD`
      </td>

      <td>
        Displays the winback offer period.
      </td>

      <td>
        For an extension of a free trial:  

        * Don't miss the free trial for a **\{\{OFFER\_PERIOD}}**.  
        * The output will be:\
          *Don't miss the free trial for a week.*
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_DURATION`
      </td>

      <td>
        Displays the winback offer duration.
      </td>

      <td>
        For a winback:  

        * Hurry up intro offer for **\{\{OFFER\_AMOUNT}}**/ **\{\{OFFER\_DURATION}}**.  
        * The output will be:\
          *Hurry up intro offer for $0.99 / 1week.*
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_PRICE_COMPARISON`
      </td>

      <td>
        Displays the price difference between the discounted offer and the regular price of the plan for the higher duration.
      </td>

      <td>
        With:  

        * offer price: $99.99/year
        * monthly: $9.99/month  
          * \*\{\{OFFER\_PRICE\_COMPARISON}}\*\* will display $19.89
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_DISCOUNT_PERCENTAGE`
      </td>

      <td>
        Displays the discount percentage between the discounted offer and the regular price of the plan.
      </td>

      <td>
        With:  

        * offer price: $99.99/year
        * monthly: $9.99/month  
          * \*\{\{OFFER\_DISCOUNT\_PERCENTAGE}}\*\* will display 17%
      </td>
    </tr>
  </tbody>
</Table>

> 📘 Warning:
>
> If you have added a text in a offer mode, it should have its equivalent text in the regular mode. If not you will have an empty line in the paywall.
