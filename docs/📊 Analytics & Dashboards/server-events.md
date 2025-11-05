---
title: Server Events
excerpt: This section provides an overlook of Server Events
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Want to know more about each category of events or their attributes?
  pages:
    - type: basic
      slug: entitlement-events
      title: Entitlement Events
    - type: basic
      slug: subscription-events
      title: Subscription Events
    - type: basic
      slug: transactional-event
      title: Transactional Event
    - type: basic
      slug: server-events-attributes
      title: Server Events Attributes
---
# What are Server Events?

<ServerEventsWhatFor />

<br />

# What are they used for?

## 1. Entitlement Events

This subset is composed of 2 events: 

- `ACTIVATE` : when an entitlement must be granted (for example after the purchase/renewal of a subscription, or the purchase of a one-time purchase)
- `DEACTIVATE`: when an existing entitlement must be revoked (for example after the termination/refund of a subscription or one-time purchase)

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/303a3b2-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

They are used  to [manage entitlements with your developer's backend](entitlements-management#managing-entitlements-with-your-own-backend)

[More details on Entitlement Events](entitlement-events)

<br />

## 2. Lifecycle Events

This subset is composed of 27 different events which map every use case in a typical subscription lifecycle.

- when a subscription starts, is renewed, terminated, upgraded, downgraded, transferred or enters in grace period or in billing retry
- when the auto-renewing of a subscription is disabled or enabled again

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/814f7ea504469dc0ae40c50fe3dbcdc5e313b940dfd7c2d7c3387365c8c53fef-Capture_decran_2024-11-14_a_10.49.30.png",
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

They can be used to:

- track the different phases of the subscribers lifecycle 
- create automations and campaigns for each stage of the subscribers' journey
- identify growth opportunities by analyzing them in the [Events Dashboard of the Purchasely Console](dasbhoard-events)

[More details on Lifecycle Events](lifecycle-events)

<br />

## 3. Offer Events

This subset is composed of 12 different events focusing on the incentives associated with your subscriptions.

- when a free trial, intro offer, promo-code or promotional offer starts, is converted or not converted.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/5a2faeea0b73eaf2cd140995b4ce9439881cd9d44295dabae4976bf09786465a-Capture_decran_2024-11-14_a_10.49.30.png",
        null,
        null
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


They can be used to:

- track the different phases of the subscribers incentives lifecycle
- create automations and campaigns to ensure these subscriptions convert

[More details on Offer Events](offer-events)

<br />

## 4. Transactional Event

This subset is composed of 1 single event: 

- `TRANSACTION_PROCESSED`: generated for subscriptions only, every time an amount of money is involved in a transaction (not for free trials therefore) and provides everything related to revenue information for this transaction (customer's currency, cumulated revenue, integrations' currency)

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/787c609-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


It can be used to:

- track all the subscribers' transactions in various platforms (either your own backend or 3rd-party platforms you are using)
- build your own internal revenue dashboard

[More details on Transactional Event](transactional-event)

<br />

# What data is associated with Server Events

Server Events consist of JSON payloads. They all share a common structure and have a comprehensive set of attributes

[More details on Server Events Attributes](server-events-attributes)