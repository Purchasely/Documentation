---
title: Migrating to v6 — React Native
excerpt: >-
  Breaking changes and migration steps to upgrade the Purchasely React Native
  SDK from v5.x to v6.0.0-rc.2
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
This guide covers the **React Native SDK** (`react-native-purchasely`). For the underlying native changes, see the [iOS guide](migrating-from-v5-to-v6-ios) and the [Android guide](migrating-from-v5-to-v6-android), or the platform pages listed on the [migration overview](migrating-from-sdk-5-to-6).

The React Native SDK v6 is **paywall‑API‑only**: the legacy v5 paywall API has been **removed** (not deprecated). Calling any removed method fails to compile (TypeScript) and the method no longer exists at runtime. The new surface is built around three entry points on the `Purchasely` default export: `Purchasely.builder(apiKey)`, `Purchasely.presentation`, and `Purchasely.interceptAction(kind, handler)`.

> 📘 Scope
>
> Every "Before" example reflects the public **v5** API as shipped in the last v5.x release. If a snippet does not match what your project compiled against, reach out to the Customer Success team.

> 💡 Let the AI help you migrate
>
> The Purchasely AI plugin and the `purchasely-integrate`, `purchasely-review` and `purchasely-debug` skills can read your integration and rewrite the v5 paywall calls to the v6 builder API for you. Point them at the files that call `Purchasely.start`, `presentPresentationForPlacement`, `fetchPresentation`, `setPaywallActionInterceptorCallback`, etc.

***

## Summary of breaking changes

| v5                                                                   | v6                                                                            |
| -------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| Default running mode `'full'`                                        | Default running mode `'observer'` ⚠️                                          |
| `Purchasely.start({ apiKey, … })`                                    | `Purchasely.builder(apiKey).…start()`                                         |
| `Purchasely.startWithAPIKey(apiKey, …)`                              | `Purchasely.builder(apiKey).…start()`                                         |
| `Purchasely.fetchPresentation({ placementId })`                      | `Purchasely.presentation.placement(id).build().preload()`                     |
| `Purchasely.presentPresentationForPlacement({ placementVendorId })`  | `Purchasely.presentation.placement(id).build().display()`                     |
| `Purchasely.presentPresentationWithIdentifier({ presentationVendorId })` | `Purchasely.presentation.screen(id).build().display()`                    |
| `Purchasely.presentProductWithIdentifier(productId, …)`              | `Purchasely.presentation.screen(id).contentId(contentId).build().display()`   |
| `Purchasely.presentPlanWithIdentifier(planId, …)`                    | `Purchasely.presentation.screen(id).build().display()`                        |
| `Purchasely.showPresentation()` / `hidePresentation()` / `closePresentation()` | `request.display()` / `request.close()`                             |
| `setPaywallActionInterceptorCallback(cb)` + `onProcessAction(bool)`  | `Purchasely.interceptAction(kind, handler)` returning `'success' \| 'failed' \| 'notHandled'` |
| `setDefaultPresentationResultCallback` / `…ResultHandler`            | `Purchasely.setDefaultPresentationDismissHandler(outcome => …)`               |
| `Purchasely.readyToOpenDeeplink(true)`                               | `Purchasely.builder(apiKey).allowDeeplink(true).start()`                      |
| `Purchasely.isDeeplinkHandled(uri)`                                  | **Renamed** `Purchasely.handleDeeplink(uri)` (same signature) ⚠️             |
| `ProductResult` ordinal enum (`PRODUCT_RESULT_PURCHASED`, …)         | `purchaseResult` string union (`'purchased' \| 'cancelled' \| 'restored'`)    |
| `Purchasely.presentSubscriptions()`                                  | **Removed — no replacement** (build your own screen) ⚠️                       |

> 📘 `isDeeplinkHandled` was **renamed** to `handleDeeplink`
>
> Like the native iOS/Android SDKs, the React Native bridge renamed this method to `Purchasely.handleDeeplink(uri)` (same signature, still returns `Promise<boolean>`). The v5 names `isDeeplinkHandled` and `readyToOpenDeeplink` **no longer exist** — there is no alias.

***

## 1. Update dependencies

Pin the **exact** pre‑release version (no caret / range):

