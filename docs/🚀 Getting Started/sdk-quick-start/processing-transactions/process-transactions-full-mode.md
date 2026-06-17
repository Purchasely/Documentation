---
title: full mode
excerpt: This section describes how to process transactions in full mode
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: entitlements-management
      title: Entitlements management
---
# General principles

In `full` mode, the Purchasely SDK automatically launches the native in-app purchase flow when a user clicks on a purchase button and automatically handles the transaction.

In other words, you have nothing to do to manage the transaction and associated receipt, the SDK manages everything.

The only thing you will have to do is to update the entitlements once you have the confirmation that the purchase has been processed.

# Implementation

After [displaying a placement](screens-display), you get the `result` of the user action on the paywall.

* `Cancelled`: User did not purchase a plan
* `Restored`: User restored a previous purchased plan
* `Purchased`: User purchased a plan and the transaction was properly processed

You also have as a second argument the `plan` bought by the user, it is set to `nil` if no purchase was made.

```swift
PLYPresentationBuilder.forPlacementId("my_placement_id")
    .contentId("my_content_id")
    .onDismissed { outcome in
        switch outcome.purchaseResult {
        case .purchased:
            print("User purchased: \(outcome.plan?.name)")
            // update entitlements to unlock the access to the contents
        case .restored:
            print("User restored his purchases")
            // update entitlements to unlock the access to the contents
        case .cancelled:
            break
        @unknown default:
            break
        }
    }
    .build()
    .preload { presentation, error in
        let paywallCtrl = presentation?.controller
    }
```
```kotlin
PLYPresentation {
    placementId("onboarding")
    onCloseRequested {
        //TODO remove view from layout hierarchy
    }
}.preload { presentation, error ->
    if (error != null || presentation == null) return@preload

    val paywallView = presentation.buildView(context) { outcome ->
        when(outcome.purchaseResult) {
            PLYPurchaseResult.PURCHASED -> Log.d("Purchasely", "User purchased ${outcome.plan?.name}")
            PLYPurchaseResult.CANCELLED -> Log.d("Purchasely", "User cancelled purchased")
            PLYPurchaseResult.RESTORED -> Log.d("Purchasely", "User restored ${outcome.plan?.name}")
            null -> {}
        }
    }

    //TODO add paywallView to layout hierarchy
}
```
```javascript React Native
try {
  const result = await Purchasely.presentPresentationForPlacement({
    placementVendorId: 'onboarding',
    isFullscreen: true,
  });

  switch (result.result) {
    case ProductResult.PRODUCT_RESULT_PURCHASED:
    case ProductResult.PRODUCT_RESULT_RESTORED:
      if (result.plan != null) {
        console.log('User purchased ' + result.plan.name);
        // update entitlements to unlock the access to the contents
      }
      break;
    case ProductResult.PRODUCT_RESULT_CANCELLED:
      break;
  }
} catch (e) {
  console.error(e);
}
```
```javascript Flutter
try {
  final outcome = await PresentationBuilder.placement('onboarding')
      .build()
      .display(const Transition.fullScreen());

  switch (outcome.purchaseResult) {
    case PurchaseResult.purchased:
      print('User purchased: ${outcome.plan}');
      // update entitlements to unlock the access to the contents
      break;
    case PurchaseResult.restored:
      print('User restored his purchases');
      // update entitlements to unlock the access to the contents
      break;
    case PurchaseResult.cancelled:
      print("User cancelled purchased");
      break;
    case null:
      print("User dismissed: ${outcome.closeReason}");
      break;
  }
} catch (e) {
  print(e);
}
```
```swift Cordova
Purchasely.presentPresentationForPlacement(
	'onboarding', //placementId
	null, //contentId
	true, //fullscreen
	(callback) => {
		if(callback.result == Purchasely.PurchaseResult.PURCHASED) {
			console.log("User purchased " + callback.plan.name);
			// update entitlements to unlock the access to the contents
		} else if(callback.result == Purchasely.PurchaseResult.RESTORED) {
			console.log("User restored his purchases");
			// update entitlements to unlock the access to the contents
		} else if(callback.result == Purchasely.PurchaseResult.CANCELLED) {
			console.log("User cancelled purchased");
		}
	},
	(error) => {
		console.log("Error with purchase : " + error);
	}
);
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely.PresentPresentationForPlacement(
  	'onboarding',
  	OnPresentationResult,
  	OnPresentationContentLoaded,
  	OnPresentationContentClosed,
  	'contentId',
  	true
);

private void OnPresentationResult(ProductViewResult result, Plan plan)
{
  Log($"Presentation Result: {result}.");

  switch(result) {
    case ProductViewResult.Purchased:
      Log($"Purchased Plan: {plan.name}.");
      break;
    case ProductViewResult.Restored':
      Log($"Restored purchases");
      break;
    case ProductViewResult.Cancelled:
      Log($"Nothing happened");
      break;
  }
}
```

<br />

Once you get the information that the purchase has been processed, you can update the entitlements to unlock the access to the premium contents
