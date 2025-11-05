---
title: Implementing promotional offers into your app
excerpt: >-
  This section provides details on how to handle promotional offers into your
  app
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
> 📘 Availability
>
> The feature described in this section is supported starting from version 4.0.0 of Purchasely SDK.
>
> If you use a prior version of the SDK your users won’t see a discount and will purchase at the regular price.

Promotional offers can be used to offer a specific discount to current or past subscribers. It is a great way to retain or win-back a customer. You will be able to set up as many as you want by creating specific paywalls with those offers.

# `full` mode - Trigger the purchase of an offer

In `full mode` Purchasely handles automatically the promotional offer purchase directly from a Purchasely Paywall and you have nothing to do.

If you are [using your own paywall](use-your-own-paywall) or need the SDK to process the promotional offer transaction from your own purchase buttons, you can do it really easily by providing the `PLYPlan` and `PLYOffer` you want to use for the purchase

```swift Swift
// First get the plan you want to purchase
Purchasely.plan(with: "planId") { plan in
// Success completion
} failure: { error in 
// Failure completion
}

// Retrieve offer id
let promoOffer = plan.promoOffers.first(where: { $0.vendorId == promoOfferVendorId })

// Then purchase
Purchasely.purchaseWithPromotionalOffer(plan: plan,
                                        contentId: nil,
                                        storeOfferId: promoOffer.storeOfferId) {                    
// Success completion       
} failure: { error in
// Failure completion                    
}

...

// We also offer the possibility to sign your promotional offers 
// if you want to purchase with your own system
Purchasely.signPromotionalOffer(storeProductId: "storeProductId",
                                storeOfferId: "storeOfferId") { signature in            
// Success completion
} failure: { error in
// Failure completion
}
```
```kotlin Kotlin
val plan = Purchasely.plan("plan_id on purchasely console")
val offer = plan?.promoOffers?.firstOrNull { it.vendorId == "offer_id on purchasely console" }

Purchasely.purchase(activity, plan, offer, onSuccess = { plan ->
  Log.d("Purchasely", "Purchase success with ${plan?.name}")
}, onError = {
  Log.e("Purchasely", "Purchase error", it)
})
```
```typescript React Native
// Purchase with the plan vendor id and promotional offer vendor id 
// set in Purchasely Console
try {
  const plan = await Purchasely.purchaseWithPlanVendorId(
    'PURCHASELY_PLUS_YEARLY',
    'PROMOTIONAL_OFFER_ID',
    null, // optional content id
  );
  console.log('Purchased plan: ' + plan);
} catch (e) {
  console.error(e);
}
```
```typescript Flutter
// Purchase with the plan vendor id and promotional offer vendor id 
// set in Purchasely Console
try {
    Map<dynamic, dynamic> plan = await Purchasely.purchaseWithPlanVendorId(
        vendorId: 'PURCHASELY_PLUS_MONTHLY', offerId: 'PROMOTIONAL_OFFER_ID');
    print('Purchased plan is $plan');
} catch (e) {
    print(e);
}
```

# `paywallObserver` mode - Retrieve the offer to purchase

When you are using Purchasely in [`paywallObserver`](paywallobserver-mode) mode, you can:

1. retrieve the Plan and associated offer purchased by the user by using the [paywall action interceptor](process-transactions-with-paywall-action-interceptor)
2. sign it (iOS only) 
3. and do the purchase with your own transaction processor

<br />

Here is a code sample to sign the offer on iOS:

> 🚧 iOS applicationUserName or appAccountToken
>
> On iOS, you must use Purchasely **anonymous user in lowercase** as **applicationUsername** with StoreKit1 or **appAccountToken** with StoreKit2 if you use `Purchasely.signPromotionalOffer()` method\
> Please look at sample code below for more details

