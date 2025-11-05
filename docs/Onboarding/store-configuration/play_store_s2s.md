---
title: Google Play Store S2S Notifications
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
# How to connect the Google Cloud Pub/Sub with Purchasely?

We connect to Google Cloud Pub/Sub automatically for you by using your service account access.\
Finalize the S2S connection by clicking on **Connect to Google** in the Purchasely Console and let it guide you.\
If you already have it configured with your own server or another provider, after clicking on the button select the topic that you have configured. Purchasely will add a subscription to the same topic to also receives notifications without other steps required on your side.

> 🚧 Manual configuration
>
> If the button is red, it means that we do no have the right to configure Pub/Sub notifications from Google cloud with the Access Key you have provided. In that case, you need to configure [Server to Server notifications](play-store-configuring-server-to-server-notifications) manually

<Image align="center" className="border" border={true} src="https://files.readme.io/93da668-image.png" />

<br />

<PlayStoreS2SNotifications />

<br />

# What are Google Play Store server-to-server notifications used for?

Google Play Store Server-to-server notifications are used to get real-time notifications of purchases and events associated to in-app purchase events or subscription lifecycle events.

They consist in messages, sent by the Google Play Store, every time an event occurs on a subscription. For instance, a message is sent when a subscription :

* is purchased
* is renewed
* is cancelled (auto-renewing cancelled by user for the following billing period)
* is refund
* gets expired
* encounters a billing issue\
  …

The server-to-server notifications are not mandatory for making subscriptions work, but they are very valuable in the sense that they bring a real-time and comprehensive vision for the app editor.
