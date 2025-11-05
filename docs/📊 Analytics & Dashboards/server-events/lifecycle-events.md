---
title: Lifecycle Events
excerpt: >-
  This section provides details on Lifecycle events and the sequence in which
  they occur
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Lifecycle Events focus on the various stages and actions within the subscription lifecycle.

These events include purchases, renewals, payment issues, and other key milestones that define the journey of a subscription or an In-App Purchase.

They provide a comprehensive view of a subscriber's current status and progression within their lifecycle, enabling more targeted and effective engagement strategies.

<Image align="center" className="border" border={true} src="https://files.readme.io/27b20f3a4a23e85fcf5ffc706a634fb73964f598c04c024434e7675dcb9475bf-Capture_decran_2024-11-14_a_10.49.30.png" />

<br />

# ACTIVATION

| Event                  | Description                                                       | Useful to                                                                                                                                                                                             |
| :--------------------- | :---------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `SUBSCRIPTION_STARTED` | A subscription has been purchased. The user becomes a subscriber. | 1. Welcome the new subscriber 2. Remind the benefits of the premium membership 3. Build trust by reminding users when their introductory offer (`TRIAL`, `INTRO OFFER` or `PROMO CODE`) will endNote: |

<br />

# CANCELLATION

| Event                     | Description                                                                                               | Useful to                                                                                                                                                                                                               |
| :------------------------ | :-------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `RENEWAL_DISABLED`        | The customer has cancelled the auto-renewal of the subscription in their device settings                  | 1. Detect premium users who are likely to churn at the end of their current billing cycle 2. Remind the benefits of the premium subscription 3. Offer a limited time promotion to make them reactivate the auto-renewal |
| `RENEWAL_ENABLED`         | The customer has reactivated the automatic renewal of the subscription                                    | 1. Detect premium users who have reactivated the auto-renewal                                                                                                                                                           |
| `SUBSCRIPTION_TERMINATED` | The subscription has been voluntarily terminated. The subscriber no longer has an active subscription     | 1. Send a survey to the customer to understand why they terminated their subscription 2. Offer a promotion to try the premium membership for a discounted price                                                         |
| `FAMILY_SHARED_REVOKED`   | The subscription owner has revoked access rights to the account user, through the family sharing settings | 1. Inform the user that they no longer have access to the premium membership because the owner of the subscription has revoked their their access                                                                       |

<br />

# BILLING ISSUES

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
        `GRACE_PERIOD_STARTED`
      </td>

      <td>
        A billing issue on the subscriber's end occurred at renewal.  

        The subscriber has entered the grace period. The subscriber still has access to all subscription benefits during the grace period.  

        The grace period can be configured in the App Store Connect Console and in the Google Play Store Console.
      </td>

      <td>
        1. Inform the user that a billing issue occurred
        2. Reassure them by telling them their premium membership will remain active for a short period of time
        3. Invite them to update their billing details in the store settings to avoid having their premium membership suspended
        4. Remind the benefits of the premium membership
      </td>
    </tr>

    <tr>
      <td>
        `GRACE_PERIOD_TERMINATED`
      </td>

      <td>
        The subscriber hasn't resolved the billing issue during the grace period. They no longer has access to the subscription benefits.  

        The grace period will be followed by a billing retry period where the store will continue to try billing the user
      </td>

      <td>
        1. Inform the user that they no longer have access to subscription benefits because the billing issue wasn't fixed in due time
        2. Invite them to update their billing details in the store settings to restore their premium membership
      </td>
    </tr>

    <tr>
      <td>
        `SUBSCRIPTION_CANCELLED_DURING_GRACE_PERIOD`
      </td>

      <td>
        The subscriber has cancelled the auto-renewal during the grace period. The subscription is terminated. The subscriber no longer has access to the premium benefits
      </td>

      <td>
        1. Inform the user that they no longer have access to subscription benefits
      </td>
    </tr>

    <tr>
      <td>
        `SUBSCRIPTION_RECOVERED_FROM_GRACE_PERIOD`
      </td>

      <td>
        The billing issue has been solved and the subscription is renewed 
      </td>

      <td>
        1. Inform the user the billing issue has been fixed and their subscription has been successfully renewed
      </td>
    </tr>

    <tr>
      <td>
        `ENTERED_BILLING_RETRY`
      </td>

      <td>
        A billing issue on the subscriber's end occurred at renewal.  

        The subscription enters the billing retry phase, which last 60 days on the App Store and 30 days on the Google Play Store.  

        The subscriber no longer has access to the subscription benefits of the premium membership.
      </td>

      <td>
        1. Inform the user that their access to the premium benefits have been suspended due to a billing issue
        2. Invite them to update their billing details in the store settings to restore their premium membership
        3. Remind the benefits of the premium membership
      </td>
    </tr>

    <tr>
      <td>
        `SUBSCRIPTION_RECOVERED_FROM_BILLING_RETRY`
      </td>

      <td>
        The transaction was successfully completed while in billing retry.  

        The subscription is resumed and the user has access to the premium membership again.  

        The new billing cycle restarts from the day the event subscription has been recovered. 
      </td>

      <td>
        1. Inform the user that their  premium membership has been restored
        2. Remind the benefits of the premium membership
      </td>
    </tr>
  </tbody>
