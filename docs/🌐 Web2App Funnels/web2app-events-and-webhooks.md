---
title: Events, attribution & webhooks
excerpt: >-
  How web purchases show up in your webhooks, in Stripe, in the SDK events and
  in your integrations, and how to tell them apart from in-app purchases.
deprecated: false
hidden: false
link:
  new_tab: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Next, frequently asked questions and known limitations.
  pages:
    - slug: web2app-faq
      title: FAQ & known limitations
      type: basic
---
A subscription sold in a Web Flow is a Purchasely subscription like any other: it goes through the same lifecycle, emits the same [server events](server-events) and reaches the same [webhook](webhook) and integrations as your App Store and Play Store subscriptions. What Web2App adds is **where the purchase came from**: the channel, the provider and the campaign. This page lists what changes, and where to read it.

## Web purchases in your webhooks

Every subscription event of a web subscription, from the first purchase to renewals, cancellations and refunds, carries the usual attributes plus three that describe the origin of the purchase.

| Attribute     | Values                                                                                                                                                                  | Present on                                                                       |
| ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| `channel`     | `web2app` for a purchase made in a Web Flow. `app2web` for a Stripe purchase made on your own website. `in_app` for App Store, Play Store, Amazon and Huawei purchases. | All subscriptions and one-time purchases.                                        |
| `provider`    | `purchasely` when Purchasely created the checkout, `external` when your backend declared the Stripe subscription through the API.                                       | Stripe purchases only.                                                           |
| `attribution` | An object with the `utm_*` parameters of the funnel's landing URL, as key/value strings, for example `{ "utm_source": "meta", "utm_campaign": "summer_promo" }`.        | Stripe `web2app` purchases whose landing URL carried at least one UTM parameter. |

```json
{
  "event_name": "ACTIVATE",
  "store": "STRIPE",
  "provider": "purchasely",
  "channel": "web2app",
  "attribution": {
    "utm_source": "meta",
    "utm_medium": "cpc",
    "utm_campaign": "summer_promo"
  },
  "plan": "premium_yearly",
  "user_id": "user_42",
  "anonymous_user_id": "…"
}
```

Use `channel` to split your revenue between the web and the stores, and `attribution` to compute the return of each campaign down to the subscription's lifetime, since the same values are repeated on every event of the subscription. The full list of attributes is on [Server events attributes](server-events-attributes). Only the UTM parameters are forwarded; click identifiers such as `gclid` or `fbclid` are used for the [ad platform integrations](web2app-setup-ad-integrations) but not sent in webhooks.

<Callout icon="📘" theme="info">
  ### Webhook v3 only

  `provider` and `attribution` are available in webhook payloads **version 3**. Native store events expose `channel` only.
</Callout>

### The activation, seen from your backend

When the subscriber opens the redemption link, the subscription moves from the anonymous web visitor to the app user. Your webhook receives the corresponding entitlement and lifecycle events for the app user: an `ACTIVATE` with the user's identifiers, then the transfer events if the subscription later moves to a signed-in account. This is the same sequence as an in-app subscription restored or transferred between users: see [Entitlement events](entitlement-events).

If your backend grants access from webhooks, grant it on `ACTIVATE` for the `user_id` or `anonymous_user_id` of the payload, as you already do. Nothing web-specific is required.

## Web purchases in Stripe

Purchasely tags the Stripe objects it creates so you can recognize them in your Stripe dashboard, exports and Sigma queries. The **Checkout Session** and the **Subscription** carry the following metadata:

| Metadata key                    | Value                                                     |
| ------------------------------- | --------------------------------------------------------- |
| `ply_provider`                  | `purchasely`                                              |
| `ply_channel`                   | `web2app`                                                 |
| `utm_source`, `utm_campaign`, … | The UTM parameters of the landing URL, up to 48 pairs.    |
| `web_session_id`                | The identifier of the web session that made the purchase. |

Stripe subscriptions created on your own website by your backend do not carry these keys.

## Events collected on the web

The funnel itself emits SDK events, the same family as your in-app Screens, tagged with the web as source. They feed your Purchasely dashboards and the Web2App funnel view.

| Event                                   | When                                                          |
| --------------------------------------- | ------------------------------------------------------------- |
| `PRESENTATION_VIEWED`                   | A Screen of the flow is displayed.                            |
| `OPTIONS_SELECTED`, `OPTIONS_VALIDATED` | A quiz answer is selected or validated.                       |
| `PURCHASE_TAPPED`                       | A purchase button is tapped and the checkout opens.           |
| `IN_APP_PURCHASED`                      | The checkout is completed.                                    |
| `LINK_OPENED`                           | An external link is opened from a Screen.                     |
| `STORE_BUTTON_CLICKED`                  | A store link is tapped on the success screen or in the email. |
| `REDEMPTION_BUTTON_CLICKED`             | The redemption button is tapped on the success screen.        |

See [UI & SDK events](ui-sdk-events-list) for the shared attributes.

## Events emitted in the app

On the app side, the activation emits one event to your SDK event listener and to your integrations:

| Event                 | When                                                                         | Notable properties                                                                                                                                        |
| --------------------- | ---------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `REDEMPTION_CONSUMED` | The subscription was activated in the app, or re-confirmed (`replay: true`). | `redemption.subscriptions`, `redemption.purchase_context` with `source: web2app`, the `utm_*` attributes and the user attributes collected in the funnel. |
| `REDEMPTION_FAILED`   | The link could not be consumed.                                              | `error_message`, `redemption.error_code`.                                                                                                                 |

From SDK 6.2, `REDEMPTION_CONSUMED` can trigger a [Campaign](campaigns). Details and payloads are on the [SDK integration](web2app-sdk-integration) page.

## Where each signal goes

| Signal                                           | Destination                                                                                     |
| ------------------------------------------------ | ----------------------------------------------------------------------------------------------- |
| Funnel steps, purchase taps, checkout completion | Purchasely dashboards and funnel view; ad platforms configured in Setup 4                       |
| Purchase confirmed by Stripe                     | Purchasely subscription, webhooks (`channel: web2app`), analytics integrations, Stripe metadata |
| Activation in the app                            | Webhooks for the app user, SDK `REDEMPTION_CONSUMED` event, Campaign trigger                    |
| Renewals, cancellations, refunds                 | Same lifecycle events as any subscription, with the same `channel` and `attribution`            |

## Troubleshooting

| Problem                                                       | Cause and solution                                                                               |
| ------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| `attribution` is missing on a web purchase.                   | The visitor arrived on the funnel without UTM parameters. Add them to the URLs used in your ads. |
| `channel` is `app2web` on a purchase I expected as `web2app`. | The Stripe subscription was created outside a Web Flow, by your website or your backend.         |
| `provider` is absent.                                         | The event concerns a native store purchase: `provider` exists for Stripe purchases only.         |
| My webhook does not receive `provider` or `attribution`.      | Your webhook uses payload version 2. Switch to version 3 in the webhook settings.                |
