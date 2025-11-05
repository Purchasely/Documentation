---
title: In-App Experiences display
excerpt: >-
  This sections details how to display a Purchasely screen in a few lines of
  code
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Purchasely allow you to display native In-App Experiences, such as Screens, Paywalls, Surveys or Flows.

In the code, In-App Experiences are called Presentations (object `PLYPresentation`). Purchasely SDK automatically renders the view to display, which can be configured entirely remotely from the Purchasely console. The view is rendered with native components, using UI Kit on iOS and View on Android, making it fully compatible with iOS & Android phones, tablets, and TVs.

There are several ways to display In-App Experiences that are detailed here (LINK TO BE INSERTED), but the preferred and most convenient way is to use a <<glossary:placement>>.

<br />

# What is a Placement?

<PlacementOverview />

[More details about placements in the dedicated page](displaying-screens-placements)

# How to display an In-App Experience associated to a Placement?

The most universal method consists in: 

- pre-fetching the Placement by calling the SDK method `fetchPresentation()`
- and then calling the `display()` method of the `PLYPresentation` object fetched

```swift Swift
Purchasely.fetchPresentation(
    for: "onboarding",
    fetchCompletion: { presentation, error in
         guard let presentation = presentation, error == nil else {
             print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
             return
         }
         
         // call the display method and provide the currently displayed UIViewController
         presentation.display(from: myUIViewController)
    }
)
```
```kotlin Kotlin
Purchasely.fetchPresentation(placementId = "onboarding") { presentation, error ->
  if(error != null) {
    Log.d("Purchasely", "Error fetching Screen", error)
    return@fetchPresentation
  }

  // call the display method and provide your Activity
  presentation.display(activity)
}
```
```typescript React Native
try {
  const presentation = await Purchasely.fetchPresentation({
      placementId: 'onboarding'
  })

  //Display Purchasely Screen
  const result = await Purchasely.presentPresentation({
    presentation: presentation
  })
} catch (e) {
  console.error(e);
}
```
```typescript Flutter
try {
  var presentation = await Purchasely.fetchPresentation("ONBOARDING");

  //Display Purchasely Screen
  var presentResult = await Purchasely.presentPresentation(presentation);
} catch (e) {
  print(e);
}
```

More details about the other features and capabilities coming alongside with the [pre-fetching](pre-fetching)

## Going further

There are other ways to display In-App Experiences with Purchasely:

- Get the view to display directly
- Through deeplinks
- Through Campaigns

More details about the different methods available to [display a screens](displaying-screens)