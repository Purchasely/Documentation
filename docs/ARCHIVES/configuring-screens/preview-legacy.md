---
title: Preview
excerpt: >-
  This page describes different menu options available in the Purchasely Screen
  preview section
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Learn how to leverage your Screen with countdown and timers
  pages:
    - type: basic
      slug: timer-countdown
      title: Countdown paywalls and timers
---
The Purchasely Screen preview section has many menu items that are useful for customizing and visualizing the Screen effectively based on the device type, orientation, location and etc. 

Here’s an overview of common menu items you might find in this section and how they can be useful for your Screen visualization:

> 🚧 Please note:
>
> While building a Screen, you will use tags to define price, duration and offer price.\
> At times, you might see the price displayed as **$X,XX** in the Screen preview instead of the real price. 
>
> The stores don't offer API that we could use to get the prices applied for a product in every country. When previewing your paywall in the SDK, you will see that the pricing is correctly displayed, so no worries!

### Territory-Store Dropdown list

Here is a list of countries and app stores where your app is distributed. The pricing can vary from one territory to another. As soon as a transaction has been processed in a specific store and territory, you will be able to preview the price in that territory.

<Image align="center" className="border" border={true} src="https://files.readme.io/d322995-image.png" />

### Show trial

This toggle button allows you to preview the texts and pricing seen by users eligible for the introductory offer or the winback offer.

<Image align="center" className="border" border={true} src="https://files.readme.io/285d56e-Screen_Recording_2024-06-18_at_15.24.34.gif" />

### Orientation

By switching to different orientation, you can preview how does the screen looks in Landscape and Portrait mode. 

<Image align="center" className="border" border={true} src="https://files.readme.io/82d5ff7-image.png" />

### Preview device selection menu

you can preview the paywall display on a wide range of device types including Mobile, Tablet devices, and TV. Please note that the device preview is just for a visual representation, its not the exact replica of how it looks in the actual device. 

<Image align="center" className="border" border={true} src="https://files.readme.io/05a954f-image.png" />

### Roll-back

When you click on the Roll-back, all the changes made to the presentation since its last publication will be discarded. 

<Image align="center" className="border" border={true} src="https://files.readme.io/055037c-image.png" />

### Save Draft

To save all the changes you have made to your Paywall before publishing it to live.

<Image align="center" className="border" border={true} src="https://files.readme.io/c3b2dbe-image.png" />

### Publish

When you publish a paywall, it's ready to go live.

<Image align="center" className="border" border={true} src="https://files.readme.io/73118f8-image.png" />

### Preview

This menu contains a QR code or deep link to view the Paywall in a device as you customize .This  feature is super handy to preview a paywall to see how the assets and copy looks like on a real devices.

<Image align="center" className="border" border={true} src="https://files.readme.io/c6bd89a-image.png" />

<br />

Minimal setup required to generate this preview are:  

1. Ensure you are using native SDK version `3.3.0` or above, version `2.3.0` or above for Flutter, React Native, and Cordova, and version `4.1.0` for Unity.
2. Define the app scheme of your app ([iOS](https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app), [Android](https://developer.android.com/training/app-links/deep-linking)) into your app
3. [Follow the guide to enable deeplinks management into your App](deeplinks-management)

> 🚧 **How to make it work for Android ?**
>
> On some devices, deeplinks like myapp\:// are not opened by the camera, this is a limitation from Google.\
> Instead you can use [App Links](https://developer.android.com/training/app-links) like [https://myapp.com/](https://myapp.com/) as the scheme for your application.\
> Purchasely will then use a link in this format: [https://myapp.com/ply/presentations\_preview/MY\_PAYWALL\_ID](https://myapp.com/ply/presentations_preview/MY_PAYWALL_ID) embedded in the QR Code that should work on your device if you have followed [Android documentation](https://support.google.com/android/search?q=open+by+default)
