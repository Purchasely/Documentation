---
name: Receiving and acknowledging webhook messages
---
# Receiving and acknowledging webhook messages

Messages sent on the webhook by the Purchasely platform need to be acknowledged by the developer backend to confirm to the Purchasely Platform that they have been processed.

This acknowledgement is done by responding to the message with a `HTTP 200` response code.

After the Purchasely Platform has received the response, it notifies the Purchasely SDK to confirm to the user that they are now a premium member and can have access to the premium contents / features. 

The Purchasely Platform implements a **retry mechanism** when a message is not acknowledged to prevent the risk to lose any message.

When a message is not acknowledge, the Purchasely SDK gets notified that something went wrong while granting the entitlements and the user is invited to retry in a few minutes.