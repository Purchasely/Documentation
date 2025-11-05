---
title: Testing purchases in Sandbox
excerpt: >-
  This section describes how to run tests for your In-App Purchase
  implementation
deprecated: false
hidden: false
metadata:
  title: ''
  description: >-
    This document explains sandbox purchases, which are simulated transactions
    used for testing in-app purchases without real money. It provides details on
    how to conduct sandbox purchases on Apple StoreKit and Google Play Billing.
  keywords:
    - sandbox
    - ' purchase'
    - ' in-app'
    - ' storekit'
    - ' play billing'
    - ' google'
    - ' apple'
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: apple-in-app-purchases
      title: Apple In-App Purchases
    - type: basic
      slug: google-in-app-purchases
      title: Google In-App Purchases
---
# Sandbox Purchases

A sandbox purchase is a type of simulated transaction used in app development for testing In-App Purchases without involving real money. Both Apple StoreKit and Google Play Billing provide sandbox environments where developers can verify the functionality of their In-App Purchase systems before deploying their applications to live users. Here’s a detailed explanation for both platforms:

## Apple StoreKit Sandbox Purchases

**Apple StoreKit** provides a sandbox environment where developers can test In-App Purchases (IAP) without financial transactions. This allows developers to simulate and test various purchase scenarios, such as successful transactions, failed transactions, subscription renewals and cancellations. Key points include:

1. **Testing Environment**: The sandbox environment mimics the production environment but doesn't involve real money. Developers use test accounts to perform transactions.
2. **Creating Test Accounts**: Developers create sandbox test user accounts in App Store Connect, which are used to log in to the sandbox environment.
3. **Simulated Transactions**: All purchases made using these test accounts in the sandbox environment are simulated. Developers can test consumables, non-consumables, subscriptions, and auto-renewing subscriptions.
4. **Debugging**: Errors and edge cases can be tested thoroughly. For example, testing for failed payments or network interruptions.
5. **Subscription Testing**: The sandbox environment accelerates the passage of time to quickly test subscription renewals. For instance, a one-month subscription might renew every five minutes in the sandbox.

[More details on configuring Apple In-App Purchases for testing purposes](apple-in-app-purchases)

## Google Play Billing Sandbox Purchases

**Google Play Billing** also provides a sandbox environment for testing In-App Purchases without real financial transactions. This environment helps developers ensure their In-App Purchase functionality works correctly before going live. Key aspects include:

1. **Testing Environment**: Similar to Apple’s sandbox, Google’s sandbox environment simulates real purchase processes using test accounts.
2. **Test Accounts**: Developers need to add license tester accounts through the Google Play Console. These accounts can then perform sandbox purchases in the app.
3. **Simulated Purchases**: Various types of purchases can be tested, including managed products (one-time purchases), subscriptions, and consumable products.
4. **Debugging**: Developers can test different scenarios, such as successful purchases, refunds, cancellations, and re-subscriptions.
5. **Subscription Testing**: Google’s sandbox environment allows developers to test subscription renewals with shortened time frames, similar to Apple’s accelerated renewal testing.

# Time Limitations of Sandbox Purchases for Subscriptions

In the Apple StoreKit and Google Play Billing sandbox environment, subscription renewals happen more frequently to allow for rapid testing. Here are the time limitations for sandbox subscriptions:

- **Monthly Subscription**: Renews every 5 minutes, up to a maximum of 6 renewals.
- **Yearly Subscription**: Renews every 30 minutes, up to a maximum of 6 renewals.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/e97f469-image.jpeg",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


# How to Cancel Sandbox Purchases

## Apple StoreKit

The sandbox environment for Apple StoreKit uses a test user account created in App Store Connect. Ensure you are using this test account to see and manage sandbox subscriptions.

To cancel a sandbox subscription on Apple StoreKit:

1. **Open the App Store**: On your test device, open the App Store.
2. **Sign In**: Ensure you are signed in with your sandbox test account.
3. **Manage Subscriptions**:
   - Tap on your profile icon in the top right corner.
   - Go to "Subscriptions".
4. **Cancel Subscription**: Find the subscription you want to cancel and tap "Cancel Subscription".

## Google Play Billing

The sandbox environment for Google Play Billing uses test accounts added through the Google Play Console. Make sure your test account is properly set up to manage sandbox subscriptions.

To cancel a sandbox subscription on Google Play Billing:

1. **Open Google Play Store**: On your test device, open the Google Play Store app.
2. **Sign In**: Ensure you are signed in with your test account.
3. **Manage Subscriptions**:
   - Tap on the menu icon (three horizontal lines) in the top left corner.
   - Select "Subscriptions".
4. **Cancel Subscription**: Find the subscription you want to cancel and tap "Cancel".