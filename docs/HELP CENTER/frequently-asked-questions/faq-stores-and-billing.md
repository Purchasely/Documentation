---
title: Stores & billing
excerpt: >-
  Store guideline compliance, StoreKit, Google Play Billing, offers and promo
  codes, Ask to Buy, family sharing, refunds and web checkout.
deprecated: false
hidden: false
metadata:
  title: 'FAQ: Stores & billing'
  description: >-
    How Purchasely keeps apps aligned with App Store and Play Store subscription
    guidelines, which StoreKit and Google Play Billing versions are supported,
    and how offers, Ask to Buy, family sharing, refunds and web checkout behave.
  robots: index
next:
  description: ''
---
# How do you help apps stay compliant with App Store and Play Store subscription guidelines?

* **Up-to-date store support.** StoreKit 1 and StoreKit 2, Google Play Billing up to v8. We implement store changes ahead of time, so you do not have to track them.
* **Mandatory elements built into the templates.** [Footer](footer) with Terms and Privacy Policy links, a **Restore** button (required by Apple), an "Already subscribed? Sign in" button, and prices, durations and renewal terms localized by the store itself.
* **Anonymous purchase.** Apple does not recommend forcing account creation to subscribe. Our [anonymous user handling](faq-users-and-identity) is designed precisely for that.
* **Store edge cases handled natively:** Ask to Buy, Apple promotional offers, offer codes, Google developer-determined offers, deferred purchases, family sharing, grace period.
* **Regulatory tracking.** We document and ship store and regulatory changes as they land — recent examples include Apple's [12-month commitment paid monthly](12-month-commitment), the web checkout path opened after the *Epic v. Apple* decision, and the Google Play rules update for US users.
* **[Preview](preview) and [Debug Mode](debug-mode)** let you validate the display and the compliance of your implementation before submission.

<br />

# StoreKit 1 or StoreKit 2?

StoreKit 2 is the default in SDK 6 and the recommended choice for new integrations. StoreKit 1 remains available for apps that need it.

You must declare your choice explicitly at initialization:

```swift Swift
Purchasely
    .apiKey("<<X-API-KEY>>")
    .storekitSettings(.storeKit2) // or .storeKit1
    .start { _ in }
```

📚 [StoreKit 1 vs StoreKit 2](app-store-storekit-1-vs-storekit-2) · [Migrating from StoreKit 1 to StoreKit 2](storekit2)

<br />

# Which Google Play Billing versions are supported?

Billing v4 through **v8**. SDK 6 integrates the current Billing version directly, so there is nothing to align on your side.

If you are still on **SDK 5.x** and prices stopped resolving after moving to Billing 8, you are very likely hitting the `billing` (non-KTX) vs `billing-ktx` conflict — the fix is documented in [Google Play Billing v8](google-play-billing-v8).

On React Native, Flutter and Cordova, keep the Google package on the **exact same version** as the main package.

<br />

# Why are prices shown in dollars instead of my local currency in TestFlight or sandbox?

That is store behavior, not Purchasely. Sandbox and TestFlight resolve prices against the store front of the **tester's** account, and Apple sandbox accounts frequently default to the US store front. Create a sandbox tester in the target country, or verify in production with a real account.

The same applies to Google Play license testers: the currency follows the tester account's country and payment profile.

<br />

# How are Ask to Buy and deferred purchases handled?

Natively.

* The SDK emits the `IN_APP_DEFERRED` [UI / SDK event](ui-sdk-events-list) when the user starts a deferred payment (Ask to Buy, PSD2 approval).
* A native **"Waiting for approval"** screen is shown, fully localizable through the `ply_modal_alert_in_app_deferred_*` strings — see [Localizing your app](localizing-your-app).
* The entitlement is only opened when the purchase is actually approved.

<br />

# How does family sharing work?

* Every server event carries an `is_family_shared` attribute — see [Server event attributes](server-events-attributes).
* `FAMILY_SHARED_REVOKED` fires when the subscription owner removes a member's access — see [Lifecycle events](lifecycle-events).
* A shared subscription attaches automatically to the member the first time they open the app. Nothing to implement on your side.
* We receive **no data about the payer** — the stores do not transmit it.

Family-shared subscriptions initially arrive as [unknown users](understanding-user-types) if the member has not opened the app yet.

<br />

# What offer types are supported?

