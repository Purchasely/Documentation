---
title: Server to Server Notifications forwarding
excerpt: This page describes how to use S2S forwarding from Purchasely console
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The Apple Server to Server Notifications are used to receive real-time notifications about the lifecycle of your client's purchases. 

They consist in messages, sent by the App Store, every time an event occurs on a subscription. For instance, a message is sent when a subscription :

* is purchased
* is renewed
* won't renew because the user as canceled the auto-renewal
* is refund
* gets expired
* encounters a billing issue\
  …

In the Apple App Store Connect, you can only add only one Production Server and Sandbox Server URL to receive Server to Server notification. Hence its recommended to add Purchasely URL here. 

<Image align="center" className="border" border={true} src="https://files.readme.io/b3501e4-image.png" />

If you would like to receive these notification to your servers, you can add the URL to the S2S Forwardings in Purchasely Integrations. 

<Image align="center" className="border" border={true} src="https://files.readme.io/2748cb8-image.png" />

In the following page, you have to turn on the Integration enabled toggle button, add your production and sandbox server URL in the respective text boxes. 

<Image align="center" className="border" border={true} src="https://files.readme.io/06d8c71-image.png" />
