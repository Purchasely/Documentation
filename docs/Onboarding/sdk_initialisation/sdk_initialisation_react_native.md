---
title: React Native
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
# SDK INITIALISATION

```typescript React Native
import Purchasely from 'react-native-purchasely';

// Everything is optional except the apiKey
// Example with default values
try {
    const configured = await Purchasely.builder('<<X-API-KEY>>')
        .appUserId(null)              // optional if you already know your user id
        .runningMode('full')          // 'observer' (default) | 'full'
        .logLevel('error')            // set to 'debug' in development mode to see logs
        .allowDeeplink(true)          // allow Purchasely to open deeplinks
        .allowCampaigns(true)         // allow Purchasely campaigns
        .stores(['google'])           // Android only: 'google' | 'huawei' | 'amazon'
        .storekitVersion('storeKit2') // iOS only: 'storeKit2' (default) | 'storeKit1'
        .start();
} catch (e) {
    console.log('Purchasely SDK not configured properly');
}
```

> 📘 In v6 the SDK is started with the fluent `Purchasely.builder(...)`. The old `Purchasely.start({...})` object method (and its `runningMode` / `logLevel` enums and the `storeKit1: true/false` boolean) has been removed. The default running mode is now `'observer'` — pass `.runningMode('full')` to let Purchasely own the purchase flow.

# STOREKIT VERSION

You must specify which StoreKit version you want to use with Purchasely for iOS devices: `'storeKit1'` or `'storeKit2'`. This replaces the old `storeKit1: true/false` boolean.

# USER IDENTIFICATION

If you want the purchases and subscriptions to be associated to a user and not a device you can provide a user id with the `.appUserId(...)` method of `Purchasely.builder(...)`.
