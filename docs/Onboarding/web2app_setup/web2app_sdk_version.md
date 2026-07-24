---
title: SDK version
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
## Why SDK 6.1+?

Web subscription redemption relies on `consumeRedemption` and `handleDeepLink`, introduced in SDK 6.1. Without it, paying users can't activate their subscription in your app.

## How do I update?

Bump the Purchasely SDK to 6.1+ and ship a new build: [iOS](https://docs.purchasely.com/docs/installation-swift) · [Android](https://docs.purchasely.com/docs/installation-kotlin) · [Flutter](https://docs.purchasely.com/docs/installation-flutter) · [React Native](https://docs.purchasely.com/docs/installation-react-native)

## How is my version detected?

From the last SDK event received from your app, per platform.
