---
title: Webhook
excerpt: Receive real-time server events about your subscribers' lifecycle
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: webhook-messages-authentication
      title: Webhook messages authentication
---
Purchasely can send real-time **Server Events** to your backend via a webhook. These events cover every stage of the subscription lifecycle — from activation to renewal, plan changes, billing issues, and churn.

This page explains how to configure and implement the webhook to receive **Lifecycle Events**, **Offer Events** and **Transactional Events**.

> 📘 Looking for entitlement management?
>
> If you want to use the webhook to manage user entitlements (`ACTIVATE` / `DEACTIVATE` events), refer to the dedicated guide: [Backend Entitlements](backend-entitlements).

<br />

# Benefits

Receiving server events on your backend unlocks several capabilities:

* **Marketing automations** — Trigger campaigns based on lifecycle milestones (e.g. send a win-back email when `RENEWAL_DISABLED` fires, or a congratulations message on `TRIAL_CONVERTED`)
* **Data pipeline** — Feed your data warehouse, BI tools or analytics platforms with granular subscription data for cohort analysis, churn prediction and LTV modeling
* **Internal tooling** — Power customer support dashboards with real-time subscription status, billing issue alerts and transaction history
* **Revenue tracking** — Use `TRANSACTION_PROCESSED` events to reconcile revenue across stores and currencies in your own systems
* **Server Event forwarding** — If you rely on a 3rd party platform which is not natively supported by Purchasely, you can leverage the webhook to receive the events and forward them directly to your 3rd-party platform directly from your backend

<br />

# Configuration

