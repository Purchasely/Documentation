---
title: Web2App FAQ · Stripe managed payments
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
# Who is the merchant of record?

The business that legally sells the subscription: it appears on the card statement, owes VAT or sales tax in every country it sells in, and handles refunds and chargebacks. By default that is you. With Stripe Managed Payments, it is Stripe, as the App Store and Play Store are for in-app purchases. Details on [Stripe Managed Payments](web2app-stripe-managed-payments).

# Is activating the option here enough?

No. Managed Payments must first be enabled on your Stripe account, following [Stripe's guide](https://docs.stripe.com/payments/managed-payments). Activating it only in Purchasely has no effect: your checkouts keep running with you as merchant of record.

# What does "activated when available" mean?

Stripe decides checkout by checkout whether Managed Payments applies. When it cannot, for example because a product has no tax code, Purchasely falls back to a standard checkout where you remain the merchant of record, so the sale never fails.

# Why does my product need a Product category in Stripe?

The Product category is a Stripe tax code. Stripe uses it to compute the right VAT or sales tax in each country. A product without a category is not eligible for Managed Payments. Set it in the Stripe Dashboard, on each product you sell.

# What does the customer see?

At checkout, "Sold through Link", and `LINK.COM*` on their card statement, instead of your business name.

# What does it cost?

Stripe's standard processing fees plus 3.5% per transaction, charged by Stripe.

# Can I switch it off later?

Yes, here or in App settings → Stores → Stripe. The change applies to new checkouts only; existing subscriptions keep the merchant of record they were sold with.
