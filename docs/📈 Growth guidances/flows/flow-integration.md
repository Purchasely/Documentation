---
title: Integrating a Flow into your app
excerpt: This pages provides details on how to integrate a flow into your app
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    In the next section, we will explain how to integrate a Quiz into your Flow
    to fetch user insights
  pages:
    - type: basic
      slug: user-insights
      title: Leveraging Quizzes to fetch User Insights
---
> 🚧 SDK v5.5.0+ recommended
>
> Flows require to integrate SDK v5.3 and above. They are supported since this version, but we recommend v5.5.0 for a better stability and data consistency.

# Integrating a Flow into your app

## Configuring the display mode

To define the way a Flow should get displayed into your app, you can configure its display mode.

<Image align="center" src="https://files.readme.io/767cf232882a169d7fa4e6788b056994edf24f8f6c3e3084fa938a852044ef0e-display_mode_flows.gif" />

If no display mode has been configured, the default display mode is applied by the SDK is `Full screen`. 

For drawers and popins, you can set the desired height:

<Image align="center" className="border" border={true} src="https://files.readme.io/b355f6c38b89ae7c02b022e86cfdcc9c96aea71d57cc3ae9d7fee408efb7cf69-image.png" />

> 🚧 Push display mode requires a navigation bar in the parent view
>
> The **Display mode** `Push` only works if the parent view already contains a navigation bar. 
>
> If you try to display a Screen/Flow associated with the `Push` display mode from a parent view which doesn't have a navigation bar associated, the display() method will fallback on the default display mode:
>
> * Modal on iOS
> * Full Screen on Android

<br />

## Display modes available

Here are how the different display modes available

<Image align="center" className="border" border={true} src="https://files.readme.io/4a3d4c0e5e7ea20876ed959f203e623858cd7e12ac9de95c8c9c6556382ee770-types.gif" />

> ❗️ The configured display mode does not reflect in the preview of the Console
>
> This means that it will not reflect in the Console if you change it.
>
> This will require a bit more work and we hope to make it available soon... Stay tuned!

<br />

## Flow display mode VS transition type

> 📘 Difference between the Flow display mode and the transition type between Screens within a Flow
>
> When configuring a Flow, it’s important to distinguish between the **Flow Display Mode** and the Transition Type. Each plays a distinct role in how screens appear within your app.
>
> ### Flow Display Mode
>
> The **Display Mode** determines how the first Screen of the Flow is presented within the app.
>
> It defines the integration behavior between the Flow and the parent view managed by your app—such as whether the Flow is shown as a modal, fullscreen, embedded view, etc.
>
> This setting is configured at the Flow level and applies only to how the Flow starts.
>
> ### Screen Transition Type
>
> The Transition Type defines how navigation occurs between Screens within the Flow.
>
> It controls the animation or visual behavior when moving from one Screen to the next (e.g., slide, fade, instant).
>
> You can configure a default Transition Type at the Flow level, and optionally override it for individual Transitions to customize specific paths in the user journey.
>
> <Image align="center" className="border" border={true} src="https://files.readme.io/5709953934e193f8100d1672d0dad747b394de8cfeaa430b8d02a369552c3751-image.png" />

<br />

## Mapping a Flow with a Placement

Once created, Flows can be associated with a [Placement](placement)

<Image align="center" className="border" border={true} src="https://files.readme.io/80c311eb197b69a6471f9db09ff67c3d6a67f844aac17ca9cf5efbd719c96ace-placement.gif" />

## Associating a Flow with a Campaign

The **[Campaigns](campaigns)** feature lets you create powerful no-code automations that will display a Purchasely Screen for a particular Audience at the App start.

Flows can be associated with Campaigns to combine both feature: the ability to display a customizable sequence of Screen following the app start.

This integration will automatically take the Display mode into consideration.

<Image align="center" className="border" border={true} src="https://files.readme.io/3d1054aaeb42eeccbd0280f3588472d600b0f5bf02d12c3e117a8b0a0afbeabf-image.png" />

## Running an A/B Test between 2 Flows

This capability is only opened to customers benefitting from the Flows Premium feature.

You can configure an A/B Test between 2 Flows or 1 Flow vs a single Screen.

<Image align="center" className="border" border={true} src="https://files.readme.io/9cf94e6d276d58c496fbb73761ae42bfa78d8ca448380a91aedb37967358265e-image.png" />
