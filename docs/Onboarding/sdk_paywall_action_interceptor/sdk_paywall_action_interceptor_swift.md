---
title: Swift
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

```swift In-House
Purchasely.setPaywallActionsInterceptor { [weak self] (action, parameters, presentationInfos, proceed) in
    switch action {
    // Intercept the tap on purchase to display the terms and condition
    case .purchase:        
        // Grab the plan to purchase
        guard let plan = parameters?.plan, let appleProductId = plan.appleProductId else {
            return
        }

        let success = MyPurchaseSystem.purchase(appleProductId)
        if success {
            Purchasely.synchronize() // synchronize new purchase with Purchasely
        }
        proceed(false) // notify Purchasely paywall to stop processing action
    case .restore:
        MyPurchaseSystem.restorePurchases()
        Purchasely.synchronize() // synchronize all purchases with Purchasely
        proceed(false) // notify Purchasely paywall to stop processing action
    default:
        proceed(true) // notify Purchasely paywall to continue other actions
    }
}
```
```swift RevenueCat
Purchasely.setPaywallActionsInterceptor { [weak self] (action, parameters, presentationInfos, proceed) in
    switch action {
    // Intercept the tap on purchase to display the terms and condition
    case .purchase:
        // Grab the plan to purchase
        guard let plan = parameters?.plan, let appleProductId = plan.appleProductId else {
            return
        }

        Purchases.shared.getOfferings { (offerings, error) in
            if let packages = offerings?.current?.availablePackages {
                if let package = packages.first(where: { $0.storeProduct.productIdentifier == appleProductId }) {
                    Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
                        /** IMPORTANT for Purchasely **/
                        // synchronize new purchase with Purchasely
                        Purchasely.synchronize()
                        // notify Purchasely paywall to stop processing action
                        proceed(false)

                        if customerInfo.entitlements["your_entitlement_id"]?.isActive == true {
                            // Unlock that great "pro" content              
                        }
                    }
                }
            }
        }
    case .restore:
        Purchases.shared.restorePurchases { customerInfo, error in
            /** IMPORTANT for Purchasely **/
            // synchronize new purchase with Purchasely
            Purchasely.synchronize()
            // notify Purchasely paywall to stop processing action
            proceed(false)
        }
    default:
        proceed(true) // notify Purchasely paywall to continue other actions
    }
}
```
