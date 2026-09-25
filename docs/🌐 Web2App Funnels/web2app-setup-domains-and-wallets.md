---
title: Setup 2 · Domains, emails & wallets
excerpt: >-
  Serve your funnels from your own subdomain, send emails from your own domain,
  and enable Apple Pay and Google Pay at checkout.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: 'Next, check your mobile app: SDK version, app scheme, icon and favicon.'
  pages:
    - type: basic
      slug: web2app-setup-mobile-app
      title: Setup 3 · Verify your mobile app
---
The second setup section is about the identity of your funnels: the domain they run on, the sender of the emails they trigger, and the wallets your visitors can pay with. It takes about ten minutes, plus the time your DNS provider needs to propagate records.

Open **Web2App → Setup**, section _2. Configure your domain_: `https://console.purchasely.io/web2app?tab=setup`. The web domain and email domain are also available under **App settings**.

| Step                       | Required                   | What it changes                                                            |
| -------------------------- | -------------------------- | -------------------------------------------------------------------------- |
| 2.1 Web domain             | Yes, to complete the setup | Funnels run on `start.yourapp.com` instead of `web.purchasely.io`          |
| 2.2 Email domain           | Optional                   | Emails are sent from `welcome@yourapp.com` instead of a Purchasely address |
| 2.3 Apple Pay & Google Pay | Optional                   | Wallets appear in the Stripe checkout                                      |

<Callout icon="📘" theme="info">
  ### Your funnels work without a custom domain

  Every Web Flow gets a live URL and a sandbox URL on `web.purchasely.io` as soon as it is created. The custom subdomain and the email domain only replace the Purchasely defaults with your brand.
</Callout>

## 2.1 Web domain

By default, funnels are served from `web.purchasely.io`. With a custom domain, the visitor sees your brand in the address bar, and the domain matches the one they clicked in your ad.


<Image src="https://files.readme.io/2f107e3886e58d317537c43d82cee354dc1f56707c1fa507196d89d15057913c-image.png" border={true} />


### Choose a subdomain

Use a **first-level subdomain** of a domain you own, for example `start.yourapp.com`, `go.yourapp.com` or `join.yourapp.com`.

* An **apex domain** (`yourapp.com`) cannot be used: your website already lives there, and Purchasely needs the whole host.
* A **deeper subdomain** (`start.web.yourapp.com`) is not supported either.
* A subdomain can be attached to **one Purchasely app** only.

### Add the CNAME record

1. In step 2.1, enter your subdomain and save. The status switches to **Verifying** and the record to add is displayed.
2. At your DNS provider, create a **CNAME** record:

| Type  | Name                                                                       | Value               |
| ----- | -------------------------------------------------------------------------- | ------------------- |
| CNAME | `start` (or the full name `start.yourapp.com`, depending on your provider) | `web.purchasely.io` |

3. Wait for propagation. Purchasely re-checks the record **every five minutes**; click **Check now** to force a check. Once the record resolves, the SSL certificate is issued automatically and the status becomes **Active**.

Verification usually completes within 10 to 20 minutes, but DNS propagation can take a few hours. Until the domain is active, your funnels keep working on `web.purchasely.io`.

### Statuses

| Status        | Meaning                                                                                            |
| ------------- | -------------------------------------------------------------------------------------------------- |
| **Not set**   | No subdomain configured. Funnels run on `web.purchasely.io`.                                       |
| **Verifying** | Waiting for the CNAME record or for the SSL certificate. Funnels still run on `web.purchasely.io`. |
| **Active**    | The subdomain serves your funnels with a valid certificate. Your live and sandbox URLs now use it. |
| **Failed**    | The record was not found after **seven days**. Remove the domain, fix the record and add it again. |

<Callout icon="🚧" theme="warn">
  ### If you use Cloudflare for your DNS

  Leave the CNAME record **DNS only** (grey cloud). A proxied record prevents Purchasely from issuing the certificate.
</Callout>

## 2.2 Email domain

After a purchase, Purchasely emails the customer a receipt containing the link that activates the subscription in your app. By default these emails come from a Purchasely address. With an email domain, they come from your brand, for example `welcome@yourapp.com`, which improves trust and deliverability.


<Image src="https://files.readme.io/fcd468869083b746426ece0bb1e152baafdc0c77c2fbb2dc1e9f2188b96f27c1-image.png" border={true} />


### Add the DNS records

1. In step 2.2, enter the **sender address** you want to use, for example `welcome@yourapp.com`, and save. Purchasely generates five DNS records.
2. Add them at your DNS provider. Names are relative to your domain; some providers expect the full name (`email.yourapp.com`).

| Type  | Name                           | Purpose                                     |
| ----- | ------------------------------ | ------------------------------------------- |
| TXT   | `email`                        | Proves that you own the domain              |
| TXT   | `_dmarc.email`                 | Sets the DMARC policy of the sending domain |
| CNAME | `<selector1>._domainkey.email` | DKIM key used to sign your emails           |
| CNAME | `<selector2>._domainkey.email` | DKIM key                                    |
| CNAME | `<selector3>._domainkey.email` | DKIM key                                    |

The exact names and values are displayed in the step, with a copy button for each. What are [DKIM and DMARC](https://www.cloudflare.com/learning/email-security/dmarc-dkim-spf/)?

3. Purchasely re-checks the records every five minutes; click **Check now** to force a check. The status switches to **Verified** once all records resolve.

Until the domain is verified, emails are sent from the Purchasely address. You can change the sender address or remove the domain at any time.

## 2.3 Apple Pay & Google Pay

Apple Pay and Google Pay let visitors pay in one tap from their wallet, without typing a card number. Stripe only shows a wallet on a checkout page if the **domain hosting the page** has been registered on your Stripe account. Purchasely does that registration for you.


<Image src="https://files.readme.io/03fa9d9ee886fec7834674ced37f68b2ec6414616b0b938ec91fd54fff15a99e-image.png" border={true} />


Stripe must be connected (step 1.1) before you can register domains.

1. Step 2.3 lists every host your checkouts can run on: `web.purchasely.io` and your custom subdomain once it is active, for each connected Stripe mode.
2. Click **Register**. Purchasely registers all the hosts, in live and test mode, as payment method domains on your Stripe account.
3. Each host shows a status per wallet. Apple Pay and Google Pay appear in your checkouts as soon as the registration is done.

When your custom web domain becomes active, its registration is triggered automatically. Nothing to do in Stripe, and nothing to do in your app.

<Callout icon="📘" theme="info">
  ### What the visitor sees

  Apple Pay only appears in Safari on Apple devices, and Google Pay only on browsers where the visitor has a Google Pay wallet. Visitors without a wallet see the regular card form.
</Callout>

## Troubleshooting

| Problem                                                            | Cause and solution                                                                                                                                                       |
| ------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| The web domain stays in _Verifying_ for hours.                     | The CNAME record is missing, points to another value than `web.purchasely.io`, or is proxied by Cloudflare. Check the record with your provider and click **Check now**. |
| _This domain is not available._                                    | The subdomain is an apex domain, has several levels, or is already attached to another Purchasely app.                                                                   |
| The email domain stays unverified.                                 | One of the five records is missing or has the wrong name. Some providers add your domain automatically: use the relative name in that case.                              |
| Apple Pay does not appear in the checkout.                         | Register the hosts in step 2.3 and test in Safari on an iPhone or a Mac with a card in Wallet.                                                                           |
| The wallets appear on `web.purchasely.io` but not on my subdomain. | The subdomain was activated after the registration. Click **Register** again.                                                                                            |
