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

```swift Swift
import Purchasely

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Purchasely
        .apiKey("<<X-API-KEY>>")
        .appUserId(nil) // optional if you already know your user id
        .runningMode(.full)
        .webRedemptionDelegate(self, appHandlesRedemptionAlert: false) // SDK 6.1.0, your AppDelegate adopts PLYWebRedemptionDelegate
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
            webRedemptionListener { result -> } // SDK 6.1.0, result of a Web2App redemption deeplink
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
            .webRedemptionListener { result -> } // SDK 6.1.0, result of a Web2App redemption deeplink
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

// Everything is optional except apiKey
// Example with default values
try {
    const configured = await Purchasely.builder('<<X-API-KEY>>')
        .appUserId(null)        // if you know your user id, set it here
        .runningMode('full')    // ⚠️ default is now 'observer' — set 'full' for Purchasely to handle purchases
        .logLevel('error')      // set to 'debug' in development mode to see logs
        .start();
} catch (e) {
     console.log("Purchasely SDK not configured properly");
}
```
```typescript Flutter
// Everything is optional except apiKey
// Example with default values
final bool configured = await Purchasely.apiKey('<<X-API-KEY>>')
    .logLevel(PLYLogLevel.error) // set to debug in development mode to see logs
    .appUserId(null) // set a user id if you have one
    .start();

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
Purchasely.start(
    '<<X-API-KEY>>',
    ['Google'],
    false, // false for StoreKit 2 (recommended), true for StoreKit 1
    null, // user id of user
    Purchasely.LogLevel.DEBUG,
    Purchasely.RunningMode.full, // ⚠️ v6 default is Observer — set .full to handle purchases
    (isConfigured) => {},
    (error) => console.error(error)
);
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

## Manual anonymous user id

> 📘 Requires SDK 6.1.0
>
> The manual anonymous user id is available from iOS SDK 6.1.0 and from Android SDK 6.1.0.

Give Purchasely the anonymous id that your app already uses. Both systems then report the same person. The two platforms do not share the same signature. Read the block for your platform.

### iOS: `appAnonymousUserId` takes a `UUID`

```swift Swift
Purchasely
    .apiKey("<<X-API-KEY>>")
    .appAnonymousUserId(myUUID) // taken only if the device holds no anonymous id yet
    .appAnonymousUserId(myUUID, override: true) // replaces an anonymous id that already exists
    .start()
```

The parameter is a `UUID`. Apple accepts a UUID only for `Transaction.appAccountToken`, so the type stops an id that StoreKit rejects. The SDK stores the id as an uppercase UUID string, because `UUID.uuidString` always returns uppercase characters. Send the same uppercase form from your backend when you compare the two ids.

A `nil` value changes nothing. The method never clears a stored id. iOS cannot accept an origin prefix such as `web_<uuid>`, because the type forbids it.

### Android: `anonymousUserId` takes a `String`

```kotlin
Purchasely.Builder(applicationContext)
    .apiKey("<<X-API-KEY>>")
    .anonymousUserId("YOUR_ID") // taken only if the device holds no anonymous id yet
    .anonymousUserId("YOUR_ID", override = true) // replaces an anonymous id that already exists
    .stores(listOf(GoogleStore()))
    .build()
    .start { error -> }
```

The value must be a canonical UUID, in uppercase or in lowercase. You can add a lowercase origin prefix, such as `web_<uuid>` or `mob_<uuid>`. The prefix makes the origin of the id visible in a dashboard. The `Purchasely { }` DSL provides the same method.

The SDK refuses any other value, writes an error log, and keeps its own generated id. The refusal never stops the initialization. The `override = true` form does not force a malformed value through.

### Rules for both platforms

The SDK takes your id only when the device holds no anonymous id yet. Use the `override` form to replace an id that already exists. An explicit id wins over an id from a Web2App redemption deeplink, because the SDK applies the explicit id first. Neither platform provides a setter. The identity belongs to the initialization, so it stays with the rest of the initialization. SDK v6 removed the former `Purchasely.setAnonymousUserId(id)` method.

## Android API proxy

> 📘 Requires SDK 6.1.0
>
> The `proxy` method is available from Android SDK 6.1.0. The iOS equivalent is not in 6.1.0.

Use a proxy when `api.purchasely.io` is unreachable, for example behind the Great Firewall in mainland China. Purchasely provides `https://svc.purchasely.io`. You can also host your own proxy.

```kotlin
Purchasely.Builder(applicationContext)
    .apiKey("<<X-API-KEY>>")
    .proxy(api = "https://svc.purchasely.io")
    .stores(listOf(GoogleStore()))
    .build()
    .start { error -> }
```

The SDK accepts only an `https` URL. It refuses a blank, a non-https, a malformed, a query-carrying, a fragment-carrying and a credential-carrying URL. It writes an error log and keeps the production host. The hosts `paywall.purchasely.io` and `tracking.purchasely.io` always stay on production. The `Purchasely { }` DSL provides the same method.

## Web2App redemption result

> 📘 Requires SDK 6.1.0
>
> The redemption delegate and the redemption listener are available from iOS SDK 6.1.0 and from Android SDK 6.1.0.

The SDK tells your app the result of a `ply/redeem/TOKEN` deeplink. Declare the delegate on iOS, or the listener on Android, in the initialization chain. Keep `appHandlesRedemptionAlert` at `false` to let the SDK present its own success or failure popin. Set it to `true` to present your own result screen instead.

The SDK calls your delegate or your listener on the main thread. It calls it exactly once for each settled redemption. On Android the `Purchasely { }` DSL and the `Purchasely.Builder` chain both provide the method. Read [Listeners / Delegates](listener-delegate) for the callback shape and for the result properties.

## Callback on initialization

You can provide a callback method when you start the SDK. It will be automatically called when the SDK has finished initializing.

You can display a screen without waiting the SDK to be fully initialized.

The callback returns a single value:

* `error`: `nil` when the SDK was initialized successfully and the configuration is correct. If it is not `nil`, you can still use Purchasely SDK, and it indicates the specific error that occurred.

<br />
