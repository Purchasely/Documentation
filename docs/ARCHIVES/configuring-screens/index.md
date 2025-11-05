---
title: Configuring Screens with the Screen & Paywall Builder (legacy)
excerpt: >-
  This section provides everything you need to know to configure a Screen using
  the Purchasely legacy Screen Builder
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Let's start with the Template System used in the Purchasely Screen Builder
  pages:
    - type: basic
      slug: template-system
      title: Template system
---
> ❗️ The Purchasely Legacy Screen Builder will be deprecated from Feb 1st 2025 onwards
>
> From this date onwards, customers are invited to use the [Screen Composer](screen-composer) to build their Screen in no-code.

# General overview

**Purchasely Screen & Paywall Builder** relies on a system of Template. It manages Paywalls (i.e.: Screens in which the Call-to-Actions are mapped with the trigger of the purchase of a Plan) but can also be used to create other type of Screens (e.g.: for onboarding or specific activation flows), by remapping the CTAs to other types of action.

The general process when creating a new Screen is the following:

1. Choose a Template - a **Template** is composed of a Screen layout and a set of configurable components
2. Integrate your copy, contents and branding (including custom fonts) in both Light mode & Dark mode
3. Configure your buttons / Call to Action
   * map them with the appropriate Action type
   * use the system of `TAGS` to display prices dynamically
4. Configure the Screen in the different locales you want to support
5. Visualize the preview of your screen on your device, inside your app
6. Publish the Screen

The Screen can then be displayed by the app [be displayed using different methods](displaying-screens).

<br />

# Table of contents

The following sections provide you all the details you need to know regarding the features available in the **Screen Builder**:

* [Template system](template-system) presents the different components available in the [various templates (supports more than 60)](template-gallery)
* [Tags](tags) presents how `TAGS` work and the list of all the tags available with concrete display examples for each tag
* [Regular labels VS Offer labels](labels-regular-price-vs-offer-prices) explains how to define specific labels for buttons and pickers depending on the User eligibility to an Offer
* [Action types for buttons](action-types) explores the different types of actions that you can associate to buttons & pickers and how to leverage them to build Screens (and not only Paywalls) and link them together
* [Close button](close-button) gives you details on how to configure the behavior and look of the Close Button of your Screens
* [Adapting Screens to devices](adapting-screens-to-devices) explains how to override images and media for specific devices
* [Custom fonts](custom-fonts) details how to integrate your custom fonts into your Screens
* [Localization](localization) explains how to localize your Screens
* [Dark Mode ](dark-mode)tells you everything you need to know about the Dark Mode
* [Videos in Screens & Paywalls](videos) gives you the process to follow to integrate videos into your Screens
* [Lottie animations](lottie-animations) gives you the process to follow to integrate Lottie animations into your Screens
* [Preview](preview) gives details on how to visualize the Preview of your Screen
* [Countdown paywalls and timers](timer-countdown) explores the possibilities offered by dynamic countdowns and countdown Paywalls to create a sentiment of urgency to your Users and increase conversion.

<br />

Have fun!
