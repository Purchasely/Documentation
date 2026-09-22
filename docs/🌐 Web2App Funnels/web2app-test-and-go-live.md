---
title: Test and go live
excerpt: >-
  Run one full purchase through your sandbox funnel, redeem it in your app, and
  check the list before sharing the live URL in your campaigns.
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: 'Next, understand what happens after the purchase, from the success screen to the app.'
  pages:
    - type: basic
      slug: web2app-redemption
      title: 'After the purchase: activating the subscription in the app'
---
Every Web Flow has two URLs. The **sandbox URL** runs the exact same funnel against Stripe test mode, so you can go through the whole journey, pay with a test card and activate the subscription in your app, without charging anyone. The **live URL** is the one you give your campaigns. This page walks through the end-to-end test and the checks to do before going live.

## The end-to-end sandbox test

The last section of **Web2App → Setup**, *5. Test your funnel*, guides the test and detects its steps automatically. You can also run it by hand from any sandbox URL.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/test-01-section-test-your-funnel.png" alt="Web2App setup, section 5. Test your funnel with the three steps and the QR code" />

1. In the step, **select a flow**. Only Web Flows with a sandbox URL are listed.
2. **Open your sandbox funnel.** Click **Open sandbox URL**, or scan the QR code with your phone. Test on a **phone** if you want to check the redemption: the success screen opens your app, which a desktop browser cannot do.
3. **Complete a test purchase.** Go through the funnel and, on the Stripe checkout, pay with the test card below. The step switches to *Test purchase confirmed* as soon as Purchasely receives the purchase.
4. **Redeem in your app.** On the success screen, tap the button that opens your app. The app activates the subscription and confirms it. The step switches to *Redemption confirmed*.

Purchase and redemption are detected automatically once they reach Purchasely; the step polls for about fifteen minutes. If you ran the test differently, click **Mark as done**.

### The Stripe test card

Your sandbox funnel checks out on Stripe's test mode, so no real card is charged.

| Field | Value |
| --- | --- |
| Card number | `4242 4242 4242 4242` |
| Expiry | Any future date, for example `12 / 30` |
| CVC | Any three digits |
| Name, email, country | Anything. Use a real inbox for the email if you want to receive the receipt. |

<Image align="center" border={true} src="TODO-NICO-UPLOAD/test-02-stripe-test-card-4242.png" alt="Stripe checkout payment form filled with the test card 4242 4242 4242 4242" />

Other test cards let you simulate a declined payment or a 3D Secure challenge: see [Stripe's test cards](https://docs.stripe.com/testing).

### What to look at during the test

* **The funnel itself.** Each Screen, the quiz branching, the personalization of texts with the answers, the prices in your currency.
* **The checkout.** The plan, the amount and the currency match the Stripe price of the plan; Apple Pay or Google Pay appears if you registered your domains.
* **The success screen and the email.** The receipt arrives at the checkout email, with a `[Sandbox]` prefix in its subject and the same redemption link as the success screen.
* **The app.** The app opens, shows the activation confirmation, and the user is subscribed. Quiz answers you chose to keep are on the user's profile.
* **Your integrations.** The purchase appears in Meta or TikTok Events Manager, and in your webhooks with the `web2app` channel. Sandbox purchases are real events for the ad platforms: use their test tools or a test dataset.

> 📘 Sandbox tools
>
> On a sandbox URL, a discreet widget in the bottom-right corner lets you switch the **locale** and the **theme** of the funnel, and **reset the session** to start the funnel again as a new visitor. It never appears on the live URL.

Sandbox purchases create **test subscriptions**: they appear in Stripe test mode and in Purchasely flagged as sandbox, and they do not count in your revenue.

## Before you go live

| Check | Where |
| --- | --- |
| Stripe is connected in **live mode**, and every plan sold in the funnel has a **LIVEMODE** price | [Setup 1 · Connect Stripe](web2app-setup-stripe) |
| Your web domain is **Active**, or you accept to run on `web.purchasely.io` | [Setup 2 · Domains, emails & wallets](web2app-setup-domains-and-wallets) |
| Apple Pay and Google Pay domains are registered for live mode | Setup 2, step 2.3 |
| The store build with **SDK 6.1+** is live, at 100% rollout, on iOS and Android | [Setup 3 · Verify your mobile app](web2app-setup-mobile-app) |
| Ad platform integrations are configured and tested | [Setup 4 · Ad platform integrations](web2app-setup-ad-integrations) |
| The flow is **published** and **Publish flow on Web** is on | [Build a Web Flow](web2app-build-a-web-flow) |
| You went through the sandbox test on a phone, purchase and redemption confirmed | This page |

Then copy the **live URL** from the flow settings, add your UTM parameters, and use it in your ads.

## Iterating on a live funnel

| Change | Visible on the live URL |
| --- | --- |
| Editing a **Screen** used by the flow, in the Composer | Immediately after saving the Screen |
| Adding, removing or reordering **steps**, changing transitions or flow settings | After you **publish** the flow |
| Changing an **ad platform integration** | Within minutes, no republish |
| Mapping a new **Stripe price** to a plan | Within minutes, no republish |
| Activating a **web domain** | When the domain becomes Active; the previous URL keeps working |

To iterate safely, test on the sandbox URL first, or duplicate the flow and run an [A/B test](web2app-ab-tests) against the live version.

## Troubleshooting

| Problem | Cause and solution |
| --- | --- |
| The checkout does not open on the sandbox URL. | Stripe is not connected in test mode, or the plan has no SANDBOX price. |
| The checkout does not open on the live URL but works in sandbox. | The plan has a SANDBOX price but no LIVEMODE price, or Stripe is not connected in live mode. |
| *Waiting for a test purchase…* never completes. | The purchase failed or was made on the live URL. Check Stripe test mode for the payment, then click **Mark as done** if it went through. |
| *Waiting for redemption…* never completes. | The app did not open or runs an SDK older than 6.1. See [Setup 3](web2app-setup-mobile-app) and [SDK integration](web2app-sdk-integration). |
| The receipt email did not arrive. | Check the spam folder and the email typed at checkout. The subject starts with `[Sandbox]` for test purchases. |
