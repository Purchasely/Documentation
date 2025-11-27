---
title: '# Purchasely SDK — Debug Mode'
excerpt: >-
  Preview, test, and validate in-app experiences directly inside your app before
  rolling them out to users.
deprecated: false
hidden: false
metadata:
  robots: index
---
Purchasely Debug Mode allows product, design, and marketing teams to preview their in-app experiences exactly as users will see them—on a real device, in multiple languages, with different themes, and under different eligibility conditions. It lets you validate your screens and funnels safely, without exposing them to your live audience.

# ✨ What Debug Mode Enables

With Debug Mode activated on a device, you can:

* Preview any in-app experience created in the Purchasely Console (paywalls, screens, flows…)
* Test localization: switch between all available languages.
* Test appearance: toggle between Light Mode and Dark Mode.
* Test introductory offer eligibility: simulate eligible or non-eligible users.
* Preview unpublished or restricted screens using the Internal Testers audience.
* Safely validate flows before enabling them for real users.

Debug Mode only affects the device on which it is activated.
It has zero impact on your production audiences, analytics, or paywall exposure.

# 🔧 How Debug Mode Works

When a device activates Debug Mode:

1. The device is automatically added to a special Internal Testers audience. This audience can be used as a targeting condition for any:
   * Placement
   * Campaign
2. Experiences targeted to the Internal Testers audience are shown only to those devices.
3. When Debug Mode is deactivated, the device is immediately removed from this audience.

This makes it safe to test any new experience—even incomplete ones—without risking exposure to actual users.

# ✅ Enabling Debug Mode

1. **Open the preview QR code in the Purchasely Console**

   When editing an Experience, Flow, or Paywall, the Console shows a Preview QR Code.
   This QR code contains all the metadata needed for your device to load the preview.
2. **Scan the QR code with your test device**

   Open your camera or QR-capable app on the device that runs your app with the Purchasely SDK integrated.

   After scanning:
   * Your device will prompt the Purchasely SDK.
   * A Purchasely Floating Debug Button appears on top of your app UI.
3. **Open the Floating Debug Button**

   Tap the floating button to open the Debug Panel.

   The Debug Panel shows contextual information about:
   * The current screen
   * Placement and Experience metadata
   * Eligibility status
   * Language and theme settings
4. **Activate Debug Mode**

   From the Debug Panel, toggle Enable Debug Mode.

   Once activated:
   * Your device enters the Internal Testers audience.
   * You can now test screens that are:
     * Not yet published
     * Targeted to Internal Testers only
     * As part of a staging workflow

<br />
