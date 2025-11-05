---
title: Expired Subscription Attributes Limitations
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
<ExpiredSubscriptionAttributesLimitations />

The expired subscription attributes will not be set in the following cases:

* Subscriptions that expired before the integration of Purchasely into your app.
* Subscriptions that expired after the integration of Purchasely into your app but haven't been imported.

In these cases, only the attribute **Has expired subscription** will be set to true, as it is computed from the local receipt. The other attributes will not be set.

To summarize, these attributes can be leveraged to win back subscribers who churned recently, rather than to win back any lapsed subscribers in the history of your app.
