---
title: Swift observer
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
# SDK INITIALISATION

```swift Swift
import Purchasely

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Purchasely.start(
       withAPIKey: "<<X-API-KEY>>",
       appUserId: nil, // optional if you already know your user id
			 runningMode: .paywallObserver,
			 storekitSettings: .storeKit1, // Set your StoreKit version
			 logLevel: .debug
    ) {(success, error) in
      print(success)
    }
	return true
}
```

# STOREKIT VERSION

You must specify which StoreKit version you want to use with Purchasely for iOS devices: `.storeKit1` or `.storeKit2`

# USER IDENTIFICATION

If you want the purchases and subscriptions to be associated to a user and not a device you can provide a user id in the`Purchasely.start()`method.