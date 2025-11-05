---
name: Tags - Introductory Offers tags
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
        `TRIAL_PRICE`
      </td>

      <td style={{ textAlign: "left" }}>
        Displays the intro price or discounted price(that you have configured in Apple or Google store) of the plan.
      </td>

      <td style={{ textAlign: "left" }}>
        For a discounted trial:  

        * Don't miss the intro offer of **TRIAL\_PRICE** for the first week.  
        * The output will be:\
          *Don't miss the intro offer of $0.99/week for the first week.*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `TRIAL_AMOUNT`
      </td>

      <td style={{ textAlign: "left" }}>
        Displays the intro price or discounted price(that you have configured in Apple or Google store) of the plan.
      </td>

      <td style={{ textAlign: "left" }}>
        For a discounted trial:\
        *Don't miss the intro offer of**TRIAL\_AMOUNT** for the first month.*  

        The output will be:\
        *Don't miss the intro offer of $5.99 for the first month.*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `TRIAL_PERIOD`
      </td>

      <td style={{ textAlign: "left" }}>
        Displays the trial period or free trial (that you have configured in Apple or Google store) configured for the plan.
      </td>

      <td style={{ textAlign: "left" }}>
        For a free trial:  

        * Don't miss the free trial for a **TRIAL\_PERIOD**.  
        * The output will be:\
          *Don't miss the free trial for a week.*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `TRIAL_DURATION`
      </td>

      <td style={{ textAlign: "left" }}>
        Displays the trial period or free trial (that you have configured in Apple or Google store) configured for the plan.
      </td>

      <td style={{ textAlign: "left" }}>
        For a discounted trial:  

        * Hurry up intro offer for **TRIAL\_AMOUNT**/ **TRIAL\_DURATION**.  
        * The output will be:\
          *Hurry up intro offer for $0.99 / 1 week.*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `TRIAL_DAYS_DURATION`
      </td>

      <td style={{ textAlign: "left" }}>
        Displays the trial duration in the days count.
      </td>

      <td style={{ textAlign: "left" }}>
        For a free trial:  

        * Don't miss the free trial for **TRIAL\_DAYS\_DURATION**  
        * The output will be:\
          *Don't miss the free trial for 7 days*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `TRIAL_DISCOUNT_PERCENTAGE`
      </td>

      <td style={{ textAlign: "left" }}>
        Displays the discount percentage between the trial (free or paid) and the regular price of the plan for the period of the subscription.
      </td>

      <td style={{ textAlign: "left" }}>
        For a free trial or intro price:  

        * Don't miss this starting price with a discount of **TRIAL\_DISCOUNT\_PERCENTAGE**  
        * The output will be:\
          *Don't miss this starting price with a discount of 67%*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `TRIAL_PRICE_COMPARISON`
      </td>

      <td style={{ textAlign: "left" }}>
        Displays the price difference between the trial (free or paid) and the regular price of the plan for the period of the subscription.
      </td>

      <td style={{ textAlign: "left" }}>
        For a free trial or intro price:  

        * Don't miss this starting price with a discount of **TRIAL\_PRICE\_COMPARISON**  
        * The output will be:\
          *Don't miss this starting price with a discount of $24*
      </td>
    </tr>
  </tbody>
</Table>
