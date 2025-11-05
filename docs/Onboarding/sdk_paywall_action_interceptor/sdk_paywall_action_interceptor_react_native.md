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
Here is a code sample using the Paywall Action Interceptor to perform the purchase and restore actions triggered from Purchasely's paywall with your own purchase system

```kotlin In-House
Purchasely.setPaywallActionInterceptorCallback((result) => {
    if (result.action === PLYPaywallAction.PURCHASE) {
      try {
        //the store product id (sku) the user clicked on in the paywall
        String storeProductId = result.parameters.plan.productId
        
        if (Platform.OS === 'android') {
          // Only for Android you can retrieve other information about the purchase
          const basePlanId = result.parameters.subscriptionOffer?.basePlanId;
          const offerId = result.parameters.subscriptionOffer?.offerId;
          const offerToken = result.parameters.subscriptionOffer?.offerToken;
        }
        
        try {
          const success = await MyPurchaseSystem.purchase(storeProductId)
          if (success) {
            Purchasely.synchronize(); // synchronize all purchases with Purchasely
            Purchasely.onProcessAction(false); // notify Purchasely paywall to stop processing action
          }
        } catch (e) {
           Purchasely.onProcessAction(false); // notify Purchasely paywall to stop processing action
        }
      } catch (e) {
        console.log(e);
        Purchasely.onProcessAction(false); // notify Purchasely paywall to stop processing action
      }
    } else if (result.action === PLYPaywallAction.RESTORE) {
      try {
        const restore = await MyPurchaseSystem.restorePurchases();
        
        Purchasely.onProcessAction(false); // notify Purchasely paywall to stop processing action
        Purchasely.synchronize(); // synchronize all purchases with Purchasely
      } catch (e) {
        Purchasely.onProcessAction(false); // notify Purchasely paywall to stop processing action
      }
    } else {
      Purchasely.onProcessAction(true); // notify Purchasely paywall to continue other actions
    }
  });
```
```kotlin RevenueCat
Purchasely.setPaywallActionInterceptorCallback((result) => {
    if (result.action === PLYPaywallAction.PURCHASE) {
      try {
        //the store product id (sku) the user clicked on in the paywall
        String storeProductId = result.parameters.plan.productId
        
        if (Platform.OS === 'android') {
          // Only for Android you can retrieve other information about the purchase
          const basePlanId = result.parameters.subscriptionOffer?.basePlanId;
          const offerId = result.parameters.subscriptionOffer?.offerId;
          const offerToken = result.parameters.subscriptionOffer?.offerToken;
        }
        
        try {
          const offerings = await Purchases.getOfferings();
          if (offerings.current !== null && offerings.current.availablePackages.length !== 0) {
            //get your package
            const package = offerings.current.monthly;
            
            //and purchase with RevenueCat
            try {
              const {customerInfo, productIdentifier} = await Purchases.purchasePackage(package);
              if (typeof customerInfo.entitlements.active.my_entitlement_identifier !== "undefined") {
                Purchasely.synchronize(); // synchronize all purchases with Purchasely
              }
              Purchasely.onProcessAction(false); // notify Purchasely paywall to stop processing action
            } catch (e) {
              Purchasely.onProcessAction(false); // notify Purchasely paywall to stop processing action
              if (!e.userCancelled) {
                showError(e);
              }
            }
          }
        } catch (e) {
           Purchasely.onProcessAction(false); // notify Purchasely paywall to stop processing action
        }
      } catch (e) {
        console.log(e);
        Purchasely.onProcessAction(false); // notify Purchasely paywall to stop processing action
      }
    } else if (result.action === PLYPaywallAction.RESTORE) {
      try {
        const restore = await Purchases.restorePurchases();
        // ... check restored purchaserInfo to see if entitlement is now active
        
        Purchasely.onProcessAction(false); // notify Purchasely paywall to stop processing action
        Purchasely.synchronize(); // synchronize all purchases with Purchasely
      } catch (e) {
        Purchasely.onProcessAction(false); // notify Purchasely paywall to stop processing action
      }
    } else {
      Purchasely.onProcessAction(true); // notify Purchasely paywall to continue other actions
    }
  });
```
