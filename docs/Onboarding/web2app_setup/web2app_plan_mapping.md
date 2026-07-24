---
title: Map your plans to Stripe prices
excerpt: ''
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
## What if a plan is not mapped?

It simply can't be sold on the web. Map at least one plan to publish your first funnel.

## How do I create the products and prices in Stripe?

In your Stripe Dashboard: one Stripe Product per Purchasely plan, with one price per billing period. See [Products and prices](https://docs.stripe.com/products-prices/how-products-and-prices-work).

## Can a plan support several currencies?

Yes. Currencies come from the Stripe price itself — use a [multi-currency price](https://docs.stripe.com/products-prices/pricing-models#multicurrency); Stripe picks the right currency automatically.

## Prices changed in Stripe — how do I sync?

Changes sync automatically via webhooks. Use **Refresh from Stripe** to force a re-sync.
