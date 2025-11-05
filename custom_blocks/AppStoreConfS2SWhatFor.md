---
name: App Store Conf - S2S what for?
---
App Store Server Notifications are used to receive real-time notifications about the lifecycle of your client's purchases.

They consist in messages, sent by the App Store, every time an event occurs on a subscription. For instance, a message is sent when a subscription :

* is purchased
* is renewed
* won't renew because the user as canceled the auto-renewal
* is refund
* gets expired
* encounters a billing issue\
  …

The server-to-server notifications are not mandatory for making subscriptions work, but they are very valuable in the sense that they bring a real-time and comprehensive vision for the app editor

> 🚧 What happens if I do not activate the S2S?
>
> Until the expected renewal date of the original subscription, Purchasely won't be able to detect:
>
> * a **refund** (which means users may have a 1-year free subscription if they immediately ask for a refund on a yearly subscription)
> * a **plan change** (when they are bought outside the application)
> * a **cancellation of the renewal** (we won't know the user will churn at the next renewal)
