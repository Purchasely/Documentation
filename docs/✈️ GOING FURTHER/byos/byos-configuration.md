---
title: BYOS - Configuration guide
deprecated: false
hidden: true
metadata:
  robots: index
---
# Creating a Bring Your Own Screen

1. Create a Screen in the Screen Composer and choose the layout **Bring Your Own Screen**.

   <Image align="center" border={true} src="https://files.readme.io/152ce49725316e7d5201e370242da14dfb4afad365a010b46e4e530c00bc6ab1-custom_screen_1.gif" className="border" />
2. Associate a screenshot of the Screen as the background image to make it easy to recognize

   <Image align="center" border={true} src="https://files.readme.io/fc5efa816ce5c7e8a54db41d0d6b0f41f44041133059af31e468c32924152a16-custom_screen_2.gif" className="border" />
3. Define the connections (e.g., login_successful, signup, cancel) — these determine the possible exit points for the Screen

   <Image align="center" border={true} src="https://files.readme.io/19b9e55f71091b6bfd168577e87a893fdca4bd32719ef2998d163f3f54ad9e0e-custom_screen_3_-_connections.gif" className="border" />
4. Implement BYOS into your app

   📚 [Follow the guide to implement BYOS into your app](byos-implementation)

<br />

<br />

## Bringing You Own Screen Within a Flow

BYOS allows you to blend native app screens and Purchasely-generated screens into one seamless user journey.

1. Insert your BYOS node anywhere in a Flow via the Console (it can even be in the first position)
2. It behaves like any other step: you can set entry/exit transitions.
3. All  events (viewed, closed, next) are automatically traked by the SDK.
4. Each connection leads to the appropriate next screen or action, as defined in the Flow graph.

<br />

## Using BYOS Within a Paywall A/B Test

You can also include BYOS nodes inside paywall experiments in A/A test or A/B test scenario.

<br />