| Offer type                        | Store        | Documentation                                                                    |
| :-------------------------------- | :----------- | :-------------------------------------------------------------------------------- |
| Introductory offers / free trials | Both         | [Eligibility to introductory offer](eligibility-intro-offer)                       |
| Promotional offers                | App Store    | [Configuration](promotional-offers-configuration) · [Implementation](promotional-offer-implementation) |
| Offer codes                       | App Store    | [Configuring offer codes](offer-codes-configuration-app-store)                    |
| Developer-determined offers       | Google Play  | [Configuration](developer-determined-offers-configuration)                        |
| Promo codes                       | Google Play  | [Configuring promo codes](promo-code-configuration-play-store)                    |
| 12-month commitment, paid monthly | App Store    | [12-Month Commitment](12-month-commitment)                                        |
| Stripe / web                      | Web          | [Web checkout](web-checkout) · [Stripe configuration](stripe-configuration)       |

Eligibility between an introductory offer and a promotional offer is resolved automatically, so a Screen configured with an [Offering](understanding-offer-types) shows the right price to the right user.

📚 [Understanding offer types](understanding-offer-types) · [Offer mode in the Composer](offer-mode)

<br />

# Can I sell outside the store — web checkout or external purchase links?

Yes. Web checkout has been available since SDK 5.3 and relies on [Stripe Payment Links](web-checkout). It is fully no-code, and web transactions are included in your A/B test results and revenue dashboards. Targeting a specific market (US, for example) is done natively with [Audiences](segmenting-your-user-base).

📚 [Web checkout](web-checkout) · [Stripe configuration](stripe-configuration)

<br />

# My yearly plan is generating monthly transactions — is that normal?

Yes, if the Plan has the **12-month commitment paid monthly** billing plan enabled. It is not a separate product: it is an additional billing plan on the same yearly SKU, and Purchasely serves whichever one the user is eligible for.

| Billing plan                         | The user is charged         | Example                      |
| :----------------------------------- | :-------------------------- | :--------------------------- |
| **1 Year Upfront** (always enabled)  | The full price, once a year | $119.88 today                |
| **Monthly with 12-Month Commitment** | Every month, for 12 months  | $9.99/month, $119.88 in total |

What surprises people most:

* Each monthly payment is an **independent transaction** granting one month of access, so you see 12 transactions per commitment cycle.
* If the user **cancels during the commitment, billing continues** to the end of the 12 periods and access is kept until then.
* **Upgrades** take effect immediately and end the commitment; **downgrades** are deferred to the end of it.
* The **billing grace period does not apply** to commitments — a failed monthly payment suspends access immediately and restores it on recovery.
* Apple requires you to **display both** the monthly amount and the total commitment before purchase. Combining `{{MONTHLY_AMOUNT}}` and `{{PRICE}}` in your offering copy covers that.

Purchasely automatically falls back to **1 Year Upfront** for users whose App Store country is not eligible (the US and Singapore are excluded by Apple), and for users on older OS or SDK versions. No app-side handling needed.

📚 [12-Month Commitment (Paid Monthly)](12-month-commitment)

<br />

# How do refunds and grace periods appear?

* **Grace period and billing retry** are reflected in the subscription status, and you can trigger a dedicated [Campaign](campaigns) for users in that state.
* **Refunds** produce their own lifecycle events and appear in the [subscription refunds](subscription-refunds) and [one-time purchase refunds](iap-refunds) dashboards.

📚 [Lifecycle events](lifecycle-events) · [Subscription status dashboard](subscription-status)

<br />

# We are transferring our app to another Apple or Google account — what breaks?

Store account transfers change the underlying identifiers, so this needs to be coordinated with us before you start.

📚 [Transferring Apple and Google account](transferring-apple-and-google-account) — and contact your Purchasely support channel ahead of the transfer window.

<br />

# Which stores can Purchasely validate receipts for?

Apple App Store, Google Play Store, Huawei AppGallery, Amazon Appstore, and Stripe for web transactions. Declare the stores you need at initialization:

```kotlin Kotlin
Purchasely {
    context(applicationContext)
    apiKey("<<X-API-KEY>>")
    stores(listOf(GoogleStore()))
    runningMode(PLYRunningMode.Full)
}
```

Starting **without any store** is also a first-class path in SDK 6: Screens, analytics, Campaigns, deeplinks and user attributes all work, and store-dependent APIs return an explicit `PLYError.NoStoreConfigured`.
