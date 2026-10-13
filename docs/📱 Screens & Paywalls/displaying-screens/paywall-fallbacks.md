---
title: Paywall fallbacks
excerpt: >-
  What the SDK shows when the requested Screen is not available, and what your
  app must do when the device cannot reach Purchasely
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Purchasely has fallback mechanisms on the server side. The SDK does not have an offline fallback. This page tells you what each mechanism covers and what your app must do.

| Situation | What Purchasely does | What your app does |
| --- | --- | --- |
| No audience of the placement matches the user | Sends the default Screen of the placement | Display it |
| The placement has no default Screen | Sends the default paywall of the app | Display it |
| An error occurs on the server while it selects the Screen | Sends the default Screen of the placement, with the type `fallback` | Display it |
| The SDK version of the user cannot show the Screen | Sends the fallback Screen for this SDK version | Display it |
| The device cannot reach Purchasely (no network, timeout, outage) | Nothing: the SDK returns an error | Show your own native paywall, or skip the paywall |

<br />

# Server-side fallbacks

When the SDK requests a Screen for a placement, the server selects the Screen in this order:

1. The Screen of the first audience of the placement that matches the user (or a variant of the A/B test of this audience).
2. If no audience matches: the **Default screen or flow** of the placement.
3. If the placement has no default Screen: the **Default paywall** of the app, in **App settings**.

If you set the default Screen of the placement to **None**, the SDK receives a presentation of the type `deactivated`. Display nothing in this case.

If an error occurs on the server while it selects the Screen, the server sends the default Screen of the placement. The presentation then has the type `fallback`. Display it as a normal Screen.

To read the presentation type before you display the Screen, use `preload`. Refer to [Pre-fetching Screens](pre-fetching) for the list of types and what to do for each type.

> 📘 Set a default paywall for the app
>
> The default paywall of the app is the last server-side fallback. Make sure that it is set in **App settings**, and that it contains your main offers.

<br />

# Fallbacks for older SDK versions

Some Screens need a minimum SDK version. Purchasely selects a different Screen for users with an older SDK.

| Content | Minimum SDK version | Users with an older SDK receive |
| --- | --- | --- |
| Screen made with the Screen Composer | 5.0.0 | The Screen set in **Fallback screen for SDK versions below 5**, in the settings of the Screen. If this field is empty, the default paywall of the app. |
| [Flow](flows) | 5.3.0 | The default Screen of the Flow. If the Flow has no default Screen, the default paywall of the app. |

These fallbacks are automatic. You do not need to change your app.

## Target a simpler Screen by SDK version

A Screen can use a component that an older SDK version cannot show. To give a simpler Screen to these users, use an [audience](audiences) on the SDK version:

1. Duplicate the Screen, then remove the components that the older SDK cannot show.
2. Create an audience with the criterion **SDK version** **is lower than** the minimum version (for example `6.2.0`).
3. In the placement, add this audience above the other audiences, and associate it with the simpler Screen.

The SDK sends its version with each request, so the server selects the correct Screen. The [SDK versions](sdk-versions) dashboard shows how many of your users have each SDK version.

<br />

# No network: show your own paywall

The SDK does not keep its own copy of the last Screen to show when the network is not available. Purchasely does not have a paywall bundled in the app either. If the device cannot reach Purchasely, the fetch or display call returns an error, and the SDK shows nothing.

Your app must handle the error branch. Show your own native paywall, or continue without a paywall.

```swift Swift
PLYPresentationBuilder
    .forPlacementId("onboarding")
    .build()
    .preload { presentation, error in
        guard let presentation = presentation, error == nil else {
            // No network, timeout or outage: show your own paywall
            self.showNativePaywall()
            return
        }

        if presentation.type == .normal || presentation.type == .fallback {
            presentation.display(from: myUIViewController)
        }
        // Handle .deactivated and .client as described in Pre-fetching Screens
    }
```
```kotlin Kotlin
PLYPresentation {
    placementId("onboarding")
}.preload { presentation, error ->
    if (error != null || presentation == null) {
        // No network, timeout or outage: show your own paywall
        showNativePaywall()
        return@preload
    }

    when (presentation.type) {
        PLYPresentationType.NORMAL,
        PLYPresentationType.FALLBACK -> presentation.display(context)
        // Handle DEACTIVATED and CLIENT as described in Pre-fetching Screens
        else -> {}
    }
}
```
```javascript React Native
try {
  const request = Purchasely.presentation.placement('onboarding').build()
  const presentation = await request.preload()

  if (presentation.type === PLYPresentationType.NORMAL ||
      presentation.type === PLYPresentationType.FALLBACK) {
    await request.display()
  }
  // Handle DEACTIVATED and CLIENT as described in Pre-fetching Screens
} catch (e) {
  // No network, timeout or outage: show your own paywall
  showNativePaywall()
}
```
```javascript Flutter
try {
  final request = PLYPresentationBuilder.placement("onboarding").build();
  final presentation = await request.preload();

  if (presentation.type == PLYPresentationType.normal ||
      presentation.type == PLYPresentationType.fallback) {
    await request.display();
  }
  // Handle deactivated and client as described in Pre-fetching Screens
} catch (e) {
  // No network, timeout or outage: show your own paywall
  showNativePaywall();
}
```

> 📘 Pre-fetch the Screen early
>
> A Screen that you load with `preload` stays loaded on that request during the session. [Pre-fetch](pre-fetching) the Screen when the user starts the onboarding, or when the app starts, so that the Screen is ready before you need it.

The stores also need the network to give the prices and to process a purchase. When the device is offline, a purchase is not possible, also from your own paywall.
