---
title: Apple In-App Purchases
excerpt: This section describe how to test Apple In-App Purchases with Purchasely
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Take a deeper dive into our In-App purchases guide for Apple
  pages:
    - type: basic
      slug: app-store-starting-with-iap
      title: App Store - Steps to unlock In-App Purchases & Subscriptions
---
# Prerequisites

## 1. Sandbox Environment

* The sandbox environment simulates the App Store for testing In-App Purchases without actual financial transactions.
* It allows you to test various purchase flows, subscriptions, and restore functionalities.
* You must create a Sandbox Apple ID for testing purposes, which is different from your regular Apple ID.

> 🚧 Important information
>
> * **No real charges:** Purchases made in the sandbox environment do not incur real charges and do not transfer to the production environment.
> * **Slow:** There can be significant delays on Apple's side in the sandbox environment when purchasing or restoring products.
> * **Offers:** You can reset your eligibility to introductory offers, but this action has an unknown delay. We advise relaunching your application to see it applied.

[Learn more about sandbox testing](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_in-app_purchases_with_sandbox)

## 2. Use real devices for purchase

* Purchasely does not support testing In-App Purchases on simulators.
* You need to test on physical devices with sandbox accounts configured or with TestFlight.

## 3. Paid Apps contracts

* Ensure you have accepted the latest Paid Apps contract in App Store Connect.
* This is a **prerequisite** for setting up and testing In-App Purchases.

## 4. Xcode Build or TestFlight

Both ways allows you to test not reviewed In-App Purchases. We advise to test during development with a Sandbox account (Xcode build) and to test one last time before release with TestFlight.

**Xcode Build:**

* Use Xcode to build and run your app on a physical device.
* Ensure you have configured your In-App Purchases correctly in App Store Connect and enabled the necessary capabilities in your Xcode project.

**TestFlight:**

* TestFlight allows you to distribute beta builds of your app to testers.
* In-App purchases are free during TestFlight testing and do not carry over to the App Store version.
* TestFlight is significantly faster for testing than using a sandbox account, but you cannot cancel or delete your subscription before it finishes naturally.

[Learn more about TestFlight](https://developer.apple.com/testflight/)

## 5. Avoid having Xcode In-App Purchases test file

* Ensure your project does not include any outdated or incorrect In-App purchase configuration files.
* This can cause conflicts and errors during testing.

## 6. App Bundle ID consistency

* Verify that the app bundle ID in your Xcode project matches the one in App Store Connect.
* A wrong bundle ID will prevent the SDK from retrieving one-time and subscription products as they are bound to your bundle ID.

# Inviting TestFlight Testers

## How to Invite Testers

1. **Log in to App Store Connect:**
   * Go to the [App Store Connect](https://appstoreconnect.apple.com/) dashboard.

2. **Select Your App:**
   * Click on the app you want to invite testers for.

3. **Access the TestFlight Tab:**
   * Click on the "TestFlight" tab in the top menu.

4. **Choose Testing Type:**
   * Click on "Internal Testing" or "External Testing" depending on your needs.

5. **Add Testers:**
   * Click the "+" button to add a new tester.
   * Enter the tester's email address and assign their role (Tester or Developer).

6. **Send Invitations:**
   * Once all testers are added, click "Save". TestFlight will send email invitations to each tester with instructions to download the TestFlight app and access your build.

## Using Public Links

You can also invite testers via a public link:

* Enable the public link on your app’s TestFlight page.
* Share this link through social media, emails, or any other medium.
* You can limit the number of testers who can join via this link.

## Capabilities of TestFlight Testing

**General Capabilities:**

* TestFlight allows you to test beta builds of your app, including In-App purchases (IAPs) and subscriptions.
* Testers can install and test multiple builds simultaneously, providing feedback directly through TestFlight.

**In-App Purchases:**

* In-App purchases are simulated, meaning testers will not be charged for any transactions made during testing.
* You can test various purchase flows, including initial purchases, upgrades, downgrades, and renewals.

**Subscriptions:**

* You can test auto-renewable subscriptions and manage introductory offers and promotional offers.
* Testers can experience the full subscription lifecycle, including renewal and expiration.

## Limitations

* Subscriptions started in TestFlight cannot be canceled or deleted before they naturally expire.
* TestFlight testing might have some limitations in terms of network delays and transaction processing times.
* Some subscription features, like Family Sharing, might not fully replicate the production environment.

# Step-by-Step Testing Process

## 1. Create a Sandbox Apple ID

* Go to App Store Connect > Users and Access > Sandbox.
* Create a new Sandbox Apple ID if you don't already have one.
* In your device, go to Settings -> App Store and in the section "Sandbox account", log in with your Sandbox account. You should not add a phone number if you want to share this account on multiple devices.

[Create Sandbox Apple IDs](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_in_app_purchases_with_sandbox#creating-sandbox-tester-accounts)

## 2. Configure In-App Purchases

* Set up your [In-App Purchases](app-store-configuring-in-app-purchases) in App Store Connect under My Apps > Your App > Monetization > In-App Purchases.
* Set up your [subscriptions](app-store-configuring-in-app-subscriptions) in  App Store Connect under My Apps > Your App > Monetization > Subscriptions.

[Configure In-App Purchases](https://developer.apple.com/documentation/storekit/in-app_purchase/configuring_in-app_purchases_in_app_store_connect)

## 3. Set Up Your Project

* In Xcode, enable In-App purchase capability in your project settings.
* Ensure your app’s bundle ID matches the one used in App Store Connect.

## 4. Build and Run on a Device

* Build your app using Xcode and run it on a physical device.
* Log in with your Sandbox Apple ID on the device.

## 5. Test In-App Purchases

* Initiate In-App purchases within your app.
* Verify the purchase flow, receipt validation, and [handling of successful and failed transactions](processing-transactions).

# Troubleshooting Tips

* Ensure all [pre-requisites](#prerequisites). are met, such as having an active Apple Developer account and accepted Paid Apps contract.
* Verify that your app’s bundle ID matches the one used in App Store Connect.
* Ensure that your [Apple App Store configuration](https://developer.apple.com/documentation/storekit/in-app_purchase/configuring_in-app_purchases_in_app_store_connect) is complete.
* Double-check your network connection and the Apple account you are using for testing.
* Refer to the [Apple Developer documentation](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_in_app_purchases_with_sandbox) for detailed troubleshooting steps and further guidance.

By following this guide, you should be able to thoroughly test your In-App purchases with Purchasely, ensuring a smooth experience for your users upon release. For more detailed information, refer to Apple's [official documentation](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_in_app_purchases_with_sandbox).
