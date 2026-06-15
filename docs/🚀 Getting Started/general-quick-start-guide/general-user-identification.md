---
title: User identification
excerpt: >-
  This section covers subscription transfer and event handling during user
  authentication.
deprecated: false
hidden: false
metadata:
  description: >-
    The document explains how to handle anonymous users making in-app purchases
    using the Purchasely SDK, including generating anonymous user IDs,
    associating purchases with those IDs, and authenticating users. It also
    provides guidance on intercepting paywall actions for user login.
  robots: index
next:
  description: Implement Custom User Attributes into your app
  pages:
    - slug: general-custom-user-attributes-integration
      title: Custom User Attributes Implementation
      type: basic
---
# Overview

Accurately identifying users within your application is essential for delivering personalized experiences and managing user-specific data. The Purchasely SDK provides robust tools for user identification.

# Anonymous users

## Handling anonymous purchasing

The Purchasely SDK automatically generates and assigns an **`anonymous_user_id`** to each user, maintaining consistency as long as the app remains installed on the device.

Your app can retrieve the **`anonymous_user_id`** by calling the following method of the SDK :

```swift Swift
Purchasely.anonymousUserId
```
```kotlin Kotlin
Purchasely.anonymousUserId
```
```typescript React Native
Purchasely.getAnonymousUserId();
```
```typescript Flutter
Purchasely.anonymousUserId;
```
```javascript Cordova
Purchasely.getAnonymousUserId((anonymousId) => {
	console.log("Purchasely anonymous Id: " + anonymousId);
});
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely.GetAnonymousUserId();
```

# Logged-in users

To login a user, just provides your user id. Purchasely will save this user id for all sessions moving forward until you call `Purchasely.userLogout()` or the user uninstall the application.  

* If the user is already logged-in when the SDK starts, you can provide the user_id directly in the `Purchasely.start()` method.

```swift Swift
import Purchasely

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Purchasely
        .apiKey("<<X-API-KEY>>")
        .appUserId("XYZ-123-ABC-456") // user ID
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

        Purchasely.Builder(applicationContext)
            .apiKey("<<X-API-KEY>>")
            .userId("XYZ-123-ABC-456") // user ID
            .runningMode(PLYRunningMode.Full)
            .build()
            .start { error ->
                if (error == null) {
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
        logLevel: LogLevels.ERROR, // set to debug in development mode to see logs
      userId: "XYZ-123-ABC-456" // user ID
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
        userId: "XYZ-123-ABC-456"    // user ID
      );
    
if (!configured) {
        print('Purchasely SDK not configured');
        return;
}
```
```javascript Cordova
/***
* @params String apiKey
* @params StringArray stores : may be Google, Amazon and Huawei
* @params String userId
* @params Purchasley.LogLevel logLevel
* @params Purchasely.RunningMode runningMode
**/
Purchasely.startWithAPIKey(
    '<<X-API-KEY>>', 
    ['Google'],
    "XYZ-123-ABC-456", // user ID 
    Purchasely.LogLevel.DEBUG 
);
```

* When the user logs-in, you can call the following method whenever you want and as much as you want, no network connection is required, the user id is saved directly if the SDK detect it has changed.

```swift Swift
Purchasely.userLogin(with: "123456789")
```
```kotlin Kotlin
Purchasely.userLogin("123456789")
```
```typescript React Native
Purchasely.userLogin('123456789');
```
```typescript Flutter
Purchasely.userLogin('123456789');
```
```javascript Cordova
Purchasely.userLogin("123456789", (shouldRefresh) => {
	if (shouldRefresh) {
		// You should call your backend to refresh user entitlements
	}
});
```
```csharp Unity
Purchasely.UserLogin("123456789", (shouldRefresh) => {
	if (shouldRefresh) {
		// You should call your backend to refresh user entitlements
	}
});
```

<br />

# Sign out users

To sign out user with Purchasely, you just need to call `Purchasely.userLogout()`. The user ID registered will be removed and Purchasely will use the auto generated **`anonymous_user_id`** to assign a variant for your A/B tests and to link a purchase.  

All [built-in attributes](user-attributes-list) and [customer user attributes](custom-user-attributes) will also be cleared by calling this method, you can prevent Purchasely from clearing your customer user attributes by adding `false` as argument of the method.

```swift Swift
Purchasely.userLogout()

// To prevent Purchasely from removing all custom user attributes 
Purchasely.userLogout(false)
```
```kotlin Kotlin
Purchasely.userLogout()

// To prevent Purchasely from removing all custom user attributes 
Purchasely.userLogout(clearUserAttributes = false)
```
```typescript React Native
Purchasely.userLogout();
```
```typescript Flutter
Purchasely.userLogout();
```
```javascript Cordova
Purchasely.userLogout();
```
```csharp Unity
Purchasely.UserLogout();
```

<br />
