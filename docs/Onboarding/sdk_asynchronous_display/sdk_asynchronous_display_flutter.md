---
title: Flutter
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

`PLYPresentationBuilder.placement(id).build()` returns a `PLYPresentationRequest`. Calling `display([PLYTransition])` shows the paywall and resolves at **dismiss** with a `PLYPresentationOutcome`.

```dart Flutter
await PLYPresentationBuilder.placement('ONBOARDING')
    .contentId(contentId)
    .build()
    .display(const PLYTransition.fullScreen());
```

### 2\. USING THE ASYNCHRONOUS DISPLAY WITH PRE-FETCH

Purchasely, by default, shows the paywall screen with a loading indicator while fetching the paywall from the network and preparing it for display.

Using the `PLYPresentationRequest` `preload` method, you can pre-fetch the paywall from the network before displaying it. 

The benefits of this method are listed in the bloc on the right

Call `PLYPresentationBuilder.placement(...).build().preload()` for a placement or `PLYPresentationBuilder.screen(...).build().preload()` with a presentation id

1. An error may be returned if the presentation could not be fetched from the network.
2. If successful, you will have a `PLYPresentation` instance containing the following properties

```swift Presentation properties
class PLYPresentation(
    id: String?
    placementId: String?
    audienceId: String?
    abTestId: String?
    abTestVariantId: String?
    language: String?
    type: PLYPresentationType
    plans: [String] // get PLYPlan instance with Purchasely.planWithIdentifier("planId")

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

```dart Flutter
try {
  // Build a request and preload it to fetch the screen from the network
  final request = PLYPresentationBuilder.placement('ONBOARDING').build();

  final presentation = await request.preload();

  if (presentation.type == PLYPresentationType.deactivated) {
    // No paywall to display
    return;
  }

  if (presentation.type == PLYPresentationType.client) {
    // Display my own paywall — plan summaries are in presentation.plans
    return;
  }

  // Display Purchasely paywall; resolves at dismiss with a PLYPresentationOutcome
  final outcome = await request.display(const PLYTransition.fullScreen());

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

### 3\. USING THE DEEPLINK

<br />
