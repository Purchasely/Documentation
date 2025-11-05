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
*Requires[SDK version 5.4.0](/changelog/54) or newer.*

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
| **Processing #2** | All the operations enabling the statistical analysis, audience measurement and optimization of the User Journey | Data Controller's legitimate interest *or* with user consent | Yes       |
| **Processing #3** | All the operations enabling the customization of the User journey and of the commercial offers presented        | Data Controller's legitimate interest *or* with user consent | Yes       |
| **Processing #4** | All the operations enabling the recommendation of commercial offers displayed spontaneously                     | Data Controller's legitimate interest *or* with user consent | Yes       |

More details on each processing are provided in the [Data Processing Agreement](https://www.purchasely.com/hubfs/PURCHASELY-DATA-PROCESSING-AGREEMENT.pdf).

<br />

> ℹ️ About Processing #1
>
> Processing #1 is essential to the functioning of the product (subscriptions), and cannot be turned off. If the user has agreed to your Terms & Conditions and activates a subscription, you have implicitly authorized that.\
> For details, consult the full Data Processing Agreement. (See link at end.)

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

###

## Processing #2 - Analytics / Aggregated Measurement

* **Purpose**: Capture aggregate UX metrics (screen views, navigation funnels) without personally identifying users.

<br />

* **When to revoke?**
  * if the Processing is necessary for the purposes of the Data Controller's legitimate interest => only revoke it if the user has *opted-out*
  * if the Processing requires the User explicit consent => revoke it if the user *has not given their consent*.

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
  * [UI / SDK events](ui-sdk-events) will continue but only with the `anonymous_user_id` (randomly generate identifier), making them unlinkable to a real user
  * Non-essential built-in user attributes (e.g. optional navigation counters) will be disabled.
  * Local trackers used for analytics are cleared.

<br />

> ❗️ Fully disabling UI / SDK events
>
> In certain sensitive contexts — such as apps targeting children or privacy-focused apps like VPNs — you may choose to completely disable all UI and SDK event tracking.
>
> When this option is enabled, no analytics data will be collected, making it impossible for the Purchasely Platform to measure displayed Screens, Paywalls, or conversion rates.\
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
  * if the Processing is necessary for the purposes of your legitimate interest => revoke it if only if the user has *opted-out*.
  * if the Processing requires the User explicit consent => revoke it if the user *has not given their consent*.

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
  * If an audience rule depends solely on optional attributes, the user may fall into a default group (*Everyone else*)
  * Screen logic that uses only essential attributes will still function normally.

    <Image alt="Note: if an audience only relies on `essential` user attributes, it will still be possible for a user with Processing #3 revoked to match it" align="center" src="https://files.readme.io/d2303b6ac62df96b4b7bb237f01cca5dec24d0c525899a9d9eac2ff07d61b2c3-image.png" />

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

* **Purpose**: Automatically trigger in-app experiences (e.g. promotion banners) without explicit user action, upon the app start\
  📚 See the [documentation about Campaigns](campaigns).

<br />

* **When to revoke?**
  * if the Processing is necessary for the purposes of your legitimate interest => revoke it if only if the user has *opted-out*.
  * if the Processing requires the User explicit consent => revoke it if the user *has not given their consent*.

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

## Disabling All Non-Essential Processing

* **Purpose**: Revoking all non essential processing at once when user chose to reject non essential processing

<br />

* **How to revoke**: You can opt to revoke all revokable processing in one go::

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

* **Effect**: This disables Processing #2, #3, and #4 simultaneously.

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
