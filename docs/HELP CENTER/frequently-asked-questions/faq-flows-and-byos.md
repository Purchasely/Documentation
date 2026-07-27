---
title: Flows & BYOS
excerpt: >-
  Multi-step journeys, transitions, how a Flow ends, and inserting your own
  native screens with BYOS.
deprecated: false
hidden: false
metadata:
  title: 'FAQ: Flows & BYOS'
  description: >-
    How Purchasely Flows are displayed and navigated, why a transition may be
    ignored, how a Flow reports its outcome, and how to plug your own native
    screens into a Flow with BYOS on iOS and Android.
  robots: index
next:
  description: ''
---
# What is a Flow, and how do I display one?

A Flow is a sequence of Screens built in the Screen Composer, linked by **Transitions** on a canvas in the Flow Composer.

You display it exactly like any other presentation — there is no Flow-specific display API:

```swift Swift
PLYPresentationBuilder
    .forPlacementId("onboarding")
    .build()
    .preload { presentation, error in
        presentation?.display(from: myUIViewController)
    }
```
```kotlin Kotlin
PLYPresentation {
    placementId("onboarding")
}.display(context)
```

Calling `display()` is what makes the Flow work: the SDK then handles navigation between Screens according to the configured Transitions, and applies the Flow's Display Mode. **If you render the presentation yourself instead of calling `display()`, you lose the Flow navigation.**

📚 [Flows](flows) · [Flow implementation](flow-implementation) · [Flow integration](flow-integration)

<br />

# How do I know whether a presentation is a Flow?

```swift Swift
if presentation.isFlow { /* … */ }
```
```kotlin Kotlin
if (presentation.flowId != null) { /* … */ }
```

Only check this if your implementation genuinely needs it — `display()` handles Flows and single Screens identically, so most integrations never have to branch on it.

<br />

# A transition I configured on a button is ignored

Transitions can only override a component action that is already one of:

* **Open Screen**
* **Open Placement**
* **Deeplink**
* **Web Page**

**Any other action value is ignored** by the transition. That is why no transition handle appears on some components in the Flow Composer: their action is not overridable — for example a `Purchase`, `Close`, `Restore` or `none` action.

Two consequences that come up regularly:

* A button that looks like it should navigate does nothing, because its Screen-level action is not in the list above.
* A Screen shows what look like **duplicate or unexpected buttons** across Flows: transitions override the Screen-level action, which is what lets the same Screen be reused in several Flows. Check the Screen's own actions, not only the Flow canvas.

📚 [Flow configuration](flow-configuration) · [Action types](action-types)

<br />

# What is the difference between Display Mode and Transition Type?

| Setting                   | Scope                                                       | Configured on                                                       |
| :------------------------ | :---------------------------------------------------------- | :------------------------------------------------------------------- |
| **Flow Display Mode**     | How the **first** Screen of the Flow opens in your app.     | The Flow. Applies only at launch. Defaults to **Full screen**.       |
| **Screen Transition Type**| Navigation **between** Screens inside the Flow.             | A default at Flow level, overridable per Transition.                 |

Available transition types: **Push**, **Modal**, **Drawer**, **Pop-in**, **Full screen**. Drawers and pop-ins take a configurable height.

> ⚠️ Push needs a navigation bar
>
> `Push` requires a navigation bar in the parent view. Without one, the SDK falls back to **Modal on iOS** and **Full Screen on Android**. If a Screen appears to sit on top of the previous one instead of pushing, this is usually why.

> ❗️ The Display Mode is not reflected in the Console preview
>
> The preview always renders the Screen itself. To see how a Flow actually opens and navigates, test on a device with [Debug Mode](debug-mode).

<br />

# Why does my Flow freeze or go blank?

Work through this in order:

