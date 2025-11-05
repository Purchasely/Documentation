---
name: Full mode - how transactions are managed in the full mode?
---
# How transactions are managed in the `full` mode?

In the `full` mode, Purchasely plays the role of subscription infrastructure and is in charge of managing transactions. 

It means that the In-App Purchase native flow is automatically triggered by the Purchasely SDK when the user hits a purchase button on a paywall.

The corresponding transaction is automatically processed and the purchase (either subscription or one-time purchase is associated with the user). 

The app just has to wait for the confirmation from the SDK that the transaction has been properly processed, to refresh the entitlements of the user.
