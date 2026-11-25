---
title: Continue the web journey in the app
excerpt: >-
  The context of the web funnel travels with the user. How to use the quiz
  answers and the campaign parameters to match the in-app experience with what
  the user saw on the web.
deprecated: false
hidden: false
link:
  new_tab: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Next, the events and webhooks that report web purchases.
  pages:
    - slug: web2app-events-and-webhooks
      title: Events, attribution & webhooks
      type: basic
---
A Web2App funnel makes a promise: the user told you their goal, picked a plan and paid. If the app then greets them with a generic onboarding and the same questions, that momentum is lost.

With Purchasely, **the context of the web journey travels with the user**. When the subscription is activated in the app, the SDK restores what the funnel learned, and you use it with the same tools as any in-app experience: Audiences, Campaigns, Flows and Screens. No backend work, no custom matching logic.

## What travels with the user

| Context                    | Where it comes from                                                                     | In the app                                                              |
| -------------------------- | --------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| **The subscription**       | The Stripe checkout.                                                                    | Active as soon as the redemption link is consumed.                      |
| **Campaign parameters**    | The `utm_*` parameters of the URL the visitor landed on.                                | Restored as built-in user attributes (`utm_source`, `utm_campaign`, …). |
| **Quiz answers and inputs** | The quiz and text input components of the Web Flow, when saved to the user's profile.  | Restored as user attributes.                                            |

The SDK writes these attributes **before** it refreshes the entitlements and emits `REDEMPTION_CONSUMED`. Everything that follows (events, Audience targeting, Campaign triggers) already knows where the user comes from and what they answered.

<Callout icon="🚧" theme="warn">
  ### Keep the answers you want to use in the app

  By default, an answer collected on the web only drives the Web Flow. To make it available in the app, tick the option that saves the user attribute to the profile on the quiz or the text input. See [Build a Web Flow](web2app-build-a-web-flow).
</Callout>

## Match the app experience with the funnel

**Welcome web subscribers with a dedicated experience.** From SDK 6.2, create a [Campaign](campaigns) triggered on _Redemption consumed_ and pick the Screen or the In-App Flow to display. The user lands in the app and immediately sees a welcome built for web subscribers, without any code.

**Skip the questions already answered.** In an [In-App Flow](flows), use the restored user attributes in the transition conditions: a user who chose "Sleep better" on the web goes straight to the sleep program instead of answering the goal question again. See [Tailoring Flows to the user insights](tailoring-flows-to-user-insights).

**One in-app experience per campaign.** Build [Audiences](audiences) on the restored attributes, for example `utm_campaign` or the goal picked in the funnel, and map each Audience to its own Screen or Flow on a Placement. The user who clicked the "reduce anxiety" ad sees the anxiety onboarding, on the web and in the app.

**Personalize the Screens themselves.** Use [Conditional Visibility](conditional-visibility#user-data) to show or hide components based on the user attributes: the right benefit list, the right program, the right testimonial.

**Reuse the same Screens.** Web Flows and In-App Flows are built with the same Screen Composer, and a Screen renders in HTML on the web and natively in the app. The app can pick up the design, the copy and the tone where the funnel left off.

## Example

A meditation app runs a "Sleep better" campaign on Meta.

1. The ad points to a Web Flow with `utm_campaign=sleep_better`. The quiz saves `goal = sleep` and `experience = beginner` to the user's profile.
2. The visitor subscribes with Stripe, installs the app and taps the redemption button.
3. The SDK activates the subscription and restores `utm_campaign`, `goal` and `experience` as user attributes.
4. A Campaign triggered on _Redemption consumed_ displays a welcome In-App Flow. Its first transition reads `goal`: the user skips the goal question and lands on the beginner sleep program.

## What you need

| Requirement                                                              | Details                                         |
| ------------------------------------------------------------------------ | ----------------------------------------------- |
| SDK **6.1** or above, with deeplinks forwarded to the SDK                | [SDK integration](web2app-sdk-integration)      |
| SDK **6.2** or above for the _Redemption consumed_ Campaign trigger      | [SDK integration](web2app-sdk-integration)      |
| UTM parameters on the URLs used in your ads                              | [Events, attribution & webhooks](web2app-events-and-webhooks) |
| Quiz answers and inputs saved to the user's profile                      | [Build a Web Flow](web2app-build-a-web-flow)    |

The same context is also sent to your backend: web purchase events carry the `web2app` channel and the attribution. See [Events, attribution & webhooks](web2app-events-and-webhooks).
