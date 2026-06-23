---
title: Migrating from SDK 5 to 6
excerpt: Everything you need to know to upgrade your Purchasely SDK integration from v5.x to v6.0
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Pick your platform to get the detailed migration steps
  pages:
    - type: basic
      slug: migrating-from-v5-to-v6-ios
      title: Migrating to v6 — iOS
    - type: basic
      slug: migrating-from-v5-to-v6-android
      title: Migrating to v6 — Android
    - type: basic
      slug: migrating-from-v5-to-v6-flutter
      title: Migrating to v6 — Flutter
    - type: basic
      slug: migrating-from-v5-to-v6-react-native
      title: Migrating to v6 — React Native
    - type: basic
      slug: migrating-from-v5-to-v6-cordova
      title: Migrating to v6 — Cordova
---
Version 6.0 is a **major release** of the Purchasely SDK. It modernizes the public API around a single, consistent presentation model, replaces the global action interceptor with a granular per‑action API, and clarifies a number of method names.

This page gives you the overview. Detailed, copy‑paste migration steps are available per platform at the bottom of this page.

***

## ⚠️ The one change everyone must check: default running mode is now `Observer`

This is the single most impactful change of v6, and it is **silent** — your code keeps compiling.

In v5, the SDK defaulted to **Full** mode (Purchasely handles and validates purchases). In v6, the default is now **Observer** mode (Purchasely observes transactions but does not process them).

> 🚧 If your app relies on Purchasely to process purchases and validate receipts, you **must** now set the running mode explicitly.
>
> ```swift
> // iOS
> Purchasely.apiKey("API_KEY").runningMode(.full).start { error in }
> ```
>
> ```kotlin
> // Android
> Purchasely.Builder(context).apiKey("API_KEY").runningMode(PLYRunningMode.Full) /* … */ .build().start { error -> }
> ```
>
> If you forget, the SDK will compile and run, but it will stop validating transactions. See [SDK initialization](sdk-initialization) for full details.

***

## What changed across all native platforms

| Area | v5 | v6 |
|------|----|----|
| Default running mode | Full | **Observer** ⚠️ |
| Initialization | Positional `start(...)` | Fluent builder (`apiKey(...)…start()`) / Kotlin DSL |
| Action interceptor | One global `setPaywallActionsInterceptor` | One interceptor per action via `interceptAction(...)` returning `PLYInterceptResult` |
| Interceptor result | Ambiguous boolean (`processAction(Bool)`) | Explicit `.success` / `.failed` / `.notHandled` |
| Deeplink readiness | `readyToOpenDeeplink` | `allowDeeplink` |
| Deeplink handling | `isDeeplinkHandled(...)` | `handleDeeplink(...)` |
| Campaign display | Gated by the deeplink flag | Dedicated `allowCampaigns` flag |
| Dismissal result | A result enum (+ optional plan) | A single `PLYPresentationOutcome` (purchase result, plan, close reason, error) |

***

## Platform support

| Platform | v6 migration guide |
|----------|--------------------|
| iOS / Swift / Objective‑C | ✅ Available |
| Android / Kotlin / Java | ✅ Available |
| Flutter | 🚧 Coming soon |
| React Native | ✅ Available |
| Cordova | 🚧 Coming soon |

The native iOS and Android SDKs are migrated first, followed by React Native. The remaining cross‑platform wrappers (Flutter, Cordova) bridge to the native SDKs and will receive their own v6 migration guides in upcoming releases.

***

## Before you start

* Read the **default running mode** warning above — it applies to every platform.
* v6 keeps a number of v5 methods as **deprecated** (they still compile but are scheduled for removal in v7). Migrating off them now avoids a second pass later.
* Test your paywalls on a real device / staging build before releasing to production. The native rendering and display pipeline were refactored in v6.

Pick your platform below to get started. 👇
