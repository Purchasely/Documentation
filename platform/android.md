# Purchasely Android SDK Documentation

This document provides comprehensive documentation for integrating and using the Purchasely Android SDK with Kotlin.

---

## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
3. [SDK Initialization](#sdk-initialization)
4. [Displaying Paywalls](#displaying-paywalls)
5. [Processing Transactions](#processing-transactions)
6. [Paywall Action Interceptor](#paywall-action-interceptor)
7. [User Identification](#user-identification)
8. [Subscription Status & Entitlements](#subscription-status--entitlements)
9. [Custom User Attributes](#custom-user-attributes)
10. [Event Listeners](#event-listeners)
11. [Pre-fetching Screens](#pre-fetching-screens)
12. [Deeplinks Management](#deeplinks-management)
13. [Alternative Stores](#alternative-stores)

---

## Requirements

| Requirement | Version |
|-------------|---------|
| minSdkVersion | 23 |
| compileSdkVersion | 34 |
| Kotlin | 2.+ |
| Gradle | 8.+ |
| JDK | 11 |

---

## Installation

### Add Maven Repository

Add the Purchasely Maven repository to your project-level `settings.gradle.kts`:

```kotlin
// settings.gradle.kts
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://maven.purchasely.io")
        }
    }
}
```

### Add Dependencies

Add the required dependencies to your app-level `build.gradle.kts`:

```kotlin
// app/build.gradle.kts
dependencies {
    // Core SDK - Required
    implementation("io.purchasely:core:5.+")

    // Google Play Store - Required for Google Play
    implementation("io.purchasely:google-play:5.+")

    // Video Player - Optional, for video support in paywalls
    implementation("io.purchasely:player:5.+")
}
```

> **Note**: The `player` dependency is optional but recommended if your paywalls contain video content.

---

## SDK Initialization

Initialize the Purchasely SDK in your Application class. This should be the first method executed by your application.

### Full Mode (Recommended)

In `full` mode, Purchasely handles the entire purchase flow including transactions and receipts.

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
            .apiKey("YOUR_API_KEY")
            .userId(null) // Optional: set if you already know your user id
            .stores(listOf(GoogleStore()))
            .logLevel(LogLevel.DEBUG) // Set to ERROR for production
            .runningMode(PLYRunningMode.Full)
            .build()
            .start { isConfigured, error ->
                if (isConfigured) {
                    // Purchasely SDK is ready
                    Log.d("Purchasely", "SDK configured successfully")
                } else {
                    // Handle configuration error
                    Log.e("Purchasely", "SDK configuration failed: ${error?.message}")
                }
            }
    }
}
```

### PaywallObserver Mode

Use `paywallObserver` mode if you have an existing in-app purchase infrastructure and want to use Purchasely only for paywall display and analytics.

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
            .apiKey("YOUR_API_KEY")
            .userId(null)
            .stores(listOf(GoogleStore()))
            .logLevel(LogLevel.DEBUG)
            .runningMode(PLYRunningMode.PaywallObserver)
            .build()
            .start { isConfigured, error ->
                if (isConfigured) {
                    // Purchasely SDK is ready
                }
            }
    }
}
```

### API Key

You can find your API Key in the Purchasely Console under **App settings > Backend & SDK configuration**.

### Initialization Callback

The callback returns two values:
- `isConfigured`: `true` if SDK was initialized successfully
- `error`: Contains the specific error if `isConfigured` is `false`

> **Important**: If you rely on subscription status or eligibility for offers, wait for the callback before proceeding.

---

## Displaying Paywalls

Purchasely paywalls are displayed using **placements**. A placement is a specific location in your app where you want to display a paywall (e.g., onboarding, settings, premium feature).

### Display a Placement

```kotlin
val presentationView = Purchasely.presentationView(
    context = context,
    properties = PLYPresentationProperties(
        placementId = "PLACEMENT_ID",
        contentId = null, // Optional: associate content with the purchase
        onClose = {
            // Called when paywall should be closed
            // Remove view from layout hierarchy here
        }
    )
) { result, plan ->
    when (result) {
        PLYProductViewResult.PURCHASED -> {
            Log.d("Purchasely", "User purchased ${plan?.name}")
            // Update entitlements to unlock content
        }
        PLYProductViewResult.CANCELLED -> {
            Log.d("Purchasely", "User cancelled")
        }
        PLYProductViewResult.RESTORED -> {
            Log.d("Purchasely", "User restored ${plan?.name}")
            // Update entitlements to unlock content
        }
    }
}

// Add presentationView to your layout hierarchy
yourContainer.addView(presentationView)
```

### Display with Activity or Fragment

You can also display presentations using `presentationViewForPlacement`:

```kotlin
val paywallView = Purchasely.presentationViewForPlacement(
    context,
    placementId = "onboarding",
    onClose = {
        // Remove view from layout hierarchy
    }
) { result, plan ->
    when (result) {
        PLYProductViewResult.PURCHASED -> Log.d("Purchasely", "User purchased ${plan?.name}")
        PLYProductViewResult.CANCELLED -> Log.d("Purchasely", "User cancelled")
        PLYProductViewResult.RESTORED -> Log.d("Purchasely", "User restored ${plan?.name}")
    }
}

// Add paywallView to your layout
```

### Close a Presentation

Unlike other platforms, on Android you must manually handle the close callback:

```kotlin
val presentationView = Purchasely.presentationView(
    context = context,
    properties = PLYPresentationProperties(
        placementId = "PLACEMENT_ID",
        onClose = {
            // Implement this callback to remove the view
            yourContainer.removeView(presentationView)
        }
    )
) { result, plan ->
    // Handle result
}
```

---

## Processing Transactions

### Full Mode

In `full` mode, Purchasely automatically handles the purchase flow when users tap a purchase button.

```kotlin
val paywallView = Purchasely.presentationViewForPlacement(
    context,
    placementId = "onboarding",
    onClose = {
        // Remove view from layout hierarchy
    }
) { result, plan ->
    when (result) {
        PLYProductViewResult.PURCHASED -> {
            Log.d("Purchasely", "User purchased ${plan?.name}")
            // Transaction completed - update entitlements
            unlockPremiumContent()
        }
        PLYProductViewResult.CANCELLED -> {
            Log.d("Purchasely", "User cancelled purchase")
        }
        PLYProductViewResult.RESTORED -> {
            Log.d("Purchasely", "User restored ${plan?.name}")
            // Restore completed - update entitlements
            unlockPremiumContent()
        }
    }
}
```

### PaywallObserver Mode

In `paywallObserver` mode, you handle transactions with your own infrastructure. Use the Paywall Action Interceptor to capture purchase intents.

---

## Paywall Action Interceptor

The Paywall Action Interceptor allows you to intercept user actions on the paywall such as purchases, logins, restores, and custom links.

### Basic Implementation

```kotlin
Purchasely.setPaywallActionsInterceptor { info, action, parameters, processAction ->
    when (action) {
        PLYPresentationAction.PURCHASE -> {
            // User tapped a purchase button
            Log.d("Purchasely", "Purchase action for plan: ${parameters.plan?.name}")
            processAction(true) // Continue with purchase
        }
        PLYPresentationAction.LOGIN -> {
            // User tapped login button
            // Display your login screen
            showLoginScreen { success ->
                if (success) {
                    Purchasely.userLogin("user_id")
                }
                processAction(success)
            }
        }
        PLYPresentationAction.RESTORE -> {
            // User tapped restore button
            Log.d("Purchasely", "Restore action")
            processAction(true) // Continue with restore
        }
        PLYPresentationAction.OPEN_PRESENTATION -> {
            // User tapped a button to open another presentation
            processAction(true)
        }
        PLYPresentationAction.CLOSE -> {
            // User tapped close button
            processAction(true)
        }
        PLYPresentationAction.PROMO_CODE -> {
            // User wants to enter a promo code
            processAction(true)
        }
        else -> {
            // For all other actions, continue normally
            processAction(true)
        }
    }
}
```

### Handle Custom Links

You can add custom links in your paywall from the Purchasely Console. Intercept them with:

```kotlin
Purchasely.setPaywallActionsInterceptor { info, action, parameters, processAction ->
    if (action == PLYPresentationAction.OPEN_PRESENTATION) {
        val url = parameters.url
        if (url != null && url.contains("your-custom-scheme")) {
            // Handle your custom link
            handleCustomLink(url)
            processAction(false) // We handled it ourselves
            return@setPaywallActionsInterceptor
        }
    }
    processAction(true)
}
```

### PaywallObserver Mode with In-House Infrastructure

When using `paywallObserver` mode with your own purchase system:

```kotlin
Purchasely.setPaywallActionsInterceptor { info, action, parameters, processAction ->
    when (action) {
        PLYPresentationAction.PURCHASE -> {
            val plan = parameters.plan
            val offerId = parameters.offer?.vendorId ?: plan?.basePlanId

            // Use your own purchase system
            yourPurchaseManager.purchase(
                productId = plan?.productId,
                offerId = offerId,
                onSuccess = { purchase ->
                    // Sync the purchase with Purchasely for analytics
                    Purchasely.synchronize()
                    processAction(true)
                },
                onError = { error ->
                    processAction(false)
                }
            )
        }
        PLYPresentationAction.RESTORE -> {
            // Use your own restore system
            yourPurchaseManager.restore { success ->
                if (success) {
                    Purchasely.synchronize()
                }
                processAction(success)
            }
        }
        else -> processAction(true)
    }
}
```

### PaywallObserver Mode with RevenueCat

```kotlin
Purchasely.setPaywallActionsInterceptor { info, action, parameters, processAction ->
    when (action) {
        PLYPresentationAction.PURCHASE -> {
            val plan = parameters.plan
            val subscriptionOption = parameters.subscriptionOffer?.subscriptionOption

            if (subscriptionOption != null) {
                // RevenueCat purchase with subscription option
                Purchases.sharedInstance.purchase(
                    PurchaseParams.Builder(info.activity, subscriptionOption).build(),
                    object : PurchaseCallback {
                        override fun onCompleted(storeTransaction: StoreTransaction, customerInfo: CustomerInfo) {
                            Purchasely.synchronize()
                            processAction(true)
                        }
                        override fun onError(error: PurchasesError, userCancelled: Boolean) {
                            processAction(false)
                        }
                    }
                )
            }
        }
        PLYPresentationAction.RESTORE -> {
            Purchases.sharedInstance.restorePurchases(object : ReceiveCustomerInfoCallback {
                override fun onReceived(customerInfo: CustomerInfo) {
                    Purchasely.synchronize()
                    processAction(true)
                }
                override fun onError(error: PurchasesError) {
                    processAction(false)
                }
            })
        }
        else -> processAction(true)
    }
}
```

---

## User Identification

### Login User

When a user logs in, provide their user ID to Purchasely:

```kotlin
Purchasely.userLogin("YOUR_USER_ID") { refresh ->
    if (refresh) {
        // User has subscriptions from a previous device/install
        // Refresh your local entitlements
        refreshEntitlements()
    }
}
```

### Logout User

When a user logs out:

```kotlin
Purchasely.userLogout()
```

### Anonymous User ID

Get the anonymous user ID assigned by Purchasely:

```kotlin
val anonymousId = Purchasely.anonymousUserId
```

### Set User ID at Initialization

You can also set the user ID during SDK initialization:

```kotlin
Purchasely.Builder(applicationContext)
    .apiKey("YOUR_API_KEY")
    .userId("YOUR_USER_ID") // Set user ID here
    .stores(listOf(GoogleStore()))
    .build()
    .start { isConfigured, error -> }
```

---

## Subscription Status & Entitlements

### Get User Subscriptions

Retrieve the list of active subscriptions for the current user:

```kotlin
Purchasely.userSubscriptions(
    onSuccess = { subscriptions ->
        subscriptions.forEach { subscription ->
            Log.d("Purchasely", "Subscription: ${subscription.plan?.name}")
            Log.d("Purchasely", "Product: ${subscription.product?.name}")
            Log.d("Purchasely", "Expires: ${subscription.subscriptionSource?.nextRenewalDate}")
        }
    },
    onError = { throwable ->
        Log.e("Purchasely", "Error fetching subscriptions: ${throwable.message}")
    }
)
```

### Check Entitlements

You can check if a user has access to specific entitlements:

```kotlin
Purchasely.userSubscriptions(
    onSuccess = { subscriptions ->
        val hasProAccess = subscriptions.any { subscription ->
            subscription.plan?.hasEntitlement("pro_features") == true
        }
        if (hasProAccess) {
            unlockProFeatures()
        }
    },
    onError = { throwable ->
        // Handle error
    }
)
```

---

## Custom User Attributes

Custom User Attributes allow you to segment users and target specific audiences with different paywalls.

### Set a Single Attribute

```kotlin
// String
Purchasely.setUserAttribute("email", "user@example.com")

// Integer
Purchasely.setUserAttribute("age", 25)

// Float
Purchasely.setUserAttribute("score", 4.5f)

// Boolean
Purchasely.setUserAttribute("premium_user", true)

// Date
Purchasely.setUserAttribute("registration_date", Date())
```

### Set Multiple Attributes

```kotlin
Purchasely.setUserAttributes(
    mapOf(
        Pair("age", 25),
        Pair("gender", "male"),
        Pair("subscription_tier", "basic")
    )
)
```

### Get Attribute Value

```kotlin
val age = Purchasely.userAttribute("age")
```

### Get All Attributes

```kotlin
val allAttributes = Purchasely.userAttributes()
allAttributes.forEach { (key, value) ->
    Log.d("Purchasely", "Attribute: $key = $value")
}
```

### Clear Attribute

```kotlin
Purchasely.clearUserAttribute("email")
```

### Clear All Attributes

```kotlin
Purchasely.clearUserAttributes()
```

### Increment Attribute

Useful for tracking counters:

```kotlin
// Increment by 1
Purchasely.incrementUserAttribute("viewed_articles")

// Increment by custom value
Purchasely.incrementUserAttribute("points", 10)
```

### Decrement Attribute

```kotlin
// Decrement by 1
Purchasely.decrementUserAttribute("remaining_credits")

// Decrement by custom value
Purchasely.decrementUserAttribute("lives", 3)
```

---

## Event Listeners

### UI/SDK Events Listener

Track user interactions with Purchasely screens:

```kotlin
Purchasely.setEventListener(object : EventListener {
    override fun onEvent(event: PLYEvent) {
        Log.d("Purchasely", "Event: ${event.name}")

        // Forward to your analytics platform
        yourAnalytics.track(event.name, event.properties)
    }
})
```

### Custom User Attributes Listener

Listen for custom user attribute changes from surveys:

```kotlin
Purchasely.setUserAttributeListener(object : UserAttributeListener {
    override fun onUserAttributeSet(
        key: String,
        value: Any,
        source: PLYUserAttributeSource
    ) {
        if (source == PLYUserAttributeSource.PURCHASELY) {
            // Attribute set by Purchasely (from survey)
            Log.d("Purchasely", "Survey attribute: $key = $value")
            // Send to your backend or analytics
            yourBackend.updateUserAttribute(key, value)
        }
        // Ignore if source is CLIENT (set by your app)
    }

    override fun onUserAttributeRemoved(key: String, source: PLYUserAttributeSource) {
        if (source == PLYUserAttributeSource.PURCHASELY) {
            Log.d("Purchasely", "Attribute removed: $key")
        }
    }
})
```

---

## Pre-fetching Screens

Pre-fetch presentations to display them instantly without loading time.

### Fetch Presentation

```kotlin
Purchasely.fetchPresentation(
    placementId = "onboarding",
    contentId = null
) { presentation, error ->
    if (error != null) {
        Log.e("Purchasely", "Error fetching: ${error.message}")
        return@fetchPresentation
    }

    when (presentation?.type) {
        PLYPresentationType.NORMAL -> {
            // Standard paywall - display it
            presentation.display()
        }
        PLYPresentationType.FALLBACK -> {
            // Fallback paywall (network error occurred)
            presentation.display()
        }
        PLYPresentationType.DEACTIVATED -> {
            // Placement is deactivated - don't show anything
            Log.d("Purchasely", "Placement is deactivated")
        }
        PLYPresentationType.CLIENT -> {
            // Custom paywall - display your own UI
            val presentationId = presentation.id
            displayYourCustomPaywall(presentationId)
        }
        else -> {
            Log.d("Purchasely", "Unknown presentation type")
        }
    }
}
```

### Display Pre-fetched Presentation

```kotlin
// Store the presentation
var cachedPresentation: PLYPresentation? = null

// Fetch it
Purchasely.fetchPresentation(placementId = "premium_feature") { presentation, error ->
    cachedPresentation = presentation
}

// Later, display it
fun showPaywall() {
    cachedPresentation?.let { presentation ->
        when (presentation.type) {
            PLYPresentationType.NORMAL, PLYPresentationType.FALLBACK -> {
                val view = presentation.buildView(
                    context = this,
                    onClose = { /* handle close */ }
                ) { result, plan ->
                    // Handle result
                }
                yourContainer.addView(view)
            }
            PLYPresentationType.DEACTIVATED -> {
                // Don't display
            }
            PLYPresentationType.CLIENT -> {
                // Show custom paywall
            }
            else -> {}
        }
    }
}
```

---

## Deeplinks Management

Purchasely can handle deeplinks to display specific presentations or trigger actions.

### Check if Deeplink is Handled

```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    intent.data?.let { uri ->
        val isHandled = Purchasely.isDeeplinkHandled(uri)
        if (isHandled) {
            Log.d("Purchasely", "Deeplink handled by Purchasely")
        } else {
            // Handle the deeplink yourself
            handleOtherDeeplink(uri)
        }
    }
}
```

### Enable Deeplink Display

By default, deeplinks are processed but presentations won't display until you enable it:

```kotlin
// Enable after your UI is ready
Purchasely.readyToOpenDeeplink = true
```

### Set Default Presentation Result Handler

Handle results from deeplink-triggered presentations:

```kotlin
Purchasely.setDefaultPresentationResultHandler { result, plan ->
    when (result) {
        PLYProductViewResult.PURCHASED -> {
            Log.d("Purchasely", "Purchased from deeplink: ${plan?.name}")
        }
        PLYProductViewResult.RESTORED -> {
            Log.d("Purchasely", "Restored from deeplink: ${plan?.name}")
        }
        PLYProductViewResult.CANCELLED -> {
            Log.d("Purchasely", "Cancelled from deeplink")
        }
    }
}
```

### Supported Deeplink Schemes

Purchasely handles deeplinks with the following schemes:
- `purchasely://`
- `https://` (with Purchasely domain)

Configure your deeplinks in the Purchasely Console under **Deeplinks** settings.

---

## Alternative Stores

### Huawei Mobile Services

Add Huawei repository and dependencies:

```groovy
// project/build.gradle
buildscript {
    repositories {
        maven { url 'https://developer.huawei.com/repo/' }
    }
    dependencies {
        classpath 'com.huawei.agconnect:agcp:1.6.0.300'
    }
}

allprojects {
    repositories {
        maven { url 'https://developer.huawei.com/repo/' }
    }
}
```

```groovy
// app/build.gradle
apply plugin: 'com.huawei.agconnect'

dependencies {
    implementation 'io.purchasely:huawei-services:5.+'
}
```

Initialize with HuaweiStore:

```kotlin
Purchasely.Builder(applicationContext)
    .apiKey("YOUR_API_KEY")
    .stores(listOf(HuaweiStore()))
    .build()
    .start { isConfigured, error -> }
```

### Amazon App Store

Add the Amazon dependency:

```groovy
dependencies {
    implementation 'io.purchasely:amazon:5.+'
}
```

Initialize with AmazonStore:

```kotlin
Purchasely.Builder(applicationContext)
    .apiKey("YOUR_API_KEY")
    .stores(listOf(AmazonStore()))
    .build()
    .start { isConfigured, error -> }
```

### Multiple Stores

You can configure multiple stores. The first available store will be used:

```kotlin
Purchasely.Builder(applicationContext)
    .apiKey("YOUR_API_KEY")
    .stores(listOf(GoogleStore(), AmazonStore(), HuaweiStore()))
    .build()
    .start { isConfigured, error -> }
```

---

## ProGuard Configuration

If you use ProGuard, add the following rules:

```proguard
-keep class io.purchasely.** { *; }
-keep class com.android.vending.billing.** { *; }
```

---

## Troubleshooting

### Enable Debug Logging

```kotlin
Purchasely.Builder(applicationContext)
    .apiKey("YOUR_API_KEY")
    .logLevel(LogLevel.DEBUG) // Enable verbose logging
    .stores(listOf(GoogleStore()))
    .build()
    .start { isConfigured, error -> }
```

### Common Issues

1. **SDK not configured**: Ensure `start()` is called before any other SDK method
2. **Paywall not displaying**: Check that the placement ID matches your Console configuration
3. **Purchase not completing**: Verify your Google Play Console setup and that products are active
4. **User subscriptions empty**: Wait for the `start` callback before fetching subscriptions

---

## Additional Resources

- [Purchasely Console](https://console.purchasely.io)
- [Full Documentation](https://docs.purchasely.com)
- [API Reference](https://docs.purchasely.com/api-reference)

---

*This documentation is for Purchasely Android SDK version 5.x*
