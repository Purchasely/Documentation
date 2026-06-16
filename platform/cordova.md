# Purchasely Cordova SDK Documentation

This document provides comprehensive documentation for integrating and using the Purchasely Cordova SDK with JavaScript.

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

Install the Purchasely Cordova SDK via NPM:

```shell
cordova plugin add @purchasely/cordova-plugin-purchasely
```

### iOS Setup

Update your Podfile to set the minimum iOS version:

```yaml
// Podfile

...

platform :ios, '13.4'

...
```

### Android Setup

Update your `android/build.gradle` file:

```groovy
// Edit file android/build.gradle
buildscript {
    ext {
        minSdkVersion = 23 //min version must not be below 23
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

> ⚠️ **Important**: The main Purchasely SDK (`@purchasely/cordova-plugin-purchasely`) does **NOT** include store implementations by default. This modular architecture allows you to include only the stores you need and avoid dependency conflicts.

With Android, you can choose to use Google Play Store and/or Huawei AppGallery and/or Amazon Appstore. **You must install the corresponding dependency for each store you want to support.**

#### Google Play Billing (Required for Google Play Store)

If your app is distributed on the **Google Play Store**, you **must** install the Google Play Billing dependency:

```shell
cordova plugin add @purchasely/cordova-plugin-purchasely-google
```

**Why is this required?**
- The Purchasely core SDK does not include the Google Play Billing library
- When you specify `['Google']` as the stores parameter in initialization, the SDK looks for this dependency at runtime
- Without this dependency, purchases will not work on Android devices using Google Play Store
- The app may crash or fail to initialize properly on Android

#### Version Matching (Critical)

> ⚠️ **All Purchasely packages must be at the exact same version.** Mismatched versions will cause runtime errors or unexpected behavior.

```json
// package.json
"dependencies": {
  "@purchasely/cordova-plugin-purchasely": "5.0.0",
  "@purchasely/cordova-plugin-purchasely-google": "5.0.0"
}
```

#### Complete Android Installation Example

For a typical app distributed on Google Play Store:

```shell
# Install all required dependencies
cordova plugin add @purchasely/cordova-plugin-purchasely
cordova plugin add @purchasely/cordova-plugin-purchasely-google
```

Then initialize with the Google store:

```javascript
Purchasely.startWithAPIKey(
    'YOUR_API_KEY',
    ['Google'], // Requires @purchasely/cordova-plugin-purchasely-google
    false, // false for StoreKit 2, true for StoreKit 1
    null,
    Purchasely.LogLevel.DEBUG,
    Purchasely.RunningMode.full
);
```

---

## SDK Initialization

Initialize the Purchasely SDK as early as possible in your application lifecycle.

### Full Mode (Recommended)

In `full` mode, Purchasely handles the entire purchase flow including transactions and receipts.

```javascript
/**
 * @params String apiKey
 * @params StringArray stores : may be Google, Amazon and Huawei
 * @params Boolean storeKit1 : true for StoreKit 1, false for StoreKit 2
 * @params String userId
 * @params Purchasely.LogLevel logLevel
 * @params Purchasely.RunningMode runningMode
 **/
