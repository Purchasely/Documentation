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
### METHODS TO DISPLAY A PAYWALL

3 methods are available to display a Paywall

1. Through the synchronous display method
2. Through the asynchronous display method
3. Through the deeplink

If you want to quickly test your first in-app Purchase, we invite you to directly scan the QR code below

### 1\. USING THE SYNCHRONOUS DISPLAY

This first method to display a Placement was already presented at the stage **Display your first screen through a placement**

```kotlin
val paywallView = Purchasely.presentationViewForPlacement(
    context,
    placementId = "ONBOARDING",
    onClose = {
        //TODO remove view from layout hierarchy
    },
)
        
//TODO add paywallView to layout hierarchy
```

### 2\. USING THE ASYNCHRONOUS DISPLAY WITH PRE-FETCH

Purchasely, by default, shows the paywall screen with a loading indicator while fetching the paywall from the network and preparing it for display.

Using `Purchasely.fetchPresentation()` method, you can pre-fetch the paywall from the network before displaying it. 

The benefits of this method are listed in the bloc on the right

Call `Purchasely.fetchPresentation` for a placement or with a presentation id

1. An error may be returned if the presentation could not be fetched from the network.
2. If successful, you will have a `PLYPresentation` instance containing the following properties

```swift PLYPresentation properties
class PLYPresentation(
    id: String?
    placementId: String?
    audienceId: String?
    abTestId: String?
    abTestVariantId: String?
    language: String?
    type: PLYPresentationType
    plans: [String] // get PLYPlan instance with Purchasely.plan("planId")

    // Android SDK only (Kotlin or Java)
    view: PLYTemplateView?
    
    // iOS SDK only (Swift or Objective-C)
    controller: UIViewController?
}
```

A presentation can be one of the following types:

* **Normal**: The default behavior, a Purchasely paywall created from our console.
* **Fallback**: A Purchasely paywall, but not the one you requested, as it could not be found.
* **Deactivated**: No paywall associated with that placement, possibly for a specific A/B test or audience.
* **Client**: You declared and associated **Your Own Paywall** in the console and should display it.\
  More information about this feature in the block on the right.

To fetch a paywall and then display it, use the following code:

```kotlin
Purchasely.fetchPresentationForPlacement("ONBOARDING") { presentation, error ->
    if(error != null) {
        Log.d("Purchasely", "Error fetching paywall", error)
        return@fetchPresentationForPlacement
    }

    when(presentation?.type) {
        PLYPresentationType.NORMAL,
        PLYPresentationType.FALLBACK -> {
            val paywallView = presentation.buildView(
                context = this@MainActivity,
                viewProperties = PLYPresentationViewProperties(
                    onClose = {
                        // TODO remove view from your layout
                    }
                )
            ) { result, plan ->
                // Paywall is closed, check result to know if a purchase happened
                when(result) {
                    PLYProductViewResult.PURCHASED -> Log.d("Purchasely", "User purchased ${plan?.name}")
                    PLYProductViewResult.CANCELLED -> Log.d("Purchasely", "User cancelled purchased")
                    PLYProductViewResult.RESTORED -> Log.d("Purchasely", "User restored ${plan?.name}")
                }
            }
            
            // Display Purchasely paywall by adding paywallView to your layout
        }
        PLYPresentationType.DEACTIVATED -> {
            // Nothing to display
        }
        PLYPresentationType.CLIENT -> {
            val paywallId = presentation.id
            val planIds = presentation.plans
            // Display your own paywall
        }
        else -> {
            //No presentation, it means an error was triggered
        }
    }
}
```

### 3\. USING THE DEEPLINK

<br />
