---
title: Screens & paywalls
excerpt: >-
  Layouts and components, personalization, localization, A/B tests, and the
  rendering issues we are asked about most often.
deprecated: false
hidden: false
metadata:
  title: 'FAQ: Screens & paywalls'
  description: >-
    What the Screen Composer offers, how localization and dark mode work, how
    many A/B test variants are supported, and how to diagnose missing prices,
    cut-off CTAs, non-scrollable content and stale published changes.
  robots: index
next:
  description: ''
---
# What paywall models do you provide?

Everything goes through the [Screen Composer](screen-composer) — no-code, drag & drop, and updated without an app release.

| Area                | What is available                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| :------------------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Layouts**         | Fill height, scroll, sticky button, tabs, carousel.                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| **Components**      | [Vertical](plan-pickers-vertical), [horizontal](plan-pickers-horizontal) and [expandable](expandable-pickers) plan pickers, multi-action [CTAs](buttons), [comparison tables](table-comparison), [timelines](timeline-vertical), [countdowns](countdown), [progress bars](progress-bars), [reviews](reviews), dynamic [tags](tags), [images](images), [videos](videos-1), [Lottie animations](lottie-animations), [quizzes](quiz), [FAQ blocks](faq), [bulleted lists](bulleted-lists). |
| **Personalization** | [Color palette](color-palette), [custom fonts](composer-custom-fonts), native [dark mode](composer-dark-mode), [safe area](safe-area) handling, automatic [adaptation to screen sizes and orientations](composer-adapting-screens-to-devices), and [conditional visibility](conditional-visibility) driven by user data or by what the user does inside the Screen — so you personalize without duplicating Screens.                                                                    |
| **Localization**    | Per Screen, language by language, plus localization of the SDK's own system strings. See [Screen localization](composer-localization) and [Localizing your app](localizing-your-app).                                                                                                                                                                                                                                                                                                   |
| **A/B tests**       | Up to 26 variants per test, deterministic assignment by hash of the user ID (a given user always sees the same variant), Bayesian statistical significance. Stripe web transactions are included in the results. See [A/B tests](ab-tests).                                                                                                                                                                                                                                             |

Beyond the single Screen: [Flows](flows) (multi-step journeys with conditional routing), [Placements](displaying-screens-placements), [Audiences](segmenting-your-user-base), programmatic [Campaigns](campaigns) (win-back, cancel survey, grace period) and [BYOS](byos) to insert one of your own native screens inside a Purchasely Flow.

<br />

# Why is my price showing as a dash, or empty?

The Screen renders, but the price placeholder cannot be resolved. Work down this list:

1. **The Plan is not mapped to a store product.** Check in the Console that the Plan has a store product ID for the platform you are testing on. A Plan mapped only to iOS shows nothing on Android.
2. **The store product is not purchasable yet.** On the App Store, subscriptions must be at least in "Ready to Submit" with a completed price schedule and an accepted paid apps agreement. On Google Play, the product must be **active** and the app published on at least one track.
3. **The tester's account is not eligible.** A sandbox account on the wrong country / store front will not resolve prices.
4. **Android only — a Google Play Billing dependency conflict.** If prices resolve on iOS but not Android, this is the most likely cause. See [Google Play Billing v8](google-play-billing-v8) for the `billing` vs `billing-ktx` issue on SDK 5.x. On cross-platform SDKs, verify that the main package and the Google package are on the **exact same version**.
5. **The SDK failed to start.** Prices come from the store, but the Plan mapping comes from us. Check the `start()` error callback and enable `logLevel(.debug)`.

📚 [Configuring App Store products](app-store-configuring-in-app-subscriptions) · [Configuring Play Store products](play-store-configuring-in-app-subscriptions)

<br />

# Why does no Screen show at all?

`preload` returns without a presentation, or returns a "deactivated" type. Usual causes:

1. **The Placement has no Screen assigned**, or the assigned Screen is still a draft. A Placement serves the first matching Audience by priority order — if no Audience matches and there is no default, nothing is served.
2. **An Audience with a higher priority matches and points to nothing.** Check the Audience order on the Placement.
3. **The Placement identifier in your code does not match the Console.** Placement IDs are exact strings.
4. **The SDK was not started, or started with a blank API key.** In that state the SDK stays inert: no Screen, no analytics, no purchase, and no crash.
5. **You are looking at a draft.** Draft Screens are only visible with [Debug Mode](debug-mode) enabled on the device.

Enable [Debug Mode](debug-mode) first — the Debug Panel tells you exactly which Placement, Audience, A/B test and variant were resolved for that device, which usually ends the investigation immediately.

