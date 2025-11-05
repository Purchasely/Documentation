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
    Purchasely.start(
       withAPIKey: "<<X-API-KEY>>",
       appUserId: nil, // optional if you already know your user id
       runningMode: .full, // select between full and paywallObserver
       eventDelegate: nil,
       storekitSettings: .storeKit2, // Set your StoreKit version
       logLevel: .debug
    ) {(success, error) in
      print(success)
    }
	return true
}
```
```kotlin
import android.app.Application
import io.purchasely.ext.Purchasely
import io.purchasely.google.GoogleStore

class YourApplication: Application() {

    override fun onCreate() {
        super.onCreate()

        Purchasely.Builder(applicationContext)
            .apiKey("<<X-API-KEY>>")
            .userId(null) // optional if you already know your user id
            .stores(listOf(GoogleStore())) // Set the list of stores you want to have
            .build()
            .start { isConfigured, error ->
                if(isConfigured) {
                    // Purchasely setup is complete 
                )
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
// Everything is optional except apiKey and storeKit1
// Example with default values
bool configured = await Purchasely.start(
        apiKey: '<<X-API-KEY>>',
        androidStores: ['Google'], // default is Google, don't forget to add the dependency to the same version
        storeKit1: false, // set to false to use StoreKit2, true to use StoreKit1
        logLevel: PLYLogLevel.error, // set to debug in development mode to see logs
        runningMode: PLYRunningMode.full, // select between full and paywallObserver
        userId: null, // set a user id if you have one
      );
    
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
    false, // true for StoreKit 1, false for StoreKit 2
    null, // user id of user
    Purchasely.LogLevel.DEBUG, 
    Purchasely.RunningMode.full
);
```
```objectivec Objective-C
#import <Purchasely/Purchasely-Swift.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.

	[Purchasely startWithAPIKey:@"<<X-API-KEY>>"
			  appUserId:@"USER_ID"
			runningMode: PLYRunningModeFull
	              eventDelegate:nil
			 uiDelegate:nil
	           storekitSettings: [StorekitSettings .storekit2]
	  paywallActionsInterceptor:nil
		           logLevel: LogLevelInfo
			initialized: nil];
	return YES;
}
```
```java Java
import android.app.Application
import io.purchasely.ext.Purchasely
import io.purchasely.google.GoogleStore

public class YourApplication extends  Application {

		 @Override
     public void onCreate() {
        super.onCreate()

        Purchasely.Builder(applicationContext)
            .apiKey("<<X-API-KEY>>")
            .stores(listOf(GoogleStore())) // Set the list of stores you want to have
            .build()
            .start { isConfigured, error ->
                if(isConfigured) {
                    // Purchasely setup is complete 
                )
            }
    }
}
```

The parameter `runningMode` allows you to choose between the `full` mode and the `paywallObserver` mode.

[More details on the SDK running modes.](running-modes)

> 📘 This call is mandatory
> 
> Ensure that `Purchasely.start()` is **the first method executed** by your application.  
> This process does not block the main thread, allowing you to call other SDK methods immediately after invoking this method.

The following operations occur during initialization (non-exhaustive list):

- Fetching your [products and plans](product-plans-setup).
- Retrieving one-time purchases with StoreKit (Apple) or Play Billing (Google).
- Retrieving subscriptions and related offers with StoreKit (Apple) or Play Billing (Google).
- Fetching current and past subscriptions from the Purchasely platform (not executed every time, thanks to a caching system).

If you depend on any of this information at the start, you must wait for the [callback](#callback-on-initialization) to be triggered.

## API Key

<APIKey />

You can find your API Key in the section [App settings / Backend & SDK configuration](https://console.purchasely.io/settings?step=backend-sdk) of the Purchasely Console and copy it by clicking on the Copy button.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/92ea305-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

## `paywallObserver` mode

If you want to use Purchasely in [paywallObserver](paywallobserver-mode) mode, you need to set the running mode of `Purchasely.start()` method to `paywallObserver`

```swift Swift
import Purchasely

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Purchasely.start(
       withAPIKey: "<<X-API-KEY>>",
			 runningMode: .paywallObserver,
    ) {(success, error) in
      print(success)
    }
	return true
}
```
```kotlin
import android.app.Application
import io.purchasely.ext.Purchasely
import io.purchasely.google.GoogleStore