Purchasely.startWithAPIKey(
    'YOUR_API_KEY',
    ['Google'],
    false, // false for StoreKit 2, true for StoreKit 1
    null, // user id if user is connected
    Purchasely.LogLevel.DEBUG, // set to ERROR in production
    Purchasely.RunningMode.full
);
```

### PaywallObserver Mode

Use `paywallObserver` mode if you have an existing in-app purchase infrastructure and want to use Purchasely only for paywall display and analytics.

```javascript
Purchasely.startWithAPIKey(
    'YOUR_API_KEY',
    ['Google'],
    false, // false for StoreKit 2, true for StoreKit 1
    null, // user id of user
    Purchasely.LogLevel.DEBUG,
    Purchasely.RunningMode.paywallObserver
);
```

### API Key

You can find your API Key in the Purchasely Console under **App settings > Backend & SDK configuration**.

---

## Displaying Paywalls

Purchasely paywalls are displayed using **placements**. A placement is a specific location in your app where you want to display a paywall (e.g., onboarding, settings, premium feature).

### Display a Placement

```javascript
Purchasely.presentPresentationForPlacement(
    'ONBOARDING', // placementId
    null, // contentId (optional)
    true, // fullscreen
    (callback) => {
        if (callback.result == Purchasely.PurchaseResult.PURCHASED) {
            console.log('User purchased ' + callback.plan.name);
            // Update entitlements to unlock content
        } else if (callback.result == Purchasely.PurchaseResult.RESTORED) {
            console.log('User restored his purchases');
            // Update entitlements to unlock content
        } else if (callback.result == Purchasely.PurchaseResult.CANCELLED) {
            console.log('User cancelled purchased');
        }
    },
    (error) => {
        console.log('Error with purchase: ' + error);
    }
);
```

### Display Results

After displaying a placement, you receive a result indicating the user's action:

- `Purchasely.PurchaseResult.PURCHASED`: User purchased a plan
- `Purchasely.PurchaseResult.RESTORED`: User restored a previous purchase
- `Purchasely.PurchaseResult.CANCELLED`: User did not complete a purchase

---

## Processing Transactions

### Full Mode

In `full` mode, the Purchasely SDK automatically launches the native in-app purchase flow when a user clicks on a purchase button and handles the transaction. You only need to update entitlements once you have confirmation that the purchase was processed.

```javascript
Purchasely.presentPresentationForPlacement(
    'onboarding', // placementId
    null, // contentId
    true, // fullscreen
    (callback) => {
        if (callback.result == Purchasely.PurchaseResult.PURCHASED) {
            console.log('User purchased ' + callback.plan.name);
            // Update entitlements to unlock the access to the contents
        } else if (callback.result == Purchasely.PurchaseResult.RESTORED) {
            console.log('User restored his purchases');
            // Update entitlements to unlock the access to the contents
        } else if (callback.result == Purchasely.PurchaseResult.CANCELLED) {
            console.log('User cancelled purchased');
        }
    },
    (error) => {
        console.log('Error with purchase: ' + error);
    }
);
```

### PaywallObserver Mode with Action Interceptor

In `paywallObserver` mode, you handle purchases with your own infrastructure while using Purchasely for paywall display.

```javascript
Purchasely.setPaywallActionInterceptorCallback((result) => {
    if (result.action === Purchasely.PaywallAction.purchase) {
        // The store product id (sku) the user clicked on in the paywall
        const storeProductId = result.parameters.plan.productId;

        MyPurchaseSystem.purchase(storeProductId, ({ success, error }) => {
            if (success) {
                // Synchronize all purchases with Purchasely
                Purchasely.synchronize();
            }
            // Notify Purchasely paywall to stop processing action
            Purchasely.onProcessAction(false);
        }, ({ error, userCancelled }) => {
            // Error making purchase
            Purchasely.onProcessAction(false);
        });
    } else if (result.action === Purchasely.PaywallAction.restore) {
        MyPurchaseSystem.restoreTransactions(
            info => {
                // Synchronize all purchases with Purchasely
                Purchasely.synchronize();
                // Notify Purchasely paywall to stop processing action
                Purchasely.onProcessAction(false);
            },
            error => {
                // Error restoring purchases
                // Notify Purchasely paywall to stop processing action
                Purchasely.onProcessAction(false);
            }
        );
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
| `Purchasely.PaywallAction.purchase` | User tapped a purchase button |
| `Purchasely.PaywallAction.restore` | User tapped the restore button |
| `Purchasely.PaywallAction.login` | User tapped the login button |
| `Purchasely.PaywallAction.close` | User tapped the close button |
| `Purchasely.PaywallAction.navigate` | User wants to navigate to an external URL |
| `Purchasely.PaywallAction.open_presentation` | User wants to open another presentation |

### Implementation

```javascript
Purchasely.setPaywallActionInterceptor((result) => {
    console.log('Received action from paywall' + result.info.presentationId);

    if (result.action === Purchasely.PaywallAction.navigate) {
        console.log(
            'User wants to navigate to website ' +
            result.parameters.title + ' ' + result.parameters.url
        );
        Purchasely.onProcessAction(true);
    } else if (result.action === Purchasely.PaywallAction.close) {
        console.log('User wants to close paywall');
        Purchasely.onProcessAction(true);
    } else if (result.action === Purchasely.PaywallAction.login) {
        console.log('User wants to login');
        // Present your own screen for user to log in
        Purchasely.closePresentation();
        Purchasely.userLogin('MY_USER_ID');
        // Call this method to update Purchasely Paywall
        Purchasely.onProcessAction(true);
    } else if (result.action === Purchasely.PaywallAction.open_presentation) {
        console.log('User wants to open a new paywall');
        Purchasely.onProcessAction(true);
    } else if (result.action === Purchasely.PaywallAction.purchase) {
        console.log('User wants to purchase');
        // If you want to intercept it, close presentation and display your screen
        Purchasely.closePresentation();
    } else if (result.action === Purchasely.PaywallAction.restore) {
        console.log('User wants to restore his purchases');
        Purchasely.onProcessAction(true);
    } else {
        console.log('Action unknown ' + result.action);
        Purchasely.onProcessAction(true);
    }
});
```

> **Important**: Always call `Purchasely.onProcessAction(true/false)` to notify the SDK whether to continue processing the action.

---

## User Identification

### Anonymous Users

The Purchasely SDK automatically generates and assigns an `anonymous_user_id` to each user, maintaining consistency as long as the app remains installed on the device.

```javascript
// Get the anonymous user ID
Purchasely.getAnonymousUserId((anonymousId) => {
    console.log('Purchasely anonymous Id: ' + anonymousId);
});
```

### User Login

To authenticate users and associate purchases with their account:

```javascript
// Login with user ID
Purchasely.userLogin('123456789', (shouldRefresh) => {
    if (shouldRefresh) {
        // You should call your backend to refresh user entitlements
        console.log('User logged in, refresh entitlements');
    }
});
```

### User Logout

To sign out a user:

```javascript
// Logout user (clears user ID and custom attributes)
Purchasely.userLogout();
```

### Login from Paywall

To handle the login button on the paywall:

```javascript
Purchasely.setPaywallActionInterceptorCallback((result) => {
    if (result.action === Purchasely.PaywallAction.login) {
        console.log('User wants to login');
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

```javascript
Purchasely.userSubscriptions(subscriptions => {
    console.log('Subscriptions ' + subscriptions);
}, (error) => {
    console.log(error);
});
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

> **Note**: Date and Array types have limited support in Cordova.

### Setting Attributes

```javascript
// Set individual attributes
Purchasely.setUserAttributeWithString('key_string', 'value_string');
Purchasely.setUserAttributeWithBoolean('key_boolean', true);
Purchasely.setUserAttributeWithInt('key_int', 7);
Purchasely.setUserAttributeWithDouble('key_double', 4.5);
```

### Retrieving Attributes

```javascript
// Retrieve a specific attribute
Purchasely.userAttribute('key_string', value => {
    console.log('User attribute string: ' + value);
});
```

### Incrementing / Decrementing Counters

The increment/decrement methods are not directly available in Cordova, but you can achieve the same result:

```javascript
// Increment a user attribute manually
Purchasely.userAttribute('viewed_articles', value => {
    Purchasely.setUserAttributeWithInt('viewed_articles', value + 1);
});
```

### Clearing Attributes

```javascript
// Remove one attribute
Purchasely.clearUserAttribute('key_string');

// Remove all attributes
Purchasely.clearUserAttributes();
```

> **Note**: `Purchasely.userLogout()` will automatically clear all custom user attributes unless you call `Purchasely.userLogout(false)`.

---

## Event Listeners

### UI / SDK Events Listener

When users interact with Purchasely Screens, the SDK triggers events. Implement an event listener to forward these events to analytics platforms.

```javascript
Purchasely.addEventListener((event) => {
    console.log('Event received: ' + event.name);
    console.log('Event properties: ' + JSON.stringify(event.properties));

    // Forward to your analytics platform
    // Analytics.track(event.name, event.properties);
});
```

---

## Pre-fetching Screens

Pre-fetch paywalls from the network before displaying them for a better user experience.

### Benefits

- Display the Screen only after it has been loaded
- Handle network errors gracefully
- Show a custom loading screen
- Pre-load during app navigation

### Implementation

```javascript
Purchasely.fetchPresentationForPlacement(
    'ONBOARDING', // placementId
    null, // contentId
    (presentation) => {
        // Use the "presentation" object from the callback
        Purchasely.presentPresentation(
            presentation,
            false, // isFullscreen
            null, // loadedCallback
            (callback) => {
                if (callback.result == Purchasely.PurchaseResult.CANCELLED) {
                    console.log('User cancelled purchased');
                } else {
                    console.log('User purchased ' + callback.plan.name);
                }
            },
            (error) => {
                console.log('Error with present: ' + error);
            }
        );
    },
    (error) => {
        console.log('Error with purchase: ' + error);
    }
);
```

### Presentation Types

| Type | Description |
|------|-------------|
| `NORMAL` | Default Purchasely paywall |
| `FALLBACK` | Fallback paywall (requested one not found) |
| `DEACTIVATED` | No paywall for this placement |
| `CLIENT` | Your own paywall (BYOS) |

---

## Deeplinks Management

To enable Purchasely to display screens via deeplinks, you need to:

1. Pass the deeplink to the Purchasely SDK
2. Allow the display when your app is ready
3. Set a default presentation handler

### Passing the Deeplink

```javascript
// If you grab the deeplink inside your Cordova code you can call
Purchasely.handle('app://ply/presentations/', (handled) => {
    console.log('Was deeplink handled by Purchasely? ' + handled);
});
```

### Forbidding the Display

By **default**, deeplinks are displayed **immediately**. To defer them (e.g. during a splash screen, onboarding or login), prevent the display and re-enable it once you are ready:

```javascript
Purchasely.allowDeeplink(false);
// later, once your app is ready
Purchasely.allowDeeplink(true);
```

Campaigns follow the same principle through `allowCampaigns` (also `true` by default): `Purchasely.allowCampaigns(false)` / `Purchasely.allowCampaigns(true)`.

### Setting the Default Presentation Handler

Retrieve the result of user actions on paywalls opened via deeplinks:

```javascript
Purchasely.setDefaultPresentationResultHandler((result) => {
    console.log('Presentation View Result: ' + result.result);

    if (result.plan != null) {
        console.log('Plan Vendor ID: ' + result.plan.vendorId);
        console.log('Plan Name: ' + result.plan.name);
    }
});
```

---

## Platform-Specific Features

### StoreKit Selection (iOS)

Choose between StoreKit 1 and StoreKit 2 for iOS:

```javascript
Purchasely.startWithAPIKey(
    'YOUR_API_KEY',
    ['Google'],
    false, // false = StoreKit 2, true = StoreKit 1
    // ...
);
```

> **Recommendation**: Use StoreKit 2 (`false`) for new integrations.

### Android Stores

Purchasely supports multiple Android stores:

```javascript
Purchasely.startWithAPIKey(
    'YOUR_API_KEY',
    ['Google'], // Options: 'Google', 'Huawei', 'Amazon'
    // ...
);
```

To use multiple stores:

```javascript
['Google', 'Huawei']
```

> **Note**: Install the corresponding dependencies for each store you want to support.

---

## Troubleshooting

### Common Issues

1. **SDK not configured**: Ensure you call `Purchasely.startWithAPIKey()` before any other SDK methods.

2. **Purchases not working**: Verify that you've added the correct store dependencies and they're all at the same version.

3. **Paywall not displaying**: Check that:
   - The placement exists in your Purchasely Console
   - The SDK is properly initialized
   - You have an active internet connection

4. **iOS issues**: Ensure your iOS deployment target is set to at least 11.0.

### Debug Mode

Enable debug logging during development:

```javascript
Purchasely.startWithAPIKey(
    'YOUR_API_KEY',
    ['Google'],
    false,
    null,
    Purchasely.LogLevel.DEBUG, // Use ERROR in production
    Purchasely.RunningMode.full
);
```

---

## Additional Resources

- [Purchasely Console](https://console.purchasely.io)
- [NPM Package](https://www.npmjs.com/package/@purchasely/cordova-plugin-purchasely)
- [Purchasely Documentation](https://docs.purchasely.com)
