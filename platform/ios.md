# Purchasely iOS SDK Documentation

This document provides comprehensive documentation for integrating and using the Purchasely iOS SDK with Swift (version 6.0.0-rc.1).

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
13. [StoreKit Configuration](#storekit-configuration)
14. [Troubleshooting](#troubleshooting)
15. [Additional Resources](#additional-resources)

---

## Requirements

| Requirement | Version |
|-------------|---------|
| iOS | 13.4+ |
| Xcode | 14.0+ |
| Swift | 5.5+ |
| Purchasely SDK | 6.0.0-rc.1 |

> 📘 SwiftUI integration requires iOS 13.4 or later.

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
3. Select the version you want to use (6.0.0-rc.1 or later)
4. Click **Add Package**

---

## SDK Initialization

Initialize the Purchasely SDK in your `AppDelegate`. This should be the first method executed by your application.

> 🚧 Major change in v6 — default running mode is now `.observer`
>
> In SDK v5 the default running mode was **Full** (Purchasely handles and validates purchases).
> In **SDK v6 the default is `.observer`** (Purchasely only observes transactions, without processing them).
>
> This change is **silent** — your code keeps compiling. If you want Purchasely to handle the purchase flow and validate receipts, you **must** now set the mode explicitly with `.runningMode(.full)`.

SDK initialization in v6 uses a **fluent builder**: start with `Purchasely.apiKey(_:)`, chain modifiers, and finish with `start`.

### Full Mode (handles & validates purchases)

In `full` mode, Purchasely handles the entire purchase flow including transactions and receipts. You must opt in explicitly with `.runningMode(.full)`.

```swift
import Purchasely

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Purchasely
        .apiKey("YOUR_API_KEY")
        .appUserId(nil) // Optional: set if you already know your user id
        .runningMode(.full) // ⚠️ default is now .observer — set .full for Purchasely to handle purchases
        .storekitSettings(.storeKit2) // Set your StoreKit version
        .logLevel(.debug) // Set to .error for production
        .start { error in
            if error == nil {
                print("Purchasely SDK configured successfully")
            } else {
                print("Purchasely SDK configuration failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }
    return true
}
```

### Full Mode — Swift async/await (recommended)

```swift
import Purchasely

do {
    try await Purchasely
        .apiKey("YOUR_API_KEY")
        .appUserId(nil)
        .runningMode(.full) // ⚠️ required for purchase handling & validation
        .storekitSettings(.storeKit2)
        .logLevel(.debug)
        .start()
    print("Purchasely SDK configured successfully")
} catch {
    // PLYError.configuration if the apiKey is empty, or any other error
    print("Purchasely SDK configuration failed: \(error.localizedDescription)")
}
```

### Observer Mode (default)

Since v6, `.observer` is the **default** running mode. Use it if you have an existing in-app purchase infrastructure and want to use Purchasely only for paywall display and analytics. You can set it explicitly for clarity:

```swift
import Purchasely

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Purchasely
        .apiKey("YOUR_API_KEY")
        .runningMode(.observer)
        .start { error in
            print(error == nil)
        }
    return true
}
```

### Builder Modifiers and Defaults

| Modifier | Default |
|----------|---------|
| `appUserId(_:)` | `nil` (anonymous) |
| `runningMode(_:)` | `.observer` ⚠️ (was `.full` in v5) |
| `storekitSettings(_:)` | `.storeKit2` |
| `logLevel(_:)` | `.error` |
| `environment(_:)` | `.prod` |
| `themeMode(_:)` | `.system` |
| `allowDeeplink(_:)` | `true` — deeplinks display immediately; pass `false` to defer until `Purchasely.allowDeeplink(true)` |
| `allowCampaigns(_:)` | `true` — campaigns display immediately; pass `false` to defer until `Purchasely.allowCampaigns(true)` |
| `handleDeeplink(_:)` | unset — pass a cold‑start deeplink to display once the SDK has started |

### API Key

You can find your API Key in the Purchasely Console under **App settings > Backend & SDK configuration**.

### Initialization Callback

Since SDK v6, the callback returns a **single value**:

- `error`: `nil` when the SDK was initialized successfully and the configuration is correct. When it is non-nil, it indicates the specific error that occurred — you can still use the Purchasely SDK.

> **Important**: If you rely on subscription status or eligibility for offers, wait for the callback before proceeding.

---

## Displaying Paywalls

Purchasely paywalls are displayed using **placements**. A placement is a specific location in your app where you want to display a paywall (e.g., onboarding, settings, premium feature).

### Display a Placement (one line)

The simplest way to display a paywall is the `Purchasely.display(for:transition:)` convenience. It wraps `PLYPresentationBuilder.forPlacementId(...).build().display(transition:)` and presents the paywall automatically. Pass `transition: nil` to honor the backend-defined display mode, or pass a `PLYDisplayMode` to override it.

```swift
// Backend-defined display mode
Purchasely.display(for: "ONBOARDING", transition: nil)

// Override the transition
Purchasely.display(for: "ONBOARDING", transition: .modal)
```

You can also `await` the resulting presentation:

```swift
let presentation = try await Purchasely.display(for: "ONBOARDING", transition: .modal)
```

### Display via the Presentation Builder

For richer configuration — a content id, lifecycle callbacks, or to manage presentation yourself — build the request with `PLYPresentationBuilder`, then `preload` and display:

```swift
PLYPresentationBuilder
    .forPlacementId("ONBOARDING")
    .build()
    .preload { presentation, error in
        guard error == nil, let presentation = presentation else { return }

        // Calling display() to launch the flow.
        // The source UIViewController is optional.
        presentation.display(from: self)
    }
```

### Display with Lifecycle Callbacks

`PLYPresentationBuilder` exposes hooks for content id, color overrides and lifecycle events:

```swift
PLYPresentationBuilder
    .forPlacementId("ONBOARDING")
    .contentId("my_content_id") // Optional: associate content with the purchase
    .onPresented { presentation, error in
        // The paywall is on screen
        print("Presentation displayed")
    }
    .onDismissed { outcome in
        // The user closed the paywall; outcome carries the purchase result
        switch outcome.purchaseResult {
        case .purchased:
            print("User purchased: \(outcome.plan?.name ?? "unknown")")
            // Update entitlements to unlock content
        case .restored:
            print("User restored: \(outcome.plan?.name ?? "unknown")")
            // Update entitlements to unlock content
        case .cancelled:
            print("User cancelled")
        case .none:
            break
        @unknown default:
            break
        }
    }
    .build()
    .display(completion: nil)
```

> 📘 `.build()` returns a `PLYPresentationRequest`, which exposes
> `display(completion:)` and `display(transition:completion:)`. The
> `display(from:)` variant lives on the loaded `PLYPresentation` you receive in
> `preload`/`onPresented` — use it when you want to control the source
> `UIViewController`.

### The Dismissal Outcome — `PLYPresentationOutcome`

`onDismissed` delivers a `PLYPresentationOutcome` carrying:

| Field | Type | Meaning |
|-------|------|---------|
| `purchaseResult` | `PLYPurchaseResult` | `.purchased` / `.cancelled` / `.restored` / `.none` |
| `plan` | `PLYPlan?` | The purchased plan, when applicable |
| `presentation` | `PLYPresentation?` | The presentation that produced this outcome |
| `closeReason` | `PLYCloseReason` | Why the paywall closed |
| `error` | `Error?` | Reserved (always `nil` in 6.0) |

```swift
.onDismissed { outcome in
    switch outcome.closeReason {
    case .button:             /* user tapped close/back */ break
    case .interactiveDismiss: /* swiped down or popped */ break
    case .programmatic:       /* app called close */ break
    case .none:               /* purchased/restored, or not applicable */ break
    @unknown default:         break
    }
}
```

### Check if a Presentation is a Flow

```swift
PLYPresentationBuilder
    .forPlacementId("ONBOARDING")
    .build()
    .preload { presentation, error in
        guard let presentation = presentation, error == nil else { return }

        if presentation.isFlow {
            // The presentation is a flow
            presentation.display()
        } else {
            presentation.display(from: self)
        }
    }
```

### Close Screens

You can close all opened Purchasely screens programmatically at any time:

```swift
Purchasely.closeAllScreens()
```

You can also call `close()` on a preloaded presentation object:

```swift
PLYPresentationBuilder
    .forPlacementId("ONBOARDING")
    .build()
    .preload { presentation, error in
        // When displayed, call close
        presentation?.close()
    }
```

> 📘 On iOS, Purchasely automatically closes the presentation after a successful purchase or restore.

---

## Processing Transactions

### Full Mode

In `full` mode (`.runningMode(.full)`), Purchasely automatically handles the purchase flow when users tap a purchase button. Use the `onDismissed` outcome to update your entitlements:

```swift
PLYPresentationBuilder
    .forPlacementId("PREMIUM_FEATURE")
    .onDismissed { outcome in
        switch outcome.purchaseResult {
        case .purchased:
            print("User purchased: \(outcome.plan?.name ?? "unknown")")
            // Transaction completed - update entitlements
            unlockPremiumContent()
        case .restored:
            print("User restored: \(outcome.plan?.name ?? "unknown")")
            // Restore completed - update entitlements
            unlockPremiumContent()
        case .cancelled:
            print("User cancelled purchase")
        case .none:
            break
        @unknown default:
            break
        }
    }
    .build()
    .display(completion: nil)
```

### Observer Mode

In `.observer` mode, you handle transactions with your own infrastructure. Use the Action Interceptor to capture purchase intents (see below); when you return the success result the SDK calls `synchronize()` automatically so Purchasely can track revenue and analytics.

---

## Action Interceptor

The Action Interceptor allows you to intercept user actions on the paywall such as purchases, logins, restores, and custom links.

In v6 the global `setPaywallActionsInterceptor` is **replaced** by a granular, **per-action** API: register one interceptor per action with `Purchasely.interceptAction(.x)`. Each interceptor reports back through a `PLYInterceptResult`.

### Result Semantics

| `PLYInterceptResult` | Meaning | SDK behavior |
|----------------------|---------|--------------|
| `.success` | App handled the action successfully | Chain advances to the next action |
| `.failed` | App tried but failed | Remaining actions from this interaction are skipped |
| `.notHandled` | App doesn't want to handle this | SDK executes the action itself |

> 📘 `.notHandled` for `.purchase` / `.restore` in observer mode logs a warning and skips — the SDK cannot execute purchases in observer mode.

Remove interceptors with `Purchasely.removeActionInterceptor(.login)` or `Purchasely.removeAllActionInterceptors()`.

### Intercept Login & Purchase

This sample shows how to intercept a login or to make the user accept terms & conditions before proceeding to the purchase. This mechanism can also be used in `full` mode.

```swift
// Intercept the tap on login
Purchasely.interceptAction(.login) { [weak self] info, params, completion in
    // When the user has completed the process
    // Return .notHandled to reload the paywall if the user is logged in
    self?.presentLogin(above: info.controller) { (loggedIn) in
        Purchasely.userLogin(with: "MY_USER_ID")
        completion(loggedIn ? .notHandled : .success)
    }
}

// Intercept the tap on purchase to display the terms and conditions
Purchasely.interceptAction(.purchase) { [weak self] info, params, completion in
    self?.presentTermsAndConditions(above: info.controller) { (userAcceptedTerms) in
        completion(userAcceptedTerms ? .notHandled : .success)
    }
}
```

### The Interceptor Info — `PLYInterceptorInfo`

The interceptor receives a `PLYInterceptorInfo` (the v6 replacement for `PLYPresentationInfo`). Useful properties:

| Property | Description |
|----------|-------------|
| `info.presentation?.id` | The presentation id |
| `info.presentation?.placementId` | The placement id |
| `info.presentation?.audienceId` | The audience id |
| `info.presentation?.abTestId` / `…abTestVariantId` | A/B test identifiers |
| `info.presentation?.campaignId` | The campaign id |
| `info.contentId` | The content id |
| `info.controller` | The source `UIViewController` |

### Observer Mode with In-House Infrastructure

Intercept the purchase and restore actions to perform them with your own purchase system; when you return the success result the SDK calls `synchronize()` automatically so Purchasely receives the transaction:

```swift
Purchasely.interceptAction(.purchase) { info, params, completion in
    // Grab the plan to purchase
    guard let plan = params?.plan, let appleProductId = plan.appleProductId else {
        completion(.notHandled)
        return
    }

    let success = MyPurchaseSystem.purchase(appleProductId)
    if success {
        // SDK auto-synchronizes on success in observer mode
        completion(.success) // notify the Purchasely paywall the action was handled
    } else {
        completion(.failed)
    }
}

Purchasely.interceptAction(.restore) { info, params, completion in
    MyPurchaseSystem.restorePurchases()
    // SDK auto-synchronizes on success in observer mode
    completion(.success) // notify the Purchasely paywall the action was handled
}
```

### Observer Mode with RevenueCat

```swift
import RevenueCat

Purchasely.interceptAction(.purchase) { info, params, completion in
    // Grab the plan to purchase
    guard let plan = params?.plan, let appleProductId = plan.appleProductId else {
        completion(.notHandled)
        return
    }

    Purchases.shared.getOfferings { (offerings, error) in
        if let packages = offerings?.current?.availablePackages {
            if let package = packages.first(where: { $0.storeProduct.productIdentifier == appleProductId }) {
                Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
                    // SDK auto-synchronizes on success in observer mode
                    // notify the Purchasely paywall the action was handled
                    completion(.success)

                    if customerInfo.entitlements["your_entitlement_id"]?.isActive == true {
                        // Unlock that great "pro" content
                    }
                }
            }
        }
    }
}

Purchasely.interceptAction(.restore) { info, params, completion in
    Purchases.shared.restorePurchases { customerInfo, error in
        // SDK auto-synchronizes on success in observer mode
        // notify the Purchasely paywall the action was handled
        completion(.success)
    }
}
```

---

## User Identification

A subscription made with Apple must be linked to an identifier, as Apple only provides the purchase receipt and the transaction id. Purchasely links each subscription to a user id (provided by you) or an anonymous user id (created by Purchasely).

### Login User

When a user logs in, provide their user id to Purchasely:

```swift
Purchasely.userLogin(with: "123456789")
```

### Automatic Subscription Transfer

When calling `userLogin`, a callback informs you whether a transfer occurred and whether you should refresh entitlements:

```swift
Purchasely.userLogin(with: "123456789") { (shouldRefreshCredentials) in
    if shouldRefreshCredentials {
        // User has subscriptions from a previous device/install
        // Call your backend to refresh user entitlements
        refreshEntitlements()
    }
}
```

### Logout User

When a user logs out, all built-in and custom user attributes are cleared by default:

```swift
Purchasely.userLogout()

// To prevent Purchasely from removing all custom user attributes
Purchasely.userLogout(false)
```

### Anonymous User ID

The SDK automatically generates an anonymous user id, consistent as long as the app remains installed. Retrieve it with:

```swift
let anonymousId = Purchasely.anonymousUserId
```

### Set User ID at Initialization

You can also set the user id during SDK initialization:

```swift
Purchasely
    .apiKey("YOUR_API_KEY")
    .appUserId("YOUR_USER_ID") // Set user ID here
    .runningMode(.full)
    .storekitSettings(.storeKit2)
    .logLevel(.debug)
    .start { error in
        // Handle initialization
    }
```

### Manual Transfer & Restore

To transfer a subscription based on your own logic, call `Purchasely.synchronize(success:failure:)` (no Apple pop-up). To let the user restore their purchases from a button, call `Purchasely.restoreAllProducts(success:failure:)` (may trigger an Apple pop-up; call only from a user action).

```swift
// Synchronize purchases with Purchasely
Purchasely.synchronize(success: {
    // synchronized
}, failure: { error in
    // handle error
})

// Restore purchases from a user action (button)
Purchasely.restoreAllProducts(success: {
    // at least one item restored
}, failure: { error in
    // nothing restored
})
```

---

## Subscription Status & Entitlements

### Get User Subscriptions

Retrieve the list of active subscriptions for the current user. The method uses
separate `success` and `failure` closures:

```swift
Purchasely.userSubscriptions(success: { subscriptions in
    guard let subscriptions = subscriptions else { return }

    for subscription in subscriptions {
        print("Subscription: \(subscription.plan.name ?? "unknown")")
        print("Product: \(subscription.product.name ?? "unknown")")
        print("Next renewal: \(subscription.nextRenewalDate ?? Date())")
    }
}, failure: { error in
    print("Error fetching subscriptions: \(error?.localizedDescription ?? "unknown")")
})
```

### The `PLYSubscription` Object

```swift
public class PLYSubscription: NSObject {

    public var product: PLYProduct
    public var plan: PLYPlan
    public var subscriptionSource: PLYSubscriptionSource
    public var nextRenewalDate: Date?
    public var cancelledDate: Date?
    public var originalPurchasedDate: Date?
    public var purchasedDate: Date?
    public var offerType: PLYSubscriptionOfferType
    public var status: PLYSubscriptionStatus
    public var environment: PLYSubscriptionEnvironment
    public var storeCountry: String?
    public var isFamilyShared: Bool
    public var contentId: String?
    public var offerIdentifier: String?

}
```

### Check Entitlements

Inspect the user's active subscriptions to decide whether to unlock premium
content. For example, check whether the user owns a subscription for a given
plan or product:

```swift
Purchasely.userSubscriptions(success: { subscriptions in
    guard let subscriptions = subscriptions else { return }

    let hasProAccess = subscriptions.contains { subscription in
        subscription.plan.vendorId == "pro_plan"
    }

    if hasProAccess {
        unlockProFeatures()
    }
}, failure: { _ in })
```

> 📘 The iOS SDK does not expose a per-plan `hasEntitlement(...)` helper.
> Derive access from the returned `[PLYSubscription]` (e.g. by inspecting
> `plan.vendorId`, `product.vendorId`, or `status`), or manage entitlements on
> your backend with the `ACTIVATE` / `DEACTIVATE` webhook events.

---

## Custom User Attributes

Custom User Attributes allow you to segment users and target specific audiences with different paywalls. Each value's type must match the type configured for that attribute in the Purchasely Console.

### Set a Single Attribute

```swift
Purchasely.setUserAttribute(withIntValue: 20, forKey: "age")
Purchasely.setUserAttribute(withDoubleValue: 175.5, forKey: "size")
Purchasely.setUserAttribute(withBoolValue: true, forKey: "subscribed")
Purchasely.setUserAttribute(withDateValue: Date(), forKey: "date")
Purchasely.setUserAttribute(withStringValue: "Female", forKey: "gender")
```

### Set Multiple Attributes

```swift
Purchasely.setUserAttributes(
    [
        "age": 20,
        "size": 175.5,
        "subscribed": true,
        "date": Date(),
        "gender": "Female"
    ]
)
```

### Get Attribute Value

```swift
// Returns an Int since it was set with that type
if let age = Purchasely.getUserAttribute(for: "age") as? Int {
    print("User age: \(age)")
}
```

### Get All Attributes

```swift
Purchasely.userAttributes.forEach { attribute in
    print("Attribute \(attribute.key) = \(attribute.value)")
}
```

### Clear Attribute

```swift
Purchasely.clearUserAttribute(forKey: "email")
```

### Clear All Attributes

```swift
Purchasely.clearUserAttributes()
```

### Increment Attribute

Useful for tracking counters:

```swift
// Increment by 1 (value defaults to 1)
Purchasely.incrementUserAttribute(withKey: "viewed_articles")

// Increment by a custom value
Purchasely.incrementUserAttribute(withKey: "points", value: 10)
```

### Decrement Attribute

```swift
// Decrement by 1 (value defaults to 1)
Purchasely.decrementUserAttribute(withKey: "remaining_credits")

// Decrement by a custom value
Purchasely.decrementUserAttribute(withKey: "lives", value: 3)
```

---

## Event Listeners

### UI / SDK Events Listener

Track user interactions with Purchasely screens. Set the delegate after starting the SDK:

```swift
Purchasely.setEventDelegate(self)

// Implement PLYEventDelegate
extension YourClass: PLYEventDelegate {
    func eventTriggered(_ event: PLYEvent, properties: [String: Any]?) {
        switch event {
        case .linkOpened:
            print("Link opened")
        default:
            print("Event: \(event)")
        }

        // Forward to your analytics platform
        yourAnalytics.track("\(event)", properties: properties)
    }
}
```

These events are sent to the Purchasely Platform to compute conversion KPIs. They cannot be routed server-to-server from the Console, so implement this delegate if you want to forward them to your own analytics.

### Custom User Attributes Listener

Listen for custom user attribute changes (e.g. set from surveys). Implement `PLYUserAttributeDelegate`:

```swift
class UserAttributeHandler: PLYUserAttributeDelegate {
    func onUserAttributeSet(key: String, type: PLYUserAttributeType, value: Any?, source: PLYUserAttributeSource) {
        if source == .purchasely {
            // Attribute set by Purchasely (e.g. from a survey)
            print("Survey attribute: \(key) = \(String(describing: value))")
            // Send to your backend or analytics
            yourBackend.updateUserAttribute(key: key, value: value)
        }
        // Ignore if the source is .client (set by your app)
    }

    func onUserAttributeRemoved(key: String, source: PLYUserAttributeSource) {
        if source == .purchasely {
            print("Attribute removed: \(key)")
        }
    }
}

Purchasely.setUserAttributeDelegate(UserAttributeHandler())
```

#### Understanding `PLYUserAttributeSource`

The `source` parameter indicates where the update originated:

```swift
@objc public enum PLYUserAttributeSource: Int {
    case purchasely, client
}
```

- **purchasely**: The change was initiated internally by the Purchasely SDK (e.g. a survey).
- **client**: The change was triggered directly by your app.

> 🚧 In most cases you can ignore the delegate callback when `source` is `.client`, since your app already has that data.

---

## Pre-fetching Screens

By default, Purchasely shows the Screen with a loading indicator while fetching it from the network. Using `PLYPresentationBuilder` with its `preload` method, you can pre-fetch the Screen beforehand to:

- Display the Screen only after it has been loaded from the network
- Handle network errors gracefully
- Show a custom loading screen
- Pre-load the Screen while users navigate through your app
- Choose not to display a Screen for a specific placement
- Display your own Screen

A presentation can be one of the following types:

- **Normal**: The default, a Purchasely Screen created from your Console.
- **Fallback**: A Purchasely Screen, but not the one you requested (it could not be found).
- **Deactivated**: No Screen associated with that placement (possibly for a specific A/B test or audience).
- **Client**: You created a Custom Screen in the Console and should display it yourself. Use the list of plans to determine which offers to display.

### Build & Preload

```swift
PLYPresentationBuilder
    .forPlacementId("onboarding")
    .build()
    .preload { presentation, error in
        // Closure to get the presentation and display it
        guard let presentation = presentation, error == nil else {
            print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
            return
        }

        if presentation.type == .normal || presentation.type == .fallback {
            // Display directly
            presentation.display(from: self)

            // Alternatively: get the UIViewController to manage the transition yourself.
            // Note: this method won't work with Flows.
            let purchaselyController = presentation.controller

        } else if presentation.type == .deactivated {
            // Nothing to display

        } else if presentation.type == .client {
            let presentationId = presentation.id
            let plans = presentation.plans // [PLYPresentationPlan] — inspect planVendorId / storeProductId
            // Display your own Screen
        }
    }
```

### Map Legacy Callbacks to Builder Hooks

| Purpose | Builder hook |
|---------|--------------|
| The presentation was fetched | `.preload { presentation, error in … }` |
| The paywall is on screen | `.onPresented { presentation, error in … }` |
| The product view controller was dismissed | `.onDismissed { outcome in … }` |

### Pre-fetch then Display Later

```swift
// Store the presentation
var cachedPresentation: PLYPresentation?

// Fetch it
PLYPresentationBuilder
    .forPlacementId("premium_feature")
    .build()
    .preload { presentation, error in
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

### Nesting the Paywall in Your Own Views

A preloaded presentation exposes its `controller` (UIKit) so you can embed the underlying `UIView` in your own layout:

```swift
import Purchasely

PLYPresentationBuilder
    .forPlacementId("onboarding")
    .build()
    .preload { presentation, error in
        guard let presentation = presentation, error == nil else {
            print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
            return
        }

        // `presentation.controller` is an optional PLYPresentationViewController?
        guard let purchaselyController = presentation.controller else { return }

        // Option 1 - Display the controller directly
        self.present(purchaselyController, animated: true, completion: nil)

        // Option 2 - Display the Purchasely UIView inside your own
        let targetView = UIView()
        let purchaselyView = purchaselyController.view!
        targetView.addSubview(purchaselyView)
        purchaselyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            purchaselyView.topAnchor.constraint(equalTo: targetView.topAnchor),
            purchaselyView.bottomAnchor.constraint(equalTo: targetView.bottomAnchor),
            purchaselyView.leadingAnchor.constraint(equalTo: targetView.leadingAnchor),
            purchaselyView.trailingAnchor.constraint(equalTo: targetView.trailingAnchor)
        ])
    }
```

### SwiftUI Integration

For SwiftUI apps, read the `swiftUIView` property off the preloaded presentation (named `swiftUIView` to disambiguate from `UIKit.UIView`). It returns `nil` for `.deactivated` presentations.

```swift
PLYPresentationBuilder
    .forScreenId(paywallIdentifier)
    .contentId(contentId)
    .build()
    .preload { presentation, error in
        self.paywallView = presentation?.swiftUIView // SwiftUI View
    }
```

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Text("This is a SwiftUI View")
                .padding()

            presentation.swiftUIView
                .frame(height: 400)
        }
    }
}
```

---

## Deeplinks Management

Purchasely can handle deeplinks to display specific presentations or trigger actions. Pass the deeplink to the SDK, optionally control when it is displayed, and set a default presentation dismiss handler. You can also hand a cold‑start deeplink to the SDK at initialization with `Purchasely.apiKey("YOUR_API_KEY").handleDeeplink(url).start { error in }`.

### 1. Pass the Deeplink to Purchasely SDK

#### Without SceneDelegate

```swift
// AppDelegate.swift
import Purchasely

func application(_ application: UIApplication,
                 open url: URL,
                 sourceApplication: String?,
                 annotation: Any) -> Bool {
    // You can chain calls to multiple handlers using a OR
    return Purchasely.handleDeeplink(url)
}
```

#### With SceneDelegate

```swift
// SceneDelegate.swift
import Purchasely

func scene(_ scene: UIScene,
           willConnectTo session: UISceneSession,
           options connectionOptions: UIScene.ConnectionOptions) {
    // …

    if let url = connectionOptions.urlContexts.first?.url {
        _ = Purchasely.handleDeeplink(url)
    }
}

func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let url = URLContexts.first?.url {
        _ = Purchasely.handleDeeplink(url)
    }
}
```

### 2. Forbidding the Display

By **default**, Purchasely deeplinks are displayed **immediately** when they are received. If your app has a launch routine that must complete first (splash screen, onboarding, login…), you can **temporarily prevent** the display, then re-enable it once you are ready:

```swift
// Prevent the display (e.g. while your onboarding is on screen)
Purchasely.allowDeeplink(false)

// Re-enable it once ready — any queued deeplink displays immediately
Purchasely.allowDeeplink(true)
```

Campaigns follow the same principle through their own flag, `allowCampaigns` (also `true` by default): call `Purchasely.allowCampaigns(false)` to defer and `Purchasely.allowCampaigns(true)` to re-enable. The two flags are independent.

### 3. Set the Default Presentation Dismiss Handler

Usually a closure is called back when you instantiate a paywall yourself. With a deeplink you don't instantiate it, so set a default handler to receive the result:

```swift
Purchasely.setDefaultPresentationDismissHandler { outcome in
    switch outcome.purchaseResult {
    case .purchased:
        print("Purchased from deeplink: \(outcome.plan?.name ?? "unknown")")
    case .restored:
        print("Restored from deeplink")
    case .cancelled:
        print("Cancelled from deeplink (\(outcome.closeReason))")
    case .none:
        break
    @unknown default:
        break
    }
    // outcome.presentation identifies which presentation (campaign / deeplink / Promoted IAP) closed
}
```

> 📘 In `.observer` mode, when your action interceptor returns the success result for a purchase or restore the SDK calls `Purchasely.synchronize(success:failure:)` automatically.

### Supported Deeplink Formats

Purchasely SDK supports the format `app_scheme://ply/...` where `app_scheme` is the URL scheme you declared to open deeplinks:

- Open a screen directly: `app_scheme://ply/presentations/PRESENTATION_ID`
- Open your default screen: `app_scheme://ply/presentations`
- Open a placement: `app_scheme://ply/placements/PLACEMENT_ID`
- Open store billing settings: `app_scheme://ply/update_billing`

Configure your deeplinks in the Purchasely Console under **Deeplinks** settings.

---

## StoreKit Configuration

### Choosing a StoreKit Version

Purchasely supports both StoreKit 1 and StoreKit 2. Choose the version during SDK initialization with `.storekitSettings(...)`.

> 📘 If you choose StoreKit 2 but the device runs an iOS version below 15, the Purchasely SDK will automatically fall back to StoreKit 1. If you are unsure which to use, opt for StoreKit 1.

#### StoreKit 2 (Recommended)

```swift
Purchasely
    .apiKey("YOUR_API_KEY")
    .runningMode(.full)
    .storekitSettings(.storeKit2) // Use StoreKit 2
    .logLevel(.debug)
    .start { error in
        // Handle initialization
    }
```

#### StoreKit 1

```swift
Purchasely
    .apiKey("YOUR_API_KEY")
    .runningMode(.full)
    .storekitSettings(.storeKit1) // Use StoreKit 1
    .logLevel(.debug)
    .start { error in
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
Purchasely
    .apiKey("YOUR_API_KEY")
    .runningMode(.full)
    .storekitSettings(.storeKit2)
    .logLevel(.debug) // Enable verbose logging
    .start { error in
        // Handle initialization
    }
```

### Common Issues

1. **Purchases not validated / subscriptions not processed**: In v6 the default running mode is `.observer`. Add `.runningMode(.full)` if you want Purchasely to handle and validate purchases.
2. **SDK not configured**: Ensure the `Purchasely.apiKey(...)…start` chain is called in `didFinishLaunchingWithOptions` before any other SDK method.
3. **Paywall not displaying**: Check that the placement id matches your Console configuration.
4. **Deeplink paywall not appearing**: Make sure you passed the deeplink with `Purchasely.handleDeeplink(_:)` and that you did not set `Purchasely.allowDeeplink(false)` (deeplinks display immediately by default).
5. **Purchase not completing**: Verify your App Store Connect setup and that products are active.
6. **User subscriptions empty**: Wait for the `start` callback before fetching subscriptions.
7. **StoreKit errors**: Ensure you've selected the correct StoreKit version for your app.

### Debug Initialization Errors

```swift
Purchasely
    .apiKey("YOUR_API_KEY")
    .runningMode(.full)
    .storekitSettings(.storeKit2)
    .logLevel(.debug)
    .start { error in
        if let error = error {
            print("SDK Error: \(error.localizedDescription)")
        }
    }
```

---

## Additional Resources

- [Purchasely Console](https://console.purchasely.io)
- [Full Documentation](https://docs.purchasely.com)
- [Migration Guide: v5 to v6 (iOS)](https://docs.purchasely.com/docs/migrating-from-v5-to-v6-ios)
- [GitHub Repository](https://github.com/Purchasely/Purchasely-iOS)

---

*This documentation is for Purchasely iOS SDK version 6.0.0-rc.1*
