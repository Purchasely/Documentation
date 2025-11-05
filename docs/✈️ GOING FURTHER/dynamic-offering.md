---
title: Dynamic Offering
excerpt: >-
  This pages provides an details on Dynamic Offering (starting from SDK version
  v5.2.0)
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Dynamic Offering allows you to dynamically define which Offering a user should see—without duplicating Paywalls just to display different SKUs.

✅ Available starting from SDK version v5.2.0

# Why Use Dynamic Offering?

With Dynamic Offering, you can:

* Use a single Paywall to display multiple Offerings, depending on what is assigned to the user.
* Offer free trials and fallback promotions in one unified Paywall setup:
  * The Offering is linked to a Plan that includes a Free Trial (via Intro Offer) and a Promotional Offer that mirrors it.
  * The SDK will automatically evaluate and apply the appropriate offer:
    * ➕ If the user is eligible for the Intro Offer, it is applied.
    * ➖ If the user is not eligible, the Promotional Offer will be applied instead.

<br />

# Configuration in the Console

In the Screen Composer, you define a default Offering for a user. An Offering includes:

* `reference`: a unique identifier (letters, numbers, `_` or `-`)
* `Plan`: choose one from the Plans configured in the Purchasely Console
* (Optional) `Promotional Offer`: choose one from the Promotional Offers configured in the Purchasely Console

<Image align="center" className="border" border={true} src="https://files.readme.io/26e142aab9f16320d99009473233835b7eb3a169054414059e6f15bee564ae70-image.png" />

When your Offering has been configured, don't forget to click on the button `+ Add offering` to add it.

<br />

Each Offering reference can then be mapped to buttons, pickers, or calls to action within the Paywall:

