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

<Image align="center" src="https://files.readme.io/1a358a8da1b12806e775d9a6030a7bdbe95a4c8076d0fc112c949c888315daf1-tags.gif" />

You can also directly type them in plain text. To do so, put the name of the tag between 2 pairs of curly brackets. Eg: `{{PRICE}}`

<br />

## What are the options when using tags?

You can use 2 types of tags.

* Tags with no parameters refer to the Plan directly mapped with the parent element (eg: the picker to which the text belongs or the purchase button) or to the default Plan configured for this Screen. To use this kind of tags, simply click on the blue button inside the widget.

  <Image align="center" src="https://files.readme.io/02cf5c8eb4587ec6d48d21004892ddafe625c941022de32d3ea266070cb96e89-tags_no_param.gif" />

  \=> This way, if you change the Plan associated with the button / picker (or run an Price A/B test), you won't need to update the tag.
* Tags with parameters are mapped with a specific Plan. They appear with the reference of the Plan selected between brackets. If you want to use them, simply select the desired Plan in the widget. 

  <Image align="center" src="https://files.readme.io/e8418dc4efcb59916fd79b06f439868751db70af03bb0e5697b8f1dcb168a0ab-tags_parameters.gif" />

  They can be used to reference another Plan in a picker or button than the one which it is mapped with, or to associate a Plan which is not the default one. 

<Image alt="The tag $59.99 references a different Plan than the one associated to the plan picker" align="center" border={true} src="https://files.readme.io/3d21534-image.png">
  The strikethrough price is a reference to another Plan than the one associated with the picker
</Image>

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
        `PRICE`
      </td>

      <td>
        Displays the plan price with the period.
      </td>

      <td>
        For a renewing plan:\
        *Subscription starting fro&#x6D;**\{\{PRICE}}**.*\
        The output will be:\
        *Subscription starting from $6.99/month.*  

        For consumables / non-consumables :\
        *Enjoy a lifetime plan a&#x74;**\{\{PRICE}}**.*\
        The output will be:\
        *Enjoy a lifetime at $83.99.*
      </td>
    </tr>

    <tr>
      <td>
        `AMOUNT`
      </td>

      <td>
        Displays the plan price.
      </td>

      <td>
        For a renewing plan:\
          *Subscription starting fro&#x6D;**\{\{AMOUNT}}***  

        The output will be:\
          *Subscription starting from $6.99.*  

        For consumables / non-consumables :\
          *Enjoy a lifetime plan a&#x74;**\{\{AMOUNT}}**.*  

        The output will be:\
          *Enjoy a lifetime plan at $83.99.*
      </td>
    </tr>

    <tr>
      <td>
        `PERIOD`
      </td>

      <td>
        Displays the period of the plan.
      </td>

      <td>
        For a renewing plan:\
        *Subscription starting fro&#x6D;**\{\{AMOUNT}}/\{\{PERIOD}}**.*  

        The output will be:\
        *Subscription starting from $6.99/month.*
      </td>
    </tr>

    <tr>
      <td>
        `DURATION`
      </td>

      <td>
        Displays the duration of the plan.
      </td>

      <td>
        For a renewing plan:  

        * Subscription starting from **\{\{AMOUNT}}** for **\{\{DURATION}}**.  
        * The output will be:\
          *Subscription starting from $6.99 for 1 month.*
      </td>
    </tr>
  </tbody>
</Table>

<br />

## Duration tags

These tags help you display the subscription duration in days, weeks , months and etc.

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Name
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
        `DAYS_DURATION`
      </td>

      <td>
        Displays the subscription duration in days.
      </td>

      <td>
        For a renewing plan:  

        * Subscription starting from **\{\{PRICE}}** is **\{\{DAILY\_AMOUNT}}**/day during **\{\{DAYS\_DURATION}}**.  
        * The output will be:\
          *Subscription starting from $6.99/week is $0.99/day only during 7 days.*
      </td>
    </tr>

    <tr>
      <td>
        `WEEKS_DURATION`
      </td>

      <td>
        Displays the subscription duration in weeks.
      </td>

      <td>
        For a renewing plan:  

        * Subscription starting from **\{\{PRICE}}** is **\{\{WEEKLY\_AMOUNT}}**/week during **\{\{WEEKS\_DURATION}}**.  
        * The output will be:\
          *Subscription starting from $6.99/month is $1.75/week during 4 weeks.*
      </td>
    </tr>

    <tr>
      <td>
        `MONTHS_DURATION`
      </td>

      <td>
        Displays the subscription duration in months.
      </td>

      <td>
        For a renewing plan:  

        * Subscription starting from **\{\{PRICE}}** is **\{\{MONTHLY\_AMOUNT}}**/month during **\{\{MONTHS\_DURATION}}**.  
        * The output will be:\
          *Subscription starting from $24.99/year is $2.08/month only during 12 months.*
      </td>
    </tr>

    <tr>
      <td>
        `QUARTERS_DURATION`
      </td>

      <td>
        Displays the subscription duration in quarters.
      </td>

      <td>
        For a renewing plan:\
        *Subscription starting fro&#x6D;**\{\{PRICE}}** is **\{\{QUARTERLY\_AMOUNT}}**/quarter during **\{\{QUARTERS\_DURATION}}**.*  

        The output will be:\
        *Subscription starting from 24€99/year is $6.24/quarter only during 4 quarters.*
      </td>
    </tr>

    <tr>
      <td>
        `YEARS_DURATION`
      </td>

      <td>
        Displays the subscription duration in years.\
        If the subscription is less than a year, the output will be 0.
      </td>

      <td>
        For a renewing plan:\
        *Subscription starting fro&#x6D;**\{\{PRICE}}** is **\{\{YEARLY\_AMOUNT}}**/year for **\{\{YEARS\_DURATION}}**.*  

        The output will be:\
        *Subscription starting from $119.99/year is $119.99/year only for 1 year.*
      </td>
    </tr>
  </tbody>
