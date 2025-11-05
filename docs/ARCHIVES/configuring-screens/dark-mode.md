---
title: Dark Mode
excerpt: >-
  This pages describes how to custoimize your paywall in dark mode Automatically
  used by Purchasely if configured
deprecated: false
hidden: true
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

### Paywall in Dark mode:

After customizing the regular (light mode) version of your paywall, click on the Dark Mode tab to specify the dark mode details, including:

1. Background color, image, and video
2. close button, carousel knot 
3. Header image, video
4. Button text color, button background, border
5. Footer color and more

<Image align="center" className="border" border={true} src="https://files.readme.io/85cc9b2-image.png" />

<br />

**Adding the paywall to the placement**\
After creating the paywall, simply add it to the placement. It's as straightforward as that.

<Image align="center" className="border" border={true} src="https://files.readme.io/25d35f7-image.png" />

<br />

**Launching an A/B test**\
When launching an A/B test, select the placement and the paywall. Our SDK will automatically handle whether to show the light or dark mode.

<Image align="center" className="border" border={true} src="https://files.readme.io/1262e33-image.png" />

<br />

If you have a light mode paywall and want to learn how to customize it for dark mode, check out this article:

### How to customize existing paywalls ?

To get your paywalls ready for dark mode:

1. Select your light mode paywall and click 'edit'.

   <Image align="center" className="border" border={true} src="https://files.readme.io/6f1cc70-image.png" />
2. Switch to the 'Dark mode' tab

   <Image align="center" className="border" border={true} src="https://files.readme.io/72b935b-image.png" />
3. Update it for dark mode: 

   1. Background color, image and video
   2. Close button, carousel knot 
   3. Header image, video
   4. Button text color, button background, border

      <Image align="center" className="border" border={true} src="https://files.readme.io/44b00d0-image.png" />
4. Before you use this new version, make sure your app is running Purchasely SDK 4.2 or higher.

### Feature integration tips:

When you're moving from the older SDK version:

* Don't immediately remove your old setup of separate paywalls.
* Update your app with the latest Purchasely SDK (version 4.2).
* Take out the old code that was used to tell the SDK about the user's mode.
* Launch the updated version of your app.
* Start running one A/B test for both modes.
* Wait a couple of weeks for users to update the app.
* Then, you can start to streamline by removing the separate dark mode settings.
* Finally, get rid of any old audiences and paywalls you don't need anymore.
