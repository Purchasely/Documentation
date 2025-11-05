---
title: SDK Initialisation
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
# What is the API key used for and where can I find it?

<APIKey />

The API Key serves as a confidential identifier, enabling your application to authenticate with Purchasely. This key permits our SDK to access your plans and confirm purchases. It's crucial to securely store this key within your application and ensure it is never disclosed publicly.

<br />

# Where should I put the Purchasely SDK initialization code?

<SDKInitializationAdvice />

To ensure that Purchasely is ready as soon as possible, we advise starting the SDK immediately when your application launches. Purchasely will initialize in a background thread to ensure that your application launch time and user experience are not affected.

<br />

# What version of StoreKit should I use?

<StoreKitDifferentVersions />

You must specify which StoreKit version you want to use with Purchasely for iOS devices.\
If you choose StoreKit 2 but the iOS version on your user's device is below 15, the Purchasely SDK will automatically use StoreKit 1.\
If you are unsure about which version to use, opt for StoreKit 1.

For more information, refer to our [StoreKit guide](app-store-storekit-1-vs-storekit-2).

# How to identify users?

There 3 types of users in Purchasely platform

* <Glossary>connected user</Glossary>
* <Glossary>anonymous user</Glossary>
* <Glossary>unknown user</Glossary>

You can provide a user id with `Purchasely.start()` or `Purchasely.userLogin()` if the user logs in after your application starts
