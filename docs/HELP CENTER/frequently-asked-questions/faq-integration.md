---
title: Integration & getting started
excerpt: >-
  The minimal path to a working paywall and reliable entitlements, running modes,
  SDK footprint, and what does or does not require an app release.
deprecated: false
hidden: false
metadata:
  title: 'FAQ: Integration & getting started'
  description: >-
    Minimal Purchasely integration path, Full vs Observer mode, entitlement
    architecture, SDK initialization behavior, and what can be changed without
    shipping a new app version.
  robots: index
next:
  description: ''
---
# What is the minimal integration path to get a working paywall and reliable entitlements?

Three pillars. A first operational paywall is typically live in a few hours.

## 1. Console configuration (no-code)

* Create the application, connect it to the stores (App Store, Play Store) and import your catalogue (Products and Plans).
* Design the Screen in the [Screen Composer](screen-composer).
* Attach the Screen to a [Placement](displaying-screens-placements) (onboarding funnel, settings, home…).

📚 [Application setup guide](application-setup)

## 2. SDK integration

```swift Swift
// 1. Initialize at launch
Purchasely
    .apiKey("<<X-API-KEY>>")
    .runningMode(.full) // ⚠️ default is .observer
    .storekitSettings(.storeKit2)
    .start { error in
        print(error == nil)
    }

// 2. Identify the user before any paywall is shown
Purchasely.userLogin(with: "your_opaque_id")

// 3. Display
PLYPresentationBuilder
    .forPlacementId("my_placement")
    .build()
    .preload { presentation, error in
        presentation?.display(from: myUIViewController)
    }
```
```kotlin Kotlin
// 1. Initialize at launch
Purchasely {
    context(applicationContext)
    apiKey("<<X-API-KEY>>")
    stores(listOf(GoogleStore()))
    runningMode(PLYRunningMode.Full) // ⚠️ default is Observer
    onInitialized { error ->
        if (error == null) { /* ready */ }
    }
}

// 2. Identify the user before any paywall is shown
Purchasely.userLogin("your_opaque_id")

// 3. Display
PLYPresentation {
    placementId("my_placement")
}.build().display(context)
```

📚 [SDK installation](sdk-installation) · [SDK initialization](sdk-initialization) · [Displaying Screens with Placements](displaying-screens-placements)

## 3. Entitlement architecture

Two complementary approaches:

| Approach                                          | How it works                                                                                                            | Best for                                                                            |
| :------------------------------------------------ | :---------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------- |
| [Backend entitlements](backend-entitlements)      | Our S2S webhooks (`ACTIVATE` / `DEACTIVATE`) make your server the single source of truth.                               | Production. Reliable cross-device experience, independent of the device.            |
| [SDK entitlements](dashboard-subscription-status) | Query the subscription status directly from the SDK.                                                                     | Offline behavior and immediate UI gating at launch.                                 |

> 📘 Recommended pattern
>
> Use your backend as the absolute reference and the SDK as a local cache for responsiveness at launch. Call `Purchasely.synchronize()` when the app returns to the foreground.

<br />

# Full mode or Observer mode — which one should I pick?

| Mode                            | Who owns the purchase flow                                                                | When to choose it                                                                                                     |
| :------------------------------ | :---------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------- |
| [Full mode](full-mode)          | Purchasely triggers the purchase, validates and acknowledges the receipt, manages rights. | New apps, or apps that want a complete subscription infrastructure.                                                    |
| [Observer mode](observer-mode)  | You keep your existing transactional logic (in-house, RevenueCat…).                       | Apps with an established IAP system that want the no-code, A/B testing and analytics layer without touching purchases. |

> ⚠️ In SDK 6, the default running mode is **Observer**
>
> If you want Purchasely to handle purchases, you must explicitly set `runningMode` to Full. This is a change from SDK 5, where Full was the default.

Both modes give you the full no-code feature set: Screen Composer, Placements, Audiences, A/B tests, Flows, Campaigns and analytics.

<br />

# Where should `start()` be called?

As early as possible in the app lifecycle — `AppDelegate` / `App` on iOS, `Application.onCreate()` on Android — and **once** per process. Calling it later means the first Placement request may fire before the SDK is configured.

Set the user identifier **before** the first paywall is displayed, either via `appUserId` / `userId` in the builder if you already know it, or via `Purchasely.userLogin()` as soon as your session is restored.

📚 [SDK initialization](sdk-initialization) · [Identifying users](user-identification)

<br />

# What happens if the SDK fails to start (no network, timeout)?

`start()` returns an error in its completion block and the SDK retries in the background. Practical consequences:

* **Do not gate your app launch on a successful `start()`.** Render your UI, and let paywall display fail gracefully.
* Always handle the error branch of the fetch/display call and provide a fallback path (skip the paywall, or show a native screen).
* Because Screens are fetched from our servers, [pre-fetching](pre-fetching) at launch removes most of the perceived latency on the first display.

<br />

# Do I have to resolve every action interceptor?

Yes. **Every interceptor must return a result** telling the SDK how your app handled the action:

