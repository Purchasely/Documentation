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

* Purchase completed
* Restoration completed

and error messages like:

* Network error
* Product not found
* Purchase impossible (or canceled) 
* Restoration incomplete.

All these alerts are managed by the **`PLYAlertMessage`** enum.

If you prefer a more customized approach to display these messages that better aligns with your app's design and user experience, you can override the default behavior. 

This is achieved by providing an implementation of **`PLYUIHandler`**.  This will allow you to display these messages and have the flexibility to customize their appearance and behavior. Additionally, you can implement specific actions to be triggered when the user interacts with these dialogs.

## Implementation

### PLYUIHandler Interface

```swift Swift
@objc public protocol PLYUIHandler {
    @objc optional func display(alert: PLYAlertMessage, with error: Error?, proceed: @escaping () -> ())
}
```
```kotlin Kotlin
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

On Android, this method must always end with a call to either `proceed()` or `alert.onDismiss()`. See [Dismissing the alert](#dismissing-the-alert-android) below.

### Dismissing the alert (Android)

Most alerts are the last step of a paywall action: a purchase, a restore, a plan change. On Android, the SDK keeps that action open until the alert is dismissed, and only then resumes the Screen — closing it after a successful purchase, or accepting taps again after an error.

There are therefore **two** ways to signal that the alert is over, and you must always use one of them:

| You call | What the SDK does |
| --- | --- |
| `proceed()` | Displays its own `AlertDialog` and dismisses the alert for you when the user taps its button. |
| `alert.onDismiss()` | Dismisses the alert without displaying any dialog. Use it when you display your own. |

<Callout icon="⚠️">
  **Always signal the dismissal**

  If you display your own dialog and call neither `proceed()` nor `alert.onDismiss()`, the paywall action is never completed. The Screen remains displayed and stops reacting to taps, including the close button, and later actions are never processed.

  Call `alert.onDismiss()` from the dismiss callback of your own dialog.
</Callout>

`onDismiss()` is declared on the `PLYAlertMessage` base class, so it is available on every alert type without a `when` branch, and it runs exactly what the button of the SDK dialog would have run. The base class also exposes the strings the SDK would have displayed — `getTitleContent()`, `getContentMessage()` and `getButtonContent()` — so you can reuse them in your own dialog.

Two rules to keep in mind:

* Call `alert.onDismiss()` **after** your dialog is dismissed, not before: on a success alert the SDK resumes the flow and closes the Screen.
* Never call both `proceed()` and `alert.onDismiss()` for the same alert, otherwise the SDK dialog is displayed on top of yours.

### PLYUIHandler implementation

You can either display your own custom dialog or call the proceed function to let the SDK display the default dialog. You also have the option to handle specific alert types with your custom dialog and use the default SDK dialog for others

```swift Swift
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
```kotlin Kotlin
Purchasely.uiHandler = object : PLYUIHandler {
  override fun onAlert(alert: PLYAlertMessage, purchaselyView: View, activity: Activity?, proceed: () -> Unit) {
    val context = activity ?: return proceed() // no activity: let the SDK display the alert
    when(alert) {
      is PLYAlertMessage.InAppSuccess,
      is PLYAlertMessage.InAppSuccessUnauthentified ->
        // Dismiss the alert once your dialog is closed, so the SDK resumes the Screen
        showMyDialog(context, alert.getTitleContent(), alert.getContentMessage()) { alert.onDismiss() }
      else -> proceed()
    }
  }
}
```

> 📘 Reading the error
>
> On Android, `PLYAlertMessage` is a sealed class: the error is carried by the alert types that have one, for instance `PLYAlertMessage.InAppError` and `PLYAlertMessage.InAppRestorationError`. Inside a `when` branch, read it with `alert.error`. Its localized message is also returned by `alert.getContentMessage()`.

<br />

### Customizing Dialog Texts

If you would like to override the text strings displayed in the SDK dialogs, such as purchase completion or error messages, you can customize them through the localization process. This allows you to display messages in a way that aligns with your app's tone and language preferences.

For more information on how to localize these messages, please refer to the [Localizing your app](localizing-your-app) page. There, you'll find instructions on how to override default SDK strings to better suit your app's style and language requirements.
