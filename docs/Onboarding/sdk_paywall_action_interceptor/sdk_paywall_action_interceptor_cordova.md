---
title: Cordova
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
    if (result.action === Purchasely.PaywallAction.purchase) {
        // the store product id (sku) the user clicked on in the paywall
        const storeProductId = result.parameters.plan.productId;

        MyPurchaseSystem.purchase(storeProductId, ({ success, error }) => {
            if (success) {
                // synchronize all purchases with Purchasely
                Purchasely.synchronize();
            }
            // notify Purchasely paywall to stop processing action
            Purchasely.onProcessAction(false);
        }, ({ error, userCancelled }) => {
            // Error making purchase
            Purchasely.onProcessAction(false);
        });
    } else if (result.action === Purchasely.PaywallAction.restore) {
        MyPurchaseSystem.restoreTransactions(
            info => {
                // synchronize all purchases with Purchasely
                Purchasely.synchronize();
                // notify Purchasely paywall to stop processing action
                Purchasely.onProcessAction(false);
            },
            error => {
                // Error restoring purchases
                // notify Purchasely paywall to stop processing action
                Purchasely.onProcessAction(false);
            }
        );
    } else {
        // notify Purchasely paywall to continue other actions
        Purchasely.onProcessAction(true);
    }
});
```
```kotlin RevenueCat
Purchasely.setPaywallActionInterceptorCallback((result) => {
    if (result.action === Purchasely.PaywallAction.purchase) {
      //the store product id (sku) the user clicked on in the paywall
      const storeProductId = result.parameters.plan.productId
      
      Purchases.getOfferings(
          offerings => {
            if (offerings.current && offerings.current.monthly) {  
              //get your package from RevenueCat
              const product = offerings.current.monthly;
             
              Purchases.purchasePackage(product, ({ productIdentifier, purchaserInfo }) => {
                  if (typeof purchaserInfo.entitlements.active.my_entitlement_identifier !== "undefined") {
                    // synchronize all purchases with Purchasely
                    Purchasely.synchronize();
                  }
                  // notify Purchasely paywall to stop processing action
          				Purchasely.onProcessAction(false);
                },
                ({error, userCancelled}) => {
                  // Error making purchase
                  Purchasely.onProcessAction(false)
                }
              );
            }
          },
          error => {
     				Purchasely.onProcessAction(false)
          }
      );
    } if (result.action === Purchasely.PaywallAction.restore) {
      Purchases.restoreTransactions(
        info => {
          // synchronize all purchases with Purchasely
          Purchasely.synchronize();
          // notify Purchasely paywall to stop processing action
          Purchasely.onProcessAction(false);
        },
        error => {
          // Error restoring purchases
          // notify Purchasely paywall to stop processing action
          Purchasely.onProcessAction(false);
        }
      );
    } else {
      // notify Purchasely paywall to continue other actions
      Purchasely.onProcessAction(true);
    }
  });
```
