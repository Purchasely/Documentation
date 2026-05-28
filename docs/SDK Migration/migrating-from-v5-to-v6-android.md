# Android SDK migration — v5.x to v6.0.0

This page covers the native Android SDK only. It intentionally does not cover iOS, React Native, Flutter, or Cordova migrations.

---

## Summary

| v5 | v6 |
|----|----|
| `PLYRunningMode.PaywallObserver` | `PLYRunningMode.Observer` |
| `readyToOpenDeeplink` | `allowDeeplink` |
| `isDeeplinkHandled(uri, activity)` | `handleDeeplink(uri, activity)` |
| `Purchasely.fetchPresentation(...)` | `PLYPresentation { ... }.preload()` |
| `PLYPresentation.id` | `PLYPresentation.screenId` |
| `onClose` | `onCloseRequested` |
| `setPaywallActionsInterceptor` | `interceptAction<PLYPresentationAction.X>` |
| `PLYProductViewResult` | `PLYPresentationOutcome.purchaseResult` |
| `presentationView(...)` | `presentation.buildView(...)` or `io.purchasely:presentation-compose` |

`screenId` is the canonical Android public name. Do not rename Android APIs to `presentationId`; other SDKs and bridges should map their historical names to `screenId`.

---

## 1. Update dependencies

```kotlin
dependencies {
    implementation("io.purchasely:core:6.0.0")
    implementation("io.purchasely:google-play:6.0.0")
    implementation("io.purchasely:player:6.0.0") // optional video support
    implementation("io.purchasely:presentation-compose:6.0.0") // optional Compose embedding
}
```

Use Gradle 9.x, Kotlin 2.2.x, JDK 11, minSdk 23, and compileSdk 35.

---

## 2. Rewrite initialization

### Kotlin DSL

```kotlin
Purchasely {
    context(application)
    apiKey(apiKey)
    stores(listOf(GoogleStore()))
    runningMode(PLYRunningMode.Full)
    allowDeeplink(true)
    allowCampaigns(true)
    onInitialized { error ->
        if (error == null) {
            // SDK ready
        }
    }
}
```

### Fluent Builder

```kotlin
Purchasely.Builder(applicationContext)
    .apiKey(apiKey)
    .stores(listOf(GoogleStore()))
    .runningMode(PLYRunningMode.Full)
    .allowDeeplink(true)
    .allowCampaigns(true)
    .build()
    .start { error -> }
```

Default running mode is now `Observer`. Set `Full` explicitly when Purchasely should execute purchases and validate receipts.

---

## 3. Migrate Presentation loading and display

```kotlin
import io.purchasely.ext.presentation.PLYPresentation
import io.purchasely.ext.presentation.PLYPresentationType
import io.purchasely.ext.presentation.PLYPurchaseResult
import io.purchasely.ext.presentation.preload

val presentation = PLYPresentation {
    placementId("onboarding")
    contentId("article_42")
    onPresented { loaded, error -> }
    onCloseRequested { }
}.preload()

when (presentation.type) {
    PLYPresentationType.DEACTIVATED -> Unit
    PLYPresentationType.CLIENT -> showYourOwnScreen(presentation)
    else -> presentation.display(activity) { outcome ->
        when (outcome.purchaseResult) {
            PLYPurchaseResult.PURCHASED -> refreshAccess()
            PLYPurchaseResult.RESTORED -> refreshAccess()
            PLYPurchaseResult.CANCELLED, null -> Unit
        }
    }
}
```

### Select by Screen

```kotlin
val presentation = PLYPresentation {
    screenId("screen_abc123")
}.preload()
```

### Display atomically

```kotlin
PLYPresentation { placementId("onboarding") }.display(
    context = activity,
    presentation = { loaded ->
        // Display has been triggered.
    },
    callback = { outcome ->
        // Final dismissal.
    }
)
```

`display(context) { outcome }` fires on final dismissal, not when display is first triggered.

---

## 4. Use the observable state

```kotlin
val prepared = PLYPresentation { placementId("onboarding") }

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

## 5. Replace embedded APIs

### View

```kotlin
val view = presentation.buildView(context) { outcome -> }
container.addView(view)
```

### Fragment

```kotlin
val fragment = presentation.getFragment { outcome -> }
```

### Compose

```kotlin
import io.purchasely.ext.presentation.compose.PLYPresentationView

PLYPresentationView(
    presentation = presentation,
    modifier = Modifier.fillMaxWidth(),
    callback = { outcome -> }
)
```

---

## 6. Replace the action interceptor

```kotlin
Purchasely.interceptAction<PLYPresentationAction.Login> { _, _ ->
    showLogin()
    PLYInterceptResult.SUCCESS
}

Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, action ->
    if (observerMode) {
        launchBilling(info?.activity, action.plan.store_product_id, action.subscriptionOffer?.offerToken)
        PLYInterceptResult.SUCCESS
    } else {
        PLYInterceptResult.NOT_HANDLED
    }
}
```

Mapping:

| v5 callback | v6 result |
|-------------|-----------|
| `processAction(false)` — app handled it | `PLYInterceptResult.SUCCESS` |
| `processAction(true)` — SDK continues | `PLYInterceptResult.NOT_HANDLED` |
| New failure path | `PLYInterceptResult.FAILED` |

---

## 7. Observer mode bridge

In Observer mode, suspend the action interceptor until your billing flow returns:

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

fun onBillingCancelled() {
    pendingResult?.invoke(PLYInterceptResult.NOT_HANDLED)
    pendingResult = null
}

fun onBillingError() {
    pendingResult?.invoke(PLYInterceptResult.FAILED)
    pendingResult = null
}
```

---

## 8. Search checklist

These searches should return no current-app usages after migration, except inside comments that document legacy v5 code:

```bash
rg "fetchPresentation|presentationView\(|PLYPresentationProperties|PLYPresentationActionParameters|PLYPresentationInfo|PLYProductViewResult|readyToOpenDeeplink|isDeeplinkHandled" app/src
```

The following legacy identifiers can still appear in migration notes because they are the names being replaced:

```bash
rg "setPaywallActionsInterceptor|PaywallObserver" docs
```

---

## 9. Verification

```bash
./gradlew :app:assembleDebug
./gradlew :app:testDebugUnitTest
```

Also manually verify:

1. SDK initialization callback receives `null` error.
2. A placement-based Presentation displays.
3. A direct `screenId` Presentation displays.
4. `onPresented`, `onCloseRequested`, and final `display` outcome are logged in the expected order.
5. Observer-mode purchase and restore paths resolve `PLYInterceptResult` exactly once.
