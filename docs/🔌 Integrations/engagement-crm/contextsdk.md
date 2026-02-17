---
title: ContextSDK
excerpt: >-
  Learn how to integrate ContextSDK with Purchasely to optimize paywall timing
  using real-time ML-driven context. This guide explains how to pass the
  `shouldUpsell` signal as a user attribute, configure audience rules, log
  outcomes, and maximize conversion and revenue performance.
deprecated: false
hidden: false
metadata:
  robots: index
---
# Using ContextSDK with Purchasely

ContextSDK integrates seamlessly with Purchasely to help you show paywalls at the perfect moment. This integration leverages ContextSDK's ML-powered recommendations to optimize when Purchasely displays paywalls, improving conversion rates.

## About ContextSDK

ContextSDK is a machine learning–powered decision engine that helps determine the best moment to present in-app experiences, such as paywalls. By analyzing real-time contextual signals, it predicts whether a user is in a favorable moment for an upsell and exposes this decision through the `shouldUpsell` property.

When integrated with Purchasely, ContextSDK enables smarter paywall timing by reducing interruptions during low-intent moments and maximizing conversions when user intent is high.

For setup instructions and full integration details, see the official ContextSDK setup guide:
[https://docs.contextsdk.com](https://docs.contextsdk.com)

## How it works

ContextSDK provides real-time context about whether it's a good moment to show a paywall through the **`shouldUpsell`** property - a boolean indicating whether it's a good moment to show a paywall.

This value is passed to Purchasely as a user attribute (`context_should_upsell`), allowing you to:

* Use it in paywall display rules and audience targeting
* Track context in your analytics
* A/B test different timing strategies
* Reduce interruptions during bad moments and maximize conversions

## Integration Guide

### Step 1: Capture Context and Show Paywall

Before showing a paywall, capture the user's context using `instantContext` and pass it to Purchasely as a user attribute:

```swift
import ContextSDK
import Purchasely

class OnboardingViewController: UIViewController {

    func showPaywall() {
        // 1. Capture the user's real-world context
        let context = ContextManager.instantContext(flowName: "purchasely_onboarding", duration: 3)

        // 2. Set the context as a Purchasely user attribute
        Purchasely.setUserAttribute(withBoolValue: context.shouldUpsell, forKey: "context_should_upsell")

        // 3. Load and show the Purchasely paywall
        let paywallController = Purchasely.presentationController(
            for: "onboarding",
            loaded: { [weak self] controller, success, error in
                if let controller = controller, success {
                    self?.present(controller, animated: true)
                } else if let error = error {
                    print("Failed to load paywall: \(error)")
                    context.log(.skipped)
                }
            },
            completion: { result, _ in
                // 4. Log the outcome to help train the ML model
                switch result {
                case .purchased:
                    context.log(.positive)
                case .cancelled:
                    context.log(.negative)
                case .restored:
                    context.log(.skipped)
                @unknown default:
                    context.log(.skipped)
                }
            }
        )
    }
}
```

### Step 2: Configure Purchasely Rules

You can use the context attribute in Purchasely's audience rules to control when paywalls appear:

**In Purchasely Console:**

1. Go to your placement configuration
2. Add audience rules using `context_should_upsell` (Boolean)
3. For example: Only show the paywall when `context_should_upsell` is `true`

This gives you the flexibility to A/B test different strategies and adjust timing logic without code changes.

### Understanding the Flow

Let's break down what's happening:

1. **`ContextManager.instantContext(flowName:duration:)`** - This captures the user's real-world context synchronously. The flow name (e.g., `"purchasely_onboarding"`) uniquely identifies this opportunity in your app. Use descriptive names like `"purchasely_settings"`, `"purchasely_post_action"`, etc.
2. **`Purchasely.setUserAttribute()`** - This passes the `shouldUpsell` value to Purchasely as a user attribute. During the initial calibration phase, this value is always `true`. Once your custom ML model is trained and deployed, it makes real-time decisions based on the user's context.
3. **`Purchasely.presentationController(for:)`** - This is your standard Purchasely integration. The placement ID (e.g., `"onboarding"`) should match what you've configured in your Purchasely dashboard.
4. **`context.log()`** - This logs the outcome, which is crucial for training the ML model:
   * `.positive` - User completed a purchase
   * `.negative` - User dismissed the paywall
   * `.skipped` - Paywall wasn't shown, or user restored purchases

## Logging Revenue Outcomes

For in-app purchases, you can optionally log revenue information to get more detailed analytics. Update your code to use `logRevenueOutcome`:

```swift
let context = ContextManager.instantContext(flowName: "purchasely_onboarding", duration: 3)

// Set the context as a Purchasely user attribute
Purchasely.setUserAttribute(withBoolValue: context.shouldUpsell, forKey: "context_should_upsell")

let paywallController = Purchasely.presentationController(
    for: "onboarding",
    loaded: { [weak self] controller, success, error in
        if let controller = controller, success {
            self?.present(controller, animated: true)
        } else if let error = error {
            print("Failed to load paywall: \(error)")
            context.log(.skipped)
        }
    },
    completion: { result, plan in
        switch result {
        case .purchased:
            // Log revenue with product details
            if let plan = plan {
                context.logRevenueOutcome(
                    revenue: plan.amount,
                    currency: "USD",
                    productId: plan.vendorId
                )
            } else {
                // Fallback if plan details aren't available
                context.log(.positive)
            }
        case .cancelled:
            context.log(.negative)
        case .restored:
            context.log(.skipped)
        @unknown default:
            context.log(.skipped)
        }
    }
)
```

<br />

<Callout icon="📘" theme="info">
  Revenue logging helps ContextSDK optimize not just for conversion rates, but for revenue maximization. Higher-value purchases can be weighted differently in the ML model training.
</Callout>

## Best Practices

### Choose a Flow Name

Select a descriptive flow name that represents your use case:

```swift
// Examples of good flow names:
ContextManager.instantContext(flowName: "purchasely_onboarding", duration: 3)
ContextManager.instantContext(flowName: "purchasely_premium_upgrade", duration: 3)
ContextManager.instantContext(flowName: "purchasely_feature_unlock", duration: 3)
ContextManager.instantContext(flowName: "purchasely_post_level", duration: 3)
```

Use a consistent naming pattern with `snake_case` and group related flows with the same prefix (e.g., all Purchasely flows start with `purchasely_`).

### Always Log Outcomes

**Critical:** Always log an outcome for every context you create. This data trains the ML model:

```swift
// Always log an outcome for every context
switch result {
case .purchased:
    context.log(.positive)
    // Or with revenue:
    // context.logRevenueOutcome(revenue: amount, currency: "USD", productId: id)
case .cancelled:
    context.log(.negative)
case .restored:
    // User restored purchases - this is not a conversion
    context.log(.skipped)
@unknown default:
    context.log(.skipped)
}
```

### Handle Multiple Placements

You can use this pattern across multiple placements in your app:

```swift
// During onboarding
func showOnboardingPaywall() {
    let context = ContextManager.instantContext(flowName: "purchasely_onboarding", duration: 3)
    presentPurchaselyPaywall(placement: "onboarding", context: context)
}

// After completing a key action
func showPostActionPaywall() {
    let context = ContextManager.instantContext(flowName: "purchasely_post_action", duration: 3)
    presentPurchaselyPaywall(placement: "post_action", context: context)
}

// In settings
func showSettingsPaywall() {
    let context = ContextManager.instantContext(flowName: "purchasely_settings", duration: 3)
    presentPurchaselyPaywall(placement: "settings", context: context)
}

private func presentPurchaselyPaywall(placement: String, context: Context) {
    // Set the context as a Purchasely user attribute
    Purchasely.setUserAttribute(withBoolValue: context.shouldUpsell, forKey: "context_should_upsell")

    let paywallController = Purchasely.presentationController(
        for: placement,
        loaded: { [weak self] controller, success, error in
            if let controller = controller, success {
                self?.present(controller, animated: true)
            } else {
                context.log(.skipped)
            }
        },
        completion: { result, _ in
            switch result {
            case .purchased:
                context.log(.positive)
            case .cancelled:
                context.log(.negative)
            case .restored:
                context.log(.skipped)
            @unknown default:
                context.log(.skipped)
            }
        }
    )
}
```

### Placement Naming Convention

Your ContextSDK flow names don't need to match your Purchasely placement IDs, but having a clear relationship helps maintain your code. For example:

* Flow name: `"purchasely_onboarding"` → Placement: `"onboarding"`
* Flow name: `"purchasely_settings"` → Placement: `"settings"`
* Flow name: `"purchasely_post_level"` → Placement: `"post_level"`

## Related Documentation

* [Revenue Outcomes](https://docs.contextsdk.com/context-decision/revenue-outcomes) - Learn more about logging revenue outcomes
* [Logging Conversions](https://docs.contextsdk.com/context-decision/logging-conversions) - General guide to logging outcomes
* [Custom Outcome Metadata](https://docs.contextsdk.com/context-decision/advanced/custom-outcome-metadata) - Track additional purchase context

<Callout icon="👍">
  ContextSDK's ML models learn from your outcome data. 

  The more purchases you log with `log(.positive)` or `logRevenueOutcome()`, the better the model becomes at predicting optimal moments to show paywalls.
</Callout>
