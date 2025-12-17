---
title: Purchasely SDK — Debug Mode
excerpt: >-
  Preview, test, and validate in-app experiences directly inside your app before
  rolling them out to users.
deprecated: false
hidden: false
metadata:
  robots: index
---
Purchasely Debug Mode allows you to preview the In-App Experiences crafted in the Console exactly as users will see them — on a real device, in multiple languages, with different themes, and under different eligibility conditions. It lets you validate your Screens and Flows safely, without exposing them to your real users.

# ✨ What Debug Mode Enables

With Debug Mode activated on a device, you can:

* Preview any In-App Experience created in the Purchasely Console (Paywalls, Screens, Flows…): the draft version is visible
* Simulate how an In-App Experience integrates with any Placement - by targeting the `Internal Testers` Audience and giving it the highest priority - before making it visible to real users.

Debug Mode only affects the device on which it is activated.

It has zero impact on your production Audiences or Paywall exposure.

<br />

# Enabling Debug Mode

1. **Open the preview QR code of any Screen the Purchasely Console**

   When editing a Screen, the Console shows a Preview QR Code.

   <br />

   <Image border={false} src="https://files.readme.io/76a2a89a2ce6c57ff1cd7cbeacbfb991b3f2440baba8c5832b6a52d3b9f319a0-image.png" />

     

   This QR code contains all the metadata needed for your device to load the preview.    

   <br />

   > ⚠️ Deeplink management required
   >
   > To make the Preview work, you must have implemented [Deeplinks management](deeplinks-management).

<br />

2. **Scan the QR code with your test device**

   Open your camera on the device that runs your app with the Purchasely SDK integrated.

   After scanning:
   * Your device will open the app and prompt the Purchasely SDK to display the Screen
   * A Purchasely Floating Debug Button appears on  top of your app UI in the bottom right corner.

<Image align="center" border={true} width="300px" src="https://files.readme.io/2385df1fadfdf69ac652e2ebc77bce30ac5b031412d698c98ec8fe0dcefb66a1-image.png" className="border" />

<br />

3. **Open the Floating Debug Button**

   Tap the floating button to open the Debug Panel.

   The Debug Panel shows contextual information about:
   * The SDK version installed on the device
   * User ID and User Anonymous ID
   * Current Screen information and associated meta data (Placement, Flow, Campaign, Audience, A/B test, A/B test variant etc...)

<Image align="center" border={true} width="300px" src="https://files.readme.io/d0861b64a1ac24266cf22d8b00e644ae80e237876a13e36f6b60964aa16557e9-Screenshot_20251127-183959.png" className="border" />

4. **Activate Debug Mode**

   From the Debug Panel, you can Enable Debug Mode by activating the switch.

   Once activated:
   * Your device enters the Internal Testers audience (Built-in User attribute `debug mode` = `true`)
   * You can now close the Debug Panel and Screen displayed and browse your application
   <br />
5. **Target In-App Experiences to `Internal Testers`**

   In the Console, you can map an In-App Experience with the Audience `Internal Testers` and any Placement.

   <br />

   <Image align="center" border={false} width="400px" src="https://files.readme.io/b77fe7976ba3df286a6acd24986608f54d75f519fa8dd16e7c63523ab7f08d75-image.png" />

   Put that Audience in first position (with the highest priority) to make sure that test devices will not match another condition with a higher priority.

<br />

6. **Navigate in your app or use the Placement deeplink**

   When you'll hit a Placement, your device with the debug mode activated will match the Audience `Internal Testers` and you will be able to see the corresponding Screen / Paywall (in the draft version). 

<br />

# How Debug Mode Works

The Audience `Internal Testers` leverages the Built-in User attribute `debug mode`. 

When you activate the Debug Mode by scanning a QR code from the Console, this set the value `debug mode` = `true` for this device.

<Image align="center" border={false} width="400px" src="https://files.readme.io/7782f09e7c19b44fd6c37cbf679695e7ed5afbf4bb8dc73b77d9881f2ca133d1-image.png" />

Your real users do not match this Audience and In-App Experiences targeted to the `Internal Testers` Audience are shown only to devices with the Debug Mode activated.

This Audience can be used as a targeting condition for any:

* Placement
* Campaign
* A/B test

<br />

When Debug Mode is deactivated from the Debug Panel, the device is immediately removed from this audience (by setting the Built-in User Attribute `debug mode` to `false`)

This makes it safe to test any new experience - even incomplete ones - without risking exposure to actual users.

<br />
