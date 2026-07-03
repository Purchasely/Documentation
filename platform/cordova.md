# Purchasely Cordova SDK Documentation

This guide covers the Purchasely **Cordova** SDK **v6** for JavaScript apps. Purchasely displays **Screens** and **Presentations** configured in the Console through placements, direct `presentationId` lookups, campaigns, and deeplinks. The Cordova plugin bridges to the native iOS and Android Purchasely SDKs through `cordova.exec`.

> 📘 SDK v6 — what changed
>
> v6 is a major release with breaking changes. Unlike the native iOS/Android and the React Native / Flutter SDKs, the **Cordova JavaScript surface stays method-based and almost unchanged** — the native bridges were rewired to the v6 SDKs behind the existing `cordova.exec` actions. The breaking changes a host app must apply are: the **default running mode is now `Observer`** (set `RunningMode.full` to let Purchasely handle purchases), the deeplink methods were renamed (`allowDeeplink` / `handleDeeplink`), `setDefaultPresentationResultHandler` became `setDefaultPresentationDismissHandler`, `synchronize` now reports completion, and `presentSubscriptions` is a no-op. See the [v5→v6 migration guide](https://docs.purchasely.com/migrating-from-v5-to-v6-cordova).

---

## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
3. [SDK Initialization](#sdk-initialization)
4. [Displaying Paywalls](#displaying-paywalls)
5. [Action Interceptor](#action-interceptor)
6. [Processing Transactions](#processing-transactions)
7. [Pre-fetching Screens](#pre-fetching-screens)
8. [Default Presentation Dismiss Handler](#default-presentation-dismiss-handler)
9. [User Identification](#user-identification)
10. [Subscription Status & Entitlements](#subscription-status--entitlements)
11. [Custom User Attributes](#custom-user-attributes)
12. [Event Listeners](#event-listeners)
13. [Deeplinks Management](#deeplinks-management)
14. [Platform-Specific Features](#platform-specific-features)
15. [Troubleshooting](#troubleshooting)
16. [Additional Resources](#additional-resources)

---

## Requirements

| Requirement | iOS | Android |
|-------------|-----|---------|
| Minimum OS version | 13.4 | API 23 |
| compileSdkVersion | — | 36 |
| targetSdkVersion | — | 35 |
| Cordova | `cordova` ≥ 11 | `cordova-android` ≥ 12 |

The v6 native Android SDK is built with Kotlin 2.2.x and `compileSdk 36`; make sure your Cordova Android toolchain provides them (see [Android Setup](#android-setup)).

---

## Installation

The Purchasely Cordova SDK is split into two plugins. **Both must be pinned to the exact same version.**

```shell
cordova plugin add @purchasely/cordova-plugin-purchasely@6.0.0-rc.2
cordova plugin add @purchasely/cordova-plugin-purchasely-google@6.0.0-rc.2
```

| Plugin | Purpose |
|--------|---------|
| `@purchasely/cordova-plugin-purchasely` | Main plugin (iOS + Android). Required. |
| `@purchasely/cordova-plugin-purchasely-google` | Google Play Billing support on Android. Required for purchases on the Google Play Store. |

These plugins pull the native SDKs:

| Platform | Native artifact |
|----------|-----------------|
| iOS | `pod 'Purchasely', '6.0.0-rc.2'` (CocoaPods) |
| Android | `io.purchasely:core:6.0.0-rc.2` + `io.purchasely:google-play:6.0.0-rc.2` (Maven Central) |

> There is **no video player plugin on Cordova** — the `io.purchasely:player` artifact is not bridged.

### iOS Setup

Set the minimum iOS version in your `Podfile`:

```ruby
# platforms/ios/Podfile
platform :ios, '13.4'
```

### Android Setup

Make sure your project resolves dependencies from Maven Central and targets the SDK levels required by v6:

```groovy
// android build.gradle
buildscript {
    ext {
        minSdkVersion = 23      // must not be below 23
        compileSdkVersion = 36
        targetSdkVersion = 35
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```

> 📘 Google Play Billing
>
> `@purchasely/cordova-plugin-purchasely-google` pulls Google Play Billing Client v8 (`com.android.billingclient:billing:8.x`) transitively. Do not force an older billing dependency into your project.

### Android Dependencies

> ⚠️ The main plugin (`@purchasely/cordova-plugin-purchasely`) does **NOT** include store implementations by default. This modular architecture lets you include only the stores you need and avoids dependency conflicts. When you pass `['Google']` as the stores parameter, the SDK looks for the Google Play Billing dependency at runtime — without it, purchases fail on Android.

#### Version matching (critical)

> ⚠️ **Every `io.purchasely:*` dependency must resolve to the same version.** A stray `6.0.0` (release) ranks *above* `6.0.0-rc.2` in Gradle and silently upgrades `core`, producing a `NoSuchMethodError` at runtime. Keep both plugins on the same pre-release string.

```json
// package.json
"dependencies": {
  "@purchasely/cordova-plugin-purchasely": "6.0.0-rc.2",
  "@purchasely/cordova-plugin-purchasely-google": "6.0.0-rc.2"
}
```

### API Key

Find your API key in the Console under [App settings / Backend & SDK configuration](https://console.purchasely.io/settings?step=backend-sdk).

---

## SDK Initialization

Initialize Purchasely as early as possible in your app lifecycle (e.g. on `deviceready`). `start()` does not block, so you can call other SDK methods right after.

```javascript
/**
 * @param {string}  apiKey
 * @param {string[]} stores      may contain 'Google', 'Amazon', 'Huawei'
 * @param {boolean} storeKit1    iOS only — true = StoreKit 1, false = StoreKit 2
 * @param {string}  userId       your user id, or null for anonymous
 * @param {number}  logLevel     Purchasely.LogLevel.*
 * @param {number}  runningMode  Purchasely.RunningMode.full | .observer
 */
Purchasely.start(
    'YOUR_API_KEY',
    ['Google'],
    false,                        // false = StoreKit 2 (recommended), true = StoreKit 1
    null,                         // user id if the user is already known
    Purchasely.LogLevel.DEBUG,    // set to ERROR in production
    Purchasely.RunningMode.full,  // ⚠️ default is now Observer — set .full to handle purchases
    (isConfigured) => {
        // Purchasely is started
    },
    (error) => {
        console.error('Purchasely start failed: ' + error);
    }
);
```

### Running modes

> 🚧 Major v6 change — the default running mode is now `Observer`
>
> In v5 the implicit default was `Full`. In **v6 the native default is `Observer`** (Purchasely observes transactions but does not process them). **If you want Purchasely to handle the purchase flow and validate receipts, you must pass `Purchasely.RunningMode.full` explicitly.** In `Observer` mode, presentations **no longer auto-close** after a purchase or restore — close them yourself (see [Processing Transactions](#processing-transactions)).

| Mode | Value | Use when |
|------|-------|----------|
| `Purchasely.RunningMode.full` | `3` | Purchasely handles store purchases and receipt validation. Pass this explicitly. |
| `Purchasely.RunningMode.observer` | `2` | Your app owns purchases; Purchasely observes transactions and displays Console-driven Screens. |

> ⚠️ `Purchasely.RunningMode.observer` was **removed** in v6 — use `Purchasely.RunningMode.observer` (same value `2`).

### Log levels

`Purchasely.LogLevel.DEBUG` `INFO` `WARN` `ERROR`. Use `DEBUG` during integration and `ERROR` in production.

---

## Displaying Paywalls

Purchasely paywalls are displayed through **placements**. A placement is a logical location in your app (onboarding, settings, a premium feature…) that the Console maps to a Screen, an A/B test, or a campaign.

### Display a placement

```javascript
Purchasely.presentPresentationForPlacement(
    'ONBOARDING', // placementId
    null,         // contentId (optional)
    true,         // fullscreen
    (outcome) => {
        if (outcome.result == Purchasely.PurchaseResult.PURCHASED) {
            console.log('User purchased ' + (outcome.plan && outcome.plan.name));
            // Update entitlements to unlock content
        } else if (outcome.result == Purchasely.PurchaseResult.RESTORED) {
            console.log('User restored their purchases');
            // Update entitlements to unlock content
        } else if (outcome.result == Purchasely.PurchaseResult.CANCELLED) {
            console.log('User cancelled');
        }
    },
    (error) => {
        console.log('Error displaying paywall: ' + error);
    }
);
```

### Display a specific Screen

```javascript
Purchasely.presentPresentationWithIdentifier(
    'screen_abc123', // presentationId (Console Screen id)
    null,            // contentId
    true,            // fullscreen
    (outcome) => { /* … */ },
    (error) => { /* … */ }
);
```

### The display outcome

The success callback receives an outcome object:

| Field | Description |
|-------|-------------|
| `result` | `Purchasely.PurchaseResult.PURCHASED` (`0`), `CANCELLED` (`1`), or `RESTORED` (`2`). |
| `plan` | The purchased/restored plan (`vendorId`, `name`, …) when applicable. |
| `purchaseResult` | String form: `'purchased'` \| `'cancelled'` \| `'restored'` \| `null`. |
| `closeReason` | Why the Screen closed: `'button'`, `'back_system'` (Android), `'interactiveDismiss'` (iOS), `'programmatic'`, or `null`. |
| `presentation` | The presentation that produced the outcome (`screenId`, `placementId`, `campaignId`, …). |

---

## Action Interceptor

Intercept user actions on a paywall to run your own logic (custom login, custom purchase flow, analytics…). Register one interceptor; respond to **every** intercepted action with `Purchasely.onProcessAction(true|false)`:

* `onProcessAction(true)` — let Purchasely proceed with its default behavior.
* `onProcessAction(false)` — you handled the action; Purchasely stops processing it.

```javascript
Purchasely.setPaywallActionInterceptor((result) => {
    console.log('Action from paywall ' + result.info.presentationId);

    switch (result.action) {
        case Purchasely.PaywallAction.navigate:
            console.log('Navigate to ' + result.parameters.title + ' ' + result.parameters.url);
            Purchasely.onProcessAction(true);
            break;

        case Purchasely.PaywallAction.login:
            // Present your own login screen, then update Purchasely
            Purchasely.closePresentation();
            Purchasely.userLogin('MY_USER_ID', () => {});
            Purchasely.onProcessAction(true);
            break;

        case Purchasely.PaywallAction.purchase:
            // To intercept the purchase, close the paywall and show your own flow
            Purchasely.closePresentation();
            break;

        default:
            Purchasely.onProcessAction(true);
            break;
    }
});
```

### Available actions

| Action | Description |
|--------|-------------|
| `Purchasely.PaywallAction.purchase` | User tapped a purchase button. |
| `Purchasely.PaywallAction.restore` | User tapped restore. |
| `Purchasely.PaywallAction.login` | User tapped the *Already subscribed? Sign-in* button. |
| `Purchasely.PaywallAction.close` | User tapped close. |
| `Purchasely.PaywallAction.close_all` | Close all Purchasely Screens. |
| `Purchasely.PaywallAction.navigate` | Navigate to an external URL (`parameters.url`, `parameters.title`). |
| `Purchasely.PaywallAction.open_presentation` | Open another presentation. |
| `Purchasely.PaywallAction.open_placement` | Open another placement. |
| `Purchasely.PaywallAction.promo_code` | Redeem a promo code. |
| `Purchasely.PaywallAction.web_checkout` | Open a web checkout. |

> **Important**: always call `Purchasely.onProcessAction(true|false)` after handling an action, or the paywall stays blocked.

---

## Processing Transactions

### Full mode

In `Full` mode the SDK launches the native purchase flow automatically when the user taps a purchase button, validates the receipt, and manages the transaction. You only need to react to the display outcome and refresh your entitlements.

### Observer mode

In `Observer` mode you run purchases with your own billing system and use Purchasely for the paywall UI. Intercept `purchase` / `restore` and run your flow; when you acknowledge success the SDK calls `synchronize()` automatically so Purchasely receives the transaction, and close the paywall yourself (Observer mode does not auto-close):

```javascript
Purchasely.setPaywallActionInterceptor((result) => {
    if (result.action === Purchasely.PaywallAction.purchase) {
        const storeProductId = result.parameters.plan.productId;

        MyPurchaseSystem.purchase(storeProductId,
            () => {
                // SDK auto-synchronizes on success in observer mode
                Purchasely.onProcessAction(false); // you handled the purchase
                Purchasely.closePresentation();    // Observer mode does not auto-close
            },
            () => {
                Purchasely.onProcessAction(false);
            }
        );
    } else if (result.action === Purchasely.PaywallAction.restore) {
        MyPurchaseSystem.restore(
            () => {
                // SDK auto-synchronizes on success in observer mode
                Purchasely.onProcessAction(false);
                Purchasely.closePresentation();
            },
            () => Purchasely.onProcessAction(false)
        );
    } else {
        Purchasely.onProcessAction(true);
    }
});
```

### `synchronize` reports completion

In v6, `synchronize` accepts optional success / error callbacks and resolves when the native synchronization completes (the v5 fire-and-forget behavior is gone). Calling `Purchasely.synchronize()` with no arguments still works. Call this manually for transactions completed outside the interceptor (the SDK already auto-syncs when you acknowledge success for a purchase or restore in observer mode).

```javascript
Purchasely.synchronize(
    () => console.log('Purchasely synchronized'),
    (error) => console.error('Sync failed: ' + error)
);
```

### Programmatic purchase & restore

```javascript
// Purchase a plan directly by its Console vendor id
Purchasely.purchaseWithPlanVendorId(
    'PURCHASELY_PLUS_YEARLY', // plan vendor id
    null,                     // offer id (optional)
    null,                     // content id (optional)
    (plan) => console.log('Purchased ' + plan.vendorId),
    (error) => console.error(error)
);

// Restore previous purchases
Purchasely.restoreAllProducts(
    () => console.log('Purchases restored'),
    (error) => console.error(error)
);
```

---

## Pre-fetching Screens

Fetch a Screen from the network before displaying it — useful to display only once loaded, handle network errors gracefully, or pre-load during onboarding.

```javascript
Purchasely.fetchPresentationForPlacement(
    'ONBOARDING', // placementId
    null,         // contentId
    (presentation) => {
        Purchasely.presentPresentation(
            presentation,
            true,  // fullscreen
            null,  // background color (optional)
            (outcome) => {
                if (outcome.result == Purchasely.PurchaseResult.CANCELLED) {
                    console.log('User cancelled');
                } else {
                    console.log('User purchased ' + (outcome.plan && outcome.plan.name));
                }
            },
            (error) => console.log('Error displaying presentation: ' + error)
        );
    },
    (error) => console.log('Error fetching presentation: ' + error)
);
```

You can also fetch by Screen id with `Purchasely.fetchPresentation(presentationId, contentId, success, error)`.

### Presentation types

| Type | Description |
|------|-------------|
| `NORMAL` | The default Purchasely Screen. |
| `FALLBACK` | A Screen, but not the requested one (it could not be found). |
| `DEACTIVATED` | No Screen for this placement (e.g. an A/B test or audience). |
| `CLIENT` | Your own Screen (BYOS) — use the list of plans to build your UI. |

---

## Default Presentation Dismiss Handler

When a Screen is opened by the SDK itself — a **campaign**, a **deeplink**, or a **Promoted In-App Purchase** — your app does not instantiate it, so no per-display callback fires. Register a default dismiss handler to receive the outcome:

```javascript
Purchasely.setDefaultPresentationDismissHandler((outcome) => {
    // `presentation` identifies which campaign/deeplink closed.
    console.log('Dismissed: ' + (outcome.presentation && outcome.presentation.screenId));
    console.log('Purchase: ' + outcome.purchaseResult + ' / close: ' + outcome.closeReason);

    if (outcome.result == Purchasely.PurchaseResult.PURCHASED && outcome.plan != null) {
        console.log('Purchased ' + outcome.plan.vendorId);
        // Update entitlements
    }
});
```

> 📘 Renamed in v6
>
> `setDefaultPresentationDismissHandler` replaces v5's `setDefaultPresentationResultHandler` (breaking change, no alias). The callback now receives a single rich outcome object (`result`, `plan`, `purchaseResult`, `closeReason`, `presentation`) instead of the legacy `(result, plan)` shape.

---

## User Identification

Provide your own user id so purchases and subscriptions follow the user across devices instead of being tied to an anonymous, device-bound id.

```javascript
// Authenticate a user
Purchasely.userLogin('123456789', (shouldRefresh) => {
    if (shouldRefresh) {
        // Call your backend to refresh user entitlements
    }
});

// Sign out — clears the user id and custom attributes
Purchasely.userLogout();
```

Retrieve the auto-generated anonymous id when needed:

```javascript
Purchasely.getAnonymousUserId((anonymousId) => {
    console.log('Anonymous id: ' + anonymousId);
});
```

---

## Subscription Status & Entitlements

Fetch the user's active subscriptions to manage entitlements at the app level:

```javascript
Purchasely.userSubscriptions(
    (subscriptions) => {
        subscriptions.forEach((sub) => {
            console.log('Plan: ' + sub.plan.vendorId);
            console.log('Source: ' + sub.subscriptionSource);
        });
    },
    (error) => console.log(error)
);
```

> **Note**: there is a few-seconds delay before `userSubscriptions()` reflects a purchase or restoration. If you call it right after a purchase, wait ~3 seconds.

Retrieve past (expired) subscriptions for analytics and re-engagement:

```javascript
Purchasely.userSubscriptionsHistory(
    (history) => console.log('Past subscriptions: ' + history.length),
    (error) => console.log(error)
);
```

> 📘 Removed UI in v6
>
> The native subscriptions-list / cancellation UI was removed from both SDKs. `Purchasely.presentSubscriptions()` is now a **no-op** (it logs a warning and does nothing). Build your own management screen from `userSubscriptions()` / `userSubscriptionsHistory()`.

---

## Custom User Attributes

Set, retrieve and clear custom attributes to segment users and build audiences. Each setter takes an optional `DataProcessingLegalBasis` (`essential` / `optional`).

```javascript
// Set attributes
Purchasely.setUserAttributeWithString('favorite_spirit', 'gin', Purchasely.DataProcessingLegalBasis.essential);
Purchasely.setUserAttributeWithBoolean('newsletter', true);
Purchasely.setUserAttributeWithInt('viewed_articles', 7);
Purchasely.setUserAttributeWithDouble('avg_session', 4.5);
Purchasely.setUserAttributeWithDate('signup_date', new Date().toISOString());

// Retrieve an attribute
Purchasely.userAttribute('favorite_spirit', (value) => {
    console.log('favorite_spirit = ' + value);
});

// Increment a counter manually (no native increment method on Cordova)
Purchasely.userAttribute('viewed_articles', (value) => {
    Purchasely.setUserAttributeWithInt('viewed_articles', (value || 0) + 1);
});

// Clear
Purchasely.clearUserAttribute('favorite_spirit');
Purchasely.clearUserAttributes();
```

Array variants are available too: `setUserAttributeWithStringArray`, `setUserAttributeWithIntArray`, `setUserAttributeWithDoubleArray`, `setUserAttributeWithBooleanArray`.

> **Note**: `Purchasely.userLogout()` clears all custom user attributes.

### Third-party attributes

Forward an analytics SDK id to Purchasely with `setAttribute`:

```javascript
Purchasely.setAttribute(Purchasely.Attribute.AMPLITUDE_USER_ID, 'amplitude_user_id');
```

---

## Event Listeners

Forward Purchasely UI/SDK events to your own analytics. Set the listener after starting the SDK.

```javascript
Purchasely.addEventsListener((event) => {
    console.log('Event: ' + event.name);
    console.log('Properties: ' + JSON.stringify(event.properties));
    // Analytics.track(event.name, event.properties);
});

// Remove it when no longer needed
Purchasely.removeEventsListener();
```

UI/SDK events are computed by the Purchasely Platform for conversion KPIs but cannot be routed to third-party integrations from the Console — forward them yourself if you need them in your analytics.

You can also listen for custom user attribute changes (e.g. from in-Screen surveys):

```javascript
Purchasely.addUserAttributeListener((change) => {
    console.log(change.action + ' ' + change.key); // Purchasely.UserAttributeAction.ADD | REMOVE
});
```

---

## Deeplinks Management

To let Purchasely display Screens via deeplinks:

### Pass the deeplink to the SDK

```javascript
Purchasely.handleDeeplink('app_scheme://ply/presentations/', (handled) => {
    console.log('Handled by Purchasely? ' + handled);
});
```

Supported formats (`app_scheme` is your declared URL scheme):

```
app_scheme://ply/presentations/PRESENTATION_ID   // a specific Screen
app_scheme://ply/presentations                   // your default Screen
app_scheme://ply/placements/PLACEMENT_ID          // a placement
app_scheme://ply/placements                       // your default placement
app_scheme://ply/flows/FLOW_ID                    // a Flow
```

### Defer the display

By **default**, deeplink presentations display immediately. To defer them (e.g. during a splash screen, onboarding, or login), turn the flag off and back on when ready:

```javascript
Purchasely.allowDeeplink(false);
// later, once your app is ready
Purchasely.allowDeeplink(true);
```

### Receive the result

Use [`setDefaultPresentationDismissHandler`](#default-presentation-dismiss-handler) to get the outcome of a Screen opened from a deeplink or campaign.

> 📘 Renamed in v6
>
> v5's `readyToOpenDeeplink(bool)` and `isDeeplinkHandled(url, …)` were **removed** — use `allowDeeplink(bool)` and `handleDeeplink(url, success, error)`.

---

## Platform-Specific Features

### StoreKit selection (iOS)

The 3rd `start` argument selects the StoreKit version on iOS — `false` for StoreKit 2 (recommended), `true` for StoreKit 1:

```javascript
Purchasely.start('YOUR_API_KEY', ['Google'], false /* StoreKit 2 */, null,
    Purchasely.LogLevel.DEBUG, Purchasely.RunningMode.full, () => {}, () => {});
```

### Android stores

Pass the store(s) you support in the `stores` array — install the matching dependency for each:

```javascript
['Google']            // Google Play
['Google', 'Huawei']  // multiple stores; the first available on the device is used
```

> **Note**: only `@purchasely/cordova-plugin-purchasely-google` is published for Cordova. For Huawei/Amazon, contact Purchasely support.

### Promotional offers (iOS)

```javascript
Purchasely.signPromotionalOffer('store_product_id', 'store_offer_id',
    (signature) => console.log(signature),
    (error) => console.error(error)
);
```

On Android this returns "No signing required on Android" — promotional offer signing is an Apple-only feature.

---

## Troubleshooting

| Symptom | Check |
|---------|-------|
| `SDK not configured` | Call `Purchasely.start(...)` before any other SDK method. |
| Purchases do not validate / paywall does not auto-close after purchase | You are likely in the new default `Observer` mode. Pass `Purchasely.RunningMode.full`. |
| Observer purchase does not update access | The SDK auto-syncs when you acknowledge success for a purchase or restore in the interceptor. Call `Purchasely.synchronize()` manually only for purchases completed outside the interceptor. |
| Purchases not working on Android | Install `@purchasely/cordova-plugin-purchasely-google` and keep every `io.purchasely:*` dependency on the same version. |
| Paywall not displaying | Verify the placement exists in the Console, the SDK is initialized, and the device has network access. |
| Deeplink does nothing | Ensure `Purchasely.allowDeeplink(true)` and that you forward the URL with `handleDeeplink(...)`. |
| `NoSuchMethodError` at runtime (Android) | A stray `io.purchasely:*:6.0.0` outranks `6.0.0-rc.2`; pin every artifact to the same string. |

### Debug logging

```javascript
Purchasely.setLogLevel(Purchasely.LogLevel.DEBUG); // or pass it to start(); use ERROR in production
```

---

## Additional Resources

- [Purchasely Console](https://console.purchasely.io)
- [Migrating from v5 to v6 — Cordova](https://docs.purchasely.com/migrating-from-v5-to-v6-cordova)
- [NPM — main plugin](https://www.npmjs.com/package/@purchasely/cordova-plugin-purchasely)
- [Purchasely Documentation](https://docs.purchasely.com)