</Table>

<br />

## Subscription cost per duration tags

These tags helps you to display subscription cost per day, week or month and etc. They are convenient to compare together several plans with different periodicities.\
*E.g.: compare the monthly price of a yearly subscription with a monthly subscription.*

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Name
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
        `DAILY_AMOUNT`
      </td>

      <td>
        Displays the cost of a plan per day.
      </td>

      <td>
        For a renewing plan:  

        * Subscription costs **\{\{DAILY\_AMOUNT}}** only per day.  
        * The output will be:\
          *Subscription costs $0.49 only per day.*
      </td>
    </tr>

    <tr>
      <td>
        `WEEKLY_AMOUNT`
      </td>

      <td>
        Displays the cost of a plan per week.
      </td>

      <td>
        For a renewing plan:\
        *Subscription cost&#x73;**\{\{WEEKLY\_AMOUNT}}** only per week.*  

        The output will be:\
        *Subscription that costs $2.78 only per week.*
      </td>
    </tr>

    <tr>
      <td>
        `MONTHLY_AMOUNT`
      </td>

      <td>
        Displays the cost of a plan per month.
      </td>

      <td>
        For a renewing plan:  

        * Subscription costs **\{\{MONTHLY\_AMOUNT}}**&#x6F;nly per month.  
        * The output will be:\
          *Subscription costs $6.99 only per month.*
      </td>
    </tr>

    <tr>
      <td>
        `QUARTERLY_AMOUNT`
      </td>

      <td>
        Displays the cost of a plan per quarter.
      </td>

      <td>
        For a renewing plan:\
        *Subscription cost&#x73;**\{\{QUARTERLY\_AMOUNT}}** only per quarter.*  

        The output will be:\
        *Subscription costs $18.99 only per quarter.*
      </td>
    </tr>

    <tr>
      <td>
        `YEARLY_AMOUNT`
      </td>

      <td>
        Displays the cost of a plan per year.
      </td>

      <td>
        For a renewing plan:  

        * Subscription costs **\{\{YEARLY\_AMOUNT}}** only per year.  
        * The output will be:\
          *Subscription costs $25.99 only per year.*
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_DAILY_AMOUNT`
      </td>

      <td>
        Displays the cost of the Introductory Offer or Promotional Offer of a Plan per day.
      </td>

      <td>
        For a renewing plan:  

        * Special offer: **\{\{OFFER\_DAILY\_AMOUNT}}** only per day.  
        * The output will be:\
          *Special offer: $0.49 only per day.*
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_WEEKLY_AMOUNT`
      </td>

      <td>
        Displays the cost of the Introductory Offer or Promotional Offer of a Plan per week.
      </td>

      <td>
        For a renewing plan:\
        *Subscription cost&#x73;**\{\{OFFER\_WEEKLY\_AMOUNT}}** only per week.*  

        The output will be:\
        *Subscription that costs $2.78 only per week.*
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_MONTHLY_AMOUNT`
      </td>

      <td>
        Displays the cost of the Introductory Offer or Promotional Offer of a Plan per month.
      </td>

      <td>
        For a renewing plan:  

        * Subscription costs **\{\{OFFER\_MONTHLY\_AMOUNT}}**&#x6F;nly per month.  
        * The output will be:\
          *Subscription costs $6.99 only per month.*
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_QUARTERLY_AMOUNT`
      </td>

      <td>
        Displays the cost of the Introductory Offer or Promotional Offer of a Plan per quarter.
      </td>

      <td>
        For a renewing plan:\
        *Subscription cost&#x73;**\{\{OFFER\_QUARTERLY\_AMOUNT}}** only per quarter.*  

        The output will be:\
        *Subscription costs $18.99 only per quarter.*
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_YEARLY_AMOUNT`
      </td>

      <td>
        Displays the cost of the Introductory Offer or Promotional Offer of a Plan per year.
      </td>

      <td>
        For a renewing plan:  

        * Subscription costs **\{\{OFFER\_YEARLY\_AMOUNT}}** only per year.  
        * The output will be:\
          *Subscription costs $25.99 only per year.*
      </td>
    </tr>
  </tbody>
</Table>

<br />

## Price & Percentage comparison tags

These tags comes handy for your to calculate percentage difference and the price difference between 2 different plans and show them automatically in the respective currency. 

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Name
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
        `PERCENTAGE_COMPARISON`
      </td>

      <td>
        Displays the percentage difference between the plan in the purchase button and the plan chosen.
      </td>

      <td>
        With:  

        * yearly: $99.99/year
        * monthly: $9.99/month  
          * **\{\{PERCENTAGE\_COMPARISON(YEARLY,MONTHLY)}}** will display 17%  
            * \*\{\{PERCENTAGE*COMPARISON(MONTHLY,YEARLY)}}\*\* will display 20%*
      </td>
    </tr>

    <tr>
      <td>
        `DISCOUNT_PERCENTAGE`
      </td>

      <td>
        Displays the discount percentage between the actual plan in the purchase button and the plan chosen.\
        The order in which the plans are selected does not matter.
      </td>

      <td>
        With:  

        * yearly: $99.99/year
        * monthly: $9.99/month  
          * **\{\{DISCOUNT\_PERCENTAGE(YEARLY,MONTHLY)}}** will display 17%  
          * \*\{\{DISCOUNT*PERCENTAGE(MONTHLY,YEARLY)}}\*\* will display 17%*
      </td>
    </tr>

    <tr>
      <td>
        `RAISE_PERCENTAGE`
      </td>

      <td>
        Displays the raise of price in percentage between the actual plan in the purchase button and the plan chosen.\
        The order in which the plans are selected does not matter.
      </td>

      <td>
        With:  

        * yearly: $99.99/year
        * monthly: $9.99/monthThe output will be:  
          * **\{\{RAISE\_PERCENTAGE(YEARLY,MONTHLY)}}** will display 20%  
            * \*\{\{RAISE*PERCENTAGE(MONTHLY,YEARLY)}}\*\* will display 20%*
      </td>
    </tr>

    <tr>
      <td>
        `PRICE_COMPARISON`
      </td>

      <td>
        Displays the price difference between the plan in the purchase button and the plan chosen.\
        The price difference is computed with the periodicity of the first plan selected.
      </td>

      <td>
        With:  

        * yearly: $99.99/year
        * monthly: $9.99/month

          * The output will be:  
          * \*\{\{PRICE\_COMPARISON(YEARLY,MONTHLY)}}\*\* will display $19.89\
            \=> the monthly plan costs $19.89 more than the yearly plan on a yearly base  
            * \*\{\{PRICE*COMPARISON(MONTHLY,YEARLY)}}\*\* will display $1.66\
              \=> the monthly plan costs $1.66 more than the yearly plan on a monthly base*
      </td>
    </tr>
  </tbody>
</Table>

<br />

## Offer tags

These tags can be used to display the price and duration of the both introductory/new user acquisition offers and Winback/retention offers you have created in the stores and declared in the Purchasely console. 

<TagsPromotionOffersTags />

## Countdown tag

These set of tags are very useful to create dynamic countdowns. You can integrate them in any label of your Screen. 3 different types of Timers are offered:

* [Relative countdown](#timer-relative)
* [Absolute countdown](#timer-absolute)
* [User countdown](#timer-user-countdown)

Timers are not only a simple tag but rather a *set of tags* composed of different sub-tags (`TIMER(MONTHS)`, `TIMER(DAYS)`, `TIMER(MINUTES)`, `TIMER(SECONDS)`) that can be manipulated independently. 

Depending on the format you associate to the Tag, they will appear in the text field with the following format:

<Image align="center" className="border" border={true} src="https://files.readme.io/fd75492fac841c3cab8c4e8944bd4b21ca81813e0fa640520a6645ada12e34d2-image.png" />

They are actually a composition of several tags. In the case above:

* one for hours
* one for minutes
* one for seconds

By default, the tags are separated by colon (":"). You can replace the colons by any string you want directly in the text field:

<Image align="center" className="border" border={true} src="https://files.readme.io/e64ffadbb3bef77f124e4b896f6349365761e55b1bd7d8d3d255c2c11c102801-image.png" />

<br />

For more information and capabilities about Countdowns. have a look at the [Countdown component](countdown)
