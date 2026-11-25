---
title: Managing user privacy
excerpt: >-
  This page provides details on how to manage user privacy and disable data
  processing performed by the Platform to match the user choices
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
_Requires[SDK version 5.4.0](/changelog/54) or newer._

This page explains how you can respect end-user privacy by matching Purchasely SDK behavior to user consent, including how to disable data processing features when required.

<br />

# Roles and responsibilities

| Role                    | Description                                                                                                |
| :---------------------- | :--------------------------------------------------------------------------------------------------------- |
| Your App / Organization | Acts as **Data Controller** — you decide what processing is lawful and inform users accordingly.           |
| Purchasely              | Acts as **Data Processor** — we process data strictly under your instructions and in compliance with laws. |

<br />

As the Data Controller, you must:

1. Determine which data processing operations are lawful (legitimate interest vs. explicit consent).
2. Transparently inform users about the data processing Purchasely performs on your behalf.
3. Collect user consent when needed (e.g. via a CMP in your app).
4. Configure the Purchasely SDK to disable processing not permitted by user choice (via the `revokeDataProcessingConsent` API).

<br />

# Purchasely Data Processing Register

Below is a summary (excerpt) of the categories of processing conducted by Purchasely on your behalf, their legal basis, and whether they can be disabled.

| Processing        | Processing designation                                                                                          | Legal Basis                                                  | Revokable |
| :---------------- | :-------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------- | :-------- |
| **Processing #1** | All the operations are strictly mandatory to allow the Services to be managed technically and operationally     | Performance of contract (or action at user request)          | No        |
| **Processing #2** | All the operations enabling the statistical analysis, audience measurement and optimization of the User Journey | Data Controller's legitimate interest _or_ with user consent | Yes       |
| **Processing #3** | All the operations enabling the customization of the User journey and of the commercial offers presented        | Data Controller's legitimate interest _or_ with user consent | Yes       |
| **Processing #4** | All the operations enabling the proactive recommendation of commercial campaigns                                | Data Controller's legitimate interest _or_ with user consent | Yes       |
| **Processing #5** | All the operations enabling technical support, incident investigation and troubleshooting of the Services       | Data Controller's legitimate interest                        | Yes       |