1. **`display()` was not used.** A Flow only navigates when the SDK owns the display. Fetching the presentation and rendering it yourself stops the Flow at its first Screen.
2. **A step's action is not overridable**, so the transition never fires and the Flow has nowhere to go — see the transition question above.
3. **The Flow was opened by a deeplink and displayed twice.** If you both handle the deeplink yourself and let the SDK display it, you get two stacked presentations. Implement [deeplink management](deeplinks-management) and let the SDK display, or take over via the UI handler — not both.
4. **A BYOS step never handed control back.** If a Custom Screen does not call the execute method, the Flow waits indefinitely — see the BYOS section below.
5. **A BYOS step returned no view.** On iOS, if the UIKit delegate returns `nil` and there is no SwiftUI delegate (or it returns an empty view), the presentation is closed — which can read as a black screen.

If none of these apply, report it with the [Screen Issue Report Template](screen-issue-report-template), specifying the Flow, the step where it froze, and how the Flow was opened.

<br />

# How do I know how a Flow ended, and whether a purchase was made?

Through the standard presentation outcome — `PLYPresentationOutcome`, which carries:

| Field            | What it tells you                                                                                          |
| :--------------- | :---------------------------------------------------------------------------------------------------------- |
| `purchaseResult` | `purchased`, `restored` or `cancelled` (absent / `none` when no purchase action took place).                 |
| `plan`           | The plan involved, when there is one.                                                                       |
| `presentation`   | The presentation handle. Absent if it never reached display.                                                |
| `closeReason`    | `button` (a close/back button rendered by the paywall), `backSystem` (Android back, iOS swipe-down or nav pop), `programmatic` (your app closed it). |
| `error`          | Mutually exclusive with `closeReason`.                                                                      |

You receive it through one of two handlers:

* **`onDismissed`** on a specific presentation, or
* **`setDefaultPresentationDismissHandler`**, the global fallback.

> 📘 The local handler wins
>
> The deciding factor is **the presence of a local `onDismissed`**, not whether you awaited the display call. With a local handler set, the global default does not fire for that presentation.

> ❗️ Register the global handler right after `start()`
>
> Presentations the **SDK opens itself** — deeplinks, Campaigns, promoted in-app purchases — have no display call for you to await and nowhere to attach `onDismissed`. Their outcome always goes to the global handler. Without it registered, you never learn what happened.

Minimum SDK versions for `PLYPresentationOutcome`: iOS 6.0.0, Android 6.0.1, Flutter 6.0.0, React Native 6.0.0-rc.2. On React Native, the global handler covers only SDK-opened presentations, not the ones you display yourself.

📚 [Handling the presentation result](handling-presentation-result)

<br />

# Where do I see how users move through a Flow?

The Flow analysis dashboard renders the journey as a Sankey diagram, with date, platform and country filters.

At event level, `flow_id`, `flow_version`, `step_id`, `from_step_id`, `from_action_id` and `flow_session_id` are attached to the events, so you can rebuild the path yourself from your own warehouse.

📚 [Flow analysis](flow-analysis)

<br />

# How do I get the answers a user gave to a Quiz in a Flow?

Through the **Custom User Attributes listener**, not a dedicated Quiz API. Enable *Save answer(s) as an Insight Attribute* on the Quiz, and the listener fires on submission with:

* `key` = the **Quiz ID**,
* a single `String` value for a single-answer quiz, or an array of strings for a multi-answer one,
* `source` = `purchasely`, telling you the attribute came from the SDK rather than from your own code.

No per-Quiz SDK code is needed. Forwarding the answers to your backend or a third-party tool is entirely on your side — there is no server-to-server integration for this.

📚 [Fetching quiz insights](fetching-quiz-insights) · [Custom user attribute listener](custom-user-attribute-listener) · [User insights](user-insights)

<br />

# BYOS — how do I put one of my own native screens inside a Flow?

**BYOS (Bring Your Own Screen)** is available on **native Swift and Kotlin only**. React Native, Flutter and Cordova support is planned but not shipped.

The lifecycle:

1. Your app requests a Screen the usual way — BYOS requires `display()`.
2. When the presentation is a Custom Screen (type `CLIENT`), the SDK **does not render it** and calls you back with the Screen ID and the list of connections.
3. You build the native view and **return it to the SDK**, which displays it through the Purchasely navigation layer — so it inherits the Flow's configured transition.
4. While it is on screen, your app owns every interaction and all business logic.
5. When done, you call the execute method with the **selected connection**, which resumes the Flow at the step mapped to that connection.