Setting up the webhook requires two steps in the [Purchasely Console](https://console.purchasely.io/webhooks) under **[YOUR APP] > Settings > Webhooks**.

<br />

## 1. Set your endpoint URL

Enter your **Client webhook URL** — this is the HTTPS endpoint on your backend that will receive the events.

<Image align="center" border={true} src="https://files.readme.io/45bca19-image.png" className="border" />

<br />

## 2. Enable Subscription Events

Scroll down to the **Subscription events** section. Here you can toggle individual events on or off depending on your needs.

<Image align="center" border={true} src="https://files.readme.io/dd7c900e0c73e3e33d3288c92c4e2ea0bd283b711ad4f382fe62cae796bb5d74-image.png" className="border" />

<br />

Events are organized by category:

| Category                                    | Examples                                                                    | Use case                                                       |
| :------------------------------------------ | :-------------------------------------------------------------------------- | :------------------------------------------------------------- |
| **Activation / Plan Change / Reactivation** | `SUBSCRIPTION_STARTED`, `SUBSCRIPTION_UPGRADED`, `SUBSCRIPTION_REACTIVATED` | Track new subscribers, plan changes and win-backs              |
| **Cancellation / Refund / Pause**           | `RENEWAL_DISABLED`, `SUBSCRIPTION_TERMINATED`, `SUBSCRIPTION_REFUNDED`      | Detect voluntary and involuntary churn signals                 |
| **Billing Issue**                           | `GRACE_PERIOD_STARTED`, `ENTERED_BILLING_RETRY`                             | Monitor and react to payment failures                          |
| **Renewal / Recovery**                      | `SUBSCRIPTION_RENEWED`, `SUBSCRIPTION_RECOVERED_FROM_BILLING_RETRY`         | Track successful renewals and billing recoveries               |
| **Entitlement / Transfer**                  | `SUBSCRIPTION_TRANSFERRED`, `SUBSCRIPTION_RECEIVED`                         | Handle multi-device subscription transfers                     |
| **Trial / Intro / Promo Offer**             | `TRIAL_STARTED`, `INTRO_OFFER_CONVERTED`, `PROMOTIONAL_OFFER_NOT_CONVERTED` | Measure offer performance and trigger conversion campaigns     |
| **Transaction Revenue**                     | `TRANSACTION_PROCESSED`                                                     | Track revenue per transaction with currency and amount details |

For a complete list and description of each event, see:

* [Lifecycle Events](lifecycle-events)
* [Offer Events](offer-events)
* [Transactional Event](transactional-event)

<br />

> 📘 Event acknowledgement expected
>
> As soon as you have configured a Client webhook URL, the Purchasely Platform will expect an acknowledgement for all events sent on the webhook.
>
> You can start by implementing a simple `HTTP 200` response for every message sent on the webhook.

<br />

# Implementation

## 1. Receive and acknowledge events

Your endpoint will receive `POST` requests with a JSON payload for each event. The most important rule: **always return `HTTP 200`** to acknowledge the event.

<BackendEntitlementsAcknowledgingMessages />

<br />

## 2. Route events based on `event_name`

Each payload includes an `event_name` field that identifies the event type. Use it to route the event to the appropriate handler in your backend.

```javascript JavaScript
const express = require('express');
const app = express();
app.use(express.json());

app.post('/purchasely/webhook', (req, res) => {
  const event = req.body;

  switch (event.event_name) {
    // Lifecycle events
    case 'SUBSCRIPTION_STARTED':
    case 'SUBSCRIPTION_RENEWED':
    case 'SUBSCRIPTION_TERMINATED':
    case 'RENEWAL_DISABLED':
      handleLifecycleEvent(event);
      break;

    // Offer events
    case 'TRIAL_STARTED':
    case 'TRIAL_CONVERTED':
    case 'TRIAL_NOT_CONVERTED':
      handleOfferEvent(event);
      break;

    // Transaction event
    case 'TRANSACTION_PROCESSED':
      handleTransactionEvent(event);
      break;

    // Entitlement events (see Backend Entitlements guide)
    case 'ACTIVATE':
    case 'DEACTIVATE':
      handleEntitlementEvent(event);
      break;

    default:
      console.log(`Unhandled event: ${event.event_name}`);
  }

  // Always acknowledge
  res.status(200).send('OK');
});
```
```ruby Ruby
# Uses Sinatra
post '/purchasely/webhook' do
  payload = JSON.parse(request.body.read)

  case payload['event_name']
  when 'SUBSCRIPTION_STARTED', 'SUBSCRIPTION_RENEWED',
       'SUBSCRIPTION_TERMINATED', 'RENEWAL_DISABLED'
    handle_lifecycle_event(payload)
  when 'TRIAL_STARTED', 'TRIAL_CONVERTED', 'TRIAL_NOT_CONVERTED'
    handle_offer_event(payload)
  when 'TRANSACTION_PROCESSED'
    handle_transaction_event(payload)
  when 'ACTIVATE', 'DEACTIVATE'
    handle_entitlement_event(payload) # See Backend Entitlements guide
  else
    puts "Unhandled event: #{payload['event_name']}"
  end

  # Always acknowledge
  status 200
  body 'OK'
end
```

<br />

## 3. Extract relevant data from the payload

All server events share a common JSON structure. Key fields include:

| Field                 | Description                                                          |
| :-------------------- | :------------------------------------------------------------------- |
| `event_name`          | Event identifier (e.g. `SUBSCRIPTION_RENEWED`)                       |
| `event_id`            | Unique event ID — use it for idempotency                             |
| `user_id`             | Logged-in user identifier                                            |
| `anonymous_user_id`   | Identifier for users who haven't logged in yet                       |
| `plan`                | The Purchasely plan identifier                                       |
| `store`               | The originating store (`APPLE_APP_STORE`, `GOOGLE_PLAY_STORE`, etc.) |
| `subscription_status` | Current status of the subscription                                   |
| `purchased_at`        | Original purchase date                                               |
| `next_renewal_at`     | Next expected renewal date                                           |
| `event_created_at`    | Timestamp of the event                                               |

For `TRANSACTION_PROCESSED` events, additional revenue fields are provided (`store_price`, `customer_currency`, `plan_price_in_customer_currency`, etc.).

For the full payload reference, see [Server Events Attributes](server-events-attributes).

<br />

## 4. Authenticate messages (recommended)

We strongly recommend verifying webhook signatures to protect your endpoint against spoofed requests.

<BackendEntitlementsSecurity />

For more details, see [Webhook Messages Authentication](webhook-messages-authentication).

<br />
