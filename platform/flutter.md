# Purchasely Flutter SDK Documentation

This document provides comprehensive documentation for integrating and using the Purchasely Flutter SDK with Dart.

---

## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
3. [SDK Initialization](#sdk-initialization)
4. [Displaying Paywalls](#displaying-paywalls)
5. [Processing Transactions](#processing-transactions)
6. [Action Interceptor](#action-interceptor)
7. [User Identification](#user-identification)
8. [Subscription Status & Entitlements](#subscription-status--entitlements)
9. [Custom User Attributes](#custom-user-attributes)
10. [Event Listeners](#event-listeners)
11. [Pre-fetching Screens](#pre-fetching-screens)
12. [Deeplinks Management](#deeplinks-management)
13. [Platform-Specific Features](#platform-specific-features)

---

## Requirements

| Requirement | iOS | Android |
|-------------|-----|---------|
| Minimum OS Version | 11.0 | 21 |
| compileSdkVersion | - | 33 |
| targetSdkVersion | - | 33 |

---

## Installation

### Main Dependency

Install the Purchasely Flutter SDK via pub.dev:

```shell
flutter pub add purchasely_flutter
```

### iOS Setup

Update your Podfile to set the minimum iOS version:

```yaml
// Podfile

...

platform :ios, '11.0'

...
```

Then run:

```shell
cd ios && pod install
```

### Android Setup

Update your `android/build.gradle` file:

```groovy
// Edit file android/build.gradle
buildscript {
    ext {
        minSdkVersion = 21 //min version must not be below 21
        compileSdkVersion = 33
        targetSdkVersion = 33
    }
}

allprojects {
    repositories {
        mavenCentral()
    }
}
```

### Android Dependencies

> ⚠️ **Important**: The main Purchasely SDK (`purchasely_flutter`) does **NOT** include store implementations by default. This modular architecture allows you to include only the stores you need and avoid dependency conflicts.

With Android, you can choose to use Google Play Store and/or Huawei AppGallery and/or Amazon Appstore. **You must install the corresponding dependency for each store you want to support.**

#### Google Play Billing (Required for Google Play Store)

If your app is distributed on the **Google Play Store**, you **must** install the Google Play Billing dependency:

```shell
flutter pub add purchasely_google
```

**Why is this required?**
- The Purchasely core SDK does not include the Google Play Billing library
- When you specify `androidStores: ['Google']` in initialization, the SDK looks for this dependency at runtime
- Without this dependency, purchases will not work on Android devices using Google Play Store
- The app may crash or fail to initialize properly on Android

#### Video Player (Required for Video Paywalls)

If your paywalls contain videos, you **must** install the Android video player dependency:

```shell
flutter pub add purchasely_android_player
```

**Why is this required?**
- The core SDK does not include a video player to avoid conflicts with other media libraries you may have (e.g., Media3/ExoPlayer)
- Without this dependency, videos in paywalls will not play on Android
- If you already have your own video player that supports HLS, you can provide your own player view instead

#### Version Matching (Critical)

> ⚠️ **All Purchasely packages must be at the exact same version.** Mismatched versions will cause runtime errors or unexpected behavior.

```yaml
# pubspec.yaml
dependencies:
  purchasely_flutter: ^5.0.0
  purchasely_google: ^5.0.0
  purchasely_android_player: ^5.0.0
```

#### Complete Android Installation Example

For a typical app distributed on Google Play Store with video paywalls:

```shell
# Install all required dependencies
flutter pub add purchasely_flutter
flutter pub add purchasely_google
flutter pub add purchasely_android_player
```

Then initialize with the Google store:

```dart
bool configured = await Purchasely.start(
    apiKey: 'YOUR_API_KEY',
    androidStores: ['Google'], // Requires purchasely_google package
    storeKit1: false,
    logLevel: PLYLogLevel.error,
    runningMode: PLYRunningMode.full,
    userId: null,
);
```

---

## SDK Initialization

Initialize the Purchasely SDK as early as possible in your application lifecycle.

### Full Mode (Recommended)

In `full` mode, Purchasely handles the entire purchase flow including transactions and receipts.

```dart
import 'package:purchasely_flutter/purchasely_flutter.dart';

// Everything is optional except apiKey and storeKit1
// Example with default values
bool configured = await Purchasely.start(
    apiKey: 'YOUR_API_KEY',
    androidStores: ['Google'], // default is Google, don't forget to add the dependency
    storeKit1: false, // set to false to use StoreKit2, true to use StoreKit1
    logLevel: PLYLogLevel.error, // set to debug in development mode to see logs
    runningMode: PLYRunningMode.full, // select between full and paywallObserver
    userId: null, // set a user id if you have one
);

if (!configured) {
    print('Purchasely SDK not configured');
    return;
}

print('Purchasely SDK configured successfully');
```

### PaywallObserver Mode

Use `paywallObserver` mode if you have an existing in-app purchase infrastructure and want to use Purchasely only for paywall display and analytics.

```dart
bool configured = await Purchasely.start(
    apiKey: 'YOUR_API_KEY',
    androidStores: ['Google'],
    storeKit1: false,
    logLevel: PLYLogLevel.error,
    runningMode: PLYRunningMode.paywallObserver,
    userId: null,
);

if (!configured) {
    print('Purchasely SDK not configured');
    return;
}
```

### API Key

You can find your API Key in the Purchasely Console under **App settings > Backend & SDK configuration**.

---

## Displaying Paywalls

Purchasely paywalls are displayed using **placements**. A placement is a specific location in your app where you want to display a paywall (e.g., onboarding, settings, premium feature).

### Display a Placement

```dart
try {
    var result = await Purchasely.presentPresentationForPlacement(
        'ONBOARDING',
        isFullscreen: true,
    );

    switch (result.result) {
        case PLYPurchaseResult.purchased:
            print('User purchased: ${result.plan?.name}');
            // Update entitlements to unlock content
            break;
        case PLYPurchaseResult.restored:
            print('User restored purchases');
            // Update entitlements to unlock content
            break;
        case PLYPurchaseResult.cancelled:
            print('User cancelled purchased');
            break;
    }
} catch (e) {
    print(e);
}
```

### Display Results

After displaying a placement, you receive a result indicating the user's action:

- `PLYPurchaseResult.purchased`: User purchased a plan
- `PLYPurchaseResult.restored`: User restored a previous purchase
- `PLYPurchaseResult.cancelled`: User did not complete a purchase

---

## Processing Transactions

### Full Mode

In `full` mode, the Purchasely SDK automatically launches the native in-app purchase flow when a user clicks on a purchase button and handles the transaction. You only need to update entitlements once you have confirmation that the purchase was processed.

```dart
try {
    var result = await Purchasely.presentPresentationForPlacement(
        'onboarding',
        isFullscreen: true,
    );

    switch (result.result) {
        case PLYPurchaseResult.purchased:
            print('User purchased: ${result.plan?.name}');
            // Update entitlements to unlock the access to the contents
            break;
        case PLYPurchaseResult.restored:
            print('User restored his purchases');
            // Update entitlements to unlock the access to the contents
            break;
        case PLYPurchaseResult.cancelled:
            print('User cancelled purchased');
            break;
    }
} catch (e) {
    print(e);
}
```

### PaywallObserver Mode with Action Interceptor

In `paywallObserver` mode, you handle purchases with your own infrastructure while using Purchasely for paywall display.

```dart
Purchasely.setPaywallActionInterceptorCallback(
    (PaywallActionInterceptorResult result) {
    if (result.action == PLYPaywallAction.purchase) {
        try {
            // The store product id (sku) the user clicked on in the paywall
            var productId = result.parameters.plan.productId;

            if (Platform.isAndroid) {
                // Only for Android you can get other interesting parameters
                String basePlanId = result.parameters.subscriptionOffer?.basePlanId;
                String offerId = result.parameters.subscriptionOffer?.offerId;
                String offerToken = result.parameters.subscriptionOffer?.offerToken;
            }

            bool success = await MyPurchaseSystem.purchase(productId);
            if (success) {
                // Synchronize all purchases with Purchasely
                Purchasely.synchronize();
                // Notify Purchasely paywall to stop processing action
                Purchasely.onProcessAction(false);
            }
        } catch (e) {
            Purchasely.onProcessAction(false);
            print(e);
        }
    } else if (result.action == PLYPaywallAction.restore) {
        Purchasely.onProcessAction(false);

        try {
            await MyPurchaseSystem.restoreAllPurchases();
            // Synchronize all purchases with Purchasely
            Purchasely.synchronize();
            Purchasely.onProcessAction(false);
        } on PlatformException catch (e) {
            Purchasely.onProcessAction(false);
            // Error restoring purchases
        }
    } else {
        // Notify Purchasely paywall to continue other actions
        Purchasely.onProcessAction(true);
    }
});
```

---

## Action Interceptor

The Action Interceptor allows you to intercept and handle user actions on the paywall.

### Available Actions

| Action | Description |
|--------|-------------|
| `PLYPaywallAction.purchase` | User tapped a purchase button |
| `PLYPaywallAction.restore` | User tapped the restore button |
| `PLYPaywallAction.login` | User tapped the login button |
| `PLYPaywallAction.close` | User tapped the close button |
| `PLYPaywallAction.navigate` | User wants to navigate to an external URL |
| `PLYPaywallAction.open_presentation` | User wants to open another presentation |

### Implementation

```dart
Purchasely.setPaywallActionInterceptorCallback(
    (PaywallActionInterceptorResult result) {
    if (result.action == PLYPaywallAction.navigate) {
        print('User wants to navigate');
        Purchasely.onProcessAction(true);
    } else if (result.action == PLYPaywallAction.close) {
        print('User wants to close paywall');
        Purchasely.onProcessAction(false);
    } else if (result.action == PLYPaywallAction.login) {
        print('User wants to login');
        // Present your own screen for user to log in
        Purchasely.closePresentation();
        Purchasely.userLogin('MY_USER_ID');
        // Call this method to update Purchasely Paywall
        Purchasely.onProcessAction(true);
    } else if (result.action == PLYPaywallAction.open_presentation) {
        print('User wants to open a new paywall');
        Purchasely.onProcessAction(true);
    } else if (result.action == PLYPaywallAction.purchase) {
        print('User wants to purchase');
        // If you want to intercept it, close presentation and display your screen
        Purchasely.closePresentation();
        Purchasely.onProcessAction(false);
    } else if (result.action == PLYPaywallAction.restore) {
        print('User wants to restore his purchases');
        Purchasely.onProcessAction(true);
    } else {
        print('Action unknown ' + result.action.toString());
        Purchasely.onProcessAction(true);
    }
});
```

> **Important**: Always call `Purchasely.onProcessAction(true/false)` to notify the SDK whether to continue processing the action.

---

## User Identification

### Anonymous Users

The Purchasely SDK automatically generates and assigns an `anonymous_user_id` to each user, maintaining consistency as long as the app remains installed on the device.

```dart
// Get the anonymous user ID
String anonymousId = Purchasely.anonymousUserId;
print('Anonymous User ID: $anonymousId');
```

### User Login

To authenticate users and associate purchases with their account:

```dart
// Login with user ID
Purchasely.userLogin('123456789').then((refresh) {
    if (refresh) {
        // Call your backend to refresh user information
        print('User logged in, refresh entitlements');
    }
});
```

### User Logout

To sign out a user:

```dart
// Logout user (clears user ID and custom attributes)
Purchasely.userLogout();
```

### Login from Paywall

To handle the login button on the paywall:

```dart
Purchasely.setPaywallActionInterceptorCallback(
    (PaywallActionInterceptorResult result) {
    if (result.action == PLYPaywallAction.login) {
        print('User wants to login');
        // Present your own screen for user to log in
        Purchasely.closePresentation();
        Purchasely.userLogin('MY_USER_ID');
        // Call this method to update Purchasely Paywall
        Purchasely.onProcessAction(true);
    } else {
        Purchasely.onProcessAction(true);
    }
});
```

---

## Subscription Status & Entitlements

### Retrieve User Subscriptions

Purchasely offers a way to retrieve active subscriptions directly from your mobile app:

```dart
try {
    List<PLYSubscription> subscriptions = await Purchasely.userSubscriptions();
    print('==> Subscriptions');
    if (subscriptions.isNotEmpty) {
        print(subscriptions.first.plan);
        print(subscriptions.first.subscriptionSource);
        print(subscriptions.first.nextRenewalDate);
        print(subscriptions.first.cancelledDate);
    }
} catch (e) {
    print(e);
}
```

> **Note**: There is a **few seconds delay** for `Purchasely.userSubscriptions()` to be updated after a purchase or restoration. If you rely on this method to get the current subscription status right after a purchase, you should **wait for 3 seconds** before calling this method.

---

## Custom User Attributes

Custom User Attributes allow you to segment users and personalize their journey.

### Supported Types

- `String`
- `Int`
- `Double` (Float)
- `Bool`
- `Date` (DateTime)
- `Array of Strings`

### Setting Attributes

```dart
// Set individual attributes
Purchasely.setUserAttributeWithString('stringKey', 'StringValue');
Purchasely.setUserAttributeWithInt('intKey', 3);
Purchasely.setUserAttributeWithDouble('doubleKey', 1.2);
Purchasely.setUserAttributeWithBoolean('booleanKey', true);
Purchasely.setUserAttributeWithDate('dateKey', DateTime.now());
```

### Retrieving Attributes

```dart
// Set an attribute first
Purchasely.setUserAttributeWithInt('age', 21);

// Retrieve a specific attribute
dynamic ageAttribute = await Purchasely.userAttribute('age');
print('Age: $ageAttribute');

// Get all attributes
Map<dynamic, dynamic> attributes = await Purchasely.userAttributes();
attributes.forEach((key, value) {
    print('Attribute $key is $value');
});
```

### Incrementing / Decrementing Counters

```dart
// Increment a user attribute
// Increment by 1, it will be created if not set
Purchasely.incrementUserAttribute('viewed_articles');
// You can also set a specific number to increment
Purchasely.incrementUserAttribute('viewed_articles', value: 3);

// Decrement a user attribute
// Decrement by 1, it will be created if not set
Purchasely.decrementUserAttribute('viewed_articles');
// You can also set a specific number to decrement
Purchasely.decrementUserAttribute('viewed_articles', value: 7);
```

### Clearing Attributes

```dart
// Remove one attribute
Purchasely.clearUserAttribute('dateKey');

// Remove all attributes
Purchasely.clearUserAttributes();
```

> **Note**: `Purchasely.userLogout()` will automatically clear all custom user attributes unless you call `Purchasely.userLogout(false)`.

---

## Event Listeners

### UI / SDK Events Listener

When users interact with Purchasely Screens, the SDK triggers events. Implement an event listener to forward these events to analytics platforms.

```dart
Purchasely.listenToEvents().listen((event) {
    print('Event received: ${event.name}');
    print('Event properties: ${event.properties}');

    // Forward to your analytics platform
    // Analytics.track(event.name, event.properties);
});
```

### Custom User Attributes Listener

The `PLYUserAttributeSource` enum indicates where the user attribute update originated:

```dart
enum PLYUserAttributeSource {
    purchasely,
    client,
}
```

- **purchasely**: The change was initiated internally by the Purchasely SDK (e.g., from surveys)
- **client**: The change was triggered directly by your app

> **Note**: When your app sets a Custom User Attribute, the listener will be called with `source` set to `client`. You can ignore these events to avoid processing data you already have.

---

## Pre-fetching Screens

Pre-fetch paywalls from the network before displaying them for a better user experience.

### Benefits

- Display the Screen only after it has been loaded
- Handle network errors gracefully
- Show a custom loading screen
- Pre-load during app navigation

### Implementation

```dart
try {
    var presentation = await Purchasely.fetchPresentation('ONBOARDING');

    if (presentation == null) {
        print('No presentation found');
        return;
    }

    if (presentation.type == PLYPresentationType.deactivated) {
        // No Screen to display
        return;
    }

    if (presentation.type == PLYPresentationType.client) {
        // Display my own Screen
        var planIds = presentation.plans;
        return;
    }

    // Display Purchasely Screen
    var presentResult = await Purchasely.presentPresentation(
        presentation,
        isFullscreen: false,
    );

    switch (presentResult.result) {
        case PLYPurchaseResult.cancelled:
            print('User cancelled purchased');
            break;
        case PLYPurchaseResult.purchased:
            print('User purchased ${presentResult.plan?.name}');
            break;
        case PLYPurchaseResult.restored:
            print('User restored ${presentResult.plan?.name}');
            break;
    }
} catch (e) {
    print(e);
}
```

### Presentation Types

| Type | Description |
|------|-------------|
| `PLYPresentationType.normal` | Default Purchasely paywall |
| `PLYPresentationType.fallback` | Fallback paywall (requested one not found) |
| `PLYPresentationType.deactivated` | No paywall for this placement |
| `PLYPresentationType.client` | Your own paywall (BYOS) |

---

## Deeplinks Management

To enable Purchasely to display screens via deeplinks, you need to:

1. Pass the deeplink to the Purchasely SDK
2. Allow the display when your app is ready
3. Set a default presentation handler

### Passing the Deeplink

```dart
Purchasely.handle('app://ply/presentations/')
    .then((value) => print('Deeplink handled by Purchasely? $value'));
```

### Forbidding the Display

By **default**, deeplinks are displayed **immediately**. To defer them (e.g. during a splash screen, onboarding or login), prevent the display and re-enable it once you are ready:

```dart
Purchasely.allowDeeplink(false);
// later, once your app is ready
Purchasely.allowDeeplink(true);
```

Campaigns follow the same principle through `allowCampaigns` (also `true` by default): `Purchasely.allowCampaigns(false)` / `Purchasely.allowCampaigns(true)`.

### Setting the Default Presentation Handler

Retrieve the result of user actions on paywalls opened via deeplinks:

```dart
Purchasely.setDefaultPresentationResultCallback((result) {
    print('Presentation View Result: ${result.result}');

    if (result.plan != null) {
        print('Plan Vendor ID: ${result.plan.vendorId}');
        print('Plan Name: ${result.plan.name}');
    }
});
```

---

## Platform-Specific Features

### StoreKit Selection (iOS)

Choose between StoreKit 1 and StoreKit 2 for iOS:

```dart
await Purchasely.start(
    apiKey: 'YOUR_API_KEY',
    storeKit1: false, // false = StoreKit 2, true = StoreKit 1
    // ...
);
```

> **Recommendation**: Use StoreKit 2 (`storeKit1: false`) for new integrations.

### Android Stores

Purchasely supports multiple Android stores:

```dart
await Purchasely.start(
    apiKey: 'YOUR_API_KEY',
    androidStores: ['Google'], // Options: 'Google', 'Huawei', 'Amazon'
    // ...
);
```

To use multiple stores:

```dart
androidStores: ['Google', 'Huawei']
```

> **Note**: Install the corresponding dependencies for each store you want to support.

### Android-Specific Purchase Parameters

When intercepting purchases on Android, you can access additional parameters:

```dart
if (Platform.isAndroid) {
    String basePlanId = result.parameters.subscriptionOffer?.basePlanId;
    String offerId = result.parameters.subscriptionOffer?.offerId;
    String offerToken = result.parameters.subscriptionOffer?.offerToken;
}
```

---

## Troubleshooting

### Common Issues

1. **SDK not configured**: Ensure you call `Purchasely.start()` before any other SDK methods.

2. **Purchases not working**: Verify that you've added the correct store dependencies and they're all at the same version.

3. **Paywall not displaying**: Check that:
   - The placement exists in your Purchasely Console
   - The SDK is properly initialized
   - You have an active internet connection

4. **iOS pod install issues**: Ensure your iOS deployment target is set to at least 11.0 in your Podfile.

### Debug Mode

Enable debug logging during development:

```dart
await Purchasely.start(
    apiKey: 'YOUR_API_KEY',
    logLevel: PLYLogLevel.debug, // Use error in production
    // ...
);
```

---

## Additional Resources

- [Purchasely Console](https://console.purchasely.io)
- [Pub.dev Package](https://pub.dev/packages/purchasely_flutter)
- [Purchasely Documentation](https://docs.purchasely.com)
