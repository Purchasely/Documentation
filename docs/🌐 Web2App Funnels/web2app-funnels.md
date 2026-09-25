---
title: Web2App Funnels
excerpt: >-
  Start the onboarding on the web, finish it in the app. Why the best apps run
  Web2App funnels, and why Purchasely is the right place to build them.
deprecated: false
hidden: false
link:
  new_tab: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Next, see exactly what a Web Flow can and cannot contain.
  pages:
    - slug: web2app-capabilities-and-limitations
      title: What you can and cannot build
      type: basic
---
**Web2App Funnels** let you acquire subscribers on the web and hand them over to your app. A visitor clicks an ad, lands on a web funnel you built in the Purchasely Console, answers a few questions, sees a paywall, pays with Stripe, and opens your app with an active subscription. No app release, no App Store fees, and the whole context of the visit follows the user into the app.

This page explains why this model has become the default for paid acquisition, and what Purchasely brings to it. If you already know why, jump straight to [What you can and cannot build](web2app-capabilities-and-limitations).

## The best apps have already moved

Onboarding has become hybrid: it starts on the web and finishes in the app. Two changes made this possible. Apple's App Tracking Transparency broke the feedback loop of paid acquisition on iOS, so apps lost the ability to know which campaign brought a user. Then the Epic ruling in the US and the DMA in Europe cracked the stores' monopoly on payments, so apps can now link out to the web and process payments at card-processing fees.

The result is visible in the numbers.

| Signal                                                | Figure                         |
| ----------------------------------------------------- | ------------------------------ |
| Top-grossing apps running Web2App funnels             | 82%, up from 46% two years ago |
| Revenue coming from the web, for apps that scaled it  | Up to 90%                      |
| US App Store consumer spending, Q2 2026 vs Q2 2025    | Down 6%                        |
| Lifetime value of a web subscription vs an in-app one | About 2×                       |

Noom pioneered the playbook in 2017 with web quizzes. Flo, Headway, BetterMe, Opal and most top-grossing health, wellness and education apps run it today.

## Fees are the trigger, not the reason to stay

Everyone starts a Web2App project because of the fees: moving your best-converting channel from a 30% store commission to card-processing fees is margin you can reinvest straight into acquisition. But the apps that stay do it for what the web gives back.

* **First-party attribution.** The ad click lands on your page. You know exactly which campaign brought the visitor, and conversion signals go back to Meta, TikTok or Google in seconds instead of days with SKAdNetwork. Your campaigns optimize on clean, fast data.
* **One funnel per campaign.** Because you know the campaign, the funnel can match the promise of the ad: same message, same creative, same job-to-be-done. Someone who clicked a "sleep better" ad and someone who clicked a "reduce anxiety" ad should never see the same onboarding.
* **Daily iteration.** A web funnel changes in minutes. No app release, no store review. Run A/B tests on screens and prices and ship the winner the same day.
* **Higher lifetime value.** Annual plans dominate web checkouts and retain better. Web subscriptions carry roughly twice the LTV of in-app ones.

This is why the structure of the best apps has changed: **one in-app onboarding**, optimized for organic users who arrive from the store with high intent, and **dozens or hundreds of Web2App funnels**, one per campaign. The top earners run more than a hundred web funnels.

## The hard part is the handover

Downloading the app remains the end goal: that is where the service lives and where retention is built. The funnel is only the intent onboarding. Once the user lands in the app, the first session has to keep the promise the funnel made, and your CRM has to turn it into a habit.

Apps lose users at two moments during that handover.

* **The redemption gap.** About 15% of subscriptions bought on the web are never activated in the app. The user paid, never got the service, churns by definition and often asks for a refund.
* **The false restart.** The user just answered ten questions on the web, and the app welcomes them with the same onboarding, from step one. All the momentum the funnel built is gone.

Seamless propagation of the subscription and of everything the user told you is the new retention battleground. It is also exactly what Purchasely is built for.

## Why build Web2App Funnels with Purchasely

**One platform for the web and the app.** Web Flows are built with the same Screen Composer as your in-app flows and paywalls. A given Screen can be used in both: it renders in HTML on the web and natively in your app. Design once, run everywhere, and keep one consistent brand and one set of analytics.

**A handover that just works.** After the Stripe checkout, the user opens your app from the success screen or from an email. The subscription is activated in the app in one tap, without any sign-in, and the SDK confirms it to the user. If the link has expired, a new one is sent automatically. See [After the purchase](web2app-redemption).

**The context travels with the user.** Quiz answers and text inputs are stored as user attributes, can be forwarded to your backend and are available in the app the moment the subscription is redeemed, alongside the campaign UTM parameters. Use them to skip the questions already answered, personalize the first session, or trigger a dedicated welcome [Campaign](web2app-sdk-integration) on the `REDEMPTION_CONSUMED` event.

**Everything a growth team needs, no code required.**

* Screens built in the Composer or generated from a prompt, with custom HTML and AI-generated components such as spin wheels or scratch cards.
* Stripe Checkout with cards, Apple Pay and Google Pay, multi-currency prices, and Stripe as merchant of record if you want it.
* Meta, Google Ads, TikTok and X integrations with server-side conversions.
* A/B tests on UI and prices, live and sandbox URLs for every flow, your own subdomain and email domain.
* Purchase events and webhooks that carry the `web2app` channel and the full attribution, so your data warehouse and your CRM know where every subscriber came from.

## How it works

1. **Set up once.** Connect Stripe, map your plans to Stripe prices, configure your domain and your app scheme, plug your ad platforms. See [Setup 1 · Connect Stripe](web2app-setup-stripe).
2. **Build or generate a Web Flow.** Chain landing, quiz, input and paywall Screens. The Stripe checkout and the Redeem step are added for you. See [Build a Web Flow](web2app-build-a-web-flow).
3. **Test in sandbox.** Run the funnel end to end with a Stripe test card and redeem in your app. See [Test and go live](web2app-test-and-go-live).
4. **Publish and iterate.** Point your campaigns to the live URL, read the funnel, A/B test, repeat.

<Callout icon="📘" theme="info">
  ### Getting access

  Web2App Funnels must be enabled on your Purchasely account. See [Getting access to Web2App Funnels](web2app-getting-access) to activate them with your Customer Success manager or Account Executive.
</Callout>
