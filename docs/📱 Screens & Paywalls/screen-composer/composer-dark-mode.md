---
title: Dark Mode
excerpt: >-
  This pages describes how to custoimize your paywall in dark mode Automatically
  used by Purchasely if configured
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Purchasely automatically adapts to the device theme, displaying presentations in either light or dark mode based on the user’s settings. If you've configured a [dark mode](https://help.purchasely.io/en/articles/8656909-dark-mode-feature) in Purchasely console, it will be utilized when the user's device is in dark mode. Otherwise, Purchasely defaults to light mode.

# Manually set your preferred mode

Override the default behavior by setting the mode manually.\
This is particularly useful if your application allows users to change its theme.

Theme Modes:

* Light
* Dark
* System (Default)

```swift Swift
// force dark mode for all Purchasely screens
Purchasely.setThemeMode(.dark) 

// use device theme to set automatically in dark or light mode
Purchasely.setThemeMode(.system) 
```
```coffeescript Kotlin
// force dark mode for all Purchasely screens
Purchasely.setThemeMode(PLYThemeMode.DARK)

// use device theme to set automatically in dark or light mode
Purchasely.setThemeMode(PLYThemeMode.SYSTEM)
```
```typescript React Native
// force dark mode for all Purchasely screens
Purchasely.setThemeMode(PLYThemeMode.DARK);

// use device theme to set automatically in dark or light mode
Purchasely.setThemeMode(PLYThemeMode.SYSTEM);
```
```coffeescript Flutter
// force dark mode for all Purchasely screens
Purchasely.setThemeMode(PLYThemeMode.dark);

// use device theme to set automatically in dark or light mode
Purchasely.setThemeMode(PLYThemeMode.system);
```
```csharp Unity
// force dark mode for all Purchasely screens
Purchasely.setThemeMode(Purchasely.ThemeMode.dark);

// use device theme to set automatically in dark or light mode
Purchasely.setThemeMode(Purchasely.ThemeMode.light);

```
```javascript Cordova
// force dark mode for all Purchasely screens
Purchasely.setThemeMode(Purchasely.ThemeMode.dark);

// use device theme to set automatically in dark or light mode
Purchasely.setThemeMode(Purchasely.ThemeMode.light);
```

<br />

## Dark mode feature in the Purchasely console

This feature allows you to create a paywall with 2 color sets, one for light mode and the other one for dark mode. Simply choose your assets, font colors, background color and so on for each mode. Our SDK will automatically display the appropriate paywall version based on the user's device settings, streamlining your workflow and reducing repetitive tasks.

### Dark mode feature in action

ℹ️ Prerequisite: SDK version 4.2.0, paywall customized in light and dark mode

When creating a new paywall, you'll need to design it as usual for the light mode, and also create a version for dark mode. All settings in the Paywall configuration will apply to the light mode.

<Image align="center" className="border" border={true} src="https://files.readme.io/0f44b56-darkmode.gif" />

### Paywall in Dark mode

After customizing the regular (light mode) version of your paywall, activate the dark mode by enabling the corresponding switch in the Screen composer

<Image align="center" className="border" border={true} src="https://files.readme.io/24c68e4b6819132811de752239ffa0439e16f519d722856eb4a50764c6fa1082-ezgif-3-edd0652856.gif" />

In dark mode, you can override the following things:

1. Background color, border color, Text color
2. Image and video
3. Close button color, carousel knot color

You just have to go through your different color / background / border / images and video and change them. 

<br />

> 🚧 Check the rendering in dark mode
>
> All colors and assets (images / video) are overridden by in black mode by default
>
> Before publishing your Screen, do not forget to check the rendering in Dark mode too because every component is by default associated with 2 different sets of colors. 
>
> The same rule for the images, videos and lottie animations. 
>
> Eg: When you drag and drop an image component, 2 assets are actually associated with the component by default: the placeholder image in light mode and dark mode
>
> ### Using the same asset for light mode and dark mode
>
> If you want to use the same image in dark mode and light mode, you can just delete the one associated to the dark mode.
>
> <Image align="center" className="border" border={true} src="https://files.readme.io/51071b771c183d64b843f53b47ac945b16c36a5a2e82234e483d59047f637df6-ezgif-3-edb916d59f.gif" />
>
> ### Deactivating the dark mode for a particular Screen
>
> Other option: if your entire app is not managing dark mode (or switching mode depending on user preference), you can simply deactivate the dark mode management at the screen level
>
> *Click on the button with the 3 dots in the upper right corner next to the button save draft, then click on settings and disable the dark mode by switching the control off*
>
> <Image align="center" className="border" border={true} src="https://files.readme.io/cc73aba6c8feef89c70a9bcb674513281e0696b54e1f097fd94291a64ea806ff-disable_dark_mode.gif" />
