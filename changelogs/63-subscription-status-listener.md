---
title: 6.3 - Subscription Status Listener
author: Kevin Herembourg
hidden: false
metadata:
  robots: noindex
published_at: '2026-11-19T15:30:00.000Z'
type: added
---
Purchasely SDK 6.3.0 is a minor release that tells your app the subscription status of the user: at start, and each time a subscription is purchased, restored, redeemed from the web or expires.

This version also measures the experiments of your campaigns, adds a `ply/restore` deeplink, a new privacy purpose and a Screen setting that ignores the device text size. There are no breaking API changes. Read the Behavior Changes section if your Android app starts the SDK in the background or uses R8.

## Highlights

- Subscription status listener, on every platform
- `ply/restore` deeplink
- Campaign experiments: `EXPERIMENT_ASSIGNED` and `EXPERIMENT_EXPOSED` events
- New privacy purpose: Support Investigation
- "Ignore device text size" Screen setting

***

## Version per platform

Detailed changelogs are available on each platform's GitHub repository:

| Platform         | SDK Version                                                            |
| :--------------- | :--------------------------------------------------------------------- |
| **iOS**          | [6.3.0](https://github.com/Purchasely/Purchasely-iOS/releases)         |
| **Android**      | [6.3.0](https://github.com/Purchasely/Purchasely-Android/releases)     |
| **Flutter**      | [6.3.0](https://github.com/Purchasely/Purchasely-Flutter/releases)     |
| **React Native** | [6.3.0](https://github.com/Purchasely/Purchasely-ReactNative/releases) |
| **Cordova**      | [6.3.0](https://github.com/Purchasely/Purchasely-Cordova/releases)     |

***

# 🚀 Features

## 🔔 Subscription Status Listener

Know at any time if the user has an active subscription:

<Tabs>
  <Tab title="iOS">
    ```swift
    Purchasely.addUserSubscriptionStatusDelegate(self)

    func userSubscriptionStatusUpdated(_ status: PLYUserSubscriptionStatus) {
        let isPremium = status.isActive
        // status.reason: .none (status call), .purchased, .restored, .expired, .webRedeemed
    }
    ```
  </Tab>

  <Tab title="Android">
    ```kotlin
    Purchasely.addUserSubscriptionStatusListener { status ->
        val isPremium = status.isActive
        // status.reason: null (status call), PURCHASED, RESTORED, EXPIRED, WEB_REDEEMED
    }
    ```
  </Tab>
</Tabs>

The listener gets two types of calls:

- **A status call** tells the current status. It has no reason. The SDK sends one at start, for the first list of subscriptions of a user, and when you add a listener.
- **A change call** tells that a subscription changed: `PURCHASED`, `RESTORED`, `EXPIRED` or `WEB_REDEEMED`.

`isActive` is `true` when the user has one or more active subscriptions. The SDK calls the listener on the main thread. On Android, `Purchasely.userSubscriptionStatusFlow()` gives the same calls as a Kotlin `Flow`.

At a login or a logout, when the last call said `isActive` `true`, the listener gets a status call with `isActive` `false`. The previous user then does not stay premium if the fetch of the new user fails.

The previous purchase APIs are deprecated: `ply_purchasedSubscription` on iOS, and `Purchasely.purchaseListener`, `PurchaseListener` and `Purchasely.livePurchase()` on Android. They continue to work.

New page: [Subscription status listener](doc:subscription-status-listener)

## 🔄 `ply/restore` Deeplink

The new deeplink `app_scheme://ply/restore` restores the purchases of the user, as the Restore button of a paywall does. It works in Full mode only. A subscription that the restore finds reaches the status listener with the reason `RESTORED`.

Reference: [Deeplinks](doc:deeplinks#restore-purchases)

## 🧪 Campaign Experiments

A campaign can run an experiment, and an arm of the experiment can have no Screen. The SDK reports what each user gets:

- `EXPERIMENT_ASSIGNED`: a campaign assigned the user to an arm.
- `EXPERIMENT_EXPOSED`: the user reached the arm. The SDK showed its Screen, or the arm has no Screen.

The two events carry `experiment_id` and `experiment_variant_id`, and reach your event listener. The SDK also sends the new built-in attributes `ply_experiments` and `ply_holdout`.

For an inline view, the SDK does not build a view for a presentation of type `DEACTIVATED`. Call `exposed()` once at the moment the user would have seen the Screen:

<Tabs>
  <Tab title="iOS">
    ```swift
    if presentation.type == .deactivated {
        presentation.exposed()
    }
    ```
  </Tab>

  <Tab title="Android">
    ```kotlin
    if (presentation.type == PLYPresentationType.DEACTIVATED) {
        presentation.exposed()
    }
    ```
  </Tab>
</Tabs>

Reference: [Campaign SDK implementation](doc:campaigns-implementation#campaign-experiments)

## 🔒 Support Investigation Privacy Purpose

The new purpose `supportInvestigation` (`SupportInvestigation` on Android) is Processing #5 of the Data Processing Agreement: technical support and incident investigation at the level of the user. `allNonEssentials` now includes it.

<Tabs>
  <Tab title="iOS">
    ```swift
    Purchasely.revokeDataProcessingConsent(for: [.supportInvestigation])
    ```
  </Tab>

  <Tab title="Android">
    ```kotlin
    Purchasely.revokeDataProcessingConsent(setOf(PLYDataProcessingPurpose.SupportInvestigation))
    ```
  </Tab>
</Tabs>

A refusal that an older SDK version stored does not change after the update. Call `revokeDataProcessingConsent` again to send it with the new purposes.

Reference: [Privacy settings](doc:privacy-settings#support-investigation)

## 🔠 Ignore Device Text Size

Turn on **Ignore device text size** in the layout settings of a Screen. The text of this Screen keeps the size that you set in the Screen Composer, also when the user selects a large text size in the device settings. This setting reduces accessibility: use it only on a Screen that you cannot adapt to large text.

Reference: [Adapting Screens to devices](doc:composer-adapting-screens-to-devices#ignore-device-text-size)

***

# ⚠️ Behavior Changes

- **Android: the SDK starts only when a screen of your app is open.** A start in the background (a push or a job) waits for the next screen. A user attribute or a dynamic offering that you set while the start waits is dropped: set it again after `start()` succeeds. `APP_STARTED` is sent only after a successful start, so the count of app sessions decreases.
- **Android: Google Play Billing Library 9.1.0.** Gradle resolves your app to this version. If your app calls the Billing Library, do not use the APIs that Billing 9 removes (`SkuDetails`, `SkuDetailsParams`, `BillingClient.SkuType`, `QueryPurchaseHistoryParams`).
- **Android: smaller R8 rules.** The SDK keeps only the code that it reaches by name. If your code reaches SDK classes by reflection, or uses Lottie directly, add your own keep rules.
- **iOS: inline presentations close through `onCloseRequested`.** An app that embeds an inline presentation must remove it from `onCloseRequested`. Without `onCloseRequested`, `onDismissed` fires at once, as in 6.2.0, but the SDK no longer navigates the host.
- **`allNonEssentials` now also revokes `identifiedAnalytics` and `supportInvestigation`** on iOS, the same set as Android.
- **Source compatibility:** `PLYEvent` has new cases on iOS and Android, and `PLYDeepLink` and `PLYDataProcessingPurpose` have new subclasses on Android. If your code uses an exhaustive `switch` or `when` on one of these types without a `default` or `else` branch, add the branch.

***

# 🍎 iOS

## ✨ Features & Improvements

- `Purchasely.addUserSubscriptionStatusDelegate(_:)` and `removeUserSubscriptionStatusDelegate(_:)`, with `PLYUserSubscriptionStatus`
- `purchasely://ply/restore` deeplink. `RESTORE_FAILED` is sent on every failed explicit restore.
- `EXPERIMENT_ASSIGNED` and `EXPERIMENT_EXPOSED` events, `ply_experiments` and `ply_holdout` built-in attributes, `PLYPresentation.exposed()`
- `display()` on a `DEACTIVATED` presentation returns to the app with no Screen and no error.
- `PLYDataProcessingPurpose.supportInvestigation`
- "Ignore device text size" Screen setting
- Large request bodies to the paywall and tracking hosts are compressed with gzip. A proxy or a network inspector in front of the app sees gzip bodies.
- A purchase made in a flow sends the step on screen at purchase time, as Android does.

## ⚠️ Action Required

- An app that embeds an inline presentation removes it from `onCloseRequested`, not from `onDismissed`.
- A `switch` over `PLYEvent` or `PLYEventProperty` without a `default` must handle the new cases.
- A type of your app that conforms to `PLYPresentation` must add `exposed()`.
- Replace the `ply_purchasedSubscription` notification with the subscription status delegate.

## 🐛 Fixes & Reliability

- A displayed paywall no longer crashes the app after a few iPad rotations or scene resizes.
- In a centered row of short labels, a label no longer disappears after a rotation.
- A Screen's events no longer carry the campaign or the placement of another Screen shown in the same session.
- After a Web2App redemption, the status delegate gets `.webRedeemed` and no longer gets `.expired` one second later.
- An SDK Screen opened while the previous one closes stays on screen.
- The close and back buttons of a Screen stay inside the safe area on every edge.
- `synchronize()` or a restore called before `start()` returns an error instead of a crash.
- Revoking `analytics` also revokes `identifiedAnalytics`, as on Android. Revoking a purpose other than `thirdPartyIntegrations` no longer clears the integration IDs.
- Intro offer eligibility follows the billing plan type of each plan (12-month commitment billed monthly).
- Less work on the main thread when a paywall draws.

***

# 🤖 Android

## ✨ Features & Improvements

- `Purchasely.addUserSubscriptionStatusListener(listener)`, `removeUserSubscriptionStatusListener(listener)` and `userSubscriptionStatusFlow()`
- `ply/restore` deeplink, in Full mode only
- `EXPERIMENT_ASSIGNED` and `EXPERIMENT_EXPOSED` events, `ply_experiments` and `ply_holdout` built-in attributes, `PLYPresentation.exposed()`
- `PLYDataProcessingPurpose.SupportInvestigation`. `PLYDataProcessingPurpose.AllNonEssentials` includes it.
- "Ignore device text size" Screen setting
- Google Play Billing Library 9.1.0
- The Open Placement action sends `PLACEMENT_OPENED`.
- Each event includes the integration IDs that you set with `Purchasely.setAttribute`, also the email attributes. The SDK removes them when the user refuses the third-party integrations purpose.

## ⚠️ Action Required

- Set again the user attributes and dynamic offerings that you set while a background start waits for a screen.
- If your app calls the Billing Library, remove the APIs that Billing 9 removes.
- If your code reaches SDK classes by reflection, or uses Lottie directly, add your own keep rules.
- Add an `else` branch to a `when` on `PLYEvent`, `PLYDeepLink` or `PLYDataProcessingPurpose`.
- `PLYTransition.backgroundColors?.color()` is removed. Read `backgroundColors?.light` or `backgroundColors?.dark`.
- Replace `Purchasely.purchaseListener`, `PurchaseListener` and `Purchasely.livePurchase()` with `Purchasely.addUserSubscriptionStatusListener()`. They will be removed in 7.0.

## 🐛 Fixes & Reliability

- The navigate action of a paywall opens `http` and `https` links in the web view, and other links with their app. It blocks `javascript`, `file`, `content`, `intent` and `data` links.
- After a Google Play error during a purchase, the SDK recovers a paid purchase that the backend does not know.
- `restoreAllProducts()` and `silentRestoreAllProducts()` call `onError` with `PLYError.BillingUnavailable` when Google Play Billing is not available.
- A Huawei or Amazon restore now ends and calls its callback.
- A flow keeps its current step after a rotation, a fold, a split screen or a window resize. A flow that Android restores after the process ended shows its steps again.
- A percent width in a horizontal stack has the same size as on iOS and in the Console.
- Prices show the trailing zero of the cents (`18,90 €`, not `18,9 €`).
- The status bar icons over a paywall follow the light or dark theme of the paywall.
- The SDK sends each event once, and an event keeps the user attributes of the moment it fired.
- A logout no longer loses the subscriptions of the anonymous user.
- A process kill during a save no longer erases the saved user data.

Full list of the fixes: [Purchasely-Android 6.3.0](https://github.com/Purchasely/Purchasely-Android/releases/tag/6.3.0)
