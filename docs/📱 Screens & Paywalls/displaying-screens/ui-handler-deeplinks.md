---
title: Manage SDK deeplinks
excerpt: This section describes how to manages SDK deeplinks using an UI Handler
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Learn how to use deeplinks to display your Screens
  pages:
    - type: basic
      slug: deeplinks
      title: Using deeplinks to display Screens
---
## Overview

When integrating the Purchasely SDK into your app, managing deeplinks becomes essential for handling various in-app events seamlessly. Deeplinks can initiate presentations that need to integrate smoothly with your app's user interface. 

## Notify the SDK

To effortlessly display deeplink-triggered Screens, your app must notify the Purchasely SDK when it is ready to handle interactions that may cover its UI. This ensures smooth transitions during critical app processes, such as dismissing loading screens upon completion or displaying onboarding flows before allowing purchases. To notify the SDK, call the following method:

```coffeescript Swift
// Call it in your viewDidAppear
Purchasely.readyToOpenDeeplink(true)
```
```coffeescript Kotlin
Purchasely.readyToOpenDeeplink = true
```

## Optional: Override display

By default, Purchasely will display the presentation in its own UIWindow (iOS) or Activity (Android).  
If you wish to display the deep link yourself accordingly to your navigation architecture, you can implement the **`PLYUIHandler`** interface to customize how Screens are displayed in your app.

### Interface

You must override the method display(presentation) that will be invoked each time a deep link will be trigged

```coffeescript Swift
@objc public protocol PLYUIHandler {
  @objc optional func display(presentation: PLYPresentation,
                              from sourceController: UIViewController?,
                              proceed: @escaping () -> ())
}
```
```coffeescript Kotlin
interface PLYUIHandler {
    /**
     * @param presentation the presentation to display
     * @param proceed a function to call if SDK should display the presentation itself
     */
    fun onPresentation(presentation: PLYPresentation, proceed: () -> Unit)
}
```

### Implementation

You can either display the Screen on your own or invoke the **`proceed`** function to let the SDK handle it.

```coffeescript Swift
// Your custom UI handler
class CustomUIHandler: NSObject, PLYUIHandler {
    
    func display(presentation: PLYPresentation, from sourceController: UIViewController?, proceed: @escaping () -> ()) {
        guard presentation.type != .deactivated,
              presentation.type != .client else {
            // if the presentation is client type, you must display your own internal screen
            return
        }
        
        if presentation.isFlow {
            // call display if it's a Flow
            presentation.display()
        } else {
            // Get the View yourself to display it
            
            // get the UIViewController
            let purchaselyController = presentation.controller
            // get the UIViewControllerRepresentable wrapper for Swift UI
            let purchaselyView = purchaselyController?.PresentationView
        }
        
        // or if you don't want to handle the display, always call
        proceed()
    }
}

// Set it once in your code
Purchasely.setUIHandler(CustomUIHandler())
```
```coffeescript Kotlin
Purchasely.uiHandler = object : PLYUIHandler {
  override fun onPresentation(presentation: PLYPresentation, proceed: () -> Unit) {
      // First possiblity, just call proceed() to let the SDK displays it
       proceed()
    
    // Display it yourself by checking the type
      when(presentation.type) {
        PLYPresentationType.NORMAL,
        PLYPresentationType.FALLBACK -> {
          Log.d("Purchasely", "Display Purchasely View")
          val purchaselyView = presentation.buildView(context, PLYPresentationViewProperties(
            onClose = {
              // TODO remove purchaselyView
            }
          ))
          myContainer.addView(purchaselyView)
        
        // Alternatively call display() to display it in a new Activity
          presentation.display(myActivity)

      }
      PLYPresentationType.DEACTIVATED -> Log.d("Purchasely", "Screen was deactivated for this placement or audience, nothing to display")
      PLYPresentationType.CLIENT -> Log.d("Purchasely", "Display your own screen")
    }
 }
}
```

> 🚧 Keep the PLYPresentation instance
> 
> Purchasely SDK will store in the presentation returned in that method some very important information to track conversion data like:
> 
> - AB Test
> - Audience
> - Placement
> - Campaign
> - Flow
> 
> For this tracking to work, you need to display the presentation returned as the first parameter of this method.  
> **DO NOT fetch the presentation again** by its id or placement id, all context will be lost.