---
title: Web2App FAQ · SDK version
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
# Why is SDK 6.1 required?

Activating a web subscription in the app is handled by the SDK: it recognizes the redemption link, calls Purchasely, refreshes the entitlements and confirms the activation to the user. This logic ships with SDK 6.1. On older versions, subscribers can pay on the web but cannot activate the subscription in the app. See [Setup 3 · Verify your mobile app](web2app-setup-mobile-app).

# Do I need SDK 6.2 for anything?

Only to trigger a Campaign on the `REDEMPTION_CONSUMED` event, for example a welcome Screen for web subscribers. Activation itself works from 6.1.

# How do I update?

Bump the Purchasely SDK to 6.1 or later and ship a new build: [iOS](installation-swift) · [Android](installation-kotlin) · [Flutter](installation-flutter) · [React Native](installation-react-native) · [Cordova](installation-cordova).

# How is my version detected?

From the SDK events received from your app over the last 28 days, per platform, with the average daily app starts. It is informative only: the step completes when you confirm each platform yourself.

# Most of my users still run an older version. Should I wait?

No. Web subscribers open the app right after paying, so what matters is that a user who installs or updates your app today gets SDK 6.1 or later. Confirm a platform when the 6.1+ build is the current store version, its staged rollout is at 100%, and both iOS and Android are done: you cannot know which device a visitor will use.

# A platform shows Not detected

Purchasely received no event from that platform in 28 days. Check the SDK initialization if you ship on it; if you do not, you can still confirm it to complete the step.

# Do I need to write code beyond updating?

Only forwarding deeplinks to the SDK, which your app already does if it handles Purchasely deeplinks. Optional hooks to customize the welcome experience are described in [SDK integration](web2app-sdk-integration).