```bash
npm install react-native-purchasely@6.0.0-rc.2
# optional Android stores:
npm install @purchasely/react-native-purchasely-google@6.0.0-rc.2
npm install @purchasely/react-native-purchasely-android-player@6.0.0-rc.2 # video support in paywalls
npm install @purchasely/react-native-purchasely-amazon@6.0.0-rc.2
npm install @purchasely/react-native-purchasely-huawei@6.0.0-rc.2
```

iOS: `cd ios && pod install`. Android: autolinking handles the native modules.

The bridge pulls the native pins automatically (iOS pod `Purchasely 6.0.0-rc.2`, Android `io.purchasely:core:6.0.0-rc.2`). Minimum OS versions: **iOS 13.4**, **Android `minSdkVersion 23`**.

***

## 2. SDK initialization

### Default running mode is now `'observer'` ⚠️

The default `runningMode` changed from `'full'` to `'observer'`. **If you want Purchasely to handle and validate purchases, pass `.runningMode('full')` explicitly.**

> 🚧 This change is silent
>
> Your code still compiles — there is **no** type error. If you relied on the implicit `full` default, your app will **stop owning the purchase flow** until you add `.runningMode('full')`. Audit every `start()` / `builder()` call. The fallback for an unknown/unset value now resolves to `observer`, never `full`.

### Before (v5 — removed)

```typescript
import Purchasely, { LogLevels, RunningMode } from 'react-native-purchasely'

await Purchasely.start({
  apiKey: 'YOUR_API_KEY',
  androidStores: ['Google'],
  storeKit1: false,
  userId: 'user_id',
  logLevel: LogLevels.ERROR,
  runningMode: RunningMode.FULL,
})

Purchasely.readyToOpenDeeplink(true)
```

### After (v6)

```typescript
import Purchasely from 'react-native-purchasely'

const configured = await Purchasely.builder('YOUR_API_KEY')
  .appUserId('user_id')         // optional, defaults to anonymous
  .runningMode('full')          // 'observer' (default) | 'full' — set 'full' for purchase handling
  .logLevel('error')            // 'debug' | 'info' | 'warn' | 'error'
  .allowDeeplink(true)          // replaces readyToOpenDeeplink(true); defaults to true
  .allowCampaigns(true)         // automatic campaigns; defaults to true, independent from deeplinks
  .stores(['google'])           // Android only: 'google' | 'huawei' | 'amazon'
  .storekitVersion('storeKit2') // iOS only: 'storeKit1' | 'storeKit2'
  .start()                      // Promise<boolean>
```

Every modifier takes a **plain string** (not an enum): `runningMode('full')`, `logLevel('error')`, `stores(['google'])`, `storekitVersion('storeKit2')`. The v5 `LogLevels` / `RunningMode` enum imports are no longer needed for initialization.

***

## 3. Displaying a paywall

`Purchasely.presentation` is the `PresentationBuilder`. Pick an entry point (`.placement(id)`, `.screen(id)`, `.defaultSource()`), chain options, call `.build()` to get a `PresentationRequest`, then `.display()`. `display()` resolves at **dismiss** with a `PresentationOutcome`. (`.defaultSource()` is the canonical cross-platform factory; `.default()` is a kept alias for the iOS-style name.)

### Before (v5 — removed)

```typescript
const result = await Purchasely.presentPresentationForPlacement({
  placementVendorId: 'ONBOARDING',
  contentId: 'my_content_id',
  isFullscreen: true,
})

switch (result.result) {
  case ProductResult.PRODUCT_RESULT_PURCHASED:
  case ProductResult.PRODUCT_RESULT_RESTORED:
    console.log('Purchased', result.plan?.name)
    break
  case ProductResult.PRODUCT_RESULT_CANCELLED:
    break
}
```

### After (v6)

```typescript
const outcome = await Purchasely.presentation
  .placement('ONBOARDING')
  .contentId('my_content_id')
  .build()
  .display()

// outcome: { presentation, purchaseResult, plan, closeReason, error }
if (outcome.error) {
  console.error(outcome.error.message)
} else if (outcome.purchaseResult === 'purchased' || outcome.purchaseResult === 'restored') {
  console.log('Purchased', outcome.plan?.name)
} else {
  console.log('Dismissed', outcome.closeReason) // 'button' | 'backSystem' | 'programmatic'
}
```

