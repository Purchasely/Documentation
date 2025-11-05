---
name: Full mode - Managing entitlements with your own backend
---
# Managing entitlements with your own backend

### Architecture

With this architecture, the Purchasely Platform notifies your backend every time an event happens with a subscription or an In-App Purchase.

<Image align="center" className="border" border={true} src="https://files.readme.io/8885725-entitlements_webhook.gif" />

This architecture is recommended for middle and big apps which require a secure way to manage entitlements

**Pros:**

* This architecture is more secure because your backend is in charge of managing the entitlements and can grant accesses to the premium contents / feature at the server level, instead of doing it at the app level.

**Cons:**

* The main inconvenient is that it requires more effort as you need to involve your backend team to integrate the Purchasely's webhook, acknowledge the events and deploy your own entitlements database.

Compared to managing the entitlements directly with the app stores, working with Purchasely is much simpler. The events sent are the same for all App stores and have been unified and simplified as much as possible.

### Purchase flow

A typical purchase flow will be as follows:

1. the Paywall is displayed by the Purchasely SDK
2. when a purchase is triggered by the user, Purchasely launches the native in-app purchase flow and automatically manages the transaction
   * The corresponding receipt is automatically gathered, sent to Purchasely's servers and verified with the App store. 
   * The information associated with it is automatically extracted
   * The subscription/one-time purchase is created/updated and associated to the user
3. the developer's backend is notified through a webhook message that a subscription/one-time purchase has been created/updated for a particular user
4. the developer's backend acknowledges the message and updates the entitlements for that particular user
5. Purchasely SDK returns control to the application and you can fetch the entitlements directly with your backend

The status of a subscription/one-time-purchase can also be updated at any moment without going through a purchase flow (eg: when a subscription is renewed, terminated or the auto-renewing is canceled...). In this case the Purchasely platform gets notified by the App Store directly, updates the subscription and notifies the developer's backend with a similar webhook message.

### Understanding webhook messages

Webhook messages are JSON payloads which carry all the information required to grant the entitlements (event `ACTIVATE`) or revoke them (event `DEACTIVATE`).

Each event is associated with a `user_id` or an `anonymous_user_id` depending on the logged-in status of the user inside the app.
