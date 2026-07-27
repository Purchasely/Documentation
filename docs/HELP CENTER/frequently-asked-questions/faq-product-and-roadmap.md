---
title: Product capabilities
excerpt: >-
  What the platform covers today, what is in beta, and how to influence what
  comes next.
deprecated: false
hidden: false
metadata:
  title: 'FAQ: Product capabilities'
  description: >-
    Overview of what Purchasely covers today across paywalls, growth, retention,
    web checkout and hybrid flows, what is currently in beta, and how to submit a
    feature request.
  robots: index
next:
  description: ''
---
# What does the platform cover today?

## No-code paywalls and journeys

* [Screen Composer](screen-composer) — drag & drop paywalls, published without an app release.
* [Placements](displaying-screens-placements) — a Screen per location in the user journey, swappable at any time.
* [Flows](flows) — multi-step journeys with conditional routing.
* [BYOS](byos) — insert one of your own native screens inside a Purchasely Flow.
* [Audiences](segmenting-your-user-base) — targeting on built-in and custom user attributes, plus the [Custom Audiences API](custom-audiences-api) to sync segments from your CRM or CDP.

## Experimentation

* [A/B tests](ab-tests) — up to 26 variants, deterministic assignment by hash of the user ID, Bayesian significance. Stripe web transactions are included in the results.
* [Quizzes](quiz) and post-paywall surveys to collect user insights and route on them — see [Tailoring Flows to user insights](tailoring-flows-to-user-insights).

## Retention and monetization

* [Campaigns](campaigns) — programmatic win-back, cancel survey, grace period.
* Full offer coverage: introductory offers, [promotional offers](promotional-offers-configuration), [offer codes](offer-codes-configuration-app-store), [developer-determined offers](developer-determined-offers-configuration), [promo codes](promo-code-configuration-play-store), [12-month commitment paid monthly](12-month-commitment).
* [Promoting in-app purchases](promoting-iap).

## Web and hybrid

* [Web checkout](web-checkout) — available since SDK 5.3, built on Stripe Payment Links, fully no-code, with web transactions in your A/B test results and revenue dashboards. Market targeting (US, for example) is done natively with Audiences.
* [Stripe integration](stripe-configuration) — Stripe Price IDs mapped onto Purchasely Plans, and a unified multi-store subscription view.

## Infrastructure

* Receipt validation for Apple App Store, Google Play, Huawei AppGallery, Amazon Appstore and Stripe.
* [S2S webhooks](webhook) on the whole subscription lifecycle, with retries.
* [Third-party integrations](engagement-crm) — MMPs, analytics, CRM and engagement platforms.
* [Dashboards](subscription-base-evolution) — conversion, MRR, churn, retention, revenue.

<br />

# What is currently in beta?

* **Web to App** — Stripe payment on the web with redemption of the purchase inside the mobile app.

Beta access is granted per account. Ask your Purchasely contact to be added.

<br />

# What is being worked on next?

Areas actively in development:

* **Server APIs for analytics and configuration** — programmatic retrieval of your analytics and of your Console configuration.
* **Apple Retention API** support.
* **Custom event triggers** — triggering Campaigns from your own application events.

> 📘 Where to get dates
>
> This page deliberately does not carry delivery dates, because they change. Check the [changelog](https://docs.purchasely.com/changelog) for what has shipped, and ask your account team for timing on anything listed above.

<br />

# How do I request a feature?

Through your Purchasely support or account channel. What makes a request actionable:

* the **outcome** you need, not only the mechanism you imagined,
* the **volume or revenue** it affects, so it can be prioritized,
* whether a workaround exists today and why it is not sufficient.

Feature requests coming from several customers with a quantified impact are the ones that move.

<br />

# Do you have an AI-assisted way to work with Purchasely?

Yes — the Purchasely AI plugin gives coding assistants direct access to the SDK documentation and integration workflows.

📚 [Purchasely AI plugin](purchasely-ai-plugin)