</Table>

<Image align="center" className="border" border={true} src="https://files.readme.io/2d85144fc8ceceead2177090cf014a1d363b14d8d8a0225e928fc62dec945478-Capture_decran_2024-11-14_a_11.18.20.png" />

<Image align="center" className="border" border={true} src="https://files.readme.io/9786bbb9a89b1319bdb18f469ab4d9a68da3525ab8508bb77c38adcdd0f1e111-Capture_decran_2024-11-14_a_11.20.41.png" />

<br />

# RENEWAL & REACTIVATION

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
        `SUBSCRIPTION_RENEWED`
      </td>

      <td>
        The subscription has been renewed
      </td>

      <td>
        1. Gather feedback by sending satisfaction survey every other month
      </td>
    </tr>

    <tr>
      <td>
        `SUBSCRIPTION_DEFERRED`
      </td>

      <td>
        **Google Play Store only**\
        The app publisher has decided to extend the subscription period by X days for free, before the subscription cycle resumes as before.  

        The date when that period will end can be found in the attribute "defer\_end\_at".  

        This event is very rare.
      </td>

      <td>
        1. Inform the subscriber with the reason and length of the free extension and stress the date at which the next billing cycle will start
      </td>
    </tr>

    <tr>
      <td>
        `SUBSCRIPTION_REACTIVATED`
      </td>

      <td>
        A subscription that was expired has been reactivated.
      </td>

      <td>
        1. Welcome back the subscriber
        2. Remind the benefits of the premium membership
      </td>
    </tr>
  </tbody>
</Table>

<br />

# PLAN CHANGE

| Event                      | Description                                                     | Useful to                                                                                                                                                                                                                         |
| :------------------------- | :-------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `SUBSCRIPTION_CROSSGRADED` | The subscriber has switched subscriptions within the same grade | 1. Build trust by thanking them and reminding which features / contents are now accessible with the new plan 2. Measure the number of subscriptions migrations to another same grade subscription                                 |
| `SUBSCRIPTION_DOWNGRADED`  | The subscriber has switched to a lower- grade subscription      | 1. Build trust by thanking them and reminding which features / contents are now accessible with the new plan 2. Measure the number of subscriptions migrations to another lower grade subscription 3. Compute the contraction MRR |
| `SUBSCRIPTION_UPGRADED`    | The subscriber has switched to a higher-grade subscription      | 1. Build trust by thanking them and reminding which features / contents are now accessible with the new plan 2. Measure the number of subscriptions migrations to another higher grade subscription 3. Compute the expansion MRR  |

<Image alt="Upgrades and downgrades are immediate. Downgrades become effective with the next billing cycle." align="center" border={true} src="https://files.readme.io/4fa9bf3-image.png">
  Upgrades and downgrades are immediate. Downgrades become effective with the next billing cycle.
</Image>

<br />

# REFUND

| Event                           | Description                                                                                                                | Useful to                                                                                                                                                                         |
| :------------------------------ | :------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `SUBSCRIPTION_REFUNDED_REVOKED` | The subscriber was refunded for his subscription. The former subscriber no longer has access to the subscription benefits. | 1. Inform the subscriber that their subscription has been refunded and that they no longer have access to the premium benefits. 2. Collect feedback by sending a refunding survey |

<br />

