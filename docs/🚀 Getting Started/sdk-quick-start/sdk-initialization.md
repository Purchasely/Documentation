---
title: SDK initialization
excerpt: How to start Purchasely SDKs and all necessary parameters
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    You can look at how to use deeplinks with Purchasely or skip directly to
    displaying screens
  pages:
    - type: basic
      slug: deeplinks-management
      title: Deeplinks management
    - type: basic
      slug: screens-display
      title: Screens display
---
# Start

<SDKInitializationAdvice />

```swift Swift
import Purchasely

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Purchasely
        .apiKey("<<X-API-KEY>>")
        .appUserId(nil) // optional if you already know your user id
        .runningMode(.full) // ⚠️ default is now .observer — set .full for Purchasely to handle purchases
        .storekitSettings(.storeKit2) // Set your StoreKit version
        .logLevel(.debug)
        .start { error in
            print(error == nil)
        }
	return true
}
```
```kotlin
import android.app.Application
import io.purchasely.ext.Purchasely
import io.purchasely.ext.PLYRunningMode
import io.purchasely.google.GoogleStore

class YourApplication: Application() {

    override fun onCreate() {
        super.onCreate()

        // ── Recommended — Kotlin DSL: configures AND starts the SDK in one call ──
        Purchasely {
            context(applicationContext)
            apiKey("<<X-API-KEY>>")
            userId(null) // optional if you already know your user id
            stores(listOf(GoogleStore())) // Set the list of stores you want to have
            runningMode(PLYRunningMode.Full) // ⚠️ default is now Observer — set Full for Purchasely to handle purchases
            onInitialized { error ->
                if (error == null) {
                    // Purchasely setup is complete
                }
            }
        }

        // ── Alternative — fluent Builder (same behavior; the only form for Java) ──
        Purchasely.Builder(applicationContext)
            .apiKey("<<X-API-KEY>>")
            .userId(null)
            .stores(listOf(GoogleStore()))
            .runningMode(PLYRunningMode.Full)
            .build()
            .start { error ->
                if (error == null) {
                    // Purchasely setup is complete
                }
            }
    }
}

```
```typescript ReactNative
import Purchasely from 'react-native-purchasely';

// Everything is optional except apiKey and storeKit1
// Example with default values
try {
    const configured = await Purchasely.start({
        apiKey: '<<X-API-KEY>>',
        storeKit1: false, // set to false to use StoreKit2, true to use StoreKit1,
        logLevel: LogLevels.ERROR, // set to debug in development mode to see logs
        userId: null, // if you know your user id, set it here
        runningMode: RunningMode.FULL, // select between full and paywallObserver
        androidStores: ['Google'] // default is Google, don't forget to add the dependency to the same version
     });
} catch (e) {
     console.log("Purchasely SDK not configured properly");
}
```
```typescript Flutter
// Everything is optional except apiKey
// Example with default values
final bool configured = await PurchaselyBuilder.apiKey('<<X-API-KEY>>')
    .stores([PLYStore.google]) // default is Google, don't forget to add the dependency to the same version
    .storekitVersion(StorekitVersion.storeKit2) // storeKit2 (default) | storeKit1
    .logLevel(LogLevel.error) // set to debug in development mode to see logs
    .runningMode(RunningMode.full) // ⚠️ default is now observer — set full for Purchasely to handle purchases
    .appUserId(null) // set a user id if you have one
    .start();

if (!configured) {
        print('Purchasely SDK not configured');
        return;
}
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely = new PurchaselyRuntime.Purchasely("USER_ID",
			false, // true for StoreKit 1, false for StoreKit 2
			LogLevel.Debug,
			RunningMode.Full,
			OnPurchaselyStart,
			OnPurchaselyEvent);
```
```javascript Cordova
/**
* @params String apiKey
* @params StringArray stores : may be Google, Amazon and Huawei
* @params String userId
* @params Purchasley.LogLevel logLevel
* @params Purchasely.RunningMode runningMode
**/
Purchasely.startWithAPIKey(
    '<<X-API-KEY>>', 
    ['Google'],
    false, // false for StoreKit 2 (recommended), true for StoreKit 1
    null, // user id of user
    Purchasely.LogLevel.DEBUG,
    Purchasely.RunningMode.full,
    (isConfigured) => {},
    (error) => console.error(error)
);
```

The parameter `runningMode` allows you to choose between the `full` mode and the `observer` mode.

> 🚧 Major change in v6 — default running mode is now `observer`
>
> In SDK v5 the default running mode was **Full** (Purchasely handles and validates purchases).
> In **SDK v6 the default is `observer`** (Purchasely only observes transactions, without processing them).
>
> This change is **silent** — your code keeps compiling. If you want Purchasely to handle the
> purchase flow and validate receipts, you **must** now set the mode explicitly:
> `.runningMode(.full)` on iOS, `.runningMode(PLYRunningMode.Full)` on Android.
>
> See the [v6 migration guide](migrating-from-sdk-5-to-6) for details.

[More details on the SDK running modes.](running-modes)

> 📘 This call is mandatory
>
> Ensure that `Purchasely.start()` is **the first method executed** by your application.\
> This process does not block the main thread, allowing you to call other SDK methods immediately after invoking this method.

The following operations occur during initialization (non-exhaustive list):