`purchaseResult` is now a **string union** (`'purchased' | 'cancelled' | 'restored' | null`) instead of the `ProductResult` ordinal enum.

### Targeting a specific screen / product / plan

```typescript
// Specific presentation by screen id (was presentPresentationWithIdentifier)
await Purchasely.presentation.screen('SCREEN_ID').build().display()

// Specific product (was presentProductWithIdentifier)
await Purchasely.presentation.screen('SCREEN_ID').contentId('CONTENT_ID').build().display()

// Specific plan (was presentPlanWithIdentifier)
await Purchasely.presentation.screen('SCREEN_ID').build().display()
```

### Builder options & lifecycle callbacks

The builder also accepts `.backgroundColor()`, `.progressColor()`, `.displayCloseButton()`, `.displayBackButton()`, and lifecycle hooks `.onLoaded()`, `.onPresented()`, `.onCloseRequested()`, `.onDismissed()` — set them before `.build()`.

`.displayCloseButton()` / `.displayBackButton()` behave differently per platform: on **Android** they are a full toggle (`true` shows, `false` hides); on **iOS** only `false` acts (it hides the button) — passing `true` is a no-op and the button follows the paywall's own configuration.

`display()` accepts an optional `Transition` **object**:

```typescript
await Purchasely.presentation.placement('ONBOARDING').build().display({
  type: 'modal', // 'fullScreen' | 'push' | 'modal' | 'drawer' | 'popin' | 'inlinePaywall'
  dismissible: true,
})
```

***

## 4. Pre‑fetching (preload)

`fetchPresentation` + `presentPresentation` are replaced by the request lifecycle: build the request once, `preload()` it, then `display()` the same request later (no extra network call).

### Before (v5 — removed)

```typescript
const presentation = await Purchasely.fetchPresentation({ placementId: 'ONBOARDING' })
const result = await Purchasely.presentPresentation({ presentation })
```

### After (v6)

```typescript
const request = Purchasely.presentation.placement('ONBOARDING').build()
const loaded = await request.preload() // resolves to a PLYLoadedPresentation when the screen is loaded
// later, when ready to show it:
const outcome = await request.display()
```

`preload()` resolves to a **`PLYLoadedPresentation`**: the presentation data (`screenId`, `placementId`, `plans`, …) **plus** `display([transition])`, `close()` and `back()` methods that delegate to the originating request. So you can also drive the lifecycle straight from the loaded object — `await loaded.display()` — instead of holding onto `request` (parity with the Flutter SDK).

***

## 5. Presentation lifecycle (show / hide / close / back)

The imperative `showPresentation` / `hidePresentation` / `closePresentation` methods are replaced by the request lifecycle:

```typescript
const request = Purchasely.presentation.placement('ONBOARDING').build()

request.display()  // show
request.close()    // hide / close
request.back()     // navigate back inside a multi‑step (Flow) presentation
```

> 🚧 `request.close()` closes everything
>
> `request.close()` currently dismisses **all** displayed presentations (the native SDK does not yet expose a per‑request close). If you stack presentations, closing one will dismiss the others.

***

## 6. Action interceptor

`setPaywallActionInterceptorCallback` + `onProcessAction` are replaced by `Purchasely.interceptAction(kind, handler)`. Register **one handler per action kind**; the handler returns the **string** `'success' | 'failed' | 'notHandled'` instead of calling `onProcessAction(true/false)`.

### Before (v5 — removed)

```typescript
Purchasely.setPaywallActionInterceptorCallback((result) => {
  if (result.action === PLYPaywallAction.PURCHASE) {
    MyPurchaseSystem.purchase(result.parameters.plan.productId)
    Purchasely.onProcessAction(false)
  } else {
    Purchasely.onProcessAction(true)
  }
})
```

### After (v6)

```typescript
import { Linking } from 'react-native'

Purchasely.interceptAction('purchase', async (info, payload) => {
  if (payload?.kind === 'purchase') {
    const ok = await MyPurchaseSystem.purchase(payload.plan.productId)
    return ok ? 'success' : 'failed'
  }
  return 'notHandled'
})

Purchasely.interceptAction('navigate', async (info, payload) => {
  if (payload?.kind === 'navigate') {
    Linking.openURL(payload.url)
    return 'success'
  }
  return 'notHandled'
})

// Cleanup
Purchasely.removeActionInterceptor('purchase')
Purchasely.removeAllActionInterceptors()
```

