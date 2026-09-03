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
        .stores(['google'])             // default is ['google'], don't forget to add the dependency to the same version
        .storekitVersion('storeKit2')   // 'storeKit2' (default) | 'storeKit1'
        .logLevel('error')              // set to 'debug' in development mode to see logs
        .runningMode('full')            // ⚠️ default is now 'observer' — set 'full' for Purchasely to handle purchases
        .appUserId(null)                // if you know your user id, set it here
        .start();
} catch (e) {
     console.log("Purchasely SDK not configured properly");
}
```
```typescript Flutter
// Everything is optional except apiKey
// Example with default values
final bool configured = await Purchasely.apiKey('<<X-API-KEY>>')
    .stores([PLYStore.google]) // default is Google, don't forget to add the dependency to the same version
    .storekitVersion(PLYStorekitVersion.storeKit2) // storeKit2 (default) | storeKit1
    .logLevel(PLYLogLevel.error) // set to debug in development mode to see logs
    .runningMode(PLYRunningMode.full) // ⚠️ default is now observer — set full for Purchasely to handle purchases
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
    Purchasely.RunningMode.full,
    (isConfigured) => {},
    (error) => console.error(error)
);
```

The parameter `runningMode` allows you to choose between the `full` mode and the `observer` mode.

<Callout icon="🚧" theme="warn">
  ### Major change in v6 — default running mode is now `observer`

  In SDK v5 the default running mode was **Full** (Purchasely handles and validates purchases).
  In **SDK v6 the default is&#x20;**`observer` (Purchasely only observes transactions, without processing them).

  This change is **silent** — your code keeps compiling. If you want Purchasely to handle the
  purchase flow and validate receipts, you **must** now set the mode explicitly:
  `.runningMode(.full)` on iOS, `.runningMode(PLYRunningMode.Full)` on Android.

  See the [v6 migration guide](migrating-from-sdk-5-to-6) for details.
</Callout>

[More details on the SDK running modes.](running-modes)

<Callout icon="📘" theme="info">
  ### This call is mandatory

  Ensure that `Purchasely.start()` is **the first method executed** by your application.<br />This process does not block the main thread, allowing you to call other SDK methods immediately after invoking this method.
</Callout>

The following operations occur during initialization (non-exhaustive list):

* Fetching your [products and plans](product-plans-setup).
* Retrieving one-time purchases with StoreKit (Apple) or Play Billing (Google).
* Retrieving subscriptions and related offers with StoreKit (Apple) or Play Billing (Google).
* Fetching current and past subscriptions from the Purchasely platform (not executed every time, thanks to a caching system).

If you depend on any of this information at the start, you must wait for the [callback](#callback-on-initialization) to be triggered.

## API Key

<APIKey />

You can find your API Key in the section [App settings / Backend & SDK configuration](https://console.purchasely.io/settings?step=backend-sdk) of the Purchasely Console and copy it by clicking on the Copy button.


<Image src="https://files.readme.io/92ea305-image.png" align="center" border={true} />


<br />

## `observer` mode

This is now the **default** running mode in SDK v6. If you want to use Purchasely in [observer](observer-mode) mode explicitly, set the running mode to `observer` (`.observer` on iOS, `PLYRunningMode.Observer` on Android):

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

// Everything is optional except apiKey
// Example with default values
try {
    const configured = await Purchasely.builder('<<X-API-KEY>>')
        .stores(['google'])             // default is ['google'], don't forget to add the dependency to the same version
        .storekitVersion('storeKit2')   // 'storeKit2' (default) | 'storeKit1'
        .logLevel('error')              // set to 'debug' in development mode to see logs
        .runningMode('observer')        // select between 'full' and 'observer'
        .appUserId(null)                // if you know your user id, set it here
        .start();
} catch (e) {
     console.log("Purchasely SDK not configured properly");
}
```
```typescript Flutter
// Everything is optional except apiKey
// Example with default values
final bool configured = await Purchasely.apiKey('<<X-API-KEY>>')
    .stores([PLYStore.google]) // default is Google, don't forget to add the dependency to the same version
    .storekitVersion(PLYStorekitVersion.storeKit2) // storeKit2 (default) | storeKit1
    .logLevel(PLYLogLevel.error) // set to debug in development mode to see logs
    .runningMode(PLYRunningMode.observer) // select between full and observer
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

## Android API proxy

<Callout icon="📘" theme="info">
  ### Requires SDK 6.1.0

  The `proxy` method is available from Android SDK 6.1.0. The iOS equivalent is not in 6.1.0.
</Callout>

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

## User identification

<UserType />

## Manual anonymous user id

<Callout icon="📘" theme="info">
  ### Requires SDK 6.1.0

  The manual anonymous user id is available from iOS SDK 6.1.0 and from Android SDK 6.1.0.
</Callout>

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

## Web2App redemption result

<Callout icon="📘" theme="info">
  ### Requires SDK 6.1.0

  The redemption delegate and the redemption listener are available from iOS SDK 6.1.0 and from Android SDK 6.1.0.
</Callout>

The SDK tells your app the result of a `ply/redeem/TOKEN` deeplink. Declare the delegate on iOS, or the listener on Android, in the initialization chain. Keep `appHandlesRedemptionAlert` at `false` to let the SDK present its own success or failure popin. Set it to `true` to present your own result screen instead.

The SDK calls your delegate or your listener on the main thread. It calls it exactly once for each settled redemption. On Android the `Purchasely { }` DSL and the `Purchasely.Builder` chain both provide the method. Read [Listeners / Delegates](listener-delegate) for the callback shape and for the result properties.

## Callback on initialization

If you **rely on a specific user subscription status**, such as eligibility for an introductory offer or current active subscription, **wait for the start method callback**. At that point, the SDK will have gathered all the necessary information to provide an accurate answer.<br />This **also applies when you want to display a placement** with an [Audience](segmenting-your-user-base) based on current or past subscription status.

Otherwise, you can [display a screen](displaying-screens) without waiting, as the SDK will automatically update the screen displayed when all necessary information about pricing and offers for your plans have been fetched.

Since SDK v6, the callback returns a single value:

* `error`: `nil` (Swift) / `null` (Kotlin) when the SDK was initialized successfully and the configuration is correct. When it is non-null, it indicates the specific error that occurred — you can still use the Purchasely SDK.
