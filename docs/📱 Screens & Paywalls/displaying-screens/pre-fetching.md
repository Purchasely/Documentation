---
title: Pre-fetching Screens
excerpt: >-
  This section provides details on how to pre-fetch Screens and display them
  later
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Purchasely, by default, [shows the Screen](displaying-your-first-screen) with a loading indicator while fetching the Screen from the network and preparing it for display.

Using the `PLYPresentation` builder with its `preload` method (iOS: `PLYPresentationBuilder`), you can pre-fetch the Screen from the network before displaying it. This provides the following benefits:

* Display the Screen only after it has been loaded from the network
* Handle network errors gracefully
* Show a custom loading screen
* Pre-load the Screen while users navigate through your app, such as during onboarding screens
* Choose [not to display a Screen](disable-placements.md) for a specific placement
* Display [your own Screen](byos)

## Implementation

Build a `PLYPresentation` (Android) / `PLYPresentationBuilder` (iOS) **for** a placement or **with** a presentation id, then call `preload`

1. An error may be returned if the presentation could not be fetched from the network.
2. If successful, you will have a `PLYPresentation` instance containing the following properties:

<PLYPresentation />

A presentation can be one of the following types:

* **Normal**: The default behavior, a Purchasely Screen created from our console.
* **Fallback**: A Purchasely Screen, but not the one you requested, as it could not be found.
* **Deactivated**: No [Screen associated](disable-placements.md) with that placement, possibly for a specific A/B test or an [audience](https://help.purchasely.io/en/articles/6940943-disable-a-paywall-for-a-placement).
* **Client**: You [created a Custom Screen in the Purchasely Console](byos-configuration) and should [display it](byos-implementation). Use the list of plans to determine which offers to display to your users.

```swift Swift
// fetch presentation for placement
PLYPresentationBuilder
    .forPlacementId("onboarding")
    .build()
    .preload { presentation, error in
         // closure to get presentation and display it
         guard let presentation = presentation, error == nil else {
             print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
             return
         }
         
         if presentation.type == .normal || presentation.type == .fallback {
           // Display directly
           presentation.display(from: myUIViewController)
           
           // alternatively: get the UIViewController to manage the transition yourself
					// note: this method won't work with Flows
					let purchaselyController = presentation.controller

             
         } else if presentation.type == .deactivated {
             
             // nothing to display
             
         } else if presentation.type == .client {
             let presentationId = presentation.id
             let planIds = presentation.plans
             
             // display your own Screen
             
         }
    }
```
```kotlin Kotlin
PLYPresentation {
  placementId("onboarding")
  onCloseRequested {
    // TODO remove view from your layout
  }
}.preload { presentation, error ->
  if(error != null) {
    Log.d("Purchasely", "Error fetching Screen", error)
    return@preload
  }

  when(presentation?.type) {
    PLYPresentationType.NORMAL,
    PLYPresentationType.FALLBACK -> {
      
			// Easy: just call display
  		presentation?.display()
      
      // Intermediate: build the view to display it yourself in your layout for specific use cases
			// Note: this won't work with Flows
      val screenView = presentation.buildView(this@MainActivity) { outcome ->
        // Screen is closed, check result to know if a purchase happened
        when(outcome.purchaseResult) {
          PLYPurchaseResult.PURCHASED -> Log.d("Purchasely", "User purchased ${outcome.plan?.name}")
          PLYPurchaseResult.CANCELLED -> Log.d("Purchasely", "User cancelled purchased")
          PLYPurchaseResult.RESTORED -> Log.d("Purchasely", "User restored ${outcome.plan?.name}")
          null -> {}
        }
      }

      // Display Purchasely Screen by adding screenView to your layout
    }
    PLYPresentationType.DEACTIVATED -> {
      // Nothing to display
    }
    PLYPresentationType.CLIENT -> {
      val paywallId = presentation.screenId
      val planIds = presentation.plans
      // Display your own Screen
    }
    else -> {
      //No Screen, it means an error was triggered
    }
  }
}
```
```javascript React Native
try {
  // Fetch presentation to display
  const presentation = await Purchasely.fetchPresentation({
      placementId: 'onboarding'
  })

  if(presentation.type == PLYPresentationType.DEACTIVATED) {
    // No Screen to display
    return
  }

  if(presentation.type == PLYPresentationType.CLIENT) {
    // Display my own Screen
    return
  }

  //Display Purchasely Screen
  const result = await Purchasely.presentPresentation({
    presentation: presentation
  })
  
  switch (result.result) {
    case ProductResult.PRODUCT_RESULT_PURCHASED:
    case ProductResult.PRODUCT_RESULT_RESTORED:
      if (result.plan != null) {
        console.log('User purchased ' + result.plan.name);
      }

      break;
    case ProductResult.PRODUCT_RESULT_CANCELLED:
      console.log('User cancelled');
      break;
  }

} catch (e) {
  console.error(e);
}
```
```javascript Flutter
try {
  final request = PresentationBuilder.placement("ONBOARDING").build();

  final presentation = await request.preload();

  if (presentation.type == PresentationType.deactivated) {
    // No Screen to display
    return;
  }

  if (presentation.type == PresentationType.client) {
    // Display my own Screen
    return;
  }

  //Display Purchasely Screen

  final outcome = await request.display();

  switch (outcome.purchaseResult) {
    case PurchaseResult.cancelled:
      {
        print("User cancelled purchased");
      }
      break;
    case PurchaseResult.purchased:
      {
        print("User purchased ${outcome.plan}");
      }
      break;
    case PurchaseResult.restored:
      {
        print("User restored ${outcome.plan}");
      }
      break;
    case null:
      {
        print("User dismissed: ${outcome.closeReason}");
      }
      break;
  }
} catch (e) {
  print(e);
}
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

...
_purchasely.FetchPresentation("presentationId",
			OnFetchPresentationSuccess,
			Log,
			"contentId");		
...

private void OnFetchPresentationSuccess(Presentation presentation)
{
	Log("Fetch Presentation Success.");
	LogPresentation(presentation);

	switch (presentation.presentationType)
	{
		case PresentationType.Normal:
		case PresentationType.Fallback:
				_purchasely.PresentContentForPresentation(
          	presentation,
						OnPresentationResult,
						OnPresentationContentLoaded,
						OnPresentationContentClosed,
						true
				);
			break;
		case PresentationType.Unknown:
		case PresentationType.Deactivated:
			Log($"Fetched presentation with type: {presentation.presentationType}. Will not show content.");
			break;
		case PresentationType.Client:
			paywall.Show(presentation);
			break;
	}
}
```