```swift Swift
Purchasely.setPaywallActionsInterceptor { [weak self] (action, parameters, presentationInfos, proceed) in
	switch action {
		// Intercept the tap on purchase to display the terms and condition
		case .purchase:		
			// Grab the plan to purchase
			guard let plan = parameters?.plan, let appleProductId = plan.appleProductId else {
				proceed(false)
				return
			}
			
			let offer = parameters?.promoOffer
	
			// sign the offer
        		Purchasely.signPromotionalOffer(storeProductId: appleProductId,
        						storeOfferId: offer?.storeOfferId) { signature in
            		// Success completion
       		 	} failure: { error in
            		// Failure completion
        		}
				
			// Purchase with signature
			
			// Using StoreKit1
			purchaseUsingStoreKit1(plan) 
			// Using StoreKit2
			purchaseUsingStoreKit2(plan)
			
			// Finally close the process with Purchasely
			proceed(false)
		default:
			proceed(true)
	}
}

func purchaseUsingStoreKit1(_ plan: PLYPlan) {

  // First step: Get SKProduct using your own service

  // Example
  let request = SKProductsRequest(productIdentifiers: Set<String>([plan.appleProductId ?? ""]))
  request.delegate = <Your delegate> // Get Product in the `productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse)` method
  request.start()

  // Second Request payment
  guard SKPaymentQueue.canMakePayments() else {
    return nil
  }

  let payment = SKMutablePayment(product: product)

  payment.applicationUsername = Purchasely.anonymousUserId.lowercased() // lowercase anonymous user id is mandatory

  if let signature = promotionalOfferSignature, #available(iOS 12.2, macOS 10.14.4, tvOS 12.2, *) {
    let paymentDiscount = SKPaymentDiscount(identifier: signature.identifier,
                                            keyIdentifier: signature.keyIdentifier,
                                            nonce: signature.nonce,
                                            signature: signature.signature,
                                            timestamp: NSNumber(value: signature.timestamp))
    payment.paymentDiscount = paymentDiscount
  }

  SKPaymentQueue.default().add(payment)
}

func purchaseUsingStoreKit2(_ plan: PLYPlan) {
    if #available(iOS 15.0, *) {
      Purchasely.signPromotionalOffer(storeProductId: plan.appleProductId,
                                      storeOfferId: plan.promoOffers.first?.storeOfferId,
                                      success: { promoOfferSignature in

               Task {

                 do {
                   let products = try await Product.products(for: ["storeProductId"])
                   var options: Set<Product.PurchaseOption> = [.simulatesAskToBuyInSandbox(<Bool: true for testing>)]

                   let userId = Purchasely.anonymousUserId.lowercased()
                   options.insert(.appAccountToken(userId))

                   if let decodedSignature = Data(base64Encoded: promoOfferSignature.signature) {
                    let offerOption:Product.PurchaseOption = .promotionalOffer(offerID: promoOfferSignature.identifier,
                                                                               keyID: promoOfferSignature.keyIdentifier,
                                                                               nonce: promoOfferSignature.nonce,
                                                                               signature: decodedSignature,
                                                                               timestamp: Int(promoOfferSignature.timestamp))
                     options.insert(offerOption)
                   }

                    if let product = products.first {
                       let purchaseResult = try await product.purchase(options: options)
                    }                        
                 }
               }
           }, failure: { error in
           })
      } else {
        // Fallback on earlier versions
      }
    }
}
```
```kotlin Kotlin
Purchasely.setPaywallActionsInterceptor { info, action, parameters, processAction ->
    when(action) {
        PLYPresentationAction.PURCHASE -> {
            val sku = parameters.subscriptionOffer?.subscriptionId
            val basePlanId = parameters.subscriptionOffer?.basePlanId
            val offerId = parameters.subscriptionOffer?.offerId
            val offerToken = parameters.subscriptionOffer?.offerToken

            // TODO purchase with SKU and offer id
            
            // Finally close the process with Purchasely
            processAction(false)
        }
        else -> processAction(true)
    }
}
```
```typescript React Native
Purchasely.setPaywallActionInterceptorCallback((result) => {
    switch (result.action) {
      case PLYPaywallAction.PURCHASE:
        // Retrieve the store product id and offer id
        const storeProductId = result.parameters.plan?.productId;
        const storeOfferId = result.parameters.offer?.storeOfferId;

        // -- GOOGLE ONLY --
        // Alternatively, just for Google with v5 and v6 you can retrieve everything if it simpler for you,
        // specially if you want the offer token
        const productId = result.parameters.subscriptionOffer?.subscriptionId;
        const basePlanId = result.parameters.subscriptionOffer?.basePlanId;
        const offerId = result.parameters.subscriptionOffer?.offerId;
        const offerToken = result.parameters.subscriptionOffer?.offerToken;
        // -- END GOOGLE --

        // -- APPLE ONLY --
        if(storeOfferId != null) {
          try {
            async() => {
              const signature = await Purchasely.signPromotionalOffer(storeProductId, storeOfferId);
              const anonymousUserId = await Purchasely.getAnonymousUserId();
              const appTokenUserId = anonymousUserId.toLowerCase();

              // You need the signature and appTokenUserId to validate the offer
            }
          } catch (e) {
            console.log("Error while signing promotional offer");
            console.error(e);
          }
        }
        // -- END APPLE --


        // Now that you have the ids you need, you can launch your purchase flow

        // Hide Purchasely paywall if you want
        Purchasely.hidePresentation();

        // TODO launch purchase flow

        // When purchase is done, call this method to stop loader on Purchasely paywall
        Purchasely.onProcessAction(false);

        // if successful, close the paywall
        Purchasely.closePresentation();

        // if not successful, display the paywall again
        Purchasely.showPresentation()
        break;
      default:
        Purchasely.onProcessAction(true);
    }
  });
```
```typescript Flutter
Purchasely.setPaywallActionInterceptorCallback(
          (PaywallActionInterceptorResult result) {
  if (result.action == PLYPaywallAction.purchase) {
    // Retrieve the store product id and offer id
      String? storeProductId = result.parameters.plan?.productId;
      String? storeOfferId = result.parameters.offer?.storeOfferId;

      // -- GOOGLE ONLY --
      // Alternatively, just for Google with v5 and v6 you can retrieve everything if it simpler for you,
      // specially if you want the offer token
      String? productId = result.parameters.subscriptionOffer?.subscriptionId;
      String? basePlanId = result.parameters.subscriptionOffer?.basePlanId;
      String? offerId = result.parameters.subscriptionOffer?.offerId;
      String? offerToken = result.parameters.subscriptionOffer?.offerToken;
      // -- END GOOGLE --

      // -- APPLE ONLY --
      if(storeProductId != null && storeOfferId != null) {
        try {
          Map signature = await Purchasely.signPromotionalOffer(storeProductId, storeOfferId);
          String? anonymousUserId = await Purchasely.anonymousUserId;
          String? appTokenUserId = anonymousUserId.toLowerCase();

            // You need the signature and appTokenUserId to validate the offer
            // Signature contains those fields
            /*
              signature['identifier'] as String
              signature['signature'] as String
              signature['keyIdentifier'] as String
              signature['timestamp'] as int
            */
        } catch (e) {
          print("Error while signing promotional offer");
          print(e);
        }
      }
      // -- END APPLE --


      // Now that you have the ids you need, you can launch your purchase flow

      // Hide Purchasely paywall if you want
      Purchasely.hidePresentation();

      // TODO launch purchase flow

      // When purchase is done, call this method to stop loader on Purchasely paywall
      Purchasely.onProcessAction(false);

      // if successful, close the paywall
      Purchasely.closePresentation();

      // if not successful, display the paywall again
      Purchasely.showPresentation();
  } else {
    Purchasely.onProcessAction(true);
  }
});
```
