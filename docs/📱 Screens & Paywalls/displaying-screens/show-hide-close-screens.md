---
title: Controling Screen visibility
excerpt: This section describes how to manage Screen's visibility
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Learn how to customize your Screens by nesting multiple views
  pages:
    - type: basic
      slug: nesting-views
      title: Nesting views
---
> 🚧 Minimum SDK versions
>
> * ReactNative: 4.0.1
> * Cordova: 4.1.0
> * Flutter: 4.0.0
> * Unity: 4.1.0

## Overview

Managing the visibility of screens in your application is essential for providing a seamless user experience. The Purchasely SDK allows you to control the visibility of screens, enabling you to:

* Hide a Screen.
* Show again a hidden Screen.
* Close permanently a Screen.

To learn more about fetching and displaying screens using the Purchasely SDK, refer to the [displaying screens](displaying-screens) documentation.

## Implementation

### Hide a Screen

Use **`Purchasely.hidePresentation() `**&#x74;o hide a screen without closing it. This method is useful when you want to temporarily hide the screen and bring it back later.

```coffeescript Flutter
Purchasely.hidePresentation()
```
```coffeescript React Native
Purchasely.hidePresentation()
```
```coffeescript Cordova
Purchasely.hidePresentation()
```
```coffeescript Unity
private PurchaselyRuntime.Purchasely _purchasely

_purchasely.HidePresentation()
```

### Show a Screen

Use **`Purchasely.showPresentation()`** to display a screen that was previously hidden using **`hidePresentation()`**.

```coffeescript Flutter
Purchasely.showPresentation()
```
```coffeescript React Native
Purchasely.showPresentation()
```
```coffeescript Cordova
Purchasely.showPresentation()
```
```coffeescript Unity
private PurchaselyRuntime.Purchasely _purchasely

_purchasely.ShowPresentation()
```

### Close a Screen

Use **`Purchasely.closePresentation()`** to close the current screen permanently. If you want to display the screen again after closing it, you will have to fetch it again by calling fetchPresentation method.

```coffeescript Flutter
Purchasely.closePresentation()
```
```coffeescript React Native
Purchasely.closePresentation()
```
```coffeescript Cordova
Purchasely.closePresentation()
```
```coffeescript Unity
private PurchaselyRuntime.Purchasely _purchasely

_purchasely.ClosePresentation()
```