# TRANSFER

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
        `SUBSCRIPTION_TRANSFERRED`
      </td>

      <td>
        The subscription was transferred to another account and the original subscriber no longer has access to the subscription benefits.  

        This event is triggered for the original subscriber. A similar event called `SUBSCRIPTION_RECEIVED` is triggered for the new subscriber.  

        This event can occur under 3 conditions:  

        1. a sign-up / sign-in after the subscription was purchased by an anonymous user
        2. a restore that was done from a different device linked to the same store account
        3. a restore that was done from a different user account (different user ID)
      </td>

      <td>
        1. Inform the original subscriber that their subscription has been transferred and that they no longer have access to their premium benefits
      </td>
    </tr>

    <tr>
      <td>
        `SUBSCRIPTION_RECEIVED`
      </td>

      <td>
        The user has received a subscription from another account and has now access to the premium benefits.  

        This event is triggered for the new subscriber. A similar event called `SUBSCRIPTION_TRANSFERRED` is triggered for the original subscriber.  

        This event can occur under 3 conditions:  

        1. a sign-up / sign-in after the subscription was purchased by an anonymous user
        2. a restore that was done from a different device linked to the same store account
        3. a restore that was done from a different user account (different user ID)
      </td>

      <td>
        1. Inform the new subscriber that a subscription has been transferred to them.
        2. Welcome the new subscriber and present them with the benefits of the premium membership
      </td>
    </tr>

    <tr>
      <td>
        `ONE_TIME_PURCHASE_TRANSFERRED`
      </td>

      <td>
        A non-consumable has been transferred to another user. The original buyer no longer has access to the non-consumable benefits  

        This event is triggered for the original subscriber. A similar event called `ONE_TIME_PURCHASE_RECEIVED` is triggered for the new user.  

        This event can occur under 3 conditions:  

        1. a sign-up / sign-in after the subscription was purchased by an anonymous user
        2. a restore that was done from a different device linked to the same store account
        3. a restore that was done from a different user account (different user ID)
      </td>

      <td>
        1. Inform original customer that their purchase has been transferred 
      </td>
    </tr>

    <tr>
      <td>
        `ONE_TIME_PURCHASE_RECEIVED`
      </td>

      <td>
        The user has been transferred a non-consumable from another account. This user has now access to the non-consumable benefits  

        This event is triggered for the new user. A similar event called `ONE_TIME_PURCHASE_TRANSFERRED` is triggered for the original buyer.  

        This event can occur under 3 conditions:  

        1. a sign-up / sign-in after the subscription was purchased by an anonymous user
        2. a restore that was done from a different device linked to the same store account
        3. a restore that was done from a different user account (different user ID)
      </td>

      <td>
        1. Inform the new user that a purchase has been transferred to them
      </td>
    </tr>
  </tbody>
</Table>

<br />

# PAUSE

The Google Play Store has a PAUSE mechanism allowing subscribers to suspend their subscription without cancelling it. This mechanism has no equivalent on the App Store.

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
        `SUBSCRIPTION_WILL_PAUSE`
      </td>

      <td>
        **Google Play Store only**\
        The subscriber has set a pause starting on the next renewal date
      </td>

      <td>
        1. Inform the subscriber that their subscription will be paused on their next renewal date and that they will lose the access to the premium benefits until the subscription is resumed
        2. Collect feedback by sending a survey to clearly identify why they plan to pause their subscription.
      </td>
    </tr>

    <tr>
      <td>
        `SUBSCRIPTION_PAUSED`
      </td>

      <td>
        **Google Play Store only**\
        The subscription has now paused and the subscriber no longer has access to the subscription benefits
      </td>

      <td>
        1. Inform the subscriber that their subscription has been paused and that they no longer have access to the premium benefits
      </td>
    </tr>

    <tr>
      <td>
        `SUBSCRIPTION_UNPAUSED`
      </td>

      <td>
        **Google Play Store only**\
        The subscription has resumed
      </td>

      <td>
        1. Inform the subscriber that their subscription has been resumed and that their access to the premium benefits have been reactivated
      </td>
    </tr>

    <tr>
      <td>
        `SUBSCRIPTION_CANCELLED_DURING_PAUSE`
      </td>

      <td>
        **Google Play Store only**\
        The subscriber has cancelled the subscription during the subscription pause
      </td>

      <td>
        1. Confirm to the user that their subscription has been cancelled and will not be resumed
        2. Collect feedback by sending a cancellation survey to clearly identify why they cancelled their subscription
      </td>
    </tr>

    <tr>
      <td>
        `SUBSCRIPTION_WILL_NOT_PAUSE`
      </td>

      <td>
        **Google Play Store only**\
        The customer has cancelled the subscription pause he had set before it even starts
      </td>

      <td>
        1. Inform the subscriber that their subscription will not be paused
      </td>
    </tr>
  </tbody>
</Table>
