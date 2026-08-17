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
| `RETENTION_MESSAGE_REQUESTED` | The subscriber opened the App Store cancel sheet and Apple asked Purchasely for a retention message — it does not mean the subscription was cancelled (App Store only, requires [Apple Retention Messaging](https://docs.purchasely.com/docs/apple-retention-messaging) to be set up) | 1. Measure how many subscribers enter the cancel flow 2. Correlate with later `RENEWAL_DISABLED` / `SUBSCRIPTION_TERMINATED` events to measure the save rate of your retention messages 3. Trigger a win-back campaign while the subscription is still active |
| `RENEWAL_DISABLED`        | The customer has cancelled the auto-renewal of the subscription in their device settings                  | 1. Detect premium users who are likely to churn at the end of their current billing cycle 2. Remind the benefits of the premium subscription 3. Offer a limited time promotion to make them reactivate the auto-renewal |
| `RENEWAL_ENABLED`         | The customer has reactivated the automatic renewal of the subscription                                    | 1. Detect premium users who have reactivated the auto-renewal                                                                                                                                                           |
| `SUBSCRIPTION_TERMINATED` | The subscription has been voluntarily terminated. The subscriber no longer has an active subscription     | 1. Send a survey to the customer to understand why they terminated their subscription 2. Offer a promotion to try the premium membership for a discounted price                                                         |
| `FAMILY_SHARED_REVOKED`   | The subscription owner has revoked access rights to the account user, through the family sharing settings | 1. Inform the user that they no longer have access to the premium membership because the owner of the subscription has revoked their their access                                                                       |

<br />

# BILLING ISSUES

| Event | Description | Useful to |
| :--- | :--- | :--- |
| `GRACE_PERIOD_STARTED` | A billing issue on the subscriber's end occurred at renewal.<br><br>The subscriber has entered the grace period. The subscriber still has access to all subscription benefits during the grace period.<br><br>The grace period can be configured in the App Store Connect Console and in the Google Play Store Console. | 1. Inform the user that a billing issue occurred<br>2. Reassure them by telling them their premium membership will remain active for a short period of time<br>3. Invite them to update their billing details in the store settings to avoid having their premium membership suspended<br>4. Remind the benefits of the premium membership |
| `GRACE_PERIOD_TERMINATED` | The subscriber hasn't resolved the billing issue during the grace period. They no longer has access to the subscription benefits.<br><br>The grace period will be followed by a billing retry period where the store will continue to try billing the user | 1. Inform the user that they no longer have access to subscription benefits because the billing issue wasn't fixed in due time<br>2. Invite them to update their billing details in the store settings to restore their premium membership |
| `SUBSCRIPTION_CANCELLED_DURING_GRACE_PERIOD` | The subscriber has cancelled the auto-renewal during the grace period. The subscription is terminated. The subscriber no longer has access to the premium benefits | 1. Inform the user that they no longer have access to subscription benefits |
| `SUBSCRIPTION_RECOVERED_FROM_GRACE_PERIOD` | The billing issue has been solved and the subscription is renewed | 1. Inform the user the billing issue has been fixed and their subscription has been successfully renewed |
| `ENTERED_BILLING_RETRY` | A billing issue on the subscriber's end occurred at renewal.<br><br>The subscription enters the billing retry phase, which last 60 days on the App Store and 30 days on the Google Play Store.<br><br>The subscriber no longer has access to the subscription benefits of the premium membership. | 1. Inform the user that their access to the premium benefits have been suspended due to a billing issue<br>2. Invite them to update their billing details in the store settings to restore their premium membership<br>3. Remind the benefits of the premium membership |
| `SUBSCRIPTION_RECOVERED_FROM_BILLING_RETRY` | The transaction was successfully completed while in billing retry.<br><br>The subscription is resumed and the user has access to the premium membership again.<br><br>The new billing cycle restarts from the day the event subscription has been recovered. | 1. Inform the user that their  premium membership has been restored<br>2. Remind the benefits of the premium membership |

<Image align="center" className="border" border={true} src="https://files.readme.io/2d85144fc8ceceead2177090cf014a1d363b14d8d8a0225e928fc62dec945478-Capture_decran_2024-11-14_a_11.18.20.png" />

<Image align="center" className="border" border={true} src="https://files.readme.io/9786bbb9a89b1319bdb18f469ab4d9a68da3525ab8508bb77c38adcdd0f1e111-Capture_decran_2024-11-14_a_11.20.41.png" />

<br />

# RENEWAL & REACTIVATION

| Event | Description | Useful to |
| :--- | :--- | :--- |
| `SUBSCRIPTION_RENEWED` | The subscription has been renewed | 1. Gather feedback by sending satisfaction survey every other month |
| `SUBSCRIPTION_DEFERRED` | **Google Play Store only**<br>The app publisher has decided to extend the subscription period by X days for free, before the subscription cycle resumes as before.<br><br>The date when that period will end can be found in the attribute "defer\_end\_at".<br><br>This event is very rare. | 1. Inform the subscriber with the reason and length of the free extension and stress the date at which the next billing cycle will start |
| `SUBSCRIPTION_REACTIVATED` | A subscription that was expired has been reactivated. | 1. Welcome back the subscriber<br>2. Remind the benefits of the premium membership |

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

| Event | Description | Useful to |
| :--- | :--- | :--- |
| `SUBSCRIPTION_TRANSFERRED` | The subscription was transferred to another account and the original subscriber no longer has access to the subscription benefits.<br><br>This event is triggered for the original subscriber. A similar event called `SUBSCRIPTION_RECEIVED` is triggered for the new subscriber.<br><br>This event can occur under 3 conditions:<br><br>1. a sign-up / sign-in after the subscription was purchased by an anonymous user<br>2. a restore that was done from a different device linked to the same store account<br>3. a restore that was done from a different user account (different user ID) | 1. Inform the original subscriber that their subscription has been transferred and that they no longer have access to their premium benefits |
| `SUBSCRIPTION_RECEIVED` | The user has received a subscription from another account and has now access to the premium benefits.<br><br>This event is triggered for the new subscriber. A similar event called `SUBSCRIPTION_TRANSFERRED` is triggered for the original subscriber.<br><br>This event can occur under 3 conditions:<br><br>1. a sign-up / sign-in after the subscription was purchased by an anonymous user<br>2. a restore that was done from a different device linked to the same store account<br>3. a restore that was done from a different user account (different user ID) | 1. Inform the new subscriber that a subscription has been transferred to them.<br>2. Welcome the new subscriber and present them with the benefits of the premium membership |
| `ONE_TIME_PURCHASE_TRANSFERRED` | A non-consumable has been transferred to another user. The original buyer no longer has access to the non-consumable benefits<br><br>This event is triggered for the original subscriber. A similar event called `ONE_TIME_PURCHASE_RECEIVED` is triggered for the new user.<br><br>This event can occur under 3 conditions:<br><br>1. a sign-up / sign-in after the subscription was purchased by an anonymous user<br>2. a restore that was done from a different device linked to the same store account<br>3. a restore that was done from a different user account (different user ID) | 1. Inform original customer that their purchase has been transferred |
| `ONE_TIME_PURCHASE_RECEIVED` | The user has been transferred a non-consumable from another account. This user has now access to the non-consumable benefits<br><br>This event is triggered for the new user. A similar event called `ONE_TIME_PURCHASE_TRANSFERRED` is triggered for the original buyer.<br><br>This event can occur under 3 conditions:<br><br>1. a sign-up / sign-in after the subscription was purchased by an anonymous user<br>2. a restore that was done from a different device linked to the same store account<br>3. a restore that was done from a different user account (different user ID) | 1. Inform the new user that a purchase has been transferred to them |

<br />

# PAUSE

The Google Play Store has a PAUSE mechanism allowing subscribers to suspend their subscription without cancelling it. This mechanism has no equivalent on the App Store.

| Event | Description | Useful to |
| :--- | :--- | :--- |
| `SUBSCRIPTION_WILL_PAUSE` | **Google Play Store only**<br>The subscriber has set a pause starting on the next renewal date | 1. Inform the subscriber that their subscription will be paused on their next renewal date and that they will lose the access to the premium benefits until the subscription is resumed<br>2. Collect feedback by sending a survey to clearly identify why they plan to pause their subscription. |
| `SUBSCRIPTION_PAUSED` | **Google Play Store only**<br>The subscription has now paused and the subscriber no longer has access to the subscription benefits | 1. Inform the subscriber that their subscription has been paused and that they no longer have access to the premium benefits |
| `SUBSCRIPTION_UNPAUSED` | **Google Play Store only**<br>The subscription has resumed | 1. Inform the subscriber that their subscription has been resumed and that their access to the premium benefits have been reactivated |
| `SUBSCRIPTION_CANCELLED_DURING_PAUSE` | **Google Play Store only**<br>The subscriber has cancelled the subscription during the subscription pause | 1. Confirm to the user that their subscription has been cancelled and will not be resumed<br>2. Collect feedback by sending a cancellation survey to clearly identify why they cancelled their subscription |
| `SUBSCRIPTION_WILL_NOT_PAUSE` | **Google Play Store only**<br>The customer has cancelled the subscription pause he had set before it even starts | 1. Inform the subscriber that their subscription will not be paused |

<br />

# MONTHLY SUBSCRIPTION WITH 12-MONTH COMMITMENT

**App Store only**\
A *monthly subscription with a 12-month commitment* is a yearly subscription that is **billed in 12 monthly installments** instead of a single upfront payment: the subscriber commits to a full year but is charged once a month. This billing mode is available on the App Store starting with iOS 26.4. To learn how to configure and sell this billing plan on your paywalls, see [12-Month Commitment (Paid Monthly)](12-month-commitment).

Each monthly charge generates an `INSTALLMENT_PAID` event, so a single committed subscription produces **12 `INSTALLMENT_PAID` events per year**. To avoid amplifying automations driven by your existing lifecycle events, those events keep their standard meaning and still fire only at the relevant moments:

* **Initial purchase** (1st installment) → `SUBSCRIPTION_STARTED` **and** `INSTALLMENT_PAID`
* **Monthly charges** (installments 2 to 12) → `INSTALLMENT_PAID` only — `SUBSCRIPTION_RENEWED` is **not** sent for these mid-commitment charges
* **Commitment renewal** (start of a new 12-month term) → `SUBSCRIPTION_RENEWED` **and** `INSTALLMENT_PAID`
* **Billing recovery** (a failed installment is eventually paid) → `SUBSCRIPTION_RECOVERED_FROM_BILLING_RETRY` **and** `INSTALLMENT_PAID`

When the subscriber turns off auto-renewal mid-commitment, a `RENEWAL_DISABLED` event is sent, but billing continues for the remaining installments (each still generating an `INSTALLMENT_PAID`) until the commitment term ends.

Events about a committed subscription carry additional `commitment_*` attributes (current installment number, total installments, commitment expiration date, commitment auto-renewal). See [Server Events Attributes](server-events-attributes).

| Event | Description | Useful to |
| :--- | :--- | :--- |
| `INSTALLMENT_PAID` | A monthly installment of a 12-month commitment subscription has been billed.<br><br>Sent on **every** monthly charge (12 per year), on top of the lifecycle event that may accompany it at the start of a term or on billing recovery (see above). | 1. Track per-installment revenue without inflating renewal-based automations<br>2. Reconcile the monthly billing schedule of committed subscribers |
| `INSTALLMENT_REFUNDED` | A **past** monthly installment of a 12-month commitment has been refunded.<br><br>The commitment and the subscription remain active and the subscriber keeps access to the premium benefits — only that single installment is refunded.<br><br>A refund of the **current** installment ends the commitment instead, and is reported through `SUBSCRIPTION_REFUNDED_REVOKED`. | 1. Reconcile a partial refund on a single billing period<br>2. Adjust revenue for the refunded installment without treating the subscriber as churned |
