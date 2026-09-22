---
title: Web2App FAQ · Stripe connection
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
# What happens when I click Connect to Stripe?

The Purchasely app opens on the Stripe App Marketplace. Install it on your Stripe account and sign in with your Purchasely credentials: no API key to copy. The step-by-step guide with screenshots is on [Setup 1 · Connect Stripe](web2app-setup-stripe).

# Why do I have to connect twice, in live and in test mode?

A Stripe account has two modes with separate data. Live mode processes real payments and powers the live URL of your funnels; test mode powers their sandbox URL, where you pay with [Stripe test cards](https://docs.stripe.com/testing). Connect both so you can test every funnel end to end before sharing it.

# I have a staging app in Purchasely. Which Stripe account do I connect?

Use a Stripe Sandbox: a separate account that only has a test mode and never touches your live data. Connect it to the staging app in test mode. Keep your production Stripe account, in both modes, for your production app.

# Can I connect one Stripe account to several Purchasely apps?

A Stripe account can be linked to one Purchasely app per mode, and a Purchasely app to one Stripe account. If you sell several apps from one Stripe account, contact your Customer Success manager before connecting.

# Can I change the Stripe account later?

Yes, until purchases have been made through it. Once a subscription has been sold, even in sandbox, the account is locked to the app. Contact your Customer Success manager if you need to migrate.

# What can Purchasely access in my Stripe account?

Your products and prices, and the checkout sessions, customers and subscriptions Purchasely creates for your funnels. Purchasely never sees your Stripe secret keys. The full list of permissions is on [Setup 1 · Connect Stripe](web2app-setup-stripe).

# The step still says Not connected after I finished in Stripe

The last screen in Stripe must show *is setup!* with the name of your Purchasely app. If it does not, open **Installed apps → Purchasely** in your Stripe dashboard and complete the setup, then reload this page.
