---
title: Campaign SDK implementation
excerpt: >-
  Learn how to authorize the Purchasely SDK to display campaigns in your
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

This page explains the SDK-side setup required to allow [Campaigns](campaigns) to display in your application.

**⚠️ The minimum SDK version required to use this feature is 5.1.0**

# Authorizing campaign display

Your app might have a launch routine that needs to complete before another screen can be shown — a splash screen, onboarding, login, ad interstitial, etc.

For that reason, the display of a trigger-based campaign is **deferred until you explicitly authorize it**. Once your app is ready, notify the Purchasely SDK with the following call:

```swift
Purchasely.readyToOpenDeeplink(true)
```
```kotlin Kotlin
Purchasely.readyToOpenDeeplink = true
```
```javascript React Native
Purchasely.readyToOpenDeeplink(true);
```
```java Flutter
Purchasely.readyToOpenDeeplink(true);
```
```swift Cordova
Purchasely.readyToOpenDeeplink(true);
```
```csharp Unity
_purchasely.SetIsReadyToOpenDeeplink(true);
```

> ❗️ Important notices
>
> * `readyToOpenDeeplink` must be called for a trigger-based campaign to be shown, as it works exactly like a [deep link](deeplinks-management) internally.
> * If you have implemented the [UI Handler](ui-handler-deeplinks) to manage the display of deep links yourself, you must keep the presentation object returned and **not** fetch it again — otherwise campaign context will be lost.

# Placement-based campaigns

Campaigns associated with [Placements](displaying-screens-placements) do **not** require any additional SDK implementation. They are displayed automatically when the Placement is called in your app, using the same code you already use to fetch and present a Placement.

In other words, if your app already calls Placements, Placement-based campaigns will work out of the box with no code change.

# Summary

| Delivery method | SDK requirement |
|---|---|
| **Trigger-based** (e.g. `APP_STARTED`) | Call `readyToOpenDeeplink(true)` when your app is ready. |
| **Placement-based** | No additional code — uses existing Placement calls. |
