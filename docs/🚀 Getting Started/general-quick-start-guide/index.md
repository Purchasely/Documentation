---
title: Quick start Guide for all apps
excerpt: >-
  In this section you will find the details to implement the Purchasely SDK into
  your app
deprecated: false
hidden: false
metadata:
  robots: index
next:
  description: Direct access to the different steps
  pages:
    - slug: general-sdk-installation
      title: SDK installation
      type: basic
    - slug: general-sdk-initialization
      title: SDK initialization
      type: basic
    - slug: general-deeplinks
      title: Deeplinks management
      type: basic
    - slug: general-in-app-experiences-display
      title: In-App Experiences display
      type: basic
    - slug: general-user-identification
      title: User identification
      type: basic
    - slug: general-custom-user-attributes-integration
      title: Custom User Attributes Implementation
      type: basic
    - slug: analytics-integration
      title: Analytics Integration
      type: basic
---
# Technologies available for the SDK

The Purchasely SDK is developed natively on the following platforms:

* iOS - Swift (minimum version {user.sdk_ios_minimum_version})
* Android - Kotlin (minimum version {user.sdk_android_minimum_version})

For hybrid apps, our <Glossary>bridge sdk</Glossary>s are available for:

* React Native
* Flutter
* Cordova

# Current version per platform

| Platform         | SDK Version                    |
| :--------------- | :----------------------------- |
| **iOS**          | {user.current_ios_version}     |
| **Android**      | {user.current_android_version} |
| **Flutter**      | {user.current_flutter_version} |
| **React Native** | {user.current_rn_version}      |
| **Cordova**      | {user.current_cordova_version} |

# Implementation process

Follow these steps to implement the SDK into your app:

1. [Install the SDK](sdk-installation) by importing it into your app project
2. [Initialize the SDK](sdk-initialization) when the app starts
3. [Manage deeplinks](deeplinks-management) to enable no-code automations
4. [Display your first In-App Experience](general-in-app-experiences-display)
5. [Identify users upon sign-in / sign-up](general-user-identification)
6. [Implement Custom User Attributes](general-custom-user-attributes-implementation) letting you segment your user base
7. [Integrate Purchasely Analytics](analytics-integraton)

<br />

The overall process takes a mobile developer between a few hours to a day of work for a straightforward implementation. This time can vary depending on the complexity of your app code and the advanced features of the Purchasely SDK you want to implement.

# Testing

Once you've finished implementing Purchasely into your app, follow our [checking list](sdk-integration-checking) to test your implementation.
