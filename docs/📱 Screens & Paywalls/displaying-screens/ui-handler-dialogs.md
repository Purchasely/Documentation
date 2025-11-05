---
title: Overriding SDK dialogs
excerpt: This section describes how to override SDK dialogs
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Learn how to customize your Screens by nesting multiple views
  pages:
    - type: basic
      slug: nesting-views
      title: Nesting views
---
## Overview

When using the Purchasely SDK in full mode, various informational messages and errors are displayed to the user through standard system dialogs (**`UIAlertController`** on iOS  and **`AlertDialog`** on Android).

These include messages such as:

- Purchase completed
- Restoration completed

and error messages like:

- Network error
- Product not found
- Purchase impossible (or canceled) 
- Restoration incomplete.

All these alerts are managed by the **`PLYAlertMessage`** enum.

If you prefer a more customized approach to display these messages that better aligns with your app's design and user experience, you can override the default behavior. 

This is achieved by providing an implementation of **`PLYUIHandler`**.  This will allow you to display these messages and have the flexibility to customize their appearance and behavior. Additionally, you can implement specific actions to be triggered when the user interacts with these dialogs.

## Implementation

### PLYUIHandler Interface

```coffeescript Swift
@objc public protocol PLYUIHandler {
    @objc optional func display(alert: PLYAlertMessage, with error: Error?, proceed: @escaping () -> ())
}
```
```coffeescript Kotlin
interface PLYUIHandler {
    /**
     * @param alert the alert to display
     * @param purchaselyView the Purchasely view currently displayed
     * @param activity the activity containing the Purchasely view (may not be found)
     * @param proceed a function to call if SDK should display the alert itself
     */
    fun onAlert(alert: PLYAlertMessage, purchaselyView: View, activity: Activity? = null, proceed: () -> Unit) {
        proceed()
    }
}
```

### PLYUIHandler implementation

You can either display your own custom dialog or call the proceed function to let the SDK display the default dialog. You also have the option to handle specific alert types with your custom dialog and use the default SDK dialog for others

```coffeescript Swift
// Your custom UI handler
class CustomUIHandler: NSObject, PLYUIHandler {
    
        func display(alert: PLYAlertMessage, with error: Error?, proceed: @escaping () -> ()) {
        switch alert {
        	case is PLYAlertMessage.inAppSuccess: /* Display your own alert dialog */
        	case is PLYAlertMessage.inAppSuccessUnauthentified:/* Display your own alert dialog */
        	default:
          	   proceed()
        }
    }
}

Purchasely.setUIHandler(CustomUIHandler())
```
```coffeescript Kotlin
Purchasely.uiHandler = object : PLYUIHandler {
  override fun onAlert(alert: PLYAlertMessage, purchaselyView: View, activity: Activity?, proceed: () -> Unit) {
    when(alert) {
      is PLYAlertMessage.InAppSuccess -> { /* Display your own alert dialog */ }
      is PLYAlertMessage.InAppSuccessUnauthentified -> { /* Display your own alert dialog */ }
      else -> proceed()
    }
  }
}
```

<br />

### Customizing Dialog Texts

If you would like to override the text strings displayed in the SDK dialogs, such as purchase completion or error messages, you can customize them through the localization process. This allows you to display messages in a way that aligns with your app's tone and language preferences.

For more information on how to localize these messages, please refer to the [Localizing your app](localizing-your-app) page. There, you'll find instructions on how to override default SDK strings to better suit your app's style and language requirements.