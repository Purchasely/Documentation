---
title: Managing the display mode
excerpt: ''
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
In the Purchasely Console, you can define the Display Mode of a Screen and change it remotely.

This lets you configure remotely how Screens created in no-code with the Screen Composer should integrate in the user journey within your app.

<br />

> 🚧 SDK v5.3.0+ required
> 
> To leverage Flows, your app must be running [SDK version `v5.3.0`](https://docs.purchasely.com/changelog/53)

# Display modes available

Here are how the different display modes available

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/4a3d4c0e5e7ea20876ed959f203e623858cd7e12ac9de95c8c9c6556382ee770-types.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

<br />

# Changing the display mode

You can change the display mode from the Screen Composer by clicking on the Screen name in the top bar and changing the parameter value.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/14c3fb70622f64c6161f57c939b82f3797c419c321dac1fc9ed8aebe475ff1cc-display_mode_console.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


If no display mode has been configured, the default display mode is applied by the SDK is `Modal`. The default display mode will also be applied by versions of the SDK inferior to 5.3

For drawers and popins, you can set the desired height:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/b355f6c38b89ae7c02b022e86cfdcc9c96aea71d57cc3ae9d7fee408efb7cf69-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

On iOS, the **Display mode** `Push` is only available, if the parent view already contains a navigation bar.

On Android or without a navigation bar, the **Display mode** will fallback to `Modal`

> 🚧 The configured display mode does not reflect in the preview of the Console
> 
> This means that it will not reflect in the Console if you change it.
> 
> This will require a bit more work and we hope to make it available soon... Stay tuned!

<br />

# Implementation

To manage the display mode in the app, 2 different methods are available:

1. The simplest one: by leverage the `display()` API of the SDK
2. The manual one: by fetching the value of the display_mode parameter manually and handling it yourself

<br />

## Leveraging the `display()` API of the SDK

You can simply pre-fetch a presentation (e.g.: from the Placement ID associated with it) and then call the `display()`  API of the SDK

<br />

<SDKDisplayMethodCodeSnipped />

<br />

> 🚧 Push display mode requires a navigation bar in the parent view
> 
> The **Display mode** `Push` only works if the parent view already contains a navigation bar. 
> 
> If you try to display a Screen/Flow associated with the `Push` display mode from a parent view which doesn't have a navigation bar associated, the display() method will fallback on the default display mode:
> 
> - Modal on iOS
> - Full Screen on Android

<br />

> 📘 Difference between the Flow display mode and the transition type between Screens within a Flow
> 
> When configuring a Flow, it’s important to distinguish between the **Flow Display Mode** and the Transition Type. Each plays a distinct role in how screens appear within your app.
> 
> ### Flow Display Mode
> 
> The **Display Mode** determines how the first Screen of the Flow is presented within the app.
> 
> It defines the integration behavior between the Flow and the parent view managed by your app—such as whether the Flow is shown as a modal, fullscreen, embedded view, etc.
> 
> This setting is configured at the Flow level and applies only to how the Flow starts.
> 
> ### Screen Transition Type
> 
> The Transition Type defines how navigation occurs between Screens within the Flow.
> 
> It controls the animation or visual behavior when moving from one Screen to the next (e.g., slide, fade, instant).
> 
> You can configure a default Transition Type at the Flow level, and optionally override it for individual Transitions to customize specific paths in the user journey.
> 
> [block:image]{"images":[{"image":["https://files.readme.io/5709953934e193f8100d1672d0dad747b394de8cfeaa430b8d02a369552c3751-image.png",null,""],"align":"center","border":true}]}[/block]

## Manually fetching the the display mode from the SDK

If you want to integrate the display mode manually into your app / parent view, you should check the attribute `displayMode` carried by the `PLYPresentation` returned by the pre-fetching

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
```swift
TO BE COMPLETED
```

<br />

# Limitations with certain action types

> ❗️ The display mode is not taken into consideration with the actions Open Screen or Deeplink
> 
> When using the action Open Screen, Open Placemennt or Deeplink in a button, the display mode of the destination screen is not taken into consideration by the SDK. The display mode used in this case is always the default one (`Modal`)
> 
> If you want to implement specific transitions between Purchasely Screens, you need to leverage the Flows feature. [Check our documentation for more information](flows)