---
title: Stripe connection
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
## What happens when I click "Connect to Stripe"?

It opens the [Purchasely app on the Stripe Marketplace](https://marketplace.stripe.com/apps/purchasely). Install it on your Stripe account (one install per mode: live and test) and grant the listed permissions — one click, no API keys to copy.

## Live vs test mode?

Live processes real payments. Test lets you validate your funnel end to end with [Stripe test cards](https://docs.stripe.com/testing) before going live. Connect both.

## What can Purchasely access?

The app reads your products and prices and follows subscription events. It never accesses your Stripe secret keys, and your Stripe account stays fully independent.

## What is Managed Payments (merchant of record)?

With [Stripe Managed Payments](https://docs.stripe.com/payments/managed-payments), Stripe becomes the merchant of record and handles sales tax / VAT collection and remittance for eligible digital products. Additional Stripe fees apply.
