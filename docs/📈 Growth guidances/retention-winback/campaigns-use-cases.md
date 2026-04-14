---
title: Campaign use cases
excerpt: >-
  Ready-made campaign examples covering conversion, retention, win-back,
  engagement, and more.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---

Below are practical examples of [Campaigns](campaigns) you can set up in the Purchasely Console. Each example describes the objective, the recommended audience targeting (🎯), and any scheduling or capping tips (🗓️ / 🔂 / 🎚️).

# Conversion campaigns

## Free user conversion

Displays a specific paywall to free users who are challenging to convert into loyal subscribers.

🎯 Target non-active subscribers using the Built-in User Attribute **Total number of Screens dismissed** above a specific threshold (e.g. 20).

🗓️ To create a fear of missing out, configure the campaign as a one-time offer by setting the `impression cap` to **1 display per user**.

## Black Friday offer

Displays a Black Friday paywall featuring discounted offers.

🎯 Target every user who is not already an active subscriber.

🗓️ Schedule the campaign in advance by defining **start / end date & time**. It will automatically activate when the start date is reached and deactivate when the end date is reached.

💡 You can also associate this campaign with your key [Placements](displaying-screens-placements) (e.g. home screen, settings, feature gate) so the Black Friday paywall appears everywhere at once — without touching individual Placement rules.

## Limited-time offer following account creation

Incentivize users to try the premium product by displaying a limited-time offer right after registration.

🎯 Target all users after they created their account.

🎚️ Configure the campaign as follows:

1. Set the **exposure window** to **3 days** after the first display.
2. Set the frequency capping to **trigger campaign every 1 app session**.
3. Add a [countdown](countdown) to the paywall, configure it as a *user countdown* and map it with a custom user attribute (e.g. `signup_date`, type: Date). Define the offset to **3 days** as well. This type of timer remains consistent from one screen display to the other — the counting continues until the end date is reached.

When the paywall is displayed for the first time, it initializes both the campaign exposure window and the custom user attribute `signup_date` with the current date. As a result, the paywall countdown and the exposure window are perfectly synchronized. The user will exit the exposure window — and therefore no longer be eligible for the campaign — exactly when the countdown reaches 0.

# Engagement campaigns

## User preferences survey

Display a sequence of surveys during onboarding to fetch user preferences and personalize the user experience.

🎯 Target every user who hasn't answered the survey. You can achieve this by associating a Custom User Attribute with the survey.

# Retention campaigns

## Cancellation survey

Displays a cancellation survey to collect user insights on their cancellation reasons.

🎯 Target active subscribers with the Built-in User Attribute `Subscription status` = `Auto-renewing disabled`.

If you want to exclude free trial / intro offer users who cancel auto-renewal immediately out of caution, you can either exclude them (`Active Offer Type` ≠ `Free Trial` & `Active Offer Type` ≠ `Intro Offer`) or leverage the attribute `Next renewal date` (`Next renewal date` is in `less than X days from now`).

🔂 To prevent user fatigue, set the `impression cap` to **one display per user** or the `frequency cap` to **once per 30 days**.

## Free trial extension

Display a free trial extension paywall to free trial users who have cancelled auto-renewal, giving them a second chance to engage with your app and potentially form a habit.

🎯 Target active subscribers with: `Subscription status` = `Auto-renewing disabled` & `Active Offer Type` = `Free Trial` or `Intro Offer`.

If you want to exclude users who cancel immediately, leverage the attribute `Next renewal date` (`Next renewal date` is in `less than X days from now`).

## Temporary discounted offer following a free trial

Some users cancel during the free trial because they find the regular price too expensive. Offering them a temporary discount can bridge the gap between the introductory offer price and the regular price, getting them used to your app.

🎯 Target active subscribers with: `Subscription status` = `Auto-renewing disabled` & `Active Offer Type` = `Free Trial` or `Intro Offer`.

If you want to exclude users who cancel immediately, leverage `Next renewal date` (`Next renewal date` is in `less than X days from now`).

ℹ️ By adjusting the frequency capping, impression cap, and priority, you can alternate between this campaign and a free trial extension campaign — proposing one then the other or making them display alternately.

