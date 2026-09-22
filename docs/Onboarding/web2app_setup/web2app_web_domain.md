---
title: Web2App FAQ · Web domain
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
# Do I need my own domain?

No. Your funnels are live on `web.purchasely.io` as soon as they are created, and keep working there. A custom subdomain shows your brand in the address bar and matches the domain of your ads. See [Setup 2 · Domains, emails & wallets](web2app-setup-domains-and-wallets).

# Which domain can I use?

A first-level subdomain of a domain you own, such as `start.yourapp.com`. An apex domain (`yourapp.com`) or a deeper subdomain (`start.web.yourapp.com`) cannot be used, and a subdomain can serve one Purchasely app only.

# What is the CNAME record for?

It routes your subdomain to Purchasely, proves you own it, and lets Purchasely issue the SSL certificate automatically. Point the record to `web.purchasely.io`.

# How long does verification take?

Usually within minutes; DNS propagation can take a few hours. Purchasely re-checks every five minutes, or immediately when you click **Check now**. Until the domain is Active, your funnels keep running on the default domain.

# I use Cloudflare for my DNS. Anything special?

Leave the CNAME record **DNS only** (grey cloud). A proxied record prevents Purchasely from issuing the certificate.

# What if the status becomes Failed?

The record was not found after seven days. Remove the domain, fix the record at your DNS provider, and add the domain again.

# Do my existing URLs change when the domain becomes active?

The live and sandbox URLs shown in your flows switch to your subdomain. Links already shared on `web.purchasely.io` keep working.