* Fetching your [products and plans](product-plans-setup).
* Retrieving one-time purchases with StoreKit (Apple) or Play Billing (Google).
* Retrieving subscriptions and related offers with StoreKit (Apple) or Play Billing (Google).
* Fetching current and past subscriptions from the Purchasely platform (not executed every time, thanks to a caching system).

If you depend on any of this information at the start, you must wait for the [callback](#callback-on-initialization) to be triggered.

## API Key

<APIKey />

You can find your API Key in the section [App settings / Backend & SDK configuration](https://console.purchasely.io/settings?step=backend-sdk) of the Purchasely Console and copy it by clicking on the Copy button.

<Image align="center" className="border" border={true} src="https://files.readme.io/92ea305-image.png" />

<br />

## `observer` mode

This is now the **default** running mode in SDK v6. If you want to use Purchasely in [observer](paywallobserver-mode) mode explicitly, set the running mode to `observer` (`.observer` on iOS, `PLYRunningMode.Observer` on Android):

```swift Swift
import Purchasely

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Purchasely
        .apiKey("<<X-API-KEY>>")
        .runningMode(.observer)
        .start { error in
            print(error == nil)
        }
	return true
}
```
```kotlin
import android.app.Application
import io.purchasely.ext.Purchasely
import io.purchasely.ext.PLYRunningMode
import io.purchasely.google.GoogleStore

class YourApplication: Application() {

    override fun onCreate() {
        super.onCreate()

        Purchasely.Builder(applicationContext)
            .apiKey("<<X-API-KEY>>")
            .runningMode(PLYRunningMode.Observer)
            .stores(listOf(GoogleStore())) // Set the list of stores you want to have
            .build()
            .start { error ->
               if (error == null) {
               			// Purchasely setup is complete
               }
            }
    }
}

```
```typescript ReactNative
import Purchasely from 'react-native-purchasely';

// Everything is optional except apiKey and storeKit1
// Example with default values
try {
    const configured = await Purchasely.start({
        apiKey: '<<X-API-KEY>>',
        storeKit1: false, // set to false to use StoreKit2, true to use StoreKit1,
        logLevel: LogLevels.ERROR, // set to debug in development mode to see logs
        userId: null, // if you know your user id, set it here
        runningMode: RunningMode.PaywallObserver, // select between full and paywallObserver
        androidStores: ['Google'] // default is Google, don't forget to add the dependency to the same version
     });
} catch (e) {
     console.log("Purchasely SDK not configured properly");
}
```
```typescript Flutter
// Everything is optional except apiKey
// Example with default values
final bool configured = await PurchaselyBuilder.apiKey('<<X-API-KEY>>')
    .stores([PLYStore.google]) // default is Google, don't forget to add the dependency to the same version
    .storekitVersion(StorekitVersion.storeKit2) // storeKit2 (default) | storeKit1
    .logLevel(LogLevel.error) // set to debug in development mode to see logs
    .runningMode(RunningMode.observer) // select between full and observer
    .appUserId(null) // set a user id if you have one
    .start();

if (!configured) {
        print('Purchasely SDK not configured');
        return;
}
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely = new PurchaselyRuntime.Purchasely("USER_ID",
			false, // true for StoreKit 1, false for StoreKit 2
			LogLevel.Debug,
			RunningMode.PaywallObserver,
			OnPurchaselyStart,
			OnPurchaselyEvent);
```
```javascript Cordova
/**
* @params String apiKey
* @params StringArray stores : may be Google, Amazon and Huawei
* @params String userId
* @params Purchasley.LogLevel logLevel
* @params Purchasely.RunningMode runningMode
**/
Purchasely.startWithAPIKey(
    '<<X-API-KEY>>', 
    ['Google'],
    false, // false for StoreKit 2 (recommended), true for StoreKit 1
    null, // user id of user
    Purchasely.LogLevel.DEBUG,
    Purchasely.RunningMode.observer,
    (isConfigured) => {},
    (error) => console.error(error)
);
```

## StoreKit version

<StoreKitDifferentVersions />

## Android stores

On Android, you must decide which store you want to use, either:

* Google Play Store
* Amazon App Store
* Huawei App Gallery

You can use multiple at the same time, but the first one available from the list you provide will be used by the SDK.

For example, with `listOf(GoogleStore(), AmazonStore())`, if Google Play Billing is available on the device, it will be the store used by the SDK.

Each store has its own dependency that you must install. Read our [installation guide](sdk-installation) for more information.

## User identification

<UserType />

## Callback on initialization

If you **rely on a specific user subscription status**, such as eligibility for an introductory offer or current active subscription, **wait for the start method callback**. At that point, the SDK will have gathered all the necessary information to provide an accurate answer.\
This **also applies when you want to display a placement** with an [Audience](segmenting-your-user-base) based on current or past subscription status.

Otherwise, you can [display a screen](displaying-screens) without waiting, as the SDK will automatically update the screen displayed when all necessary information about pricing and offers for your plans have been fetched.

Since SDK v6, the callback returns a single value:

* `error`: `nil` (Swift) / `null` (Kotlin) when the SDK was initialized successfully and the configuration is correct. When it is non-null, it indicates the specific error that occurred — you can still use the Purchasely SDK.