| Result        | Meaning                                                 |
| ------------- | ------------------------------------------------------- |
| `'success'`     | App handled the action — SDK skips its default behavior |
| `'failed'`      | App tried but failed — breaks the action chain          |
| `'notHandled'`  | SDK should handle the action itself                     |

`onProcessAction(false)` → return `'success'`; `onProcessAction(true)` → return `'notHandled'`.

Known action kinds: `close`, `closeAll`, `login`, `navigate`, `purchase`, `restore`, `openPresentation`, `openPlacement`, `promoCode`, `webCheckout`.

***

## 7. Deeplinks, campaigns & the default dismiss handler

```typescript
// Allow deeplinks (replaces readyToOpenDeeplink(true)) — set at start:
await Purchasely.builder('YOUR_API_KEY').allowDeeplink(true).start()

// Pass a deeplink to the SDK — RENAMED from isDeeplinkHandled to handleDeeplink:
const handled = await Purchasely.handleDeeplink('app://ply/presentations/')
```

> 📘 `isDeeplinkHandled` was renamed to `handleDeeplink`
>
> Like the native iOS/Android SDKs, the React Native bridge renamed this method to `Purchasely.handleDeeplink(uri)` (same signature). The v5 names `isDeeplinkHandled` and `readyToOpenDeeplink` **no longer exist** — there is no alias, so any call to `isDeeplinkHandled` fails to compile.

There are **two distinct paywall flows** — don't conflate them:

### 1. Paywalls **you** display

When your app instantiates the presentation, read the result from that request (`await display()` or `request.onDismissed(...)`):

```typescript
const outcome = await Purchasely.presentation.placement('ONBOARDING').build().display()
```

### 2. Paywalls the **SDK** opens itself (campaigns, deeplinks, Promoted IAP)

Your app never calls `display()` for these, so there is no request to attach a callback to. Register the **global default dismiss handler** instead. It is the v6 replacement for `setDefaultPresentationResultCallback` / `setDefaultPresentationResultHandler`, and mirrors the native `setDefaultPresentationDismissHandler`:

```typescript
import Purchasely from 'react-native-purchasely'

const subscription = Purchasely.setDefaultPresentationDismissHandler((outcome) => {
  // outcome: { presentation, purchaseResult, plan, closeReason, error }
  // `presentation` is always populated here — use it to tell which
  // campaign/deeplink screen closed.
  console.log(
    'SDK paywall dismissed:',
    outcome.presentation?.screenId,
    outcome.purchaseResult, // 'purchased' | 'restored' | 'cancelled' | null
    outcome.closeReason     // 'button' | 'backSystem' | 'programmatic' | null
  )
})

// Only one handler is active at a time — calling again replaces it.
// Remove it (e.g. on unmount) with either:
subscription.remove()
// …or:
Purchasely.removeDefaultPresentationDismissHandler()
```

> 📘 Platform note
>
> `closeReason` is one of `'button'`, `'backSystem'` or `'programmatic'`. System dismissals surface as `'backSystem'` on both platforms — the Android system back gesture/button and the iOS interactive swipe‑down / nav pop both map there. `error` is reserved (always `null` in 6.0).

***

## 8. Synchronize (now awaitable)

`Purchasely.synchronize()` previously returned `void` (fire‑and‑forget). The v6 native SDKs expose completion callbacks, so the bridge now returns a **`Promise<boolean>`** that resolves when the receipt synchronization completes and rejects on failure.

This is **source‑compatible**: existing fire‑and‑forget callers keep working (they just ignore the returned promise). New code can await it:

```typescript
try {
  await Purchasely.synchronize() // resolves when the sync finishes
  console.log('Synchronized')
} catch (e) {
  console.error('Synchronize failed', e) // e.g. PLYError.NoStoreConfigured
}
```

> 💡 In Observer mode after a host‑side purchase, `await Purchasely.synchronize()` before chaining a follow‑up placement so the receipt is uploaded first.

***

## 9. Removed: `presentSubscriptions()` (breaking)

`Purchasely.presentSubscriptions()` is **removed with no replacement** — the native v6 SDKs (iOS **and** Android) dropped the built‑in subscription‑list UI. This is **not** a no‑op: the method no longer exists, so any call fails to compile (TypeScript) and throws at runtime.

