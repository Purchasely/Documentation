---
title: Privacy, security & compliance
excerpt: >-
  GDPR roles, DPA, the data processing register and consent API, children-oriented
  apps, certifications, and data export and deletion.
deprecated: false
hidden: false
metadata:
  title: 'FAQ: Privacy, security & compliance'
  description: >-
    Purchasely GDPR roles and DPA, the data processing register and the
    revokeDataProcessingConsent API, COPPA and children-oriented apps,
    certifications and trust center, and how to export or delete a user's data.
  robots: index
next:
  description: ''
---
# What are the respective roles under GDPR?

| Role                        | Who       | What it means                                                                                    |
| :-------------------------- | :-------- | :----------------------------------------------------------------------------------------------- |
| **Data Controller**         | You       | You decide which processing is lawful and inform your users accordingly.                          |
| **Data Processor**          | Purchasely | We process data strictly under your instructions and in compliance with applicable law.           |

Our Data Processing Agreement is public: [PURCHASELY-DATA-PROCESSING-AGREEMENT.pdf](https://www.purchasely.com/hubfs/PURCHASELY-DATA-PROCESSING-AGREEMENT.pdf)

📚 [Managing user privacy](privacy-settings)

<br />

# What data processing do you perform, and what can I switch off?

The register is exposed directly in the SDK since **v5.4**, with the legal basis and revocability of each processing:

| Processing | Purpose                                                                       | Legal basis                                | Revocable |
| :--------- | :---------------------------------------------------------------------------- | :----------------------------------------- | :-------- |
| **#1**     | Operations strictly necessary for the service to function                     | Performance of contract                    | No        |
| **#2**     | Audience measurement, statistical analysis, journey optimization              | Legitimate interest **or** consent         | Yes       |
| **#3**     | Personalization of the journey and of the offers presented                    | Legitimate interest **or** consent         | Yes       |
| **#4**     | Recommendation of offers displayed spontaneously (Campaigns)                  | Legitimate interest **or** consent         | Yes       |

The API is granular, and you wire your CMP to it:

```swift Swift
Purchasely.revokeDataProcessingConsent(for: [.allNonEssentials])
// or precisely: .analytics, .identifiedAnalytics, .personalization, .campaigns, .thirdPartyIntegrations
```
```kotlin Kotlin
Purchasely.revokeDataProcessingConsent(setOf(PLYDataProcessingPurpose.AllNonEssentials))
```

> 🚧 The SDK is not wired to your CMP automatically
>
> Your app is responsible for translating the user's CMP choices into `revokeDataProcessingConsent` calls. There is no direct interface between the two.

[User attributes](user-attributes-list) are typed `essential` or `optional`. When personalization is revoked, `optional` attributes are wiped and ignored in Audience matching, while `essential` ones keep working.

📚 [Managing user privacy — full guide](privacy-settings)

<br />

# Do you collect email addresses, phone numbers or any PII?

No. Purchasely never asks for an email address or a phone number. The user identifier you pass is an opaque string of your choosing, and an internal UUID is enough — see [Users & identity](faq-users-and-identity).

If you push [custom user attributes](custom-user-attributes), you control what goes in them. Nothing requires directly identifying data.

> ❗️ Do not use an email address as the user ID
>
> It would bring PII into the platform for no functional benefit.

<br />

# Our app targets children or families — is there a compliant mode?

Yes. There is a maximal setting that stops all UI / SDK event collection:

```swift Swift
Purchasely.revokeDataProcessingConsent(for: [.analytics])
```
```kotlin Kotlin
Purchasely.revokeDataProcessingConsent(setOf(PLYDataProcessingPurpose.Analytics))
```

This is exactly the mode intended for apps targeting children, and for privacy-focused apps in general.

> ⚠️ The trade-off is explicit
>
> Paywall displays are no longer measured, so you lose the conversion dashboards and the A/B test reports. Revenue and subscription data are unaffected, since those come from server events. Use this setting deliberately, not as a default.

Store-level protections for families are handled natively:

* **Ask to Buy / PSD2** — the `IN_APP_DEFERRED` event plus a fully localizable native "Waiting for approval" screen (`ply_modal_alert_in_app_deferred_*`). The entitlement is opened only once the purchase is actually approved.
* **Family Sharing** — `is_family_shared` on every server event, and `FAMILY_SHARED_REVOKED` when the owner removes access. A shared subscription attaches to the member automatically on their first app open, with nothing to implement. We receive **no data about the payer** — the stores do not transmit it.

📚 [Localizing your app](localizing-your-app) · [Server event attributes](server-events-attributes) · [Lifecycle events](lifecycle-events)

<br />

# What certifications and compliance frameworks do you hold?

Purchasely is compliant with **GDPR, COPPA and CCPA**, and is **SOC 2 certified**.

* Security overview: [purchasely.com/security](https://www.purchasely.com/security)
* Documents and certifications (Trust Center): [Purchasely Trust Center](https://app.vanta.com/purchasely.com/trust/grnmamthf8r38yu2xtlmwu)

<br />

# Where is the data hosted, and do you have a document for our DPIA?

Our certifications, security policies and the current list of subprocessors are published in the [Trust Center](https://app.vanta.com/purchasely.com/trust/grnmamthf8r38yu2xtlmwu), and the contractual commitments — including hosting locations, subprocessors, breach notification and deletion deadlines — are in the [Data Processing Agreement](https://www.purchasely.com/hubfs/PURCHASELY-DATA-PROCESSING-AGREEMENT.pdf).

For a DPIA you will usually also want the technical and organizational measures (TOMs) summary and the hosting regions in writing for your specific contract. **Request those from your Purchasely contact or our DPO** — they are provided as part of the security review, not published on this page.

<br />

# How do I export or port a user's data?

Continuously, through the channels you already have:

* **[S2S webhooks](webhook)** — real-time JSON on the whole lifecycle (entitlement events, 27 lifecycle events, offer events, `TRANSACTION_PROCESSED`). The most complete channel: you replicate the data on your side permanently.
* **[Third-party forwarding](engagement-crm)** to your analytics and CRM tools.
* **Client API** at `https://api.purchasely.io/client/mobile_applications/{app_id}` with a Bearer token, for programmatic operations.
* **CSV exports** from the [Console dashboards](subscription-base-evolution).

📚 [Analytics & data](faq-analytics-and-data)

<br />

# How do I delete the data of one specific user?

Call the user deletion request endpoint:

```shell
curl --request POST \
  --url https://s2s.purchasely.io/user_deletion_requests \
  --header 'X-API-KEY: <your app API key>' \
  --header 'Authorization: <HMAC-SHA256 signature of the body>' \
  --header 'Content-Type: application/json' \
  --data '{"user_id":"12345"}'
```

The request is signed with your Client shared secret, processed asynchronously, and returns a deletion request identifier that support can use to trace it. It covers the whole chain:

* irreversible pseudonymization of the user identifier on all subscription events, including subscriptions transferred from or to that user,
* deletion of the stored webhook history and the associated tokens,
* erasure of the IP addresses of the attached devices,
* purge of the stored purchases in the real-time database,
* deletion marking of the user.

> ❗️ Throttling
>
> 50 requests per 10 minutes. Beyond that you get a `429` and are blocked for 10 minutes. Contact us if you need a higher limit.

📚 [User deletion request — full reference](user-deletion-request)

<br />

# Are third-party integrations a privacy concern for us?

Forwarding uses the identifier **you** provide, so it is the downstream tool that has to resolve it, not us. If a user declines that processing, switch it off entirely:

```swift Swift
Purchasely.revokeDataProcessingConsent(for: [.thirdPartyIntegrations])
```
```kotlin Kotlin
Purchasely.revokeDataProcessingConsent(setOf(PLYDataProcessingPurpose.ThirdPartyIntegrations))
```

Subscription lifecycle processing itself (Processing #1) cannot be turned off — it is what makes subscriptions work — but its forwarding to external systems can.

📚 [Managing user privacy](privacy-settings)
