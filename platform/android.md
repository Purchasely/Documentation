# Purchasely Android SDK Documentation

This guide covers the Purchasely Android SDK v6 API for Kotlin and Java apps. Purchasely displays **Screens** and **Presentations** configured in the Console through placements, direct `screenId` lookups, campaigns, and Flows.

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
| compileSdkVersion | 35 |
| Kotlin | 2.2.x |
| Gradle | 9.x |
| JDK | 11 |

---

## Installation

Add Purchasely artifacts to your app module:

```kotlin
dependencies {
    implementation("io.purchasely:core:6.0.0")
    implementation("io.purchasely:google-play:6.0.0")

    // Optional video support for Screens containing video components.
    implementation("io.purchasely:player:6.0.0")

    // Optional Compose helper for embedded Presentations.
    implementation("io.purchasely:presentation-compose:6.0.0")
}
```

If you use Huawei or Amazon stores, add their Purchasely store artifact instead of or in addition to `google-play`.

---

## SDK Initialization

### Kotlin DSL

`Purchasely { ... }` configures and starts the SDK in one call. `context(...)` and `apiKey(...)` are mandatory.

```kotlin
class App : Application() {
    override fun onCreate() {
        super.onCreate()

        Purchasely {
            context(this@App)
            apiKey("YOUR_API_KEY")
            stores(listOf(GoogleStore()))
            runningMode(PLYRunningMode.Full)
            logLevel(LogLevel.DEBUG)
            allowDeeplink(true)
            allowCampaigns(true)
            onInitialized { error ->
                if (error == null) {
                    // SDK ready
                } else {
                    Log.e("Purchasely", "Initialization failed", error)
                }
            }
        }
    }
}
```

### Java / fluent Builder

```kotlin
Purchasely.Builder(applicationContext)
    .apiKey("YOUR_API_KEY")
    .stores(listOf(GoogleStore()))
    .runningMode(PLYRunningMode.Full)
    .allowDeeplink(true)
    .allowCampaigns(true)
    .build()
    .start { error ->
        if (error == null) {
            // SDK ready
        }
    }
```

### Running modes

| Mode | Use when |
|------|----------|
| `PLYRunningMode.Full` | Purchasely handles store purchases and receipt validation. |
| `PLYRunningMode.Observer` | Your app owns purchases; Purchasely observes transactions and displays Console-driven Screens. |

Default in v6 is `Observer`. Set `Full` explicitly when Purchasely must handle purchase execution.

---

## Displaying Presentations

Use the `PLYPresentation` builder. A prepared Presentation can be loaded with `preload()` and then displayed, or displayed atomically.

```kotlin
import io.purchasely.ext.presentation.PLYPresentation
import io.purchasely.ext.presentation.PLYPresentationType
import io.purchasely.ext.presentation.PLYPurchaseResult
import io.purchasely.ext.presentation.preload

val presentation = PLYPresentation {
    placementId("onboarding")
    contentId("article_42")
    onPresented { loaded, error ->
        if (error != null) Log.e("Purchasely", "Presentation failed", error)
    }
    onCloseRequested {
        Log.d("Purchasely", "User requested close")
    }
}.preload()

when (presentation.type) {
    PLYPresentationType.DEACTIVATED -> Unit
    PLYPresentationType.CLIENT -> showYourOwnScreen(presentation)
    else -> presentation.display(activity) { outcome ->
        when (outcome.purchaseResult) {
            PLYPurchaseResult.PURCHASED -> refreshEntitlements()
            PLYPurchaseResult.RESTORED -> refreshEntitlements()
            PLYPurchaseResult.CANCELLED, null -> Unit
        }
    }
}
```

### Selectors

```kotlin
PLYPresentation { placementId("onboarding") }
PLYPresentation { screenId("screen_abc123") }
PLYPresentation { flowId("flow_abc123") }
```

`screenId` is the canonical Android name for a direct Console Screen identifier. Do not use `presentationId` in Android public APIs.

### UI and callback options

```kotlin
val prepared = PLYPresentation {
    placementId("settings")
    backgroundColor(0xFF101820.toInt())
    progressColor(0xFFFFC857.toInt())
    displayCloseButton(true)
    displayBackButton(true)
    onPresented { presentation, error -> }
    onCloseRequested { }
    onDismissed { outcome -> }
}
```

### Prepared display helper

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

`display(context) { outcome }` fires on final dismissal. Do not use it as a “display triggered” callback.

---

## Action Interceptor

The v6 interceptor is registered per action and returns `PLYInterceptResult`.

```kotlin
import io.purchasely.ext.PLYInterceptResult
import io.purchasely.ext.interceptAction
import io.purchasely.ext.presentation.PLYPresentationAction

Purchasely.interceptAction<PLYPresentationAction.Login> { _, _ ->
    showLoginScreen()
    PLYInterceptResult.SUCCESS
}

Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, action ->
    if (observerMode) {
        launchBilling(
            activity = info?.activity,
            productId = action.plan.store_product_id,
            offerToken = action.subscriptionOffer?.offerToken,
        )
        PLYInterceptResult.SUCCESS
    } else {
        PLYInterceptResult.NOT_HANDLED
    }
}
```

