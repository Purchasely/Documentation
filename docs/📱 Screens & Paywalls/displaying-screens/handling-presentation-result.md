---
title: Handling the paywall result (presentation outcome)
excerpt: >-
  How to retrieve the result of a paywall when it closes — purchase, restore,
  cancellation or simple dismissal — across iOS, Android, Flutter and React
  Native, and how the SDK routes that outcome between a per-presentation handler
  and the global default handler.
deprecated: false
hidden: false
metadata:
  title: ''
  description: >-
    Understand the three channels that deliver a presentation outcome
    (PLYPresentationOutcome) when a Purchasely paywall closes, and the routing
    rule that decides which one receives it.
  robots: index
next:
  description: ''
---
> 🚧 Minimum SDK versions
>
> The unified `PLYPresentationOutcome` model and the routing rule described here are part of the **6.0** display API.
>
> * iOS: 6.0.0
> * Android: 6.0.1
> * Flutter: 6.0.0
> * React Native: 6.0.0-rc.2
>
> On v5 the equivalent result type was `PLYProductViewControllerResult` (iOS) / `PresentPresentationResult` (Flutter / React Native), and the global handler was named `setDefaultPresentationResultHandler`. See the [v5 → v6 migration guides](migrating-from-sdk-5-to-6).

# Overview

When a Purchasely paywall (a **presentation**) closes, your app needs to know **what happened**: did the user purchase, restore, or simply dismiss the screen? That information is delivered as a single object — a **`PLYPresentationOutcome`** — that you can inspect to update your UI, unlock content, or fire your own analytics.

There are **three channels** through which an outcome can reach your code:

1. **The return value of the display call** — you `await` the display and read the outcome inline, where you showed the paywall.
2. **A per-presentation dismiss handler** (`onDismissed`) — a callback attached to **this specific** presentation.
3. **The global default dismiss handler** (`setDefaultPresentationDismissHandler`) — a single, app-wide handler that acts as a safety net and also receives the outcome for presentations the **SDK** opens on its own (deeplinks, campaigns, promoted in-app purchases).

> 📘 The routing rule (read this first)
>
> When a presentation closes, the SDK delivers the outcome to the **per-presentation `onDismissed` handler if one is set**, **otherwise** to the **global default handler**. It is the **presence of a local `onDismissed` handler** that decides the routing — **not** whether you awaited the display call.
>
> The return value of `display()` is **independent** of that rule: on the platforms that return an outcome (Flutter, Android), awaiting the call always resolves with the outcome **in addition** to whichever handler the rule selected.

# The `PLYPresentationOutcome`

The outcome is the same conceptual object on every platform. It carries five fields:

| Field | iOS type | Android type | Flutter type | React Native type | Meaning |
|-------|----------|--------------|--------------|-------------------|---------|
| `purchaseResult` | `PLYPurchaseResult` | `PLYPurchaseResult?` | `PLYPurchaseResult?` | `PLYPurchaseResult?` | The purchase action result: `purchased` / `restored` / `cancelled`. On iOS a `.none` sentinel means "no purchase action"; on Android/Flutter/React Native the same is expressed as `null`. On React Native it is a string union (`'purchased' \| 'restored' \| 'cancelled' \| null`). |
| `plan` | `PLYPlan?` | `PLYPlan?` | `PLYPlan?` | `PurchaselyPlan?` | The plan involved in the purchase, when applicable. |
| `presentation` | `PLYPresentation?` | `PLYPresentation?` | `PLYPresentation?` | `PLYPresentation?` | The presentation that produced this outcome (`null` if it never reached display). |
| `closeReason` | `PLYCloseReason` | `PLYCloseReason?` | `PLYCloseReason?` | `PLYCloseReason?` | Why the paywall closed when no purchase happened. On React Native a string union (`'button' \| 'backSystem' \| 'programmatic' \| null`). |
| `error` | `Error?` | `PLYError?` | `PLYPresentationError?` | `PLYPresentationError?` | Display error. Mutually exclusive with `closeReason`. Reserved on iOS (always `nil` in 6.0). |

