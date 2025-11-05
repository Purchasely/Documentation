---
title: SDK Running Modes
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
# Understanding the running modes

The Purchasely SDK can be used in 2 different modes:

1. `full` (default): the Purchasely platform is in charge of managing the transactions. 
   * When a call-to-action is clicked from a Purchasely paywall, the Purchasely SDK automatically triggers the in-app purchase native flow and manages the transaction from end to end. 
   * This includes the transaction finishing (App Store) and transaction acknowledgement (Google Play Store).
2. `paywallObserver`: the transactions remain managed with the existing subscription infrastructure (either in-house or 3rd party such as RevenueCat).
   * When a call-to-action is clicked from a Purchasely paywall, the Purchasely SDK hands-over to the app (using the Paywall Action Interceptor), which can manage the transaction on its own, using the existing subscription infrastructure.
   * In this case, the responsibility to finish the transaction (App Store) or acknowledge it (Google Play Store) lies with the developer.
   * Once the transaction has been processed, the Purchasely SDK gathers the receipt and sends it to the Purchasely Platform to feed the dashboard.

# When to use the `paywallObserver` mode?

This mode is perfect to use Purchasely data and Purchasely paywalls without changing your existing subscription infrastructure (either in-house or 3rd party such as RevenueCat).

You can use this mode if you want to:

* use Purchasely remotely modifiable paywalls and screens
* benefit of our unified data set of subscription events to get a better understanding of your subscribers' lifecycle
* fuel your marketing tools with these events and create no-code automations
* all this without changing your legacy transaction processor / backend

<br />

# When to use the `full` mode?

In the Full mode, Purchasely handles transactions, analytics and paywall display as explained in default SDK Configuration.

Most of Purchasely customers use this mode because it allows to take benefit of all powerful features from Purchasely.

This mode is particularly relevant for teams starting their journey with in-app subscriptions as it will avoid developers to:

* code an in-house transaction processor and build their own subscription infrastructure
* manage the subscribers lifecycle and develop store-specific code to plug with the app stores (3 to 6 months of work in average)
* waste time on developing the paywall(s)

Instead, teams can focus on developing their core product and features and use subscriptions as a convenience.

<br />

<br />

<FullModeHowTransactionsAreManagedInTheFullMode />

<FullModeHowItWorks />

<FullModeManagingEntitlementsWithYourOwnBackend />

<FullModeManagingEntitlementsWithThePurchaselySDK />

<br />

# How transactions are managed in the `full` mode?

In the `full` mode, Purchasely plays the role of subscription infrastructure and is in charge of managing transactions. 

It means that the In-App Purchase native flow is automatically triggered by the Purchasely SDK when the user hits a purchase button on a paywall.

The corresponding transaction is automatically processed and the purchase (either subscription or one-time purchase is associated with the user). 

The app just has to wait for the confirmation from the SDK that the transaction has been properly processed, to refresh the entitlements of the user.

# How entitlements are managed in the `full` mode?

When used in full mode, Purchasely plays the role of subscription infrastructure.

2 different options are available to manage entitlements (control the access to the premium contents / features only available to premium members):

1. Managing entitlements with your own backend, leveraging Purchasely's webhook (recommended and more secure)
2. Managing entitlements through the Purchasely SDK (less secure since a malicious user could modify your app to gain access to premium features)

# Managing entitlements with your own backend

### Architecture

With this architecture, the Purchasely Platform notifies your backend every time an event happens on a subscription or with an In-App Purchase.

<Image align="center" className="border" border={true} src="https://files.readme.io/8885725-entitlements_webhook.gif" />

This architecture is recommended for middle and big apps which require a secure way to manage entitlements

**Pros:**

* This architecture is more secure because your backend is in charge of managing the entitlements and can grant accesses to the premium contents / feature at the server level, instead of doing it at the app level.

**Cons:**

* The main inconvenient is that it requires more effort as you need to involve your backend team to integrate the Purchasely's webhook, acknowledge the events and deploy your own entitlements database.

Compared to managing the entitlements directly with the app stores, working with Purchasely is much simpler. The events sent are the same for all App stores and have been unified and simplified as much as possible.

More details available [here](https://docs.purchasely.com/integrations/webhook-1)

### Purchase flow

A typical purchase flow will be as follows:

1. the Paywall is displayed by the Purchasely SDK
2. when a purchase is triggered by the user, Purchasely launches the native in-app purchase flow and automatically manages the transaction
   * The corresponding receipt is automatically gathered and verified with the App store. 
   * The information associated with it is automatically extracted
   * The subscription/one-time purchase is created/updated and associated to the user
3. the developer backend is notified through a webhook message that a subscription/one-time purchase has been created/updated for a particular user
4. the developer backend acknowledges the message and updates the entitlements for that particular user and notifies the app

Upon the reception of App store server notifications (eg: when a subscription is renewed, terminated or the auto-renewing is canceled...), the Purchasely platform gets notified, updates the subscription and notifies the developer backend with a similar webhook message.

### Understanding webhook messages

Webhook messages are JSON payloads which carry all the information required to grant the entitlements (event `ACTIVATE`) or revoke them (event `DEACTIVATE`).

Each event is associated with a `user_id` or an `anonymous_user_id` depending on the logged-in status of the user inside the app.

Once the entitlements have been granted, the app is notified through the Purchasely SDK and can fetch the entitlements directly with your backend.

# Managing entitlements with the Purchasely SDK

### Architecture

With this architecture, the entitlements are managed through the Purchasely SDK.

<Image align="center" className="border" border={true} src="https://files.readme.io/b02e9cf-userSubscriptions.gif" />

To manage entitlements, the app fetches the active subscriptions using the API `userSubscriptions` of the Purchasely SDK.

This architecture is relevant for small app starting with in-app purchases or subscriptions and indie developers, as the requirements to manage entitlements and protect the access to the premium features or premium contents are lower.

**Pros**:

* This architecture is simpler and does not require to involve any backend. It can even work if the app is not relying on any backend.

**Cons**:

* The main drawback of this architecture is that it is less secure, as entitlements are managed at the app level. An attacker could either temper with the response provided by the Purchasely SDK or modify the active subscription fetched by the SDK from the Purchasely platform with a man-in-the-middle attack.
* The usage of the API `userSubscriptions` is limited for cost-reasons (as the cost of the server calls to Purchasely, which does not charge any extra cost for this service). It is therefore not relevant for big apps with important traffic.

### Purchase flow

A typical purchase flow will be as follows:

1. the Paywall is displayed by the Purchasely SDK
2. when a purchase is triggered by the user, Purchasely launches the native in-app purchase flow and automatically manages the transaction
   * The corresponding receipt is automatically gathered and verified with the App store. 
   * The information associated with it is automatically extracted
   * The subscription/one-time purchase is created/updated and associated to the user
3. the app fetches the subscription status directly through the Purchasely SDK and grants the access to the premium membership when a subscription is active.