<br />

# Why does my Screen look different on Android and iOS?

Some differences are expected, some are bugs. Expected:

- **Font metrics.** The same font renders with different line heights and fallback behavior on each platform. If a font family is not embedded for one platform, the OS substitutes it — which changes wrapping and can clip text. See [Custom fonts](composer-custom-fonts).
- **System string localization.** Prices, durations and renewal terms are formatted by the store, not by us, so wording differs.
- **Safe area and notch handling.** Check the [safe area](safe-area) configuration.
- **Nav bar and status bar treatment**, which follows each platform's conventions.

If the layout itself is wrong on one platform only, report it with the [Screen Issue Report Template](screen-issue-report-template), including screenshots from **both** platforms and both light and dark mode.

<br />

# My CTA is cut off, or the content does not scroll

This is almost always a layout configuration rather than an SDK bug:

- **Fill height layout with more content than the viewport.** Fill height does not scroll by design. Switch the Screen to a scroll layout, or to scroll with a sticky button so the CTA stays pinned.
- **A component set to [Expand to fill](expand-to-fill) inside a scrollable container.** "Expand to fill" needs a bounded parent height; in a scroll container it has nothing to expand against.
- **Fixed heights on a small device.** Test on a small screen (and on a very tall one such as an S20 Ultra or a Pro Max) using [Preview](preview) and [adaptive settings](composer-adapting-screens-to-devices).
- **Inline paywall with an unbounded container.** When embedding, the host view must give the paywall a real height. See [Displaying inline paywalls](displaying-inline-paywalls) and [Nesting views](nesting-views).

<br />

# Why is a close or back button still visible?

Two different things control this:

- The **Screen's own close button**, configured in the Composer — see [Close button](composer-close-button).
- Your **host navigation**. If you present the paywall inside your own navigation controller or fragment with its own nav bar, that chrome belongs to your app and the Composer cannot remove it. Present it modally / full screen, or hide your nav bar for that route.

📚 [Close button configuration](composer-close-button) · [Controlling Screen visibility](show-hide-close-screens)

<br />

# I published a change in the Console but the app still shows the old Screen

In order of likelihood:

1. **The change was saved but not published.** Drafts are only visible in [Debug Mode](debug-mode).
2. **The SDK cached the previous version.** Screens are cached per session. Fully close and reopen the app, or dismiss and re-open the paywall so the SDK re-fetches. A screenshot taken without reopening the Screen may predate your change entirely.
3. **The Placement resolves to a different Screen than you think** — an Audience or a running A/B test overrides the default. The Debug Panel shows what was actually resolved.
4. **A/B test in progress.** A user already bucketed keeps their variant; that is by design.

<br />

# Why is my custom font not applied, or why is my text clipped?

Because the Screen is rendered with **native** iOS and Android components, the font has to exist in the **native project**. The font file you upload in the Console is used **only for the Composer preview** — it is never shipped to the device.

So a font works only if all three are true:

