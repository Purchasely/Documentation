---
title: Swift
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

```swift
let placementId = "ONBOARDING"
paywallCtrl = Purchasely.presentationController(for: placementId, contentId: contentId, loaded: { _, _, _ in
            }, completion: completion)
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

```swift
// fetch presentation for placement
Purchasely.fetchPresentation(
    for: "ONBOARDING",
    fetchCompletion: { presentation, error in
         // closure to get presentation and display it
         guard let presentation = presentation, error == nil else {
             print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
             return
         }
         
         if presentation.type == .normal || presentation.type == .fallback {
             let paywallController = presentation.controller
             
             // display paywall controller.
             
         } else if presentation.type == .deactivated {
             
             // nothing to display
             
         } else if presentation.type == .client {
             let presentationId = presentation.id
             let planIds = presentation.plans
             
             // display your own paywall
             
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
    })
```

### 3\. USING THE DEEPLINK

<br />
