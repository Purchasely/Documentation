---
title: Eligibility to introductory offer
excerpt: ''
deprecated: false
hidden: false
metadata:
  title: Eligibility to introductory offer
  description: >-
    Learn how to effectively implement introductory offers such as free trials
    and discounted subscriptions using Purchasely with Apple StoreKit and Google
    Play Billing. Discover setup guidelines, user eligibility criteria, and best
    practices to maximize subscriber acquisition and retention.
  keywords:
    - intro
    - offer
    - free
    - trial
    - free-trial
    - free trial
    - introductory
  robots: index
next:
  description: ''
---
Introductory offers, such as free trials and discounted rates, enable users to experience your subscription content at lower or no initial cost, enhancing user acquisition and retention.

## Types of Introductory Offers

* **Free Trial**: Users access subscription content for free during a limited time.
* **Pay As You Go**: Users pay a reduced price periodically during an initial promotional period.
* **Pay Up Front**: Users pay once at a discounted rate, covering multiple billing cycles upfront.

<br />

## Apple StoreKit

### Setting Up Introductory Offers

* Navigate to **App Store Connect → Features → In-App Purchases**.
* Create or select an existing **Auto-Renewable Subscription**.
* Under **Subscription Prices**, select **Create Introductory Offer**.
* Choose the offer type (**Free Trial**, **Pay As You Go**, **Pay Up Front**), duration, and applicable regions.

### User Eligibility

* Eligible if the user has never previously subscribed to any subscription within the same subscription group.
* Ineligible if the user is a current or past subscriber within the subscription group.

> 📘 Eligibility with StoreKit 1
>
> With StoreKit 1, user eligibility can only be determined by inspecting the user's purchase history through local receipts. However, this method is not entirely reliable because Apple may not update these receipts in real time, particularly during sandbox or TestFlight testing.
>
> **Recommendation**:\
> For accurate and reliable eligibility checks, we strongly recommend configuring the Purchasely SDK to use StoreKit 2, which leverages Apple's [dedicated method](https://developer.apple.com/documentation/storekit/product/subscriptioninfo/iseligibleforintrooffer) to determine user eligibility more effectively.

## Google Play Billing

### Setting Up Introductory Offers

* Navigate to **Google Play Console → Monetize → Products → Subscriptions**.
* Create or select a subscription, then add a **Base Plan**.
* Within the base plan, select **Add Offer** to create your introductory offer.
* Configure offer details (pricing phases, duration, eligibility criteria).

### User Eligibility

* **New Customer Acquisition**: Automatically determined by Google Play based on user history.
* **Developer Determined**: Custom eligibility criteria managed by your app logic.
* **Upgrade Offers**: Offers targeted at users upgrading their subscription.

<br />

## Displaying Introductory Offer in your app

* Check user eligibility dynamically from your Purchasely plan (see below)
* Eligibility to introductory offer is computed by Purchasely when the screen is visible to [display the offer](offer-mode) to the user

### Get the information from the SDK

You can retrieve the eligibility to the introductory offer for your user on a specific plan from Purchasely SDK

```swift Swift
Purchasely.plan(with: "planId") { plan in
    plan.isUserEligibleForIntroductoryOffer { eligible in
        if eligible {
            print("User is eligible for introductory offer.")
        } else {
            print("User is not eligible for introductory offer.")
        }
    }
} failure: { error in
    // Failure completion
}
```
```coffeescript Kotlin
// Using coroutines
viewModelScope.launch {
  try {
    val plan = Purchasely.plan("plan_id on purchasely console")
    // get eligibility to introductory offer (including free trial)
    val eligibleToIntroductoryOffer = plan?.isEligibleToOffer(null)
    // get eligibility to a specific offer id (as set in Google Play Console)
    val eligibleToSpecificOffer = plan?.isEligibleToOffer(storeOfferId = "offer_id_on_google_play_console")
  } catch (e: PLYError) {
    Log.e(TAG, "Error retrieving plan", e)
  }
}

// Using callback
Purchasely.plan("plan_id on purchasely console",
    onSuccess = { plan ->
        // get eligibility to introductory offer (including free trial)
        val eligibleToIntroductoryOffer = plan?.isEligibleToOffer(null)
        // get eligibility to a specific offer id (as set in Google Play Console)
        val eligibleToSpecificOffer = plan?.isEligibleToOffer(storeOfferId = "offer_id_on_google_play_console")
    },
    onError = { error ->
        Log.e(TAG, "Error retrieving plan", e)
    }
)
```
```typescript React Native
// Check whether the user is eligible for the intro offer to your plan id 'PLAN_ID_FROM_PURCHASELY_CONSOLE'
await Purchasely.isEligibleForIntroOffer('PLAN_ID_FROM_PURCHASELY_CONSOLE').then(
    (isEligible: boolean) => {
        console.log('Is eligible for intro offer ? ' + isEligible)
    }
)
```
```typescript Flutter
// Check whether the user is eligible for the intro offer to your plan id 'PLAN_ID_FROM_PURCHASELY_CONSOLE'
bool isEligible = await Purchasely.isEligibleForIntroOffer('PLAN_ID_FROM_PURCHASELY_CONSOLE');
print('is eligible ? : $isEligible');
```
