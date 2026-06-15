---
title: Kotlin
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
Here is a code sample using the Action Interceptor to perform the purchase and restore actions triggered from Purchasely's paywall with your own purchase system

```kotlin In-House
Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
    val subscriptionId = purchase.subscriptionOffer?.subscriptionId
    val basePlanId = purchase.subscriptionOffer?.basePlanId
    val offerId = purchase.subscriptionOffer?.offerId
    val offerToken = purchase.subscriptionOffer?.offerToken

    // you just need to pass the offerToken to BillingClient
    val success = MyPurchaseSystem.purchase(offerToken)

    if (success) {
        Purchasely.synchronize() // synchronize new purchase
        PLYInterceptResult.SUCCESS
    } else {
        PLYInterceptResult.FAILED
    }
}

Purchasely.interceptAction<PLYPresentationAction.Restore> { info, _ ->
    MyPurchaseSystem.restoreAllPurchases()
    Purchasely.synchronize() // synchronize all purchases with Purchasely
    PLYInterceptResult.SUCCESS
}
```
```kotlin RevenueCat
Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
    val subscriptionId = purchase.subscriptionOffer?.subscriptionId
    val basePlanId = purchase.subscriptionOffer?.basePlanId
    val offerId = purchase.subscriptionOffer?.offerId
    val offerToken = purchase.subscriptionOffer?.offerToken

    //get RevenueCat package
    Purchases.sharedInstance.getOfferingsWith({ error ->
    // An error occurred
    }) { offerings ->
        offerings.current
            ?.availablePackages
            ?.takeUnless { it.isNullOrEmpty() }
            ?.let { list ->
             val rcPackage = list.firstOrNull { it.product.sku == subscriptionId }

             Purchases.sharedInstance.purchasePackage(
                this,
                rcPackage,
                onError = { error, userCancelled ->
                    /* No purchase */
                },
                onSuccess = { product, customerInfo ->
                    if (customerInfo.entitlements["my_entitlement_identifier"]?.isActive == true) {
                        // Unlock that content and synchronize with Purchasely
                        Purchasely.synchronize()
                    }
            })
        }
    }

    PLYInterceptResult.SUCCESS // notify Purchasely the action was handled
}

Purchasely.interceptAction<PLYPresentationAction.Restore> { info, _ ->
    // restore purchases with RevenueCat
    Purchases.sharedInstance.restorePurchases(::showError) { customerInfo ->
        //... check customerInfo to see if entitlement is now active

        Purchasely.synchronize() // synchronize all purchases with Purchasely
    }

    PLYInterceptResult.SUCCESS // notify Purchasely the action was handled
}
```
