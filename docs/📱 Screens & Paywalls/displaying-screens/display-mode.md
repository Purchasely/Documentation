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

<Image align="center" className="border" border={true} src="https://files.readme.io/4a3d4c0e5e7ea20876ed959f203e623858cd7e12ac9de95c8c9c6556382ee770-types.gif" />

<br />

<br />

# Changing the display mode

You can change the display mode from the Screen Composer by clicking on the Screen name in the top bar and changing the parameter value.

<Image align="center" className="border" border={true} src="https://files.readme.io/14c3fb70622f64c6161f57c939b82f3797c419c321dac1fc9ed8aebe475ff1cc-display_mode_console.gif" />

If no display mode has been configured, the default display mode is applied by the SDK is `Modal`. The default display mode will also be applied by versions of the SDK inferior to 5.3

For drawers and popins, you can set the desired height:

<Image align="center" className="border" border={true} src="https://files.readme.io/b355f6c38b89ae7c02b022e86cfdcc9c96aea71d57cc3ae9d7fee408efb7cf69-image.png" />

<br />

On iOS, the **Display mode** `Push` is only available, if the parent view already contains a navigation bar.

On Android or without a navigation bar, the **Display mode** will fallback to `Modal`

> 🚧 The configured display mode does not reflect in the preview of the Console
>
> This means that it will not reflect in the Console if you change it.
>
> This will require a bit more work and we hope to make it available soon... Stay tuned!

# Implementation

To manage the display mode in the app, 2 different methods are available:

1. The simplest one: by leverage the `display()` API of the SDK
2. The manual one: by fetching the value of the display\_mode parameter manually and handling it yourself

<br />

## Leveraging the `display()` API of the SDK

You can simply pre-fetch a presentation (e.g.: from the Placement ID associated with it) and then call the `display()`  API of the SDK

```swift Swift
Purchasely.fetchPresentation(for: "onboarding", fetchCompletion: { presentation, error in
      guard error == nil,
            let presentation = presentation else { return }
                                                                  
     // Calling display() to launch the flow
		 // Source UIViewController is optional 
     presentation.display(from: myUIViewController) 
})
```
```kotlin Kotlin
Purchasely.fetchPresentation(placementId = "onboarding") { presentation, error ->
  if(error != null) {
    Log.d("Purchasely", "Error fetching Screen", error)
    return@fetchPresentation
  }
  
  // Calling display() to launch the flow 
  presentation?.display(context) { result, plan ->
    when (result) {
      PLYProductViewResult.PURCHASED -> Log.d("Purchasely", "User purchased ${plan?.name}")
      PLYProductViewResult.CANCELLED -> Log.d("Purchasely", "User cancelled purchased")
      PLYProductViewResult.RESTORED -> Log.d("Purchasely", "User restored ${plan?.name}")
    }
  } ?: run {
    Toast.makeText(context, "Presentation display failed: presentation is null", Toast.LENGTH_SHORT).show()
    return@fetchPresentation
  }
}
```

<br />

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
