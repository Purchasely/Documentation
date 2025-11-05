---
name: Backend Entitlements - updating entitlements
---
The `ACTIVATE` / `DEACTIVATE` events are carrying the information needed to determined which entitlements shall be granted / revoked to which user:

* the plan purchased
* the store used for purchasing
* the user will be identified by their user ID if they are logged in, or by an anonymous ID if they are not.

Sample payload:

* the subset tabs display only the mandatory fields necessary for managing entitlements
* the full payload tabs show the entire event payloads

```json ACTIVATE (subset)
{
  "purchasely_one_time_purchase_id":"otp_xxx", // if the purchase is a one-time-purchase,
  "purchasely_subscription_id":"subs_xxx", // if the purchase is a subscription
  "event_name": "ACTIVATE",
  "store": "APPLE_APP_STORE",
  "user_id": "<user id provided by the app to the sdk>", // if the user is logged in
  "anonymous_user_id": "<user id provided by the app to the sdk>", // if the user is not logged in
  "plan": "<plan id set in the Purchasely console>"
}
```
```json DEACTIVATE (subset)
{
  "purchasely_one_time_purchase_id":"otp_xxx", // if the purchase is a one-time-purchase,
  "purchasely_subscription_id":"subs_xxx", // if the purchase is a subscription
  "event_name": "ACTIVATE",
  "store": "APPLE_APP_STORE",
  "user_id": "<user id provided by the app to the sdk>", // if the user is signed-in
  "anonymous_user_id": "<user id provided by the app to the sdk>", // if the user is signed-out
  "plan": "<plan id set in the Purchasely console>"
}
```
```json ACTIVATE (full payload)
{
  "plan": "monthly",
  "store": "GOOGLE_PLAY_STORE",
  "product": "PURCHASELY_PLUS",
  "user_id": "toto",
  "event_id": "5e45109f-7fac-45f8-a7e4-464892d5d35d",
  "event_name": "ACTIVATE",
  "offer_type": "NONE",
  "api_version": 3,
  "device_type": "PHONE",
  "environment": "SANDBOX",
  "purchased_at": "2023-12-12T14:13:11.777Z",
  "purchase_type": "RENEWING_SUBSCRIPTION",
  "store_country": "FR",
  "next_renewal_at": "2023-12-12T14:23:11.777Z",
  "purchased_at_ms": 1702390391777,
  "event_created_at": "2023-12-12T14:19:26.120Z",
  "is_family_shared": false,
  "store_product_id": "com.purchasely.plus.monthly",
  "customer_currency": "EUR",
  "plan_price_in_eur": 9.99,
  "next_renewal_at_ms": 1702390991777,
  "event_created_at_ms": 1702390766120,
  "previous_offer_type": "NONE",
  "store_app_bundle_id": "com.purchasely.demo",
  "subscription_status": "AUTO_RENEWING",
  "store_transaction_id": "GPA.3355-5688-7970-28037..5",
  "original_purchased_at": "2023-12-12T13:48:16.233Z",
  "original_purchased_at_ms": 1702388896233,
  "cumulated_revenues_in_eur": 69.9,
  "effective_next_renewal_at": "2023-12-12T14:23:11.777Z",
  "purchasely_subscription_id": "subs_D7GnVQbUxvY6YxoeK6nhyPDkmyCVcfe",
  "effective_next_renewal_at_ms": 1702390991777,
  "store_original_transaction_id": "GPA.3355-5688-7970-28037",
  "plan_price_in_customer_currency": 9.99
}
```
```json DEACTIVATE (full payload)
{
  "plan": "monthly",
  "store": "GOOGLE_PLAY_STORE",
  "product": "PURCHASELY_PLUS",
  "user_id": "toto",
  "event_id": "3ab7e67a-6c88-44fe-8804-39897d601136",
  "event_name": "DEACTIVATE",
  "offer_type": "NONE",
  "api_version": 3,
  "device_type": "PHONE",
  "environment": "SANDBOX",
  "purchased_at": "2023-12-12T14:18:11.777Z",
  "purchase_type": "RENEWING_SUBSCRIPTION",
  "store_country": "FR",
  "next_renewal_at": "2023-12-12T14:23:11.777Z",
  "purchased_at_ms": 1702390691777,
  "event_created_at": "2023-12-12T14:24:09.412Z",
  "is_family_shared": false,
  "store_product_id": "com.purchasely.plus.monthly",
  "customer_currency": "EUR",
  "plan_price_in_eur": 9.99,
  "next_renewal_at_ms": 1702390991777,
  "event_created_at_ms": 1702391049412,
  "previous_offer_type": "NONE",
  "store_app_bundle_id": "com.purchasely.demo",
  "subscription_status": "UNPAID",
  "store_transaction_id": "GPA.3355-5688-7970-28037..5",
  "original_purchased_at": "2023-12-12T13:48:16.233Z",
  "original_purchased_at_ms": 1702388896233,
  "cumulated_revenues_in_eur": 69.9,
  "effective_next_renewal_at": "2023-12-12T14:23:11.777Z",
  "purchasely_subscription_id": "subs_D7GnVQbUxvY6YxoeK6nhyPDkmyCVcfe",
  "effective_next_renewal_at_ms": 1702390991777,
  "store_original_transaction_id": "GPA.3355-5688-7970-28037",
  "plan_price_in_customer_currency": 9.99
}
```

The users entitlements must be associated to the `user ID` or `anonymous user ID` and stored in your database. You must solely rely on the webhook events to update them.

> 🚧 Do not rely on the "billing cycle end dates" to invalidate subscriptions on your end
>
> Never use the `next_renewal_at` / `effective_next_renewal_at` to invalidate a subscription and always use the `DEACTIVATE` event sent on the webhook for this sole purpose. These dates are only here to help your marketing team take actions (or if you want to display the next renewal date in your app).
>
> **Why is relying on these dates a mistake?**
>
> If your/Purchasely/stores's servers encounter an issue, you might invalidate a user's rights simply because your data isn't up to date and the `effective_next_renewal_at` seems to be in the past.
>
> **What should you do instead?**
>
> * Upon subscription renewal, the Purchasely Platform always sends a `ACTIVATE` message
> * Upon subscription termination, the Purchasely Platform always sends a `DEACTIVATE` message in the right timing, in other words when the entitlements should be revoked on your end
>
> If you ever need a fail safe to unsubscribe users in case an issue occurs with the Store/Purchasely/your servers, you should let at least a 24h-margin with the given `effective_next_renewal_at`.
