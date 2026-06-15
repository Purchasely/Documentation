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

* Display a paywall
* Display a placement
* Update credit card (Deeplink to App Store)

Deeplinks are also used to preview paywalls and screen on your device (directly inside your app) by scanning a QR code displayed in the upper right corner of the Paywall builder inside the Console.

<Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/543fe33-image.png" />

Only a certain type of deeplinks, matching a specific pattern are recognized and handled by Purchasely. 

Deeplinks which do not match the pattern are just ignored

# How to enable deeplinks management with the SDK?

To integrate these automations:

1. Pass the deeplink to Purchasely when it is received by the application — **not required on Android**, where the SDK intercepts Purchasely deeplinks automatically
2. Optionally control when Purchasely is allowed to display content over your interface

<WhenShouldIAllowTheDisplayOfDeeplinks />

<br />

# Can I control when deeplinks are displayed?

By **default**, Purchasely deeplinks are displayed **immediately** when they are received — you don't have to do anything.

If your app has a launch routine that must complete before a screen can be shown (splash screen, onboarding, login…), you can **temporarily prevent** the display with `Purchasely.allowDeeplink(false)` and re-enable it with `Purchasely.allowDeeplink(true)` once your app is ready.
