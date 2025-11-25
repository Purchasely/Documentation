---
title: BYOS - Implementation guide
excerpt: >-
  This page provides a comprensive overview of the implementation of Custom
  Screens into your app and includes general functioning and code snippet both
  inside and outside of a Flow
deprecated: false
hidden: false
metadata:
  robots: index
---
# How It Works

BYOS relies on a simple handover mechanism between the Purchasely SDK and your application.
The process is always the same — whether the Screen is used inside a Flow, as part of a Paywall A/B test, or displayed as a standalone Screen.

## General functioning

Here’s the general lifecycle of a Custom Screen:

1. The app requests a Screen from the SDK using the usual fetch method.
2. If the retrieved Screen is a Custom Screen, the SDK does not render it and triggers a callback with:
   * the Screen ID
   * the list of connections (exit points)
3. The app generates the corresponding native view controller and returns it to the SDK, which displays it using Purchasely's navigation layer (modal, push, drawer, full screen, etc).
4. While the Custom Screen is visible, the app manages all user interactions and business logic (e.g., text inputs, sign-in flow, validation, API calls)
5. When the user completes the step, the app calls the SDK’s execute method with the selected connection, indicating what should happen next

## Using BYOS Inside a Flow

When a Flow reaches a Custom Screen step, the same handover mechanism applies:

1. The SDK requests the next screen in the Flow sequence.
2. The SDK detects that the step is a Custom Screen and triggers the callback with the Screen ID and its connections.
3. The app creates the native view controller and returns it to the SDK, which displays it with the Flow’s configured transition
4. The app manages all interactions on the Custom Screen while the Custom Screen is displayed
5. The app resumes the Flow by calling the SDK’s execute method with the selected connection, and the Flow continues to the next mapped step.

<br />

# Implementation Guidelines

To integrate a Custom Screen using BYOS, you must implement three components on the app side:

### 1. Handle the BYOS callback

Your app must implement the SDK delegate or callback that is triggered whenever a Custom Screen is retrieved.
This callback gives you the `PLYPresentation` containing:

* the Screen ID
* the list of connections (exit points)

```swift
@objc public class PLYPresentation: NSObject {
  @objc public let id: String?
	@objc public let language: String
	@objc public let placementId: String?
  @objc public let audienceId: String?
  @objc public let abTestId: String?
  @objc public let abTestVariantId: String?
  @objc public let campaignId: String?

  // ...

  @objc public var connections: Set<PLYConnection>
}

/**
 * Represents a connection in a presentation that defines navigation or action paths.
 * Connections allow custom screens to trigger actions such as navigating to other screens,
 * completing flows, or executing other configured behaviors.
 */
@objc public class PLYConnection: NSObject, Identifiable {
    /// Your Connection's ID, as set in the console
    @objc public var id: String {
        _connection.id
    }
}

/**
 * Used to provide a UIViewController for a given Custom Screen presentation when the SDK is to display a Custom Screen
 */
@objc public protocol PLYCustomScreenViewControllerDelegate {
    /**
     * Called when the Purchasely SDK is attempting to display a Custom Screen
     * - Parameter presentation: the Custom Screen's presentation
     *
     * - Returns: a `UIViewController` or `nil` if no view should be displayed or the SDK should fall back to the `PLYCustomScreenViewDelegate`
     */
    @objc func viewController(for presentation: PLYPresentation) -> UIViewController?
}

/**
 * Used to provide a SwiftUI View for a given Custom Screen presentation when the SDK is to display a Custom Screen
 */
public protocol PLYCustomScreenViewDelegate {
    associatedtype Content: View
    /**
     * Called when the Purchasely SDK is attempting to display a Custom Screen
     * - Parameter presentation: the Custom Screen's presentation
     *
     * - Returns: a SwiftUI `View` or `EmptyView` if no view should be displayed
     */
    @ViewBuilder func view(for presentation: PLYPresentation) -> Content
}

/**
 * Sets the Custom Screen UIKit delegate.
 *
 * - Parameters:
 * - delegate: An instance conforming to the `PLYCustomScreenViewControllerDelegate` protocol
 *
 * - Note: should be called after the SDK has started.
 * - Note:
 * Both a UIKit and SwiftUI Custom Screen delegate can be set.
 * If set, the UIKit Custom Screen delegate will be called first. If it does not return a UIViewController, the SDK will fall back to the SwiftUI Custom Screen delegate.
 * Should the SwiftUI Custom Screen delegate not be set or return an EmptyView, the view will be closed.
 */
class Purchasely.setCustomScreenViewControllerDelegate(_:)

/**
 * Clears the UIKit Custom Screen delegate.
 */
class Purchasely.removeCustomScreenViewControllerDelegate()

/**
 * Sets the Custom Screen SwiftUI delegate.
 *
 * - Parameters:
 * - delegate: An instance conforming to the `PLYCustomScreenViewDelegate` protocol
 *
 * - Note: should be called after the SDK has started.
 * - Note:
 * Both a UIKit and SwiftUI Custom Screen delegate can be set.
 * If set, the UIKit Custom Screen delegate will be called first. If it does not return a UIViewController, the SDK will fall back to the SwiftUI Custom Screen delegate.
 * Should the SwiftUI Custom Screen delegate not be set or return an EmptyView, the view will be closed.
 */
class Purchasely.setCustomScreenViewDelegate(_:)

/**
 * Clears the SwiftUI Custom Screen delegate.
 */
class Purchasely.removeOwnScreenViewDelegate()
```
```kotlin

/**
 * Represents a custom screen that can be displayed within a Purchasely flow.
 *
 * Clients can provide either a View or a Fragment implementation when responding
 * to custom screen requests via [PLYCustomScreenProvider].
 *
 * @see PLYCustomScreenProvider
 */
sealed class PLYCustomScreen {
    /**
     * A custom screen backed by an Android View.
     * @property view The View to display
     */
    data class View(val view: android.view.View) : PLYCustomScreen()

    /**
     * A custom screen backed by an Android Fragment.
     * @property fragment The Fragment to display
     */
    data class Fragment(val fragment: androidx.fragment.app.Fragment) : PLYCustomScreen()
}


/**
 * Interface for providing custom screens within Purchasely flows.
 *
 * Clients should implement this interface and register it via
 * [Purchasely.setOwnScreenProvider] to provide their own UI for specific presentations.
 *
 * When a presentation is marked as client-controlled (type == CLIENT), the SDK will
 * invoke [onCustomScreenRequested] to obtain the custom screen implementation.
 *
 * @see PLYCustomScreen
 * @see Purchasely.setOwnScreenProvider
 */
interface PLYCustomScreenProvider {
    /**
     * Called when the SDK needs a custom screen for the given presentation.
     *
     * @param presentation The presentation requesting a custom screen
     * @return A [PLYCustomScreen] containing either a View or Fragment, or null if no custom screen is available
     */
    fun onCustomScreenRequested(presentation: PLYPresentation): PLYCustomScreen?
}
```

