---
title: SDK Placement
excerpt: ''
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# What is a Placement?

A Placement represents a specific location in your user journey inside your app (e.g. Onboarding, Settings, Home page, Article). 

* A Placement can be created in the corresponding section of the Console
* Then you can define the paywall associated to the placement (none, one paywall or several paywalls for several audiences)
* A single paywall can be used for different Placements. 

You can create as many Placements as you want in the section Placements of the Console

# How to display a Placement?

Placements can be displayed in 2 different ways:

* By calling them directly in the app code
* By using the associated deeplink

# When should I call the Placement from the app code?

Placements that match a precise location in the app (e.g.: Onboarding, Home page, Settings) can be integrated directly to the code of the app.

The main inconvenience with this method is that this work can only be done by the developers and adding a new placement requires an update of the app.

A Placement can be deactivated from the Console by associating it with no screen.

# When should I use the Placement deeplink?

Purchasely supports the use of deeplinks to trigger the display of a Placement through a deeplink. 

This method is particularly convenient to create automations with mCRM / Engagement / push notification platforms. The deeplink can be associated to a Push notification, an In-App Message or an email. 

When the app is opened through a Placement deeplink, the Purchasely SDK will automatically open the requested placement and display the associated paywall or screen to the user.

<FirstScreenDisplay />

# What is paywall pre-fetching and when to use it?

Paywall pre-fetching is a mechanism offered by the Purchasely SDK to load paywall asynchronously before displaying it. 

The benefits of using the pre-fetching are the following:

* Display the paywall only after it has been loaded from the network
* Handle network errors gracefully
* Show a custom loading screen
* Pre-load the paywall while users navigate through your app, such as during onboarding screens
* [Deactivate a Placement](https://purchasely.readme.io/docs/disable-placements) (possibly for a particular Audience) by associating no paywall or screen with it
* [Display **Your Own Paywall**](https://purchasely.readme.io/docs/use-your-own-paywall)\*\*\*\*

More information [on pre-fetching available here](https://docs.purchasely.com/advanced-features/asynchronous-paywalls)
