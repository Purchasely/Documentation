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

So that these emails come from your brand, for example `welcome@yourapp.com`, instead of a Purchasely address. Better trust for the subscriber and better deliverability. Until it is verified, emails are sent from a Purchasely address with your app name as sender.

# Which DNS records do I need?

Five records generated after you save the domain: one TXT to prove ownership, one TXT for the DMARC policy and three CNAME records carrying the DKIM keys that sign your emails. Names are shown relative to your domain; some providers expect the full name. [What are DKIM and DMARC?](https://www.cloudflare.com/learning/email-security/dmarc-dkim-spf/)

# The domain stays unverified

One record is missing or has the wrong name. A frequent cause is a provider that appends your domain automatically: enter the relative name only. Purchasely re-checks every five minutes; click **Check now** after fixing.

# Can I change the sender address later?

Yes, the sending domain and mailbox can be changed or removed at any time. Emails already sent are not affected.