### `PLYPurchaseResult`

`purchased`, `restored`, `cancelled`. (iOS also exposes a `none` case as the Objective-C–readable sentinel for "no purchase action took place".)

### `PLYCloseReason`

| Value | Wire string | Meaning |
|-------|-------------|---------|
| `button` | `"button"` | The user tapped a close / back button rendered by the paywall. |
| `backSystem` / `BACK_SYSTEM` | `"back_system"` | A system dismissal: Android system back, or — on iOS — an interactive swipe-down or navigation-stack pop. |
| `programmatic` / `PROGRAMMATIC` | `"programmatic"` | The app closed the paywall itself (`closeAllScreens()` / `presentation.close()`). |

> 📘 iOS naming detail
>
> The native iOS enum case is `interactiveDismiss` for a swipe-down / nav-pop, but it **stringifies to `"back_system"`** so the same dismissal correlates with Android across SDKs. iOS also has a `none` sentinel (no Android counterpart) for "no close happened / not applicable", e.g. on a purchased outcome.

# The three channels

## 1. The return value of the display call

On **Flutter**, **Android** and **React Native**, the display call resolves with the outcome at dismiss time, so you can read it inline.

```dart Flutter
final outcome = await PLYPresentationBuilder.placement('<PLACEMENT_ID>')
    .build()
    .display(const PLYTransition.fullScreen());

if (outcome.purchaseResult == PLYPurchaseResult.purchased) {
  // unlock content
}
```
```kotlin Android
// Coroutine context — PLYPresentationSession.await() resolves at dismiss
val outcome = PLYPresentation { placementId("<PLACEMENT_ID>") }
    .build()
    .display(context)
    .await()

when (outcome.purchaseResult) {
    PLYPurchaseResult.PURCHASED -> { /* unlock content */ }
    PLYPurchaseResult.RESTORED  -> { /* restore */ }
    PLYPurchaseResult.CANCELLED, null -> { /* dismissed: ${outcome.closeReason} */ }
}
```
```swift Swift
// On iOS the async display/preload calls return the PLYPresentation handle,
// NOT the outcome. The outcome is delivered through onDismissed (channel 2)
// or the default handler (channel 3) — see below.
let presentation = try await PLYPresentationBuilder
    .forPlacementId("<PLACEMENT_ID>")
    .build()
    .preload()
presentation.display(from: self)
```
```typescript React Native
// React Native display() resolves at dismiss with the 5-field outcome
const outcome = await Purchasely.presentation
    .placement('<PLACEMENT_ID>')
    .build()
    .display();

if (outcome.purchaseResult === 'purchased' || outcome.purchaseResult === 'restored') {
    // unlock content
} else {
    // dismissed: outcome.closeReason ('button' | 'backSystem' | 'programmatic')
}
```

> 🚧 iOS has no "return value" channel
>
> The iOS `display(...)` / `request.preload()` / `request.display()` async methods return the **`PLYPresentation` handle**, not the outcome. To read the result on iOS you must use a **per-presentation `onDismissed`** (channel 2) or the **default handler** (channel 3). Only **Flutter**, **Android** and **React Native** expose the outcome as the awaited return value.

## 2. A per-presentation dismiss handler (`onDismissed`)

Attach an `onDismissed` callback to **this** presentation while building it. It receives the `PLYPresentationOutcome` when the paywall closes.

