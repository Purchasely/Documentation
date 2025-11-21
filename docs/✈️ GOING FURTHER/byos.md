---
title: Bring Your Own Screen
deprecated: false
hidden: true
metadata:
  robots: index
---
**Bring Your Own Screen** (BYOS) lets you embed your own native screens directly inside Purchasely Flows. It extends the no-code experience by allowing you to add custom steps — such as sign-in, sign-up, forms with text fields, or any screen integrating highly specific UI components that cannot be built with the Screen Composer.

# When to Use BYOS

Bring Your Own Screen is useful whenever you want to combine the flexibility of your native screens with the orchestration and analytics of Purchasely Flows.
You should use BYOS in the following situations:

1. **Integrating a custom screen inside a Purchasely Flow**
   When you need a step that cannot be built with the Screen Composer — such as authentication, forms, or screens with complex logic — BYOS lets you plug your native screen directly into the Flow.
2. **Running an A/B test between your existing paywall and a Purchasely paywall**
   BYOS allows you to include your legacy paywall as a variant in a Purchasely experiment without rebuilding it in the Console.
3. **Running an A/A test between your existing paywall and its Purchasely version**
   If you reimplemented your paywall using Purchasely’s Screen Composer, BYOS lets you compare both versions under identical conditions to validate performance and consistency.
4. **Reordering steps in your existing onboarding flow without code**
   BYOS allows you to orchestrate the sequence of your native onboarding screens around Purchasely screens — letting you reorder, insert, or remove steps entirely in no-code.

<br />

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

<br />

<br />

## Using BYOS Inside a Flow

When a Flow reaches a Custom Screen step, the same handover mechanism applies:

1. The SDK requests the next screen in the Flow sequence.
2. The SDK detects that the step is a Custom Screen and triggers the callback with the Screen ID and its connections.
3. The app creates the native view controller and returns it to the SDK, which displays it with the Flow’s configured transition
4. The app manages all interactions on the Custom Screen while the Custom Screen is displayed
5. The app resumes the Flow by calling the SDK’s execute method with the selected connection, and the Flow continues to the next mapped step.

Additionally, when integrating a Custom Screen into a Flow, you can configure its display mode and transition type (modal, drawer, pop-in, full-screen, etc.) directly from the Console. The SDK will apply those transitions when displaying your native view controller.

<br />

## Synchronizing Purchases

If a purchase is performed within a Custom Screen, your app must call the SDK’s `synchronize()` method.
This allows the SDK to retrieve the latest receipt and extract the purchase information.

This is particularly important in A/B or A/A test scenarios, where accurate purchase tracking is required to attribute conversions correctly.

<br />

# Implementation Guidelines

You will find code snippets in the next section, but here is the general setup process:

Create a Custom Screen in the Screen Composer and mark it as “Bring Your Own Screen”.

Define its connections (e.g., login_success, create_account, cancel) — these determine the next step in the Flow.

Implement the delegate/callback in your app to intercept the BYOS event from the SDK.

Render your native screen using your preferred framework (Swift, Kotlin, Flutter, React Native).

Resume the Flow by calling Purchasely.nextInFlow(connection_vendor_id) when the user completes the step, or Purchasely.backInFlow() to go back.

Using BYOS Within a Flow

Insert your BYOS node anywhere in a Flow via the Console.

It behaves like any other step: you can set entry/exit transitions, tracking, and analytics.

All events (viewed, closed, next) are automatically logged by the SDK when the Flow resumes.

Each connection leads to the appropriate next screen or action, as defined in the Flow graph.

This allows you to blend native app screens and Purchasely-generated screens into one seamless user journey.

Using BYOS Within a Paywall A/B Test

You can also include BYOS nodes inside paywall experiments to test different entry paths or onboarding variants:

Define the BYOS step within each test variant.

Use the same analytics logic — events from custom screens are tracked once the Flow resumes.

Measure the impact of your native step (e.g., a custom login, survey, or tutorial) on conversion, engagement, or retention.

BYOS ensures A/B tests remain consistent across both Purchasely-rendered and app-rendered experiences.