| Result        | Effect                                                                                                      |
| :------------ | :---------------------------------------------------------------------------------------------------------- |
| `SUCCESS`     | The action succeeded. The chain continues to the next action on that button. In Observer mode, `purchase` and `restore` also trigger synchronization automatically. |
| `FAILED`      | Stops the chain, the remaining actions are skipped, and the button leaves its loading state.                  |
| `NOT_HANDLED` | You did not handle it — the SDK performs its own default behavior for that action.                            |

```swift Swift
Purchasely.interceptAction(.purchase) { info, params, completion in
    guard let productId = params?.plan?.appleProductId else {
        return completion(.notHandled)
    }
    myBillingStack.purchase(productId) { ok in
        completion(ok ? .success : .failed)
    }
}
```
```kotlin Kotlin
Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
    val activity = info?.activity ?: return@interceptAction PLYInterceptResult.NOT_HANDLED
    when (myBillingStack.launch(activity, purchase)) {
        BillingResult.SUCCESS -> PLYInterceptResult.SUCCESS
        else -> PLYInterceptResult.FAILED
    }
}
```

Notes that matter in practice:

* On Kotlin, the reified form above is a **suspend** lambda — you *return* the result. There is also a `Class`-based overload for non-coroutine call sites, `Purchasely.interceptAction(PLYPresentationAction.Purchase::class.java) { info, action, result -> … }`, where you must call `result` **exactly once**, synchronously or after your async work.
* An action with **no registered interceptor** is performed by the SDK, so a button never stays stuck spinning. The risk is the opposite: registering an interceptor and then never resolving it.
* Actions run **in order** and only advance if the previous one succeeded. A `purchase` that fails will not run the `open_screen` configured after it.
* **Do not intercept `open_presentation` or `open_placement`** unless you have discussed it with us — overriding them breaks A/B test, Audience and Campaign tracking.

📚 [Paywall action interceptor](action-interceptor) · [Processing transactions with the interceptor](process-transactions-with-paywall-action-interceptor) · [Action types](action-types)

<br />

# Which parameters do I get in the interceptor, and which can be null?

The payload differs by platform, and this is where most integration surprises come from.

**iOS** — the action carries a `params` object and an `info` object:

| What you need                              | Where it is                                                                 |
| :----------------------------------------- | :-------------------------------------------------------------------------- |
| The store product to purchase              | `params?.plan?.appleProductId` — **optional**, guard it and return `.notHandled` |
| A promotional offer                        | `params?.promoOffer?.storeOfferId`                                           |
| 12-month commitment billing plan           | `params?.billingPlanType` — `upFront`, `monthly` or `unspecified`            |
| Web checkout data                          | `params?.url`, `params?.clientReferenceId`, `params?.queryParameterKey`, `params?.webCheckoutProvider` |
| The presenting controller                  | `info?.controller`                                                          |
| Targeting context                          | `info?.presentation?.placementId` / `.audienceId` / `.abTestId` / `.abTestVariantId` / `.campaignId`, and `info?.contentId` |

**Android** — there is no wrapper parameters object any more: the fields live **on the action subclass itself**.

| Action              | Fields                                                                          |
| :------------------ | :------------------------------------------------------------------------------ |
| `Purchase`          | `plan`, `subscriptionOffer` (**nullable**), `offer`                              |
| `Close` / `CloseAll`| `closeReason`                                                                    |
| `Navigate`          | `url`, `title`                                                                   |
| `OpenPresentation`  | `presentationId`                                                                 |
| `OpenPlacement`     | `placementId`                                                                    |
| `WebCheckout`       | `url`, `clientReferenceId`, `queryParameterKey`, `webCheckoutProvider`            |
| `Restore` / `Login` / `PromoCode` | no parameters                                                      |

For a Google Play purchase you typically read `purchase.subscriptionOffer?.subscriptionId`, `?.basePlanId`, `?.offerId` and `?.offerToken`. Because `subscriptionOffer` is nullable, always handle the null branch rather than force-unwrapping — that is the usual cause of a paywall button that does nothing on a plan without an offer.

> ❗️ `planVendorId` is not part of the interceptor payload
>
> It is a Dynamic Offering input and a field of `PLYPresentationPlan`. If you need the Purchasely-side plan reference in the interceptor, read it from the `plan` object you are given.

Migrating from v5? The `proceed` closure is gone: `processAction(false)` becomes `.success` and `processAction(true)` becomes `.notHandled`. To detach an interceptor, use `removeActionInterceptor(...)` or `removeAllActionInterceptors()`.

<br />

# In Observer mode, when do I have to call `synchronize()`?

Less often than most integrations assume.

| Situation                                                                        | What to do                                                                          |
| :------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------- |
| Purchase or restore made **through the paywall**, bridged via the interceptor      | **Nothing.** Returning the success result already triggers synchronization for you.  |
| Purchase made **outside** the paywall — your own store screen, a BYOS Custom Screen | Call `Purchasely.synchronize()` yourself once your billing flow completes.            |

```swift Swift
Purchasely.synchronize(success: { }, failure: { error in })
```
```kotlin Kotlin
Purchasely.synchronize(
    onSuccess = { plan -> /* plan is the validated PLYPlan, or null */ },
    onError = { error -> }
)
```

