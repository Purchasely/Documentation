---
title: Bring Your Own Screen
excerpt: >-
  This page explains the different use cases for Bring Your Own Screen and when
  it should be used.
deprecated: false
hidden: false
metadata:
  robots: index
next:
  description: Configure your first Custom
---
**Bring Your Own Screen** (BYOS) lets you embed your own native screens directly inside Purchasely Flows. It extends the no-code experience by allowing you to add custom steps — such as sign-in, sign-up, forms with text fields, or any screen integrating highly specific UI components that cannot be built with the Screen Composer.

# When to Use BYOS

Bring Your Own Screen is useful whenever you want to combine the flexibility of your native screens with the orchestration and analytics of Purchasely Flows.

You should use BYOS in the following situations:

1. **Integrating a Custom Screen inside a Purchasely Flow**
   When you need a step that cannot be built with the Screen Composer — such as authentication, forms, or screens with complex logic — BYOS lets you plug your native screen directly into the Flow.

   <Image align="center" border={true} caption="BYOS let you integrate your native sign-in process into a Flow" src="https://files.readme.io/36f0aa40539778160a7ec230511f25c7a69c6b491a7414e968a89af8d523b780-image.png" />

   <br />
2. **Running an A/B test between your existing paywall and a Purchasely paywall**
   BYOS allows you to include your legacy paywall as a variant in a Purchasely experiment without rebuilding it in the Console.

   <Image align="center" border={true} src="https://files.readme.io/78b8f6f704524eab24b3da03b1cf51d0287b2cddc4f2cc68827446cc7cee68a8-image.png" className="border" />

   <br />
3. **Running an A/A test between your existing paywall and its Purchasely version**
   If you reimplemented your paywall using Purchasely’s Screen Composer, BYOS lets you compare both versions under identical conditions to validate performance and consistency.

   <Image align="center" border={true} src="https://files.readme.io/eb624073adbc49da047d8943136efa597ec9b8bd3274071e7aaad9d8ecf1b70b-image.png" className="border" />

   <br />
4. **Reordering steps in your existing onboarding flow without code**
   BYOS allows you to orchestrate the sequence of your native onboarding screens around Purchasely screens — letting you reorder, insert, or remove steps entirely in no-code.

   <Image border={false} src="https://files.readme.io/b388730187059df321f7fff1f9a91622d56b727146e333ac0cf614a0110d1a8b-image.png" />

   <br />

> 🚧 SDK v5.6.0+ mandatory
>
> BYOS requires SDK v5.6 or later and the use of the `display()` method to show In-App Experiences.
>
> It is currently available for **native Swift and Kotlin apps** and will be extended to React Native, Flutter, and Cordova in a future release.

# Useful links

To configure Bring Your Own Screen, follow the guide

📚 [Configuring BYOS in the Purchasely Console](byos-configuration)

To implement it in your app, follow the guide

📚 [Implementing BYOS into the app](byos-implementation)
