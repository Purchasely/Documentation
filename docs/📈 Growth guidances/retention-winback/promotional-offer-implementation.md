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

# `observer` mode - Retrieve the offer to purchase

When you are using Purchasely in [`observer`](observer-mode) mode, you can:

1. retrieve the Plan and associated offer purchased by the user by using the [action interceptor](process-transactions-with-paywall-action-interceptor)
2. sign it (iOS only) 
3. and do the purchase with your own transaction processor

<br />

Here is a code sample to sign the offer on iOS:

> 🚧 iOS applicationUserName or appAccountToken
>
> On iOS, you must use Purchasely **anonymous user in lowercase** as **applicationUsername** with StoreKit1 or **appAccountToken** with StoreKit2 if you use `Purchasely.signPromotionalOffer()` method\
> Please look at sample code below for more details

```swift Swift
// Intercept the tap on purchase to display the terms and condition
Purchasely.interceptAction(.purchase) { [weak self] info, params, completion in
	// Grab the plan to purchase
	guard let plan = params?.plan, let appleProductId = plan.appleProductId else {
		completion(.success)
		return
	}

	let offer = params?.promoOffer

	// sign the offer
	Purchasely.signPromotionalOffer(storeProductId: appleProductId,
					storeOfferId: offer?.storeOfferId) { signature in
		// Success completion
	} failure: { error in
		// Failure completion
	}

	// Purchase with signature

	// Using StoreKit1
	self?.purchaseUsingStoreKit1(plan)
	// Using StoreKit2
	self?.purchaseUsingStoreKit2(plan)

	// Finally close the process with Purchasely
	completion(.success)
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
Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
    val sku = purchase.subscriptionOffer?.subscriptionId
    val basePlanId = purchase.subscriptionOffer?.basePlanId
    val offerId = purchase.subscriptionOffer?.offerId
    val offerToken = purchase.subscriptionOffer?.offerToken

    // TODO purchase with SKU and offer id

    // Finally close the process with Purchasely
    PLYInterceptResult.SUCCESS
}
```
```typescript React Native
Purchasely.interceptAction('purchase', async (info, payload) => {
  if (payload?.kind !== 'purchase') {
    return 'notHandled';
  }

  // Retrieve the store product id and offer id
  const storeProductId = payload.plan?.productId;
  const storeOfferId = payload.offer?.storeOfferId;

  // -- GOOGLE ONLY --
  // Alternatively, just for Google you can retrieve everything if it is simpler for you,
  // specially if you want the offer token
  const productId = payload.subscriptionOffer?.subscriptionId;
  const basePlanId = payload.subscriptionOffer?.basePlanId;
  const offerId = payload.subscriptionOffer?.offerId;
  const offerToken = payload.subscriptionOffer?.offerToken;
  // -- END GOOGLE --

  // -- APPLE ONLY --
  if (storeOfferId != null) {
    try {
      const signature = await Purchasely.signPromotionalOffer(storeProductId, storeOfferId);
      const anonymousUserId = await Purchasely.getAnonymousUserId();
      const appTokenUserId = anonymousUserId.toLowerCase();

      // You need the signature and appTokenUserId to validate the offer
    } catch (e) {
      console.log('Error while signing promotional offer');
      console.error(e);
    }
  }
  // -- END APPLE --

  // Now that you have the ids you need, you can launch your purchase flow

  try {
    // TODO launch purchase flow

    // if successful, return 'success' to dismiss the paywall
    return 'success';
  } catch (e) {
    // if not successful, return 'failed' to keep the paywall displayed
    return 'failed';
  }
});
```
```typescript Flutter
await Purchasely.interceptAction(
  PLYPresentationActionKind.purchase,
  (info, payload) async {
    if (payload is! PLYPurchasePayload) {
      return PLYInterceptResult.notHandled;
    }

    // Retrieve the store product id and offer id
    String? storeProductId = payload.plan.productId;
    String? storeOfferId = payload.offer?.storeOfferId;

    // -- GOOGLE ONLY --
    // Alternatively, just for Google you can retrieve everything if it is simpler for you,
    // specially if you want the offer token
    String? productId = payload.subscriptionOffer?.subscriptionId;
    String? basePlanId = payload.subscriptionOffer?.basePlanId;
    String? offerId = payload.subscriptionOffer?.offerId;
    String? offerToken = payload.subscriptionOffer?.offerToken;
    // -- END GOOGLE --

    // -- APPLE ONLY --
    if (storeProductId != null && storeOfferId != null) {
      try {
        Map signature = await Purchasely.signPromotionalOffer(storeProductId, storeOfferId);
        String? anonymousUserId = await Purchasely.anonymousUserId;
        String? appTokenUserId = anonymousUserId?.toLowerCase();

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

    try {
      // TODO launch purchase flow

      // if successful, return success to dismiss the paywall
      return PLYInterceptResult.success;
    } catch (e) {
      // if not successful, return failed to keep the paywall displayed
      return PLYInterceptResult.failed;
    }
  },
);
```