class YourApplication: Application() {

    override fun onCreate() {
        super.onCreate()

        Purchasely.Builder(applicationContext)
            .apiKey("<<X-API-KEY>>")
            .runningMode(PLYRunningMode.PaywallObserver)
            .stores(listOf(GoogleStore())) // Set the list of stores you want to have
            .build()
            .start { isConfigured, error ->
               if(isConfigured) {
               			// Purchasely setup is complete 
               )
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
// Everything is optional except apiKey and storeKit1
// Example with default values
bool configured = await Purchasely.start(
        apiKey: '<<X-API-KEY>>',
        androidStores: ['Google'], // default is Google, don't forget to add the dependency to the same version
        storeKit1: false, // set to false to use StoreKit2, true to use StoreKit1
        logLevel: PLYLogLevel.error, // set to debug in development mode to see logs
        runningMode: PLYRunningMode.paywallObserver, // select between full and paywallObserver
        userId: null, // set a user id if you have one
      );
    
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
    true, // true for StoreKit 1, false for StoreKit 2
    null, // user id of user
    Purchasely.LogLevel.DEBUG, 
    Purchasely.RunningMode.paywallObserver
);
```
```objectivec Objective-C
#import <Purchasely/Purchasely-Swift.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.

	[Purchasely startWithAPIKey:@"<<X-API-KEY>>"
			  appUserId:@"USER_ID"
			runningMode: PLYRunningModePaywallObserver
	              eventDelegate:nil
			 uiDelegate:nil
			storekitSettings: [StorekitSettings .storekit1]
	  paywallActionsInterceptor:nil
		           logLevel: LogLevelInfo
			initialized: nil];
	return YES;
}
```
```java Java
import android.app.Application
import io.purchasely.ext.Purchasely
import io.purchasely.google.GoogleStore

public class YourApplication extends  Application {

		 @Override
     public void onCreate() {
        super.onCreate()

        Purchasely.Builder(applicationContext)
            .apiKey("<<X-API-KEY>>")
            .runningMode(PLYRunningMode.Full.PaywallObserver)
            .stores(listOf(GoogleStore())) // Set the list of stores you want to have
            .build()
            .start { isConfigured, error ->
               if(isConfigured) {
               			// Purchasely setup is complete 
               )
            }
    }
}
```

## StoreKit version

<StoreKitDifferentVersions />

## Android stores

On Android, you must decide which store you want to use, either:

- Google Play Store
- Amazon App Store
- Huawei App Gallery

You can use multiple at the same time, but the first one available from the list you provide will be used by the SDK.

For example, with `listOf(GoogleStore(), AmazonStore())`, if Google Play Billing is available on the device, it will be the store used by the SDK.

Each store has its own dependency that you must install. Read our [installation guide](sdk-installation) for more information.

## User identification

<UserType />

## Callback on initialization

If you **rely on a specific user subscription status**, such as eligibility for an introductory offer or current active subscription, **wait for the start method callback**. At that point, the SDK will have gathered all the necessary information to provide an accurate answer.  
This **also applies when you want to display a placement** with an [Audience](segmenting-your-user-base) based on current or past subscription status.

Otherwise, you can [display a screen](displaying-screens) without waiting, as the SDK will automatically update the screen displayed when all necessary information about pricing and offers for your plans have been fetched.

The callback returns two values:

- `success`:** true | false** to indicate whether the SDK was initialized successfully and whether the configuration is correct. If it returns false, you can still use Purchasely SDK.
- `error`: Indicates the specific error that may have occurred when the `success` value is false.