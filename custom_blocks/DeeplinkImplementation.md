---
name: Deeplink implementation
---
# Deeplink implementation

To manage deeplinks you need to do up to 3 things:

1. Pass the deeplink to the Purchasely SDK when it is received by the application (**not required on Android** — see below)
2. Optionally control when Purchasely is allowed to display content over your interface
3. Set a default presentation handler to get the result of what was done by the user on the paywall / screen

## 1. Passing the deeplink to Purchasely SDK

> 📘 Android handles deeplinks automatically
>
> Since v6, the Android SDK **intercepts Purchasely deeplinks on its own** (it reads the foreground activity's intent on create and resume). **You don't need to call `handleDeeplink` yourself.** The manual call below is only useful as a fallback for activities using `singleTask` / `singleTop` launch modes that receive the deeplink in `onNewIntent` without calling `setIntent(intent)`.

To enable the Purchasely SDK to analyze the deeplink, the app provides it using the following code:

```swift Swift
// ---------------------------------------------------
// If you are **NOT** using SceneDelegate
// ---------------------------------------------------

// AppDelegate.swift

import Purchasely

func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
	// You can chain calls to multiple handler using a OR
	return Purchasely.handleDeeplink(url) 
}

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
```kotlin Kotlin
class MyActivity : FragmentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Optional on Android: the SDK already intercepts deeplinks automatically.
        // Keep this only as a fallback (e.g. singleTask/singleTop without setIntent()).
        val data = intent.data
        if (data != null) {
            // Purchasely SDK returns true if it handles the deeplink
            val isHandledByPurchasely = Purchasely.handleDeeplink(data)
        }
    }

}
```
```javascript React Native
Purchasely.handleDeeplink('app://ply/presentations/')
          .then((value) => console.log('Deeplink handled by Purchasely ? ' + value));
```
```java Flutter
Purchasely.handleDeeplink('app://ply/presentations/')
          .then((value) => print('Deeplink handled by Purchasely ? $value'));
```
```swift Cordova
// If you grab the deeplink inside your Cordova code you can call
Purchasely.handleDeeplink("app://ply/presentations/", (handled) => {
	console.log("Was deeplink handled by Purchasely? " + handled);
});
```
> 📘 Passing the deeplink at start
>
> When your app is launched **from** a deeplink (cold start), you can hand it to the SDK directly at initialization instead of waiting for the SDK to be ready:
>
> ```swift
> // iOS
> Purchasely.apiKey("YOUR_API_KEY").handleDeeplink(url).start { error in }
> ```
>
> ```kotlin
> // Android
> Purchasely.Builder(context).handleDeeplink(intent.data).build().start { error -> }
> ```

## 2. Forbidding the display

By **default**, Purchasely deeplinks are displayed **immediately** when they are received.

If your app has a launch routine that must complete before a screen can be shown (splash screen, onboarding, login, displaying an ad…), you can **temporarily prevent** Purchasely from displaying deeplinks, then re-enable it once you are ready:

```swift Swift
// Prevent the display (e.g. while your onboarding is on screen)
Purchasely.allowDeeplink(false)

// Re-enable it once your app is ready — any queued deeplink displays immediately
Purchasely.allowDeeplink(true)
```
```kotlin Kotlin
// Prevent the display (e.g. while your onboarding is on screen)
Purchasely.allowDeeplink = false

// Re-enable it once your app is ready — any queued deeplink displays immediately
Purchasely.allowDeeplink = true
```
```javascript React Native
Purchasely.allowDeeplink(false);
// later
Purchasely.allowDeeplink(true);
```
```java Flutter
Purchasely.allowDeeplink(false);
// later
Purchasely.allowDeeplink(true);
```
```swift Cordova
Purchasely.allowDeeplink(false);
// later
Purchasely.allowDeeplink(true);
```
> 📘 You only need this if you want to **defer** deeplinks. If you do nothing, deeplinks display as soon as they are received.

## 3. Forbidding campaigns

[Campaigns](campaigns) follow the same principle through their own flag, `allowCampaigns`, which is **`true` by default** (campaigns display immediately). To gate campaigns behind a launch flow, set it to `false` and flip it back to `true` when ready — any campaign queued meanwhile displays immediately:

```swift Swift
Purchasely.allowCampaigns(false)
// later
Purchasely.allowCampaigns(true)
```
```kotlin Kotlin
Purchasely.allowCampaigns = false
// later
Purchasely.allowCampaigns = true
```

`allowDeeplink` and `allowCampaigns` are independent: gating one does not affect the other.
