# Purchasely Android SDK Documentation

This guide covers the Purchasely Android SDK **v6** API for Kotlin apps. Purchasely displays **Screens** and **Presentations** configured in the Console through placements, direct `screenId` lookups, campaigns, and Flows.

> 📘 SDK v6 — what changed
>
> v6 is a major release with breaking changes. The most impactful one for new integrations is that the **default running mode is now `Observer`** (it was `Full` in v5). If you want Purchasely to handle and validate purchases, you must set `.runningMode(PLYRunningMode.Full)` explicitly. See [SDK Initialization](#sdk-initialization) and the v5→v6 migration guide.

---

## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
3. [SDK Initialization](#sdk-initialization)
4. [Displaying Presentations](#displaying-presentations)
5. [Action Interceptor](#action-interceptor)
6. [Processing Transactions](#processing-transactions)
7. [Embedded Presentations](#embedded-presentations)
8. [Preloading](#preloading)
9. [User Identification](#user-identification)
10. [Subscription Status & Entitlements](#subscription-status--entitlements)
11. [Custom User Attributes](#custom-user-attributes)
12. [Event Listeners](#event-listeners)
13. [Deeplinks & Campaigns](#deeplinks--campaigns)
14. [Alternative Stores](#alternative-stores)
15. [Troubleshooting](#troubleshooting)

---

## Requirements

| Requirement | Version |
|-------------|---------|
| minSdkVersion | 23 |
| compileSdkVersion | 36 |
| Kotlin | 2.2.x (K2 compiler) |
| Gradle | 9.3.0+ |
| Android Gradle Plugin | 9.x |
| JDK | 11 |

The reified Kotlin entry points (`interceptAction<T> { … }`, `removeActionInterceptor<T>()`) are `inline` functions targeting JVM 11. Compile your Kotlin module with `jvmTarget = 11`, or use the non-inline `Class`-based overload.

Purchasely artifacts are distributed through **Maven Central**, so make sure your project resolves dependencies from it:

```groovy build.gradle
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```

> 📘 Android TV
>
> The SDK is compatible with Android TV and declares the following in its manifest so it can run on TV devices:
> ```xml
> <uses-feature android:name="android.software.leanback" android:required="false" />
> <uses-feature android:name="android.hardware.touchscreen" android:required="false" />
> ```

---

## Installation

Add the Purchasely artifacts to your app module. **All Purchasely dependencies must share the exact same version.**

```kotlin
dependencies {
    // Core SDK — required. Contains everything except the store and the video player.
    implementation("io.purchasely:core:6.0.0-rc.1")

    // Google Play Billing — required for purchases on the Google Play Store.
    // Provides the GoogleStore class added to Purchasely.Builder.
    implementation("io.purchasely:google-play:6.0.0-rc.1")

    // Optional — video support for Screens containing video components.
    implementation("io.purchasely:player:6.0.0-rc.1")
}
```

| Dependency | Purpose |
|------------|---------|
| `io.purchasely:core` | Main SDK. Required. |
| `io.purchasely:google-play` | Google Play Billing implementation (`GoogleStore`). Required for Google Play purchases. |
| `io.purchasely:player` | Optional video player for Screens that contain videos. Auto-detected by the SDK if you don't ship your own HLS player. |

For Huawei or Amazon stores, add their Purchasely store artifact instead of, or in addition to, `google-play` (see [Alternative Stores](#alternative-stores)).

> ⚠️ Version matching is mandatory
>
> Mismatched versions cause runtime errors. Keep every Purchasely artifact on the same version:
> ```kotlin
> implementation("io.purchasely:core:6.0.0-rc.1")
> implementation("io.purchasely:google-play:6.0.0-rc.1")
> implementation("io.purchasely:player:6.0.0-rc.1")
> ```

> 📘 Google Play Billing
>
> The `io.purchasely:google-play` artifact pulls in Google Play Billing Client v8 (`com.android.billingclient:billing:8.3.0`) transitively. Do not force an older billing dependency into your project.

---

## SDK Initialization

Initialize Purchasely as early as possible — typically in your `Application.onCreate()`. `start()` does not block the main thread, so you can call other SDK methods immediately after.

### Java / fluent Builder

```kotlin
import android.app.Application
import io.purchasely.ext.Purchasely
import io.purchasely.ext.PLYRunningMode
import io.purchasely.ext.LogLevel
import io.purchasely.google.GoogleStore

class YourApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        Purchasely.Builder(applicationContext)
            .apiKey("<<X-API-KEY>>")
            .userId(null) // optional if you already know your user id
            .stores(listOf(GoogleStore()))
            .runningMode(PLYRunningMode.Full) // ⚠️ default is now Observer — set Full to handle purchases
            .logLevel(LogLevel.DEBUG)
            .allowDeeplink(true)
            .allowCampaigns(true)
            .build()
            .start { error ->
                if (error == null) {
                    // Purchasely setup is complete
                } else {
                    Log.e("Purchasely", "Initialization failed", error)
                }
            }
    }
}
```

### Kotlin DSL

`Purchasely { … }` configures **and** starts the SDK in one call. `context(...)` and `apiKey(...)` are mandatory; every other setting is a method-style setter.

```kotlin
Purchasely {
    context(applicationContext)
    apiKey("<<X-API-KEY>>")
    userId(null) // optional if you already know your user id
    stores(listOf(GoogleStore()))
    runningMode(PLYRunningMode.Full) // ⚠️ default is now Observer
    logLevel(LogLevel.WARN)
    allowDeeplink(true)
    allowCampaigns(true)
    onInitialized { error ->
        if (error == null) {
            // SDK ready
        }
    }
}
```

Custom Lint checks (`PurchaselyMissingContext`, `PurchaselyMissingApiKey`, `PurchaselyFullModeWithoutStores`) flag common mistakes at editor time.

### Running modes

> 🚧 Major v6 change — the default running mode is now `Observer`
>
> In v5 the implicit default was `Full`. In **v6 the default is `Observer`** (Purchasely observes transactions but does not process them). This change is silent — your code keeps compiling. **If you want Purchasely to handle the purchase flow and validate receipts, you must set `.runningMode(PLYRunningMode.Full)` explicitly.** If you omit it, the SDK logs a DEBUG reminder at `build()` time.
>
> Behavioral consequence: in `Observer` mode, presentations **no longer auto-close** after a purchase or restore. In v5, the implicit `Full` default appended a `close_all` action after `purchase` / `restore`. If your app relied on auto-close, set `Full`.

| Mode | Use when |
|------|----------|
| `PLYRunningMode.Full` | Purchasely handles store purchases and receipt validation. Set this explicitly. |
| `PLYRunningMode.Observer` (default) | Your app owns purchases; Purchasely observes transactions and displays Console-driven Screens. |

### Callback signature

The init callback receives a single `PLYError?` (`null` on success). The redundant `Boolean` first parameter from the v5 callback is gone.

```kotlin
.start { error ->
    if (error != null) Log.e("Purchasely", "failed", error) else Log.d("Purchasely", "ready")
}
```

If you rely on a specific subscription status at launch (e.g. offer eligibility, active subscription, or an Audience based on subscription status), wait for this callback. Otherwise you can display Screens right away — the SDK refreshes the displayed Screen once pricing and offers are fetched.

### API Key validation

The SDK validates `apiKey` at `start()`. When it is null or blank, the init callback fires with `PLYError.Configuration` ("API key not set") and the SDK stays inert (no crash). If you source the key dynamically (RemoteConfig, feature flags), ensure it is non-blank before calling `start()`.

### Storeless integration

Starting **without any store** is a first-class path in v6: Screens, analytics, campaigns, deeplinks and user attributes all work. Purchase APIs return `PLYError.NoStoreConfigured` (in Full mode) when no store is set.

### API Key location

Find your API key in the Console under [App settings / Backend & SDK configuration](https://console.purchasely.io/settings?step=backend-sdk).

---

## Displaying Presentations

Use the `PLYPresentation` builder. A prepared Presentation can be loaded with `preload` and then displayed, or fetched and displayed atomically. A presentation can be one of four types:

* **Normal**: the default behavior, a Purchasely Screen created from the Console.
* **Fallback**: a Purchasely Screen, but not the one requested (the requested one could not be found).
* **Deactivated**: no Screen is associated with that placement (possibly for a specific A/B test or audience).
* **Client**: you created a Custom Screen in the Console and should display your own UI. Use the list of plans to decide which offers to show.

```kotlin
import io.purchasely.ext.presentation.PLYPresentation
import io.purchasely.ext.presentation.PLYPresentationType
import io.purchasely.ext.presentation.PLYPurchaseResult
import io.purchasely.ext.presentation.preload
import io.purchasely.ext.presentation.display

PLYPresentation {
    placementId("onboarding")
    onCloseRequested {
        // remove view from layout hierarchy if you embed the Screen
    }
}.preload { presentation, error ->
    if (error != null) {
        Log.d("Purchasely", "Error fetching Screen", error)
        return@preload
    }

    when (presentation?.type) {
        PLYPresentationType.NORMAL,
        PLYPresentationType.FALLBACK -> {
            // Easy: just call display
            presentation.display(this@MainActivity)
        }
        PLYPresentationType.DEACTIVATED -> {
            // Nothing to display
        }
        PLYPresentationType.CLIENT -> {
            val paywallId = presentation.screenId
            val planIds = presentation.plans
            // Display your own Screen
        }
        else -> {
            // No Screen — an error was triggered
        }
    }
}
```

### Selectors

```kotlin
PLYPresentation { placementId("onboarding") } // required unless screenId is set
PLYPresentation { screenId("screen_abc123") }  // direct Console Screen lookup
```

`screenId` is the canonical Android name for a direct Console Screen identifier. To display a Flow, use its deeplink `app_scheme://ply/flows/FLOW_ID` — `flowId` is no longer exposed on the public builder (it remains read-only on a loaded `PLYPresentation`).

### Builder options

```kotlin
val prepared = PLYPresentation {
    placementId("settings")
    contentId("content_123")            // optional
    backgroundColor(0xFF101820.toInt()) // optional runtime color override
    progressColor(0xFFFFC857.toInt())   // optional runtime color override
    displayCloseButton(true)            // optional Android UI flag
    displayBackButton(true)             // optional Android UI flag
    onPresented { loaded, error -> }
    onCloseRequested { }
    onDismissed { outcome -> }
}
```

### Coroutine form

On a loaded presentation, `display(context)` / `display(context, transition)` are **non-suspend** (Java-callable, and callable inside a coroutine). Each overload returns a `PLYPresentationSession` you can `await()`:

```kotlin
lifecycleScope.launch {
    try {
        val loaded = PLYPresentation { placementId("onboarding") }.preload()
        val outcome: PLYPresentationOutcome = loaded.display(this@MainActivity).await()
        // react to outcome.purchaseResult / outcome.plan / outcome.closeReason
    } catch (e: PLYError) {
        // the presentation failed to launch or render
    }
}
```

### Atomic fetch-and-display

```kotlin
PLYPresentation { placementId("onboarding") }.display(
    context = activity,
    presentation = { loaded ->
        // Display has been triggered for this loaded Screen.
    },
    callback = { outcome ->
        // Final dismissal result.
    }
)
```

`display(context) { outcome }` fires on **final dismissal**. Do not use it as a "display triggered" callback — use the `presentation` parameter above for that.

### The dismissal outcome

Display / dismissal callbacks receive a single `PLYPresentationOutcome`:

```kotlin
data class PLYPresentationOutcome(
    val presentation: PLYPresentation?,
    val purchaseResult: PLYPurchaseResult?,
    val plan: PLYPlan?,
    val closeReason: PLYCloseReason? = null,
    val error: PLYError? = null,
)
```

```kotlin
loaded.display(context) { outcome ->
    if (outcome.error != null) {
        showError(outcome.error)
        return@display
    }
    when (outcome.purchaseResult) {
        PLYPurchaseResult.PURCHASED -> trackPurchase(outcome.plan)
        PLYPurchaseResult.RESTORED  -> refreshEntitlements()
        PLYPurchaseResult.CANCELLED -> Unit
        null -> Unit
    }
}
```

### Close

```kotlin
// Close the currently displayed presentation
PLYPresentation { placementId("onboarding") }.preload { presentation, error ->
    presentation?.close()
}

// Or close all opened Purchasely Screens at any time
Purchasely.closeAllScreens()
```

### `onCloseRequested`

`onCloseRequested` fires when the user **requests** a close (e.g. taps the X). The actual dismissal, with the purchase outcome, is delivered by `onDismissed` or the `display()` result handler.

### Default presentation result handler

When a Screen is opened from a deeplink or a campaign, your app does not instantiate it, so no per-display callback fires. Register a default handler to receive the result:

```kotlin
Purchasely.setDefaultPresentationResultHandler { outcome ->
    when (outcome.purchaseResult) {
        PLYPurchaseResult.PURCHASED -> Log.d("Purchasely", "Purchased ${outcome.plan}")
        PLYPurchaseResult.CANCELLED -> Log.d("Purchasely", "Cancelled purchase of ${outcome.plan}")
        PLYPurchaseResult.RESTORED  -> Log.d("Purchasely", "Restored ${outcome.plan}")
        null -> {}
    }
}
```

---

## Action Interceptor

The v6 interceptor is registered **per action** and returns a `PLYInterceptResult`. It works in both Full and Observer mode.

```kotlin
import io.purchasely.ext.PLYInterceptResult
import io.purchasely.ext.interceptAction
import io.purchasely.ext.presentation.PLYPresentationAction

Purchasely.interceptAction<PLYPresentationAction.Login> { info, _ ->
    val activity = info.activity ?: return@interceptAction PLYInterceptResult.NOT_HANDLED
    presentLogin(activity) { userLoggedIn ->
        Purchasely.userLogin("MY_USER_ID")
        // The login flow is handled by your app
    }
    PLYInterceptResult.SUCCESS
}

Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
    presentTermsAndConditions(info.activity) { accepted ->
        // Display your terms & conditions, then proceed
    }
    PLYInterceptResult.NOT_HANDLED // let the SDK perform the purchase
}
```

### Result values

| Result | Meaning |
|--------|---------|
| `SUCCESS` | App handled the action; SDK skips its default behavior. |
| `FAILED` | App tried but failed; the action chain stops. |
| `NOT_HANDLED` | SDK should continue with its default behavior. |

### Action types

`PLYPresentationAction` is a **sealed class**; each variant carries its own type-safe parameters:

| Action | Parameters |
|--------|------------|
| `PLYPresentationAction.Purchase` | `plan`, `subscriptionOffer`, `offer` |
| `PLYPresentationAction.Restore` | — |
| `PLYPresentationAction.Login` | — |
| `PLYPresentationAction.Close` | `closeReason` |
| `PLYPresentationAction.CloseAll` | `closeReason` |
| `PLYPresentationAction.Navigate` | `url`, `title` |
| `PLYPresentationAction.OpenPresentation` | `presentationId` |
| `PLYPresentationAction.OpenPlacement` | `placementId` |
| `PLYPresentationAction.PromoCode` | — |
| `PLYPresentationAction.WebCheckout` | `url`, `clientReferenceId`, … |

### Removing interceptors

```kotlin
Purchasely.removeActionInterceptor<PLYPresentationAction.Purchase>()
Purchasely.removeAllActionInterceptors()
```

---

## Processing Transactions

In **Full** mode, Purchasely performs purchases from Presentation buttons, validates receipts, and manages entitlements automatically. You only need to fetch the subscription status afterwards (see [Subscription Status & Entitlements](#subscription-status--entitlements)).

In **Observer** mode, intercept the purchase and restore actions, run your own billing flow, then call `Purchasely.synchronize()` after success so Purchasely receives the transaction state. Suspend the interceptor until your billing flow returns so you can resolve `PLYInterceptResult` exactly once.

```kotlin
Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
    val subscriptionId = purchase.subscriptionOffer?.subscriptionId
    val basePlanId = purchase.subscriptionOffer?.basePlanId
    val offerId = purchase.subscriptionOffer?.offerId
    val offerToken = purchase.subscriptionOffer?.offerToken

    suspendCancellableCoroutine { continuation ->
        startBilling(info.activity, purchase.plan.store_product_id, offerToken) { result ->
            if (continuation.isActive) continuation.resume(
                when (result) {
                    BillingResult.SUCCESS   -> { Purchasely.synchronize(); PLYInterceptResult.SUCCESS }
                    BillingResult.CANCELLED -> PLYInterceptResult.NOT_HANDLED
                    else                    -> PLYInterceptResult.FAILED
                }
            )
        }
    }
}

Purchasely.interceptAction<PLYPresentationAction.Restore> { info, _ ->
    MyPurchaseSystem.restoreAllPurchases()
    Purchasely.synchronize() // synchronize all purchases with Purchasely
    PLYInterceptResult.SUCCESS
}
```

### `synchronize()` with callbacks

`Purchasely.synchronize()` gains optional completion callbacks in v6 and refreshes the subscriptions cache before firing `onSuccess`. Both parameters default to `null`, so existing `Purchasely.synchronize()` calls keep working.

```kotlin
Purchasely.synchronize(
    onSuccess = { plan -> /* refresh UI; plan is the validated PLYPlan or null */ },
    onError = { error -> /* surface failure */ }
)
```

---

## Embedded Presentations

Use `display()` for standard modal/Flow display. Use the embedded APIs only when your app must own the container. Build the view from a **loaded** presentation (preload first).

### Android View

```kotlin
PLYPresentation {
    placementId("onboarding")
    onCloseRequested {
        // remove the view from your layout hierarchy
    }
}.preload { loaded, error ->
    if (error != null || loaded == null) return@preload

    val screenView = loaded.buildView(context) { outcome ->
        when (outcome.purchaseResult) {
            PLYPurchaseResult.PURCHASED -> Log.d("Purchasely", "User purchased ${outcome.plan?.name}")
            PLYPurchaseResult.CANCELLED -> Log.d("Purchasely", "User cancelled purchase")
            PLYPurchaseResult.RESTORED  -> Log.d("Purchasely", "User restored ${outcome.plan?.name}")
            null -> {}
        }
    }

    findViewById<FrameLayout>(R.id.container).addView(screenView)
}
```

### Fragment

```kotlin
PLYPresentation { placementId("onboarding") }.preload { loaded, error ->
    if (error != null || loaded == null) return@preload
    val fragment = loaded.getFragment { outcome -> }
    supportFragmentManager.beginTransaction()
        .replace(R.id.container, fragment)
        .commit()
}
```

### Jetpack Compose

The SDK does not ship a Compose wrapper. Preload first, then wrap `buildView(...)` in an `AndroidView` (`loaded` is the preloaded `PLYPresentation`):

```kotlin
AndroidView(
    modifier = Modifier
        .fillMaxSize()
        .padding(0.dp, 5.dp),
    factory = { context ->
        loaded.buildView(context) { outcome ->
            // remove this component to close the Purchasely Screen
        }
    }
)
```

---

## Preloading

Pre-fetch a Screen from the network before displaying it. This lets you display only after the Screen is loaded, handle network errors gracefully, show a custom loading state, and pre-load while users navigate through onboarding.

```kotlin
var cached: PLYPresentation? = null

lifecycleScope.launch {
    cached = PLYPresentation { placementId("premium_feature") }.preload()
}

button.setOnClickListener {
    cached?.display(activity) { outcome -> }
}
```

Builder, prepared and loaded presentations all expose `state: StateFlow<PLYPresentationState>`:

```kotlin
val prepared = PLYPresentation { placementId("onboarding") }

lifecycleScope.launch {
    prepared.state.collect { state ->
        when (state) {
            PLYPresentationState.Idle -> Unit
            PLYPresentationState.Loading -> showLoading()
            PLYPresentationState.Loaded -> hideLoading()
            PLYPresentationState.Displayed -> Unit
            is PLYPresentationState.Dismissed -> handle(state.outcome)
            is PLYPresentationState.Error -> showError(state.error)
        }
    }
}
```

---

## User Identification

A subscription made with Google must be linked to an identifier. Provide your own user id so purchases and subscriptions follow the user across devices, instead of being tied to an anonymous, device-bound id.

```kotlin
// Authenticate a user (no network connection required; saved across sessions)
Purchasely.userLogin("123456789")

// With a callback to know whether entitlements should be refreshed after an automatic transfer
Purchasely.userLogin("123456789") { refresh ->
    if (refresh) {
        // Call your backend to refresh user entitlements
    }
}

// Sign out — clears the user id and all built-in & custom user attributes
Purchasely.userLogout()

// Prevent Purchasely from clearing custom user attributes on logout
Purchasely.userLogout(clearUserAttributes = false)
```

Call `userLogin` before loading Screens that depend on identified-user audiences. Retrieve the auto-generated anonymous id when needed:

```kotlin
val anonymousId = Purchasely.anonymousUserId
```

### Login from a Purchasely Screen

Every presentation has an *Already subscribed? Sign-in* button (shown when no user id is set). Intercept it with the action interceptor and notify the SDK when the login flow completes:

```kotlin
Purchasely.interceptAction<PLYPresentationAction.Login> { info, _ ->
    val activity = info.activity ?: return@interceptAction PLYInterceptResult.NOT_HANDLED
    presentLogin(activity) { userLoggedIn ->
        Purchasely.userLogin("MY_USER_ID") // call before returning to update the Screen
    }
    PLYInterceptResult.SUCCESS
}
```

---

## Subscription Status & Entitlements

In **Full** mode, fetch active subscriptions directly from the SDK to manage entitlements at the app level.

```kotlin
Purchasely.userSubscriptions(
    onSuccess = { subscriptions ->
        // Each subscription contains the plan purchased and the source it was bought from.
        // To let a user cancel, call Purchasely.displaySubscriptionCancellationInstruction(activity)
        // which shows a dialog explaining how to unsubscribe via the Google Play settings.
    },
    onError = { throwable ->
        Log.e("Purchasely", "Subscription fetch failed", throwable)
    }
)
```

Force a refresh by invalidating the cache:

```kotlin
Purchasely.userSubscriptions(
    invalidateCache = true,
    onSuccess = { subscriptions -> },
    onError = { throwable -> }
)
```

### Subscriptions history

Retrieve expired subscriptions (the user's history) — useful for analytics and engagement strategies. `userSubscriptionsHistory()` fetches from the Purchasely backend.

```kotlin
Purchasely.userSubscriptionsHistory(
    onSuccess = { subscriptions ->
        // Past subscriptions
    },
    onError = { throwable ->
        // Display error
    }
)
```

> 📘 Removed in v6
>
> The local-storage purchase history methods `Purchasely.purchaseHistory()` and `Purchasely.isPastSubscriber()` were removed (Google Play Billing v8 no longer exposes the underlying data). Use `userSubscriptionsHistory()` instead, and derive past-subscriber state from it.

### Plan offer methods

All `intro*` / `INTRO_*` / `TRIAL_*` APIs were removed in favor of unified `offer*` / `OFFER_*` equivalents (direct renames with identical behavior):

| Removed | Replacement |
|---------|-------------|
| `hasIntroductoryPrice()` | `hasOfferPrice()` |
| `isEligibleToIntroOffer()` | `isEligibleToOffer()` |
| `localizedIntroductoryPrice()` | `localizedOfferPrice()` |
| `PLYPlanTags.INTRO_PRICE` / `TRIAL_PRICE` | `PLYPlanTags.OFFER_PRICE` |

> 📘 Removed UI in v6
>
> The built-in subscription management and cancellation-survey UI was removed (`subscriptionsFragment()`, all `PLYSubscriptions*` / `PLYSubscriptionDetail*` / `PLYSubscriptionCancellation*` views, and the `ply/subscriptions` / `ply/cancellation_survey` deeplinks). Build your own UI from `userSubscriptions()` and `userSubscriptionsHistory()`.

---

## Custom User Attributes

Set, retrieve, increment/decrement and clear custom attributes to segment users and build audiences. Value types must match the type configured in the Console for that key.

In v6, mutation methods return `Deferred<Boolean>` (success/failure). You can ignore the return value for fire-and-forget behavior, or `await()` it.

```kotlin
// Set a single attribute
Purchasely.setUserAttribute("age", 20)
val success = Purchasely.setUserAttribute("favorite_spirit", "gin").await()

// Set multiple attributes
Purchasely.setUserAttributes(mapOf(
    Pair("age", 21),
    Pair("gender", "man"),
    Pair("hair", "brown"),
))

// Retrieve attributes
val age = Purchasely.userAttribute("age")
val all = Purchasely.userAttributes()
all.forEach { attribute ->
    Log.d("Purchasely", "Attribute ${attribute.key} = ${attribute.value}")
}

// Increment / decrement counters (created if not set)
Purchasely.incrementUserAttribute("viewed_articles")
Purchasely.incrementUserAttribute("viewed_articles", 3)
Purchasely.decrementUserAttribute("viewed_articles")
Purchasely.decrementUserAttribute("viewed_articles", 7)

// Clear attributes
Purchasely.clearUserAttribute("age")
Purchasely.clearUserAttributes()
```

Affected mutation methods returning `Deferred<Boolean>`: `setUserAttribute(s)`, `clearUserAttribute(s)`, `incrementUserAttribute`, `decrementUserAttribute`.

### Custom User Attribute listener

When a user answers a Survey configured in the Screen Composer, the SDK can set a Custom User Attribute and hand it to your app through the event listener. The `source` parameter (`PLYUserAttributeSource.PURCHASELY` vs `CLIENT`) tells you whether the change came from Purchasely or from your own app — you can usually ignore `CLIENT` updates since your app already has that data.

---

## Event Listeners

Implement an event listener to forward Purchasely UI/SDK events to your own analytics. Set it after starting the SDK.

```kotlin
import io.purchasely.ext.EventListener
import io.purchasely.ext.PLYEvent

private val eventListener = object : EventListener {
    override fun onEvent(event: PLYEvent) {
        when (event) {
            PLYEvent.LoginTapped -> Log.d("Purchasely", "Login tapped, open login page")
            else -> Log.d("Purchasely", "Event: ${event.name}")
        }
    }
}

Purchasely.eventListener = eventListener
```

UI/SDK events are computed by the Purchasely Platform for conversion KPIs but, unlike Server events, cannot be routed to third-party integrations from the Console — forward them yourself from the app if you need them in your analytics.

---

## Deeplinks & Campaigns

### Passing the deeplink to the SDK

In v6, the SDK automatically reads the foreground activity's intent (on create and resume) and routes its own URIs to the deeplink handler — **you no longer need to call `handleDeeplink(uri)` yourself.** Existing manual calls keep working and are deduped.

```kotlin
class MyActivity : FragmentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Optional in v6 (auto-intercepted). Still valid for explicit handling:
        val data = intent.data
        if (data != null) {
            val isHandledByPurchasely = Purchasely.handleDeeplink(data)
        }
    }
}
```

Opt out of automatic handling with `.automaticDeeplinkHandling(false)`. For a cold start from a deeplink, pass it to the builder with `.handleDeeplink(intent.data)`.

> 🚧 `singleTask` / `singleTop` activities
>
> If a deeplink arrives in `onNewIntent` and you do **not** call `setIntent(intent)`, the URI is hidden from auto-interception. Call `setIntent(intent)` or keep the manual `handleDeeplink(uri)` call.

### `allowDeeplink` and `allowCampaigns`

`allowDeeplink` now **defaults to `true`** (it was `false` in v5). Campaigns have their own flag, `allowCampaigns` (also default `true`), separate from deeplinks. Use `allowCampaigns = false` during startup/onboarding to defer automated campaign display.

```kotlin
Purchasely.allowDeeplink = true    // deeplink presentations
Purchasely.allowCampaigns = false  // campaigns stay queued (e.g. during onboarding)
Purchasely.allowCampaigns = true   // queued campaigns display immediately
```

To restore the v5 deferred-deeplink behavior, start with `allowDeeplink(false)` and flip it once the UI is ready:

```kotlin
Purchasely.Builder(context).allowDeeplink(false).build()
// later, when ready:
Purchasely.allowDeeplink = true
```

Preview deeplinks (Console QR codes with `?preview=1`) always display immediately, bypassing `allowDeeplink`.

### Supported deeplink formats

The SDK supports `app_scheme://ply/...` (where `app_scheme` is your declared scheme) and, on Android only, universal links like `https://www.myapp.com/ply/...`:

```
app_scheme://ply/presentations/PRESENTATION_ID   // a specific Screen
app_scheme://ply/presentations                   // your default Screen
app_scheme://ply/placements/PLACEMENT_ID          // a placement
app_scheme://ply/placements                       // your default placement
app_scheme://ply/flows/FLOW_ID                    // a Flow
app_scheme://ply/update_billing                   // open Play Store billing settings
```

Use `setDefaultPresentationResultHandler` (see [Displaying Presentations](#displaying-presentations)) to receive the result of a Screen opened from a deeplink.

---

## Alternative Stores

On Android you choose which store(s) to use: Google Play Store, Amazon Appstore, or Huawei AppGallery. You may pass several — the first one available on the device is used. Each store has its own Purchasely dependency that you must install at the matching version.

```kotlin
Purchasely.Builder(applicationContext)
    .apiKey("<<X-API-KEY>>")
    .stores(listOf(GoogleStore(), HuaweiStore(), AmazonStore()))
    .runningMode(PLYRunningMode.Full)
    .build()
    .start { error -> }
```

For example, with `listOf(GoogleStore(), AmazonStore())`, if Google Play Billing is available on the device it is the store used by the SDK.

---

## Troubleshooting

| Symptom | Check |
|---------|-------|
| Presentation does not display | Placement ID or `screenId`, the SDK initialization callback, and network logs. |
| Close result is missing | Use `display(context) { outcome }` or `onDismissed { outcome }` (not `onCloseRequested`, which only signals the user's close request). |
| Purchases do not validate / Screen does not auto-close after purchase | You are likely in the new default `Observer` mode. Set `.runningMode(PLYRunningMode.Full)`. |
| Observer purchase does not update access | Call `Purchasely.synchronize()` after your billing flow succeeds. |
| `PLYError.NoStoreConfigured` on purchase | No store was provided in Full mode; add `GoogleStore()` (or another store) to `.stores(...)`. |
| Deeplink does nothing | Ensure `Purchasely.allowDeeplink = true`; for `singleTask`/`singleTop` activities call `setIntent(intent)` in `onNewIntent`. |
| `interceptAction<T>` does not compile | Compile with `jvmTarget = 11`, or use the `Class`-based overload. |
| Wrong Screen appears | Verify placement mapping, audience targeting, user attributes, and campaigns. |

Enable verbose logs during integration with `.logLevel(LogLevel.DEBUG)`. In v6, custom loggers receive **all** messages regardless of `logLevel`; the new `Purchasely.logcatEnabled` flag (set at init with `.logcatEnabled(false)`) controls Logcat output independently.

For the full list of v5→v6 breaking changes, see the [Migrating to v6 — Android](https://docs.purchasely.com/migrating-from-v5-to-v6-android) guide.
