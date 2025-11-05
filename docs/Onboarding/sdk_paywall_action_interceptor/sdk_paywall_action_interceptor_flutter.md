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
Here is a code sample using the Paywall Action Interceptor to perform the purchase and restore actions triggered from Purchasely's paywall with your own purchase system

```kotlin In-House
Purchasely.setPaywallActionInterceptorCallback(
          (PaywallActionInterceptorResult result) {
    if (result.action == PLYPaywallAction.purchase) {
      try {
        //the store product id (sku) the user clicked on in the paywall
        var productId = result.parameters.plan.productId
        
        if(Platform.isAndroid) {
          // Only for Android you can get other interesting parameters
          String basePlanId = result.parameters.subscriptionOffer?.basePlanId;
          String offerId = result.parameters.subscriptionOffer?.offerId;
          String offerToken = result.parameters.subscriptionOffer?.offerToken;
        }
        
        bool success = await MyPurchaseSystem.purchase(productId);
        if (success) {
          // synchronize all purchases with Purchasely
          Purchasely.synchronize();
          // notify Purchasely paywall to stop processing action
          Purchasely.onProcessAction(false);
        }
      } catch (e) {
        Purchasely.onProcessAction(false);
        print(e);
      }
    } if (result.action == PLYPaywallAction.restore) {
      Purchasely.onProcessAction(false);
      
      try {
        await MyPurchaseSystem.restoreAllPurchases();
       
        // synchronize all purchases with Purchasely
        Purchasely.synchronize();
        // notify Purchasely paywall to stop processing action
        Purchasely.onProcessAction(false);
      } on PlatformException catch (e) {
        Purchasely.onProcessAction(false);
        // Error restoring purchases
      }
    } else {
      // notify Purchasely paywall to continue other actions
      Purchasely.onProcessAction(true);
    }
 });
```
```kotlin RevenueCat
Purchasely.setPaywallActionInterceptorCallback(
          (PaywallActionInterceptorResult result) {
    if (result.action == PLYPaywallAction.purchase) {
      try {
        //the store product id (sku) the user clicked on in the paywall
        var productId = result.parameters.plan.productId
        
        if(Platform.isAndroid) {
          // Only for Android you can get other interesting parameters
          String basePlanId = result.parameters.subscriptionOffer?.basePlanId;
          String offerId = result.parameters.subscriptionOffer?.offerId;
          String offerToken = result.parameters.subscriptionOffer?.offerToken;
        }
        
        Offerings offerings = await Purchases.getOfferings();
        if (offerings.current != null && offerings.current.monthly != null) {
          //get your product from revenuecat
          Product product = offerings.current.monthly.product;
          
          //start purchase
          PurchaserInfo purchaserInfo = await Purchases.purchasePackage(product);
          if (purchaserInfo.entitlements.all["my_entitlement_identifier"].isActive) {
            // synchronize all purchases with Purchasely
            Purchasely.synchronize();
          }
          // notify Purchasely paywall to stop processing action
          Purchasely.onProcessAction(false);
        }
      } catch (e) {
        Purchasely.onProcessAction(false);
        print(e);
      }
    } if (result.action == PLYPaywallAction.restore) {
      Purchasely.onProcessAction(false);
      
      try {
        PurchaserInfo restoredInfo = await Purchases.restoreTransactions();
        // ... check restored purchaserInfo to see if entitlement is now active
        
        // synchronize all purchases with Purchasely
        Purchasely.synchronize();
        // notify Purchasely paywall to stop processing action
        Purchasely.onProcessAction(false);
      } on PlatformException catch (e) {
        Purchasely.onProcessAction(false);
        // Error restoring purchases
      }
    } else {
      // notify Purchasely paywall to continue other actions
      Purchasely.onProcessAction(true);
    }
 });
```
