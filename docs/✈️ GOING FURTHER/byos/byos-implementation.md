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

## Synchronizing Purchases

If a purchase is performed within a Custom Screen, your app must call the SDK’s `synchronize()` method.
This allows the SDK to retrieve the latest receipt and extract the purchase information.

This is particularly important in A/B or A/A test scenarios, where accurate purchase tracking is required to attribute conversions correctly.

# Implementation Guidelines

<br />
