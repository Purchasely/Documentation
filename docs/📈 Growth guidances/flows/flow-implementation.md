---
title: Prerequisites & Flows Implementation
excerpt: >-
  This page provides an overlook of prerequisites to leverage Flows and
  implementation details
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: In the next section, we guide you with the configuration of a Flow
  pages:
    - type: basic
      slug: flow-configuration
      title: Building a Flow with the Flow Composer
---
> 🚧 SDK v5.5.0+ recommended
> 
> Flows require to integrate SDK v5.3 and above. They are supported since this version, but we recommend v5.5.0 for a better stability and data consistency.

<br />

# Implementing Flows into your app

There are several ways to display a Flow inside of the app:

1. Pre-fetching the Flow and using the `display()` method 
2. Manually integrating the Flow inside of your app (Android only)
3. Using the Flow deeplink

Let's dig into each of them

## 1. Prefetching the Flow and using the `display()` method - recommended

In the Purchasely Console, [Flows can be associated with a Placement](flows#mapping-a-flow-with-a-placement).

To display a Flow, the recommended method consists in pre-fetching it ([more information on pre-fetching](pre-fetching)) and then showing it to the user using the `display()` method. This new method has been added along with the `v5.3.0` of the SDK

<SDKDisplayMethodCodeSnipped />

<br />

The `display()` method automatically:

- Handles navigation inside the Flow (based on the transitions you configured in the Flow Composer)
- Applies the Flow’s Display Mode (modal, fullscreen, push, drawer, pop‑in)

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/a276eec6e01d7f867cef0337f4567a612c78e017326579818da016559673cd7f-display_mode.gif",
        "",
        "The display mode defines how the first Screen of the Flow should open"
      ],
      "align": "center",
      "border": true,
      "caption": "The display mode defines how the first Screen of the Flow should open"
    }
  ]
}
[/block]


- Works uniformly across all screen types (paywalls, quizzes, landing pages, etc.)

> 🚧 Push display mode requires a navigation bar in the parent view
> 
> The **Display mode** `Push` only works if the parent view already contains a navigation bar. 
> 
> If you try to display a Screen/Flow associated with the `Push` display mode from a parent view which doesn't have a navigation bar associated, the display() method will fallback on the default display mode:
> 
> - Modal on iOS
> - Full Screen on Android

<br />

## 2. Manually integrating the Flow inside of your app (Only on Android)

If you want to integrate the Flow manually into your app / parent view, you should check the attribute `displayMode` carried by the `PLYPresentation` returned by the pre-fetching

```kotlin Kotlin
Purchasely.fetchPresentation(placementId = "onboarding") { presentation, error ->
  error?.let {
    Toast.makeText(context, "Error fetching presentation", Toast.LENGTH_SHORT).show()
    return@fetchPresentation
  }

  presentation?.let {
    val fragment = it.getFragment(){ result, plan ->
      when(result) {
        PLYProductViewResult.PURCHASED -> Log.d("Purchasely", "User purchased ${plan?.name}")
        PLYProductViewResult.CANCELLED -> Log.d("Purchasely", "User cancelled purchased")
        PLYProductViewResult.RESTORED -> Log.d("Purchasely", "User restored ${plan?.name}")
      }
    }

    when(it.displayMode?.type) {
      PLYTransitionType.PUSH -> {
        // Handle push transition
        Log.d("Purchasely", "Display it as a push transition")
      }
      PLYTransitionType.FULLSCREEN -> {
        // Handle pop transition
        Log.d("Purchasely", "Display it as a fullscreen transition")
      }
      PLYTransitionType.MODAL -> {
        // Handle modal transition
        Log.d("Purchasely", "Display it as a modal transition")
      }
      PLYTransitionType.DRAWER -> {
        // Handle drawer transition
        val heightPercentage = it.displayMode?.heightPercentage
        Log.d("Purchasely", "Display it as a drawer transition with height percentage: $heightPercentage")
      }
      PLYTransitionType.POPIN -> {
        // Handle pop-in transition
        val heightPercentage = it.displayMode?.heightPercentage
        Log.d("Purchasely", "Display it as a pop-in transition with height percentage: $heightPercentage")
      }
      null -> {
        // Handle no transition
      }
    }
  } ?: run {
    Toast.makeText(context, "Presentation is null", Toast.LENGTH_SHORT).show()
    return@fetchPresentation
  }
}
```

<br />

## 3. Using the Flow deeplink

To use this method, you need to have implemented [Deeplink management](deeplinks-management)  
You can trigger the display of a Flow using its deeplink, the SDK will automatically display it.

You can also display the Flow yourself by implementing the [UIHandler](ui-handler-deeplinks)  
Quick example:

```swift Swift

extension myClass: PLYUIHandler {
    func display(presentation: PLYPresentation, from sourceController: UIViewController?, proceed: @escaping () -> ()) {
      presentation.display(from: nil)
    }
}
```
```kotlin Kotlin
Purchasely.uiHandler = object : PLYUIHandler {
  override fun onPresentation(presentation: PLYPresentation, proceed: () -> Unit) {
    // Display the flow
    presentation.display(context)
  }
}

```

In this case, the **Display mode** is automatically taken into consideration by the SDK if you call the method `display`.  
Otherwise, you need to retrieve the display mode from the presentation object to display it accordingly.  
Learn more in our dedicated section about the [UIHandler](ui-handler-deeplinks)