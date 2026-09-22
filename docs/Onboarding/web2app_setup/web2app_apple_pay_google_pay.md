---
title: Web2App FAQ · Apple Pay & Google Pay
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
# Why do I have to register my domains?

Apple and Google only let a wallet pay on a domain its owner has verified. Stripe performs that verification when the domain is registered as a payment method domain on your account. Purchasely does the registration for you. [Stripe documentation](https://docs.stripe.com/payments/payment-methods/pmd-registration)

# Which domains are registered?

Every host your checkout can be served from: `web.purchasely.io` and your own subdomain once it is active, in every connected Stripe mode. One click registers them all, for both wallets.

# I activated my custom domain after registering. Do I need to register again?

Purchasely registers a custom domain automatically when it becomes active. If a wallet is missing on your subdomain, click **Register** again.

# Apple Pay does not appear when I test

Apple Pay only shows in Safari on an Apple device with a card in Wallet, and Google Pay only in browsers with a Google Pay wallet. Test on a phone, and make sure the mode you test (live or test) is connected and registered. See [Setup 2 · Domains, emails & wallets](web2app-setup-domains-and-wallets).

# Is anything needed in my app?

No. Wallets are a checkout feature; the app is not involved.
