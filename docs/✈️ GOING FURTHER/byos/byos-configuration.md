---
title: BYOS - Configuration guide
excerpt: >-
  This page provides details on how to configure a Custom Screen in the
  Purchasely Console
deprecated: false
hidden: false
metadata:
  robots: index
next:
  description: Follow the implementation guide to integrate BYOS into your app
  pages:
    - slug: byos-implementation
      title: BYOS - Implementation guide
      type: basic
---
> 🚧 SDK v5.6.0+ mandatory
>
> BYOS requires SDK v5.6 ([changelog](/changelog/56)) or later and the use of the `display()` method to show In-App Experiences.
>
> It is currently available for **native Swift and Kotlin apps** and will be extended to React Native, Flutter, and Cordova in a future release.

# Creating a Custom Screen

1. Create a new Screen in the Screen Composer and choose the layout **Bring Your Own Screen**.

   <Image align="center" border={true} src="https://files.readme.io/24a01f0bb80056fea3a71f2d3d2359b17417cd32abd6ba6c71f45a70c79f1fd2-custom_screen.gif" className="border" />
2. Enter the Screen ID for your Custom Screen. This Screen ID needs to be communicated to your mobile engineers as they will need it to know which custom screen shall be displayed.

   <Image align="center" border={true} src="https://files.readme.io/c05e9e22184602922a4589b90ae7eb5544f9d776b47c31f2826f5b0dc0bf95e1-image.png" className="border" />

   <br />
3. Associate a screenshot of the Screen as the background image to make it easy to recognize

   <Image align="center" border={true} src="https://files.readme.io/cd011ef37a883192a723edeb05afb2d959b1909ea7afd3de0f023d43a41df2c6-custom_screen_3.gif" className="border" />
4. Define the connections (e.g., login_successful, signup, cancel) — these determine the possible exit points for the Screen

   <Image align="center" border={true} src="https://files.readme.io/a0f2da3de5d3d473957f00cb9310a45f62ffe3f8c71c1da9e1d88af2566f98b3-custom_screen_2.gif" className="border" />

   Note: The IDs defined for the connections need to be decided with / provided to your mobile engineering team as they will need them in the code of the BYOS implementation.
5. [Mobile engineers] Implement BYOS into your app

   📚 [Follow the guide to implement BYOS into your app](byos-implementation)

<br />

<br />

# Bringing You Own Screen Within a Flow

BYOS allows you to blend native app screens and Purchasely-generated screens into one seamless user journey.

1. Insert your Custom Screen anywhere in the Flow from the Console — including as the very first step.

   <Image align="center" border={true} src="https://files.readme.io/b40487455bd22f205ac7760714651307cd7072e68d58535a1e3f0cb8e6811b89-custom_screen_flow.gif" className="border" />
2. Connect it to other Screens in the Flow and define the transition type for each incoming and outgoing connection.

   <Image align="center" border={true} src="https://files.readme.io/b17360c683d2f65696b5cded60b54d926e37ef504c16cfa725116bdeaf751c6b-custom_screen_flow_2.gif" className="border" />

<br />

The Custom Screen will appear in the Flow’s navigation exactly according to the transition you configured.

* Example: If the connection leading to your Custom Screen uses the pop-in transition, the SDK will display your native screen as a pop-in.

You can also chain multiple Custom Screens together and control the transition of each link independently.

* Example: If your sign-in process spans several native steps, each step can be mapped to its own Custom Screen node with its own transition.

<br />

# Using BYOS Within a Paywall A/B Test

You can also include Custom Screen inside Paywall experiments in A/A test or A/B test scenario.

1. create a Custom Screen corresponding to your existing in-house Paywall - don't forget the Screenshot!

   <Image align="center" border={true} src="https://files.readme.io/d4e9d9fd4bcaa1b9a1de76966d807e3e96c4a1885a2e26515f63bcb9a48e4d0c-custom_paywall.gif" className="border" />
2. Integrate it in your A/B test as the control variant

   <Image align="center" border={true} src="https://files.readme.io/9e69f2d071f18843953e23a06ca82ee34f0acaf4b8f5918dd9eff8806ee683ca-ab_test.gif" className="border" />

<br />

# Using BYOS to reorder steps in your existing onboarding Flow without code

BYOS lets you recreate and manage your existing native onboarding flow inside Purchasely by representing each of your native screens as a Custom Screen node. Once mapped, you can reorder, insert, or remove steps directly from the Console — giving you full no-code control over the structure and sequencing of your onboarding while preserving your original UI.

1. Create one Custom Screen for each native onboarding step, assign it a Screen ID, and define its connections (exit points).
2. Add all these Custom Screens to a Flow in the Console.
3. Drag and drop the nodes to reorder, insert, or remove steps as needed.
4. Draw the transitions between nodes and attach the appropriate connections to each one.
5. Publish the Flow so the SDK orchestrates your onboarding sequence according to your no-code configuration.

Note: This requires having implemented BYOS in your app and mapping each onboarding view controller to its corresponding Screen ID and connections.

# Tracking of the Custom Screens

When a Flow is displayed by the SDK, Custom Screens are automatically tracked like any other Purchasely Screen.
Each time a Custom Screen is shown, the SDK emits a `PRESENTATION_DISPLAYED` event containing the Screen ID (in the `displayed_presentation` property). This allows you to analyze user paths, visualize transitions, and measure drop-off at every step of the Flow. This is also used to compute conversion rates in A/B tests.

Custom Screens are also tracked outside of a Flow, but only when displayed via the SDK’s `display()` method.

If your app manually fetches Screens and displays the Custom Screen’s view controller itself - without using the SDK’s `display()` method - you must trigger the tracking events manually:

* call `clientPresentationDisplayed(presentation)` when your Custom Screen is shown
* call `clientPresentationClosed(presentation)` when it is dismissed

These calls ensure the Custom Screen appears in your analytics.

Finally, note that user interactions inside Custom Screens are not tracked by the SDK, since these screens are fully managed by your app. If you require interaction-level analytics, you should instrument them directly in your own client-side code.

> ❗️ Don't forget to synchronize purchases
>
> In a Paywall A/B test scenario, make sure with your engineering team that [the In-App Purchases performed inside the Custom Screen are properly synchronized](https://docs.purchasely.com/docs/byos-implementation#synchronizing-purchases).
>
> If purchases are not synchronized, in-app purchases happening on your Custom Paywall will not be counted by the SDK and integrated in the A/B test data.

<br />