On Android the subscriptions cache is refreshed **before** `onSuccess` fires, so a normal cached `userSubscriptions(...)` read from that callback already returns the fresh entitlements — no polling with an arbitrary delay.

> ⚠️ `NOT_HANDLED` does nothing useful on purchase / restore in Observer mode
>
> Purchasely never processes those actions in Observer mode, so returning `.notHandled` logs a warning and skips. Return the success or failure result instead.

> ❗️ Finishing the transaction stays your responsibility
>
> In Observer mode the SDK observes the receipt for analytics but does **not** finish the transaction (App Store) or acknowledge it (Google Play). Your own billing code must still do that.

📚 [Observer mode](observer-mode) · [Checking your integration in Observer mode](checking-your-purchasely-integration-observer-mode)

<br />

# Do I need to ship a new app version every time I change a paywall?

No. Screens, Placements, Audiences, A/B tests, Flows, Campaigns and localizations are all resolved server-side. You publish in the Console and the change reaches your users without a release.

An app release is only required when:

* you upgrade the SDK itself (new major features, new component *types*),
* you add a new Placement identifier that does not exist in your code yet,
* you change your own native code (interceptor logic, entitlement gating, deeplink handling).

<br />

# Does a new Screen Composer component or layout require an SDK update?

In most cases, no — new components and layouts are rendered by the existing SDK. An SDK update is only needed when a component brings a genuinely new capability or a new rendering primitive (video is the classic example).

The Console warns you when a Screen uses a component that requires a minimum SDK version, and you can configure a legacy Screen as a fallback for older SDK versions still in the wild.

📚 [SDK versions dashboard](sdk-versions) — to know what SDK versions your installed base actually runs.

<br />

# How large is the SDK?

Under 2 MB on iOS and under 1 MB on Android. Both are native (Swift / Kotlin), with no heavyweight runtime dependency.

<br />

# Which platforms are supported?

| Platform      | Language               | Package                                                                          |
| :------------ | :--------------------- | :------------------------------------------------------------------------------- |
| iOS           | Swift / Objective-C    | `pod 'Purchasely'` or Swift Package Manager — [guide](installation-swift)         |
| Android       | Kotlin / Java          | `io.purchasely:core` (Maven) — [guide](installation-kotlin)                       |
| React Native  | TypeScript             | `react-native-purchasely` — [guide](installation-react-native)                    |
| Flutter       | Dart                   | `purchasely_flutter` — [guide](installation-flutter)                              |
| Cordova       | JavaScript             | `@purchasely/cordova-plugin-purchasely` — [guide](installation-cordova)           |

<br />

# On React Native, Flutter and Cordova, why do I need a second package for Google Play?

The main cross-platform package does not embed Google Play Billing, so that iOS-only apps do not carry it. Add the store package explicitly:

| Platform      | Main package                              | Google Play Billing                                |
| :------------ | :---------------------------------------- | :------------------------------------------------- |
| React Native  | `react-native-purchasely`                 | `@purchasely/react-native-purchasely-google`       |
| Flutter       | `purchasely_flutter`                      | `purchasely_google`                                |
| Cordova       | `@purchasely/cordova-plugin-purchasely`   | `@purchasely/cordova-plugin-purchasely-google`     |

> ❗️ Keep both packages on the **exact same version**
>
> A version mismatch between the main package and the store package is one of the most common causes of prices not resolving on Android.

<br />

# Can I run Purchasely alongside RevenueCat or my own IAP code?

Yes — that is exactly what [Observer mode](observer-mode) is for. Purchasely observes transactions without processing them, and you keep your receipt validation and entitlement logic. You still get the Screen Composer, Placements, Audiences, A/B tests and analytics.

📚 [Checking your integration in Observer mode](checking-your-purchasely-integration-observer-mode) · [Using Purchasely in existing apps](using-purchasely-in-existing-apps)

<br />

# How do I test before going live?

1. Enable [Debug Mode](debug-mode) on your test device by scanning the Preview QR code from the Console. You then see draft Screens, plus the SDK version, user IDs, Placement, Audience, A/B test and variant actually resolved for that device.
2. Target the built-in `Internal Testers` Audience with the highest priority so only debug devices see the experience under test.
3. Use the [Preview](preview) in the Console for layout checks, and a real device for anything store-related (prices, eligibility, purchase flow).

📚 [Checking your Purchasely integration](sdk-integration-checking-full-mode)

<br />

# I am on SDK 5 — how do I move to SDK 6?

Follow the migration guide for your platform:

* [Android](migrating-from-v5-to-v6-android)
* [iOS](migrating-from-v5-to-v6-ios)
* [React Native](migrating-from-v5-to-v6-react-native)
* [Flutter](migrating-from-v5-to-v6-flutter)
* [Cordova](migrating-from-v5-to-v6-cordova)

The two changes that catch teams out most often: the **default running mode is now Observer**, and Google Play Billing is integrated directly by the Android SDK (see [Google Play Billing v8](google-play-billing-v8) if you are still on 5.x).
