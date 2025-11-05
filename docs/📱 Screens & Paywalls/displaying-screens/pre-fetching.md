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
> 🚧 Minimum SDK versions
>
> * iOS: 3.5.0
> * Android: 3.5.0
> * ReactNative: 2.5.0
> * Cordova: 2.5.0
> * Flutter: 1.5.0
> * Unity: 4.1.0

Purchasely, by default, [shows the Screen](displaying-your-first-screen) with a loading indicator while fetching the Screen from the network and preparing it for display.

Using `Purchasely.fetchPresentation()` method, you can pre-fetch the Screen from the network before displaying it. This provides the following benefits:

* Display the Screen only after it has been loaded from the network
* Handle network errors gracefully
* Show a custom loading screen
* Pre-load the Screen while users navigate through your app, such as during onboarding screens
* Choose [not to display a Screen](disable-placements.md) for a specific placement
* Display [your own Screen](use-your-own-paywall.md)

## Implementation

Call `Purchasely.fetchPresentation` **for** a placement or **with** a presentation id

1. An error may be returned if the presentation could not be fetched from the network.
2. If successful, you will have a `PLYPresentation` instance containing the following properties:

```coffeescript Swift
class PLYPresentation {
  let id: String?
  let language: String
  let placementId: String?
  let audienceId: String?
  let abTestId: String?
  let abTestVariantId: String?
  let type: PLYPresentationType
  let controller: PLYPresentationViewController?
  let plans: [PLYPresentationPlan]
  let metadata: PLYPresentationMetadata?
  let backgroundColor: UIColor?
}

```
```coffeescript Kotlin
data class PLYPresentation(
    val id: String?,
    val placementId: String?,
    val audienceId: String?,
    val abTestId: String?,
    val abTestVariantId: String?,
    val language: String?,
    val type: PLYPresentationType,
    val plans: List<PLYPresentationPlan>,
    val metadata: PLYPresentationMetadata?,
    val backgroundColor: String?
}
```

A presentation can be one of the following types:

* **Normal**: The default behavior, a Purchasely Screen created from our console.
* **Fallback**: A Purchasely Screen, but not the one you requested, as it could not be found.
* **Deactivated**: No [Screen associated](disable-placements.md) with that placement, possibly for a specific A/B test or an [audience](https://help.purchasely.io/en/articles/6940943-disable-a-paywall-for-a-placement).
* **Client**: You declared [your own Screen in our console](https://help.purchasely.io/en/articles/6940803-your-own-paywall-in-the-purchasely-console) and should [display it](use-your-own-paywall.md). Use the list of plans to determine which offers to display to your users.

```swift Swift
// fetch presentation for placement
Purchasely.fetchPresentation(
    for: "onboarding",
    fetchCompletion: { presentation, error in
         // closure to get presentation and display it
         guard let presentation = presentation, error == nil else {
             print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
             return
         }
         
         if presentation.type == .normal || presentation.type == .fallback {
             let screenController = presentation.controller
             
             // display controller.
             
         } else if presentation.type == .deactivated {
             
             // nothing to display
             
         } else if presentation.type == .client {
             let presentationId = presentation.id
             let planIds = presentation.plans
             
             // display your own Screen
             
         }
    },
    completion: { result, plan in
        // closure when presentation controller is closed to get result
        switch result {
            case .purchased:
                print("User purchased: \(plan?.name)")
                break
            case .restored:
                print("User restored: \(plan?.name)")
                break
            case .cancelled:
                break
            @unknown default:
                break
        }
    }
)
```
```kotlin Kotlin
Purchasely.fetchPresentationForPlacement("onboarding") { presentation, error ->
    if(error != null) {
        Log.d("Purchasely", "Error fetching Screen", error)
        return@fetchPresentationForPlacement
    }

    when(presentation?.type) {
        PLYPresentationType.NORMAL,
        PLYPresentationType.FALLBACK -> {
            val screenView = presentation.buildView(
                context = this@MainActivity,
                viewProperties = PLYPresentationViewProperties(
                    onClose = {
                        // TODO remove view from your layout
                    }
                )
            ) { result, plan ->
                // Screen is closed, check result to know if a purchase happened
                when(result) {
                    PLYProductViewResult.PURCHASED -> Log.d("Purchasely", "User purchased ${plan?.name}")
                    PLYProductViewResult.CANCELLED -> Log.d("Purchasely", "User cancelled purchased")
                    PLYProductViewResult.RESTORED -> Log.d("Purchasely", "User restored ${plan?.name}")
                }
            }
            
            // Display Purchasely Screen by adding screenView to your layout
        }
        PLYPresentationType.DEACTIVATED -> {
            // Nothing to display
        }
        PLYPresentationType.CLIENT -> {
            val paywallId = presentation.id
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
  var presentation = await Purchasely.fetchPresentation("ONBOARDING");

  if (presentation == null) {
    print("No presentation found");
    return;
  }

  if (presentation.type == PLYPresentationType.deactivated) {
    // No Screen to display
    return;
  }

  if (presentation.type == PLYPresentationType.client) {
    // Display my own Screen
    return;
  }

  //Display Purchasely Screen

  var presentResult = await Purchasely.presentPresentation(presentation,
      isFullscreen: false);

  switch (presentResult.result) {
    case PLYPurchaseResult.cancelled:
      {
        print("User cancelled purchased");
      }
      break;
    case PLYPurchaseResult.purchased:
      {
        print("User purchased ${presentResult.plan?.name}");
      }
      break;
    case PLYPurchaseResult.restored:
      {
        print("User restored ${presentResult.plan?.name}");
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
