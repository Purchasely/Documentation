---
title: Subscription Events
excerpt: >-
  This section provides details on Subscription events and the sequence in which
  they occur
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Throughout the entire subscription lifecycle, the Purchasely Platform generates detailed Subscription Events. 

These events enrich the foundational Transactional Events, which primarily focus on entitlement management. 

By offering additional, real-time insights, the subscription events provide a comprehensive view of a subscriber's current status and progression within their lifecycle, enabling more targeted and effective engagement strategies.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/c0f1390-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


# ACTIVATION

[block:parameters]
{
  "data": {
    "h-0": "Event",
    "h-1": "Description",
    "h-2": "Useful to",
    "0-0": "`SUBSCRIPTION_STARTED`",
    "0-1": "A subscription has been purchased. The user becomes a subscriber.",
    "0-2": "1. Welcome the new subscriber\n2. Remind the benefits of the premium membership\n3. Build trust by reminding users when their introductory offer (`TRIAL`, `INTRO OFFER` or `PROMO CODE`) will endNote:  \n  \n- this event is triggered in addition to the events  \n  `TRIAL_STARTED`  \n  `INTRO_OFFER_STARTED`  \n  `PROMO_CODE_STARTED`",
    "1-0": "`TRIAL_STARTED`  \n`INTRO_OFFER_STARTED`  \n`PROMO_CODE_STARTED`",
    "1-1": "A free trial, an introductory offer or a promo code has started",
    "1-2": "1. Engage user with the premium contents / features\n2. Build trust by reminding users when their introductory offer (`TRIAL`, `INTRO OFFER` or `PROMO CODE`) will end",
    "2-0": "`TRIAL_CONVERTED`  \n`INTRO_OFFER_CONVERTED`  \n`PROMO_CODE_CONVERTED`",
    "2-1": "The free trial, introductory offer or promo-code has been converted to a regular price subscription",
    "2-2": "1. Build trust by thanking the user for their loyalty\n2. Build trust by reminding the user when their current billing cycle will end",
    "3-0": "`TRIAL_NOT_CONVERTED`  \n`INTRO_OFFER_NOT_CONVERTED`  \n`PROMO_CODE_NOT_CONVERTED`",
    "3-1": "The free trial or the introductory offer did not convert to a regular price subscription",
    "3-2": "1. Send a survey to understand why they did not convert\n2. Offer a free trial extension to give a second chance to the user to try the premium membership\n3. Offer a promotion to try the premium membership for a discounted price"
  },
  "cols": 3,
  "rows": 4,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/3eee065-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


# CANCELLATION

| Event                     | Description                                                                                               | Useful to                                                                                                                                                                                                               |
| :------------------------ | :-------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `RENEWAL_DISABLED`        | The customer has cancelled the auto-renewal of the subscription in their device settings                  | 1. Detect premium users who are likely to churn at the end of their current billing cycle 2. Remind the benefits of the premium subscription 3. Offer a limited time promotion to make them reactivate the auto-renewal |
| `RENEWAL_ENABLED`         | The customer has reactivated the automatic renewal of the subscription                                    | 1. Detect premium users who have reactivated the auto-renewal                                                                                                                                                           |
| `SUBSCRIPTION_TERMINATED` | The subscription has been voluntarily terminated. The subscriber no longer has an active subscription     | 1. Send a survey to the customer to understand why they terminated their subscription 2. Offer a promotion to try the premium membership for a discounted price                                                         |
| `FAMILY_SHARED_REVOKED`   | The subscription owner has revoked access rights to the account user, through the family sharing settings | 1. Inform the user that they no longer have access to the premium membership because the owner of the subscription has revoked their their access                                                                       |

# BILLING ISSUES

[block:parameters]
{
  "data": {
    "h-0": "Event",
    "h-1": "Description",
    "h-2": "Useful to",
    "0-0": "`GRACE_PERIOD_STARTED`",
    "0-1": "A billing issue on the subscriber's end occurred at renewal.  \n  \nThe subscriber has entered the grace period. The subscriber still has access to all subscription benefits during the grace period.  \n  \nThe grace period can be configured in the App Store Connect Console and in the Google Play Store Console.",
    "0-2": "1. Inform the user that a billing issue occurred\n2. Reassure them by telling them their premium membership will remain active for a short period of time\n3. Invite them to update their billing details in the store settings to avoid having their premium membership suspended\n4. Remind the benefits of the premium membership",
    "1-0": "`GRACE_PERIOD_TERMINATED`",
    "1-1": "The subscriber hasn't resolved the billing issue during the grace period. They no longer has access to the subscription benefits.  \n  \nThe grace period will be followed by a billing retry period where the store will continue to try billing the user",
    "1-2": "1. Inform the user that they no longer have access to subscription benefits because the billing issue wasn't fixed in due time\n2. Invite them to update their billing details in the store settings to restore their premium membership",
    "2-0": "`SUBSCRIPTION_CANCELLED_DURING_GRACE_PERIOD`",
    "2-1": "The subscriber has cancelled the auto-renewal during the grace period. The subscription is terminated. The subscriber no longer has access to the premium benefits",
    "2-2": "1. Inform the user that they no longer have access to subscription benefits",
    "3-0": "`SUBSCRIPTION_RECOVERED_FROM_GRACE_PERIOD`",
    "3-1": "The billing issue has been solved and the subscription is renewed ",
    "3-2": "1. Inform the user the billing issue has been fixed and their subscription has been successfully renewed",
    "4-0": "`ENTERED_BILLING_RETRY`",
    "4-1": "A billing issue on the subscriber's end occurred at renewal.  \n  \nThe subscription enters the billing retry phase, which last 60 days on the App Store and 30 days on the Google Play Store.  \n  \nThe subscriber no longer has access to the subscription benefits of the premium membership.",
    "4-2": "1. Inform the user that their access to the premium benefits have been suspended due to a billing issue\n2. Invite them to update their billing details in the store settings to restore their premium membership\n3. Remind the benefits of the premium membership",
    "5-0": "`SUBSCRIPTION_RECOVERED_FROM_BILLING_RETRY`",
    "5-1": "The transaction was successfully completed while in billing retry.  \n  \nThe subscription is resumed and the user has access to the premium membership again.  \n  \nThe new billing cycle restarts from the day the event subscription has been recovered. ",
    "5-2": "1. Inform the user that their  premium membership has been restored\n2. Remind the benefits of the premium membership"
  },
  "cols": 3,
  "rows": 6,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/e5d4a93-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/3e7293f-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


# RETENTION & WIN-BACK

| Event                             | Description                                                                                               | Useful to                                                                                                                                                                                                                                                                                       |
| :-------------------------------- | :-------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `PROMOTIONAL_OFFER_STARTED`       | A subscription has been renewed or reactivated with a promotional offer. The promotional offer is active. | 1. Build trust by thanking the user for their loyalty 2. Build trust by reminding users when their promotional offer will end                                                                                                                                                                   |
| `PROMOTIONAL_OFFER_CONVERTED`     | The promotional offer has been converted to a regular price subscription                                  | 1. Build trust by thanking the user for their loyalty 2. Build trust by reminding the user when their current billing cycle will end 3. Measure the number of conversions of promotional offers and compute the conversion rate (= `PROMOTIONAL_OFFER_CONVERTED` / `PROMOTIONAL_OFFER_STARTED`) |
| `PROMOTIONAL_OFFER_NOT_CONVERTED` | The promotional offer has not been converted and the subscription has been terminated                     | 1. Send a survey to understand why they did not convert                                                                                                                                                                                                                                         |

# TRANSFER

[block:parameters]
{
  "data": {
    "h-0": "Event",
    "h-1": "Description",
    "h-2": "Useful to",
    "0-0": "`SUBSCRIPTION_TRANSFERRED`",
    "0-1": "The subscription was transferred to another account and the original subscriber no longer has access to the subscription benefits.  \n  \nThis event is triggered for the original subscriber. A similar event called `SUBSCRIPTION_RECEIVED` is triggered for the new subscriber.  \n  \nThis event can occur under 3 conditions:  \n  \n1. a sign-up / sign-in after the subscription was purchased by an anonymous user\n2. a restore that was done from a different device linked to the same store account\n3. a restore that was done from a different user account (different user ID)",
    "0-2": "1. Inform the original subscriber that their subscription has been transferred and that they no longer have access to their premium benefits",
    "1-0": "`SUBSCRIPTION_RECEIVED`",
    "1-1": "The user has received a subscription from another account and has now access to the premium benefits.  \n  \nThis event is triggered for the new subscriber. A similar event called `SUBSCRIPTION_TRANSFERRED` is triggered for the original subscriber.  \n  \nThis event can occur under 3 conditions:  \n  \n1. a sign-up / sign-in after the subscription was purchased by an anonymous user\n2. a restore that was done from a different device linked to the same store account\n3. a restore that was done from a different user account (different user ID)",
    "1-2": "1. Inform the new subscriber that a subscription has been transferred to them.\n2. Welcome the new subscriber and present them with the benefits of the premium membership",
    "2-0": "`ONE_TIME_PURCHASE_TRANSFERRED`",
    "2-1": "A non-consumable has been transferred to another user. The original buyer no longer has access to the non-consumable benefits  \n  \nThis event is triggered for the original subscriber. A similar event called `ONE_TIME_PURCHASE_RECEIVED` is triggered for the new user.  \n  \nThis event can occur under 3 conditions:  \n  \n1. a sign-up / sign-in after the subscription was purchased by an anonymous user\n2. a restore that was done from a different device linked to the same store account\n3. a restore that was done from a different user account (different user ID)",
    "2-2": "1. Inform original customer that their purchase has been transferred ",
    "3-0": "`ONE_TIME_PURCHASE_RECEIVED`",
    "3-1": "The user has been transferred a non-consumable from another account. This user has now access to the non-consumable benefits  \n  \nThis event is triggered for the new user. A similar event called `ONE_TIME_PURCHASE_TRANSFERRED` is triggered for the original buyer.  \n  \nThis event can occur under 3 conditions:  \n  \n1. a sign-up / sign-in after the subscription was purchased by an anonymous user\n2. a restore that was done from a different device linked to the same store account\n3. a restore that was done from a different user account (different user ID)",
    "3-2": "1. Inform the new user that a purchase has been transferred to them"
  },
  "cols": 3,
  "rows": 4,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


# RENEWAL & REACTIVATION

[block:parameters]
{
  "data": {
    "h-0": "Event",
    "h-1": "Description",
    "h-2": "Useful to",
    "0-0": "`SUBSCRIPTION_RENEWED`",
    "0-1": "The subscription has been renewed",
    "0-2": "1. Gather feedback by sending satisfaction survey every other month",
    "1-0": "`SUBSCRIPTION_DEFERRED`",
    "1-1": "**Google Play Store only**  \nThe app publisher has decided to extend the subscription period by X days for free, before the subscription cycle resumes as before.  \n  \nThe date when that period will end can be found in the attribute \"defer_end_at\".  \n  \nThis event is very rare.",
    "1-2": "1. Inform the subscriber with the reason and length of the free extension and stress the date at which the next billing cycle will start",
    "2-0": "`SUBSCRIPTION_REACTIVATED`",
    "2-1": "A subscription that was expired has been reactivated.",
    "2-2": "1. Welcome back the subscriber\n2. Remind the benefits of the premium membership"
  },
  "cols": 3,
  "rows": 3,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


# PLAN CHANGE

| Event                      | Description                                                     | Useful to                                                                                                                                                                                                                         |
| :------------------------- | :-------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `SUBSCRIPTION_CROSSGRADED` | The subscriber has switched subscriptions within the same grade | 1. Build trust by thanking them and reminding which features / contents are now accessible with the new plan 2. Measure the number of subscriptions migrations to another same grade subscription                                 |
| `SUBSCRIPTION_DOWNGRADED`  | The subscriber has switched to a lower- grade subscription      | 1. Build trust by thanking them and reminding which features / contents are now accessible with the new plan 2. Measure the number of subscriptions migrations to another lower grade subscription 3. Compute the contraction MRR |
| `SUBSCRIPTION_UPGRADED`    | The subscriber has switched to a higher-grade subscription      | 1. Build trust by thanking them and reminding which features / contents are now accessible with the new plan 2. Measure the number of subscriptions migrations to another higher grade subscription 3. Compute the expansion MRR  |

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/4fa9bf3-image.png",
        null,
        null
      ],
      "align": "center",
      "border": true,
      "caption": "Upgrades and downgrades are immediate. Downgrades become effective with the next billing cycle."
    }
  ]
}
[/block]


