---
title: FAQ & known limitations
excerpt: >-
  Answers to the questions that come up when launching Web2App Funnels, and the
  limits to know before you plan.
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
## Getting started

**Do I need a new app or a new Purchasely project?**
No. Web2App Funnels are enabled on your Purchasely account and used with your existing apps. The same plans, Screens, users and dashboards are used on the web and in the app.

**Do I need to change my app?**
Only if it runs a Purchasely SDK older than **6.1**, or if it does not declare a custom URL scheme yet. Nothing else: the SDK activates web subscriptions on its own. See [Setup 3](web2app-setup-mobile-app).

**Can I use my existing Stripe account?**
Yes. Install the Purchasely app on it, in live mode and in test mode. One Stripe account per Purchasely app; use a Stripe Sandbox for your staging app. See [Setup 1](web2app-setup-stripe).

**Can I start without a custom domain?**
Yes. Funnels run on `web.purchasely.io` until your subdomain is active, and keep working there afterwards.

## Flows and Screens

**Can I reuse my in-app paywalls on the web?**
Yes. A Screen renders natively in the app and in HTML on the web. Check it on the **Web** tab of the Composer: a few properties, such as text inputs and custom HTML, are web only.

**Can a funnel end without a payment?**
No. Every Web Flow ends with the Stripe checkout and the Redeem step. Downloads and app opens are tracked only when a subscription is attached to the redemption link.

**Can I add a sign-up or login step in the funnel?**
No. Visitors stay anonymous on the web. Ask them to sign up in the app when the redemption link opens it, before the SDK consumes the link, so the subscription is attached to their account. See [SDK integration](web2app-sdk-integration).

**Do my changes go live immediately?**
Screen edits do. Changes to the structure of a flow (steps, transitions, settings) go live when you publish the flow. See [Build a Web Flow](web2app-build-a-web-flow).

**Why does my spin wheel not spin in the Composer?**
JavaScript is not executed in the Console. Open the Screen's web preview or scan its QR code. See [Web components](web2app-web-components).

**Does the funnel work on desktop?**
Yes. It keeps its smartphone width, centered on the page. Tablet and desktop layouts are on the roadmap. The redemption itself happens on the phone, from the success screen or from the email.

## Payments

**Which payment methods are supported?**
Cards, and Apple Pay and Google Pay once your domains are registered in [Setup 2](web2app-setup-domains-and-wallets). Payments are processed by Stripe only.

**Can I offer a free trial or an introductory price on the web?**
Not yet. Trial and introductory periods configured on a Stripe price are ignored. Price the offer in the Stripe price itself. This is on the roadmap.

**Can I use Stripe promotion codes?**
Not yet. Build the discount into a dedicated plan and price instead, and show it with a spin wheel or a scratch card if you want the reveal effect.

**Can I sell one-time purchases or lifetime plans on the web?**
Not yet. Only subscriptions are supported.

**Who is the merchant of record?**
You, by default. Activate [Stripe Managed Payments](web2app-stripe-managed-payments) to make Stripe the merchant of record, with tax handled for you.

**How are currencies handled?**
From the Stripe price. Configure the currencies on the price, and the visitor is charged in the currency of their browser settings. See [Stripe - Configuring Subscriptions](stripe-configuring-subscriptions).

**What about renewals, cancellations and refunds?**
They happen in Stripe and are reflected in Purchasely like any subscription: same lifecycle events, same webhooks, same dashboards. Subscribers manage their web subscription through Stripe's customer portal.

## After the purchase

**How long is the redemption link valid?**
Four hours. Opening an expired or already-used link automatically sends a new one to the checkout email address. See [After the purchase](web2app-redemption).

**The subscriber bought on desktop. How do they activate on their phone?**
From the receipt email: it carries the store links and the redemption link. The link works on any device.

**What if the subscriber is already signed in in the app?**
The subscription is attached to their account directly.

**What if they sign in later, or on another device?**
A subscription activated while the user was anonymous stays with that anonymous user: a later sign-in does not move it. To attach it to an account, the subscriber opens a fresh redemption link from the email while signed in. The recommended approach is to identify the user before the link is consumed, see [SDK integration](web2app-sdk-integration).

**Can I show a specific welcome experience to web subscribers?**
Yes: with the redemption delegate in your app, or without code with a Campaign triggered on `REDEMPTION_CONSUMED` (SDK 6.2). See [SDK integration](web2app-sdk-integration).

## Measurement

**How do I tell web purchases from in-app purchases in my data?**
Every event of a web subscription carries `channel: web2app` and, when UTM parameters were present, an `attribution` object. See [Events, attribution & webhooks](web2app-events-and-webhooks).

**Which events reach Meta, TikTok, Google Ads and X?**
Page View, Screen Viewed, Purchase Tapped and Purchase, mapped to each platform's native events. Meta and TikTok also receive purchases server-side. See [Setup 4](web2app-setup-ad-integrations).

**Do sandbox purchases pollute my data?**
They are flagged as sandbox in Purchasely and land in Stripe test mode. They do count as real events for the ad platforms: use their test tools when testing.

**Can I A/B test a funnel?**
Yes, from the A/B tests section: UI variants as well as price variants through different plans. See [A/B testing Web Flows](web2app-ab-tests).

## Known limitations

| Limitation | Status |
| --- | --- |
| Free trials and introductory prices on web checkouts | On the roadmap |
| Stripe promotion codes at checkout | Not supported |
| One-time purchases and lifetime plans on the web | Not supported |
| Tablet and desktop layouts | On the roadmap; funnels render in smartphone width |
| Universal links and App Links for redemption | Not supported; custom URL schemes only |
| Apex domains and multi-level subdomains | Not supported; first-level subdomain only |
| Several Stripe accounts on one app, or changing the account after purchases | Not supported; contact your Customer Success manager |
| Sign-in or sign-up step inside the funnel | Not supported by design; see [SDK integration](web2app-sdk-integration) |
| Web analytics tab in the Console | In development |

Something missing? Reach out to your Customer Success manager.
