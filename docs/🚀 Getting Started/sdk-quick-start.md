---
title: Quick start
excerpt: >-
  In this section you will find the details to implement the Purchasely SDK into
  your app
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Direct access to the different steps
  pages:
    - type: basic
      slug: sdk-installation
      title: SDK installation
    - type: basic
      slug: sdk-initialization
      title: SDK initialization
    - type: basic
      slug: running-modes
      title: Running modes
    - type: basic
      slug: sdk_deeplinks
      title: SDK Deeplinks
    - type: basic
      slug: screens-display
      title: Screens display
    - type: basic
      slug: processing-transactions
      title: Transactions processing
    - type: basic
      slug: entitlements-management
      title: Entitlements management
    - type: basic
      slug: testing
      title: Testing
---
# Technologies available for the SDK

The Purchasely SDK is developed natively on the following platforms:

* iOS - Swift (minimum version {user.sdk_ios_minimum_version})
* Android - Kotlin (minimum version {user.sdk_android_minimum_version})

For hybrid apps, our <Glossary>bridge sdk</Glossary>s are available for:

* React Native
* Flutter
* Unity
* Cordova

# Current version per platform

<Table align={["left","left"]}>
  <thead>
    <tr>
      <th>
        Platform
      </th>

      <th>
        SDK Version
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        **iOS**
      </td>

      <td>
        {user.current_ios_version}
      </td>
    </tr>

    <tr>
      <td>
        **Android**
      </td>

      <td>
        {user.current_android_version}
      </td>
    </tr>

    <tr>
      <td>
        **Flutter**
      </td>

      <td>
        {user.current_flutter_version}
      </td>
    </tr>

    <tr>
      <td>
        **React Native**
      </td>

      <td>
        {user.current_rn_version}
      </td>
    </tr>

    <tr>
      <td>
        **Cordova**
      </td>

      <td>
        {user.current_cordova_version}
      </td>
    </tr>

    <tr>
      <td>
        **Unity**
      </td>

      <td>
        {user.current_unity_version}
      </td>
    </tr>
  </tbody>
</Table>

# Implementation process

Follow these steps to implement the SDK into your app:

1. [Install the SDK](sdk-installation) by importing it into your app project
2. [Choose your running mode](running-modes) that suits your needs
3. [Initialize the SDK](sdk-initialization) when the app starts
4. [Manage deeplinks](deeplinks-management) to enable no-code automations
5. [Display your first Screen or Paywall](screens-display)
6. [Process transaction](processing-transactions) when a user makes a purchase
7. [Manage entitlements](entitlements-management) to enable users to access the premium benefits of their purchases
8. [Listeners / delegates for UI / SDK Events and Custom User Attributes](listener-delegate) to gain real-time insights on user's interactions with Purchasely Screens and personalize the user experience (optional but recommended)

<br />

The overall process takes a mobile developer between a few hours to a day of work for a straightforward implementation. This time can vary depending on the complexity of your app code and the advanced features of the Purchasely SDK you want to implement.

# Testing

Once you've finished implementing Purchasely into your app, follow our [checking list](sdk-integration-checking) to test your implementation.
