---
title: Free trials & intro offers with Stripe
excerpt: >-
  Offer a free trial, an introductory price or both on a Web Flow: create the
  coupon in Stripe, declare the promotional offer on the plan, pick it in the
  Screen Composer.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Next, configure your web domain, your email domain and the wallets.
  pages:
    - type: basic
      slug: web2app-setup-domains-and-wallets
      title: Setup 2 · Domains, emails & wallets
---
Web Flows can sell a subscription with a **free trial**, an **introductory price**, or both, exactly as your in-app paywalls do with App Store and Play Store offers. On the web, the discount is a **Stripe coupon** and the trial is a number of days; both are carried by a **Promotional Offer** declared on the Purchasely plan, then picked in the Screen Composer next to the plan. This page walks through the three steps.

| Step | Where | What you do |
| --- | --- | --- |
| 1. Create the coupon | Stripe Dashboard | Define the discount: percentage or fixed amount, for one or several billing cycles. Skip this step for a free trial without discount. |
| 2. Declare the Promotional Offer | Purchasely Console, Products & Plans | Add an offer to the plan with the number of trial days and/or the Stripe coupon. |
| 3. Use it on a Screen | Screen Composer | Select the plan **and** the offer on the purchase action, and display the offer tags. |

> 📘 One Promotional Offer for all stores
>
> A Promotional Offer is the same object you use for App Store and Play Store offers. An offer can carry an App Store offer ID, a Play Store offer ID and the Stripe fields at the same time, so one offer on one plan serves the same Screen in the app and on the web.

## 1. Create the coupon in Stripe

Skip this step if you only want a free trial.

