---
title: mParticle
excerpt: >-
  Purchasely sends the Server Events of your subscribers to mParticle, server
  to server
deprecated: false
hidden: true
metadata:
  title: ''
  description: >-
    Send the Purchasely Server Events to mParticle. Give the mParticle ID (MPID)
    of the user to the Purchasely SDK, activate the integration in the
    Purchasely Console and select the events to send.
  robots: index
next:
  description: ''
---
# Overview

[mParticle](https://www.mparticle.com/) is a customer data platform (CDP). With this integration, Purchasely sends the [Server Events](server-events) of your subscribers to mParticle, server to server. mParticle can then forward them to the other tools of your stack.

<Image align="center" border={true} src="TODO-mparticle-flow.png" alt="The app gives the MPID to Purchasely, and Purchasely sends the Server Events to mParticle" />

What the integration sends:

- **Server Events**: subscription lifecycle, offers and transactions. You select the events in the Console.
- **Not sent**: the UI / SDK Events and the user properties. To send the UI / SDK Events to mParticle, forward them from your app with the mParticle SDK. Refer to [UI / SDK Events](ui-sdk-events).

The integration requires 3 steps:

1. Give the mParticle ID (MPID) of the user to Purchasely (SDK implementation)
2. Activate the **mparticle** integration in the Purchasely Console
3. Select the Server Events to send

<br />

# 1 - Give the MPID to Purchasely (SDK implementation)

mParticle matches each event to a user with the MPID. Get the MPID of the current user from the mParticle SDK, and give it to Purchasely with `setAttribute`:

```swift Swift
if let mpid = MParticle.sharedInstance().identity.currentUser?.userId {
    Purchasely.setAttribute(.mParticleUserId, value: mpid.stringValue)
}
```
```kotlin Kotlin
MParticle.getInstance()?.Identity()?.currentUser?.id?.let { mpid ->
    Purchasely.setAttribute(Attribute.MPARTICLE_USER_ID, mpid.toString())
}
```
```typescript React Native
// mpid: the MPID of the current user, from the mParticle SDK
Purchasely.setAttribute(Attributes.MPARTICLE_USER_ID, mpid);
```
```dart Flutter
// mpid: the MPID of the current user, from the mParticle SDK
Purchasely.setAttribute(PLYAttribute.mParticleUserId, mpid);
```
```javascript Cordova
// mpid: the MPID of the current user, from the mParticle SDK
Purchasely.setAttribute(Purchasely.Attribute.MPARTICLE_USER_ID, mpid);
```

<Callout icon="🚧" theme="warn">
  ### Without an MPID, Purchasely sends nothing

  Purchasely sends an event to mParticle only if the user has an MPID. The MPID can change after a login or a logout in mParticle. Set the attribute again after each identity change in mParticle.
</Callout>

**Stripe purchases**: there is no SDK in the loop. Send the MPID in the `integration_mparticle_user_id` field of the receipt. Refer to [Stripe configuration](stripe-configuration).

<br />

# 2 - Activate the mParticle integration

## Get your mParticle credentials

Purchasely sends the events to the mParticle server-to-server API. This API needs a key and a secret:

1. In mParticle, open **Setup** > **Inputs** > **Feeds**.
2. Add a **Custom Feed**.
3. Copy the server-to-server key and the secret.

## Activate the integration in the Purchasely Console

1. In the Purchasely Console, open the [Integrations](https://console.purchasely.io/external-integrations) section and click **mparticle**.
2. Activate the integration.
3. Enter the API key.

<Callout icon="📘" theme="info">
  ### API secret

  The integration also needs the API secret. Contact the Purchasely support team to set it on your app.
</Callout>

<br />

# 3 - Select the Server Events

In the **Server events** tab of the integration, enable each event that you want to send. You can also change the name of each event.

How Purchasely sends the events:

| Purchasely event | mParticle event type | Content |
| :-- | :-- | :-- |
| `TRANSACTION_PROCESSED` | Commerce event, action `purchase` | Transaction ID, product, price and total amount, promotional offer, and the event attributes |
| All other Server Events | Custom event, type `transaction` | The event attributes |

- The event attributes are the [Server Events attributes](server-events-attributes): plan, product, store, offer type, subscription status, placement, screen, A/B test, audience and more.
- Purchasely sends sandbox purchases with the `development` environment and real purchases with the `production` environment.

<EventsIntegration />

<br />

# Test the integration

1. Install your app on a test device and make sure that the app sets the MPID.
2. Make a sandbox purchase.
3. In mParticle, open **Live Stream** and select the `development` environment. The Purchasely events show with the MPID of your test user.
