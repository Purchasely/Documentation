---
title: Web2App FAQ · End-to-end test
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
# How do I validate my setup end to end?

Select a flow, open its sandbox URL on your phone, pay with the Stripe test card, then tap the redemption button on the success screen so your app activates the subscription. Purchase and redemption are detected automatically; the full walkthrough is on [Test and go live](web2app-test-and-go-live).

# Why test on a phone rather than on my computer?

The redemption opens your app through its URL scheme, which a desktop browser cannot do. You can run the funnel and the checkout on desktop, but the last step needs the phone with your app installed.

# Which card do I use?

`4242 4242 4242 4242`, any future expiry date and any three-digit CVC. The sandbox funnel runs on Stripe test mode, so no real card is charged. Other test cards simulate declines and 3D Secure: [Stripe test cards](https://docs.stripe.com/testing).

# The purchase is not detected

Check that the payment went through in Stripe test mode, and that you used the sandbox URL, not the live one. If it did, click **Mark as done**. The step polls for about fifteen minutes after you open the funnel.

# The redemption is not detected

The app did not open, or it runs an SDK older than 6.1, or the URL is not forwarded to the SDK. See [Setup 3 · Verify your mobile app](web2app-setup-mobile-app) and [SDK integration](web2app-sdk-integration).

# Where does the receipt email go?

To the email address you typed at checkout, with a `[Sandbox]` prefix in the subject. Use a real inbox to check the email and its store and redemption links.

# Do sandbox purchases count somewhere?

They create test subscriptions in Stripe test mode and appear as sandbox in Purchasely. They are real events for the ad platforms, though: use their test tools while you test.
