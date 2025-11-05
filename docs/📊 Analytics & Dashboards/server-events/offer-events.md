---
title: Offer Events
excerpt: ''
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Offer Events focus on the incentives associated with your subscriptions.

These events cover trials, introductory offers, promo codes, and promotional offers.

# ACTIVATION

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Event
      </th>

      <th>
        Description
      </th>

      <th>
        Useful to
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        `TRIAL_STARTED`
        `INTRO_OFFER_STARTED`
        `PROMO_CODE_STARTED`
      </td>

      <td>
        A free trial, an introductory offer or a promo code has started
      </td>

      <td>
        1. Engage user with the premium contents / features
        2. Build trust by reminding users when their introductory offer will end
      </td>
    </tr>

    <tr>
      <td>
        `TRIAL_CONVERTED`\
        `INTRO_OFFER_CONVERTED`\
        `PROMO_CODE_CONVERTED`
      </td>

      <td>
        The incentive has been converted to a regular price subscription
      </td>

      <td>
        1. Build trust by thanking the user for their loyalty
        2. Build trust by reminding the user when their current billing cycle will end
      </td>
    </tr>

    <tr>
      <td>
        `TRIAL_NOT_CONVERTED`\
        `INTRO_OFFER_NOT_CONVERTED`\
        `PROMO_CODE_NOT_CONVERTED`
      </td>

      <td>
        The incentive did not convert to a regular price subscription
      </td>

      <td>
        1. Send a survey to understand why they did not convert
        2. Offer a free trial extension to give a second chance to the user to try the premium membership
        3. Offer a promotion to try the premium membership for a discounted price
      </td>
    </tr>
  </tbody>
</Table>

<Image align="center" className="border" border={true} src="https://files.readme.io/26fb2f4d4bb54a8378c30b7b294919897904a4db3e90b800d3c27209201360b9-Capture_decran_2024-11-14_a_10.51.04.png" />

<br />

# RETENTION & WIN-BACK

| Event                             | Description                                                                                               | Useful to                                                                                                                                                                                                                                                                                       |
| :-------------------------------- | :-------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `PROMOTIONAL_OFFER_STARTED`       | A subscription has been renewed or reactivated with a promotional offer. The promotional offer is active. | 1. Build trust by thanking the user for their loyalty 2. Build trust by reminding users when their promotional offer will end                                                                                                                                                                   |
| `PROMOTIONAL_OFFER_CONVERTED`     | The promotional offer has been converted to a regular price subscription                                  | 1. Build trust by thanking the user for their loyalty 2. Build trust by reminding the user when their current billing cycle will end 3. Measure the number of conversions of promotional offers and compute the conversion rate (= `PROMOTIONAL_OFFER_CONVERTED` / `PROMOTIONAL_OFFER_STARTED`) |
| `PROMOTIONAL_OFFER_NOT_CONVERTED` | The promotional offer has not been converted and the subscription has been terminated                     | 1. Send a survey to understand why they did not convert                                                                                                                                                                                                                                         |
