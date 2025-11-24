---
title: BYOS - Implementation guide
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

## Implementing the Custom Screen callback into your app

You can create as many Custom Screens as you need in the Purchasely Console. But all of them need to be mapped with the corresponding view controller in your app code.

When the callback is called by the SDK, the ID of the Custom Screen and the array of connections configured are passed as entry parameters.

Implement the following code snippet to match the Screen IDs with your in-house view controllers.

```swift
```
```kotlin
```

<br />

## Executing the action associated with a specific connection

You can create up to 20 different outgoing connections for a Custom Screen. But each connection ID configured needs to be mapped in your app code.

Once the user has completed the step corresponding to the Custom Screen, call the method `exectue()` of the SDK with a connection ID. If no connection ID / an invalid connection ID has been provided, the SDK will execute the connection configured as default.

```swift
```
```kotlin
```

<br />

### Within a Flow

In the context of a Flow, calling this method will take the user to the next Screen in the Flow associated with the connection.

Example:

1. Calling `execute()` with the connection ID `email` will get the user to the email checking screen - which is another Custom Screen

   <Image align="center" border={true} src="https://files.readme.io/497f65ee3b2d20cb33e4b6494ee66eccde496f3185f974a67632015a4aeb1995-custom_screen_6.gif" className="border" />
2. For social connections, the process is managed by the the app through the Custom Screen `sign_in_screen` view controller. Once the user has completed the social connection, calling `execute()` with the connection ID `social_connection_successful` will get the user to the final screen of the Flow, bypassing the email validation process.

   <Image align="center" border={false} src="https://files.readme.io/7e2eea5bfb7a0f7f0d4a2398ccb8fdbe31350a21696d5f46f4c8a6892c35cf22-custom_screen_7.gif" />

### Outside of a Flow

Outside of Flow, calling the method `execute()` will trigger the action associated with the connection passed in parameter (Purchase, Open Screen, Open Placement, Deeplink, Close, Close all etc...)

<br />

## Synchronizing Purchases

If a purchase is performed within a Custom Screen, your app must call the SDK’s `synchronize()` method.
This allows the SDK to retrieve the latest receipt and extract the purchase information.

This is particularly important in A/B or A/A test scenarios, where accurate purchase tracking is required to attribute conversions correctly.

<br />
