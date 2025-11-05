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

## Implementation

### 1. Notify the SDK

To effortlessly display deeplink-triggered Screens, your app must notify the Purchasely SDK when it is ready to handle interactions that may cover its UI. This ensures smooth transitions during critical app processes, such as dismissing loading screens upon completion or displaying onboarding flows before allowing purchases. To notify the SDK, call the following method:

```coffeescript Swift
// Call it in your viewDidAppear
Purchasely.readyToOpenDeeplink(true)
```
```coffeescript Kotlin
Purchasely.readyToOpenDeeplink = true
```

### PLYUIHandler implementation

Implement the **`PLYUIHandler`** interface to customize how Screens are displayed in your app. This allows you to tailor the user experience to match your app's design and functionality. 

```coffeescript Swift
@objc public protocol PLYUIHandler {
    @objc optional func display(presentation: PLYPresentation, from sourceController: UIViewController?, proceed: @escaping () -> ())
}
```
```coffeescript Kotlin
interface PLYUIHandler {
    /**
     * @param presentation the presentation to display
     * @param proceed a function to call if SDK should display the presentation itself
     */
    fun onPresentation(presentation: PLYPresentation, proceed: () -> Unit) {
        proceed()
    }
}
```

You can either display the Screen on your own or invoke the **`proceed`** function to let the SDK handle it.

```coffeescript Swift
// Your custom UI handler
class CustomUIHandler: NSObject, PLYUIHandler {
    
    func display(presentation: PLYPresentation, from sourceController: UIViewController?, proceed: @escaping () -> ())
        //TODO display view as you wish in your activity
        //type can be PRODUCT_PAGE, SUBSCRIPTION_LIST or CANCELLATION_PAGE
			  //Otherwise, you can let the sdk handle it by callind proceed()
    }
}

Purchasely.setUIHandler(CustomUIHandler())
```
```coffeescript Kotlin
Purchasely.uiHandler = object : PLYUIHandler {
  override fun onPresentation(presentation: PLYPresentation, proceed: () -> Unit) {
      when(presentation.type) {
        PLYPresentationType.NORMAL,
        PLYPresentationType.FALLBACK -> {
          Log.d("Purchasely", "Display Purchasely View")
          val purchaselyView = presentation.buildView(context, PLYPresentationViewProperties(
            onClose = {
              // TODO remove purchaselyView
            }
          ))

        // TODO add purchaselyView to your layout

        // You can also just call proceed() to let Purchasely display the presentation itself
      }
      PLYPresentationType.DEACTIVATED -> Log.d("Purchasely", "Screen was deactivated for this placement or audience, nothing to display")
      PLYPresentationType.CLIENT -> Log.d("Purchasely", "Display your own screen")
    }
 }
}
```