---
title: 6.0 - 12 month commitment and personalized tags
author: Kevin Herembourg
hidden: false
metadata:
  description: >-
    Purchasely SDK 6.0.0 is a major release that modernizes SDK initialization,
    screen presentation, action handling, and purchase-flow control across all
    supported platforms.
published_at: '2026-07-20T15:00:00.000Z'
type: added
---
Purchasely SDK 6.0.0 is a major release that modernizes SDK initialization, screen presentation, action handling, and purchase-flow control across all supported platforms.

This version introduces the new presentation builder APIs, per-action interceptors, support for Apple's monthly subscriptions with 12-month commitment, Google Play Billing v8, personalized tags, and improved screen customization.

<Callout icon="🚧" theme="warn">
  ### SDK 6.0 is a major release with breaking changes.

  Before upgrading, read the full <Anchor target="_blank" href="https://docs.purchasely.com/docs/migrating-from-sdk-5-to-6">SDK 5 to 6 migration guide</Anchor>.<br />The detailed new APIs are documented in the platform-specific migration guides.
</Callout>

## Highlights

- Apple monthly subscriptions with 12-month commitment
- Google Play Billing v8 support
- Personalized tags for dynamic paywall content
- Custom back button support
- Campaigns and deeplinks enabled by default

***

## Version per platform

Detailed changelogs are available on each platform's GitHub repository:

