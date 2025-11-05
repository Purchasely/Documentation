---
name: Full mode - Managing entitlements with the Purchasely SDK
---
# Managing entitlements with the Purchasely SDK

### Architecture

With this architecture, the entitlements are managed through the Purchasely SDK.

<Image align="center" className="border" border={true} src="https://files.readme.io/b02e9cf-userSubscriptions.gif" />

To manage entitlements, the app fetches the active subscriptions using the `userSubscriptions` method of the Purchasely SDK.

This architecture is relevant for small app starting with subscriptions/in-app purchases and indie developers, as the requirements to manage entitlements and protect the access to the premium features or premium contents are lower.

**Pros**:

* This architecture is simpler and does not require to involve any backend.

**Cons**:

* The main drawback of this architecture is that it is less secure, as entitlements are managed at the app level. An attacker could either temper with the response provided by the Purchasely SDK or modify the active subscription fetched by the SDK from the Purchasely platform with a man-in-the-middle attack.
* The usage of the API `userSubscriptions` is limited for cost-reasons (as the cost of the server calls to Purchasely, which does not charge any extra cost for this service). It is therefore not relevant for big apps with important traffic.

### Purchase flow

A typical purchase flow will be as follows:

1. the Paywall is displayed by the Purchasely SDK
2. when a purchase is triggered by the user, Purchasely launches the native in-app purchase flow and automatically manages the transaction
   * The corresponding receipt is automatically gathered, sent to Purchasely's backend and verified with the App store
   * The information associated with it is automatically extracted
   * The subscription/one-time purchase is created/updated and associated to the user
3. Purchasely SDK returns control to the application
4. You can fetch the subscription status directly through the Purchasely SDK and grant the access to the premium feature
