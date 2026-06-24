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

```dart Flutter
import 'package:purchasely_flutter/purchasely_flutter.dart';

// Everything is optional except the apiKey
// Example with default values
final bool configured = await Purchasely.apiKey('<<X-API-KEY>>')
    .appUserId(null)                              // optional if you already know your user id
    .runningMode(PLYRunningMode.observer)         // PLYRunningMode.observer (default) | full
    .logLevel(PLYLogLevel.error)                  // set to PLYLogLevel.debug in development mode to see logs
    .stores([PLYStore.google])                    // Android only: google | huawei | amazon
    .storekitVersion(PLYStorekitVersion.storeKit2) // iOS only: storeKit2 (default) | storeKit1
    .start();

if (!configured) {
  print('Purchasely SDK not configured');
  return;
}
```

> 📘 In v6 the SDK is started with the fluent `PurchaselyBuilder`. The old `Purchasely.start(...)` method and the v5 `PLYRunningMode` / `PLYLogLevel` enums (and the `storeKit1: true/false` boolean) have been removed. The default `PLYRunningMode` is now `PLYRunningMode.observer`, so observer mode no longer needs to be requested explicitly — but passing `.runningMode(PLYRunningMode.observer)` makes the intent clear. In observer mode your existing in-app purchase infrastructure keeps control of the purchase flow.

### STOREKIT VERSION

You must specify which StoreKit version you want to use with Purchasely for iOS devices: `PLYStorekitVersion.storeKit1` or `PLYStorekitVersion.storeKit2`. This replaces the old `storeKit1: true/false` boolean.

### USER IDENTIFICATION

If you want the purchases and subscriptions to be associated to a user and not a device you can provide a user id with the `.appUserId(...)` method of `PurchaselyBuilder`.