| Platform         | SDK Version                                                            |
| :--------------- | :--------------------------------------------------------------------- |
| **iOS**          | [6.0.0](https://github.com/Purchasely/Purchasely-iOS/releases)         |
| **Android**      | [6.0.1](https://github.com/Purchasely/Purchasely-Android/releases)     |
| **Flutter**      | [6.0.0](https://github.com/Purchasely/Purchasely-Flutter/releases)     |
| **React Native** | [6.0.0](https://github.com/Purchasely/Purchasely-ReactNative/releases) |
| **Cordova**      | [6.0.0](https://github.com/Purchasely/Purchasely-Cordova/releases)     |

***

# 🚀 Features

## 🍎 Apple 12-Month Commitment Support

SDK 6 adds support for Apple monthly subscriptions with a 12-month commitment.

This includes support for billing-plan-scoped offers, allowing apps to use Apple's new commitment-based subscription capabilities in eligible configurations.

This feature is available with our iOS, Flutter, React Native and Cordova SDKs.

<Callout icon="far fa-circle-info" theme="warn">
  ### Plan Usage Restrictions

  On a screen, the same plan can only be used once. This means you cannot have a yearly upfront commitment (default) and a 12-month commitment offer using the same plan (Apple Store product ID). You need to use 2 different plans.
</Callout>

## 🤖 Google Play Billing v8

SDK 6 supports Google Play Billing v8 (8.3.0).

This keeps Android integrations aligned with Google Play requirements and prepares apps for the latest billing behavior and dependency expectations.

Apps using Purchasely in Observer mode should update their integration and validate purchases in sandbox before releasing.

## 🏷 Personalized Tags

SDK 6 introduces support for personalized tags in dynamic paywall content.

Personalized tags can be used to adapt screen copy and paywall content based on user context, attributes, or SDK-provided values.

This makes it easier to build dynamic, personalized paywalls without hardcoding copy variants in the app.

## 🧱 New SDK Initialization Builder

SDK startup now uses a fluent builder API.

This makes initialization easier to read, safer to configure, and more consistent across platforms.

<Tabs>
  <Tab title="iOS">

    ```swift
    try await Purchasely
        .apiKey("YOUR_API_KEY")
        .appUserId("user_123")
        .runningMode(.full)     // required if Purchasely handles purchases
        .allowDeeplink(true)    // default: true
        .allowCampaigns(true)   // default: true
        .start()
    ```

  </Tab>
  <Tab title="Android">

    ```kotlin
    Purchasely {
        context(applicationContext)
        apiKey("YOUR_API_KEY")
        userId("user_123")
        stores(listOf(GoogleStore()))
        runningMode(PLYRunningMode.Full) // required if Purchasely handles purchases
        allowDeeplink(true)              // default: true
        allowCampaigns(true)             // default: true
        onInitialized { error -> }
    }
    ```

  </Tab>
  <Tab title="Flutter">

    ```dart
    final configured = await Purchasely.apiKey('YOUR_API_KEY')
        .appUserId('user_123')
        .runningMode(PLYRunningMode.full)
        .allowDeeplink(true)
        .allowCampaigns(true)
        .start();
    ```

  </Tab>
  <Tab title="React Native">

    ```typescript
    const configured = await Purchasely.builder('YOUR_API_KEY')
      .appUserId('user_123')
      .runningMode('full')
      .allowDeeplink(true)
      .allowCampaigns(true)
      .start()
    ```

  </Tab>
  <Tab title="Cordova">

    ```javascript
    Purchasely.start(
      {
        apiKey: 'YOUR_API_KEY',
        appUserId: 'user_123',
        runningMode: Purchasely.RunningMode.full,
        allowDeeplink: true,
        allowCampaigns: true,
      },
      (isConfigured) => {},
      (error) => console.error(error)
    );
    ```

  </Tab>
</Tabs>

<Callout icon="⚠️" theme="warn">
  ### The default running mode changed from Full to Observer.

  If Purchasely handles and validates purchases in your app, you must explicitly set Full mode.
</Callout>

## 📺 New Presentation Builder APIs

SDK 6 introduces a unified builder / preload / display lifecycle for screens and paywalls.

The new APIs replace legacy fetch and display methods with a single presentation model:

- build a presentation request
- preload it when needed
- display it later without an extra network call
- receive a structured dismissal outcome

<Tabs>
  <Tab title="iOS">

    ```swift
    let presentation = try await PLYPresentationBuilder
        .forPlacementId("ONBOARDING")
        .build()
        .preload()

    presentation.display(from: self)
    ```

  </Tab>
  <Tab title="Android">

    ```kotlin
    lifecycleScope.launch {
        val loaded = PLYPresentation {
            placementId("ONBOARDING")
            contentId("premium")
            onDismissed { outcome -> }
        }.preload()

        loaded.display(this@MainActivity)
    }
    ```

  </Tab>
  <Tab title="Flutter">

    ```dart
    final presentation = await PLYPresentationBuilder
        .placement('ONBOARDING')
        .contentId('premium')
        .build()
        .preload();

    final outcome = await presentation.display(const PLYTransition.fullScreen());
    ```

  </Tab>
  <Tab title="React Native">

    ```typescript
    const request = Purchasely.presentation
      .placement('ONBOARDING')
      .contentId('premium')
      .build()

    const loaded = await request.preload()
    const outcome = await loaded.display()
    ```

  </Tab>
  <Tab title="Cordova">

    ```javascript
    const loaded = await Purchasely.presentation
      .placement('ONBOARDING')
      .contentId('premium')
      .build()
      .preload();

    const outcome = await loaded.display();
    ```

  </Tab>
</Tabs>

## 🧩 Per-Action Interceptors

The previous global paywall action interceptor has been replaced by per-action interceptors.

This makes action handling more explicit and easier to reason about.

<Tabs>
  <Tab title="iOS">

    ```swift
    Purchasely.interceptAction(.purchase) { info, params in
        guard let plan = params?.plan else { return .notHandled }

        do {
            try await customPurchase(plan)
            return .success
        } catch {
            return .failed
        }
    }
    ```

  </Tab>
  <Tab title="Android">

    ```kotlin
    Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
        runCustomBilling(purchase.plan)
        PLYInterceptResult.SUCCESS
    }
    ```

  </Tab>
  <Tab title="Flutter">

    ```dart
    await Purchasely.interceptAction(
      PLYPresentationActionKind.purchase,
      (info, payload) async {
        if (payload is! PLYPurchasePayload) return PLYInterceptResult.notHandled;
        await runCustomBilling(payload.plan);
        return PLYInterceptResult.success;
      },
    );
    ```

  </Tab>
  <Tab title="React Native">

    ```typescript
    Purchasely.interceptAction('purchase', async (info, payload) => {
      if (payload?.kind !== 'purchase') return 'notHandled'
      await runCustomBilling(payload.plan)
      return 'success'
    })
    ```

  </Tab>
  <Tab title="Cordova">

    ```javascript
    Purchasely.interceptAction(
      Purchasely.PresentationAction.purchase,
      async (info, parameters) => {
        await runCustomBilling(parameters.plan);
        return Purchasely.InterceptResult.success;
      }
    );
    ```

  </Tab>
</Tabs>

Interceptor results are now explicit:

- success: the app handled the action
- failed: the app tried to handle it and failed
- notHandled: the SDK should continue with its default behavior

This replaces the previous boolean processAction(true / false) model.

## 🔙 Custom Back Button Support

SDK 6 improves header button customization with support for custom back button behavior and display controls.

This enables better navigation control in multi-screen experiences, flows, and custom paywall journeys.

## 🔗 Deeplinks & Campaigns Enabled by Default

Deeplinks and campaigns are now available by default.

`allowDeeplink` and `allowCampaigns` both default to true, which means campaign and deeplink paywalls can display as soon as the SDK is configured.

Apps that need to delay display during splash screens, onboarding, login, or consent flows can explicitly disable them during initialization and re-enable them later.

***

# 🍎 iOS

## ✨ Features & Improvements

- Fluent initialization with Purchasely.apiKey(...).start()
- New PLYPresentationBuilder
- First-class SwiftUI access with presentation.swiftUIView
- Rich PLYPresentationOutcome
- Public display sizing dimensions
- Apple monthly subscriptions with 12-month commitment
- Personalized tags for dynamic paywall content
- Campaign display control with allowCampaigns
- Header button customization, including back button handling
- New Swift Package Manager distribution channel (CocoaPods still supported)
- Improved image and GIF caching
- Improved renderer reliability

## ⚠️ Breaking Changes

- Default running mode is now Observer
- Purchasely.start(withAPIKey:) removed, replaced by the initialization builder
- setPaywallActionsInterceptor() removed, replaced by interceptAction()
- fetchPresentation() APIs removed, replaced by PLYPresentationBuilder
- PLYPresentation is now a protocol (Objective-C: id<PLYPresentation>)
- PLYDisplayMode renamed to PLYTransition
- PLYPresentation.id renamed to screenId
- onClose renamed to onCloseRequested
- setDefaultPresentationResultHandler renamed to setDefaultPresentationDismissHandler, now delivers a PLYPresentationOutcome
- readyToOpenDeeplink() and isDeeplinkHandled() removed, replaced by allowDeeplink() and handleDeeplink()
- ply/products and ply/plans deeplinks removed, use ply/presentations or ply/placements
- allowCampaigns default changed from false to true
- UIViewController-returning presentation APIs removed
- Legacy SwiftUI view APIs removed, replaced by presentation.swiftUIView

## 🐛 Fixes & Reliability

- Improved action execution reliability
- Safer async action handling
- Fixes for flow navigation and dismissal edge cases
- Improved SDK window handling
- Better StoreKit test-session stability
- Improved eligibility filtering and presentation-context decoding

***

# 🤖 Android

## ✨ Features & Improvements

- Kotlin DSL initialization entrypoint
- New PLYPresentation builder / preload / display lifecycle
- PLYPresentationSession display handle
- Per-action typed interceptors
- Storeless integration support
- Automatic deeplink interception
- Independent campaign gating with allowCampaigns
- Google Play Billing v8 support
- synchronize() completion callbacks
- Structured drawer and popin dimensions
- Improved logging controls

## ⚠️ Breaking Changes

- Default running mode is now Observer
- PLYRunningMode.PaywallObserver renamed to PLYRunningMode.Observer
- Initialization callback simplified: start { isConfigured, error -> } is now start { error -> }
- setPaywallActionsInterceptor() removed
- PLYPresentationAction is now a sealed class
- Presentation types moved to io.purchasely.ext.presentation.\*
- PLYPresentation.id renamed to screenId
- onClose renamed to onCloseRequested
- readyToOpenDeeplink renamed to allowDeeplink, isDeeplinkHandled renamed to handleDeeplink
- setDefaultPresentationResultHandler renamed to setDefaultPresentationDismissHandler
- Subscription management UI removed
- Purchase history APIs replaced by subscription history APIs
- Introductory-price helpers renamed to offer helpers

## 📦 Build Requirements

- Minimum SDK: 23
- Compile SDK: 36
- Minimum Kotlin: 2.2.x
- Java target: 11

***

# 🌉 Cross-Platform SDKs

Flutter, React Native, and Cordova have been updated to expose the SDK 6 presentation, initialization, deeplink, campaign, and action-interceptor changes through their respective bridges.

Each bridge follows the same migration principles:

- explicit running mode
- builder-style initialization where supported
- presentation preload / display lifecycle
- per-action interception
- renamed deeplink APIs
- rich presentation dismissal outcomes

<br />