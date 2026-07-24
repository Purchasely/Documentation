---
title: App scheme
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
## Custom scheme or universal link?

A custom scheme (`sportelo://`) works immediately — no app update needed if it's already declared. Universal links open your app from an https link and feel more native, but require a manifest change and a new release.

## What do I need to change for universal links?

Add your web domain to the iOS [Associated Domains](https://developer.apple.com/documentation/xcode/supporting-associated-domains) and the Android [App Links intent filter](https://developer.android.com/training/app-links/verify-android-applinks), and host the `apple-app-site-association` and `assetlinks.json` files.

## How do I test it?

Trigger a purchase in your sandbox funnel with a [Stripe test card](https://docs.stripe.com/testing), then confirm the app opens and redeems the subscription from the success page.
