---
title: Flutter
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
final bool configured = await PurchaselyBuilder.apiKey('<<X-API-KEY>>')
    .appUserId(null)                             // optional if you already know your user id
    .runningMode(RunningMode.full)               // RunningMode.observer (default) | full
    .logLevel(LogLevel.error)                    // set to LogLevel.debug in development mode to see logs
    .stores([PLYStore.google])                   // Android only: google | huawei | amazon
    .storekitVersion(StorekitVersion.storeKit2)  // iOS only: storeKit2 (default) | storeKit1
    .start();

if (!configured) {
  print('Purchasely SDK not configured');
  return;
}
```

> 📘 In v6 the SDK is started with the fluent `PurchaselyBuilder`. The old `Purchasely.start(...)` method and the `PLYRunningMode` / `PLYLogLevel` enums (and the `storeKit1: true/false` boolean) have been removed. The default `RunningMode` is now `RunningMode.observer` — pass `.runningMode(RunningMode.full)` to let Purchasely own the purchase flow.

### STOREKIT VERSION

You must specify which StoreKit version you want to use with Purchasely for iOS devices: `StorekitVersion.storeKit1` or `StorekitVersion.storeKit2`. This replaces the old `storeKit1: true/false` boolean.

### USER IDENTIFICATION

If you want the purchases and subscriptions to be associated to a user and not a device you can provide a user id with the `.appUserId(...)` method of `PurchaselyBuilder`.
