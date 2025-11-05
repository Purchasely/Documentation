---
name: Deeplink implementation
---
# Deeplink implementation

To manage deeplinks you need to do 3 things:

1. Pass the deeplink to the Purchasely SDK when it is received by the application
2. Allow the Purchasely SDK to display content over your interface
3. Set a default presentation handler to get the result of what was done by the user on the paywall / screen

## 1. Passing the deeplink to Purchasely SDK

To enable the Purchasely SDK to analyze the deeplink, the app needs to provide it using the following code:

```swift Swift
// ---------------------------------------------------
// If you are **NOT** using SceneDelegate
// ---------------------------------------------------

// AppDelegate.swift

import Purchasely

func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
	// You can chain calls to multiple handler using a OR
	return Purchasely.isDeeplinkHandled(deeplink: url) 
}

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
```kotlin Kotlin
class MyActivity : FragmentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        //retrieve intent data to get deeplink that opened your activity
        val data = intent.data
        if(data != null) {
            //Purchasely sdk will return true if it handles the deeplink
            val isHandledByPurchasely = Purchasely.isDeeplinkHandled(data)
        }
    }    

}
```
```javascript React Native
Purchasely.isDeeplinkHandled('app://ply/presentations/')
          .then((value) => console.log('Deeplink handled by Purchasely ? ' + value));
```
```java Flutter
Purchasely.isDeeplinkHandled('app://ply/presentations/')
          .then((value) => print('Deeplink handled by Purchasely ? $value'));
```
```swift Cordova
// If you grab the deeplink inside your Cordova code you can call
Purchasely.isDeeplinkHandled("app://ply/presentations/", (handled) => {
	console.log("Was deeplink handled by Purchasely? " + handled);
});
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely.IsDeeplinkHandled("app://ply/presentations/");
```

## 2. Allowing the display

Your app might have a launch routine that requires to be fulfilled before another screen can be displayed. It can be splash screen, on boarding, login, displaying an ad etc...

For that reason, the display of Purchasely deeplinks is **deferred until you authorize it**. 

Once your app is ready, notify the Purchasely SDK by using the following code:

```swift
Purchasely.readyToOpenDeeplink(true)
```
```kotlin Kotlin
Purchasely.readyToOpenDeeplink = true
```
```javascript React Native
Purchasely.readyToOpenDeeplink(true);
```
```java Flutter
Purchasely.readyToOpenDeeplink(true);
```
```swift Cordova
Purchasely.readyToOpenDeeplink(true);
```
```csharp Unity
_purchasely.SetIsReadyToOpenDeeplink(true);
```