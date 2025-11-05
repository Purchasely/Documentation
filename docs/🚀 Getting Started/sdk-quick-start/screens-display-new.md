---
title: Screens display (new)
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
---
Purchasely allow you to display native In-App Experiences, such as Screens, Paywalls, Surveys or Flows.

In the code, In-App Experiences are called Presentations (object `PLYPresentation`). Purchasely SDK automatically renders the view to display, which can be configured entirely remotely from the Purchasely console. The view is rendered with native components, using UI Kit on iOS and View on Android, making it fully compatible with iOS & Android phones, tablets, and TVs.

There are several ways to display In-App Experiences that are detailed here (LINK TO BE INSERTED), but the preferred and most convenient way is to use a <Glossary>placement</Glossary>.

<br />

# What is a Placement?

<PlacementOverview />

[More details about placements in the dedicated page](displaying-screens-placements)

# How to display an In-App Experience associated to a Placement?

The most universal method consists in: 

* pre-fetching the Placement by calling the SDK API `prefetch`
* and then calling the `display()` method of the `PLYPresentation` object fetched

```swift Swift
Purchasely.fetchPresentation(for: placementId, fetchCompletion: { presentation, error in
      guard error == nil,
            let presentation = presentation else { return }

     presentation.display(from: myUIViewController)
})
```
```kotlin Kotlin
TO BE COMPLETED
```
```typescript React Native
TO BE COMPLETED
```
```typescript Flutter
TO BE COMPLETED
```
```csharp Unity
TO BE COMPLETED
```
```javascript Cordova
TO BE COMPLETED
```

More details about the other features and capibilities coming alongside with the [pre-fetching](pre-fetching)

# Going further

There are other ways to display In-App Experiences with Purchasely:

* through the viewController
* through deeplinks
* through Campaigns

More details about the different methods available to [display a screens](displaying-screens) 

<br />

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
