---
title: BYOS - Configuration guide
deprecated: false
hidden: true
metadata:
  robots: index
---
# Creating a Bring Your Own Screen

1. Create a Screen in the Screen Composer and choose the layout **Bring Your Own Screen**.
   <br />
2. Associate a screenshot of the Screen as the background image to make it easy to recognize
   <br />
3. Define the connections (e.g., login_successful, signup, cancel) — these determine the possible exit points for the Screen
   <br />
4. Implement the delegate/callback in your app to intercept the BYOS event from the SDK.
5. Render your native screen and return it to the SDK that will display it
6. Resume the Flow by calling  when the user completes the step - or Purchasely.backInFlow() to go back.

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
