---
title: Security - FAQ
excerpt: ''
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Why authenticate messages and verify signature?

Validating the webhook events is strongly recommended to verify that they are actually coming from the Purchasely platform.

The risk is to face a "man-in-the-middle" attack, where the attacker would forge fake webhook events and send them to your webhook endpoint to simulate the purchase of in-app subscriptions and to get entitlements granted for free (without paying for the subscription or the in-app purchase).

Thanks to the signature of the message and the `CLIENT SHARED SECRET` that you can find in the Purchasely Console ([App settings > Backend & SDK Configuration](https://console.purchasely.io/settings?step=sdk)) you can authenticate the messages and verify that the sender is indeed the Purchasely Platform.
