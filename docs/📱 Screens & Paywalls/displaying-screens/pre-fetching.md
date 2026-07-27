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
Purchasely, by default, shows the Screen with a loading indicator while fetching it from the network and preparing it for display.

Using the `PLYPresentation` builder with its `preload` method (iOS: `PLYPresentationBuilder`), you can pre-fetch the Screen from the network before displaying it. This provides the following benefits:

* Display the Screen only after it has been loaded from the network
* Handle network errors gracefully
* Show a custom loading screen
* Pre-load the Screen while users navigate through your app, such as during onboarding screens
* Choose [not to display a Screen](displaying-screens-placements) for a specific placement
* Display [your own Screen](byos)

## Implementation

Build a `PLYPresentation` (Android) / `PLYPresentationBuilder` (iOS) **for** a placement or **with** a presentation id, then call `preload`

1. An error may be returned if the presentation could not be fetched from the network.
2. If successful, you will have a `PLYPresentation` instance containing the following properties:

<PLYPresentation />

A presentation can be one of the following types:

| Type | Meaning | What to do |
| --- | --- | --- |
| **Normal** | The default: a Purchasely Screen created from your console | Display it |
| **Fallback** | A Purchasely Screen, but not the one you requested (it could not be found) | Display it |
| **Deactivated** | No [Screen associated](displaying-screens-placements) with that placement (e.g. a specific A/B test or [audience](segmenting-your-user-base) deliberately serves no Screen) | Display nothing |
| **Client** | You [created a Custom Screen](byos-configuration) and should [display it yourself](byos-implementation) | Use the list of `plans` to know which offers to show |

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
             let presentationId = presentation.screenId
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
  // Build a request for the placement, then preload its Screen
  const request = Purchasely.presentation.placement('onboarding').build()

  const presentation = await request.preload()

  if (presentation.type === PLYPresentationType.DEACTIVATED) {
    // No Screen to display
    return
  }

  if (presentation.type === PLYPresentationType.CLIENT) {
    // Display my own Screen
    return
  }

  // Display Purchasely Screen, resolves when it is dismissed
  const outcome = await request.display()

  switch (outcome.purchaseResult) {
    case 'purchased':
    case 'restored':
      if (outcome.plan != null) {
        console.log('User purchased ' + outcome.plan.name);
      }

      break;
    case 'cancelled':
      console.log('User cancelled');
      break;
    case null:
      console.log('User dismissed: ' + outcome.closeReason);
      break;
  }

} catch (e) {
  console.error(e);
}
```
```javascript Flutter
try {
  final request = PLYPresentationBuilder.placement("ONBOARDING").build();

  final presentation = await request.preload();

  if (presentation.type == PLYPresentationType.deactivated) {
    // No Screen to display
    return;
  }

  if (presentation.type == PLYPresentationType.client) {
    // Display my own Screen
    return;
  }

  //Display Purchasely Screen

  final outcome = await request.display();

  switch (outcome.purchaseResult) {
    case PLYPurchaseResult.cancelled:
      {
        print("User cancelled purchased");
      }
      break;
    case PLYPurchaseResult.purchased:
      {
        print("User purchased ${outcome.plan?.name}");
      }
      break;
    case PLYPurchaseResult.restored:
      {
        print("User restored ${outcome.plan?.name}");
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
