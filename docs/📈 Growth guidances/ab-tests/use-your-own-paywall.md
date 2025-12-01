---
title: Bring Your Own Paywall
excerpt: How to use your own paywall within Purchasely environment.
deprecated: false
hidden: false
metadata:
  title: ''
  description: >-
    This document provides information on how to set up and implement your own
    custom paywall in a No Code environment using Purchasely, allowing for A/A
    testing and price A/B testing infrastructure deployment without changing
    your UI.
  robots: index
next:
  description: >-
    Want to know more on how to leverage this feature to personalize remotely
    your own paywall?
  pages:
    - type: basic
      slug: remote-config-your-own-screen
      title: Remotely configure your own screens
---
It might seem odd to bring your own paywall in a no-code environment, but it can actually be very useful when you start implementing Purchasely for:

1. **Running an A/B test between your existing paywall and a Purchasely paywall**
   The platform feature Bring Your Own Screen allows you to include your legacy paywall as a variant in a Purchasely experiment without rebuilding it in the Console.

   <Image align="center" border={true} src="https://files.readme.io/78b8f6f704524eab24b3da03b1cf51d0287b2cddc4f2cc68827446cc7cee68a8-image.png" className="border" />

   <br />
2. **Running an A/A test between your existing paywall and its Purchasely version**
   If you reimplemented your paywall using Purchasely’s Screen Composer, the feature Bring Your Own Screen  lets you compare both versions under identical conditions to validate performance and consistency.

   <Image align="center" border={true} src="https://files.readme.io/e27a0f750c017820086008b95bad8f43daebe81773289cf3d5420fbacc1aa9e9-image.png" className="border" />

   <br />

<br />

<br />

> 🚧 SDK v5.6.0+ mandatory
>
> To  SDK v5.6 ([changelog](/changelog/56)) or later and the use of the `display()` method to show In-App Experiences.

<br />

# Useful links

To configure Bring Your Own Screen, follow the guide:

📚 [Configuring BYOS in the Purchasely Console](byos-configuration)

To implement it in your app, follow the guide:

📚 [Implementing BYOS into the app](byos-implementation)

<br />
