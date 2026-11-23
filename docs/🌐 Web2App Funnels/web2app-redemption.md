---
title: 'After the purchase: activating the subscription in the app'
excerpt: >-
  How a web subscriber lands in your app with an active subscription: the
  success screen, the receipt email, the redemption link and what happens in the
  app.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: 'Next, the SDK side: what your app needs, and how to tailor the welcome experience.'
  pages:
    - type: basic
      slug: web2app-sdk-integration
      title: SDK integration
---
The payment is only half of a Web2App Funnel. The other half is the **handover**: the subscriber must open your app and find their subscription active, without typing anything. Purchasely does this with a **redemption link**, delivered on the success screen and by email, that the SDK consumes when it opens the app. This page describes the journey and its edge cases; the [SDK integration](web2app-sdk-integration) page covers the code.

## The journey

1. **Checkout completed.** Stripe confirms the payment. Purchasely creates the subscription, owned for now by the anonymous web visitor.
2. **Success screen.** The funnel lands on the **Redeem step**, which always presents two steps: **step 1**, the App Store and Play Store links to install your app if it is not there yet; **step 2**, the **redemption button** that opens the app and activates the subscription. On a phone, tapping the button opens your app directly through its custom URL scheme.
3. **Receipt email.** In parallel, Purchasely emails the customer a receipt at the email address typed at checkout. It carries your app name and icon, the plan, and the same two steps as the success screen: the **App Store and Play Store links** to download the app, then the **redemption link** to activate the subscription. The subscriber can use it later, on any device.
4. **The app opens.** The SDK detects the redemption link, calls Purchasely, activates the subscription for this app user and refreshes their entitlements. It shows a confirmation, and your app can react to it.

> 📘 No sign-in required, but identify first if you have accounts
>
> The subscriber does not need an account to activate the subscription: the link is enough, and Purchasely attaches the subscription to the app user who opened it. If your app has accounts, make sure the user is **signed in before the link is consumed**: the subscription is then attached to their account, or transferred to it automatically if it was created for an anonymous web visitor, and your webhooks report the transfer, exactly as for in-app subscriptions. A link consumed while the user is anonymous leaves the subscription on the anonymous user, and a later sign-in does not move it. See [SDK integration](web2app-sdk-integration) for the recommended pattern.

## The redemption link

The link is unique to the subscription and works **once**: when it is consumed, the subscription is attached to the app user who opened it.

| Rule | Detail |
| --- | --- |
| **Validity** | A link is valid for **3 days** after it is issued. |
| **Expired or already-used link** | When the subscriber opens an expired or already-used link, from the email or from the success screen, Purchasely **automatically emails a new link** to the address entered at checkout and tells the subscriber to check their inbox. Nothing to do on your side. |
| **Any device** | The link works on the device where the purchase was made and on any other one, for example a purchase on desktop and an activation on the phone, from the email. |
| **App not installed** | Step 1 of the success screen links to the App Store and Play Store; the email carries the same store links. Once the app is installed, the subscriber taps the redemption button, or opens the link from the email, to activate. |
| **Subscription no longer active** | If the subscription was cancelled or refunded before activation, the link shows an *unavailable* page and no email is sent. |

The receipt email is sent from `redemption@purchasely.io` with your app name as sender, or from your own address once your [email domain](web2app-setup-domains-and-wallets) is verified. For sandbox purchases, its subject starts with `[Sandbox]`.

## Reminder emails

Some buyers close the receipt email and never open the app. Purchasely can email the redemption link again. This feature is optional and is **off by default**.

To turn it on, open the **Email domain** step of your Web2App Funnels setup in the Console. Switch on **Send redemption reminders**, then click **Save** on the step. Purchasely emails the redemption link again 1 day and 3 days after the purchase. It targets buyers who have not redeemed yet.

* Purchasely sends a reminder only for an active subscription that nobody has redeemed yet. It sends the reminder to the email address entered at checkout.
* A reminder uses the same layout as the receipt email: app name, icon, store links and redemption link. It has its own subject and intro.
* The switch applies to the reminders not sent yet.
* The link in each reminder is valid for 3 days.

## Get the redemption link from your backend

To send the redemption link in your own emails, CRM or support tools, call the Management API:

```http
POST /management/v1/applications/{application_id}/purchasely_subscriptions/{id}/redemption_link
```

`{id}` is the subscription `id` that the subscriptions list returns.

