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
        Displays the winback offer price.
      </td>

      <td style={{ textAlign: "left" }}>
        For a winback offer :  

        * Don't miss the intro offer of **OFFER\_PRICE** for the first week.  
        * The output will be:\
          *Don't miss the intro offer of $0.99/week for the first week.*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `OFFER_AMOUNT`
      </td>

      <td style={{ textAlign: "left" }}>
        Displays the winback offer amount.
      </td>

      <td style={{ textAlign: "left" }}>
        For a winback offer :  

        * Don't miss the intro offer of **OFFER\_AMOUNT** for the first month.  
        * The output will be:\
          *Don't miss the intro offer of $5.99 for the first month.*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `OFFER_PERIOD`
      </td>

      <td style={{ textAlign: "left" }}>
        Displays the winback offer period.
      </td>

      <td style={{ textAlign: "left" }}>
        For an extension of a free trial:  

        * Don't miss the free trial for a **OFFER\_PERIOD**.  
        * The output will be:\
          *Don't miss the free trial for a week.*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `OFFER_DURATION`
      </td>

      <td style={{ textAlign: "left" }}>
        Displays the winback offer duration.
      </td>

      <td style={{ textAlign: "left" }}>
        For a winback:  

        * Hurry up intro offer for **OFFER\_AMOUNT**/ **OFFER\_DURATION**.  
        * The output will be:\
          *Hurry up intro offer for $0.99 / 1week.*
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
          * \*OFFER\_PRICE\_COMPARISON\*\* will display $19.89
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `OFFER_DISCOUNT_PERCENTAGE`
      </td>

      <td style={{ textAlign: "left" }}>
        Displays the discount percentage between the discounted offer and the regular price of the plan.
      </td>

      <td style={{ textAlign: "left" }}>
        With:  

        * offer price: $99.99/year
        * monthly: $9.99/month  
          * \*OFFER\_DISCOUNT\_PERCENTAGE\*\* will display 17%
      </td>
    </tr>
  </tbody>
</Table>
