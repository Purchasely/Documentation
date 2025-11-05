---
title: SDK Deeplinks
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
# What is an app scheme?

App Scheme or Universal Links are used to open your app and navigate directly to a specific location or screen.

It is the equivalent of a URL for a web browser.

It's configured in your app and is specific to each mobile platform (iOS and Android).

Your mobile development team can provide the App Scheme for both Android and iOS

<WhatArePurchaselyDeeplinksUsedFor />

<br />

# What are Purchasely deeplinks used for?

Purchasely supports the use of Deeplinks to trigger different actions to improve conversion, retention and upsell. You can send a Push or an email with that deeplink and Purchasely will open the requested presentation or page for you.

Here are the actions Purchasely supports:

- Display a paywall
- Display a placement
- Update credit card (Deeplink to App Store)
- Display the user subscriptions
- Display the cancellation survey

Deeplinks are also used to preview paywalls and screen on your device (directly inside your app) by scanning a QR code displayed in the upper right corner of the Paywall builder inside the Console.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/543fe33-image.png",
        null,
        ""
      ],
      "align": "center",
      "sizing": "350px",
      "border": true
    }
  ]
}
[/block]


Only a certain type of deeplinks, matching a specific pattern are recognized and handled by Purchasely. 

Deeplinks which do not match the pattern are just ignored

# How to enable deeplinks management with the SDK?

To integrate these automations you need 2 things:

1. Pass the deeplink to Purchasley when it is received by the application
2. Allow Purchasely to display content over your interface

<WhenShouldIAllowTheDisplayOfDeeplinks />

<br />

# When should I allow the display of deeplinks?

Your app might have a launch routine that requires to be fulfilled before another screen can be displayed. It can be splash screen, on boarding, login …

The display of Purchasely deeplinks is deferred until you authorize it. Once your app is ready, notify the Purchasely SDK by calling the appropriate method referred on the left.