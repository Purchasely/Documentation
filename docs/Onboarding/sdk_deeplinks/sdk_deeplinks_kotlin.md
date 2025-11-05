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
To manage deeplinks you need to do 2 things:

* Pass the deeplink to the Purchasely SDK when it is received by the application
* Allow the Purchasely SDK to display content over your interface
* Set a default presentation handler to get the result of what was done by the user on the paywall / screen

### PASSING THE DEEPLINK TO THE PURCHASELY SDK

To enable the Purchasely SDK to analyze the deeplink, the app needs to pass it using the following code:

```kotlin
class MyActivity : FragmentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        //retrieve intent data to get deeplink that opened your activity
        val data = intent.data
        if(data != null) {
            //Purchasely sdk will return true if it handles the deeplink
            val isHandledByPurchasely = Purchasely.isDeeplinkHandled(data)
        }
    }    

}
```

### ALLOWING THE DISPLAY

Your app might have a launch routine that requires to be fulfilled before another screen can be displayed. It can be splash screen, on boarding, login, displaying an ad etc...

For that reason, the display of Purchasely deeplinks is **deferred until you authorize it**. 

Once your app is ready, notify the Purchasely SDK by using the following code:

```kotlin
Purchasely.readyToOpenDeeplink = true
```

### SETTING THE DEFAULT PRESENTATION HANDLER

Usually when a paywall / screen is instantiated by the app, a closure is called back to inform the app of what has happened with the paywall / screen. However, when a deeplink is called, as you don't instantiate the paywall / screen yourself, no closure will be called.

You can retrieve the result of the user action in a paywall opened with a deeplink by setting a `DefaultPresentationResultHandler`.

```kotlin
Purchasely.setDefaultPresentationResultHandler { result, plan ->
    /* You can set a callback to know when your user purchased a product */
    when(result) {
        PLYProductViewResult.PURCHASED -> Log.d("Purchasely", "Purchased $plan")
        PLYProductViewResult.CANCELLED ->  Log.d("Purchasely", "Cancelled purchase of $plan")
        PLYProductViewResult.RESTORED -> Log.d("Purchasely", "Restored $plan")
    }
}
```
