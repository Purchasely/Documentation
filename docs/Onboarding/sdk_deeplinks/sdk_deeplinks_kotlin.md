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
To manage deeplinks you need to do up to 2 things:

* Optionally control when Purchasely is allowed to display content over your interface
* Set a default presentation handler to get the result of what was done by the user on the paywall / screen

> 📘 No code needed to pass the deeplink on Android
>
> Since v6, the Android SDK **intercepts Purchasely deeplinks automatically** (it reads the foreground activity's intent on create and resume). **You don't need to call `handleDeeplink` yourself.**

### PASSING THE DEEPLINK TO THE PURCHASELY SDK (optional)

The SDK already handles deeplinks on its own. You only need the manual call below as a fallback for activities using `singleTask` / `singleTop` launch modes that receive the deeplink in `onNewIntent` **without** calling `setIntent(intent)`. You can also pass a cold-start deeplink at initialization with `Purchasely.Builder(context).handleDeeplink(intent.data).build().start { error -> }`.

```kotlin
class MyActivity : FragmentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Optional — the SDK already intercepts deeplinks automatically.
        val data = intent.data
        if (data != null) {
            // Purchasely SDK returns true if it handles the deeplink
            val isHandledByPurchasely = Purchasely.handleDeeplink(data)
        }
    }

}
```

### FORBIDDING THE DISPLAY

By **default**, Purchasely deeplinks are displayed **immediately** when they are received.

If your app has a launch routine that must complete before a screen can be shown (splash screen, onboarding, login, displaying an ad…), you can **temporarily prevent** the display, then re-enable it once you are ready:

```kotlin
// Prevent the display (e.g. while your onboarding is on screen)
Purchasely.allowDeeplink = false

// Re-enable it once ready — any queued deeplink displays immediately
Purchasely.allowDeeplink = true
```

> 📘 You only need this if you want to **defer** deeplinks. Do nothing and they display as soon as they are received.

### SETTING THE DEFAULT PRESENTATION HANDLER

Usually when a paywall / screen is instantiated by the app, a closure is called back to inform the app of what has happened with the paywall / screen. However, when a deeplink is called, as you don't instantiate the paywall / screen yourself, no closure will be called.

You can retrieve the result of the user action in a paywall opened with a deeplink by setting a `DefaultPresentationResultHandler`.

```kotlin
Purchasely.setDefaultPresentationResultHandler { outcome ->
    /* You can set a callback to know when your user purchased a product */
    when(outcome.purchaseResult) {
        PLYPurchaseResult.PURCHASED -> Log.d("Purchasely", "Purchased ${outcome.plan}")
        PLYPurchaseResult.CANCELLED ->  Log.d("Purchasely", "Cancelled purchase of ${outcome.plan}")
        PLYPurchaseResult.RESTORED -> Log.d("Purchasely", "Restored ${outcome.plan}")
        null -> {}
    }
}
```
