---
title: 6.2 - Custom Events
author: Kevin Herembourg
hidden: false
metadata:
  robots: noindex
published_at: '2026-10-08T15:00:00.000Z'
type: added
---
Purchasely SDK 6.2.0 is a minor release that lets your app send its own business events to Purchasely, open a campaign when one fires, and measure them as conversion KPIs.

This version also links every purchase to the paywall that started it, and lets audiences see every active and expired subscription of the user. There are no breaking API changes. Read the Behavior Changes section if your server reads `appAccountToken`.

## Highlights

- Custom Events, sent from your app or from a Screen
- Campaigns triggered by a Custom Event
- Purchases attributed to the paywall that started them
- Audiences that see every active and expired subscription

***

## Version per platform

Detailed changelogs are available on each platform's GitHub repository:

| Platform         | SDK Version                                                        |
| :--------------- | :----------------------------------------------------------------- |
| **iOS**          | [6.2.0](https://github.com/Purchasely/Purchasely-iOS/releases)     |
| **Android**      | [6.2.0](https://github.com/Purchasely/Purchasely-Android/releases) |
| **Flutter**      | Coming soon                                                        |
| **React Native** | Coming soon                                                        |
| **Cordova**      | Coming soon                                                        |

***

# 🚀 Features

## 📣 Custom Events

Send your own business events to Purchasely:

<Tabs>
  <Tab title="iOS">
    ```swift
    Purchasely.emit(name: "recipe_viewed", properties: ["recipe_id": 42, "title": "Ratatouille"])
    Purchasely.emit(name: "checkout_started")
    ```
  </Tab>

  <Tab title="Android">
    ```kotlin
    Purchasely.emit("recipe_viewed", mapOf("recipe_id" to 42, "title" to "Ratatouille"))
    Purchasely.emit("checkout_started")
    ```
  </Tab>
</Tabs>

Declare each event in the Console, in **Targeting > Events**. The SDK sends only the declared event names. It compares names exactly, case and spaces included, so `"Recipe Viewed"` and `"recipe_viewed"` are two different events. The SDK ignores an event that is not declared.

Four rules are worth knowing:

- **Properties travel as given.** Dates are sent as ISO 8601 strings. The SDK drops a value that it cannot send, such as `NaN`, logs a warning, and sends the rest of the event.
- **Your user attributes come along.** Each event carries your user attributes and the built-in attributes as they were at the moment of the call.
- **Consent is respected.** When the user refuses the `analytics` purpose, the SDK sends no new Custom Events.
- **Separate from the SDK events.** Custom Events have their own queue and their own retries. They never reach your `PLYEventDelegate` or your event listener.

You can call `emit` before `start()`.

New page: [Custom Events](doc:custom-events)

## 🎯 Trigger a Campaign with a Custom Event

Link a campaign to one of your Custom Events in the Console. When the event fires, the SDK opens the campaign Screen or Flow. The rules of the `APP_STARTED` trigger apply: dates, capping, exposure, and the `campaigns` consent purpose. A Custom Event never opens the campaigns of a Purchasely event that has the same name.

Reference: [Campaign configuration](doc:campaign-configuration)

## 👆 Track Event Screen Action

The new **Track event** action of the Screen Composer sends one of your Custom Events from a Screen. The event carries the context of the Screen: presentation, placement, audience, A/B test and variant, campaign, and flow and step. Use it to measure a success KPI on a paywall.

Your app cannot intercept this action, and the action never blocks the actions next to it. A button that tracks an event and then purchases still closes the paywall after the purchase.

Reference: [Action types](doc:action-types#track-event)

## 🧾 Purchases Attributed to the Paywall That Started Them

Every purchase is now linked to the paywall, placement, campaign and A/B test that started it. On iOS, this holds when the same product is bought twice, for Ask to Buy, and when the purchase completes after the app relaunches. Conversion reporting is more accurate as a result.

**iOS, Observer mode.** `signPromotionalOffer` has a new variant that gives a purchase context token with the signature. The previous variants are deprecated, but continue to work.

```swift
Purchasely.signPromotionalOffer(storeProductId: productId,
                                storeOfferId: offerId,
                                purchaseContextToken: nil,
                                success: { signature, token in
    // StoreKit 2: pass `token` as .appAccountToken(token)
    // StoreKit 1: set applicationUsername = token.uuidString.lowercased()
}, failure: { error in })
```

Reference: [Implementing promotional offers](doc:promotional-offer-implementation)

## 👥 Audiences See Every Subscription

Audience targeting now sees the user's current active and expired subscriptions on every request. This includes subscriptions bought on the web (Stripe, web-to-app). The SDK sends them in the new built-in attributes `ply_active_subscriptions` and `ply_expired_subscriptions`.

On iOS, `ply_custom_events_tracked` counts the events sent for each name, and `ply_custom_events_last_tracked` holds the time of the last one.

***

# ⚠️ Behavior Changes

- **iOS: `appAccountToken` and `applicationUsername` now carry a purchase context token.** Before, the SDK put the anonymous user id there. It now puts a new random UUID for each purchase. If your server reads `appAccountToken` in App Store Server Notifications to identify the user, use your own user mapping or Purchasely webhooks instead.
- **Subscriptions whose plan is not in your app catalog are now returned**, for example a web subscription. Their plan and product can have an empty `vendorId`, so handle that case.
- **Android, source compatibility:** `PLYEvent` has a new subclass. If your code uses `when (event)` on `PLYEvent` without an `else` branch, add an `else` branch.
- **Android, source compatibility:** `StoreType.WEB_CHECKOUT_STRIPE` is now `StoreType.STRIPE`, and `PLYPurchaseResponse.expiredSubscriptions` is now nullable.

***

# 🍎 iOS

## ✨ Features & Improvements

- `Purchasely.emit(name:properties:)` to send Custom Events
- Campaigns triggered by a Custom Event
- `track_event` Screen action
- Purchases attributed to the paywall, placement, campaign and A/B test that started them
- `signPromotionalOffer(storeProductId:storeOfferId:purchaseContextToken:success:failure:)` for Observer mode. The previous variants are deprecated.
- `ply_active_subscriptions`, `ply_expired_subscriptions`, `ply_custom_events_tracked` and `ply_custom_events_last_tracked` built-in attributes
- New consent purpose `PLYDataProcessingPurpose.refundHandling`, to record that the user refused to share consumption data with Apple for refund requests. It is not part of `.allNonEssentials`.

## ⚠️ Action Required

- If your server reads `appAccountToken` to identify the user, use your own user mapping or Purchasely webhooks.
- `revokeDataProcessingConsent(for:)` replaces the whole list each time you call it. Pass every refused purpose in the same call.

## 🐛 Fixes & Reliability

- Taps inside a tappable container run only the inner action. Before the fix, a button or a plan picker inside a tappable block could also run the block's action. Dragging a scroll view no longer triggers an action.
- Stack backgrounds and borders display on iOS 27.
- Bold and italic text keeps its size when a custom font has no bold or italic face.
- Labels such as `1. Premier` or `- 50%` no longer show a `\` on screen. When a label has two links, each keeps its own URL.
- `synchronize()` no longer sends the same receipts again on every call. This mostly affected non-renewing subscriptions.
- `clearBuiltInAttributes()` also clears the cached subscriptions used for audience targeting.
- Concurrent starts no longer create a duplicate session, so some apps will see fewer `APP_STARTED` events.

***

# 🤖 Android

## ✨ Features & Improvements

- `Purchasely.emit(name, properties)` to send Custom Events. Supported property types: `Int`, `Long`, `Float`, `Double`, `Boolean`, `String`, `Date` and a list of `String`.
- Campaigns triggered by a Custom Event
- "Track event" Screen action
- `ply_active_subscriptions` and `ply_expired_subscriptions` built-in attributes
- `PLYPlan.dump()` returns a full text report of a plan and of its Google Play product. Attach it to a support request.
- The SDK starts faster when the user has a long subscription history.
- Media3 update to 1.11.1 in the `player` module.

## ⚠️ Action Required

- Add an `else` branch to a `when (event)` on `PLYEvent`.
- Replace `StoreType.WEB_CHECKOUT_STRIPE` with `StoreType.STRIPE`.
- Handle a `null` value of `PLYPurchaseResponse.expiredSubscriptions`.

## 🐛 Fixes & Reliability

- A paywall fetch without an API key now fails with `PLYError.Configuration` and sends no request.
- A Google Play network error during a purchase ends the purchase without an alert. Your `onError` callback receives the error.
- The callbacks of `purchase()`, `restoreAllProducts()` and `silentRestoreAllProducts()` answer only the call that started them.
- A paywall no longer freezes after two purchase attempts that end with the same result.
- A paywall purchase button no longer stays blocked after an error that shows no alert.
- A login transfers the subscriptions that the user bought or redeemed while anonymous, and tries a failed transfer again at the next login.
- An inline paywall (`buildView`) no longer sends a `Close` action when its host screen goes away.
- On Android TV, the paywall works with the remote control (D-pad).
- `Purchasely.closeAllScreens()` closes all stacked screens.
- A flow sheet or modal no longer crashes or closes when a late dismiss or navigation request arrives.
- The SDK no longer reports "In-app purchase failed" events when no purchase is in progress.
- A deeplink with an upper-case `PLY` host now opens.
- A property with a `NaN` or infinite number inside a list or a map no longer causes the loss of the full request.

Full list of the fixes: [Purchasely-Android 6.2.0](https://github.com/Purchasely/Purchasely-Android/releases/tag/6.2.0)
