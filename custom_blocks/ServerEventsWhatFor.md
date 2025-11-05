---
name: Server Events - what for?
---
Server Events are generated when something changes in the subscription lifecycle.  
_E.g.: when a subscription starts, is renewed, the auto-renewing is cancelled, a trial is converted, ..._

They may be triggered when:

- a one-time purchase or a subscription is purchased
- a subscription has reached its renewal date
- an <<glossary:S2S>> is received from the App stores (eg: App Store Server Notification or Play Store Server notifications)

They are used to:

- grant & revoke entitlements ([Entitlement Events](entitlement-events))
- provide details on the revenue associated to the transactions ([Transactional Event](transactional-event))
- provide details on the subscription lifecycle ([Lifecycle Events](lifecycle-events))
- provide details on the incentives associated with your subscriptions ([Offer Events](offer-events))

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/8f3e294aa6332e7870cdf7a278c67d52f3db99240601bdac3ec08898bb1d369a-Capture_decran_2024-11-14_a_10.49.55.png",
        null,
        null
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

They can natively be routed to:

- the [webhook of the Purchasely platform](webhook)
- Purchasely's 3rd-party integrations ([attribution platforms](attribution), [engagement & CRM platforms](engagement-crm), [analytics platforms](analytics-3rd-party))
- a [Firebase App](firebase-app)

They can also be visualized and analyzed in the [Events Dashboard of the Purchasely Console](dashboard-events)