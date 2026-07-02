# Purchasely React Native SDK Documentation

This guide covers the Purchasely React Native SDK **v6** (`6.0.0-rc.2`) for JavaScript / TypeScript apps. The bridge wraps the Purchasely 6.0 native SDKs (iOS `Purchasely 6.0.0-rc.2`, Android `io.purchasely:core 6.0.0-rc.2`) and displays **Presentations** (Screens / paywalls) configured in the Console through placements, direct `screen` lookups, campaigns, deeplinks and Flows.

> 📘 SDK v6 — what changed
>
> v6 is a major release with breaking changes on the **paywall surface only**: **starting the SDK** (`Purchasely.builder(...)`), **displaying / preloading / closing a presentation**, and the **action interceptor**. Everything else on the `Purchasely` object — purchases, restore, identity, catalog, subscriptions, user attributes, events, dynamic offerings, consent and config — keeps its v5 signatures. The one deeplink change: the runtime entry point `Purchasely.isDeeplinkHandled(uri)` was **renamed** to `Purchasely.handleDeeplink(uri)` (same signature) to match the native SDKs — `isDeeplinkHandled` and `readyToOpenDeeplink` no longer exist.
>
> The most impactful change for new integrations is that the **default running mode is now `'observer'`** (it was Full in v5). If you want Purchasely to handle and validate purchases, set `.runningMode('full')` explicitly. See [SDK Initialization](#sdk-initialization).

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
13. [Embedded Presentations](#embedded-presentations)
14. [Platform-Specific Features](#platform-specific-features)
15. [Theme & Appearance](#theme--appearance)
16. [Privacy & Consent](#privacy--consent)
17. [Troubleshooting](#troubleshooting)
18. [Additional Resources](#additional-resources)

---

## Requirements

| Requirement | iOS | Android |
|-------------|-----|---------|
| Minimum OS Version | 13.4 | 23 (minSdkVersion) |
| compileSdkVersion | - | 36 |
| targetSdkVersion | - | 35 |

The SDK packages are pinned to `6.0.0-rc.2`. Pin every Purchasely package to that **exact** version — this is a pre-release, so do **not** use a floating range (`^6.0.0`, `6.x`, …).

---

## Installation

We rely on [NPM](https://www.npmjs.com/package/react-native-purchasely) to distribute the React Native SDK.

### Main Dependency

```shell
npm install react-native-purchasely --save
```

Don't forget to change the minimum OS versions to match Purchasely requirements (iOS 13.4 / Android minSdk 23).

### iOS Setup

Update your Podfile to set the minimum iOS version:

```ruby
# Podfile

...

platform :ios, '13.4'

...
```

Then run:

```shell
cd ios && pod install
```

The iOS native dependency (`Purchasely 6.0.0-rc.2`) is published on the CocoaPods trunk, so it resolves from the public repositories with no extra configuration.

### Android Setup

Update your `android/build.gradle` file:

```groovy
// Edit file android/build.gradle
buildscript {
    ext {
        minSdkVersion = 23 //min version must not be below 23
        compileSdkVersion = 36
        targetSdkVersion = 35
    }
}

allprojects {
    repositories {
        mavenCentral()
    }
}
```

The Android native dependencies (`io.purchasely:core` / `google-play` / `player` `6.0.0-rc.2`) are published on **Maven Central**, so they resolve from the public repositories with no extra configuration.

### Android Dependencies

> ⚠️ **Important**: The main Purchasely SDK (`react-native-purchasely`) does **NOT** include store implementations by default. This modular architecture lets you include only the stores you need and avoids dependency conflicts.

With Android, you can choose to use Google Play Store and/or Huawei AppGallery and/or Amazon Appstore. **You must install the corresponding dependency for each store you want to support.**

#### Google Play Billing (Required for Google Play Store)

If your app is distributed on the **Google Play Store**, you **must** install the Google Play Billing dependency:

```shell
npm install @purchasely/react-native-purchasely-google --save
```

**Why is this required?**
- The Purchasely core SDK does not include the Google Play Billing library
- When you pass `.stores(['google'])` at initialization, the SDK looks for this dependency at runtime
- Without this dependency, purchases will not work on Android devices using Google Play Store
- The app may crash or fail to initialize properly on Android

> ⚠️ **Google Play Billing v8** — the `@purchasely/react-native-purchasely-google` artifact pulls in Google Play Billing Client v8. If you also depend on Google Play Billing directly, do not force an older billing dependency into your project.

#### Video Player (Required for Video Paywalls)

If your paywalls contain videos, you **must** install the Android video player dependency:

```shell
npm install @purchasely/react-native-purchasely-android-player --save
```

**Why is this required?**
- The core SDK does not include a video player to avoid conflicts with other media libraries you may have (e.g., Media3/ExoPlayer)
- Without this dependency, videos in paywalls will not play on Android
- The external player is detected and handled automatically by the SDK

#### Version Matching (Critical)

> ⚠️ **All Purchasely packages must be pinned to the exact same version.** Mismatched versions cause runtime errors. Pin each package to `6.0.0-rc.2` — do **not** use a floating range.

```json
// package.json
"dependencies": {
  "react-native-purchasely": "6.0.0-rc.2",
  "@purchasely/react-native-purchasely-google": "6.0.0-rc.2",
  "@purchasely/react-native-purchasely-android-player": "6.0.0-rc.2"
}
```

The two remaining alternative stores follow the same pattern:

```shell
npm install @purchasely/react-native-purchasely-amazon --save
npm install @purchasely/react-native-purchasely-huawei --save
```

#### Complete Android Installation Example

For a typical app distributed on Google Play Store with video paywalls:

```shell
# Install all required dependencies (same exact version)
npm install react-native-purchasely --save
npm install @purchasely/react-native-purchasely-google --save
npm install @purchasely/react-native-purchasely-android-player --save
```

Then initialize with the Google store:

```typescript
await Purchasely.builder('YOUR_API_KEY')
    .runningMode('full')
    .logLevel('error')
    .stores(['google']) // requires @purchasely/react-native-purchasely-google at the same version
    .storekitVersion('storeKit2') // iOS only: 'storeKit2' (default) | 'storeKit1'
    .start();
```

---

## SDK Initialization

In v6 the SDK is started with the fluent **`Purchasely.builder(...)`**. The v5 object-based start method and its `runningMode` / `logLevel` enum values and the StoreKit boolean have been **removed**. All builder options now use plain **strings** (e.g. `'full'`, `'error'`, `'google'`, `'storeKit2'`).

Initialize the Purchasely SDK as early as possible in your application lifecycle.

> 🚧 Major v6 change — the default running mode is now Observer
>
> In v5 the implicit default was Full. In **v6 the default is `'observer'`** — Purchasely observes transactions but your app keeps control of the purchase flow. **If you want Purchasely to handle the purchase flow and validate receipts, pass `.runningMode('full')` explicitly.** A behavioral consequence: in observer mode, presentations no longer auto-close after a purchase or restore — dismiss them yourself.

### Full Mode (Purchasely handles purchases)

In `'full'` mode, Purchasely handles the entire purchase flow including transactions and receipts.

```typescript
import Purchasely from 'react-native-purchasely';

// Everything is optional except the apiKey
// Example with default values
try {
    const configured = await Purchasely.builder('YOUR_API_KEY')
        .appUserId(null)              // optional if you already know your user id
        .runningMode('full')          // 'observer' (default) | 'full'
        .logLevel('error')            // set to 'debug' in development mode to see logs
        .allowDeeplink(true)          // allow Purchasely to open deeplinks (default false)
        .allowCampaigns(true)         // allow Purchasely campaigns (default true)
        .stores(['google'])           // Android only: 'google' | 'huawei' | 'amazon'
        .storekitVersion('storeKit2') // iOS only: 'storeKit2' (default) | 'storeKit1'
        .start();                     // resolves to a boolean

    if (configured) {
        console.log('Purchasely SDK configured successfully');
    }
} catch (e) {
    console.log('Purchasely SDK not configured properly', e);
}
```

### Observer Mode (your app owns purchases)

Use `'observer'` mode if you have an existing in-app purchase infrastructure and want to use Purchasely only for paywall display and analytics. This is the **default** mode in v6, so passing it makes the intent explicit.

```typescript
import Purchasely from 'react-native-purchasely';

try {
    const configured = await Purchasely.builder('YOUR_API_KEY')
        .appUserId(null)              // optional if you already know your user id
        .runningMode('observer')      // 'observer' (default) | 'full'
        .logLevel('error')            // set to 'debug' in development mode to see logs
        .allowDeeplink(true)          // allow Purchasely to open deeplinks
        .allowCampaigns(true)         // allow Purchasely campaigns
        .stores(['google'])           // Android only: 'google' | 'huawei' | 'amazon'
        .storekitVersion('storeKit2') // iOS only: 'storeKit2' (default) | 'storeKit1'
        .start();
} catch (e) {
    console.log('Purchasely SDK not configured properly');
}
```

### Builder options

| Method | Values | Notes |
|--------|--------|-------|
| `.appUserId(id)` | `string \| null` | Associate purchases with a user; anonymous by default |
| `.runningMode(mode)` | `'observer'` (default), `'full'` | `'full'` lets Purchasely own the purchase flow |
| `.logLevel(level)` | `'debug'`, `'info'`, `'warn'`, `'error'` (default) | Use `'debug'` in development |
| `.allowDeeplink(bool)` | `true` / `false` (default `false`) | Replaces the v5 startup deeplink-permission method |
| `.allowCampaigns(bool)` | `true` (default) / `false` | Gate Purchasely campaign display |
| `.handleDeeplink(url)` | `string \| null` | Cold-start deeplink captured at launch; replayed automatically once `start()` completes (no separate `handleDeeplink()` call needed) |
| `.stores(list)` | `['google' \| 'huawei' \| 'amazon']` | Android only |
| `.storekitVersion(v)` | `'storeKit2'` (default), `'storeKit1'` | iOS only; replaces the `storeKit1` boolean |
| `.start()` | — | `Promise<boolean>`; resolves once the SDK is configured |

### API Key

You can find your API Key in the Purchasely Console under **App settings > Backend & SDK configuration**.

---

## Displaying Paywalls

Purchasely paywalls are **Presentations** displayed using **placements** (a specific location in your app, e.g. onboarding, settings, premium feature) or by direct `screen` id.

`Purchasely.presentation` is the entry point (a `PresentationBuilder`). `Purchasely.presentation.placement(id).build()` returns a **`PresentationRequest`**. Calling `.display([transition])` shows the presentation and resolves at **dismiss** with a `PresentationOutcome` (`{ presentation, purchaseResult, plan, closeReason, error }`).

### Display a Placement

```typescript
import Purchasely from 'react-native-purchasely';

try {
    const outcome = await Purchasely.presentation
        .placement('ONBOARDING')
        .contentId('my_content_id') // optional: associate content with the purchase
        .build()
        .display();

    // outcome: { presentation, purchaseResult, plan, closeReason, error }
    if (outcome.error != null) {
        console.log('Display error:', outcome.error.message);
    } else if (
        outcome.purchaseResult === 'purchased' ||
        outcome.purchaseResult === 'restored'
    ) {
        console.log('User purchased ' + outcome.plan?.name);
        // Update entitlements to unlock content
    } else {
        console.log('Dismissed:', outcome.closeReason); // 'button' | 'backSystem' | ...
    }
} catch (e) {
    console.error(e);
}
```

### Targeting a specific screen / product

```typescript
// A specific presentation by screen id
await Purchasely.presentation.screen('SCREEN_ID').build().display();

// A specific content inside a screen
await Purchasely.presentation.screen('SCREEN_ID').contentId('CONTENT_ID').build().display();
```

### Selectors

```typescript
Purchasely.presentation.placement('onboarding'); // by placement id
Purchasely.presentation.screen('screen_abc123'); // direct Console Screen lookup
Purchasely.presentation.defaultSource();         // SDK default placement (canonical, cross-platform)
Purchasely.presentation.default();               // alias of defaultSource() kept for parity with the iOS native name
```

`defaultSource()` is the canonical cross-platform factory (it matches the Flutter SDK); `default()` is a thin alias kept because the native iOS API names this factory `default`. Both build the same request.

To display a Flow, use its deeplink `app_scheme://ply/flows/FLOW_ID`.

### Builder chaining

The `PresentationBuilder` exposes the following chainable options before `.build()`:

```typescript
Purchasely.presentation
    .placement('ONBOARDING')
    .contentId('my_content_id')
    .backgroundColor('#000000')      // hex color
    .progressColor('#FFFFFF')        // hex color
    .displayCloseButton(true)        // toggle the close button (see platform note)
    .displayBackButton(true)         // toggle the back button (see platform note)
    .onLoaded((presentation, error) => { /* screen loaded */ })
    .onPresented((presentation, error) => { /* screen presented */ })
    .onCloseRequested(() => { /* user requested close */ })
    .onDismissed((outcome) => { /* screen dismissed */ })
    .build();
```

> 📘 `displayCloseButton` / `displayBackButton` behave differently per platform
>
> - **Android** — full toggle: `true` shows the button, `false` hides it.
> - **iOS** — removal only: only `false` has an effect (it hides the button). Passing `true` is a **no-op** — the button follows the paywall's own configuration.

### Transitions

`.display([transition])` accepts an optional `Transition` **object**:

```typescript
await Purchasely.presentation.placement('ONBOARDING').build().display({ type: 'fullScreen' });
await Purchasely.presentation.placement('ONBOARDING').build().display({ type: 'modal', dismissible: false });
await Purchasely.presentation.placement('ONBOARDING').build().display({ type: 'push' });
```

The `Transition` object accepts:

| Field | Type | Description |
|-------|------|-------------|
| `type` | `'fullScreen' \| 'push' \| 'modal' \| 'drawer' \| 'popin' \| 'inlinePaywall'` | Transition mode |
| `heightPercentage` | `number?` | Height ratio for `drawer` / `popin` |
| `dismissible` | `boolean?` | Whether the user can dismiss interactively |
| `backgroundColors` | `{ light?, dark? }?` | Backdrop colors per theme |

### Display Results

`.display([transition])` resolves with a `PresentationOutcome`:

| Field | Type | Description |
|-------|------|-------------|
| `presentation` | `Presentation \| null` | The displayed presentation (or `null` if it never reached display) |
| `purchaseResult` | `string \| null` | `'purchased'` \| `'restored'` \| `'cancelled'` \| `null` |
| `plan` | `PurchaselyPlan \| null` | The purchased plan (when `purchaseResult` is `'purchased'` / `'restored'`) |
| `closeReason` | `string \| null` | `'button'` \| `'backSystem'` \| `'programmatic'` (when no purchase) |
| `error` | `PresentationError \| null` | Display error; mutually exclusive with `closeReason` |

`purchaseResult` is `null` when the user dismissed the screen without a purchase action. Platform note: system dismissals surface as `'backSystem'` on both platforms — the Android system back gesture/button and the iOS interactive swipe-down / navigation pop both map to `'backSystem'`.

### Presentation lifecycle (display / close / back)

A `PresentationRequest` exposes imperative controls:

```typescript
const request = Purchasely.presentation.placement('ONBOARDING').build();

request.display();  // show (returns a Promise that resolves at dismiss)
request.close();    // dismiss programmatically
request.back();     // navigate back inside a multi-step (Flow) presentation
```

> 📘 The v5 imperative close / hide / show presentation methods have been **removed**. Use the `PresentationRequest` handle (`request.close()` / `request.back()`) instead.
>
> ⚠️ The native SDK does not yet expose a per-request close, so `request.close()` currently dismisses **all** displayed presentations, not only this request. If your app stacks presentations (e.g. a product page inside an onboarding flow), calling `close()` on one will also dismiss the others.

---

## Processing Transactions

### Full Mode

In `'full'` mode, the Purchasely SDK automatically launches the native in-app purchase flow when a user taps a purchase button and handles the transaction. You only need to update entitlements once you have confirmation the purchase was processed.

```typescript
try {
    const outcome = await Purchasely.presentation
        .placement('onboarding')
        .build()
        .display();

    if (
        outcome.purchaseResult === 'purchased' ||
        outcome.purchaseResult === 'restored'
    ) {
        console.log('User purchased ' + outcome.plan?.name);
        // Update entitlements to unlock the access to the contents
    }
} catch (e) {
    console.error(e);
}
```

You can also trigger a purchase programmatically (unchanged in v6):

```typescript
const plan = await Purchasely.purchaseWithPlanVendorId({
    planVendorId: 'PURCHASELY_PLUS_MONTHLY',
    offerId: null,   // optional
    contentId: null, // optional
});
```

### Observer Mode with Action Interceptor

In `'observer'` mode, you handle purchases with your own infrastructure while using Purchasely for paywall display. Register an interceptor for the `'purchase'` action; the handler returns an intercept result string (the v5 process-action acknowledgement callback no longer exists). In observer mode the presentation does **not** auto-close, so dismiss it yourself.

```typescript
import { Platform } from 'react-native';
import Purchasely from 'react-native-purchasely';

Purchasely.interceptAction('purchase', async (info, payload) => {
    if (payload?.kind !== 'purchase') {
        return 'notHandled';
    }
    try {
        // The store product id (sku) the user tapped on in the paywall
        const storeProductId = payload.plan.productId;

        if (Platform.OS === 'android') {
            // Only for Android you can retrieve the subscription offer details
            const basePlanId = payload.subscriptionOffer?.basePlanId;
            const offerId = payload.subscriptionOffer?.offerId;
            const offerToken = payload.subscriptionOffer?.offerToken;
        }

        const success = await MyPurchaseSystem.purchase(storeProductId);
        if (success) {
            // SDK auto-synchronizes on success in observer mode
            return 'success'; // notify Purchasely the action was handled
        }
        return 'failed';
    } catch (e) {
        console.log(e);
        return 'failed';
    }
});

Purchasely.interceptAction('restore', async (info, payload) => {
    try {
        await MyPurchaseSystem.restorePurchases();
        // SDK auto-synchronizes on success in observer mode
        return 'success'; // notify Purchasely the action was handled
    } catch (e) {
        // Error restoring purchases
        return 'failed';
    }
});
```

> 📘 `synchronize()` now reports completion. In v6 `Purchasely.synchronize()` returns a `Promise<boolean>` that **resolves when the synchronization actually completes** and **rejects on failure**. `await` it (and optionally `try/catch`) before chaining a follow-up presentation that targets subscribers. Fire-and-forget callers stay source-compatible with the previous behavior. Call this manually for transactions completed outside the interceptor (the SDK already auto-syncs when an interceptor returns the success result for a purchase or restore in observer mode).

---

## Action Interceptor

The v6 interceptor is registered **per action kind** with `Purchasely.interceptAction(kind, handler)`. The handler receives a typed payload and returns an intercept result string — the v5 single global interceptor callback and its boolean process-action acknowledgement no longer exist.

### Result values

| Result | Meaning |
|--------|---------|
| `'success'` | App handled the action; SDK skips its default behavior. |
| `'failed'` | App tried but failed; the action chain stops. |
| `'notHandled'` | SDK should continue with its default behavior. |

### Action kinds & payloads

Action kinds: `'close'`, `'closeAll'`, `'login'`, `'navigate'`, `'purchase'`, `'restore'`, `'openPresentation'`, `'openPlacement'`, `'promoCode'`, `'webCheckout'`.

The handler's second argument is a typed payload (or `null`); narrow it with `payload?.kind`:

| Action kind | Payload `kind` | Notable fields |
|-------------|----------------|----------------|
| `purchase` | `'purchase'` | `plan` (`PurchaselyPlan`), `subscriptionOffer?`, `offer?` |
| `restore` | — | — |
| `login` | — | — |
| `close` / `closeAll` | `'close'` / `'closeAll'` | `closeReason` |
| `navigate` | `'navigate'` | `url`, `title?` |
| `openPresentation` | `'openPresentation'` | `presentationId` |
| `openPlacement` | `'openPlacement'` | `placementId` |
| `webCheckout` | `'webCheckout'` | `url`, `clientReferenceId`, `queryParameterKey`, `webCheckoutProvider` |

### Implementation

```typescript
import { Linking } from 'react-native';
import Purchasely from 'react-native-purchasely';

Purchasely.interceptAction('navigate', async (info, payload) => {
    if (payload?.kind === 'navigate') {
        Linking.openURL(payload.url);
        return 'success';
    }
    return 'notHandled';
});

Purchasely.interceptAction('login', async (info, payload) => {
    // Present your own screen for the user to log in
    Purchasely.userLogin('MY_USER_ID');
    return 'success';
});
```

### Removing interceptors

```typescript
Purchasely.removeActionInterceptor('purchase');
Purchasely.removeAllActionInterceptors();
```

---

## User Identification

### Anonymous Users

The Purchasely SDK automatically generates and assigns an `anonymous_user_id` to each user, maintaining consistency as long as the app remains installed on the device.

```typescript
const anonymousId = await Purchasely.getAnonymousUserId();
console.log('Anonymous User ID: ' + anonymousId);

const anonymous = await Purchasely.isAnonymous();
console.log('Is anonymous? ' + anonymous);
```

### User Login

To authenticate users and associate purchases with their account:

```typescript
Purchasely.userLogin('123456789').then((refresh) => {
    if (refresh) {
        // You should call your backend to refresh user entitlements
        console.log('User logged in, refresh entitlements');
    }
});
```

You can also provide the user id at initialization with `Purchasely.builder('YOUR_API_KEY').appUserId('123456789').start()`.

### User Logout

```typescript
// Logout user (clears user id and custom attributes)
Purchasely.userLogout();
```

### Login from Paywall

To handle the login button on a presentation, intercept the `'login'` action:

```typescript
Purchasely.interceptAction('login', async (info, payload) => {
    // Present your own screen for the user to log in
    Purchasely.userLogin('MY_USER_ID'); // call before returning to update the screen
    return 'success';
});
```

---

## Subscription Status & Entitlements

### Retrieve User Subscriptions

Purchasely offers a way to retrieve active subscriptions directly from your mobile app:

```typescript
try {
    const subscriptions = await Purchasely.userSubscriptions();
    if (subscriptions[0] !== undefined) {
        console.log(subscriptions[0].plan);
        console.log(subscriptions[0].subscriptionSource);
        console.log(subscriptions[0].nextRenewalDate);
        console.log(subscriptions[0].cancelledDate);
    }
} catch (e) {
    console.log(e);
}
```

Expired subscriptions (the user's history) are available via `Purchasely.userSubscriptionsHistory()` — useful for analytics and engagement strategies.

```typescript
const history = await Purchasely.userSubscriptionsHistory();
```

> **Note**: There is a **few seconds delay** for `Purchasely.userSubscriptions()` to be updated after a purchase or restoration. If you rely on this method right after a purchase, **wait for 3 seconds** before calling it.

### Restoring Purchases

```typescript
// Visible restore — triggers store UI when needed, returns true if a purchase was restored
const restored = await Purchasely.restoreAllProducts();

// Silent restore — no store prompt
const silentRestored = await Purchasely.silentRestoreAllProducts();
```

### Catalog data

```typescript
const products = await Purchasely.allProducts();
const product = await Purchasely.productWithIdentifier('product_vendor_id');
const plan = await Purchasely.planWithIdentifier('plan_vendor_id');

// iOS introductory offer eligibility
const eligible = await Purchasely.isEligibleForIntroOffer('plan_vendor_id');
```

> 🚧 Removed in v6 — the native subscriptions screen (BREAKING)
>
> The native subscriptions screen was removed from the 6.0 SDKs on both platforms, so the v5 method that opened it has been **removed entirely** from the React Native API — the method no longer exists. There is no drop-in replacement: build your own subscriptions screen with `userSubscriptions()` / `userSubscriptionsHistory()`.

---

## Custom User Attributes

Custom User Attributes allow you to segment users and personalize their journey.

### Supported Types

`String`, `Number` (Int / Float), `Boolean`, `Date`, and arrays of `String` / `Number` / `Boolean`.

### Setting Attributes

Every setter accepts an optional GDPR legal basis (`PLYDataProcessingLegalBasis.ESSENTIAL` / `.OPTIONAL`) as the last argument.

```typescript
import Purchasely, { PLYDataProcessingLegalBasis } from 'react-native-purchasely';

Purchasely.setUserAttributeWithString('gender', 'man');
Purchasely.setUserAttributeWithNumber('age', 21);
Purchasely.setUserAttributeWithNumber('weight', 78.2);
Purchasely.setUserAttributeWithBoolean('premium', true, PLYDataProcessingLegalBasis.ESSENTIAL);
Purchasely.setUserAttributeWithDate('subscription_date', new Date());
Purchasely.setUserAttributeWithStringArray('tags', ['sport', 'news']);
Purchasely.setUserAttributeWithNumberArray('scores', [10, 20]);
Purchasely.setUserAttributeWithBooleanArray('flags', [true, false]);
```

### Retrieving Attributes

```typescript
// Get all attributes
const attributes = await Purchasely.userAttributes();
console.log(attributes);

// Retrieve a specific attribute
const dateAttribute = await Purchasely.userAttribute('subscription_date');
// For dates, parse the ISO 8601 string to retrieve the Date object
console.log(new Date(dateAttribute).getFullYear());
```

### Incrementing / Decrementing Counters

```typescript
// Increment a user attribute (created if not set)
Purchasely.incrementUserAttribute({ key: 'viewed_articles' });
Purchasely.incrementUserAttribute({ key: 'viewed_articles', value: 3 });

// Decrement a user attribute
Purchasely.decrementUserAttribute({ key: 'viewed_articles' });
Purchasely.decrementUserAttribute({ key: 'viewed_articles', value: 7 });
```

### Clearing Attributes

```typescript
// Remove one attribute
Purchasely.clearUserAttribute('size');

// Remove all attributes
Purchasely.clearUserAttributes();

// Clear Purchasely built-in attributes
Purchasely.clearBuiltInAttributes();
```

> **Note**: `Purchasely.userLogout()` clears all custom user attributes.

---

## Event Listeners

### UI / SDK Events Listener

When users interact with Purchasely Screens, the SDK triggers events. Implement an event listener to forward these events to your analytics platforms.

```typescript
const listener = Purchasely.addEventListener((event) => {
    console.log('Event received: ' + event.name);
    console.log('Event properties: ' + JSON.stringify(event.properties));
    // Forward to your analytics platform
});

// Stop listening when no longer needed:
listener.remove();
// or Purchasely.removeEventListener();
```

UI/SDK events are computed by the Purchasely Platform for conversion KPIs but cannot be routed to third-party integrations from the Console — forward them yourself from the app if you need them in your analytics.

### Purchase Listener

```typescript
const purchaseListener = Purchasely.addPurchasedListener(() => {
    console.log('A purchase was made');
    // Refresh entitlements
});

purchaseListener.remove();
```

### Custom User Attributes Listener

When a user submits answers to a survey configured in the Screen Composer, custom user attributes can be set automatically by the SDK. The `source` property tells you whether the change came from Purchasely or from your own app.

```typescript
import Purchasely, { PLYUserAttributeSource } from 'react-native-purchasely';

const setListener = Purchasely.addUserAttributeSetListener((attribute) => {
    console.log('Attribute key: ' + attribute.key);
    console.log('Attribute value: ' + attribute.value);
    console.log('Attribute type: ' + attribute.type);
    console.log('Attribute source: ' + attribute.source);

    if (attribute.source === PLYUserAttributeSource.PURCHASELY) {
        // Process attribute set by Purchasely (e.g., from surveys)
    }
});

const removedListener = Purchasely.addUserAttributeRemovedListener((attribute) => {
    console.log('Attribute removed: ' + attribute.key);
});

// Clean up
setListener.remove();
removedListener.remove();
```

The source values:

- **`PLYUserAttributeSource.PURCHASELY`**: The change was initiated internally by the Purchasely SDK (e.g., from surveys)
- **`PLYUserAttributeSource.CLIENT`**: The change was triggered directly by your app — you can usually ignore these since your app already has the data

---

## Pre-fetching Screens

Purchasely, by default, shows the paywall screen with a loading indicator while fetching it from the network. Using `request.preload()`, you can pre-fetch the paywall from the network **before** displaying it for a better user experience.

### Benefits

- Display the Screen only after it has been loaded
- Handle network errors gracefully
- Show a custom loading screen
- Pre-load during app navigation

### Implementation

Build a `PresentationRequest`, `preload()` it to fetch the screen from the network, then `display()` the **same** request when you are ready.

`preload()` resolves to a **`PLYLoadedPresentation`** — the presentation data (`screenId`, `placementId`, `plans`, …) **plus** `display([transition])`, `close()` and `back()` methods that delegate to the originating request. You can therefore drive the whole lifecycle straight from the loaded object (`loaded.display()`) instead of keeping a separate reference to the request. (This mirrors the Flutter SDK.)

```typescript
import Purchasely, { PLYPresentationType } from 'react-native-purchasely';

try {
    // Build a request for the placement
    const request = Purchasely.presentation.placement('ONBOARDING').build();

    // Pre-fetch the presentation; resolves to a PLYLoadedPresentation once the screen is loaded
    const presentation = await request.preload();

    if (presentation == null) {
        // No presentation, it means an error was triggered
        return;
    }

    if (presentation.type === PLYPresentationType.DEACTIVATED) {
        // No paywall to display for this placement
        return;
    }

    if (presentation.type === PLYPresentationType.CLIENT) {
        // Display your own paywall (BYOS)
        const paywallId = presentation.screenId;
        const planIds = presentation.plans;
        return;
    }

    // Display the preloaded presentation; resolves at dismiss
    const outcome = await request.display();

    switch (outcome.purchaseResult) {
        case 'purchased':
        case 'restored':
            if (outcome.plan != null) {
                console.log('User purchased ' + outcome.plan.name);
            }
            break;
        case 'cancelled':
            console.log('User cancelled');
            break;
        default:
            console.log('User dismissed:', outcome.closeReason);
            break;
    }
} catch (e) {
    console.error(e);
}
```

Because the `PLYLoadedPresentation` carries the lifecycle methods, you can also skip the extra `request` reference and drive it from the loaded object directly:

```typescript
const loaded = await Purchasely.presentation.placement('ONBOARDING').build().preload();
const outcome = await loaded.display();   // show
// loaded.close();                        // dismiss programmatically
// loaded.back();                         // step back inside a Flow
```

> ⚠️ On **Android**, `close()` (whether called on the request or the loaded presentation) dismisses **all** displayed presentations — the native SDK does not yet expose a per-request close. On **iOS** it closes only the targeted presentation.

### Presentation Types

| Type (`PLYPresentationType`) | Description |
|------------------------------|-------------|
| `NORMAL` | Default Purchasely paywall |
| `FALLBACK` | Fallback paywall (requested one not found) |
| `DEACTIVATED` | No paywall for this placement |
| `CLIENT` | Your own paywall (BYOS) |

---

## Deeplinks Management

To manage deeplinks you can do up to 3 things:

1. Pass a received deeplink to the SDK (and allow the SDK to open deeplinks)
2. Optionally control when Purchasely is allowed to display content over your interface
3. Set a default presentation dismiss handler to receive the result of the user's action

### Allowing the Display

Deeplink display is allowed via the start builder (it defaults to `false`):

```typescript
await Purchasely.builder('YOUR_API_KEY')
    .allowDeeplink(true)
    .start();
```

### Passing the Deeplink to the SDK

To let the Purchasely SDK analyze a deeplink received by the app, pass it with `handleDeeplink`:

```typescript
const handled = await Purchasely.handleDeeplink('app://ply/presentations/');
console.log('Deeplink handled by Purchasely? ' + handled);
```

> 📘 `isDeeplinkHandled` was renamed to `handleDeeplink`
>
> In v6 the runtime method for passing a deeplink is `Purchasely.handleDeeplink(uri)` (same signature — it still returns a `Promise<boolean>`). The v5 names `isDeeplinkHandled` **and** `readyToOpenDeeplink` **no longer exist** (no alias). Allow deeplinks at startup with `.allowDeeplink(true)` on the builder. For a deeplink captured at **cold start**, pass it to the builder with `.handleDeeplink(url)`; the SDK replays it automatically once `start()` completes.

### Forbidding the Display

By **default**, Purchasely deeplinks are displayed **immediately** when they are received. To defer them (e.g. during a splash screen, onboarding or login), prevent the display and re-enable it once you are ready:

```typescript
// Prevent the display (e.g. while your onboarding is on screen)
Purchasely.allowDeeplink(false);

// Re-enable it once ready — any queued deeplink displays immediately
Purchasely.allowDeeplink(true);
```

Campaigns follow the same principle through `allowCampaigns` (also `true` by default):
`Purchasely.allowCampaigns(false)` / `Purchasely.allowCampaigns(true)`.

### Setting the Default Presentation Dismiss Handler

When a paywall / screen is opened by the SDK itself (deeplink, campaign, Promoted In-App Purchase), you don't instantiate it yourself, so no per-display callback fires. Register a default dismiss handler to receive the resulting `PresentationOutcome`. `setDefaultPresentationDismissHandler` is the v6 replacement for the v5 default presentation result callbacks.

```typescript
const subscription = Purchasely.setDefaultPresentationDismissHandler((outcome) => {
    // outcome: { presentation, purchaseResult, plan, closeReason, error }
    // `presentation` is always populated — use it to identify which screen closed.
    console.log(outcome.presentation?.screenId, outcome.purchaseResult, outcome.closeReason);

    if (outcome.plan != null) {
        console.log('Plan Vendor ID:', outcome.plan.vendorId);
        console.log('Plan Name:', outcome.plan.name);
    }
});

// Only one handler is active at a time (re-registering replaces it).
// Remove it when you no longer need it:
//   subscription.remove();
//   // or Purchasely.removeDefaultPresentationDismissHandler();
```

---

## Embedded Presentations

To render a presentation inline inside your component tree — as opposed to full-screen / modal — use the `PLYPresentationView` component.

The recommended input is a **preloaded request** (parity with the Flutter SDK): build a `PresentationRequest`, `preload()` it, then pass it through the `request` prop. The native view resolves the loaded presentation by the request's `requestId`, so there is no second network fetch.

```tsx
import Purchasely, { PLYPresentationView, ProductResult } from 'react-native-purchasely';

// Preload before rendering (e.g. in an effect or during navigation)
const request = Purchasely.presentation.placement('ONBOARDING').build();
await request.preload();

<PLYPresentationView
    request={request}
    flex={1}
    onPresentationClosed={(result) => {
        // result: { result: ProductResult, plan: PurchaselyPlan | null }
        if (
            result.result === ProductResult.PRODUCT_RESULT_PURCHASED ||
            result.result === ProductResult.PRODUCT_RESULT_RESTORED
        ) {
            console.log('User purchased', result.plan?.name);
        }
        // Remove the component from your tree to close the Purchasely Screen
    }}
/>
```

> 📘 The embedded view reports a `PLYPresentationViewResult`, not the 5-field outcome
>
> Unlike the full-screen `display()` (which resolves a `PLYPresentationOutcome`), the native embedded view emits a **`{ result, plan }`** couple: `result` is a `ProductResult` (`PRODUCT_RESULT_PURCHASED` / `PRODUCT_RESULT_RESTORED` / `PRODUCT_RESULT_CANCELLED`) and `plan` is the purchased / restored `PurchaselyPlan` (or `null` when the user simply closed the screen).

If you don't preload a request, the view falls back to a `placementId` (or a presentation you preloaded yourself):

```tsx
<PLYPresentationView
    placementId="ONBOARDING"
    flex={1}
    onPresentationClosed={(result) => console.log('Closed:', result.result, result.plan)}
/>
```

If your app renders its own paywall (BYOS), report display and close to Purchasely for analytics:

```typescript
Purchasely.clientPresentationDisplayed(presentation);
// ... when your screen closes
Purchasely.clientPresentationClosed(presentation);
```

---

## Platform-Specific Features

### StoreKit Selection (iOS)

Choose between StoreKit 1 and StoreKit 2 for iOS with the `.storekitVersion(...)` builder option (this replaces the old StoreKit boolean flag):

```typescript
await Purchasely.builder('YOUR_API_KEY')
    .storekitVersion('storeKit2') // 'storeKit2' (default) | 'storeKit1'
    .start();
```

> **Recommendation**: Use StoreKit 2 (`'storeKit2'`, the default) for new integrations.

### Android Stores

Purchasely supports multiple Android stores via the `.stores([...])` builder option:

```typescript
await Purchasely.builder('YOUR_API_KEY')
    .stores(['google']) // 'google' | 'huawei' | 'amazon'
    .start();
```

To use multiple stores (the first one available on the device is used):

```typescript
.stores(['google', 'huawei'])
```

> **Note**: Install the corresponding dependency for each store you want to support, all at the same version.

### Android-Specific Purchase Parameters

When intercepting purchases on Android, you can access additional subscription offer parameters from the typed payload's `subscriptionOffer`:

```typescript
import { Platform } from 'react-native';

Purchasely.interceptAction('purchase', async (info, payload) => {
    if (payload?.kind === 'purchase' && Platform.OS === 'android') {
        const basePlanId = payload.subscriptionOffer?.basePlanId;
        const offerId = payload.subscriptionOffer?.offerId;
        const offerToken = payload.subscriptionOffer?.offerToken;
    }
    return 'notHandled';
});
```

### Promotional Offers (iOS)

```typescript
const signature = await Purchasely.signPromotionalOffer({
    storeProductId: 'my_store_product_id',
    storeOfferId: 'my_store_offer_id',
});
```

### Dynamic Offerings

```typescript
await Purchasely.setDynamicOffering({
    reference: 'my_offering',
    planVendorId: 'PURCHASELY_PLUS_MONTHLY',
    offerVendorId: 'my_offer', // optional
});

const offerings = await Purchasely.getDynamicOfferings();
Purchasely.removeDynamicOffering('my_offering');
Purchasely.clearDynamicOfferings();
```

### Language

Force the Purchasely Screens language (otherwise the device locale is used):

```typescript
Purchasely.setLanguage('fr');
```

### Consumable subscription content

When a user has consumed the content unlocked by a non-renewing subscription, notify the SDK:

```typescript
Purchasely.userDidConsumeSubscriptionContent();
```

---

## Theme & Appearance

Control whether Purchasely Screens render in light, dark or system appearance with `setThemeMode`:

```typescript
import Purchasely, { PLYThemeMode } from 'react-native-purchasely';

Purchasely.setThemeMode(PLYThemeMode.LIGHT);  // LIGHT | DARK | SYSTEM
```

| Value | Behavior |
|-------|----------|
| `PLYThemeMode.LIGHT` | Always render in light appearance |
| `PLYThemeMode.DARK` | Always render in dark appearance |
| `PLYThemeMode.SYSTEM` | Follow the device system appearance |

---

## Privacy & Consent

### GDPR legal basis on attributes

Every `setUserAttributeWith*` (and `incrementUserAttribute` / `decrementUserAttribute`) accepts an optional `PLYDataProcessingLegalBasis` to record the legal basis for storing the value:

```typescript
import Purchasely, { PLYDataProcessingLegalBasis } from 'react-native-purchasely';

Purchasely.setUserAttributeWithString('gender', 'man', PLYDataProcessingLegalBasis.ESSENTIAL);
```

`PLYDataProcessingLegalBasis` values: `ESSENTIAL`, `OPTIONAL`.

### Revoking data-processing consent

To honor a user opting out, revoke consent for one or more processing purposes:

```typescript
import Purchasely, { PLYDataProcessingPurpose } from 'react-native-purchasely';

Purchasely.revokeDataProcessingConsent([
    PLYDataProcessingPurpose.ANALYTICS,
    PLYDataProcessingPurpose.CAMPAIGNS,
]);
```

`PLYDataProcessingPurpose` values: `ANALYTICS`, `IDENTIFIED_ANALYTICS`, `CAMPAIGNS`, `PERSONALIZATION`, `THIRD_PARTY_INTEGRATION`, `ALL_NON_ESSENTIALS`.

---

## Troubleshooting

### Common Issues

1. **SDK not configured**: Ensure you call `Purchasely.builder('YOUR_API_KEY').start()` and that it resolves to `true` before any other SDK methods.

2. **Purchases not validating / paywall does not auto-close after purchase**: You are likely in the new default `'observer'` mode. Pass `.runningMode('full')` for Purchasely to own the purchase flow. In observer mode, presentations do not auto-close — dismiss them yourself with `request.close()`.

3. **Purchases not working on Android**: Verify that you've added `@purchasely/react-native-purchasely-google` and that all Purchasely packages are pinned to the exact same version (`6.0.0-rc.2`).

4. **Paywall not displaying**: Check that:
   - The placement / screen exists in your Purchasely Console
   - The SDK is properly initialized (the `start()` promise resolved `true`)
   - You have an active internet connection

5. **Observer purchase does not update access**: The SDK auto-syncs when your interceptor returns the success result for a purchase or restore. Call `await Purchasely.synchronize()` manually only for purchases completed outside the interceptor.

6. **iOS pod install issues**: Ensure your iOS deployment target is set to at least **13.4** in your Podfile, then run `cd ios && pod install --repo-update`.

7. **Deeplink does nothing**: Ensure `allowDeeplink` is `true` and, if you defer deeplinks, that you re-enable with `Purchasely.allowDeeplink(true)`.

### Debug Mode

Enable debug logging during development:

```typescript
await Purchasely.builder('YOUR_API_KEY')
    .logLevel('debug') // use 'error' in production
    .start();
```

You can also adjust the log level at runtime:

```typescript
import Purchasely, { LogLevels } from 'react-native-purchasely';

Purchasely.setLogLevel(LogLevels.DEBUG);
```

---

## Additional Resources

- [Purchasely Console](https://console.purchasely.io)
- [NPM Package](https://www.npmjs.com/package/react-native-purchasely)
- [Purchasely Documentation](https://docs.purchasely.com)
