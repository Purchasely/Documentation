---
title: Migrating to v6 — Android
excerpt: Breaking changes and migration steps to upgrade the Purchasely Android SDK from v5.x to v6.0.0-rc.1
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
This guide covers the **native Android SDK** (Kotlin & Java). For other platforms, see the [iOS guide](migrating-from-v5-to-v6-ios) or the platform pages listed on the [migration overview](migrating-from-sdk-5-to-6).

> 📘 Scope
>
> Every "Before" example reflects the public **v5** API as shipped in the last v5.x release. If a snippet does not match what your project compiled against, reach out to the Customer Success team.

***

## Summary of breaking changes

| v5 | v6 |
|----|----|
| Default running mode `Full` | Default running mode **`Observer`** ⚠️ |
| `PLYRunningMode.PaywallObserver` | `PLYRunningMode.Observer` |
| `setPaywallActionsInterceptor { … }` | `interceptAction<PLYPresentationAction.X> { … }` |
| `PLYPresentationAction` (enum) | `PLYPresentationAction` (sealed class) |
| `PLYPresentationActionParameters` | parameters carried by each action subclass |
| `readyToOpenDeeplink` | `allowDeeplink` (now defaults to `true`) |
| `isDeeplinkHandled(uri, activity)` | `handleDeeplink(uri, activity)` (auto‑intercepted) |
| `Purchasely.fetchPresentation(...)` | `PLYPresentation { … }.preload()` |
| `Purchasely.presentationView(...)` | `presentation.buildView(context) { … }` |
| `PLYPresentation.id` | `PLYPresentation.screenId` |
| `onClose` | `onCloseRequested` |
| `PLYProductViewResult` | `PLYPurchaseResult` inside `PLYPresentationOutcome` |
| `io.purchasely.ext.*` (presentation types) | `io.purchasely.ext.presentation.*` |
| `start { isConfigured, error -> }` | `start { error -> }` |

> 📘 `screenId` is the canonical Android public name for a direct Screen lookup. The name `presentationId` is kept internally only.

***

## 1. Update dependencies

```kotlin
dependencies {
    implementation("io.purchasely:core:6.0.0-rc.1")
    implementation("io.purchasely:google-play:6.0.0-rc.1")
    implementation("io.purchasely:player:6.0.0-rc.1") // optional, video support
}
```

Build requirements: **Gradle 9.3.0+**, **Kotlin 2.2.x** (K2 compiler), JDK 11, `minSdk 23`, `compileSdk 36`.

> 📘 The reified Kotlin entry points (`interceptAction<T> { … }`, `removeActionInterceptor<T>()`) are `inline` functions targeting JVM 11. Compile your Kotlin module with `jvmTarget = 11`, or use the non‑inline `Class`‑based overload.

***

## 2. SDK initialization

### Default running mode is now `Observer` ⚠️

The default `runningMode` changed from `Full` to `Observer`. **If you want Purchasely to handle and validate purchases, set Full explicitly.**

```kotlin
// Before (v5) — running mode was implicitly Full
Purchasely.Builder(this)
    .apiKey("API_KEY")
    .stores(listOf(GoogleStore()))
    .build()
    .start()

// After (v6) — Kotlin DSL (recommended); set Full explicitly if you need it
Purchasely {
    context(applicationContext)
    apiKey("API_KEY")
    stores(listOf(GoogleStore()))
    runningMode(PLYRunningMode.Full) // ← required for purchase handling & validation
    onInitialized { error -> }
}
```

