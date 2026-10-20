---
title: Stripe - Configuring Subscriptions
excerpt: >-
  How to model your subscriptions as Stripe products and prices so they can be
  linked to your Purchasely plans and sold on the web.
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Purchasely sells subscriptions on the web through Stripe, for example in [Web2App Funnels](web2app-funnels). For that, each Purchasely plan you want to sell on the web must be linked to a **Stripe price**. This page explains how to create those products and prices in the Stripe Dashboard so that the link is straightforward, and how to attach them to your plans in the Console.

> 📘 One plan for every store
>
> A Purchasely plan is meant to be linked to an **App Store product**, a **Play Store product** and your **Stripe prices** at the same time. You do not need separate plans for the web: the SDK picks the payment method, in-app or web, according to the platform the paywall is displayed on.

## How Stripe models a subscription

Stripe separates **what** you sell from **how much** you charge:

* A **Product** is the thing you sell, for example *Premium*.
* A **Price** belongs to a product and defines an amount, a currency and a billing interval, for example *€9.99 every month*. A product can have several prices.

A Purchasely plan corresponds to a **product and a billing period**, so the mapping is:

| In Purchasely | In Stripe |
| --- | --- |
| One plan (e.g. *Premium Monthly*) | One **recurring** price (e.g. €9.99 / month) on the *Premium* product |
| Another plan of the same product (e.g. *Premium Yearly*) | Another recurring price (e.g. €59.99 / year) on the same *Premium* product |

## The recommended model

The cleanest catalog for Purchasely is **one Stripe product per Purchasely product**, with **one recurring price per billing period**, and **every currency you sell in configured on each price**:

```
Product: Sportello Premium
├── Price: monthly   → €9.99  · $11.99 · £8.99
└── Price: yearly    → €99.99 · $119.99 · £89.99
```

Each price is then linked to one Purchasely plan (*Premium Monthly*, *Premium Yearly*). Purchasely picks the currency to charge from the visitor's browser settings.

## Creating the product and its first price

In the [Stripe Dashboard](https://dashboard.stripe.com/products), open **Product catalog** and click **Add product**. A product is always created together with its first price, on the same form.

<Image align="center" className="border" border={true} src="TODO-NICO-UPLOAD/stripe-products-01-add-product.png" alt="Stripe Dashboard: Add a product form with name, tax code and recurring pricing" />

1. **Name**: the name of your Purchasely product, for example *Sportello Premium*. It is shown to the customer at checkout.
2. **Product category**: select a **tax code**. It is required if you plan to use [Stripe Managed Payments](web2app-stripe-managed-payments), where Stripe calculates, collects and remits taxes for you.
3. **Pricing**: choose **Recurring**. *One-off* products cannot be sold in Web Flows.
4. **Amount** and currency, then the **Billing period** that matches your Purchasely plan (monthly, yearly…).
5. Click **Add product**. The product page opens with this first price listed under *Pricing*.

<Image align="center" className="border" border={true} src="TODO-NICO-UPLOAD/stripe-products-02-product-page-pricing.png" alt="Stripe Dashboard: product page with the first recurring price" />

> 🚧 Free trials and introductory prices
>
> Do not configure a trial period or an introductory price on the Stripe price: they are not supported yet in Web Flows and would be ignored. Introductory pricing on the web is on the roadmap.

## Adding billing periods and currencies

Use the same *Add price* form both to add another billing period (a yearly plan next to the monthly one) and to add currencies to a price.

1. On the product page, click **+** next to *Pricing*.
2. Choose **Recurring** and keep the **Flat rate** pricing model.
3. Enter the **Amount** in your default currency, then click **Choose a currency…** to add each additional currency with its own amount. Stripe does not convert amounts: you set every price yourself, and it does not change when exchange rates move.
4. Select the **Billing period** of this price.
5. Click **Create price**.

<Image align="center" className="border" border={true} src="TODO-NICO-UPLOAD/stripe-products-03-add-price-multi-currency.png" alt="Stripe Dashboard: Add price form with EUR and USD amounts and a yearly billing period" />

Repeat for every billing period you sell. You can also open an existing price and add currencies to it later.

### Live mode and test mode

Stripe keeps two separate catalogs, one per mode. Create the same products and prices in **live mode** and in **test mode** (or in your Stripe Sandbox). The live prices are charged on the live URL of your funnels, the test prices on their sandbox URL, so you can test a checkout end to end with a [Stripe test card](https://docs.stripe.com/testing).

### Legacy catalogs: one price per currency

Before multi-currency prices existed, the only way to sell in several currencies was to create **one price per currency** on the same product, all with the same billing period. Older catalogs often use this model. Purchasely supports it: link every currency price of the plan in the Console, as described below. For a new catalog, prefer multi-currency prices.

If a price carries several amounts for the same currency, Purchasely uses the **most recently created** one.

## Linking the prices to your Purchasely plans

You do not need to copy price IDs from Stripe. Once your Stripe account is connected to Purchasely (see [Stripe configuration](stripe-configuration) or [Setup 1 · Connect Stripe](web2app-setup-stripe)), the Console lists your prices directly.

1. In the Console, open **Products & Plans** and select the plan.
2. In **Applications stores**, open the **Stripe** tab.
3. Under **Stripe prices**, click **Select a Stripe price** and search by product name, price ID or amount. Each price carries a **SANDBOX** or **LIVEMODE** badge.
4. Add the live price and the test price of the plan, and every currency price if you use the legacy model. Save.

<Image align="center" className="border" border={true} src="TODO-NICO-UPLOAD/setup-stripe-12-plan-editor-stripe-prices.png" alt="Plan editor, Stripe tab: linked prices and the price picker with SANDBOX badges" />

> 🚧 Same period, same entitlement
>
> Only link prices that share the plan's billing period and level of service. A price with a different period or a different entitlement belongs to another Purchasely plan.

The same mapping is available from the Web2App setup, step *1.2 Map your plans to Stripe prices*.