```swift Swift
PLYPresentationBuilder
    .forPlacementId("<PLACEMENT_ID>")
    .onDismissed { outcome in
        switch outcome.purchaseResult {
        case .purchased, .restored: break // unlock content
        case .cancelled, .none:     break // dismissed: outcome.closeReason
        @unknown default:           break
        }
    }
    .build()
    .display(completion: nil)
```
```kotlin Android
PLYPresentation {
    placementId("<PLACEMENT_ID>")
    onDismissed { outcome ->
        when (outcome.purchaseResult) {
            PLYPurchaseResult.PURCHASED, PLYPurchaseResult.RESTORED -> { /* unlock */ }
            PLYPurchaseResult.CANCELLED, null -> { /* dismissed: ${outcome.closeReason} */ }
        }
    }
}.build().display(context)
```
```dart Flutter
PLYPresentationBuilder.placement('<PLACEMENT_ID>')
    .onDismissed((outcome) {
      if (outcome.purchaseResult == PLYPurchaseResult.purchased) {
        // unlock content
      }
    })
    .build()
    .display(const PLYTransition.fullScreen());
```
```typescript React Native
Purchasely.presentation
    .placement('<PLACEMENT_ID>')
    .onDismissed((outcome) => {
        if (outcome.purchaseResult === 'purchased' || outcome.purchaseResult === 'restored') {
            // unlock content
        } else {
            // dismissed: outcome.closeReason
        }
    })
    .build()
    .display();
```

## 3. The global default dismiss handler

Register **one** handler for the whole app with `setDefaultPresentationDismissHandler`. It receives the outcome whenever a presentation closes **without** a per-presentation `onDismissed`, and it is the channel used for presentations the **SDK opens itself**: deeplinks, campaigns, and promoted in-app purchases (which you never call `display()` on, so there is nowhere to attach a local handler).

```swift Swift
Purchasely.setDefaultPresentationDismissHandler { outcome in
    print("SDK presentation dismissed: \(outcome.purchaseResult) / \(outcome.closeReason)")
}
```
```kotlin Android
Purchasely.setDefaultPresentationDismissHandler { outcome ->
    println("SDK presentation dismissed: ${outcome.purchaseResult} / ${outcome.closeReason}")
}
```
```dart Flutter
Purchasely.setDefaultPresentationDismissHandler((outcome) {
  print('SDK presentation dismissed: '
      '${outcome.purchaseResult} / ${outcome.closeReason}');
});
```
```typescript React Native
Purchasely.setDefaultPresentationDismissHandler((outcome) => {
    // outcome: { presentation, purchaseResult, plan, closeReason, error }
    console.log('SDK presentation dismissed:', outcome.purchaseResult, '/', outcome.closeReason);
});
// Only one handler at a time; remove with the returned subscription's .remove()
// or Purchasely.removeDefaultPresentationDismissHandler().
```

> 📘 Set it once, at startup
>
> Register the default handler right after `start()`. It is your safety net for every presentation that has no local handler, and the **only** way to receive outcomes for SDK-initiated presentations (deeplinks, campaigns, promoted IAP).

# The routing rule

> **At dismiss, the outcome goes to the per-presentation `onDismissed` if one is set, otherwise to the global default handler.** The deciding factor is the **presence of a local handler**, not whether you awaited the display call.

In the native SDKs this is literally a single fallback expression:

* **Android** — `presentation.onDismissed ?: PLYPresentationViewController.defaultCallbackDismissHandler`
* **iOS** — the default handler fires only when the presentation has **no** inline `onDismissed`
* **Flutter** — `entry.presentation?.onDismissed ?? entry.request?.onDismissed`, falling back to the default handler when both are `null`

The return value of the display call is resolved **separately** and in **addition** to the selected handler (on Flutter/Android/React Native, which expose it).

> 📘 React Native routing differs
>
> On React Native the awaited `display()` resolves with the outcome and the request's own `onDismissed` fires, but the **global default handler is reserved for presentations the SDK opens itself** (deeplinks, campaigns, promoted IAP). It does **not** act as a fallback for presentations you display yourself, so the four cases below — which describe the native / Flutter fallback — do not map one-to-one to React Native. For a presentation you display, read the outcome from `await display()` and/or a local `onDismissed`.

## The four cases

