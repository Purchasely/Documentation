---
title: Migrating from SDK 5 to 6
excerpt: >-
  Everything you need to know to upgrade your Purchasely SDK integration from
  v5.x to v6.0
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

<Callout icon="🚧" theme="warn">
  ### If your app relies on Purchasely to process purchases and validate receipts, you **must** now set the running mode explicitly.

  ```swift
  // iOS
  Purchasely.apiKey("API_KEY").runningMode(.full).start { error in }
  ```

  ```kotlin
  // Android
  Purchasely.Builder(context).apiKey("API_KEY").runningMode(PLYRunningMode.Full) /* … */ .build().start { error -> }
  ```

  If you forget, the SDK will compile and run, but it will stop validating transactions. See [SDK initialization](sdk-initialization) for full details.
</Callout>

***

## What changed across all native platforms

v6 concentrates the migration around three surfaces. Start with these first, then use the platform guide for the smaller renames and edge cases.

<Callout icon="📣" theme="default">
  ### Campaigns and deeplinks are available by default

  In v6, deeplinks and campaigns are no longer blocked until you explicitly unlock them. `allowDeeplink` and `allowCampaigns` both default to `true`, so campaign and deeplink paywalls can display as soon as the SDK is configured. If your app needs to wait for onboarding, login, splash loading or a consent step, set them to `false` during start and flip them back to `true` when the app is ready.
</Callout>

### 1. Start now uses a builder

The old positional `start(...)` calls are replaced by a fluent builder (or the Android Kotlin DSL). This makes defaults visible and keeps platform-specific options in one chain.

The important default is still the running mode: **v6 starts in Observer mode unless you explicitly set Full**.

<Tabs>
  <Tab title="iOS">
    ```swift
    try await Purchasely
        .apiKey("YOUR_API_KEY")
        .appUserId("user_123")
        .runningMode(.full)     // required if Purchasely handles purchases
        .allowDeeplink(false)    // default: true
        .allowCampaigns(false)   // default: true
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
    const isConfigured = await Purchasely.builder('YOUR_API_KEY')
      .appUserId('user_123')
      .runningMode(Purchasely.RunningMode.full)
      .allowDeeplink(true)
      .allowCampaigns(true)
      .start();
    ```
  </Tab>
</Tabs>

### 2. Presentation display uses a build → preload → display lifecycle

`fetchPresentation(...)`, `presentPresentationForPlacement(...)`, direct product/plan presentation helpers and platform-specific display overloads move to a single presentation request model.

Use the builder to target a placement, screen or default presentation, then choose whether to `preload()` before showing or call `display()` directly. Dismissal now returns a single rich outcome (`PLYPresentationOutcome` or the platform equivalent) with the presentation, purchase result, plan, close reason and error.

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
    const request = Purchasely.presentation
      .placement('ONBOARDING')
      .contentId('premium')
      .build();

    const loaded = await request.preload();
    const outcome = await loaded.display();
    ```
  </Tab>
</Tabs>

### 3. Action interception is per action

The global paywall action interceptor is gone. Register one handler per action and return an explicit result:

| Result                                       | Meaning                                                                |
| -------------------------------------------- | ---------------------------------------------------------------------- |
| `success` / `.success` / `SUCCESS`           | Your app handled the action successfully                               |
| `failed` / `.failed` / `FAILED`              | Your app tried to handle it and failed; the SDK stops the action chain |
| `notHandled` / `.notHandled` / `NOT_HANDLED` | Your app declines the action; the SDK runs its default behavior        |

This replaces the ambiguous `processAction(true/false)` pattern and makes observer-mode purchase flows easier to reason about.

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
        final purchase = payload as PLYPurchasePayload;
        await runCustomBilling(purchase.plan);
        return PLYInterceptResult.success;
      },
    );
    ```
  </Tab>

  <Tab title="React Native">
    ```typescript
    Purchasely.interceptAction('purchase', async (info, payload) => {
      await runCustomBilling(payload?.plan)
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

***

## Platform support

| Platform                  | v6 version | Status   | Migration guide                                                        |
| ------------------------- | ---------- | -------- | ---------------------------------------------------------------------- |
| iOS / Swift / Objective‑C | `6.1.0`    | ✅ Stable | [Migrating to v6 — iOS](migrating-from-v5-to-v6-ios)                   |
| Android / Kotlin / Java   | `6.1.0`    | ✅ Stable | [Migrating to v6 — Android](migrating-from-v5-to-v6-android)           |
| Flutter                   | `6.0.0`    | ✅ Stable | [Migrating to v6 — Flutter](migrating-from-v5-to-v6-flutter)           |
| React Native              | `6.0.0`    | ✅ Stable | [Migrating to v6 — React Native](migrating-from-v5-to-v6-react-native) |
| Cordova                   | `6.0.0`    | ✅ Stable | [Migrating to v6 — Cordova](migrating-from-v5-to-v6-cordova)           |

***

## Let the AI plugin help with the migration

The [Purchasely AI Plugin](https://github.com/Purchasely/Purchasely-AI-Plugin) ships a dedicated migration skill, `purchasely-migrate`. It can scan an existing Purchasely integration, identify v5 calls, rewrite the migration hotspots to the v6 builder APIs, and flag anything that still needs a product or billing decision.

Use it for the repetitive parts first: SDK start, presentation display / preload, action interception, deeplink renames and default running mode checks. Then run the platform guide manually for the final review.

<Tabs>
  <Tab title="Claude">
    ```text
      /plugin marketplace add Purchasely/Purchasely-AI-Plugin
      /plugin install purchasely@Purchasely-AI-Plugin
      /purchasely:migrate
    ```
  </Tab>

  <Tab title="Codex">
    ```shell
      codex plugin marketplace add Purchasely/Purchasely-AI-Plugin
    ```

    Then open `/plugins`, search for `purchasely`, install the plugin, and ask Codex to use the `purchasely-migrate` skill on your app.
  </Tab>

  <Tab title="Other">
    ```shell
      npx skills add Purchasely/Purchasely-AI-Plugin
    ```

    This installs the portable skills only. Ask your AI assistant to run `purchasely-migrate` on the files that initialize Purchasely, display paywalls or intercept paywall actions.
  </Tab>
</Tabs>

***

## Before you start

- Read the **default running mode** warning above — it applies to every platform.
- v6 keeps a number of v5 methods as **deprecated** (they still compile but are scheduled for removal in v7). Migrating off them now avoids a second pass later.
- Test your paywalls on a real device / staging build before releasing to production. The native rendering and display pipeline were refactored in v6.

Pick your platform below to get started. 👇
