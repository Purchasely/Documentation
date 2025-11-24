---
title: BYOS - Configuration guide
excerpt: >-
  This page provides details on how to configure a Custom Screen in the
  Purchasely Console
deprecated: false
hidden: true
metadata:
  robots: index
---
# Creating a Custom Screen

1. Create a new Screen in the Screen Composer and choose the layout **Bring Your Own Screen**.

   <Image align="center" border={true} src="https://files.readme.io/152ce49725316e7d5201e370242da14dfb4afad365a010b46e4e530c00bc6ab1-custom_screen_1.gif" className="border" />
2. Associate a screenshot of the Screen as the background image to make it easy to recognize

   <Image align="center" border={true} src="https://files.readme.io/fc5efa816ce5c7e8a54db41d0d6b0f41f44041133059af31e468c32924152a16-custom_screen_2.gif" className="border" />
3. Define the connections (e.g., login_successful, signup, cancel) — these determine the possible exit points for the Screen

   <Image align="center" border={true} src="https://files.readme.io/19b9e55f71091b6bfd168577e87a893fdca4bd32719ef2998d163f3f54ad9e0e-custom_screen_3_-_connections.gif" className="border" />

   Note: The IDs defined for the connections need to be decided with / provided to your mobile engineering team as they will need them in the code of the BYOS implementation.
4. [Mobile engineers] Implement BYOS into your app

   📚 [Follow the guide to implement BYOS into your app](byos-implementation)

<br />

<br />

## Bringing You Own Screen Within a Flow

BYOS allows you to blend native app screens and Purchasely-generated screens into one seamless user journey.

1. Insert your Custom Screen anywhere in the Flow from the Console — including as the very first step.

   <Image align="center" border={true} src="https://files.readme.io/08df9e08ec7d4c74da0e92c1999496e257141159300ee66b34c87de61720b9d2-custom_screen_4_-_drag__drop.gif" className="border" />
2. Connect it to other Screens in the Flow and define the transition type for each incoming and outgoing connection.

   <Image align="center" border={true} src="https://files.readme.io/6d1a2fadb35fd34f2ae028cbbdef6f218c1b01f8ab5b77d8aa9b9cd86fbdbce1-custom_screen_5.gif" className="border" />

<br />

The Custom Screen will appear in the Flow’s navigation exactly according to the transition you configured.

* Example: If the connection leading to your Custom Screen uses the pop-in transition, the SDK will display your native screen as a pop-in.

You can also chain multiple Custom Screens together and control the transition of each link independently.

* Example: If your sign-in process spans several native steps, each step can be mapped to its own Custom Screen node with its own transition.

<br />

## Using BYOS Within a Paywall A/B Test

You can also include Custom Screen inside Paywall experiments in A/A test or A/B test scenario.

1. create a Custom Screen corresponding to your existing in-house Paywall - don't forget the Screenshot!

   <Image align="center" border={true} src="https://files.readme.io/9fc04be352a7e35a931ef03e1998cb29f5fe302e25f81e7286ff77c99e17afaa-custom_paywall.gif" className="border" />
2. Integrate it in your A/B test as the control variant

   <Image align="center" border={true} src="https://files.readme.io/8431bd8e9a63f6f5c892a6d73af18092368930e1fbaacd12a3f89dd34757e69c-custom_paywall_ab_test.gif" className="border" />

<br />

## Tracking of the Custom Screens

When a Flow is displayed by the SDK, Custom Screens are automatically tracked just like any other Purchasely Screen. Each time a Custom Screen appears, the SDK emits a `PRESENTATION_DISPLAYED` event containing the Screen ID (in the `displayed_presentation` property). This allows you to analyze user paths, visualize transitions, and measure drop-off at every step of the Flow.

User interactions inside Custom Screens are not tracked by the SDK, since these screens are fully controlled by your app. If you need additional interaction analytics, you should instrument them directly within your client-side code.

In a Paywall A/B test scenario, make sure with your engineering team that [the In-App Purchases performed inside the Custom Screen are properly synchronized](https://docs.purchasely.com/docs/byos-implementation#synchronizing-purchases).

<br />
