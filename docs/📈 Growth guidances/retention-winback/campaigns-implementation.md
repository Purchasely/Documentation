---
title: Campaign SDK implementation
excerpt: >-
  Learn how to control when the Purchasely SDK displays campaigns in your
  application.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---

This page explains how to control when [Campaigns](campaigns) display in your application. By default, no SDK code is required — campaigns display automatically.

**⚠️ The minimum SDK version required to use this feature is 5.1.0**

# Controlling campaign display

By **default**, campaigns are displayed **immediately** — `allowCampaigns` is `true`, so a trigger-based campaign shows on its own with no extra code.

If your app has a launch routine that must complete before a screen can be shown (splash screen, onboarding, login, ad interstitial…), you can **temporarily prevent** campaigns from displaying, then re-enable them once you are ready. Any campaign triggered meanwhile is then displayed:

```swift Swift
// Prevent campaigns from displaying (e.g. during onboarding)
Purchasely.allowCampaigns(false)

// Re-enable once ready — any queued campaign displays immediately
Purchasely.allowCampaigns(true)
```
```kotlin Kotlin
// Prevent campaigns from displaying (e.g. during onboarding)
Purchasely.allowCampaigns = false

// Re-enable once ready — any queued campaign displays immediately
Purchasely.allowCampaigns = true
```
```javascript React Native
Purchasely.allowCampaigns(false);
// later, once your app is ready
Purchasely.allowCampaigns(true);
```
```java Flutter
Purchasely.allowCampaigns(false);
// later, once your app is ready
Purchasely.allowCampaigns(true);
```
```swift Cordova
Purchasely.allowCampaigns(false);
// later, once your app is ready
Purchasely.allowCampaigns(true);
```

> 📘 Important notices
>
> * `allowCampaigns` controls campaigns **independently** from deeplinks (`allowDeeplink`) — gating one does not affect the other.
> * If you have implemented the [UI Handler](ui-handler-deeplinks) to manage the display yourself, you must keep the presentation object returned and **not** fetch it again — otherwise campaign context will be lost.

# Placement-based campaigns

Campaigns associated with [Placements](displaying-screens-placements) do **not** require any additional SDK implementation. They are displayed automatically when the Placement is called in your app, using the same code you already use to fetch and present a Placement.

In other words, if your app already calls Placements, Placement-based campaigns will work out of the box with no code change.

# Campaign experiments

> 📘 Availability
>
> SDK 6.3.0 and later, on iOS, Android, React Native, Flutter and Cordova.

A campaign can run an experiment: Purchasely assigns each user to one arm of the experiment. An arm can have no Screen. The SDK then gets a presentation of type `DEACTIVATED` and shows nothing.

## SDK events

The SDK sends two events to your [event listener](ui-sdk-events-list):

| Event | When the SDK sends it |
| :-- | :-- |
| `EXPERIMENT_ASSIGNED` | A campaign answer assigns the user to a new experiment. One event for each new experiment. |
| `EXPERIMENT_EXPOSED` | The user reaches the arm: the SDK shows its Screen, or `display()` gets a `DEACTIVATED` presentation. |

The two events carry `experiment_id` and `experiment_variant_id`, with the `placement_id` or the triggering event of the campaign.

## Inline view of a deactivated presentation

When the SDK shows the Screen, or when you call `display()`, the SDK sends `EXPERIMENT_EXPOSED` itself. Do not call `exposed()` in these cases: the SDK then counts the view two times.

When you fetch a placement for an inline view and the presentation is `DEACTIVATED`, the SDK does not build a view. Call `exposed()` once, at the moment the user would have seen the Screen:

```swift Swift
let presentation = try await PLYPresentationBuilder
    .forPlacementId("<PLACEMENT_ID>")
    .build()
    .preload()

if presentation.type == .deactivated {
    // No Screen to show: tell Purchasely that the user reached the arm
    presentation.exposed()
} else {
    // Show the inline view of the presentation
}
```
```kotlin Kotlin
val presentation = PLYPresentation { placementId("<PLACEMENT_ID>") }.preload()

if (presentation.type == PLYPresentationType.DEACTIVATED) {
    // No Screen to show: tell Purchasely that the user reached the arm
    presentation.exposed()
} else {
    // Show the inline view of the presentation
}
```

On React Native, Flutter and Cordova, call `exposed()` on the presentation that `preload()` gives.

# Summary

| Delivery method | SDK requirement |
|---|---|
| **Trigger-based** (e.g. `APP_STARTED`) | Displayed automatically (`allowCampaigns` is `true` by default). Set it to `false` to defer, back to `true` when ready. |
| **Placement-based** | No additional code — uses existing Placement calls. |