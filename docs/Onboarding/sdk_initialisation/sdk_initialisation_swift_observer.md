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
    Purchasely
        .apiKey("<<X-API-KEY>>")
        .appUserId(nil) // optional if you already know your user id
        .runningMode(.observer)
        .storekitSettings(.storeKit1) // Set your StoreKit version
        .webRedemptionDelegate(self, appHandlesRedemptionAlert: false) // SDK 6.1.0
        .appAnonymousUserId(myUUID) // SDK 6.1.0, optional, reuses the anonymous id of your app
        .logLevel(.debug)
        .start { error in
            print(error == nil)
        }
	return true
}
```

# STOREKIT VERSION

You must specify which StoreKit version you want to use with Purchasely for iOS devices: `.storeKit1` or `.storeKit2`

# USER IDENTIFICATION

If you want the purchases and subscriptions to be associated to a user and not a device you can provide a user id in the`Purchasely.start()`method.

# WEB2APP REDEMPTION

Requires SDK 6.1.0. Your class must adopt `PLYWebRedemptionDelegate`. The SDK calls `webRedemptionCompleted(result: PLYWebRedemptionResult)` on the main thread, once per redemption. Set `appHandlesRedemptionAlert` to `true` to draw your own result screen.

# ANONYMOUS USER ID

Requires SDK 6.1.0. The parameter of `appAnonymousUserId` is a `UUID`, and the SDK stores it as an uppercase string. The SDK takes the id only when the device holds no anonymous id yet. Use `.appAnonymousUserId(myUUID, override: true)` to replace an id that already exists.