More details on each processing are provided in the [Data Processing Agreement](https://www.purchasely.com/hubfs/PURCHASELY-DATA-PROCESSING-AGREEMENT.pdf).

<br />

> ℹ️ About Processing #1
>
> Processing #1 is essential to the functioning of the product (subscriptions), and cannot be turned off. If the user has agreed to your Terms & Conditions and activates a subscription, you have implicitly authorized that.  
> For details, consult the full Data Processing Agreement. (See link at end.)

<br />

> ℹ️ SDK diagnostics fall under Processing #1
>
> From SDK 6.1.0 the iOS SDK can report its own traces, logs and crashes to Purchasely, so the support team can find the cause of a paywall problem without a reproduction. That collection falls under **Processing #1** and is therefore **not revocable**: it exists to keep the Services working technically and operationally, and it is not audience measurement. It involves no personal data and is therefore distinct from [Processing #5](#processing-5---technical-support--incident-investigation), which covers investigations on User-level data.
>
> The data is performance data, other diagnostic data and crash data, all declared in the iOS SDK privacy manifest with the `AppFunctionality` purpose. Purchasely does not link it to the user and does not use it for tracking. The SDK collects no personal data and sanitizes free text from a crash report.
>
> The feature is off by default. Purchasely enables it from the backend, per app, per build environment and per signal family. There is no SDK API to turn it on, and Purchasely can turn it off remotely with no app release.
>
> See [SDK diagnostics and observability](sdk-diagnostics-and-observability) for the full description.

<br />

<br />

# How It Works: Consent Flow & SDK Integration

Here’s a recommended lifecycle to match SDK behavior with the user’s privacy choices:

1. **App Launch / Onboarding**
   * Show your privacy notice or consent pop-up via your CMP.
   * Ask for user consent to Data Processing that require explicit user consent (if applicable).
   * Provide the option to “decline” features that rely purely on legitimate interest (opt-out).
2. **Translate User Choice → SDK Configuration**
   * Based on the user’s selection, call the corresponding `revokeDataProcessingConsent` method(s) on the Purchasely SDK to disable the relevant processing(s).
   * This setting persists until changed (e.g., user revokes, changes decision, or reinstalls app).
3. **Behavior After Revocation**
   * If a processing is revoked, Purchasely disables the associated local trackers or data collection.
   * UI / SDK events may degrade in functionality depending on what is disabled (see caveats, below).

<br />

> 🚧 There is no direct interface between the CMP and the Purchasely SDK
>
> The Purchasely SDK is not directly interfaced with the CMP integrated into your app.
>
> The app has the responsibility to revoke the data processing to match the user choices provided by the CMP.

# Revoking Specific Processing Types

## Revoking processing

You must aggregate in one single call to the `revokeDataProcessingConsent` API all the Data Processing you want to revoke:

```swift
Purchasely.revokeDataProcessingConsent(for: [.identifiedAnalytics, .personalization])
```
```kotlin
Purchasely.revokeDataProcessingConsent(setOf(PLYDataProcessingPurpose.IdentifiedAnalytics))
```
```javascript React Native
Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.IDENTIFIED_ANALYTICS])
```
```javascript Flutter
Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.identifiedAnalytics]);
```
```javascript Cordova
Purchasely.revokeDataProcessingConsent([Purchasely.DataProcessingPurpose.identifiedAnalytics])
```

## Reactivating all processing

To reactivate all processing, you must call the `revokeDataProcessingConsent` API with an empty array

```swift
Purchasely.revokeDataProcessingConsent(for: [])
```
```kotlin
Purchasely.revokeDataProcessingConsent(emptySet())
```
```javascript React Native
Purchasely.revokeDataProcessingConsent([])
```
```javascript Flutter
Purchasely.revokeDataProcessingConsent([]);
```
```javascript Cordova
Purchasely.revokeDataProcessingConsent([])
```

###

## Processing #2 - Analytics / Aggregated Measurement

* **Purpose**: Capture aggregate UX metrics (screen views, navigation funnels) without personally identifying users.

<br />

* **When to revoke?**
  * if the Processing is necessary for the purposes of the Data Controller's legitimate interest => only revoke it if the user has _opted-out_
  * if the Processing requires the User explicit consent => revoke it if the user _has not given their consent_.

<br />

* **How to revoke?**
  ```swift
  Purchasely.revokeDataProcessingConsent(for: [.identifiedAnalytics])
  ```
  ```kotlin
  Purchasely.revokeDataProcessingConsent(setOf(PLYDataProcessingPurpose.IdentifiedAnalytics))
  ```
  ```javascript React Native
  Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.IDENTIFIED_ANALYTICS])
  ```
  ```javascript Flutter
  Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.identifiedAnalytics]);
  ```
  ```javascript Cordova
  Purchasely.revokeDataProcessingConsent([Purchasely.DataProcessingPurpose.identifiedAnalytics])
  ```

<br />

* **Effect**
  * [UI / SDK events](ui-sdk-events) will continue but only with the `anonymous_user_id` (randomly generated identifier), making them unlinkable to a real user
  * Non-essential built-in user attributes (e.g. optional navigation counters) will be disabled.
  * Local trackers used for analytics are cleared.

<br />

> ❗️ Fully disabling UI / SDK events
>
> In certain sensitive contexts — such as apps targeting children or privacy-focused apps like VPNs — you may choose to completely disable all UI and SDK event tracking.
>
> When this option is enabled, UI / SDK events will not be triggered (nor collected) by the SDK, making it impossible for the Purchasely Platform to:
>
> *  measure Screens or Paywalls displayed
> * measure conversion rates
> * fetch user insights generated when responding to a Quiz
>
> As a result, all related metrics — including Screens displayed, Paywalls displayed, Placements displayed, etc. — will be missing from the Console, especially in the Conversion Dashboard and A/B Tests reports.
>
> ⚠️ **Important**: This configuration should only be used as a last resort, as it will introduce significant data gaps and biases across all Dashboards relying on UI / SDK events and disable conversion reporting.
>
> To fully disable UI / SDK event collection, use the following code snippet:
>
> ```swift
> Purchasely.revokeDataProcessingConsent(for: [.analytics])
> ```
> ```kotlin
> Purchasely.revokeDataProcessingConsent(setOf(PLYDataProcessingPurpose.Analytics))
> ```
> ```javascript React Native
> Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.ANALYTICS])
> ```
> ```javascript Flutter
> Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.analytics]);
> ```
> ```javascript Cordova
> Purchasely.revokeDataProcessingConsent([Purchasely.DataProcessingPurpose.analytics])
> ```

<br />

## Processing #3 - Personalization / Recommendation Logic

* **Purpose**: Leverages user attributes ([built-in](user-attributes-list) or [custom](custom-user-attributes)) to tailor Paywalls, Offers, and journeys.

<br />

* **When to revoke?**
  * if the Processing is necessary for the purposes of your legitimate interest => revoke it only if the user has _opted-out_.
  * if the Processing requires the User explicit consent => revoke it if the user _has not given their consent_.

<br />

* **How to revoke?**
  ```swift
  Purchasely.revokeDataProcessingConsent(for: [.personalization])
  ```
  ```kotlin
  Purchasely.revokeDataProcessingConsent(setOf(PLYDataProcessingPurpose.Personalization))
  ```
  ```javascript React Native
  Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.PERSONALIZATION])
  ```
  ```javascript Flutter
  Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.personalization]);
  ```
  ```javascript Cordova
  Purchasely.revokeDataProcessingConsent([Purchasely.DataProcessingPurpose.personalization])
  ```

<br />

* **Effect**

  * Optional (non-essential) user attributes are wiped and not considered in audience matching.
  * If an audience rule depends solely on optional attributes, the user may fall into a default group (_Everyone else_)
  * Screen logic that uses only essential attributes will still function normally.

    <Image align="center" alt="Note: if an audience only relies on `essential` user attributes, it will still be possible for a user with Processing #3 revoked to match it" border={false} src="https://files.readme.io/d2303b6ac62df96b4b7bb237f01cca5dec24d0c525899a9d9eac2ff07d61b2c3-image.png" />

<br />

> 📘 User Attributes privacy settings
>
> Built-in user attributes are classified as `essential` or `optional`.
>
> 📚 More details in the [built-in user attribute list](user-attributes-list)
>
> Custom User Attributes can be defined as `essential` or `optional` too:
>
> * when you set a Custom User Attribute, you must define its privacy setting
> * by default, a user attribute is `optional` (if privacy setting has been set).
> * Custom User Attributes set prior to the update of the SDK to `v5.4` are classified as `optional` too.
> * User Attributes rely on local storage trackers.
>
> 📚 More details on [Custom User Attributes' privacy settings](https://docs.purchasely.com/docs/custom-user-attributes#about-privacy-settings)

## Processing #4 - Spontaneous Campaign/Offers

* **Purpose**: Automatically trigger in-app experiences (e.g. promotion banners) without explicit user action, upon the app start  
  📚 See the [documentation about Campaigns](campaigns).

<br />

* **When to revoke?**
  * if the Processing is necessary for the purposes of your legitimate interest => revoke it only if the user has _opted-out_.
  * if the Processing requires the User explicit consent => revoke it if the user _has not given their consent_.

<br />

* **How to revoke**?
  ```swift
  Purchasely.revokeDataProcessingConsent(for: [.campaigns])
  ```
  ```kotlin
  Purchasely.revokeDataProcessingConsent(setOf(PLYDataProcessingPurpose.Campaigns))
  ```
  ```javascript React Native
  Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.CAMPAIGNS])
  ```
  ```javascript Flutter
  Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.campaigns]);
  ```
  ```javascript Cordova
  Purchasely.revokeDataProcessingConsent([Purchasely.DataProcessingPurpose.campaigns])
  ```

<br />

* **Effect**: Automatically triggered Campaigns are fully disabled.

<br />

## Processing #5 - Technical Support / Incident Investigation

<Callout icon="📘" theme="info">
  ### Availability

  This purpose is available from SDK **6.3.0** on iOS, Android, React Native, Flutter and Cordova.
</Callout>

* **Purpose**: Investigate and resolve the issues you report, or the anomalies that affect the Services. Investigations use aggregated data whenever possible. Purchasely accesses User-level data (identifiers, events, transactions, properties) only when the issue cannot be resolved otherwise, and only for the Users concerned by that issue.

  Authorised Purchasely personnel or automated support agents carry out the investigations. The automated support agents use a large language model provider (OpenAI) as a sub-processor. The data stays in the European Union, is never used for model training, and is deleted within 30 days.

<br />

* **When to revoke?**
  * This Processing is necessary for the purposes of your legitimate interest and is active by default => revoke it only if the user has _opted-out_.

<br />

* **How to revoke?**
  ```swift
  Purchasely.revokeDataProcessingConsent(for: [.supportInvestigation])
  ```
  ```kotlin
  Purchasely.revokeDataProcessingConsent(setOf(PLYDataProcessingPurpose.SupportInvestigation))
  ```
  ```javascript React Native
  Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.SUPPORT_INVESTIGATION])
  ```
  ```javascript Flutter
  Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.supportInvestigation]);
  ```
  ```javascript Cordova
  Purchasely.revokeDataProcessingConsent([Purchasely.DataProcessingPurpose.supportInvestigation])
  ```

<br />

* **Effect**
  * The SDK sends `support-investigation` in the list of refused purposes.
  * Investigations that concern this user use aggregated data only.
  * Issues specific to this user (for example, a subscription that does not unlock or an unexpected paywall) can take longer to resolve, or cannot be resolved.
  * The SDK behavior does not change.

<br />

> 💡 Reduce the data without revoking
>
> To minimise the data involved in an investigation without revoking this Processing, hash your external user identifiers before you pass them to the SDK.

<br />

## Disabling All Non-Essential Processing

* **Purpose**: Revoking all non essential processing at once when user chose to reject non essential processing

<br />

* **How to revoke**: You can opt to revoke all revokable processing in one go:

```swift
Purchasely.revokeDataProcessingConsent(for: [.allNonEssentials])
```
```kotlin
Purchasely.revokeDataProcessingConsent(setOf(PLYDataProcessingPurpose.AllNonEssentials))
```
```javascript React Native
Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.ALL_NON_ESSENTIALS])
```
```javascript Flutter
Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.allNonEssentials]);
```
```javascript Cordova
Purchasely.revokeDataProcessingConsent([Purchasely.DataProcessingPurpose.allNonEssentials])
```

<br />

* **Effect**: This disables Processing #2, #3, #4 and #5 simultaneously.

> ℹ️ From SDK 6.3.0, `allNonEssentials` also includes [Processing #5](#processing-5---technical-support--incident-investigation). A refusal that an older SDK version stored does not change after the update. Call `revokeDataProcessingConsent` again to send it with the new purposes.

> ℹ️ `allNonEssentials` does not include the [Refund Handling](#refund-handling-ios-only) purpose. Add it to the same call when the user refuses it too.

<br />

## Disabling Forwarding to 3rd-Party Integrations

* **Purpose:** While subscription lifecycle events (Processing #1) cannot be turned off, you can disable forwarding them to external systems (e.g. analytics, CRMs)

<br />

* **How to revoke?**
  ```swift
  Purchasely.revokeDataProcessingConsent(for: [.thirdPartyIntegrations])
  ```
  ```kotlin
  Purchasely.revokeDataProcessingConsent(setOf(PLYDataProcessingPurpose.ThirdPartyIntegrations))
  ```
  ```javascript React Native
  Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.THIRD_PARTY_INTEGRATION])
  ```
  ```javascript Flutter
  Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.thirdPartyIntegrations]);
  ```
  ```javascript Cordova
  Purchasely.revokeDataProcessingConsent([Purchasely.DataProcessingPurpose.thirdPartyIntegrations])
  ```

<br />

> ℹ️ About 3rd party integrations
>
> In the Purchasely Console, you can activate 3rd party integrations, to automatically forward subscription lifecycle events (Server Events) and user subscription attributes to them. See [documentation](engagement-crm)

<br />

## Refund Handling (iOS only)

<Callout icon="📘" theme="info">
  ### Availability

  This purpose is available from SDK **6.2.0** on iOS, and on React Native, Flutter and Cordova for iOS apps. Android has no equivalent, because it concerns App Store refund requests only.
</Callout>

* **Purpose**: When a user asks Apple for a refund, Apple sends a `CONSUMPTION_REQUEST` notification. Purchasely can answer with the consumption data of the user, to help Apple decide on the refund. Apple accepts this data only with the consent of the user.

<br />

* **When to revoke?** Revoke it when the user refuses to share consumption data with Apple for refund requests.

<br />

* **How to revoke?**
  ```swift
  Purchasely.revokeDataProcessingConsent(for: [.refundHandling])
  ```
  ```javascript React Native
  Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.REFUND_HANDLING])
  ```
  ```javascript Flutter
  Purchasely.revokeDataProcessingConsent([PLYDataProcessingPurpose.refundHandling]);
  ```
  ```javascript Cordova
  Purchasely.revokeDataProcessingConsent([Purchasely.DataProcessingPurpose.refundHandling])
  ```

<br />

* **Effect**: Purchasely does not answer the `CONSUMPTION_REQUEST` notifications of this user. The SDK behavior does not change.

<br />

> 🚧 Pass every refused purpose in the same call
>
> `revokeDataProcessingConsent` replaces the full list of refused purposes each time you call it. It does not add to the previous call. `allNonEssentials` does not include `refundHandling`, so pass both when the user refuses everything:
>
> ```swift
> Purchasely.revokeDataProcessingConsent(for: [.allNonEssentials, .refundHandling])
> ```