## iOS (Swift)

```swift Swift
// UIKit
func viewController(for presentation: PLYPresentation) -> UIViewController? { … }
Purchasely.setCustomScreenViewControllerDelegate(myDelegate)

// SwiftUI
@ViewBuilder func view(for presentation: PLYPresentation) -> Content { … }
Purchasely.setCustomScreenViewDelegate(myDelegate)

// Hand control back to the Flow
presentation.executeConnection(
    presentation.connections.first(where: { $0.id == "login" })
)
```

Both delegates can be set. **The UIKit delegate is called first**; if it returns no view controller, the SDK falls back to the SwiftUI delegate. If neither provides a view, **the presentation is closed** — which is the usual cause of a black screen at a BYOS step. Register the delegates **after** the SDK has started.

## Android (Kotlin)

```kotlin Kotlin
Purchasely.setCustomScreenProvider(object : PLYCustomScreenProvider {
    override fun onCustomScreenRequested(presentation: PLYPresentation): PLYCustomScreen? {
        return PLYCustomScreen.View(myView) // or PLYCustomScreen.Fragment(myFragment)
    }
})

// Hand control back to the Flow
val connection = presentation.connections.firstOrNull { it.id == "login" }
presentation.execute(connection)
```

Set the provider at application initialization, before any presentation is displayed.

> 📘 The method names differ between platforms
>
> iOS: `presentation.executeConnection(_:)` · Android: `presentation.execute(connection:)`. Passing no connection falls back to the presentation's default connection, if one is defined.

<br />

# What connections should I define, and where?

In the Console, create a Screen with the **Bring Your Own Screen** layout, set its **Screen ID**, and define the **connections** — the possible exit points, for example `login_successful`, `signup`, `cancel`. Add a screenshot as the background image so the Flow canvas stays readable.

Both the **Screen ID and the connection IDs must be agreed with your mobile engineering team**, because your native code matches on those exact strings.

A BYOS Screen can sit anywhere in a Flow, including as the **first step**, and you can chain several of them with an independent transition per link.

📚 [BYOS configuration](byos-configuration) · [BYOS implementation](byos-implementation)

<br />

# What context do I get inside a Custom Screen?

The `PLYPresentation` handed to your delegate carries the targeting context, so you do not need to plumb it through yourself: `screenId`, `placementId`, `audienceId`, `abTestId`, `abTestVariantId`, `campaignId`, `language`, and `connections`.

This is what lets a BYOS step inside a Campaign Flow know which Campaign it belongs to.

<br />

# What is tracked automatically in a BYOS screen, and what is not?

| Situation                                                    | Tracking                                                                                     |
| :----------------------------------------------------------- | :-------------------------------------------------------------------------------------------- |
| Custom Screen inside a Flow, displayed via `display()`        | **Automatic.** The SDK emits the display event with your Screen ID in `displayed_presentation`. |
| Custom Screen outside a Flow, displayed via `display()`       | **Automatic.**                                                                                 |
| You fetch and display the view yourself, without `display()`  | **Manual** — call `clientPresentationDisplayed(...)` on display and `clientPresentationClosed(...)` on close. |
| User interactions **inside** your Custom Screen               | **Never tracked.** Instrument them yourself.                                                   |

> ❗️ A purchase made inside a Custom Screen must be reported
>
> Call `Purchasely.synchronize()` after your own purchase flow completes, so the SDK picks up the latest receipt. Without it, purchases made on your own paywall are **not counted in A/B test results** — which silently invalidates any legacy-paywall vs Purchasely-paywall test.

<br />

# Can I A/B test a Flow against a single Screen, or my own paywall against a Purchasely one?

Yes — that is one of the main BYOS use cases, including A/A tests to validate instrumentation before trusting a real test. A/B testing between Flows, or a Flow against a Screen, is a **Premium** capability.

Whatever the setup, make sure purchases in your own screen are synchronized (see above), otherwise one arm of the test reports no revenue.

📚 [BYOS](byos) · [A/B test configuration](ab-test-configuration)