| Result | Meaning |
|--------|---------|
| `SUCCESS` | App handled the action; SDK skips default behavior. |
| `FAILED` | App tried and failed; action chain stops. |
| `NOT_HANDLED` | SDK should continue with default behavior. |

Remove interceptors when tearing down a custom SDK wrapper:

```kotlin
Purchasely.removeAllActionInterceptors()
```

---

## Processing Transactions

In `Full` mode, Purchasely performs purchases from Presentation buttons.

In `Observer` mode, intercept purchase and restore actions, run your billing flow, then call `Purchasely.synchronize()` after success so Purchasely receives the transaction state.

```kotlin
private var pendingResult: ((PLYInterceptResult) -> Unit)? = null

Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
    suspendCancellableCoroutine { continuation ->
        pendingResult = { result ->
            if (continuation.isActive) continuation.resume(result)
        }
        startBilling(info?.activity, purchase.plan.store_product_id, purchase.subscriptionOffer?.offerToken)
    }
}

fun onBillingSuccess() {
    Purchasely.synchronize()
    pendingResult?.invoke(PLYInterceptResult.SUCCESS)
    pendingResult = null
}
```

---

## Embedded Presentations

Use `display()` for standard modal/Flow display. Use embedded APIs only when your app must own the container.

### Android View

```kotlin
val view = presentation.buildView(context) { outcome ->
    // Embedded result
}
container.addView(view)
```

### Fragment

```kotlin
val fragment = presentation.getFragment { outcome -> }
supportFragmentManager.beginTransaction()
    .replace(R.id.container, fragment)
    .commit()
```

### Compose

With the optional Compose artifact:

```kotlin
import io.purchasely.ext.presentation.compose.PLYPresentationView

PLYPresentationView(
    presentation = presentation,
    modifier = Modifier.fillMaxWidth(),
    callback = { outcome -> }
)
```

Without the artifact:

```kotlin
AndroidView(
    factory = { context -> presentation.buildView(context) ?: FrameLayout(context) }
)
```

---

## Preloading

```kotlin
var cached: PLYPresentation? = null

lifecycleScope.launch {
    cached = PLYPresentation { placementId("premium_feature") }.preload()
}

button.setOnClickListener {
    cached?.display(activity) { outcome -> }
}
```

Every builder/prepared/loaded presentation exposes `state: StateFlow<PLYPresentationState>`.

```kotlin
lifecycleScope.launch {
    prepared.state.collect { state ->
        when (state) {
            PLYPresentationState.Idle -> Unit
            PLYPresentationState.Loading -> showLoading()
            PLYPresentationState.Loaded -> hideLoading()
            PLYPresentationState.Displayed -> Unit
            is PLYPresentationState.Error -> showError(state.error)
        }
    }
}
```

---

## User Identification

```kotlin
Purchasely.userLogin("user_123") { shouldRefresh ->
    shouldRefresh
}

Purchasely.userLogout()
```

Call `userLogin` before loading Screens that depend on identified-user audiences.

---

## Subscription Status & Entitlements

```kotlin
Purchasely.userSubscriptions(false, object : SubscriptionsListener {
    override fun onSuccess(subscriptions: List<PLYSubscriptionData>) {
        val active = subscriptions.any { it.subscriptionStatus?.isExpired() == false }
    }

    override fun onFailure(error: Throwable) {
        Log.e("Purchasely", "Subscription fetch failed", error)
    }
})
```

---

## Custom User Attributes

User attribute mutations return `Deferred<Boolean>`; you may ignore the return value when fire-and-forget behavior is enough.

```kotlin
Purchasely.setUserAttribute("favorite_spirit", "gin")
val success = Purchasely.incrementUserAttribute("cocktails_viewed").await()
```

---

## Event Listeners

```kotlin
Purchasely.eventListener = object : EventListener {
    override fun onEvent(event: PLYEvent) {
        Log.d("Purchasely", "${event.name}: ${event.properties}")
    }
}
```

---

## Deeplinks & Campaigns

```kotlin
Purchasely.allowDeeplink = true
Purchasely.allowCampaigns = true

fun handleIncoming(uri: Uri, activity: Activity) {
    Purchasely.handleDeeplink(uri, activity)
}
```

Use `allowCampaigns(false)` during startup/onboarding when automated campaign display must be deferred.

---

## Alternative Stores

```kotlin
Purchasely {
    context(application)
    apiKey("YOUR_API_KEY")
    stores(listOf(GoogleStore(), HuaweiStore(), AmazonStore()))
    runningMode(PLYRunningMode.Full)
}
```

---

## Troubleshooting

| Symptom | Check |
|---------|-------|
| Presentation does not display | Placement ID or `screenId`, SDK initialization callback, network logs. |
| Close result is missing | Use `display(context) { outcome }` or `onDismissed { outcome }`. |
| Observer purchase does not update access | Call `Purchasely.synchronize()` after your billing flow succeeds. |
| Deeplink does nothing | Call `Purchasely.allowDeeplink = true` only after the UI can display a Screen. |
| Wrong Screen appears | Verify placement mapping, audience targeting, user attributes, and campaigns. |

For v5 to v6 breaking changes, see `docs/SDK Migration/migrating-from-v5-to-v6-android.md`.