ℹ️ You can also display this campaign only for users who gave the reason *"The subscription is too expensive"* in a cancellation survey. To achieve that: [map your cancellation survey](mcq#1-configuring-the-survey) with a custom user attribute (e.g. `cancellation_survey`, type: String) and add the condition `cancellation_survey` = `too_expensive` in your audience. You can also create a conditional [user flow to present the retention offer right after the cancellation survey](user-surveys#how-to-create-journeys-composed-of-several-questions).

## Discounted offers to paid subscribers about to churn

Display a retention paywall reminding subscription benefits and leveraging promotional offers to propose a discounted price.

🎯 Target active subscribers with: `Subscription status` = `Auto-renewing disabled` & `Active Offer Type` ≠ `Free Trial` & `Active Offer Type` ≠ `Intro Offer`.

ℹ️ As with the previous example, you can restrict this campaign to users who cited price as a cancellation reason by leveraging a custom user attribute from a cancellation survey.

## Yearly subscribers about to churn — progressive discount strategy

**Context:** 25% of yearly subscribers cancel auto-renewal immediately out of caution — they want to ensure they get enough value before committing to another year. But half of them forget the renewal date and churn unintentionally.

To prevent that, create a set of campaigns triggered during the last month of the billing cycle, displaying paywalls with progressively increasing discounts.

**Campaign 1 — Simple reminder with premium benefits** (30 → 15 days before renewal)

🎯 `Active Subscription Plan` = `[yearly plan ID]` & `Subscription status` = `Auto-renewing disabled` & `Next renewal date` is in `less than 30 days from now` and `more than 15 days from now`.

📱 The paywall features a "Reactivate my subscription" button (a Purchase Button mapped with their current plan) that resets `Subscription status` to `Auto-renewing`.

**Campaign 2 — Loyalty discount of 10%** (15 → 5 days before renewal)

🎯 `Active Subscription Plan` = `[yearly plan ID]` & `Subscription status` = `Auto-renewing disabled` & `Next renewal date` is in `less than 15 days from now` and `more than 5 days from now`.

📱 The paywall features a 10% promotional offer. If accepted, the subscription reactivates and the promotion applies upon renewal.

**Campaign 3 — Aggressive 30% discount with countdown** (< 5 days before renewal)

🎯 `Active Subscription Plan` = `[yearly plan ID]` & `Subscription status` = `Auto-renewing disabled` & `Next renewal date` is in `less than 5 days from now`.

📱 The paywall features a 30% promotional offer and a countdown to create urgency. If accepted, the subscription reactivates and the promotion applies upon renewal.

## Billing detail update for subscribers in grace period

Display a screen informing users that their subscription could not be renewed due to a billing issue, reminding them of premium benefits and inviting them to update their billing details.

🎯 Target active subscribers with: `Subscription status` = `Grace period`.

🔂 To maximize recovery chances, this campaign should be displayed every time the app is started.

# Win-back campaigns

## Billing detail update for subscribers in billing retry

Display a screen informing users that their subscription was cancelled due to a billing issue, reminding them of premium benefits and inviting them to update their billing details to reactivate.

🎯 Target lapsed subscribers with: `Expired Subscription status` = `Billing retry`.

## Discounted offers to lapsed subscribers

Display a win-back paywall featuring a promotional offer to lapsed subscribers.

🎯 Target lapsed subscribers with: `Active subscription` = `false` & `Exp. subscription` = `true`.

You can leverage the [Built-in Expired Subscription Attributes](user-attributes-list#built-in-expired-subscription-attributes) for more precise targeting based on `Expired Sub. Status` (= `Deactivated` means voluntary churn), `Expired sub. Plan`, `Expired sub. cumulated revenue (USD)` or `Cumulated revenue (USD)`, and `Expired sub. expiry date`.

🗓️ Limited-time offers with aggressive discounts are the most effective way to win back lapsed subscribers. Leverage the `Exposure window` parameter combined with a [countdown](countdown) component inside the paywall to create a fear of missing out.

💡 Associating this campaign with relevant [Placements](displaying-screens-placements) ensures the win-back offer is visible every time the user encounters a feature gate or paywall — not just at app start.