<br />

### 2. Construct and return the native view controller

Based on the Screen ID, your app should instantiate the corresponding native UI (Swift/Kotlin/RN/Flutter).
You then return that view controller to the SDK, which inserts it into Purchasely’s navigation layer.

```swift
@mobile team: 
code de la methode PLYCustomScreenProvider / PLYCustomScreenViewDelegate / PLYCustomScreenViewControllerDelegate
```
```kotlin
```

<br />

### 3. Resume execution by calling the SDK

When the user completes the Custom Screen, call the SDK’s `execute()` method with the chosen connection.

This tells Purchasely what to do next (continue a Flow, trigger an action, etc.).

```swift
/**
 * Notifies the presentation a Connection should be executed.
 * Call this method with the matching connection when a user performs an action on your Custom Screen
 * - Parameter connection: The `PLYConnection` object representing the connection. If nil, will fall back to the presentation's default connection.
 *
 * Calling this method may trigger UI updates or other side effects related to the connection.
 */
PLYPresentation.executeConnection(_:)

Example:

let login = presentation.connections.first(where: { $0.id == "login" })
presentation.exect
```
```kotlin
```

In the context of a Flow, calling this method will take the user to the next step in the Flow - the one associated with the connection.

Example:

1. Calling `execute(email)` will take the user to the email checking screen - which is another Custom Screen

   <Image align="center" border={true} src="https://files.readme.io/497f65ee3b2d20cb33e4b6494ee66eccde496f3185f974a67632015a4aeb1995-custom_screen_6.gif" className="border" />
2. For social connections, the process is managed by the the app through the Custom Screen `sign_in_screen` view controller. Once the user has completed the social connection, calling `execute(social_connection_successful)` will take the user to the final screen of the Flow, bypassing the email validation process.

   <Image align="center" border={false} src="https://files.readme.io/7e2eea5bfb7a0f7f0d4a2398ccb8fdbe31350a21696d5f46f4c8a6892c35cf22-custom_screen_7.gif" />

### Outside of a Flow

Outside of Flow, calling the method `execute()` will trigger the action associated with the connection passed in parameter (Purchase, Open Screen, Open Placement, Deeplink, Close, Close all etc...)

<br />

## Synchronizing Purchases

If a purchase is performed within a Custom Screen, your app must call the SDK’s `synchronize()` method.
This allows the SDK to retrieve the latest receipt and extract the purchase information.

```swift
@mobile team: 
appel à la méthode synchronize() après un achat
```
```kotlin
```

This is particularly important in A/B or A/A test scenarios, where accurate purchase tracking is required to attribute conversions correctly.

<br />

## Tracking of the Custom Screens

When a Flow is displayed by the SDK, Custom Screens are automatically tracked just like any other Purchasely Screen. Each time a Custom Screen appears, the SDK emits a `PRESENTATION_DISPLAYED` event containing the Screen ID (in the `displayed_presentation` property). This allows you to analyze user paths, visualize transitions, and measure drop-off at every step of the Flow.

User interactions inside Custom Screens are not tracked by the SDK, since these screens are fully controlled by your app. If you need additional interaction analytics, you should instrument them directly within your client-side code.

<br />
