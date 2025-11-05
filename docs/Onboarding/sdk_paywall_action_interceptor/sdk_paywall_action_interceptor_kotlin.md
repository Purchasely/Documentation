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
Here is a code sample using the Paywall Action Interceptor to perform the purchase and restore actions triggered from Purchasely's paywall with your own purchase system

```kotlin In-House
Purchasely.setPaywallActionsInterceptor { info, action, parameters, processAction ->
    when(action) {
        PLYPresentationAction.PURCHASE -> {
            val subscriptionId = parameters.subscriptionOffer?.subscriptionId
            val basePlanId = parameters.subscriptionOffer?.basePlanId
            val offerId = parameters.subscriptionOffer?.offerId
            val offerToken = parameters.subscriptionOffer?.offerToken
            
            // you just need to pass the offerToken to BillingClient
            val success = MyPurchaseSystem.purchase(offerToken)
          
            if(success) {
              Purchasely.synchronize() // synchronize new purchase
            }
            
            processAction(false) // notify Purchasely paywall to stop processing action
        }
        PLYPresentationAction.RESTORE -> {
            MyPurchaseSystem.restoreAllPurchases()
            Purchasely.synchronize() // synchronize all purchases with Purchasely
            processAction(false) // notify Purchasely paywall to stop processing action
        }
        else -> processAction(true) // notify Purchasely paywall to continue other actions
    }
}
```
```kotlin RevenueCat
Purchasely.setPaywallActionsInterceptor { info, action, parameters, processAction ->
    when(action) {
        PLYPresentationAction.PURCHASE -> {
            val subscriptionId = parameters.subscriptionOffer?.subscriptionId
            val basePlanId = parameters.subscriptionOffer?.basePlanId
            val offerId = parameters.subscriptionOffer?.offerId
            val offerToken = parameters.subscriptionOffer?.offerToken
            
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
                            //stop process on Purchasely side
			    processAction(false)
                        },
                        onSuccess = { product, customerInfo ->
                            //stop process on Purchasely side
			    processAction(false)
                            if (customerInfo.entitlements["my_entitlement_identifier"]?.isActive == true) {
                                // Unlock that content and synchronize with Purchasely
                                Purchasely.synchronize()
                                processAction(false)
                            }
                    })
                }
            }
        }
        PLYPresentationAction.RESTORE -> {
           // restore purchases with RevenueCat
            Purchases.sharedInstance.restorePurchases(::showError) { customerInfo ->
                //... check customerInfo to see if entitlement is now active
                
                //one this is done, stop Purchasely process and synchronize
	        			processAction(false)
                Purchasely.synchronize() // synchronize all purchases with Purchasely
            }
        }
        else -> processAction(true) // notify Purchasely paywall to continue other actions
    }
}
```