The examples below use Flutter, but the principle is identical on every platform — substitute the per-platform `onDismissed` / `setDefaultPresentationDismissHandler` signatures shown above. (On iOS, where there is no return-value channel, cases A and C collapse to "the handler selected by the rule receives it".)

### Case A — fire-and-forget, global handler set

`display()` is called **without** `await` and **without** `onDismissed`. A global handler is registered → the **global** handler receives the outcome.

```dart Flutter
Purchasely.setDefaultPresentationDismissHandler((outcome) {
  // ✅ receives the outcome
});

// no await, no onDismissed
PLYPresentationBuilder.placement('<PLACEMENT_ID>')
    .build()
    .display(const PLYTransition.fullScreen());
```

### Case B — local `onDismissed`, no await

A per-presentation `onDismissed` is set (without awaiting) → the **local** handler receives the outcome; the global handler stays **silent**.

```dart Flutter
Purchasely.setDefaultPresentationDismissHandler((outcome) {
  // 🔇 NOT called — a local handler exists
});

PLYPresentationBuilder.placement('<PLACEMENT_ID>')
    .onDismissed((outcome) {
      // ✅ receives the outcome
    })
    .build()
    .display(const PLYTransition.fullScreen());
```

### Case C — `await display()`, no local handler, global handler set

You `await` the display **and** a global handler is registered, with **no** local `onDismissed` → **both** the awaited return value **and** the global handler receive the outcome.

```dart Flutter
Purchasely.setDefaultPresentationDismissHandler((outcome) {
  // ✅ ALSO called — no local handler exists, so the rule routes here…
});

// …AND the return value resolves with the same outcome
final outcome = await PLYPresentationBuilder.placement('<PLACEMENT_ID>')
    .build()
    .display(const PLYTransition.fullScreen());
// ✅ outcome is available here too
```

> 📘 Why both fire in case C
>
> Awaiting does **not** count as "handling locally". With no `onDismissed`, the routing rule still falls through to the global handler — and the awaited future resolves independently. If you want the global handler to stay silent, set a local `onDismissed` (case D).

### Case D — `await display()` + local `onDismissed`

You `await` the display **and** set a local `onDismissed` → the awaited return value **and** the local handler receive the outcome; the global handler stays **silent**.

```dart Flutter
Purchasely.setDefaultPresentationDismissHandler((outcome) {
  // 🔇 NOT called — a local handler exists
});

final outcome = await PLYPresentationBuilder.placement('<PLACEMENT_ID>')
    .onDismissed((outcome) {
      // ✅ receives the outcome
    })
    .build()
    .display(const PLYTransition.fullScreen());
// ✅ outcome is available here too
```

## Summary table

| Case | `await` return value | Local `onDismissed` | Global default handler |
|------|----------------------|---------------------|------------------------|
| **A** — no await, no local, global set | — | — | ✅ receives |
| **B** — local set, no await | — | ✅ receives | 🔇 silent |
| **C** — await, no local, global set | ✅ receives | — | ✅ receives |
| **D** — await + local | ✅ receives | ✅ receives | 🔇 silent |

(On **iOS** there is no return-value column: replace "✅ receives (return value)" with "use `onDismissed` or the default handler".)

# Presentations opened by the SDK

For presentations your app never calls `display()` on — **deeplinks**, **campaigns**, and **promoted in-app purchases** — there is no display call to await and nowhere to attach a local `onDismissed`. Their outcome is **always** delivered through the **global default handler**. This is the main reason to register `setDefaultPresentationDismissHandler` at startup even if every paywall you display manually uses a local handler.

# See also

* [Using Placements to display Screens & Paywalls](displaying-screens-placements)
* [Pre-fetching Screens](pre-fetching)
* [Controling Screen visibility](show-hide-close-screens)
* [Migrating to v6 — iOS](migrating-from-v5-to-v6-ios) · [Android](migrating-from-v5-to-v6-android) · [Flutter](migrating-from-v5-to-v6-flutter) · [React Native](migrating-from-v5-to-v6-react-native)
