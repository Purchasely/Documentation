---
title: Web domain
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
## Can I use my own domain?

Yes. Point a subdomain (e.g. `web2app.sportelo.com`) to Purchasely with a CNAME record at your DNS provider. Until it's verified, your funnels stay live on `web2app.purchasely.io`.

## What is the CNAME for?

It routes traffic on your subdomain to Purchasely, proves ownership, and lets us issue the SSL certificate automatically.

## How long does verification take?

Usually minutes; DNS propagation can take a few hours. We re-check every 5 minutes — or hit **Check now**.