In the API key permissions, under **Look-ups**, turn on **Edit** for **Subscriptions**. This grants the scope `lookups.subscriptions:edit`. See [Management API](https://docs.purchasely.com/docs/management-api). The full contract is in the [API Reference](https://docs.purchasely.com/reference/post_management_v1_applications_application_id_purchasely_subscriptions_id_redemption_link).

```json
{
  "redemption_link": {
    "url": "...",
    "deeplinks": { "ios": "...", "android": "..." },
    "expires_at": "..."
  }
}
```

* `url` is the same web link as in the email. A deeplink is `null` when the platform or its app scheme is not set.
* The returned link is valid for 3 days from the call.
* Purchasely sends no email for this call.
* Anyone who opens a valid link can redeem the subscription. Send the link only to the buyer.

| Error | Meaning |
| --- | --- |
| `404 NOT_FOUND` | The application has no subscription with this ID. |
| `409 ALREADY_REDEEMED` | Someone already redeemed the subscription. |
| `422 NOT_REDEEMABLE` | The subscription is not active, does not come from a Web2App Funnel, or has no redemption link. |
| `422 LINK_LIMIT_REACHED` | Too many redemption links were created for this subscription. Try again later. |

## Find buyers who have not redeemed

* **Console:** in the **Subscriptions** list, use the **Redemption** filter. The values are **Redeemed**, **Not redeemed** and **All redemption statuses**.
* **Management API:** add `redemption_status=redeemed` or `redemption_status=not_redeemed` to `GET /management/v1/applications/{application_id}/purchasely_subscriptions`.

**Not redeemed** also lists subscriptions that are no longer active.

## What happens to the subscription

| Situation in the app | Result |
| --- | --- |
| The app user is **anonymous** | The subscription is attached to this anonymous user. A later sign-in does **not** transfer it: to attach it to an account, the subscriber must open a fresh redemption link while signed in. To avoid this, identify the user before the link is consumed, see [SDK integration](web2app-sdk-integration). |
| The app user is **identified** (your app already called the SDK's login method) | The subscription is attached to their account directly. If it had been created for an anonymous web visitor, it is transferred automatically and your webhooks report the transfer. |
| The user **already owns** the subscription (same link opened again) | Entitlements are refreshed, nothing else changes. |

From then on, the subscription behaves like any Purchasely subscription: it appears in the user's subscriptions in the SDK, in the Console, in your dashboards, and its lifecycle is reported in your [webhooks](web2app-events-and-webhooks) with the `web2app` channel. Renewals, cancellations and refunds come from Stripe and are handled by Purchasely.

## What the subscriber sees in the app

The SDK handles the activation and shows a short confirmation. Three outcomes exist:

| Outcome | Message shown by the SDK |
| --- | --- |
| **Success** | The subscription is active. |
| **Expired link** | The link has expired and a new one was sent to the checkout email address, shown partially masked. |
| **Invalid link** | The link does not match this app or its subscription is no longer available. |

You can replace these messages with your own experience, for example a welcome Screen or a sign-up prompt: see [SDK integration](web2app-sdk-integration).

## The context follows the user

Along with the subscription, the app receives the **context of the web journey**: the UTM parameters of the campaign, the click identifiers and the user attributes collected in the funnel that you chose to keep. They are available in the SDK right after the activation, so the first session can skip the questions already answered and start where the funnel stopped.

## Troubleshooting

| Problem | Cause and solution |
| --- | --- |
| The button on the success screen does nothing. | The app is not installed, or the app scheme in the Console does not match the one declared in the app. See [Setup 3](web2app-setup-mobile-app). |
| The app opens but nothing happens. | The app runs an SDK older than 6.1, or the URL is not forwarded to the SDK. See [SDK integration](web2app-sdk-integration). |
| The subscriber says the link has expired or was already used. | Expected: a new email was sent automatically to the checkout address. Ask them to open the latest email. |
| A buyer paid but never opened the app. | Select **Not redeemed** in the **Redemption** filter. Get the link with the Management API, then send it to the buyer. Turn on [reminder emails](#reminder-emails) for the next buyers. |
| The subscriber never received the email. | Check the spam folder and the address typed at checkout. The email is sent within a minute of the purchase. |
| The subscription is on the wrong account, or on no account. | The link was consumed while another user, or no user, was signed in on the device. Have the subscriber open a fresh redemption link from the email while signed in with the right account. |
