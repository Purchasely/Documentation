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

Click **Verify sending domain** to see them. Names are shown in full; if your provider appends your domain automatically, enter only the part before it.

- **Three DKIM records (CNAME), required.** They carry the keys that sign your emails and prove that you own the domain (`<token>._domainkey.yourapp.com`). The domain is verified once they resolve.
- **Two MAIL FROM records (MX and TXT on `bounce.yourapp.com`), recommended.** Bounces then come back through your domain, so SPF passes for your domain as well. Without them, emails still go out.
- **One DMARC record (TXT on `_dmarc.yourapp.com`), recommended.** Gmail and Yahoo require one from senders of more than 5,000 emails a day. A domain can have only one DMARC record, so skip it if yours already has one: it then shows as verified, and your policy keeps applying.

[What are DKIM, SPF and DMARC?](https://www.cloudflare.com/learning/email-security/dmarc-dkim-spf/)

# The domain stays unverified

A DKIM record is missing or has the wrong name, often because the provider appended your domain a second time. Purchasely re-checks every five minutes; click **Check now** after fixing. Verification is attempted for 72 hours: the status then turns to **DNS records missing**, and **Retry verification** generates three new DKIM records to add (the MAIL FROM and DMARC records do not change). A **Paused** status means the email provider paused sending after too many bounces or complaints; emails use the Purchasely address while Purchasely support reviews it with you.

# A record shows "Action needed"

Waiting will not fix this record: its message says what to change.

- **Several SPF or DMARC records at the same name.** They cancel each other out. A second DMARC record even switches off the DMARC policy of your whole domain, so keep only one.
- **SPF record without `include:amazonses.com`.** Add it to your existing record rather than creating a second one.
- **MX record not found within 72 hours.** Add it, then contact Purchasely support to restart the check.

Your emails keep being sent from your domain meanwhile: only the DKIM records decide the domain's status.

# Which mailbox can I use?

Any name on your domain made of lowercase letters, digits, dots, dashes and underscores, with no dot at the start, at the end or twice in a row. Subscribers who reply to the email reach this mailbox, so pick one that exists.

# Can I change the sender address later?

Yes. A new mailbox on the same domain applies right away. A new domain needs its own verification, and emails use the Purchasely address until then. Emails already sent are not affected.