Build your own screen from the data APIs, which are unchanged:

```typescript
const subscriptions = await Purchasely.userSubscriptions()        // active subscriptions
const history = await Purchasely.userSubscriptionsHistory()       // full history
```

***

## 10. What's unchanged

All **core** SDK methods are unchanged in name, signature, and behaviour. Only the v5 *paywall* surface was removed (plus `synchronize`, which gained an awaitable result — see §8). The following keep working exactly as in v5:

- **User**: `userLogin`, `userLogout`, `getAnonymousUserId`, `isAnonymous`.
- **Products**: `allProducts`, `productWithIdentifier`, `planWithIdentifier`, `purchaseWithPlanVendorId`, `signPromotionalOffer`, `isEligibleForIntroOffer`, and dynamic offerings (`setDynamicOffering`, `getDynamicOfferings`, `removeDynamicOffering`, `clearDynamicOfferings`).
- **Subscriptions data**: `userSubscriptions`, `userSubscriptionsHistory`, `restoreAllProducts`, `silentRestoreAllProducts`, `userDidConsumeSubscriptionContent`.
- **Attributes**: `setUserAttributeWith{String,Number,Boolean,Date,StringArray,NumberArray,BooleanArray}`, `incrementUserAttribute`, `decrementUserAttribute`, `userAttributes`, `userAttribute`, `clearUserAttribute`, `clearUserAttributes`, `clearBuiltInAttributes`, `setAttribute`.
- **Listeners**: `addEventListener` / `removeEventListener`, `addPurchasedListener` / `removePurchasedListener`, `addUserAttributeSetListener` / `removeUserAttributeSetListener`, `addUserAttributeRemovedListener` / `removeUserAttributeRemovedListener`.
- **Client (BYOS) presentations**: `clientPresentationDisplayed`, `clientPresentationClosed`.
- **Misc**: `setLogLevel`, `setLanguage`, `setThemeMode`, `setDebugMode`, `revokeDataProcessingConsent`, `getConstants`, `close`. (`isDeeplinkHandled` was **renamed** to `handleDeeplink` — see §7.)
- **Embedded component**: `PLYPresentationView` — the `placementId` / `presentation` props still work; v6 **adds** a `request` prop so you can pass a preloaded `PresentationRequest` (parity with Flutter). Its `onPresentationClosed` receives a `{ result, plan }` `PLYPresentationViewResult` (a `ProductResult` + plan), not the 5-field outcome.

***

## Migration checklist

### Breaking (must fix)

- [ ] Replace `Purchasely.start({ … })` / `startWithAPIKey(...)` with `Purchasely.builder('…').…start()`
- [ ] If you want Purchasely to own purchases, add explicit `.runningMode('full')` (default changed to `'observer'`)
- [ ] Replace `fetchPresentation(...)` with `Purchasely.presentation.placement(id).build().preload()`
- [ ] Replace `presentPresentationForPlacement` / `presentPresentationWithIdentifier` / `presentProductWithIdentifier` / `presentPlanWithIdentifier` with the `presentation` builder + `.build().display()`
- [ ] Replace `showPresentation` / `hidePresentation` / `closePresentation` with `request.display()` / `request.close()`
- [ ] Replace `setPaywallActionInterceptorCallback` + `onProcessAction` with `interceptAction(kind, handler)` returning `'success' | 'failed' | 'notHandled'`
- [ ] Replace `setDefaultPresentationResultCallback` / `…ResultHandler` with `setDefaultPresentationDismissHandler`
- [ ] Replace `readyToOpenDeeplink(true)` with `.allowDeeplink(true)` on the builder
- [ ] Rename `isDeeplinkHandled(uri)` to `handleDeeplink(uri)` (same signature; `isDeeplinkHandled` / `readyToOpenDeeplink` no longer exist)
- [ ] Read `purchaseResult` as a string (`'purchased' | 'cancelled' | 'restored'`) instead of the `ProductResult` ordinal
- [ ] Remove `presentSubscriptions()` and build your own screen from `userSubscriptions()` / `userSubscriptionsHistory()`

### Keep as‑is

- [ ] All core / user / products / attributes / listeners methods
- [ ] `PLYPresentationView` embedded component (still accepts `placementId` / `presentation`; the `request` prop is additive)

<br />
