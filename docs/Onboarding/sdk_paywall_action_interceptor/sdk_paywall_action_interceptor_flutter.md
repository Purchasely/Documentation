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
Here is a code sample using the Action Interceptor to perform the purchase and restore actions triggered from Purchasely's paywall with your own purchase system.

Register **one handler per action kind** with `Purchasely.interceptAction(kind, handler)`. The handler returns a `PLYInterceptResult` (`success` / `failed` / `notHandled`) — there is no more `Purchasely.onProcessAction(bool)`.

> **Observer mode:** after handling a purchase, do your own billing, call `await Purchasely.synchronize()` and return `PLYInterceptResult.success`. In observer mode the presentation does **not** auto-close, so dismiss it yourself with `info.presentation?.close()`.

```dart In-House
import 'package:flutter/foundation.dart';
import 'package:purchasely_flutter/purchasely_flutter.dart';

await Purchasely.interceptAction(
  PLYPresentationActionKind.purchase,
  (info, payload) async {
    if (payload is! PLYPurchasePayload) {
      return PLYInterceptResult.notHandled;
    }
    try {
      // The store product id (sku) the user tapped on in the presentation
      final storeProductId = payload.plan.productId;

      if (defaultTargetPlatform == TargetPlatform.android) {
        // Only for Android you can retrieve the subscription offer details
        final basePlanId = payload.subscriptionOffer?.basePlanId;
        final offerId = payload.subscriptionOffer?.offerId;
        final offerToken = payload.subscriptionOffer?.offerToken;
      }

      final success = await MyPurchaseSystem.purchase(storeProductId);
      if (success) {
        await Purchasely.synchronize(); // synchronize new purchase with Purchasely
        // In observer mode, dismiss the presentation yourself
        await info.presentation?.close();
        return PLYInterceptResult.success; // notify Purchasely the action was handled
      }
      return PLYInterceptResult.failed;
    } catch (e) {
      print(e);
      return PLYInterceptResult.failed;
    }
  },
);

await Purchasely.interceptAction(
  PLYPresentationActionKind.restore,
  (info, payload) async {
    try {
      await MyPurchaseSystem.restoreAllPurchases();
      await Purchasely.synchronize(); // synchronize all purchases with Purchasely
      // In observer mode, dismiss the presentation yourself
      await info.presentation?.close();
      return PLYInterceptResult.success; // notify Purchasely the action was handled
    } catch (e) {
      // Error restoring purchases
      return PLYInterceptResult.failed;
    }
  },
);
```
```dart RevenueCat
import 'package:flutter/foundation.dart';
import 'package:purchasely_flutter/purchasely_flutter.dart';

await Purchasely.interceptAction(
  PLYPresentationActionKind.purchase,
  (info, payload) async {
    if (payload is! PLYPurchasePayload) {
      return PLYInterceptResult.notHandled;
    }
    try {
      // The store product id (sku) the user tapped on in the presentation
      final storeProductId = payload.plan.productId;

      if (defaultTargetPlatform == TargetPlatform.android) {
        // Only for Android you can retrieve the subscription offer details
        final basePlanId = payload.subscriptionOffer?.basePlanId;
        final offerId = payload.subscriptionOffer?.offerId;
        final offerToken = payload.subscriptionOffer?.offerToken;
      }

      final offerings = await Purchases.getOfferings();
      final monthly = offerings.current?.monthly;
      if (monthly != null) {
        // start purchase with RevenueCat
        final purchaserInfo = await Purchases.purchasePackage(monthly);
        if (purchaserInfo.entitlements.all['my_entitlement_identifier']?.isActive == true) {
          // Unlock that great "pro" content and synchronize with Purchasely
          await Purchasely.synchronize();
          // In observer mode, dismiss the presentation yourself
          await info.presentation?.close();
          return PLYInterceptResult.success; // notify Purchasely the action was handled
        }
      }
      return PLYInterceptResult.failed;
    } catch (e) {
      print(e);
      return PLYInterceptResult.failed;
    }
  },
);

await Purchasely.interceptAction(
  PLYPresentationActionKind.restore,
  (info, payload) async {
    try {
      final restoredInfo = await Purchases.restoreTransactions();
      // ... check restored purchaserInfo to see if entitlement is now active

      await Purchasely.synchronize(); // synchronize all purchases with Purchasely
      // In observer mode, dismiss the presentation yourself
      await info.presentation?.close();
      return PLYInterceptResult.success; // notify Purchasely the action was handled
    } catch (e) {
      // Error restoring purchases
      return PLYInterceptResult.failed;
    }
  },
);
```

You can register handlers for other action kinds the same way (e.g. `PLYPresentationActionKind.login`, `PLYPresentationActionKind.navigate` with its typed `PLYNavigatePayload`). To clean up, use `Purchasely.removeActionInterceptor(kind)` or `Purchasely.removeAllActionInterceptors()`.
