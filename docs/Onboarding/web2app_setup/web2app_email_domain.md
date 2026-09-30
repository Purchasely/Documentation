---
title: Web2App FAQ · Email domain
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
# Which emails does Purchasely send to my subscribers?

After a web purchase, a receipt with the store links and the redemption link that activates the subscription in your app. It is the subscriber's backup path when they close the success screen or change device. See [After the purchase](web2app-redemption).

# Why configure an email domain?

So that this email comes from your brand, for example `welcome@yourapp.com`, instead of a Purchasely address. Better trust for the subscriber and better deliverability. Until the domain is verified, it is sent from `redemption@purchasely.io` with your app name as sender.

# Which DNS records do I need?

Three CNAME records, shown once you click **Verify sending domain**. They carry the DKIM keys that sign your emails and prove that you own the domain. Names are shown in full (`<token>._domainkey.yourapp.com`); if your provider appends your domain automatically, enter only the part before it. No SPF or DMARC record is needed: DKIM is enough for your emails to pass DMARC, and a DMARC policy already set on your domain keeps applying. [What are DKIM and DMARC?](https://www.cloudflare.com/learning/email-security/dmarc-dkim-spf/)

# The domain stays unverified

One record is missing or has the wrong name, often because the provider appended your domain a second time. Purchasely re-checks every five minutes; click **Check now** after fixing. Verification is attempted for 72 hours: the status then turns to **DNS records missing**, and **Retry verification** generates three new records to add. A **Paused** status means the email provider paused sending after too many bounces or complaints; emails use the Purchasely address while Purchasely support reviews it with you.

# Which mailbox can I use?

Any name on your domain made of lowercase letters, digits, dots, dashes and underscores, with no dot at the start, at the end or twice in a row. Subscribers who reply to the email reach this mailbox, so pick one that exists.

# Can I change the sender address later?

Yes. A new mailbox on the same domain applies right away. A new domain needs its own verification, and emails use the Purchasely address until then. Emails already sent are not affected.
