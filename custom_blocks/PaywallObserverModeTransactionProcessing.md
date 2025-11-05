---
name: paywallObserver mode - transaction processing
---
# What happens with the transaction processed by my own system?

Once the app has processed the transaction, the Purchasely SDK fetches the receipt created and sends it to the Purchasely Platform, to feed the platform with all the analytics associated to the receipt (subscription events, revenue, mapping with the user etc).

The transaction will however not be finished (App Store) nor acknowledged (Google Play Store). In the Paywall Observer Mode, this is the responsibility of the developer to do it.
