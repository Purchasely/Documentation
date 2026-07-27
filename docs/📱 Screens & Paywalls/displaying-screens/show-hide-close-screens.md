---
title: Controling Screen visibility
excerpt: This section describes how to close a Screen programmatically
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Learn how to customize your Screens by nesting multiple views
  pages:
    - type: basic
      slug: nesting-views
      title: Nesting views
---
> 🚧 Minimum SDK versions
>
> The lifecycle described here is the **6.0** display API.
>
> * iOS: 6.0.0
> * Android: 6.0.1
> * Flutter: 6.0.0
> * React Native: 6.0.0-rc.2
> * Cordova: 6.0.0

> ❗️ There is no `hide` primitive any more
>
> In v5, `hidePresentation()` / `showPresentation()` / `closePresentation()` let you temporarily dismiss a Screen and bring it back. **All three are removed in v6.**
>
> | v5                                                | v6                                                                 |
> | :------------------------------------------------ | :----------------------------------------------------------------- |
> | `Purchasely.closeDisplayedPresentation()` (iOS)   | `Purchasely.closeAllScreens()`                                     |
> | `Purchasely.hidePresentation()`                   | `close()` — then display again to bring the Screen back            |
> | `Purchasely.showPresentation()`                   | `display()` on the presentation handle or on the request            |
> | `Purchasely.closePresentation()`                  | `close()` (kept as a deprecated alias on Cordova only)             |
>
> To show a Screen again after closing it, **fetch it again** with `preload`. See the [v5 → v6 migration guides](migrating-from-sdk-5-to-6).

# Two different scopes

| Method                          | What it closes                                                              |
| :------------------------------ | :--------------------------------------------------------------------------- |
| `close()` on a presentation      | **That** presentation. Available on the loaded presentation handle.          |
| `Purchasely.closeAllScreens()`   | **Every** Purchasely Screen currently displayed, whatever the display path.   |

Use `closeAllScreens()` when you need a guaranteed clean slate — for example when your app navigates away, or after handling a purchase yourself in Observer mode, where presentations no longer auto-close.

Both produce a `programmatic` close reason in the [presentation outcome](handling-presentation-result).

<br />

# Native iOS and Android

Call `close()` on the loaded [presentation](pre-fetching) object.

```swift Swift
PLYPresentationBuilder
    .forPlacementId("onboarding")
    .build()
    .preload { presentation, error in
        // once displayed, close this presentation
        presentation?.close()
    }

// Or, at any time, close every displayed Purchasely Screen
Purchasely.closeAllScreens()
```
```kotlin Kotlin
PLYPresentation {
    placementId("onboarding")
}.preload { presentation, error ->
    // once displayed, close this presentation
    presentation?.close()
}

// Or, at any time, close every displayed Purchasely Screen
Purchasely.closeAllScreens()
```

> 📘 `back()` is also available
>
> On the loaded presentation, `back()` navigates to the previous step instead of dismissing — useful inside a [Flow](flows).

<br />

# Flutter

The imperative global methods are gone. Use the loaded `PLYPresentation` handle, obtained from `preload()` or from `outcome.presentation`.

```dart Flutter
// Close this presentation
presentation.close();

// Display it (again) — after a close you must preload it first
presentation.display();
```

<br />

# React Native

Use the request returned by `.build()`.

```typescript React Native
const request = Purchasely.presentation.placement('onboarding').build();

await request.display();

// Dismiss it
request.close();
```

> 🚧 `request.close()` does not have the same scope on both platforms
>
> * **iOS** — closes the **specific** presentation identified by its `requestId`, falling back to closing all Purchasely Screens when the request is no longer tracked.
> * **Android** — the native SDK does not expose a per-request close yet, so it dismisses **all** displayed presentations. If you stack presentations (for example a product page inside an onboarding Flow), closing one also dismisses the others.
>
> The v5 top-level `close()` is removed. Use `Purchasely.closeAllScreens()` when you explicitly want to dismiss everything.

<br />

# Cordova

```javascript Cordova
// Dismiss the presentation of this request
request.close();

// Or close every displayed Purchasely Screen
Purchasely.closeAllScreens();
```

`request.back()` navigates back one step. On Cordova, `request.close()` always closes **every** displayed presentation, not only this request.

> 📘 `closePresentation()` is a deprecated alias
>
> `closeAllScreens` is the canonical name on Cordova. `closePresentation()` still works with identical behavior but is deprecated. `showPresentation()` and `hidePresentation()` were **removed with no alias**.

<br />

To learn more about fetching and displaying Screens, see [displaying screens](displaying-screens).
