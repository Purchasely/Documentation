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
// Intercept the tap on purchase to display the terms and condition
Purchasely.interceptAction(.purchase) { info, params, completion in
    // Grab the plan to purchase
    guard let plan = params?.plan, let appleProductId = plan.appleProductId else {
        completion(.notHandled)
        return
    }

    let success = MyPurchaseSystem.purchase(appleProductId)
    if success {
        Purchasely.synchronize() // synchronize new purchase with Purchasely
        completion(.success) // notify Purchasely paywall the action was handled
    } else {
        completion(.failed)
    }
}

Purchasely.interceptAction(.restore) { info, params, completion in
    MyPurchaseSystem.restorePurchases()
    Purchasely.synchronize() // synchronize all purchases with Purchasely
    completion(.success) // notify Purchasely paywall the action was handled
}
```
```swift RevenueCat
// Intercept the tap on purchase to display the terms and condition
Purchasely.interceptAction(.purchase) { info, params, completion in
    // Grab the plan to purchase
    guard let plan = params?.plan, let appleProductId = plan.appleProductId else {
        completion(.notHandled)
        return
    }

    Purchases.shared.getOfferings { (offerings, error) in
        if let packages = offerings?.current?.availablePackages {
            if let package = packages.first(where: { $0.storeProduct.productIdentifier == appleProductId }) {
                Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
                    /** IMPORTANT for Purchasely **/
                    // synchronize new purchase with Purchasely
                    Purchasely.synchronize()
                    // notify Purchasely paywall the action was handled
                    completion(.success)

                    if customerInfo.entitlements["your_entitlement_id"]?.isActive == true {
                        // Unlock that great "pro" content              
                    }
                }
            }
        }
    }
}

Purchasely.interceptAction(.restore) { info, params, completion in
    Purchases.shared.restorePurchases { customerInfo, error in
        /** IMPORTANT for Purchasely **/
        // synchronize new purchase with Purchasely
        Purchasely.synchronize()
        // notify Purchasely paywall the action was handled
        completion(.success)
    }
}
```
