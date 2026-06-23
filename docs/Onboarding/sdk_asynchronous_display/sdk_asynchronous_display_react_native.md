---
title: React Native
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

```javascript React Native
const outcome = await Purchasely.presentation
    .placement('ONBOARDING')
    .contentId('my_content_id')
    .build()
    .display();
```

### 2\. USING THE ASYNCHRONOUS DISPLAY WITH PRE-FETCH

Purchasely, by default, shows the paywall screen with a loading indicator while fetching the paywall from the network and preparing it for display.

Using the `preload()` method on a presentation request, you can pre-fetch the paywall from the network before displaying it. 

The benefits of this method are listed in the bloc on the right

Call `Purchasely.presentation.placement(...).build().preload()` for a placement or `Purchasely.presentation.screen(...).build().preload()` with a presentation id

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

```javascript React Native
try {
  // Build a request for the placement
  const request = Purchasely.presentation.placement('ONBOARDING').build()

  // Pre-fetch presentation to display
  const presentation = await request.preload()

  if (presentation == null) {
    // No presentation, it means an error was triggered
    return
  }

  if (presentation.type === PLYPresentationType.DEACTIVATED) {
    // No paywall to display
    return
  }

  if (presentation.type === PLYPresentationType.CLIENT) {
    const paywallId = presentation.screenId
    const planIds = presentation.plans
    // Display your own paywall
    return
  }

  // Display Purchasely paywall, resolves when it is dismissed
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
  }

} catch (e) {
  console.error(e);
}
```

### 3\. USING THE DEEPLINK

<br />
