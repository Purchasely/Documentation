---
title: paywallObserver - using the Paywall Action Interceptor
excerpt: >-
  This sections provides a detailed overview of how to use the Paywall Action
  Interceptor to process transactions in paywallObserver Mode
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: It's time to test that everything is functioning correctly
  pages:
    - type: basic
      slug: process-transactions-full-mode
      title: full mode
---
<PaywallActionInterceptorWhatIsIt />

<PaywallActionInterceptorActionsIntercepted />

# Implementing the Paywall Action Interceptor

The interceptor passes 4 parameters:

- `action`: the `PLYPresentationAction` enum that gives the type of action
- `parameters`: a dictionary that contains the objects needed to perform the action (like a `PLYPlan` for a purchase)
- `info`: the `PLYPresentationInfo` object containing the controller of the paywall to dismiss it or display content / error messages above it, and the presentation id and content id associated to this paywall
- `proceed`: a completion handler parameter with a boolean telling Purchasely if it should continue the action itself. In other words, returning `true` on a purchase action will lead the Purchasely SDK to trigger the native in-app purchase flow

> ⚠️ When should you call `proceed(true)`  after handling the action?
> 
> On a `login` action, call `proceed(true)` to refresh the paywall if the user has logged in
> 
> On a `purchase` action, if you've successfully handled the transaction, you should not call `proceed(true)` to avoid a second trigger of the native in-app purchase flow by the SDK
> 
> If you don't handle every action, you **HAVE TO ** call `proceed(true)` otherwise the bouton will keep spinning and nothing will happen.

## Processing transactions with your in-house system

Here is a code sample using the Paywall Action Interceptor to process transactions ** with your own in-house purchase system**, for the actions `purchase` and `restore`:

```swift
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
```kotlin
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
```javascript React Native
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
            Purchasely.closePresentation(); // close the current screen displayed by Purchasely
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
        Purchasely.closePresentation(); // close the current screen displayed by Purchasely
      } catch (e) {
        Purchasely.onProcessAction(false); // notify Purchasely paywall to stop processing action
      }
    } else {
      Purchasely.onProcessAction(true); // notify Purchasely paywall to continue other actions
    }
  });
```
```javascript Flutter
Purchasely.setPaywallActionInterceptorCallback(
          (PaywallActionInterceptorResult result) {
    if (result.action == PLYPaywallAction.purchase) {
      try {
        //the store product id (sku) the user clicked on in the paywall
        var productId = result.parameters.plan.productId
     
        if (Platform.isAndroid) {
           // Only for Android you can get other interesting parameters
          String subscriptionId = result.parameters.subscriptionOffer?.subscriptionId
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
```swift Cordova
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
```csharp Unity
purchasely.SetPaywallActionInterceptor(OnPaywallActionIntercepted);

private void OnPaywallActionIntercepted(PaywallAction action)
	{
		Log($"Purchasely Paywall Action Intercepted. Action: {action.action}.");

		switch (action.action)
		{
			case "purchase":
				var storeProductId = action.parameters.plan?.storeProductId;
				var basePlanId = action.parameters.plan?.basePlanId;
				var offerId = action.parameters.offer?.storeOfferId;

				MyPurchaseSystem.purchase(storeProductId, basePlanId, offerId);
				// if purchase successful, synchronize all purchases with Purchasely
				purchasely.Synchronize();
				
				// notify Purchasely paywall to stop processing action
				purchasely.ProcessPaywallAction(false);
        
        // dismiss the paywall if you want
        purchasely.ClosePresentation();

				break;
			case "restore":
				MyPurchaseSystem.restoreTransactions();
        // synchronize all purchases with Purchasely
				purchasely.Synchronize();
				// notify Purchasely paywall to stop processing action
				purchasely.ProcessPaywallAction(false);
        // dismiss the paywall if you want
        purchasely.ClosePresentation();
				break;
			default:
					purchasely.ProcessPaywallAction(true);
					break;
		}
}
```

> 🚧 Don't forget to call `synchronize()` after the transaction has been processed
> 
> Calling this method allows the Purchasely SDK to observe the transaction, i.e fetch the receipt and pass it to the Purchasely Platform to extract the data out of it without interfering with it

## Processing transaction with RevenueCat

Here is a code sample using the Paywall Action Interceptor to process transactions ** with RevenueCat**, for the actions `purchase` and `restore`:

```swift
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
```kotlin
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
```javascript React Native
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
              Purchasely.closePresentation(); // close the current screen displayed by Purchasely
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
        Purchasely.closePresentation(); // close the current screen displayed by Purchasely
      } catch (e) {
        Purchasely.onProcessAction(false); // notify Purchasely paywall to stop processing action
      }
    } else {
      Purchasely.onProcessAction(true); // notify Purchasely paywall to continue other actions
    }
  });
```
```javascript Flutter
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
```swift Cordova
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
```csharp Unity
purchasely.SetPaywallActionInterceptor(OnPaywallActionIntercepted);

private void OnPaywallActionIntercepted(PaywallAction action)
	{
		Log($"Purchasely Paywall Action Intercepted. Action: {action.action}.");

		switch (action.action)
		{
			case "purchase":
				var storeProductId = action.parameters.plan?.storeProductId;
				var basePlanId = action.parameters.plan?.basePlanId; //only for Android with Google
				var offerId = action.parameters.offer?.storeOfferId;
        
        var purchases = GetComponent<Purchases>();
        purchases.GetOfferings((offerings, error) =>
        {
          // Get the offering and product that matches the storeProductId and offerID
          // Here just a sample from RevenueCat documentation with the Monthly product
          if (offerings.Current != null && offerings.Current.Monthly != null){
            var product = offerings.Current.Monthly.Product;
            
            purchases.PurchasePackage(package, (product, customerInfo, userCancelled, error) =>
            {
              if (customerInfo.Entitlements.Active.ContainsKey("my_entitlement_identifier")) {
                // synchronize purchases with Purchasely
								purchasely.Synchronize();
              }
              
              // notify Purchasely paywall to stop processing action and hide loader
							purchasely.ProcessPaywallAction(false);
              
              // dismiss the paywall if you want
              purchasely.ClosePresentation();
            });
          }
        });
				break;
			case "restore":
				var purchases = GetComponent<Purchases>();
        purchases.RestorePurchases((info, error) =>
        {
            //... check purchaserInfo to see if entitlement is now active
          
          	// synchronize all purchases with Purchasely
            purchasely.Synchronize();
            // notify Purchasely paywall to stop processing action
            purchasely.ProcessPaywallAction(false);
            // dismiss the paywall if you want
            purchasely.ClosePresentation();
        }
				break;
			default:
					purchasely.ProcessPaywallAction(true);
					break;
		}
}
```

<br />

> 🚧 Don't forget to call `synchronize()` after the transaction has been processed
> 
> Calling this method allows the Purchasely SDK to observe the transaction, i.e fetch the receipt and pass it to the Purchasely Platform to extract the data out of it without interfering with it

<br />

[More details on the Paywall Action Interceptor and how to intercept of types of actions](paywall-action-interceptor)