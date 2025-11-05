---
title: Preview
excerpt: >-
  This page describes different menu options available in the Purchasely Screen
  preview section
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
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

<Image align="center" className="border" border={true} src="https://files.readme.io/c60c4e34294db1fa043beb923abbeb4ef0c7b415a2c4cae743b2c0acb6d2b2f5-Previews.gif" />

### Show trial

This toggle button allows you to preview the texts and pricing seen by users eligible for the introductory offer or the winback offer.

<Image align="center" className="border" border={true} src="https://files.readme.io/ebebc4cbcf4f4e88d59db40e2e359043853d190d33af7c23f784827b3d17e3a4-trials.gif" />

### Orientation

By switching to different orientation, you can preview how does the screen looks in Landscape and Portrait mode. 

<Image align="center" className="border" border={true} src="https://files.readme.io/9808488279253c791b1abe2f54fb9653362f62f8b9d8b17d4dffa325444cfd19-image.png" />

### Preview device selection menu

You can preview the paywall display on a wide range of device types including Mobile, Tablet devices, and TV. Please note that the device preview is just for a visual representation, its not the exact replica of how it looks in the actual device. 

> 👍 Warning
>
> There might be small discrepancies between the web preview and the way the paywall is rendered on the device, as it’s 3 core different technologies (HTML / Swift / Kotlin) that rely each on their specific constraints engines.
>
> We strongly encourage to verify your screens on device using the mobile preview before publishing it. Only this can ensure that the screen will be perfectly rendered.

<Image align="center" className="border" border={true} src="https://files.readme.io/1a94f3f98de7faa14fea93a72aefe6d1657e0a812128e782c32e8a5bda3ad67e-image.png" />

> 📘 Seeing prices displayed as $X,XX in the console preview instead of the real price ?
>
> We are using data sent alongside previous transactions. So we need to have a transaction performed in the selected country to display a price.
>
> As soon as the first transactions are processed or observed for this particular product, the X.XX will be replaced by the pricing observed for this product. You will see the correct price in the deivce instead of X.XX
>
> Note that the pricing can be different from one territory to the other. As soon as a transaction has been processed in a specific store & territory, you will be able to preview the price in this territory.

<br />

### Roll-back

When you click on the Roll-back, all the changes made to the presentation since its last publication will be discarded.

<Image align="center" className="border" border={true} src="https://files.readme.io/692c31a2ff6a9c1f1f5d1167402f57923e435cce82c85c58eff883e4559f1c84-image.png" />

### Save Draft

To save all the changes you have made to your Paywall before publishing it to live.

<Image align="center" className="border" border={true} src="https://files.readme.io/797f0b28817a54831c3aaf2adb92d2d1e9c0afd8581e33449e0416396272f7a5-image.png" />

### Publish

When you publish a paywall, it's ready to go live.

<Image align="center" className="border" border={true} src="https://files.readme.io/373893a14ffaf502406fec541c8d8257d603cec3956ffbd9bfaa90965f73acfd-image.png" />

## Preview on the devices

This menu contains a QR code or deep link to view the Paywall in a device as you customize .This  feature is super handy to preview a paywall to see how the assets and copy looks like on a real devices.

It allows you to visualize the draft version of the screen (not the published one) and that buttons are not active in the preview, hence you can't make a purchase from paywall rendered using this preview.

<Image align="center" className="border" border={true} src="https://files.readme.io/746a5fcbbdb5ef9d09bc33f6803113a373901f343feaf5c2dd44ea8bc0268b18-image.png" />

Minimal setup required to generate this preview are:  

1. Ensure you are using native SDK version `3.3.0` or above, version `2.3.0` or above for Flutter, React Native, and Cordova, and version `4.1.0` for Unity.
2. Define the app scheme of your app ([iOS](https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app), [Android](https://developer.android.com/training/app-links/deep-linking)) into your app
3. [Follow the guide to enable deeplinks management into your App](deeplinks-management)

> 🚧 **How to make it work for Android ?**
>
> On some devices, deeplinks like myapp\:// are not opened by the camera, this is a limitation from Google.\
> Instead you can use [App Links](https://developer.android.com/training/app-links) like [https://myapp.com/](https://myapp.com/) as the scheme for your application.\
> Purchasely will then use a link in this format: [https://myapp.com/ply/presentations\_preview/MY\_PAYWALL\_ID](https://myapp.com/ply/presentations_preview/MY_PAYWALL_ID) embedded in the QR Code that should work on your device if you have followed [Android documentation](https://support.google.com/android/search?q=open+by+default)
