---
title: In-App Experiences display
excerpt: >-
  This sections details how to display a Purchasely screen in a few lines of
  code
deprecated: false
hidden: false
metadata:
  robots: index
---
Purchasely allow you to display native In-App Experiences, such as Screens, Quizzes or Flows.

In the code, In-App Experiences are called Presentations (object `PLYPresentation`).

Purchasely SDK automatically renders the view to display, which can be configured entirely remotely from the Purchasely console. 

The view is rendered with native components, using UI Kit on iOS and View on Android, making it fully compatible with iOS & Android phones, tablets, and TVs.

There most straightforward way to display In-App Experiences is to use a <Glossary>placement</Glossary>.

<br />

# What is a Placement?

<PlacementOverview />

[More details about placements in the dedicated page](displaying-screens-placements)

# How to display an In-App Experience associated to a Placement?

The most universal method consists in:

* pre-fetching the Placement by calling the SDK method `preload()`
* and then calling the `display()` method of the `PLYPresentation` object fetched

```swift Swift
PLYPresentationBuilder
    .forPlacementId("onboarding")
    .build()
    .preload { presentation, error in
         guard let presentation = presentation, error == nil else {
             print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
             return
         }
         
         // call the display method and provide the currently displayed UIViewController
         presentation.display(from: myUIViewController)
    }
```
```kotlin Kotlin
PLYPresentation {
    placementId("onboarding")
}.preload { presentation, error ->
  if (error != null) {
    Log.d("Purchasely", "Error fetching Screen", error)
    return@preload
  }

  // call the display method and provide your Activity
  presentation?.display(activity)
}
```
```typescript React Native
try {
  const request = Purchasely.presentation.placement('onboarding').build()

  // Preload the Screen, then display it
  await request.preload()

  //Display Purchasely Screen
  const outcome = await request.display()
} catch (e) {
  console.error(e);
}
```
```typescript Flutter
try {
  final request = PresentationBuilder.placement("ONBOARDING").build();

  // Preload the Screen, then display it
  await request.preload();

  //Display Purchasely Screen
  final outcome = await request.display();
} catch (e) {
  print(e);
}
```

More details about the other features and capabilities coming alongside with the [pre-fetching](pre-fetching)

## Going further

There are other ways to display In-App Experiences with Purchasely:

* Get the view to display directly
* Through deeplinks
* Through Campaigns

More details about the different methods available to [display a screens](displaying-screens)