![](https://files.readme.io/c0cc299b143cb61556926d89ddfba6d09a2bb78e340953112f3a259cc49a37f2-image.png)

<br />

> ⚠️ Legacy Paywalls Migration
>
> Paywalls created before May 7, 2025 used direct mapping between Promotional Offers and UI elements.
>
> Starting May 7, the mapping uses the Offering Reference instead. Purchasely has migrated legacy Paywalls accordingly.
>
> 🆘 Contact Purchasely Support if you experience any unexpected behavior with Promotional Offers after this change.

<br />

# SDK Integration

Offerings must be associated before displaying or pre-fetching a Paywall. Ideally, set them up at app startup, after initializing the SDK.

```swift Swift
/// **Setting a Dynamic Offering**
/// Use this when you want to override the default plans shown on a specific screen or context.
let reference = "dynamic_offering_reference"
let targetPlanVendorId = "yearly_premium_01"
let specificOfferId = "YEARLY_PROMO_XYZ" // Optional: can be nil

print("Setting dynamic offering for reference: \(reference)...")
Purchasely.setDynamicOffering(reference: reference,
               planVendorId: targetPlanVendorId,
               offerVendorId: specificOfferId) { success in
  // This completion handler is called after the SDK attempts to store the offering.
  // It runs asynchronously.
  if success {
    print("Successfully set dynamic offering for \(reference).")
    // You might update UI or state here if needed
  } else {
    print("Failed to set dynamic offering for \(reference).")
    // Handle failure if necessary
  }
}

/// **Getting Current Dynamic Offerings (Synchronous)**
/// Useful for debugging or immediate checks within your code logic to see
/// which dynamic offerings are currently active in memory.
print("Checking dynamic offerings synchronously...")
let currentOfferings = Purchasely.getDynamicOfferings() // Synchronous call

if currentOfferings.isEmpty {
  print("No dynamic offerings currently set.")
} else {
  print("Current dynamic offerings:")
  for offering in currentOfferings {
    // Assuming PLYOffering has relevant properties like reference, planId, offerId
    print("- Ref: \(offering.reference), Plan: \(offering.planId), Offer: \(offering.offerId ?? "N/A")")
  }
}

/// **Getting Current Dynamic Offerings (Asynchronous)**
/// Use this if retrieving the offerings might involve I/O or other async work,
/// or simply to follow an asynchronous pattern.
print("Checking dynamic offerings asynchronously...")
Purchasely.getDynamicOfferings { currentOfferings in
  // This completion handler might be called asynchronously.
  if currentOfferings.isEmpty {
    print("Async fetch: No dynamic offerings currently set.")
  } else {
    print("Async fetch: Current dynamic offerings:")
    for offering in currentOfferings {
      print("- Ref: \(offering.reference), Plan: \(offering.planId), Offer: \(offering.offerId ?? "N/A")")
    }
  }
}

/// **Removing a Specific Dynamic Offering**
/// Call this when the specific context requiring an override is no longer valid.
let reference = "sample_reference"
print("Removing dynamic offering for reference: \(reference)...")
Purchasely.removeDynamicOffering(reference: reference)
print("Dynamic offering for \(reference) removed (if it existed).")

/// **Clearing All Dynamic Offerings**
/// Useful on user logout, or when you want to ensure all paywalls revert
/// to their default server-configured offerings.
print("Clearing all dynamic offerings...")
Purchasely.clearDynamicOfferings()
print("All dynamic offerings cleared.")
```
```kotlin Kotlin
// ---------- Setting a Dynamic Offering ----------
val reference = "dynamic_offering_reference"
val planVendorId = "your_plan_vendor_id"      // Required: must be a valid plan vendor id
val offerVendorId = "your_offer_vendor_id"    // Optional: can be null


Purchasely.setDynamicOffering(
    reference = reference,
    planVendorId = planVendorId,
    offerVendorId = offerVendorId
) { success ->
    // This callback is invoked after the SDK attempts to store the offering
    if (success) {
        println("Successfully set dynamic offering for $reference.")
    } else {
        println("Failed to set dynamic offering for $reference.")
    }
}

// ---------- Getting Current Dynamic Offerings (Synchronous via Coroutine) ----------
// Using GlobalScope for demonstration purposes; 
// Consider using a proper coroutine scope in production code
GlobalScope.launch {
    val currentOfferings = Purchasely.getDynamicOfferings()
    if (currentOfferings.isEmpty()) {
        println("No dynamic offerings currently set.")
    } else {
        currentOfferings.forEach { offering ->
            println("- Ref: ${offering.reference}, Plan: ${offering.planId}, Offer: ${offering.offerId ?: "N/A"}")
        }
    }
}

// ---------- Getting Current Dynamic Offerings (Asynchronous) ----------
Purchasely.getDynamicOfferings { currentOfferings ->
    if (currentOfferings.isEmpty()) {
        println("No dynamic offerings currently set.")
    } else {
        currentOfferings.forEach { offering ->
            println("- Ref: ${offering.reference}, Plan: ${offering.planId}, Offer: ${offering.offerId ?: "N/A"}")
        }
    }
}

// ---------- Removing a Specific Dynamic Offering ----------
val removalReference = "dynamic_offering_reference"
Purchasely.removeDynamicOffering(removalReference)

// ---------- Clearing All Dynamic Offerings ----------
Purchasely.clearDynamicOfferings()
```

<br />

# Offering Replacement Logic

If the Paywall references match the Offerings associated with a user, the default Offering will be replaced dynamically.

All buttons, pickers, CTAs, and tags linked to that Offering will update accordingly — no extra UI logic needed.

<br />

# Testing

1. Create a Paywall with multiple default Offerings (e.g. `p1` and `p2`), each linked to a Plan (e.g. `Yearly 99.99€` and `Monthly 9.99€`)

   ![](https://files.readme.io/7e24685f8eacc4b2b5cdfe4adb04b0bfe1ee3a5993d4cd0fc54a9aef325ca032-image.png)

   <br />
2. Assign a Dynamic Offering to a user via SDK, using the same reference values but different Plans and optionally, Promotional Offers (e.g. `p1`:`Quarterly 34.99€` and `p2`:`Weekly 4.99€`)
3. Display the test paywall for that user: 

✅ You should see the Paywall reflect the user-specific Offering (`Quarterly 34.99€` and  `Weekly 4.99€`) instead of the default Offering (`Yearly 99.99€` and `Monthly 9.99€`)
