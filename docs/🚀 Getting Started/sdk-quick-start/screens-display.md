---
title: Screens display
excerpt: >-
  This sections details how to display a Purchasely screen in a few lines of
  code
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: processing-transactions
      title: Transactions processing
---
Purchasely screens, also called presentations or paywalls, can be displayed directly via their identifier, but the preferred way is to use a <Glossary>placement</Glossary>.

You can learn more about [placements](displaying-screens-placements) & [screens](displaying-screens) in their dedicated article.

Purchasely will automatically render the view to display, which can be configured entirely remotely from the Purchasely console. The view is rendered with native components, using UI Kit on iOS and View on Android, making it fully compatible with iOS & Android phones, tablets, and TVs.

# Display a placement

<PlacementOverview />

[More details about placements in the dedicated page](displaying-screens-placements)

Once the placements are defined and called from the app, you can change the displayed paywall remotely without any developer action.

```swift Swift
let placementId = "<<default_placement>>"
// Get the UIViewController to present
let purchaselyController = Purchasely.presentationController(for: placementId)
```
```kotlin Kotlin
// Retrieve the view to display in your layout hierarchy
val presentationView = Purchasely.presentationView(
  context = context,
  properties = PLYPresentationProperties(
    placementId = "<<default_placement>>",
    onClose = {
      // remove view from layout hierarchy
    })
) { result, plan ->
  when (result) {
    PLYProductViewResult.PURCHASED -> Log.d("Purchasely", "User purchased ${plan?.name}")
    PLYProductViewResult.CANCELLED -> Log.d("Purchasely", "User cancelled purchased")
    PLYProductViewResult.RESTORED -> Log.d("Purchasely", "User restored ${plan?.name}")
  }
}
```
```typescript React Native
await Purchasely.presentPresentationForPlacement({
    placementVendorId: '<<default_placement>>',
    isFullscreen: true,
});
```
```typescript Flutter
await Purchasely.presentPresentationForPlacement('<<default_placement>>');
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely.PresentPresentationForPlacement(
  	'<<default_placement>>',
  	OnPresentationResult,
  	OnPresentationContentLoaded,
  	OnPresentationContentClosed,
  	'contentId',
  	true
);
```
```javascript Cordova
Purchasely.presentPresentationForPlacement('<<default_placement>>');
```

# Limitations

<LimitationsSynchronousDisplay />

[More details about the different methods available to display a screens](displaying-screens)

# Close & Callback

Once a successful purchase or restoration has occurred, Purchasely screens will be automatically closed by the SDK, except in Kotlin/Java, where you need to implement the `onClose` callback.\
For more details on how to retrieve this information or manage it yourself in paywallObserver mode, refer to the [next step](processing-transactions).

In all other cases, if you want to close the Purchasely presentation, you must do it manually.

```swift Swift
// just dismiss the UIViewController returned by Purchasely
```
```kotlin Kotlin
val presentationView = Purchasely.presentationView(
  context = context,
  properties = PLYPresentationProperties(
    placementId = "<<default_placement>>",
    onClose = {
      // The onClose callback to implement
      // remove view from layout hierarchy here
    })
) { result, plan ->
  when (result) {
    PLYProductViewResult.PURCHASED -> Log.d("Purchasely", "User purchased ${plan?.name}")
    PLYProductViewResult.CANCELLED -> Log.d("Purchasely", "User cancelled purchased")
    PLYProductViewResult.RESTORED -> Log.d("Purchasely", "User restored ${plan?.name}")
  }
}
```
```typescript React Native
Purchasely.closePresentation();
```
```typescript Flutter
Purchasely.closePresentation();
```
```csharp Unity
Purchasely.ClosePresentation();
```
```javascript Cordova
Purchasely.closePresentation();
```
