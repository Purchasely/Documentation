---
title: Web2App FAQ · Plan mapping
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
# Why do I need to map my plans?

A Web Flow sells your Purchasely plans, the same ones your paywalls sell in the app. On the web, the payment goes through Stripe, so each plan needs the Stripe price to charge. A plan without a Stripe price can still be sold in the app but cannot appear in a web checkout.

# Do I need separate plans for the web?

No. The target model is one plan linked to your App Store product, your Play Store product and your Stripe prices. The same paywall then works in the app and in a Web Flow; the SDK picks the payment method from the platform. See [Stripe - Configuring Subscriptions](stripe-configuring-subscriptions).

# Where do I find the Stripe price IDs?

You do not need to copy them. Once Stripe is connected, the picker lists the prices of your account with a SANDBOX or LIVEMODE badge, searchable by product name, amount or ID.

# Why link several prices to one plan?

To cover both Stripe modes: link the LIVEMODE price for the live URL and the SANDBOX price for the sandbox URL. Also, if your Stripe catalog was built with one price per currency, link all the currency prices of the plan. Never link prices with a different billing period or a different level of service: that is another plan.

# The sandbox funnel works but the live one does not sell the plan

The plan only has a SANDBOX price. Link its LIVEMODE price too; prices are read per mode.

# How are currencies handled?

From the Stripe price. With a multi-currency price, Purchasely charges the currency matching the visitor's browser settings and falls back to the price's default currency. Purchasely never converts amounts. See [Stripe - Configuring Subscriptions](stripe-configuring-subscriptions).

# Can I use a Stripe price with a free trial or an introductory price?

Not yet. Trial and introductory periods set on the Stripe price are ignored in Web Flows. Map plans to prices without a trial period.

# I changed a price in Stripe. When does Purchasely see it?

Within minutes. Click **Refresh from Stripe** to force an immediate re-sync.
