---
title: Swift
excerpt: ''
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
To manage deeplinks you need to do up to 3 things:

* Pass the deeplink to the Purchasely SDK when it is received by the application
* Optionally control when Purchasely is allowed to display content over your interface
* Set a default presentation handler to get the result of what was done by the user on the paywall / screen

### PASSING THE DEEPLINK TO THE PURCHASELY SDK

To enable the Purchasely SDK to analyze the deeplink, the app needs to pass it using the following code. You can also pass a cold-start deeplink at initialization with `Purchasely.apiKey("YOUR_API_KEY").handleDeeplink(url).start { error in }`.

```swift Without Using SceneDelegate
// ---------------------------------------------------
// If you are **NOT** using SceneDelegate
// ---------------------------------------------------

// AppDelegate.swift

import Purchasely

func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
	// You can chain calls to multiple handler using a OR
	return Purchasely.handleDeeplink(url) 
}
```
```Text With SceneDelegate
// ---------------------------------------------------
// If you are using SceneDelegate
// ---------------------------------------------------

// SceneDelegate.swift

import Purchasely

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

	// …

	if let url = connectionOptions.urlContexts.first?.url {
		_ = Purchasely.handleDeeplink(url)
	}
}

func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
	if let url = URLContexts.first?.url {
		_ = Purchasely.handleDeeplink(url)
	}
}
```

### FORBIDDING THE DISPLAY

By **default**, Purchasely deeplinks are displayed **immediately** when they are received.

If your app has a launch routine that must complete before a screen can be shown (splash screen, onboarding, login, displaying an ad…), you can **temporarily prevent** the display, then re-enable it once you are ready:

```swift
// Prevent the display (e.g. while your onboarding is on screen)
Purchasely.allowDeeplink(false)

// Re-enable it once ready — any queued deeplink displays immediately
Purchasely.allowDeeplink(true)
```

> 📘 You only need this if you want to **defer** deeplinks. Do nothing and they display as soon as they are received.

### SETTING THE DEFAULT PRESENTATION HANDLER

Usually when a paywall / screen is instantiated by the app, a closure is called back to inform the app of what has happened with the paywall / screen. However, when a deeplink is called, as you don't instantiate the paywall / screen yourself, no closure will be called.

You can retrieve the result of the user action in a paywall opened with a deeplink by setting a `DefaultPresentationResultHandler`.

```swift Swift
Purchasely.setDefaultPresentationDismissHandler { outcome in
    switch outcome.purchaseResult {
        case .purchased:
            break
        case .restored:
            break
        case .cancelled:
            break
        case .none:
            break
        @unknown default:
				    break
    }
}
```
