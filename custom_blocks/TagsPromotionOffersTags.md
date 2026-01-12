---
name: Tags - Promotional Offers Tags
---
<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th style={{ textAlign: "left" }}>
        Tag
      </th>

      <th style={{ textAlign: "left" }}>
        Usage
      </th>

      <th style={{ textAlign: "left" }}>
        Example
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td style={{ textAlign: "left" }}>
        `OFFER_PRICE`
      </td>

      <td style={{ textAlign: "left" }}>
        Offer price with period
      </td>

      <td style={{ textAlign: "left" }}>
        For a winback offer :

        * Don't miss the intro offer of **\{\{OFFER_PRICE}}** for the first week.
        * The output will be:  
          _Don't miss the intro offer of $0.99/week for the first week._
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `OFFER_AMOUNT`
      </td>

      <td style={{ textAlign: "left" }}>
        Offer price without period (e.g., $9.99).
      </td>

      <td style={{ textAlign: "left" }}>
        For a winback offer :

        * Don't miss the intro offer of **\{\{OFFER_AMOUNT}}** for the first month.
        * The output will be:  
          _Don't miss the intro offer of $5.99 for the first month._
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `OFFER_PERIOD`
      </td>

      <td style={{ textAlign: "left" }}>
        Billing period during offer
      </td>

      <td style={{ textAlign: "left" }}>
        For an extension of a free trial:

        * Don't miss the free trial for a **\{\{OFFER_PERIOD}}**.
        * The output will be:  
          _Don't miss the free trial for a week._
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `OFFER_DURATION`
      </td>

      <td style={{ textAlign: "left" }}>
        Total offer length
      </td>

      <td style={{ textAlign: "left" }}>
        For a winback:

        * Hurry up intro offer for **\{\{OFFER_AMOUNT}}**/ **\{\{OFFER_DURATION}}**.
        * The output will be:  
          _Hurry up intro offer for $0.99 / 1week._
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `OFFER_PRICE_COMPARISON`
      </td>

      <td style={{ textAlign: "left" }}>
        Displays the price difference between the discounted offer and the regular price of the plan for the higher duration.
      </td>

      <td style={{ textAlign: "left" }}>
        With:

        * offer price: $99.99/year
        * monthly: $9.99/month
          * *\{\{OFFER_PRICE_COMPARISON}}** will display $19.89
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `OFFER_DISCOUNT_PERCENTAGE`
      </td>

      <td style={{ textAlign: "left" }}>
        % discount of an Offer price vs Full price.

        * If only one Offering is selected, compares the discount percentage of the Offer (Introductory Offer or Promotional Offer) with the full price. 
        * If 2 different Offerings are selected, compares the discount percentage of the Offer (Introductory Offer or Promotional Offer) from the first Offering, with the full price of the second Offering
      </td>

      <td style={{ textAlign: "left" }}>
        With:

        * offer price: $99.99/year
        * monthly: $9.99/month
          * *\{\{OFFER_DISCOUNT_PERCENTAGE(plan1,plan2)}}** will display 17%
      </td>
    </tr>
  </tbody>
</Table>