<br />

# REFUND

| Event                           | Description                                                                                                                | Useful to                                                                                                                                                                         |
| :------------------------------ | :------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `SUBSCRIPTION_REFUNDED_REVOKED` | The subscriber was refunded for his subscription. The former subscriber no longer has access to the subscription benefits. | 1. Inform the subscriber that their subscription has been refunded and that they no longer have access to the premium benefits. 2. Collect feedback by sending a refunding survey |

# PAUSE

The Google Play Store has a PAUSE mechanism allowing subscribers to suspend their subscription without cancelling it. This mechanism has no equivalent on the App Store.

[block:parameters]
{
  "data": {
    "h-0": "Event",
    "h-1": "Description",
    "h-2": "Useful to",
    "0-0": "`SUBSCRIPTION_WILL_PAUSE`",
    "0-1": "**Google Play Store only**  \nThe subscriber has set a pause starting on the next renewal date",
    "0-2": "1. Inform the subscriber that their subscription will be paused on their next renewal date and that they will lose the access to the premium benefits until the subscription is resumed\n2. Collect feedback by sending a survey to clearly identify why they plan to pause their subscription.",
    "1-0": "`SUBSCRIPTION_PAUSED`",
    "1-1": "**Google Play Store only**  \nThe subscription has now paused and the subscriber no longer has access to the subscription benefits",
    "1-2": "1. Inform the subscriber that their subscription has been paused and that they no longer have access to the premium benefits",
    "2-0": "`SUBSCRIPTION_UNPAUSED`",
    "2-1": "**Google Play Store only**  \nThe subscription has resumed",
    "2-2": "1. Inform the subscriber that their subscription has been resumed and that their access to the premium benefits have been reactivated",
    "3-0": "`SUBSCRIPTION_CANCELLED_DURING_PAUSE`",
    "3-1": "**Google Play Store only**  \nThe subscriber has cancelled the subscription during the subscription pause",
    "3-2": "1. Confirm to the user that their subscription has been cancelled and will not be resumed\n2. Collect feedback by sending a cancellation survey to clearly identify why they cancelled their subscription",
    "4-0": "`SUBSCRIPTION_WILL_NOT_PAUSE`",
    "4-1": "**Google Play Store only**  \nThe customer has cancelled the subscription pause he had set before it even starts",
    "4-2": "1. Inform the subscriber that their subscription will not be paused"
  },
  "cols": 3,
  "rows": 5,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]