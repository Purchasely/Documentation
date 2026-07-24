---
title: Redemption email
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
## When is this email sent?

Right after a successful checkout. It's the user's backup path to activate the subscription in the app if they close the success page.

## What can I customize?

The template (text + layout) with variables: `{redemption_link}`, `{subscription_plan}`, `{trial_end}`, `{client_name}`. Use **Send test email** to preview the result in your inbox.

## Which sender address is used?

The mailbox configured in the Email domain step (e.g. `welcome@sportelo.com`). If no email domain is set up, emails are sent from a Purchasely address.

## Can users get a new redemption link?

Yes — from the app, `requestRedemptionByEmail` re-sends a fresh link to the checkout email (rate-limited).
