---
title: SDK initialization
excerpt: How to start Purchasely SDKs and all necessary parameters
deprecated: false
hidden: false
metadata:
  robots: index
next:
  description: >-
    You can look at how to use deeplinks with Purchasely or skip directly to
    displaying screens
  pages:
    - slug: deeplinks-management
      title: Deeplinks management
      type: basic
    - slug: screens-display
      title: Screens display
      type: basic
---
# Start

<SDKInitializationAdvice />

```swift Swift
import Purchasely

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Purchasely
        .apiKey("<<X-API-KEY>>")
        .appUserId(nil) // optional if you already know your user id
        .runningMode(.full)
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

        // Kotlin DSL — configures AND starts the SDK in a single call
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
        logLevel: LogLevels.ERROR, // set to debug in development mode to see logs
        userId: null // if you know your user id, set it here
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
        logLevel: PLYLogLevel.error, // set to debug in development mode to see logs
        userId: null, // set a user id if you have one
      );
    
if (!configured) {
        print('Purchasely SDK not configured');
        return;
}
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
    null, // user id of user
    Purchasely.LogLevel.DEBUG 
);
```

### Kotlin — fluent Builder (alternative to the DSL)

On Android, the Kotlin DSL above is the recommended entry point. You can also use the fluent `Purchasely.Builder`, which behaves identically:

```kotlin Kotlin
Purchasely.Builder(applicationContext)
    .apiKey("<<X-API-KEY>>")
    .userId(null) // optional if you already know your user id
    .stores(listOf(GoogleStore())) // Set the list of stores you want to have
    .runningMode(PLYRunningMode.Full) // ⚠️ default is now Observer — set Full for Purchasely to handle purchases
    .build()
    .start { error ->
        if (error == null) {
            // Purchasely setup is complete
        }
    }
```

<br />

[More details on the SDK running modes.](running-modes)

> 📘 This call is mandatory
>
> Ensure that `Purchasely.start()` is **the first method executed** by your application.  
> This process does not block the main thread, allowing you to call other SDK methods immediately after invoking this method.

<br />

## API Key

The API Key serves as a confidential identifier, enabling your application to authenticate with Purchasely. It's crucial to securely store this key within your application and ensure it is never disclosed publicly.

You can find your API Key in the section [App settings / Backend & SDK configuration](https://console.purchasely.io/settings?step=backend-sdk) of the Purchasely Console and copy it by clicking on the Copy button.

<Image align="center" border={true} src="https://files.readme.io/92ea305-image.png" className="border" />

<br />

## User identification

<UserType />

## Callback on initialization

You can provide a callback method when you start the SDK. It will be automatically called when the SDK has finished initializing.

You can display a screen without waiting the SDK to be fully initialized.

The callback returns a single value:

* `error`: `nil` when the SDK was initialized successfully and the configuration is correct. If it is not `nil`, you can still use Purchasely SDK, and it indicates the specific error that occurred.

<br />