> 📘 The fluent `Purchasely.Builder` still works and is the form Java callers use — see [Kotlin DSL vs fluent Builder](#kotlin-dsl-recommended) below.

If you don't set `runningMode(PLYRunningMode.Full)`, the SDK logs a DEBUG message at `build()` time reminding you of the change.

> 🚧 Behavioral consequence — automatic screen close
>
> In Observer mode, presentations **no longer auto‑close** after a purchase or restore. In v5, the implicit Full default auto‑appended a `close_all` action after `purchase` / `restore`. If your app relied on auto‑close, set `.runningMode(PLYRunningMode.Full)`.

### `PLYRunningMode.PaywallObserver` → `Observer`

```kotlin
.runningMode(PLYRunningMode.PaywallObserver) // v5
.runningMode(PLYRunningMode.Observer)        // v6
```

### Kotlin DSL (recommended)

`Purchasely { … }` configures **and** starts the SDK in one call. It is the **recommended** Kotlin entry point in v6:

```kotlin
Purchasely {
    context(applicationContext)
    apiKey("API_KEY")
    userId("user-123")
    stores(listOf(GoogleStore()))
    runningMode(PLYRunningMode.Full)
    logLevel(LogLevel.WARN)
    allowDeeplink(true)
    allowCampaigns(true)
    onInitialized { error ->
        if (error == null) { /* SDK ready */ }
    }
}
```

`context` and `apiKey` are mandatory; every setting is a method‑style setter. Custom Lint checks (`PurchaselyMissingContext`, `PurchaselyMissingApiKey`, `PurchaselyFullModeWithoutStores`) flag common mistakes at editor time.

The fluent `Purchasely.Builder` chain remains **fully supported** (and is the only form available to Java callers). Both paths share one internal initialization, so they behave identically — pick whichever you prefer:

```kotlin
Purchasely.Builder(applicationContext)
    .apiKey("API_KEY")
    .userId("user-123")
    .stores(listOf(GoogleStore()))
    .runningMode(PLYRunningMode.Full)
    .build()
    .start { error ->
        if (error == null) { /* SDK ready */ }
    }
```

### Callback signature simplified

The init callback drops its redundant `Boolean`. It now receives only `PLYError?` (`null` on success):

```kotlin
// Before (v5)
.start { isConfigured, error -> }

// After (v6)
.start { error ->
    if (error != null) Log.e(TAG, "failed", error) else Log.d(TAG, "ready")
}
```

### `apiKey` validation

The SDK validates `apiKey` at `start()`. When null/blank, the init callback fires with `PLYError.Configuration` ("API key not set") and the SDK stays inert (no crash). If you source the key dynamically (RemoteConfig, feature flags), make sure it is non‑blank before calling `start()`.

### Storeless integration (new)

Starting **without any store** is now a first‑class path: screens, analytics, campaigns, deeplinks and user attributes all work. Purchase APIs return `PLYError.NoStoreConfigured` (Full mode) when no store is set.

> 🚧 If you previously caught `PLYError.Unknown` with message `"No store found"`, switch to matching `PLYError.NoStoreConfigured`.

***

## 3. Action interceptor (major rewrite)

The global `setPaywallActionsInterceptor` is **removed**, replaced by a granular per‑action API. Each action gets its own interceptor returning an explicit `PLYInterceptResult`.

### Removed

* `Purchasely.setPaywallActionsInterceptor()`
* `PLYPresentationInfo` → use `PLYInterceptorInfo`
* `PLYPresentationActionParameters` → parameters are now on each action subclass
* `PLYPaywallActionHandler`, `PLYCompletionHandler`, `PLYPaywallActionListener`, `PLYProcessActionListener`

### `PLYInterceptResult`

| Result | Meaning |
|--------|---------|
| `SUCCESS` | App handled the action — SDK skips its default behavior |
| `FAILED` | App tried but failed — breaks the action chain |
| `NOT_HANDLED` | SDK should handle the action itself |

`processAction(false)` → `SUCCESS`, `processAction(true)` → `NOT_HANDLED`.

### `PLYPresentationAction` is now a sealed class

Each variant carries its own type‑safe parameters:

| Old (enum) | New (sealed) | Parameters |
|------------|--------------|------------|
| `PURCHASE` | `PLYPresentationAction.Purchase` | `plan`, `subscriptionOffer`, `offer` |
| `RESTORE` | `PLYPresentationAction.Restore` | — |
| `LOGIN` | `PLYPresentationAction.Login` | — |
| `CLOSE` | `PLYPresentationAction.Close` | `closeReason` |
| `CLOSE_ALL` | `PLYPresentationAction.CloseAll` | `closeReason` |
| `NAVIGATE` | `PLYPresentationAction.Navigate` | `url`, `title` |
| `OPEN_PRESENTATION` | `PLYPresentationAction.OpenPresentation` | `presentationId` |
| `OPEN_PLACEMENT` | `PLYPresentationAction.OpenPlacement` | `placementId` |
| `PROMO_CODE` | `PLYPresentationAction.PromoCode` | — |
| `WEB_CHECKOUT` | `PLYPresentationAction.WebCheckout` | `url`, `clientReferenceId`, … |

### Migration example

```kotlin
// Before (v5)
Purchasely.setPaywallActionsInterceptor { info, action, parameters, processAction ->
    when (action) {
        PLYPresentationAction.PURCHASE -> processAction(true)   // let SDK continue
        PLYPresentationAction.LOGIN -> processAction(false)     // app handled it
        else -> processAction(true)
    }
}

// After (v6)
Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
    // use purchase.plan, purchase.subscriptionOffer, …
    PLYInterceptResult.NOT_HANDLED
}

Purchasely.interceptAction<PLYPresentationAction.Login> { info, _ ->
    showLogin()
    PLYInterceptResult.SUCCESS
}
```

Java callers use the `Class`‑based overload:

```java
Purchasely.interceptAction(PLYPresentationAction.Purchase.class, (info, action, result) -> {
    PLYPresentationAction.Purchase purchase = (PLYPresentationAction.Purchase) action;
    result.invoke(PLYInterceptResult.NOT_HANDLED);
});
```

Remove interceptors with `Purchasely.removeActionInterceptor<PLYPresentationAction.Purchase>()` or `Purchasely.removeAllActionInterceptors()`.

### Observer‑mode bridge

In Observer mode, suspend the interceptor until your own billing flow returns:

```kotlin
Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
    suspendCancellableCoroutine { continuation ->
        startBilling(
            info?.activity,
            purchase.plan.store_product_id,
            purchase.subscriptionOffer?.offerToken
        ) { result -> // your billing result
            if (continuation.isActive) continuation.resume(
                when (result) {
                    BillingResult.SUCCESS  -> { Purchasely.synchronize(); PLYInterceptResult.SUCCESS }
                    BillingResult.CANCELLED -> PLYInterceptResult.NOT_HANDLED
                    else -> PLYInterceptResult.FAILED
                }
            )
        }
    }
}
```

***

## 4. Presentation API — new builder / preload / display model

`PLYPresentation` is now a complete builder → preload → display API with an observable lifecycle. The sealed base is `PLYPresentationBase`; **public typealiases** keep most read‑only call sites compiling unchanged:

| Typealias (Kotlin) | Underlying type | Meaning |
|--------------------|-----------------|---------|
| `PLYPresentation` | `PLYPresentationBase.Loaded` | Loaded, ready‑to‑display |
| `PLYPresentationBuilder` | `PLYPresentationBase.Builder` | Mutable builder |
| `PLYPresentationPrepared` | `PLYPresentationBase.Prepared` | Immutable request intent |

Java callers must use the concrete nested names (`PLYPresentationBase.Loaded`, …) since typealiases are not visible in Java.

### Imports moved to `ext.presentation`

All presentation types moved from `io.purchasely.ext.*` to `io.purchasely.ext.presentation.*`. The fix is a pure import update:

```kotlin
// Before
import io.purchasely.ext.PLYPresentation
import io.purchasely.ext.display
import io.purchasely.ext.preload

// After
import io.purchasely.ext.presentation.PLYPresentation
import io.purchasely.ext.presentation.display
import io.purchasely.ext.presentation.preload
// or simply:
import io.purchasely.ext.presentation.*
```

### `fetchPresentation` → `PLYPresentation { … }.preload()`

```kotlin
// Before (v5)
Purchasely.fetchPresentation(placementId = "onboarding") { presentation, error ->
    if (error != null) return@fetchPresentation
    presentation?.display(context)
}

// After (v6)
PLYPresentation {
    placementId("onboarding")          // required unless screenId is set
    screenId("screen_123")             // optional, direct Screen lookup
    contentId("content_123")           // optional
    backgroundColor(0xFF101820.toInt()) // optional runtime color override
    progressColor(0xFFFFC857.toInt())   // optional runtime color override
    displayCloseButton(true)            // optional Android UI flag
    displayBackButton(true)             // optional Android UI flag
    onPresented { loaded, error -> }
    onCloseRequested { }
    onDismissed { outcome -> }
}.preload { loaded, error ->
    if (error != null) return@preload
    loaded?.display(context)
}
```

> 🚧 `flowId`, `productId` and `planId` are **no longer** exposed on the public builder. To display a Flow, use its deeplink `app_scheme://ply/flows/FLOW_ID`. `flowId` remains read‑only on the loaded `PLYPresentation`.

### `PLYPresentation.id` → `screenId`

```kotlin
val screenId = loaded.screenId         // was loaded.id
val key = loaded.toMap()["screenId"]   // toMap() key renamed "id" → "screenId"
```

### Coroutine form

```kotlin
lifecycleScope.launch {
    val loaded = PLYPresentation { placementId("onboarding") }.preload()
    loaded.display(context)
}
```

### Preload early, display later (no extra network call)

```kotlin
var loaded: PLYPresentation? = null

lifecycleScope.launch {
    loaded = PLYPresentation { placementId("onboarding") }.preload()
}

button.setOnClickListener { loaded?.display(context) }
```

### `display()` is now non‑suspend and returns a session

On the loaded presentation, `display(context)` / `display(context, transition)` are **non‑suspend** (Java‑callable, also callable inside a coroutine). The previous `suspend` extension is removed. Every overload returns a `PLYPresentationSession` you can `await()` from a coroutine:

```kotlin
lifecycleScope.launch {
    try {
        val outcome: PLYPresentationOutcome = loaded.display(activity).await()
        // react to outcome.purchaseResult / outcome.plan / outcome.closeReason
    } catch (e: PLYError) {
        // the presentation failed to launch or render
    }
}
```

### Atomic fetch‑and‑display

```kotlin
PLYPresentation { placementId("onboarding") }.display(
    context = activity,
    presentation = { loaded -> /* display triggered */ },
    callback = { outcome -> /* final dismissal */ }
)
```

### Observable lifecycle state

Builder / prepared / loaded all expose `state: StateFlow<PLYPresentationState>`:

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

### `onClose` → `onCloseRequested`

The callback was renamed: it fires when the user **requests** a close (e.g. taps the X). The actual dismissal, with the purchase outcome, is delivered by `onDismissed` / the `display()` result handler.

***

## 5. Embedded views

### Removed: `Purchasely.presentationView(...)`

```kotlin
// Before (v5)
val view = Purchasely.presentationView(
    context = this,
    placementId = "onboarding",
    properties = PLYPresentationProperties(),
) { result, plan -> }
container.addView(view)

// After (v6)
PLYPresentation { placementId("onboarding") }.preload { loaded, error ->
    if (error != null || loaded == null) return@preload
    container.addView(loaded.buildView(this) { outcome -> })
}
```

### Fragment

```kotlin
val fragment = loaded.getFragment { outcome -> }
```

### Jetpack Compose

The SDK does not ship a Compose wrapper. Wrap `buildView(...)` in an `AndroidView`:

```kotlin
AndroidView(factory = { loaded.buildView(it) { outcome -> } })
```

***

## 6. `PLYPresentationOutcome` — single dismissal envelope

Display / dismissal callbacks now receive one `PLYPresentationOutcome` (no separate `PLYError` parameter):

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
// Before (v5)
presentation.display(context) { result, plan ->
    when (result) {
        PLYProductViewResult.PURCHASED -> trackPurchase(plan)
        PLYProductViewResult.RESTORED  -> { }
        PLYProductViewResult.CANCELLED -> { }
    }
}

// After (v6)
loaded.display(context) { outcome ->
    if (outcome.error != null) { showError(outcome.error); return@display }
    when (outcome.purchaseResult) {
        PLYPurchaseResult.PURCHASED -> trackPurchase(outcome.plan)
        PLYPurchaseResult.RESTORED  -> { }
        PLYPurchaseResult.CANCELLED -> { }
        null -> { }
    }
}
```

`PLYProductViewResult` is deprecated — use `PLYPurchaseResult`. The `PLYPresentationResultHandler` typealias was renamed `PLYPresentationOutcomeHandler` and now carries a single `PLYPresentationOutcome`.

***

## 7. Deeplinks

| v5 | v6 |
|----|----|
| `isDeeplinkHandled(uri, activity)` | `handleDeeplink(uri, activity)` |
| `readyToOpenDeeplink` | `allowDeeplink` |
| `Builder().readyToOpenDeeplink()` | `Builder().allowDeeplink()` |

### Automatic deeplink interception (zero code)

The SDK now reads the foreground activity's intent (on create and resume) and routes its own URIs to the deeplink handler. **You no longer need to call `handleDeeplink(uri)` yourself.** Existing manual calls keep working and are deduped.

```kotlin
// v5 — manual call required
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    Purchasely.handleDeeplink(intent.data) // ← no longer needed in v6
}
```

Opt out with `.automaticDeeplinkHandling(false)`. For a cold start from a deeplink, pass it to the builder with `.handleDeeplink(intent.data)`.

> 🚧 Activities using `singleTask`/`singleTop` that receive the deeplink in `onNewIntent` **without** calling `setIntent(intent)` hide the URI from auto‑interception — call `setIntent(intent)` or keep the manual `handleDeeplink(uri)` call.

### `allowDeeplink` now defaults to `true`

In v5 it defaulted to `false` (deeplinks queued until opt‑in). In v6 it defaults to `true`. To restore the v5 deferred behavior:

```kotlin
Purchasely.Builder(context).allowDeeplink(false).build()
// then when ready: Purchasely.allowDeeplink = true
```

Preview deeplinks (Console QR codes with `?preview=1`) always display immediately, bypassing `allowDeeplink`.

### Campaign display control

Campaigns now have their own flag, `allowCampaigns` (default `true`), separate from deeplinks:

```kotlin
Purchasely.allowDeeplink = true     // deeplink presentations
Purchasely.allowCampaigns = false   // campaigns stay queued (e.g. during onboarding)
Purchasely.allowCampaigns = true    // queued campaigns display immediately
```

***

## 8. `synchronize()` now accepts completion callbacks (Observer mode)

`Purchasely.synchronize()` — called after a purchase completes in your own billing flow — gains optional callbacks and refreshes the subscriptions cache before firing `onSuccess`:

```kotlin
Purchasely.synchronize(
    onSuccess = { plan -> /* refresh UI; plan is the validated PLYPlan or null */ },
    onError = { error -> /* surface failure */ }
)
```

Both parameters default to `null`, so existing `Purchasely.synchronize()` calls keep working.

***

## 9. User attributes return `Deferred<Boolean>`

Mutation methods now return `Deferred<Boolean>` (success/failure). The return value can be ignored — they still work fire‑and‑forget:

```kotlin
val success = Purchasely.setUserAttribute("key", "value").await()
```

Affected: `setUserAttribute(s)`, `clearUserAttribute(s)`, `incrementUserAttribute`, `decrementUserAttribute`. The internal `PLYUserAttributeManager` was removed (attributes are managed by `PLYUserDataStorage`).

***

## 10. Removed: subscription list & cancellation survey UI

The built‑in subscription management and cancellation survey UI has been **removed**:

* `Purchasely.subscriptionsFragment()`, all `PLYSubscriptions*` / `PLYSubscriptionDetail*` / `PLYSubscriptionCancellation*` fragments and views
* Deeplinks `ply/subscriptions`, `ply/cancellation_survey[/PRODUCT_VENDOR_ID]`
* The related `PLYEvent` subclasses (`SubscriptionListViewed`, `SubscriptionDetailsViewed`, `SubscriptionPlanTapped`, `SubscriptionCancelTapped`, `CancellationReasonPublished`)

Build your own UI from the data APIs that remain:

```kotlin
Purchasely.userSubscriptions { subscriptions -> /* active subs */ }
Purchasely.userSubscriptionsHistory { subscriptions -> /* history */ }
```

***

## 11. Purchase history methods removed

Local purchase history relied on local storage that Google Play Billing v8 no longer exposes:

| Removed | Replacement |
|---------|-------------|
| `Purchasely.purchaseHistory()` | `Purchasely.userSubscriptionsHistory()` |
| `Purchasely.isPastSubscriber()` | derive from `userSubscriptionsHistory()` |

`userSubscriptionsHistory()` is a `suspend` function fetching from the Purchasely backend.

***

## 12. Plan offers — `intro*` / `INTRO_*` / `TRIAL_*` removed

All `intro*` / `introductory*` methods on `PLYPlan` and all `INTRO_*` / `TRIAL_*` `PLYPlanTags` values were removed in favor of unified `offer*` / `OFFER_*` equivalents. These are direct renames with identical behavior, e.g.:

| Removed | Replacement |
|---------|-------------|
| `hasIntroductoryPrice()` | `hasOfferPrice()` |
| `isEligibleToIntroOffer()` | `isEligibleToOffer()` |
| `localizedIntroductoryPrice()` | `localizedOfferPrice()` |
| `PLYPlanTags.INTRO_PRICE` / `TRIAL_PRICE` | `PLYPlanTags.OFFER_PRICE` |

***

## 13. Logging changes

* Custom loggers now receive **all** log messages regardless of `logLevel`.
* New flag `Purchasely.logcatEnabled` controls Logcat output independently; set it at init with `.logcatEnabled(false)`.

***

## 14. Verification checklist

```bash
./gradlew :app:assembleDebug
./gradlew :app:testDebugUnitTest
```

Then manually verify:

1. The init callback receives `null` error.
2. A placement‑based presentation displays.
3. A direct `screenId` presentation displays.
4. `onPresented`, `onCloseRequested` and the final `display`/`onDismissed` outcome fire in the expected order.
5. In Observer mode, purchase and restore paths resolve `PLYInterceptResult` exactly once.
6. If you use Full mode, `.runningMode(PLYRunningMode.Full)` is set — purchases validate and screens auto‑close after purchase.