In the [Stripe Dashboard](https://dashboard.stripe.com/coupons), open **Product catalog → Coupons** and click **Create coupon**.


<Image src="https://files.readme.io/af2dcb338d63563edcb2958f82a131ea7cc5ffa09c9d1cd537015d9da3c9f8be-intro-offers-01-stripe-create-coupon.png" border={true} />


<br />

1. **Name**: it appears on the customer's receipts and invoices, so write it for them, for example *Intro Offer - 30% off for 3 months*.
2. **Type**: *Percentage off* or *Fixed amount off*. A fixed amount must be defined in **every currency** of the Stripe prices it applies to; otherwise the offer does not apply to the prices in the missing currencies.
3. **Duration**: *Once* for one discounted billing cycle, or *Multiple months* for several. Leave *Forever* aside: a permanent discount is a different price, not an intro offer.
4. Leave **Use customer-facing promotion codes** off. Purchasely applies the coupon itself at checkout; visitors never type a code.
5. Create the coupon. Do it in **live mode and in test mode**, so your sandbox funnels can be tested with the offer.

> 🚧 Intro price duration is counted in billing cycles
>
> A *Multiple months* coupon discounts every invoice issued during that period. For a monthly price, *3 months* means three discounted months; for a yearly price, it means one discounted year. If the coupon is limited to specific products, the product of the plan must be among them.

## 2. Declare the Promotional Offer on the plan

In the Console, open **Products & Plans**, click the three dots of the plan and **Manage promotional offers**, then **Promotional Offer** to add one. This is the same screen as for App Store and Play Store offers, described on [Configuring promotional offers](promotional-offers-configuration).


<Image src="https://files.readme.io/19aa21677a73cf3c9eb2eef49b947bd24c9734d4f0ec4562275be3a887f3a09e-intro-offers-02-console-promo-offer-stripe-coupon.png" border={true} />

| Field | What to enter |
| --- | --- |
| **Name** | An internal name, for example *Intro Offer - 30% off for 3m*. |
| **Vendor ID** | Your own identifier for the offer, reused in the Composer and in your data. |
| **Appstore Offer ID**, **Playstore Offer ID** | Leave empty for a web-only offer, or fill them to use the same offer in the app. |
| **Stripe trial days** | The length of the free trial, from 1 to 730 days. Leave empty for no trial. |
| **Stripe coupon** | Pick the coupon in the list, searchable by name, coupon ID or discount. Leave empty for a trial without discount. |

Three combinations are possible:

| Offer | Stripe trial days | Stripe coupon | What the subscriber pays |
| --- | --- | --- | --- |
| **Free trial** | 7 | empty | Nothing for 7 days, then the full price. |
| **Intro price** | empty | 30% off, 3 months | The discounted price for 3 cycles, then the full price. |
| **Trial then intro price** | 7 | 30% off, 3 months | Nothing for 7 days, then the discounted price for 3 cycles, then the full price. |


<Image src="https://files.readme.io/2eb4f8f013e57988c30597936db5ff0662987d9ab811ca9375966ec1a5223fb7-intro-offers-05-console-promo-offer-free-trial.png" align="center" border={true} />

The Console warns you when a coupon has no amount in one of the currencies of the plan's prices, and when a *Multiple months* coupon would end before the trial does, which would leave no discounted cycle.

> 🚧 Locked once used
>
> Like store offer IDs, the Stripe fields of an offer are locked after the first purchase made with it. To change a trial length or a coupon, create a new offer.

## 3. Use the offer on a Screen

In the Screen Composer, an offer is attached to a **purchase action** of a button or a plan picker:

1. select the action **Purchase**,
2. select the **Plan**, which must be mapped to the Stripe price, see [Setup 1 · Connect Stripe](web2app-setup-stripe),
3. select the **Offer**.

The checkout then applies the trial and the coupon automatically. A visitor cannot get the offer without going through that action, and the Composer only proposes the offers of the selected plan.

### Display the offer with tags

Switch the component to **Offer mode** to write the copy shown when an offer is attached, and use the offer tags. They are the same tags as for store offers, computed from the Stripe price and the coupon:

| Tag | Example | Meaning |
| --- | --- | --- |
| `{{OFFER_PRICE}}` | *€7 / month* | The discounted price per billing period. |
| `{{OFFER_AMOUNT}}` | *€7* | The discounted amount, without the period. |
| `{{OFFER_DURATION}}` | *3 months* | How long the offer lasts: the trial length, or the number of discounted cycles. |
| `{{OFFER_DISCOUNT_PERCENTAGE}}` | *30%* | The discount, for a percentage coupon. |
| `{{OFFER_PRICE_COMPARISON}}` | *€30* | The full price over the duration of the offer, for a strikethrough. |

The full list, including the per-period amounts such as `{{OFFER_MONTHLY_AMOUNT}}`, is on the [Tags](tags) page. Intro tags (`{{INTRO_PRICE}}`, `{{INTRO_AMOUNT}}`) and offer tags can be used indifferently.


<Image src="https://files.readme.io/2bdf6b42fa3a985be8ee7d04ad8b199654ab9134eac7992571c3decacf87f399-intro-offers-03-web-paywall-offer-tags.png" align="center" border={true} />

## What the subscriber sees at checkout

The Stripe checkout shows the full price, the coupon as a line item with its name and the discount, and the total due today. With a free trial, the total due today is zero and the first charge date is displayed.


<Image src="https://files.readme.io/3065179fd3a054bf8e1063cc91afd5f9d0de2934da819ae5ae57ebdd621d2f5a-image.png" align="center" border={true} />

Renewals after the offer are charged at the full price by Stripe, as for any subscription.

## How the offer is reported

Web subscriptions sold with an offer go through the same offer events as store subscriptions, in your webhooks and in your dashboards:

| Offer | Events |
| --- | --- |
| Free trial | `TRIAL_STARTED` at purchase, then `TRIAL_CONVERTED` at the first paid invoice. |
| Intro price | `INTRO_OFFER_STARTED` at purchase, then `INTRO_OFFER_CONVERTED` at the first full-price invoice. |
| Trial then intro price | `TRIAL_STARTED`, then `TRIAL_CONVERTED` and `INTRO_OFFER_STARTED` at the first discounted invoice, then `INTRO_OFFER_CONVERTED`. |

The subscription carries the offer's vendor ID, and the Stripe subscription carries the offer in its metadata. See [Offer events](offer-events) and [Events, attribution & webhooks](web2app-events-and-webhooks).

## Testing

Test the offer on the **sandbox URL** of the flow with a [Stripe test card](https://docs.stripe.com/testing): the coupon must exist in Stripe test mode and the offer must be attached to the plan's SANDBOX price. The checkout shows the discount and the trial exactly as in live mode. See [Test and go live](web2app-test-and-go-live).

## Troubleshooting

| Problem | Cause and solution |
| --- | --- |
| The coupon is not in the list. | It was created in the other Stripe mode, it is a *Forever* coupon, or it has expired or reached its redemption limit. |
| The offer does not appear in the Composer. | The offer belongs to another plan, or the plan is not mapped to a Stripe price. Select the plan first. |
| The checkout shows the full price. | The Screen is published without the offer on its purchase action, or the coupon has no amount in the visitor's currency, or it is limited to other products. |
| The Console warns about a missing currency. | Add the missing currency to the fixed-amount coupon in Stripe, or switch to a percentage coupon. |
| I cannot edit the trial days or the coupon. | The offer has already been used by a purchase. Create a new offer. |