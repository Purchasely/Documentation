---
title: Using deeplinks to display Screens
excerpt: This section provides details on how to display Screens using deeplinks
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
<AboutPurchaselyDeeplinks />

<WhatArePurchaselyDeeplinksUsedFor />

<DeeplinkImplementation />

# Supported deeplinks to create automations

Purchasely SDK supports the deeplink format with `app_scheme://ply` where _app_scheme_ is the application scheme you have declared to open deeplinks.  
On Android only, the SDK also supports universal links like `https://www.myapp.com/ply`

## Presentation / Screen

You can open a product presentation directly to the user with the default presentation or a specific one used for a specific purpose / promotion.

⚠️ This kind of push requires users opt-in (see App Store Review Guidelines - 4.5.4).

Open a screen directly  
`app_scheme://ply/presentations/PRESENTATION_ID`

Open your default screen  
`app_scheme://ply/presentations`

Open a placement  
`app_scheme://ply/placements/PLACEMENT_ID`

Open your default placement  
`app_scheme://ply/placements`

## Subscriptions

This deeplink will open the subscriptions view inside the app.

`app_scheme://ply/subscriptions`

## Update billing

This deeplink will open the App Store / Play Store setttings for the user to updates its credit card after a payment error.

`app_scheme://ply/update_billing`

# Be notified of purchase from a deeplink paywall

Usually when a paywall / screen is instantiated by the app, a closure is called back to inform the app of what has happened with the paywall . However, when a deeplink is called, as you don't instantiate the paywall yourself, no closure will be called.

You can retrieve the result of the user action in a paywall opened with a deeplink by setting a `DefaultPresentationResultHandler`. This only works in [full mode](full-mode), in [paywallObserver mode](paywallobserver-mode) do not forget to call Purchasely.synchronize() when a purchase happened.

```swift Swift
Purchasely.setDefaultPresentationResultHandler { [weak self](result, plan) in
    switch result {
        case .purchased:
            break
        case .restored:
            break
        case .cancelled:
            break
        @unknown default:
				    break
    }
}
```
```kotlin Kotlin
Purchasely.setDefaultPresentationResultHandler { result, plan ->
    /* You can set a callback to know when your user purchased a product */
    when(result) {
        PLYProductViewResult.PURCHASED -> Log.d("Purchasely", "Purchased $plan")
        PLYProductViewResult.CANCELLED ->  Log.d("Purchasely", "Cancelled purchase of $plan")
        PLYProductViewResult.RESTORED -> Log.d("Purchasely", "Restored $plan")
    }
}
```
```javascript React Native
Purchasely.setDefaultPresentationResultCallback((result) => {
  console.log('Presentation View Result : ' + result.result);

  if (result.plan != null) {
    console.log('Plan Vendor ID : ' + result.plan.vendorId);
    console.log('Plan Name : ' + result.plan.name);
  }
});
```
```java Flutter
Purchasely.setDefaultPresentationResultCallback((result) => {
  console.log('Presentation View Result : ' + result.result);

  if (result.plan != null) {
    console.log('Plan Vendor ID : ' + result.plan.vendorId);
    console.log('Plan Name : ' + result.plan.name);
  }
});
```
```swift Cordova
Purchasely.setDefaultPresentationResultHandler((result) => {
	console.log("Presentation View Result: " + result.result);

	if (result.plan != null) {
		console.log("Plan Vendor ID: " + result.plan.vendorId);
		console.log("Plan Name:  " + result.plan.name);
	}
});
```
```csharp Unity
_purchasely.SetDefaultPresentationResultHandler((result, plan) =>
{
    Log($"Presentation Result: {result}.");
});

```

> 📘 Keep in mind
> 
> The callback `PLYProductViewControllerResult`(iOS) / `ProductViewResultListener`(Android) is optional, you can set to null if you do not need it. You can override it when you display a presentation directly.

# Override the display of deeplinks

You can display the Purchasely deeplink for a Screen or Placement yourself if you want to control it entirely from your application. This only works on native iOS and Android frameworks at the moment

[Learn more](ui-handler-deeplinks)