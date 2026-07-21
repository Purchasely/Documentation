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

# Summary

| Delivery method | SDK requirement |
|---|---|
| **Trigger-based** (e.g. `APP_STARTED`) | Displayed automatically (`allowCampaigns` is `true` by default). Set it to `false` to defer, back to `true` when ready. |
| **Placement-based** | No additional code — uses existing Placement calls. |
