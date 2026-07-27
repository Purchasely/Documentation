---
title: Testing & sandbox
excerpt: >-
  What is normal store behavior in sandbox and TestFlight, and what is an actual
  bug worth reporting.
deprecated: false
hidden: false
metadata:
  title: 'FAQ: Testing & sandbox'
  description: >-
    Triage guide for Purchasely testing: prices in USD in sandbox and TestFlight,
    accelerated renewals, sandbox accounts with purchase history breaking audience
    matching, receipt verification errors, and the floating debug button.
  robots: index
next:
  description: ''
---
Most "bugs" reported from a sandbox or TestFlight build turn out to be normal store behavior in a test environment. This page separates the two.

<br />

# Expected in sandbox / TestFlight — not a bug

| What you see                                                                  | Why                                                                                                                                                          |
| :---------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Prices in USD** even though the tester's account is in another country      | Apple's product metadata request frequently returns USD in Sandbox and TestFlight, regardless of the storefront. The native purchase sheet still shows the real local price — that mismatch is the tell-tale sign. It does not happen in production. Full explanation in [Testing](testing). |
| **Prices without VAT**                                                        | Same root cause: the test environment does not resolve the storefront's tax treatment.                                                                          |
| **Renewals every few minutes**                                                | Both Apple and Google accelerate subscription time in sandbox so renewals can be tested quickly. A monthly plan may renew every 5 minutes.                       |
| **A "never subscribed" Audience does not match your test account**            | Sandbox Apple IDs accumulate purchase history that never resets. An account you used a month ago is no longer a new user as far as eligibility is concerned. Create a fresh sandbox tester. |
| **Introductory offer not offered to your test account**                       | Same reason — intro offer eligibility is per store account and per subscription group, and your tester already consumed it. See [Eligibility to introductory offer](eligibility-intro-offer). |
| **A campaign shows a price in the wrong currency**                            | Same USD behavior as above.                                                                                                                                    |

📚 [Testing](testing) · [Apple In-App Purchases](apple-in-app-purchases) · [Google In-App Purchases](google-in-app-purchases)

<br />

# How do I force the correct currency in TestFlight without waiting for release?

Tap **Restore**, or re-authenticate, with an Apple ID whose storefront matches the target country. That can force StoreKit to return the correct currency. Otherwise the price resolves correctly the moment the app is live on the App Store — no SDK or Screen change is required.

<br />

# What is the right way to test a Screen before exposing it to users?

1. **Enable [Debug Mode](debug-mode)** on the device by scanning the Preview QR code from the Console. You then see **draft** Screens, and the Debug Panel tells you the SDK version, the user and anonymous IDs, and the Placement, Flow, Campaign, Audience, A/B test and variant actually resolved.
2. **Target the built-in `Internal Testers` Audience** on the Placement, with the **highest priority**, so only debug devices get the experience under test.
3. Use the Console [Preview](preview) for layout, and a **real device** for anything store-dependent — prices, offer eligibility, the purchase flow itself.

📚 [Checking your Purchasely integration](sdk-integration-checking-full-mode) · [Checking your integration in Observer mode](checking-your-purchasely-integration-observer-mode)

<br />

# The floating debug button is showing in production — how do I remove it?

The floating debug button only appears on a device where **Debug Mode was activated**, by scanning a Console Preview QR code. It is per-device and has no effect on your real users.

To remove it: open the Debug Panel from the button and **turn Debug Mode off**. The device leaves the `Internal Testers` Audience immediately.

If you are seeing it on a device that never scanned a QR code, that is worth reporting — include the SDK version and how the app was installed.

<br />

# The debug button doesn't appear even though Debug Mode is on

The button is drawn by the SDK on top of your app UI. Check, in order:

1. **[Deeplink handling is implemented](deeplinks-management).** The QR code works through a deeplink; without deeplink handling the scan never reaches the SDK, so nothing is activated.
2. **The scan actually opened your app**, and not a browser.
3. **The SDK started successfully** — with a blank or invalid API key the SDK stays inert.
4. **Your own UI is not covering it** — the button sits in the bottom-right corner.

<br />

# I get a receipt verification error in sandbox

A sandbox receipt is validated against Apple's sandbox endpoint, so this normally means the transaction and the environment disagree. Check:

* The build is genuinely a sandbox / TestFlight build, not a production build signed with a sandbox account.
* The Purchasely app you are testing against is the one configured for that bundle ID and that store account.
* The store product exists and is purchasable in the environment you are testing.

If the error persists, report it with the SDK version, the platform, the environment, the store product ID and the exact error code.

<br />

# Can I test the purchase flow without touching the stores?

Partially. You can validate everything that does not require a real transaction — Screen rendering, Placement and Audience resolution, Flow navigation, deeplinks, user attributes — including with **no store configured at all**, which is a first-class path in SDK 6. Prices and purchases, however, always come from the store, so they need a sandbox or license-tester account.

<br />

# My test purchases show up in production dashboards

They should not, provided you test against the Purchasely app dedicated to that environment. If sandbox transactions appear in your production data, you are almost certainly pointing your test build at the production API key — see [Console & environments](faq-console-and-environments).
