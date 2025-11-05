---
title: App Store Server Notification
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
# Where can I report the S2S Notifications end point in the App Store Connect Console?

<AppStoreConfS2SNotifications />

<br />

⚠️ This step is only available in the App Store Connect Console once you've created your first In-App Subscription.

[More details on managing In-App Subscriptions in the App Store](app-store-managing-in-app-subscriptions)

To plug App Store Server Notifications with the Purchasely platform, follow these steps:

1. Open App Store Connect, 
2. Go to My Apps and select the desired app
3. Navigate to the section General > App information
4. In the sub-section App Store Server Notifications, edit the Product Server URL

   [block:image]{"images":[{"image":["https://files.readme.io/7248fa4-image.png",null,""],"align":"center","border":true}]}[/block]
5. Paste the value from the field Server to server endpoint in the Purchasely Console

   [block:image]{"images":[{"image":["https://files.readme.io/a511a4e-image.png",null,""],"align":"center","border":true}]}[/block]

# What are App Store Server Notifications used for?

<AppStoreConfS2SWhatFor />

App Store Server Notifications are used to receive real-time notifications about the lifecycle of your client's purchases.

They consist in messages, sent by the App Store, every time an event occurs on a subscription. For instance, a message is sent when a subscription :

- is purchased
- is renewed
- won't renew because the user as canceled the auto-renewal
- is refund
- gets expired
- encounters a billing issue  
  …

The server-to-server notifications are not mandatory for making subscriptions work, but they are very valuable in the sense that they bring a real-time and comprehensive vision for the app editor

<br />

# I am already using the App Store Server Notifications, how can I plug Purchasely?

App Store Connect only allows setting one endpoint url for S2S in production and sandbox mode. To circumvent this limitation, you can enable our S2S Forwardings integration in Purchasely console.

If you are already using S2S notification with your existing Subscription Infrastructure, you can:

1. In the Purchasely Console on the left, go to `Integrations`, activate the Server to `Server Notifications Forwarding` and fill in the fields `Raw S2S forwarding endpoint URL (Production & Sandbox)` with the values currently configured in your App Store Connect Console.
2. In App Store Connect Console, replace the existing values with the App Store Server Notifications End Point URL that you can copy from the Purchasely Console on the left side of this block