---
title: Flutter observer
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
### SDK INITIALISATION

```typescript Flutter
// Everything is optional except apiKey and storeKit1
// Example with default values
bool configured = await Purchasely.start(
        apiKey: '<<X-API-KEY>>',
        androidStores: ['Google'], // default is Google, don't forget to add the dependency to the same version
        storeKit1: false, // set to false to use StoreKit2, true to use StoreKit1
        logLevel: PLYLogLevel.error, // set to debug in development mode to see logs
        runningMode: PLYRunningMode.paywallObserver, // select between full and paywallObserver
        userId: null, // set a user id if you have one
      );
    
if (!configured) {
        print('Purchasely SDK not configured');
        return;
}
```

### USER IDENTIFICATION

If you want the purchases and subscriptions to be associated to a user and not a device you can provide a user id in the `Purchasely.start()`method.
