---
title: SDK diagnostics and observability
excerpt: What the iOS SDK reports about itself, and what it does not report
deprecated: false
hidden: false
metadata:
  robots: index
---
<Callout icon="far fa-info" theme="info">
  ### Applies to the iOS SDK 6.1.0 and later

  The Android equivalent is not in 6.1.0.

  This article is informational. There is no public API and no client toggle for this feature.
</Callout>

## What the feature does

The iOS SDK can report its own traces, logs and crashes to Purchasely. The support team then finds the cause of a paywall problem without a reproduction of the problem.

## Which surfaces the SDK covers

The SDK reports on these surfaces:

| Surface | What it measures |
| :--- | :--- |
| `sdk.start` | The initialization of the SDK |
| The presentation fetch | The request for a screen or a placement |
| The purchase | The purchase flow |
| The restore | The restore flow |
| The paywall render | The time from the render to the visible screen |
| The action interceptor | The latency of your handler, and a hung handler |
| The Web2App redemption | The exchange of a redemption token |
| The campaign trigger | The decisions of a campaign trigger |

## Crash detection

The SDK uses MetricKit for the crash detection.

- The SDK installs NO crash handler. It therefore cannot interfere with Crashlytics, Sentry, Bugsnag or any other crash reporter in the app.
- The SDK reports only a crash that the report attributes to the SDK.
- The SDK ships no native code of its own. A native crash is out of scope.

## Who turns the feature on

The feature is OFF by default.

Purchasely enables the feature from the backend, with three levels of control:

- Per app.
- Per build environment: `development`, `preproduction` or `production`.
- Per family: `tracing` or `crash_detection`.

A client cannot turn the feature on. Purchasely can turn the feature off remotely, and this needs no app release.

## Privacy

- The SDK sends no personal data.
- The SDK sanitizes the free text from a crash report.
- The SDK never fabricates a console identity.

📚 See [Apple's Privacy Manifest Requirement](apples-privacy-manifest-requirement) for the data types that the SDK declares.
