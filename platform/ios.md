# Purchasely iOS SDK Documentation

This document provides comprehensive documentation for integrating and using the Purchasely iOS SDK with Swift.

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
13. [StoreKit Configuration](#storekit-configuration)
14. [Troubleshooting](#troubleshooting)
15. [Additional Resources](#additional-resources)

---

## Requirements

| Requirement | Version |
|-------------|---------|
| iOS | 11.0+ |
| Xcode | 13.0+ |
| Swift | 5.0+ |

---

## Installation

Purchasely supports three installation methods: CocoaPods, Carthage, and Swift Package Manager.

### CocoaPods

Add Purchasely to your `Podfile`:

```ruby
pod 'Purchasely'
```

Then run:

```bash
pod install
```

### Carthage

Add Purchasely to your `Cartfile`:

```
binary "https://raw.githubusercontent.com/Purchasely/Purchasely-iOS/master/Purchasely.json"
```

Then run:

```bash
carthage update
```

### Swift Package Manager

1. In Xcode, select **File > Add Packages...**
2. Enter the repository URL:
   ```
   https://github.com/Purchasely/Purchasely-iOS
   ```
3. Select the version you want to use
4. Click **Add Package**

---

## SDK Initialization

Initialize the Purchasely SDK in your `AppDelegate`. This should be the first method executed by your application.

### Full Mode (Recommended)

In `full` mode, Purchasely handles the entire purchase flow including transactions and receipts.

```swift
import Purchasely

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Purchasely.start(
        withAPIKey: "YOUR_API_KEY",
        appUserId: nil, // Optional: set if you already know your user id
        runningMode: .full,
        storekitSettings: .storeKit2, // Set your StoreKit version
        logLevel: .debug // Set to .error for production
    ) { (success, error) in
        if success {
            print("Purchasely SDK configured successfully")
        } else {
            print("Purchasely SDK configuration failed: \(error?.localizedDescription ?? "unknown error")")
        }
    }
    return true
}
```

### PaywallObserver Mode

Use `paywallObserver` mode if you have an existing in-app purchase infrastructure and want to use Purchasely only for paywall display and analytics.

```swift
import Purchasely

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Purchasely.start(
        withAPIKey: "YOUR_API_KEY",
        appUserId: nil,
        runningMode: .paywallObserver,
        storekitSettings: .storeKit2,
        logLevel: .debug
    ) { (success, error) in
        if success {
            print("Purchasely SDK configured successfully")
        }
    }
    return true
}
```

### API Key

You can find your API Key in the Purchasely Console under **App settings > Backend & SDK configuration**.

### Initialization Callback

The callback returns two values:
- `success`: `true` if SDK was initialized successfully
- `error`: Contains the specific error if `success` is `false`

> **Important**: If you rely on subscription status or eligibility for offers, wait for the callback before proceeding.

---

## Displaying Paywalls

Purchasely paywalls are displayed using **placements**. A placement is a specific location in your app where you want to display a paywall (e.g., onboarding, settings, premium feature).

### Display a Placement

```swift
let placementId = "ONBOARDING"
let paywallCtrl = Purchasely.presentationController(
    for: placementId,
    contentId: nil, // Optional: associate content with the purchase
    completion: { (result, plan) in
        switch result {
        case .purchased:
            print("User purchased: \(plan?.name ?? "unknown")")
            // Update entitlements to unlock content
        case .restored:
            print("User restored: \(plan?.name ?? "unknown")")
            // Update entitlements to unlock content
        case .cancelled:
            print("User cancelled")
        @unknown default:
            break
        }
    }
)

// Present the paywall
if let paywallCtrl = paywallCtrl {
    present(paywallCtrl, animated: true)
}
```

### Display with Custom Loading Handler

```swift
let paywallCtrl = Purchasely.presentationController(
    for: "ONBOARDING",
    contentId: "my_content_id",
    loaded: { controller, presentation, plan in
        // Called when presentation is loaded and ready to display
        print("Presentation loaded: \(presentation?.id ?? "unknown")")
    },
    completion: { result, plan in
        switch result {
        case .purchased:
            print("User purchased: \(plan?.name ?? "unknown")")
        case .restored:
            print("User restored: \(plan?.name ?? "unknown")")
        case .cancelled:
            break
        @unknown default:
            break
        }
    }
)

if let paywallCtrl = paywallCtrl {
    present(paywallCtrl, animated: true)
}
```

### Close a Presentation

On iOS, Purchasely automatically closes the presentation after a successful purchase or restore. You can also dismiss it manually:

```swift
// Just dismiss the UIViewController returned by Purchasely
paywallCtrl?.dismiss(animated: true)
```

---

## Processing Transactions

### Full Mode

In `full` mode, Purchasely automatically handles the purchase flow when users tap a purchase button.

```swift
let paywallCtrl = Purchasely.presentationController(
    for: "PREMIUM_FEATURE",
    completion: { (result, plan) in
        switch result {
        case .purchased:
            print("User purchased: \(plan?.name ?? "unknown")")
            // Transaction completed - update entitlements
            unlockPremiumContent()
        case .cancelled:
            print("User cancelled purchase")
        case .restored:
            print("User restored: \(plan?.name ?? "unknown")")
            // Restore completed - update entitlements
            unlockPremiumContent()
        @unknown default:
            break
        }
    }
)

if let paywallCtrl = paywallCtrl {
    present(paywallCtrl, animated: true)
}
```

### PaywallObserver Mode

In `paywallObserver` mode, you handle transactions with your own infrastructure. Use the Paywall Action Interceptor to capture purchase intents.

---

## Paywall Action Interceptor

The Paywall Action Interceptor allows you to intercept user actions on the paywall such as purchases, logins, restores, and custom links.

### Basic Implementation

```swift
Purchasely.setPaywallActionsInterceptor { (action, parameters, presentationInfos, proceed) in
    switch action {
    case .purchase:
        // User tapped a purchase button
        print("Purchase action for plan: \(parameters?.plan?.name ?? "unknown")")
        proceed(true) // Continue with purchase

    case .login:
        // User tapped login button
        // Display your login screen
        showLoginScreen { success in
            if success {
                Purchasely.userLogin(with: "user_id")
            }
            proceed(success)
        }

    case .restore:
        // User tapped restore button
        print("Restore action")
        proceed(true) // Continue with restore

    case .openPresentation:
        // User tapped a button to open another presentation
        proceed(true)

    case .close:
        // User tapped close button
        proceed(true)

    case .promoCode:
        // User wants to enter a promo code
        proceed(true)

    default:
        // For all other actions, continue normally
        proceed(true)
    }
}
```

### Handle Custom Links

```swift
Purchasely.setPaywallActionsInterceptor { (action, parameters, presentationInfos, proceed) in
    if action == .navigate {
        if let url = parameters?.url, url.contains("your-custom-scheme") {
            // Handle your custom link
            handleCustomLink(url)
            proceed(false) // We handled it ourselves
            return
        }
    }
    proceed(true)
}
```

### PaywallObserver Mode with In-House Infrastructure

```swift
Purchasely.setPaywallActionsInterceptor { (action, parameters, presentationInfos, proceed) in
    switch action {
    case .purchase:
        // Grab the plan to purchase
        guard let plan = parameters?.plan,
              let appleProductId = plan.appleProductId else {
            return
        }

        // Use your own purchase system
        let success = MyPurchaseSystem.purchase(appleProductId)
        if success {
            // Synchronize new purchase with Purchasely for analytics
            Purchasely.synchronize()
        }
        proceed(false) // We handled the purchase ourselves

    case .restore:
        MyPurchaseSystem.restorePurchases()
        // Synchronize all purchases with Purchasely
        Purchasely.synchronize()
        proceed(false)

    default:
        proceed(true)
    }
}
```

### PaywallObserver Mode with RevenueCat

```swift
import RevenueCat

Purchasely.setPaywallActionsInterceptor { (action, parameters, presentationInfos, proceed) in
    switch action {
    case .purchase:
        guard let plan = parameters?.plan,
              let appleProductId = plan.appleProductId else {
            return
        }

        Purchases.shared.getOfferings { (offerings, error) in
            if let packages = offerings?.current?.availablePackages {
                if let package = packages.first(where: {
                    $0.storeProduct.productIdentifier == appleProductId
                }) {
                    Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
                        // Synchronize new purchase with Purchasely
                        Purchasely.synchronize()
                        proceed(false)

                        if customerInfo.entitlements["your_entitlement_id"]?.isActive == true {
                            // Unlock that great "pro" content
                        }
                    }
                }
            }
        }

    case .restore:
        Purchases.shared.restorePurchases { customerInfo, error in
            // Synchronize new purchase with Purchasely
            Purchasely.synchronize()
            proceed(false)
        }

    default:
        proceed(true)
    }
}
```

---

## User Identification

### Login User

When a user logs in, provide their user ID to Purchasely:

```swift
Purchasely.userLogin(with: "YOUR_USER_ID") { refresh in
    if refresh {
        // User has subscriptions from a previous device/install
        // Refresh your local entitlements
        refreshEntitlements()
    }
}
```

### Logout User

When a user logs out:

```swift
Purchasely.userLogout()
```

### Anonymous User ID

Get the anonymous user ID assigned by Purchasely:

```swift
let anonymousId = Purchasely.anonymousUserId
```

### Set User ID at Initialization

You can also set the user ID during SDK initialization:

```swift
Purchasely.start(
    withAPIKey: "YOUR_API_KEY",
    appUserId: "YOUR_USER_ID", // Set user ID here
    runningMode: .full,
    storekitSettings: .storeKit2,
    logLevel: .debug
) { success, error in
    // Handle initialization
}
```

---

## Subscription Status & Entitlements

### Get User Subscriptions

Retrieve the list of active subscriptions for the current user:

```swift
Purchasely.userSubscriptions { subscriptions, error in
    guard let subscriptions = subscriptions, error == nil else {
        print("Error fetching subscriptions: \(error?.localizedDescription ?? "unknown")")
        return
    }

    for subscription in subscriptions {
        print("Subscription: \(subscription.plan?.name ?? "unknown")")
        print("Product: \(subscription.product?.name ?? "unknown")")
        print("Expires: \(subscription.subscriptionSource?.nextRenewalDate ?? Date())")
    }
}
```

### Check Entitlements

```swift
Purchasely.userSubscriptions { subscriptions, error in
    guard let subscriptions = subscriptions else { return }

    let hasProAccess = subscriptions.contains { subscription in
        subscription.plan?.hasEntitlement("pro_features") == true
    }

    if hasProAccess {
        unlockProFeatures()
    }
}
```

---

## Custom User Attributes

Custom User Attributes allow you to segment users and target specific audiences with different paywalls.

### Set a Single Attribute

```swift
// String
Purchasely.setAttribute(.string("user@example.com"), forKey: "email")

// Integer
Purchasely.setAttribute(.int(25), forKey: "age")

// Double
Purchasely.setAttribute(.double(4.5), forKey: "score")

// Boolean
Purchasely.setAttribute(.bool(true), forKey: "premium_user")

// Date
Purchasely.setAttribute(.date(Date()), forKey: "registration_date")
```

### Set Multiple Attributes

```swift
let attributes: [String: PLYAttribute] = [
    "age": .int(25),
    "gender": .string("male"),
    "subscription_tier": .string("basic")
]

Purchasely.setAttributes(attributes)
```

### Get Attribute Value

```swift
if let age = Purchasely.userAttribute(for: "age") {
    print("User age: \(age)")
}
```

### Get All Attributes

```swift
let allAttributes = Purchasely.userAttributes()
for (key, value) in allAttributes {
    print("Attribute: \(key) = \(value)")
}
```

### Clear Attribute

```swift
Purchasely.clearUserAttribute(for: "email")
```

### Clear All Attributes

```swift
Purchasely.clearUserAttributes()
```

### Increment Attribute

Useful for tracking counters:

```swift
// Increment by 1
Purchasely.incrementUserAttribute(for: "viewed_articles")

// Increment by custom value
Purchasely.incrementUserAttribute(for: "points", by: 10)
```

### Decrement Attribute

```swift
// Decrement by 1
Purchasely.decrementUserAttribute(for: "remaining_credits")

// Decrement by custom value
Purchasely.decrementUserAttribute(for: "lives", by: 3)
```

---

## Event Listeners

### UI/SDK Events Listener

Track user interactions with Purchasely screens:

```swift
Purchasely.setEventDelegate(self)

// Implement PLYEventDelegate
extension YourClass: PLYEventDelegate {
    func eventTriggered(_ event: PLYEvent) {
        print("Event: \(event.name)")

        // Forward to your analytics platform
        yourAnalytics.track(event.name, properties: event.properties)
    }
}
```

### Custom User Attributes Listener

Listen for custom user attribute changes from surveys:

```swift
Purchasely.setUserAttributesDelegate(self)

// Implement PLYUserAttributesDelegate
extension YourClass: PLYUserAttributesDelegate {
    func onUserAttributeSet(
        key: String,
        value: Any,
        source: PLYUserAttributeSource
    ) {
        if source == .purchasely {
            // Attribute set by Purchasely (from survey)
            print("Survey attribute: \(key) = \(value)")
            // Send to your backend or analytics
            yourBackend.updateUserAttribute(key: key, value: value)
        }
        // Ignore if source is .client (set by your app)
    }

    func onUserAttributeRemoved(
        key: String,
        source: PLYUserAttributeSource
    ) {
        if source == .purchasely {
            print("Attribute removed: \(key)")
        }
    }
}
```

---

## Pre-fetching Screens

Pre-fetch presentations to display them instantly without loading time.

### Fetch Presentation

```swift
Purchasely.fetchPresentation(
    for: "onboarding",
    fetchCompletion: { presentation, error in
        guard let presentation = presentation, error == nil else {
            print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
            return
        }

        if presentation.type == .normal || presentation.type == .fallback {
            // Display directly
            presentation.display(from: self)

            // Alternatively: get the UIViewController to manage transition yourself
            // Note: this method won't work with Flows
            let purchaselyController = presentation.controller

        } else if presentation.type == .deactivated {
            // Nothing to display
            print("Placement is deactivated")

        } else if presentation.type == .client {
            let presentationId = presentation.id
            let planIds = presentation.plans
            // Display your own screen
        }
    },
    completion: { result, plan in
        // Closure when presentation controller is closed
        switch result {
        case .purchased:
            print("User purchased: \(plan?.name ?? "unknown")")
        case .restored:
            print("User restored: \(plan?.name ?? "unknown")")
        case .cancelled:
            break
        @unknown default:
            break
        }
    },
    loadedCompletion: {
        // Closure when presentation is loaded and displayed
        print("Presentation loaded and displayed")
    }
)
```

### Display Pre-fetched Presentation

```swift
// Store the presentation
var cachedPresentation: PLYPresentation?

// Fetch it
Purchasely.fetchPresentation(for: "premium_feature") { presentation, error in
    self.cachedPresentation = presentation
}

// Later, display it
func showPaywall() {
    guard let presentation = cachedPresentation else { return }

    switch presentation.type {
    case .normal, .fallback:
        presentation.display(from: self)
    case .deactivated:
        // Don't display
        break
    case .client:
        // Show custom paywall
        showCustomPaywall(with: presentation)
    @unknown default:
        break
    }
}
```

---

## Deeplinks Management

Purchasely can handle deeplinks to display specific presentations or trigger actions.

### Pass Deeplink to Purchasely SDK

#### Without SceneDelegate

```swift
// AppDelegate.swift
import Purchasely

func application(_ application: UIApplication,
                 open url: URL,
                 sourceApplication: String?,
                 annotation: Any) -> Bool {
    // You can chain calls to multiple handlers using OR
    return Purchasely.isDeeplinkHandled(deeplink: url)
}
```

#### With SceneDelegate

```swift
// SceneDelegate.swift
import Purchasely

func scene(_ scene: UIScene,
           willConnectTo session: UISceneSession,
           options connectionOptions: UIScene.ConnectionOptions) {
    // ...

    if let url = connectionOptions.urlContexts.first?.url {
        _ = Purchasely.isDeeplinkHandled(deeplink: url)
    }
}

func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let url = URLContexts.first?.url {
        _ = Purchasely.isDeeplinkHandled(deeplink: url)
    }
}
```

### Enable Deeplink Display

By default, deeplinks are processed but presentations won't display until you enable it:

```swift
// Enable after your UI is ready
Purchasely.readyToOpenDeeplink(true)
```

### Set Default Presentation Result Handler

Handle results from deeplink-triggered presentations:

```swift
Purchasely.setDefaultPresentationResultHandler { (result, plan) in
    switch result {
    case .purchased:
        print("Purchased from deeplink: \(plan?.name ?? "unknown")")
    case .restored:
        print("Restored from deeplink: \(plan?.name ?? "unknown")")
    case .cancelled:
        print("Cancelled from deeplink")
    @unknown default:
        break
    }
}
```

### Supported Deeplink Schemes

Purchasely handles deeplinks with the following schemes:
- `purchasely://`
- `https://` (with Purchasely domain)

Configure your deeplinks in the Purchasely Console under **Deeplinks** settings.

---

## StoreKit Configuration

### Choosing StoreKit Version

Purchasely supports both StoreKit 1 and StoreKit 2. Choose the version during SDK initialization:

#### StoreKit 2 (Recommended)

```swift
Purchasely.start(
    withAPIKey: "YOUR_API_KEY",
    appUserId: nil,
    runningMode: .full,
    storekitSettings: .storeKit2, // Use StoreKit 2
    logLevel: .debug
) { success, error in
    // Handle initialization
}
```

#### StoreKit 1

```swift
Purchasely.start(
    withAPIKey: "YOUR_API_KEY",
    appUserId: nil,
    runningMode: .full,
    storekitSettings: .storeKit1, // Use StoreKit 1
    logLevel: .debug
) { success, error in
    // Handle initialization
}
```

### Benefits of StoreKit 2

- Modern Swift async/await API
- Better transaction handling
- Improved offer eligibility
- Enhanced security

### When to Use StoreKit 1

- Supporting iOS versions below 15.0
- Existing codebase uses StoreKit 1
- Third-party SDKs require StoreKit 1

---

## Troubleshooting

### Enable Debug Logging

```swift
Purchasely.start(
    withAPIKey: "YOUR_API_KEY",
    appUserId: nil,
    runningMode: .full,
    storekitSettings: .storeKit2,
    logLevel: .debug // Enable verbose logging
) { success, error in
    // Handle initialization
}
```

### Common Issues

1. **SDK not configured**: Ensure `Purchasely.start()` is called in `didFinishLaunchingWithOptions` before any other SDK method
2. **Paywall not displaying**: Check that the placement ID matches your Console configuration
3. **Purchase not completing**: Verify your App Store Connect setup and that products are active
4. **User subscriptions empty**: Wait for the `start` callback before fetching subscriptions
5. **StoreKit errors**: Ensure you've selected the correct StoreKit version for your app

### Debug Purchase Issues

```swift
Purchasely.start(
    withAPIKey: "YOUR_API_KEY",
    appUserId: nil,
    runningMode: .full,
    storekitSettings: .storeKit2,
    logLevel: .debug
) { success, error in
    if !success {
        print("SDK Error: \(error?.localizedDescription ?? "unknown")")
    }
}
```

---

## Additional Resources

- [Purchasely Console](https://console.purchasely.io)
- [Full Documentation](https://docs.purchasely.com)
- [API Reference](https://docs.purchasely.com/api-reference)
- [GitHub Repository](https://github.com/Purchasely/Purchasely-iOS)

---

*This documentation is for Purchasely iOS SDK version 5.x*