1. The font is added to the **iOS project** (per Apple's guide, registered in `Info.plist` under `UIAppFonts`) **and** to the **Android project** (`main/assets` or, preferably, `res/font`).
2. The **iOS font name** field in the Console matches the font's internal **PostScript name** — not the filename. Renaming a font file does nothing: iOS resolves fonts by internal metadata. Use `UIFont.familyNames()` then `UIFont.fontNames(forFamilyName:)` to get the real name.
3. The **Android font name** field matches the resource name (verify with `ResourcesCompat.getFont(context, R.font.myfont)`).

If one platform is missing the font, the OS silently substitutes a fallback — which changes line height and wrapping, and is the usual cause of **clipped multiline text on one platform only**.

If you use a bridge SDK (React Native, Flutter, Cordova), the font still has to be added to the underlying iOS and Android projects.

📚 [Custom fonts](composer-custom-fonts) · [Figma plugin](figma-plugin)

<br />

# Why is one of my strings not translated?

There are **two separate** localization layers, and they are edited in different places:

| Layer                  | What it covers                                                                                    | Where you edit it                                                                                                                                               |
| :--------------------- | :------------------------------------------------------------------------------------------------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Screen content**     | Everything you typed in the Composer — titles, CTA labels, benefit lists, FAQ blocks.             | Per Screen, language tab by language tab, or in bulk with **Smart Localization** (a CSV of keys × languages). See [Screen localization](composer-localization). |
| **SDK system strings** | Error messages, the Restore button, "Already subscribed? Sign in", the Ask to Buy waiting screen. | Override the `ply_*` keys in your own `Localizable.strings` / `strings.xml`. See [Localizing your app](localizing-your-app).                                    |

Consequences:

- A string that stays in English while the rest of the Screen is translated is usually an **SDK system string** in a language the SDK does not ship. The SDK ships **17 languages** and falls back to English; Screen content supports far more.
- A missing translation on a Screen means that **language tab was not filled in** for that component. There is no automatic fallback to the default language per component.
- Prices, durations and renewal terms are formatted **by the store**, not by us — `{{PRICE}}`, `{{AMOUNT}}`, `{{DURATION}}` and the other [tags](tags) resolve at display time from the store's own localized data.
- The app's **default language is chosen at app creation and cannot be changed afterwards**.

To force a language instead of following the OS:

```swift Swift
Purchasely.setLanguage(from: Locale(identifier: "es"))
```
```kotlin Kotlin
Purchasely.language = Locale("es")
```

<br />

# Why does a user see a different Screen than the one I expect?

A Placement resolves in a strict order, and the first match wins:

1. The SDK walks the Audiences attached to the Placement **from the highest priority down** (top of the list = highest).
2. The first Audience the user belongs to determines the Screen.
3. If no Audience matches, the Screen attached to **_Everyone else_** is served.
4. A running **A/B test** overrides that result with one of its variants.

So a user can belong to several Audiences and still see only one Screen — the highest-priority one. If the wrong Screen appears, reorder the Audiences on the Placement (`⋮`**&#x20;→ Prioritize audiences**) rather than editing the Audiences themselves.

Two things that regularly surprise people:

- **Audience is not the same as [conditional visibility](conditional-visibility).** An Audience picks _which Screen_ is served; conditional visibility hides or shows _components inside_ a Screen. If a component must appear only for some users, that is conditional visibility, not an Audience.
- **Expired-subscription attributes are only populated for subscriptions Purchasely knows about.** For a user who churned before you integrated Purchasely — or whose subscription was never imported — only `Has expired subscription` is set, computed from the local receipt. Audiences built on the finer expired attributes will not match those users.

To see what actually resolved for a device, use [Debug Mode](debug-mode) — the Debug Panel names the Placement, Audience, A/B test and variant applied.

📚 [Audiences](audiences) · [Leveraging Audiences](leveraging-audiences) · [Placements](displaying-screens-placements)

<br />

# Can I embed a paywall inside one of my own screens?

Yes — nested display is supported on Swift, Kotlin (including Compose), Flutter and React Native. Cordova is not supported.

Three rules cover most inline issues:

1. **Pre-fetch the Placement first.** A nested view is built from a **preloaded** presentation, not from a placement ID. On Android, `buildView(context)` requires a loaded presentation.
2. **The height is set in the Composer**, on the first item (the layout) of the Screen structure. The SDK also exposes it as `PLYPresentation.height` on the preloaded presentation, so you can size your container from it instead of hardcoding a value.
3. **Your host view owns the layout and the removal.** In UIKit you add the presentation's view as a subview and pin its four anchors; in SwiftUI you use `presentation.swiftUIView`; on Android you add the built view to your container. On close, the SDK calls `onCloseRequested` — **removing the view from your layout is your responsibility**, the SDK does not do it for you.

The Console preview is not a size reference for a nested paywall: the preview renders at full-screen proportions while the device renders at your container's size. Compare against the device.

📚 [Displaying inline paywalls](displaying-inline-paywalls) · [Nesting views](nesting-views) · [Displaying Screens with SwiftUI](displaying-screens-with-swiftui) · [Pre-fetching](pre-fetching)

<br />

# Can I use one of my own native screens inside a Purchasely Flow?

Yes, that is **BYOS** (Bring Your Own Screen). Purchasely hands control to your native screen at a step of the Flow and resumes the Flow when you hand it back.

📚 [BYOS configuration](byos-configuration) · [BYOS implementation](byos-implementation)

<br />

# Can I design in Figma and import into the Composer?

Yes, via the Figma plugin.

📚 [Figma plugin](figma-plugin)

<br />

# How do I report a Screen rendering issue so it gets fixed quickly?

Use the [Screen Issue Report Template](screen-issue-report-template). The fields that matter most and are most often missing:

- the **link to the Screen** in the Console,
- **how** the Screen is displayed (Placement, deeplink, programmatic call, inline view),
- **SDK version, app version, platform, environment**,
- screenshots or a recording in **both** light and dark mode,
- whether the issue affects **all** users or only some (device, language, eligibility, entitlement).

<br />
