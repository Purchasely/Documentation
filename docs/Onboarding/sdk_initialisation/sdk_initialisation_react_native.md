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

// Everything is optional except apiKey and storeKit1
// Example with default values
try {
    const configured = await Purchasely.start({
        apiKey: '<<X-API-KEY>>',
        storeKit1: false, // set to false to use StoreKit2, true to use StoreKit1,
        logLevel: LogLevels.ERROR, // set to debug in development mode to see logs
        userId: null, // if you know your user id, set it here
        runningMode: RunningMode.Full, // select between full and paywallObserver
        androidStores: ['Google'] // default is Google, don't forget to add the dependency to the same version
     });
} catch (e) {
     console.log("Purchasely SDK not configured properly");
}
```

# USER IDENTIFICATION

If you want the purchases and subscriptions to be associated to a user and not a device you can provide a user id in the`Purchasely.start()`method.