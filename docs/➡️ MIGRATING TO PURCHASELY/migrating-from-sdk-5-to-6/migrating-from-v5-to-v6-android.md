---
title: Migrating to v6 — Android
excerpt: >-
  Breaking changes and migration steps to upgrade the Purchasely Android SDK
  from v5.x to v6.1.0
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

> 🚧 The default running mode is now Observer — silent behavioral change
>
> In v5, the SDK started in **Full** mode by default (Purchasely handled and validated purchases). In v6 the default is **Observer**. If Purchasely processes your purchases today, you **must** add `.runningMode(PLYRunningMode.Full)` at initialization — otherwise purchases will no longer be validated by the SDK and presentations will no longer auto-close after a purchase or restore. See [section 2](#2-sdk-initialization).

***

## Requirements

| Requirement | v6 value |
| --- | --- |
| SDK version | **6.1.0** (stable) |
| Gradle | **9.3.0 minimum** (SDK built with 9.6.1) |
| Android Gradle Plugin | SDK built with AGP 9.0.1 |
| Kotlin | **2.2.x minimum**, K2 compiler (SDK built with 2.3.21) |
| JVM target | **11** — `jvmTarget = 11` required for the reified `inline` APIs (Java callers unaffected) |
| `minSdk` | 23 (Android 6.0) |
| `compileSdk` | 36 |
| Google Play Billing | **v8** (8.3.0, bundled with `io.purchasely:google-play`) |

***

## Summary of breaking changes

| v5 | v6 |
| --- | --- |
| Default running mode `Full` | Default running mode `Observer` ⚠️ |
| `setPaywallActionsInterceptor { … }` | `interceptAction<PLYPresentationAction.X> { … }` |
| `PLYPresentationAction` (enum) + `PLYPresentationActionParameters` | `PLYPresentationAction` (sealed class), parameters on each subclass |
| `Purchasely.fetchPresentation(...)` + `PLYPresentationProperties` | `PLYPresentation { … }` builder → `preload()` → `display()` |
| `Purchasely.presentationView(...)` | `loaded.buildView(context) { … }` |
| `display { result, plan -> }` (`PLYProductViewResult`) | `display { outcome -> }` (`PLYPresentationOutcome` / `PLYPurchaseResult`) |
| `readyToOpenDeeplink` (default `false`) | `allowDeeplink` (default `true` ⚠️) |
| `isDeeplinkHandled(uri, activity)` | `handleDeeplink(uri, activity)` — and deeplinks are now auto-intercepted |
| `PLYRunningMode.PaywallObserver` | `PLYRunningMode.Observer` |
| `PLYPresentation.id` / `toMap()["id"]` | `PLYPresentation.screenId` / `toMap()["screenId"]` |
| `onClose` / `PLYPresentationClose` | `onCloseRequested` / `PLYPresentationCloseRequested` |
| `start { isConfigured, error -> }` | `start { error -> }` |
| `io.purchasely.ext.*` (presentation types) | `io.purchasely.ext.presentation.*` |
| `setDefaultPresentationResultHandler { result, plan -> }` | `setDefaultPresentationDismissHandler { outcome -> }` (nullable to unregister) |
| `PLYError.Unknown` ("No store found") | `PLYError.NoStoreConfigured` |
| `setUserAttribute(...)` fire-and-forget | returns `Deferred<Boolean>` (still ignorable) |
| `Purchasely.subscriptionsFragment()` & cancellation survey UI | Removed — build your own UI from data APIs |
| `purchaseHistory()`, `isPastSubscriber()` | `userSubscriptionsHistory()` |
| `PLYPlan.intro*` methods, `PLYPlanTags.INTRO_*` / `TRIAL_*` | `offer*` methods, `OFFER_*` tags |

> 📘 `screenId` is the canonical Android public name for a direct Screen lookup. The name `presentationId` is kept internally only.

***

## 1. Update your Gradle dependencies

Bump every Purchasely artifact to **6.1.0** and make sure your build environment meets the [Requirements](#requirements).

### Before (v5)

```kotlin
dependencies {
    implementation("io.purchasely:core:5.+")
    implementation("io.purchasely:google-play:5.+")
    implementation("io.purchasely:player:5.+")
}
```

### After (v6)

```kotlin
dependencies {
    implementation("io.purchasely:core:6.1.0")
    implementation("io.purchasely:google-play:6.1.0")
    implementation("io.purchasely:player:6.1.0") // optional, video support
}
```

Alternative stores follow the same version: `io.purchasely:huawei-services:6.1.0`, `io.purchasely:amazon:6.1.0`.

> 🚧 Kotlin `jvmTarget = 11`
>
> The reified Kotlin entry points (`interceptAction<T> { … }`, `removeActionInterceptor<T>()`) are `inline` functions built for JVM target 11. Compiling a Kotlin module with a lower `jvmTarget` fails with *"Cannot inline bytecode built with JVM target 11 into bytecode that is being built with JVM target 1.8"*. Set `jvmTarget = 11` (the modern Android default), or use the non-inline `Class`-based overloads. Java callers are unaffected.

***

## 2. SDK initialization

The default `runningMode` changed from `Full` to `Observer`, the init callback dropped its redundant `Boolean`, and Kotlin gains a DSL entry point. **If you want Purchasely to handle and validate purchases, set `Full` explicitly.**

### Before (v5)

```kotlin
Purchasely.Builder(this)
    .apiKey("API_KEY")
    .stores(listOf(GoogleStore()))
    .build()
    .start { isConfigured, error -> }
// Running mode was implicitly Full — Purchasely handled purchases
```

### After (v6)

<Tabs>
  <Tab title="Kotlin">

    ```kotlin
    // Kotlin DSL (recommended) — configures AND starts the SDK in one call
    Purchasely {
        context(applicationContext)
        apiKey("API_KEY")
        userId("user-123")
        stores(listOf(GoogleStore()))
        runningMode(PLYRunningMode.Full) // ← required if Purchasely handles purchases
        logLevel(LogLevel.WARN)
        onInitialized { error ->
            if (error == null) { /* SDK ready */ }
        }
    }
    ```

    The fluent `Purchasely.Builder` chain remains fully supported in Kotlin and behaves identically (the DSL delegates to it internally):

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

  </Tab>
  <Tab title="Java">

    ```java
    // The Kotlin DSL is Kotlin-only — Java keeps the fluent Builder
    new Purchasely.Builder(getApplicationContext())
        .apiKey("API_KEY")
        .userId("user-123")
        .stores(List.of(new GoogleStore()))
        .runningMode(PLYRunningMode.Full)
        .build()
        .start(error -> {
            if (error == null) { /* SDK ready */ }
            return kotlin.Unit.INSTANCE;
        });
    ```

  </Tab>
</Tabs>

If you don't set `runningMode(PLYRunningMode.Full)`, the SDK logs a DEBUG message at `build()` time reminding you of the change. This message reaches all registered custom loggers regardless of `logLevel`; to see it in logcat during migration, set `.logLevel(LogLevel.DEBUG)`.

> 🚧 Behavioral consequence — automatic screen close
>
> In Observer mode, presentations **no longer auto-close** after a purchase or restore. In v5, the implicit Full default auto-appended a `close_all` action after `purchase` / `restore`. If your app relied on auto-close, set `.runningMode(PLYRunningMode.Full)`.

### `PLYRunningMode.PaywallObserver` → `Observer`

```kotlin
.runningMode(PLYRunningMode.PaywallObserver) // v5
.runningMode(PLYRunningMode.Observer)        // v6
```

### Kotlin DSL details

`context` and `apiKey` are mandatory; every setting is a method-style setter (`userId(...)`, `stores(...)`, `runningMode(...)`, `logLevel(...)`, `logcatEnabled(...)`, `allowDeeplink(...)`, `allowCampaigns(...)`, `themeMode(...)`, `onInitialized { }`). Custom Lint checks flag common mistakes at editor time: `PurchaselyMissingContext`, `PurchaselyMissingApiKey`, `PurchaselyFullModeWithoutStores`.

### Callback signature simplified

The init callback (`PLYSdkConfigured`) drops its redundant `Boolean`. It now receives only `PLYError?` — `null` on success:

```kotlin
// Before (v5)
.start { isConfigured, error -> }

// After (v6)
.start { error ->
    if (error != null) Log.e(TAG, "failed", error) else Log.d(TAG, "ready")
}
```

Java code storing this callback in a field must update its type from `Function2<Boolean, PLYError, Unit>` to `Function1<PLYError, Unit>`.

### `apiKey` validation

The SDK validates `apiKey` at `start()`. When null or blank, the init callback fires with `PLYError.Configuration` ("API key not set") and the SDK stays **inert** — no presentation, no analytics, no purchase (no crash). If you source the key dynamically (RemoteConfig, feature flags), make sure it is non-blank before calling `start()`.

### Storeless integration (new)

Starting **without any store** (omitting `.stores(...)` or passing an empty list) is now a first-class path: screens, analytics, campaigns, deeplinks and user attributes all work. Store-dependent APIs behave as follows:

| API | Storeless behavior |
| --- | --- |
| `purchase()` | `onError` returns `PLYError.NoStoreConfigured` (Full mode) or `PLYError.Configuration` (Observer mode) |
| `restoreAllProducts()` / `silentRestoreAllProducts()` | `onError` returns `PLYError.NoStoreConfigured` |
| `synchronize()` | Logs WARN and returns |
| `userSubscriptions()` / `userSubscriptionsHistory()` | **Unchanged** — fetch from the Purchasely backend, not from a store |

> 🚧 No store configured error
>
> If you previously caught `PLYError.Unknown` with message `"No store found"`, switch to matching `PLYError.NoStoreConfigured`.

If you set Full mode without any store, the SDK logs a WARN at `build()` time ("Full mode enabled but no stores configured").

### `themeMode` configurable at init (new)

`Purchasely.Builder` and the Kotlin DSL now expose `themeMode(PLYThemeMode)` (`LIGHT`, `DARK`, `SYSTEM`), applied before the SDK starts. `Purchasely.setThemeMode(...)` keeps working unchanged; the default remains `SYSTEM`.

```kotlin
Purchasely.Builder(this)
    .apiKey("API_KEY")
    .themeMode(PLYThemeMode.DARK)
    .build()
    .start()
```

***

## 3. Action interceptor (major rewrite)

The global `setPaywallActionsInterceptor` is **removed**, replaced by a granular per-action API. Each action gets its own interceptor returning an explicit `PLYInterceptResult`.

Removed along with it: `PLYPresentationInfo` (→ `PLYInterceptorInfo`), `PLYPresentationActionParameters` (→ parameters on each action subclass), `PLYPaywallActionHandler`, `PLYCompletionHandler`, `PLYPaywallActionListener`, `PLYProcessActionListener`.

### `PLYInterceptResult`

| Result | Meaning |
| --- | --- |
| `SUCCESS` | App handled the action — SDK skips its default behavior |
| `FAILED` | App tried but failed — breaks the action chain |
| `NOT_HANDLED` | SDK should handle the action itself |

Mapping from v5: `processAction(false)` → `SUCCESS`, `processAction(true)` → `NOT_HANDLED`, and `FAILED` is new.

### `PLYPresentationAction` is now a sealed class

Each variant carries its own type-safe parameters, replacing the flat `PLYPresentationActionParameters` bag:

| Old (enum) | New (sealed) | Parameters |
| --- | --- | --- |
| `PURCHASE` | `PLYPresentationAction.Purchase` | `plan`, `subscriptionOffer`, `offer` |
| `RESTORE` | `PLYPresentationAction.Restore` | — |
| `LOGIN` | `PLYPresentationAction.Login` | — |
| `CLOSE` | `PLYPresentationAction.Close` | `closeReason` |
| `CLOSE_ALL` | `PLYPresentationAction.CloseAll` | `closeReason` |
| `NAVIGATE` | `PLYPresentationAction.Navigate` | `url`, `title` |
| `OPEN_PRESENTATION` | `PLYPresentationAction.OpenPresentation` | `presentationId` |
| `OPEN_PLACEMENT` | `PLYPresentationAction.OpenPlacement` | `placementId` |
| `PROMO_CODE` | `PLYPresentationAction.PromoCode` | — |
| `WEB_CHECKOUT` | `PLYPresentationAction.WebCheckout` | `url`, `clientReferenceId`, `queryParameterKey`, `webCheckoutProvider` |

### Before (v5)

```kotlin
Purchasely.setPaywallActionsInterceptor { info, action, parameters, processAction ->
    when (action) {
        PLYPresentationAction.PURCHASE -> processAction(true)   // let SDK continue
        PLYPresentationAction.LOGIN -> processAction(false)     // app handled it
        else -> processAction(true)
    }
}
```

### After (v6)

<Tabs>
  <Tab title="Kotlin">

    ```kotlin
    // Reified overload — suspend lambda, action already typed, return the result directly
    Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
        // use purchase.plan, purchase.subscriptionOffer, purchase.offer
        PLYInterceptResult.NOT_HANDLED  // let SDK continue
    }

    Purchasely.interceptAction<PLYPresentationAction.Login> { info, _ ->
        showLogin()
        PLYInterceptResult.SUCCESS      // app handled it
    }
    ```

    If your call site is **not** a coroutine, use the `Class`-based overload (select it with `::class.java`) and hand the result back later through the `result` lambda — call it exactly once, synchronously or after async work:

    ```kotlin
    Purchasely.interceptAction(PLYPresentationAction.Purchase::class.java) { info, action, result ->
        val purchase = action as PLYPresentationAction.Purchase   // not cast for you here
        result(PLYInterceptResult.NOT_HANDLED)
    }
    ```

  </Tab>
  <Tab title="Java">

    ```java
    // Java — Class-based callback overload; cast the action yourself
    Purchasely.interceptAction(PLYPresentationAction.Purchase.class, (info, action, result) -> {
        PLYPresentationAction.Purchase purchase = (PLYPresentationAction.Purchase) action;
        // use purchase.getPlan(), purchase.getOffer(), etc.
        result.invoke(PLYInterceptResult.NOT_HANDLED);
    });
    ```

  </Tab>
</Tabs>

Remove interceptors with `Purchasely.removeActionInterceptor<PLYPresentationAction.Purchase>()` (Kotlin), `Purchasely.removeActionInterceptor(PLYPresentationAction.Purchase.class)` (Java), or `Purchasely.removeAllActionInterceptors()`.

> 📘 No extra import needed
>
> `interceptAction` / `removeActionInterceptor` are **members of `Purchasely`**, not top-level extensions. If an earlier `6.0.0-rc` build had you add `import io.purchasely.ext.interceptAction`, delete that import — the member call resolves on its own.

***

## 4. Displaying paywalls — builder, preload, display

`PLYPresentation` is now a complete builder → preload → display API with an observable lifecycle, replacing `fetchPresentation` + `PLYPresentationProperties`. The sealed base is `PLYPresentationBase`; **public typealiases** keep most read-only Kotlin call sites compiling unchanged:

| Typealias (Kotlin) | Underlying type | Meaning |
| --- | --- | --- |
| `PLYPresentation` | `PLYPresentationBase.Loaded` | Loaded, ready-to-display |
| `PLYPresentationBuilder` | `PLYPresentationBase.Builder` | Mutable builder |
| `PLYPresentationPrepared` | `PLYPresentationBase.Prepared` | Immutable request intent |

Java callers must use the concrete nested names (`PLYPresentationBase.Loaded`, `PLYPresentationBase.Prepared`, …) since typealiases are not visible in Java.

### Imports moved to `ext.presentation`

All presentation-related public types moved from `io.purchasely.ext.*` to `io.purchasely.ext.presentation.*` (`PLYPresentation`, `PLYPresentationAction`, `PLYPresentationOutcome`, `PLYPurchaseResult`, `PLYCloseReason`, `PLYPresentationType`, `PLYSubscriptionOffer`, the `display`/`preload` extensions, …). Names are unchanged — the fix is a pure import update:

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

Two exceptions: `PLYPresentationFetchHandler` is also **renamed** to `PLYPresentationHandler`, and `PresentationDisplayMethod` moves to `io.purchasely.models.presentation`.

### Before (v5)

```kotlin
val properties = PLYPresentationProperties(
    placementId = "onboarding",
    contentId = "article_42",
    displayCloseButton = false,
    onLoaded = { loaded -> },
    onClose = { dismiss() }
)
Purchasely.fetchPresentation("onboarding", properties) { presentation, error ->
    if (error != null) return@fetchPresentation
    presentation?.display(context)
}
```

### After (v6)

<Tabs>
  <Tab title="Kotlin">

    ```kotlin
    import io.purchasely.ext.presentation.PLYPresentation

    PLYPresentation {
        placementId("onboarding")           // required unless screenId is set
        screenId("screen_123")              // optional, direct Screen lookup
        contentId("article_42")             // optional
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

  </Tab>
  <Tab title="Java">

    ```java
    PLYPresentationBase.builder()
        .placementId("onboarding")
        .onPresented((presentation, error) -> kotlin.Unit.INSTANCE)
        .onCloseRequested(() -> kotlin.Unit.INSTANCE)
        .onDismissed(outcome -> kotlin.Unit.INSTANCE)
        .build()
        .preload((loaded, error) -> {
            if (error != null || loaded == null) return kotlin.Unit.INSTANCE;
            loaded.display(context, null, outcome -> kotlin.Unit.INSTANCE);
            return kotlin.Unit.INSTANCE;
        });
    ```

  </Tab>
</Tabs>

> 📘 `PLYPresentationProperties` is removed
>
> Every field moved onto the builder: `placementId` → `placementId(id)`, `presentationId` → `screenId(id)`, `contentId` → `contentId(id)`, `displayCloseButton` → `displayCloseButton(show)`, `backgroundColor` / `progressColor` → `@ColorInt` setters, `onLoaded(Boolean)` → `onPresented { loaded, error -> }`, `onClose` → `onCloseRequested { }`. `flowId`, `productId` and `planId` are no longer settable — remove those calls (Flows are displayed via their deeplink `ply/flows/FLOW_ID`; the SDK resolves the relevant plan/product at display time).

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

### `display()` is now non-suspend and returns a session

On the loaded presentation, `display(context)` / `display(context, transition)` are **non-suspend** members — callable from Java, from a plain method, or inside a coroutine. The previous `suspend` extension is removed. Every overload returns a `PLYPresentationSession` you can `await()` from a coroutine to suspend until dismissal:

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

```java
// Java
loaded.display(activity);
loaded.display(activity, (PLYTransition) null);          // cast disambiguates from the callback overload
loaded.display(activity, transition, outcome -> kotlin.Unit.INSTANCE);
```

`PLYPresentationSession` also exposes `presentation` and `state: StateFlow<PLYPresentationState>`. Note: `Prepared.display(context[, transition])` (the implicit-preload entry point) remains `suspend` and returns the loaded `PLYPresentation` — only the **Loaded** display surface changed.

### Atomic fetch-and-display

```kotlin
PLYPresentation { placementId("onboarding") }.display(
    context = activity,
    presentation = { loaded -> /* display triggered */ },
    callback = { outcome -> /* final dismissal */ }
)
```

### Observable lifecycle state (new)

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

### `PLYPresentationOutcome` — single dismissal envelope

Display / dismissal callbacks now receive one `PLYPresentationOutcome` (no separate `PLYError` parameter), and `PLYProductViewResult` is deprecated in favor of `PLYPurchaseResult`:

```kotlin
data class PLYPresentationOutcome(
    val presentation: PLYPresentation?,
    val purchaseResult: PLYPurchaseResult?,
    val plan: PLYPlan?,
    val closeReason: PLYCloseReason? = null,
    val error: PLYError? = null,
)
```

`closeReason` is set on a clean dismissal (button tap, back press, programmatic close); `error` is set when display failed — the two are mutually exclusive, and technical failures are no longer reported as `CANCELLED`.

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

The same envelope applies to `Purchasely.display(...)`:

```kotlin
// Before (v5) — separate result callback + fetch completion callback
Purchasely.display(
    context = context,
    placementId = "onboarding",
    resultCallback = { result, plan -> /* … */ }
) { presentation, error -> if (error != null) handleError(error) }

// After (v6)
Purchasely.display(context, "onboarding") { outcome ->
    if (outcome.error != null) handleError(outcome.error!!) else handleOutcome(outcome)
}
```

The `PLYPresentationResultHandler` typealias was renamed `PLYPresentationOutcomeHandler` and now carries a single `PLYPresentationOutcome`. This affects `buildView(context, callback)`, `getFragment(callback)` and `setDefaultPresentationDismissHandler(handler)`.

### `onClose` → `onCloseRequested`

The callback was renamed on the builder (and the `PLYPresentationClose` typealias became `PLYPresentationCloseRequested`): it fires when the user **requests** a close (e.g. taps the X). The actual dismissal, with the purchase outcome, is delivered by `onDismissed` / the `display()` dismiss callback.

### `back()` / `close()` moved to the loaded presentation only

In v5, `back()` and `close()` existed on the sealed base. In v6 they are only on `PLYPresentation` (= `Loaded`). Code holding a `PLYPresentation` variable is unaffected; code using the base type needs a cast:

```kotlin
fun handle(p: PLYPresentationBase) {
    (p as? PLYPresentation)?.back()
}
```

### `PLYCustomScreenProvider` — parameter type narrowed

`onCustomScreenRequested` now receives `PLYPresentation` (= `Loaded`) instead of the sealed base. Kotlin signatures look identical thanks to the typealias; Java callers must update the parameter type:

```java
// v5
public PLYCustomScreen onCustomScreenRequested(PLYPresentation presentation) { … }

// v6
public PLYCustomScreen onCustomScreenRequested(PLYPresentationBase.Loaded presentation) { … }
```

### Deprecated (not removed)

| Deprecated | Replacement |
| --- | --- |
| `Purchasely.fetchPresentation(placementId, callback)` | `PLYPresentation { placementId("id") }.preload { loaded, err -> }` |
| `display()` callback shape `(PLYProductViewResult, PLYPlan?) -> Unit` | `(PLYPresentationOutcome) -> Unit` |

***

## 5. Embedded views & Jetpack Compose

`Purchasely.presentationView(...)` is **removed**. Build the view from a preloaded presentation instead.

### Before (v5)

```kotlin
val view = Purchasely.presentationView(
    context = this,
    placementId = "onboarding",
    properties = PLYPresentationProperties(),
) { result, plan -> }
container.addView(view)
```

### After (v6)

```kotlin
PLYPresentation { placementId("onboarding") }.preload { loaded, error ->
    if (error != null || loaded == null) return@preload
    container.addView(loaded.buildView(this) { outcome -> })
}
```

`buildView(context, properties, callback)` lost its `properties` parameter — configure everything on the builder before `preload()`.

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

## 6. Deeplinks & campaigns

| v5 | v6 |
| --- | --- |
| `isDeeplinkHandled(uri, activity)` | `handleDeeplink(uri, activity)` |
| `readyToOpenDeeplink` | `allowDeeplink` |
| `Builder().readyToOpenDeeplink()` | `Builder().allowDeeplink()` |

### Automatic deeplink interception (zero code)

The SDK now reads the foreground activity's intent (on create and resume) and routes its own URIs to the deeplink handler.

### Before (v5)

```kotlin
// Manual call required in every deeplink-handling activity
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    Purchasely.handleDeeplink(intent.data)
}
```

### After (v6)

```kotlin
// Nothing to do — the SDK intercepts the launch/resume intent itself.
// Existing manual handleDeeplink() calls keep working and are deduped.
```

Opt out with `.automaticDeeplinkHandling(false)` (Builder) or `Purchasely.automaticDeeplinkHandling = false` (runtime). For a cold start from a deeplink, hand it to the builder:

```kotlin
Purchasely.Builder(context)
    .handleDeeplink(intent.data)
    .build()
    .start()
```

> 🚧 Activity configuration
>
> Activities using `singleTask`/`singleTop` that receive the deeplink in `onNewIntent` **without** calling `setIntent(intent)` hide the URI from auto-interception — call `setIntent(intent)` or keep the manual `handleDeeplink(uri)` call for that path.

### `allowDeeplink` now defaults to `true` ⚠️

In v5, `readyToOpenDeeplink` defaulted to `false` (deeplinks queued until opt-in). In v6, `allowDeeplink` defaults to `true` — deeplinks display as soon as they are received. To restore the v5 deferred behavior:

```kotlin
Purchasely.Builder(context).allowDeeplink(false).build()
// then when ready: Purchasely.allowDeeplink = true
```

Preview deeplinks (Console QR codes with `?preview=1`) always display immediately, bypassing `allowDeeplink`.

### Campaign display control (new)

In v5, campaigns were gated by `readyToOpenDeeplink`. In v6 they have their own flag, `allowCampaigns` (default `true`), settable on the Builder, the Kotlin DSL and at runtime:

```kotlin
Purchasely.allowDeeplink = true     // deeplink presentations
Purchasely.allowCampaigns = false   // campaigns stay queued (e.g. during onboarding)
Purchasely.allowCampaigns = true    // queued campaigns display immediately
```

GDPR consent (`revokeDataProcessingConsent(PLYDataProcessingPurpose.Campaigns)`) is unchanged and prevents campaigns from being queued entirely; `allowCampaigns` only defers dispatch of already-queued campaigns.

### Global dismiss handler renamed

The global handler for presentations your app did not instantiate itself (campaign, deeplink, Promoted IAP) is renamed and now takes the outcome envelope — and accepts `null` to unregister:

```kotlin
// Before (v5)
Purchasely.setDefaultPresentationResultHandler { result, plan -> }

// After (v6)
Purchasely.setDefaultPresentationDismissHandler { outcome -> /* … */ }
Purchasely.setDefaultPresentationDismissHandler(null) // unregisters the handler
```

***

## 7. Renames & removals

### User attributes return `Deferred<Boolean>`

Mutation methods now return `Deferred<Boolean>` (success/failure). The return value can be ignored — they still work fire-and-forget:

```kotlin
val success = Purchasely.setUserAttribute("key", "value").await()
```

Affected: `setUserAttribute(s)`, `clearUserAttribute(s)`, `incrementUserAttribute`, `decrementUserAttribute`.

> 📘 Legacy attribute storage
>
> The internal `PLYUserAttributeManager` was removed (attributes are managed by `PLYUserDataStorage`). Users upgrading from an old v5 build that still stored attributes in the legacy `user_attributes.json` format will not have them migrated — re-set those attributes after upgrading. No action needed if your app already ran a v5 version that completed the automatic migration.

### Subscription list & cancellation survey UI removed

The built-in subscription management and cancellation survey UI has been **removed**:

- `Purchasely.subscriptionsFragment()`, all `PLYSubscriptions*` / `PLYSubscriptionDetail*` / `PLYSubscriptionCancellation*` fragments and views
- Deeplinks `ply/subscriptions` and `ply/cancellation_survey[/PRODUCT_VENDOR_ID]`
- The `PLYDeepLink.Subscriptions` / `PLYDeepLink.CancellationSurvey` variants and the `SUBSCRIPTION_LIST` / `CANCELLATION_PAGE` values of `PLYUIViewType`
- The related `PLYEvent` subclasses (`SubscriptionListViewed`, `SubscriptionDetailsViewed`, `SubscriptionPlanTapped`, `SubscriptionCancelTapped`, `CancellationReasonPublished`) — remove any `EventListener` branches matching them

Build your own UI from the data APIs that remain:

```kotlin
Purchasely.userSubscriptions { subscriptions -> /* active subs */ }
Purchasely.userSubscriptionsHistory { subscriptions -> /* history */ }
```

### Purchase history methods removed

Local purchase history relied on local storage that Google Play Billing v8 no longer exposes:

```kotlin
// Before (v5)
val history = Purchasely.purchaseHistory()
val wasSub = Purchasely.isPastSubscriber()

// After (v6)
val history = Purchasely.userSubscriptionsHistory()
val wasSub = history.any {
    it.plan?.type == DistributionType.RENEWING_SUBSCRIPTION ||
    it.plan?.type == DistributionType.NON_RENEWING_SUBSCRIPTION
}
```

`userSubscriptionsHistory()` is a `suspend` function fetching from the Purchasely backend, unlike the removed methods which read from local storage.

### Plan offers — `intro*` / `INTRO_*` / `TRIAL_*` removed

All `intro*` / `introductory*` methods on `PLYPlan` and all `INTRO_*` / `TRIAL_*` `PLYPlanTags` values were removed in favor of unified `offer*` / `OFFER_*` equivalents. These are direct renames with identical behavior:

| Removed | Replacement |
| --- | --- |
| `hasIntroductoryPrice()` | `hasOfferPrice()` |
| `localizedIntroductoryPrice()` / `localizedFullIntroductoryPrice()` | `localizedOfferPrice()` / `localizedFullOfferPrice()` |
| `introductoryAmount()`, `introductoryPeriod()`, `introductoryDuration()`, `introductoryCycles()` | `offerAmount()`, `offerPeriod()`, `offerDuration()`, `offerCycles()` |
| `introDurationInDays/Weeks/Months/Quarters/Years()` | `offerDurationInDays/Weeks/Months/Quarters/Years()` |
| `introPriceComparison()`, `introDiscountPercentage()` | `offerPriceComparison()`, `offerDiscountPercentage()` |
| `isEligibleToIntroOffer()`, `hasIntroOffer()` | `isEligibleToOffer()`, `hasOffer()` |
| `introDurationForTag()`, `introPriceForTag()` | `offerDurationForTag()`, `offerPriceForTag()` |
| `PLYPlanTags.INTRO_*` / `TRIAL_*` (all values) | `PLYPlanTags.OFFER_*` |

### Logging changes

- Custom loggers (`Purchasely.addLogger(...)`) now receive **all** log messages regardless of `logLevel`, so you can capture full logs to your own files.
- New flag `Purchasely.logcatEnabled` controls Logcat output independently; set it at init with `.logcatEnabled(false)`.

### `PLYTransition` — structured dimensions (additive, non-breaking)

`PLYTransition` (sizing of flow `DRAWER` / `POPIN` surfaces) gains structured `width` / `height` fields of type `PLYTransitionDimension` (`PLYDimensionType.PIXEL` in dp, or `PERCENTAGE` as a 0.0–1.0 ratio). `heightPercentage` is deprecated but still read as a fallback. Existing `PLYTransition(...)` construction keeps compiling; defaults are unchanged (drawer 60%, popin 50% height).

### Internal: `PLYStorage.configuration` / `PLYStorage.products` removed

These were never part of the documented integration surface. If you were reading them (unsupported), use `PLYManager.configuration` / `PLYManager.products` instead.

***

## 8. Observer mode bridge

If you run in Observer mode (now the default — see [section 2](#2-sdk-initialization)), you bridge paywall purchase buttons to your own billing stack through the interceptor and return `PLYInterceptResult.SUCCESS` — the SDK then synchronizes the transaction automatically (see the callout below), so no manual `synchronize()` call is needed on that path.

### Bridging the Purchase action

Defer the interceptor result until your billing flow returns. With the reified (coroutine) overload, suspend until your callback resolves:

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
                    BillingResult.SUCCESS   -> PLYInterceptResult.SUCCESS // SDK auto-synchronizes on success in Observer mode
                    BillingResult.CANCELLED -> PLYInterceptResult.NOT_HANDLED
                    else -> PLYInterceptResult.FAILED
                }
            )
        }
    }
}
```

If you don't want to deal with coroutines, the `Class`-based overload gives you the same deferral — call `result(…)` from inside your billing callback:

```kotlin
Purchasely.interceptAction(PLYPresentationAction.Purchase::class.java) { info, action, result ->
    val purchase = action as PLYPresentationAction.Purchase
    startBilling(
        info?.activity,
        purchase.plan.store_product_id,
        purchase.subscriptionOffer?.offerToken
    ) { billingResult ->
        result(
            when (billingResult) {
                BillingResult.SUCCESS   -> PLYInterceptResult.SUCCESS
                BillingResult.CANCELLED -> PLYInterceptResult.NOT_HANDLED
                else -> PLYInterceptResult.FAILED
            }
        )
    }
}
```

> 📘 Auto-synchronize on SUCCESS
>
> When a `Purchase` or `Restore` interceptor returns `PLYInterceptResult.SUCCESS` in Observer mode, the SDK calls `synchronize()` for you to report the transaction — no manual call needed on that path.

### `synchronize()` now accepts completion callbacks

For purchases made **outside** a Purchasely paywall, call `Purchasely.synchronize()` after your billing flow completes. In v5 it was fire-and-forget; in v6 it gains optional callbacks (aligned with iOS `synchronize(success:failure:)`) and refreshes the SDK's subscriptions cache **before** firing `onSuccess` — no more polling `userSubscriptions(invalidateCache = true)` with an arbitrary delay.

### Before (v5)

```kotlin
Purchasely.synchronize()
// no signal — poll userSubscriptions() and hope
```

### After (v6)

```kotlin
Purchasely.synchronize(
    onSuccess = { plan -> /* refresh UI; plan is the validated PLYPlan or null */ },
    onError = { error -> /* surface failure, log error?.message */ }
)
```

Both parameters default to `null`, so existing `Purchasely.synchronize()` calls keep compiling and behaving the same. From `onSuccess`, a default cached `userSubscriptions(...)` read returns the freshly written entitlements.

Java has three overloads (`@JvmStatic @JvmOverloads`):

```java
Purchasely.synchronize();
Purchasely.synchronize(onSuccess);
Purchasely.synchronize(onSuccess, onError);
```

> 🚧 Nullable callback parameters
>
> The `plan` in `onSuccess` and the `error` in `onError` are both nullable (`onError` receives `null` while a receipt is still `PENDING` backend validation) — Java callers must null-check before dereferencing. When multiple pending receipts are processed at once (rare), `onSuccess` fires after the first one validates; pass `invalidateCache = true` to `userSubscriptions(...)` if you need the authoritative batch state immediately.

***

## Removed APIs

| v5 API | v6 replacement |
| --- | --- |
| `Purchasely.setPaywallActionsInterceptor()` | `Purchasely.interceptAction<T> { … }` / `interceptAction(Class, callback)` |
| `PLYPresentationInfo` | `PLYInterceptorInfo` |
| `PLYPaywallActionHandler`, `PLYCompletionHandler`, `PLYPaywallActionListener`, `PLYProcessActionListener` | `PLYActionInterceptorCallback` / suspend lambda + `PLYInterceptResult` |
| `PLYPresentationActionParameters` | Parameters on each `PLYPresentationAction` subclass |
| `PLYPresentationProperties` | `PLYPresentation { … }` / `PLYPresentationBase.builder()` |
| `Purchasely.fetchPresentation(placementId, properties)` and suspend `fetchPresentation(placementId)` | `PLYPresentation { placementId("id") }.preload()` |
| `Purchasely.presentationView(context, placementId, properties, callback)` | `preload { loaded, _ -> loaded?.buildView(context) }` |
| `PLYPresentation.buildView(context, properties, callback)` | `buildView(context, callback)` — configure on the builder |
| suspend `PLYPresentation.display(context, transition)` extension | Non-suspend `loaded.display(context[, transition])` (+ `.await()` on the returned session) |
| `presentation.id` / `toMap()["id"]` | `presentation.screenId` / `toMap()["screenId"]` |
| `onClose` / `PLYPresentationClose` | `onCloseRequested` / `PLYPresentationCloseRequested` |
| `setDefaultPresentationResultHandler(handler)` | `setDefaultPresentationDismissHandler(handler?)` |
| `PLYPresentationFetchHandler` | `PLYPresentationHandler` |
| `back()` / `close()` on `PLYPresentationBase` | `back()` / `close()` on `PLYPresentation` (Loaded) only |
| `Purchasely.subscriptionsFragment()` and all subscription/cancellation UI | Build your own UI with `userSubscriptions()` / `userSubscriptionsHistory()` |
| Deeplinks `ply/subscriptions`, `ply/cancellation_survey[/ID]` | — (removed) |
| `PLYDeepLink.Subscriptions`, `PLYDeepLink.CancellationSurvey`, `PLYUIViewType.SUBSCRIPTION_LIST`, `PLYUIViewType.CANCELLATION_PAGE` | — (removed) |
| `PLYEvent.SubscriptionListViewed` and 4 other subscription-UI events | — (removed) |
| `Purchasely.purchaseHistory()` | `Purchasely.userSubscriptionsHistory()` |
| `Purchasely.isPastSubscriber()` | Derive from `userSubscriptionsHistory()` |
| `PLYPlan.intro*` / `introductory*` methods | `PLYPlan.offer*` methods |
| `PLYPlanTags.INTRO_*` / `TRIAL_*` values | `PLYPlanTags.OFFER_*` values |
| `PLYRunningMode.PaywallObserver` | `PLYRunningMode.Observer` |
| `Purchasely.isDeeplinkHandled(uri, activity)` | `Purchasely.handleDeeplink(uri, activity)` (usually unnecessary — auto-intercepted) |
| `readyToOpenDeeplink` (property & Builder) | `allowDeeplink` (property & Builder) |
| `PLYUserAttributeManager` (internal) | `PLYUserDataStorage` (internal) |
| `PLYManager.storage.configuration` / `.products` (internal) | `PLYManager.configuration` / `PLYManager.products` |

***

## Migration checklist

- [ ] Bump all `io.purchasely:*` dependencies to **6.1.0**; verify Gradle ≥ 9.3.0, Kotlin ≥ 2.2 with `jvmTarget = 11`, `minSdk` ≥ 23, `compileSdk` 36
- [ ] **Set `.runningMode(PLYRunningMode.Full)` explicitly if Purchasely handles and validates your purchases** (the default is now Observer)
- [ ] Rename `PLYRunningMode.PaywallObserver` → `PLYRunningMode.Observer`
- [ ] Update the init callback: `start { isConfigured, error -> }` → `start { error -> }` (or adopt the Kotlin DSL with `onInitialized { error -> }`)
- [ ] Replace `setPaywallActionsInterceptor` with per-action `interceptAction` registrations; map `processAction(false)` → `SUCCESS` and `processAction(true)` → `NOT_HANDLED`
- [ ] Replace `fetchPresentation` + `PLYPresentationProperties` with the `PLYPresentation { … }` builder; move every property onto the builder; remove `productId` / `planId` / `flowId` usage
- [ ] Replace `Purchasely.presentationView(...)` with `preload()` + `buildView(context, callback)`
- [ ] Update display/dismiss callbacks to the single `PLYPresentationOutcome` parameter; replace `PLYProductViewResult` with `PLYPurchaseResult`
- [ ] Rename `onClose` → `onCloseRequested`, `presentation.id` → `screenId`, `toMap()["id"]` → `toMap()["screenId"]`
- [ ] Update imports: `io.purchasely.ext.*` → `io.purchasely.ext.presentation.*` for presentation types
- [ ] Rename `setDefaultPresentationResultHandler` → `setDefaultPresentationDismissHandler`
- [ ] Deeplinks: remove manual `handleDeeplink` calls (or keep them — they are deduped); handle the `singleTask`/`singleTop` + `onNewIntent` case with `setIntent(intent)`
- [ ] If your app relied on deferred deeplinks or campaigns, set `.allowDeeplink(false)` / `.allowCampaigns(false)` at init and re-enable when your UI is ready (both now default to `true`)
- [ ] Rename `readyToOpenDeeplink` → `allowDeeplink`, `isDeeplinkHandled` → `handleDeeplink`
- [ ] Replace removed APIs: subscription/cancellation UI, `purchaseHistory()` / `isPastSubscriber()`, `intro*` / `INTRO_*` / `TRIAL_*`
- [ ] Remove `EventListener` branches matching the deleted subscription-UI `PLYEvent` subclasses
- [ ] Catch `PLYError.NoStoreConfigured` instead of `PLYError.Unknown` ("No store found")
- [ ] Observer mode: bridge `Purchase` / `Restore` actions through the interceptor (resolve the result exactly once) and use `synchronize(onSuccess, onError)` for out-of-paywall purchases
- [ ] Edge case: if some users still run a pre-migration v5 build (legacy `user_attributes.json`), re-set their user attributes after upgrading
- [ ] Build (`./gradlew :app:assembleDebug`) and run your test suite; verify the init callback receives `null`, a placement displays, and purchase/restore paths behave as expected in your running mode
