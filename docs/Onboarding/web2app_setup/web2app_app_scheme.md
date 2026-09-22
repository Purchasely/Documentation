---
title: Web2App FAQ · App scheme
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
# What is the app scheme used for?

After the payment, the success screen and the receipt email open your app through its custom URL scheme, for example `yourapp://`. Purchasely builds the link; the scheme tells the phone which app to open. See [Setup 3 · Verify your mobile app](web2app-setup-mobile-app).

# Where do I find my app's scheme?

In your app project: under URL Types in the target's Info tab on iOS, in the intent-filter of your launch activity on Android. If your app already handles Purchasely deeplinks, it already declares one.

# My app does not declare a scheme yet

Add one and ship a new build: Apple's guide on [custom URL schemes](https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app), Android's guide on [deep links](https://developer.android.com/training/app-links/deep-linking). Pick a scheme specific to your app to avoid collisions with other apps on the device.

# Can I use universal links or App Links instead?

Not for redemption today: links use the custom scheme only.

# Are the iOS and Android schemes different?

They are entered per platform, in the Apple and Google tabs, and are usually the same value. Purchasely picks the right one from the device that opens the link. The scheme is shared with App settings → Stores.

# How do I test it?

Open the sandbox URL of a Web Flow on your phone, pay with a [Stripe test card](https://docs.stripe.com/testing), then tap the button on the success screen. The app must open and confirm the activation. See [Test and go live](web2app-test-and-go-live).
