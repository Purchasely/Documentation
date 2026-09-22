---
title: What you can and cannot build
excerpt: >-
  A clear map of what a Web Flow can contain, what the platform handles for you,
  and what is out of scope today.
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: 'Next, see how to get access to Web2App Funnels for your app.'
  pages:
    - type: basic
      slug: web2app-getting-access
      title: Getting access to Web2App Funnels
---
A **Web Flow** is the object you create in the Purchasely Console to run a Web2App Funnel. It is a sequence of **Screens** hosted on the web, ending with a Stripe checkout and a step that sends the new subscriber into your app. This page lists what a Web Flow can do today, and what it cannot, so you can plan your funnel before you start building.

> 📘 Web Flows vs In-App Flows
>
> Web Flows and In-App Flows are built with the same Screen Composer. The same Screen can be used in both: it is rendered in HTML on the web and natively inside your app. Only the flow settings differ (web URLs, transition animations, custom JavaScript).

## The anatomy of a Web Flow

A typical Web2App Funnel chains the following steps. All of them are Screens you design, except the checkout and the redemption step which Purchasely generates for you.

| Step | What it is | Built with |
| --- | --- | --- |
| **Landing & onboarding screens** | Value proposition, social proof, feature highlights, loading or "personalizing your plan" screens. | Any Screen from the Composer, or a Screen generated from a prompt. |
| **Quiz** | Single or multiple-choice questions. Each answer is saved as a **user attribute** and can drive the next step of the flow. | Quiz component and options pickers. |
| **Text input** | A free text field (name, goal, email…) saved into a user attribute. | Text input component. |
| **Paywall** | Plan pickers, prices in the visitor's currency, comparison tables, countdowns, reviews. | Any paywall Screen with a purchase action. |
| **Checkout** | Secure payment page embedded in your funnel, with cards, Apple Pay and Google Pay. | Stripe Checkout, generated automatically. Not an editable Screen. |
| **Redeem step** | Success screen that opens your app and activates the subscription. A receipt containing the redemption link is also emailed to the customer's billing address, from the sender address of your choice, so they can claim their subscription on the device of their choice at any time. | Generated automatically as soon as a Screen contains a purchase action. |

Screens can be personalized with the attributes collected earlier in the flow (for example, a plan name that echoes the goal a visitor selected), and transitions between web steps use full-screen animations (Fade, Slide, Tiles, Curtain or none).

## What you can do

**Design**

* Build Screens in the Screen Composer, or **generate a Screen from a prompt** directly in the Console.
* Reuse a Screen on both web and mobile: it renders in HTML on the web and natively in your app.
* Add **Custom HTML** components with your own markup and JavaScript, and wire up to five actions from your markup to the flow.
* Use **AI Generation** inside a Custom HTML component with ready-made presets: quiz, plan picker, spin wheel, scratch card, reveal card, or free-form.
* Add **custom JavaScript** at flow or Screen level.
* Localize Screens; Stripe picks the right currency from your multi-currency prices.

**Monetization**

* Sell any Purchasely plan mapped to a **Stripe price**, with multi-currency support.
* Accept cards, **Apple Pay** and **Google Pay**.
* Let Stripe act as the merchant of record with **Managed Payments** (tax collection and remittance handled by Stripe).
* Run each flow on a **live URL** and a **sandbox URL** that uses Stripe test mode.

**Growth**

* Serve funnels from your own **subdomain** (for example `start.yourapp.com`). Without one, funnels run on `web.purchasely.io`.
* Forward funnel events to **Meta, Google Ads, TikTok and X**, with server-side conversions for Meta and TikTok.
* Keep UTM parameters and click IDs from the first visit to the purchase, and get them back in webhooks.
* **A/B test** Web Flows: UI variants as well as price variants.
* Send purchase and lifecycle emails from your own **email domain**.

**In the app**

* Activate the web subscription in your app **without any sign-in**: the subscription is transferred to the app user when the redemption link opens the app, from the success screen or from the receipt email.
* React to the activation with the SDK delegate to display a tailored welcome experience, or trigger a **Campaign** on the `REDEMPTION_CONSUMED` event.

## What you cannot do (yet)

| Not possible today | What to do instead |
| --- | --- |
| Add a custom **sign-in or sign-up** step, or create an account during the funnel. | Visitors stay anonymous on the web. The subscription is linked to the app user through the redemption link; you can identify the user in the app afterwards. |
| Publish a Web Flow **without a payment step**. | Every Web Flow ends with a Stripe checkout followed by the Redeem step. It's possible to link a web landing page created with Purchasely to your app stores product pages, but downloads & effective opening will be tracked only if a subscription is attached to the redemption link. |
| Use a **payment provider other than Stripe**. | Connect a Stripe account. |
| Apply **Stripe promotion codes** or **introductory / trial periods** configured in Stripe. | Price your offer directly in the Stripe price. Intro and trial periods are on the roadmap. |
| Display funnels in a **tablet or desktop layout**. | Web Flows always render in a smartphone layout, whatever the device. On larger screens the funnel keeps its smartphone width and is centered on the page. Tablet and desktop layouts are on the roadmap. |
| Rely on **deferred deep linking or device fingerprinting** to match the web visitor with the app user. | Purchasely uses a redemption link, which is deterministic. See [After the purchase](web2app-redemption). |

> 👍 Not sure your use case fits?
>
> Reach out to your Customer Success manager: several of these limitations are being lifted as the feature evolves.
