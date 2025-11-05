---
title: Activating the Safe area
excerpt: >-
  This page describes about the safe area in Purchasely screen composer, how to
  use it, do's and don'ts.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
## About

Safe areas in the Purchasely Screen Composer layout are designed to ensure that screen content is rendered within the safe area boundaries of a device.

Although the Screen Composer includes a preview section, enabling safe areas within your screens helps you achieve the most accurate rendering on real devices. 

***

## Where to find this feature ?

You can find **Add safe area on top** and **Add safe area at the bottom** at the Layout level of the Screen Composer. This option is available for all layouts provided in the Screen Composer.

<Image align="center" className="border" border={true} src="https://files.readme.io/ea0cb182a038f413edceddac8bdaba29439544a81320c8534ff800b04f1783c6-ScreenRecording2025-10-15at16.28.30-ezgif.com-video-to-gif-converter.gif" />

***

### Prerequisite:

Requires SDK version 5.4.0 or above.

You can find the SDK 5.4 changelog [here](https://docs.purchasely.com/changelog/54).

***

### How to use this feature ?

This feature works based on the screen display mode you have set. You can apply both top and bottom safe areas simultaneously on the same screen.

Purchasely has [5 display modes](https://docs.purchasely.com/docs/display-mode): Full, Push, Modal, Drawer and Pop-in.

<Image align="center" className="border" border={true} src="https://files.readme.io/e195f76fb7f7298280712f5d0abb0d40ca5677d72d33e8059180ebf02d4b99de-ScreenRecording2025-10-15at17.30.56-ezgif.com-video-to-gif-converter.gif" />

***

### Add safe area on top:

Applies a margin at the top of the screen to prevent unwanted cropping of images or text in the header area — for example, due to the notch on iOS devices.

This top safe area is applied only when the screen display mode is set to **Full** or **Push**.

***

### Add safe area at the bottom:

Applies a margin at the bottom of the screen to ensure that elements such as footers or terms & conditions are not cropped by the system navigation bar (e.g., on Android devices).

This bottom safe area is applied when the display mode is set to any mode **except Pop-in**. 

<Image align="center" className="border" width="700px" border={true} src="https://files.readme.io/b80ac5996e8acb4facb51b08964355788303b05b728eb8a33cef62161108581b-image.png" />

<br />

***

<br />

### Examples

Here are screenshots of screen rendered before and after applying safe areas on top is applied in full mode. 

<Image align="center" src="https://files.readme.io/cc2ba734b6d764656088cf7c6aa30ebc3c33b2c9a514bbc3c8a80beede9513cd-Docs_prep-3.jpg" />

<br />

### Safe areas and close / back buttons:

The Safe area of the [Close](close-button) and Back buttons always take the safe area into consideration even if you haven't activated it.

If you need to align horizontally a Screen component (such as a progress bar image for instance) with a back button or a Close button, you should activate the safe area on top, and fine-tune the top margin of the Screen first component to align (e.g.: add 20px of top margin to the first component of the Screen)

<Image align="center" className="border" border={true} src="https://files.readme.io/f45e8e846297fe6af5a7eaffb35821ccbc06aa3d5c42ee9d4d4a5d7f5f2d9d84-image.png" />

<br />

### Safe areas and background image / background color

The background image (or video) and background color of the Screen (set at the level of the layout or the body) are **not affected** by the safe area. This means that if you want the Screen to cover the device edge to edge, you should configure the image either as the background image or define a background color.
