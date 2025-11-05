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
To manage deeplinks you need to do 2 things:

* Pass the deeplink to the Purchasely SDK when it is received by the application
* Allow the Purchasely SDK to display content over your interface
* Set a default presentation handler to get the result of what was done by the user on the paywall / screen

### PASSING THE DEEPLINK TO THE PURCHASELY SDK

To enable the Purchasely SDK to analyze the deeplink, the app needs to pass it using the following code:

```swift Without Using SceneDelegate
// ---------------------------------------------------
// If you are **NOT** using SceneDelegate
// ---------------------------------------------------

// AppDelegate.swift

import Purchasely

func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
	// You can chain calls to multiple handler using a OR
	return Purchasely.isDeeplinkHandled(deeplink: url) 
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
		_ = Purchasely.isDeeplinkHandled(deeplink: url)
	}
}

func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
	if let url = URLContexts.first?.url {
		_ = Purchasely.isDeeplinkHandled(deeplink: url)
	}
}
```

### ALLOWING THE DISPLAY

Your app might have a launch routine that requires to be fulfilled before another screen can be displayed. It can be splash screen, on boarding, login, displaying an ad etc...

For that reason, the display of Purchasely deeplinks is **deferred until you authorize it**. 

Once your app is ready, notify the Purchasely SDK by using the following code:

```swift
Purchasely.readyToOpenDeeplink(true)
```

### SETTING THE DEFAULT PRESENTATION HANDLER

Usually when a paywall / screen is instantiated by the app, a closure is called back to inform the app of what has happened with the paywall / screen. However, when a deeplink is called, as you don't instantiate the paywall / screen yourself, no closure will be called.

You can retrieve the result of the user action in a paywall opened with a deeplink by setting a `DefaultPresentationResultHandler`.

```swift Swift
Purchasely.setDefaultPresentationResultHandler { [weak self](result, plan) in
    switch result {
        case .purchased:
            break
        case .restored:
            break
        case .cancelled:
            break
        @unknown default:
				    break
    }
}
```
