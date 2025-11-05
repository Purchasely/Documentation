---
name: webhook-architecture
---
# ARCHITECTURE & FUNCTIONNING

Below is a typical architecture of the Purchasely subscriptions infrastructure.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/f70acc5-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Everything related to transaction, app store receipts & subscription updates is managed directly by the Purchasely Platform.

Every entitlement update is sent on the webhook through 2 messages: **`ACTIVATE`** / **`DEACTIVATE`**.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/9e51f51-image.png",
        null,
        ""
      ],
      "align": "center",
      "sizing": "500px",
      "border": true
    }
  ]
}
[/block]


On your end, what you have to do is:

1. listen to Purchasely webhook events & acknowledge them
2. store and update the entitlements in your database upon the reception of **`ACTIVATE`** / **`DEACTIVATE`** events
3. manage the entitlements at the app level through your own API

# UPDATING BACKEND ENTITLEMENTS

The ACTIVATE / DEACTIVATE events are carrying the information needed to determined which entitlements shall be granted / revoked to which user:  
the plan purchased  
the store used for purchasing  
the user (user ID if the user was logged in or anonymous ID if the user was logged out)

Sample payload:

- the subset tabs only displays the fields that are mandatory to look at to manage entitlements
- the full payload tabs show the entire event payloads

```json ACTIVATE (subset)
{
  "event_name": "ACTIVATE",
  "store": "APPLE_APP_STORE",
  "user_id": "<user id provided by the app to the sdk>", // if the user is signed-in
  "anonymous_user_id": "<user id provided by the app to the sdk>", // if the user is signed-out
  "plan": "<plan id set in the Purchasely console>"
}
```
```json DEACTIVATE (subset)
{
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

> 🚧 Do not invalidate subscriptions on your end, by relying on the billing cycle end date
> 
> Never use the `next_renewal_at` / `effective_next_renewal_at` to invalidate a subscription (and always use the webhook sent to you for this sole purpose). This date is only here to help your marketing team take actions (or if you want to display the next renewal date in your app).
> 
> Indeed, in case of billing issue, if a grace period has been configured, the next renewal date might be expired when the subscription shall be actually terminated.
> 
> - Upon subscription renewal, the Purchasely Platform always sends a `ACTIVATE` message
> - Upon subscription termination, the Purchasely Platform always sends a `DEACTIVATE` message in the right timing, in other words when the entitlements should be revoked, after the grace period has expired.
> 
> If you ever needed a fail safe to unsubscribe users in case an issue occurs with Apple/Google/Huawei/Purchasely/your servers, you should let at least a 24h-margin with the given `next_renewal_at` / `effective_next_renewal_at`.

Sample backend code for:

- receiving webhook events
- extracting the relevant information
- updating the entitlements in the database
- acknowledging the processing of the events

```javascript

```
```ruby Ruby

```
```kotlin Kotlin

```

# MANAGING APP ENTITLEMENTS

The app shall fetch a backend API and provide the user ID as an entry parameter to determine which entitlements shall be granted to the user inside the app.

If the user is logged-out, the entry parameter should be the anonymous user ID provided by the SDK.

```swift Swift
Purchasely.anonymousUserId
```
```kotlin Kotlin
Purchasely.anonymousUserId
```
```javascript React Native
Purchasely.getAnonymousUserId();
```
```javascript Flutter
Purchasely.anonymousUserId;
```
```javascript Cordova
Purchasely.getAnonymousUserId((anonymousId) => {
	console.log("Purchasely anonymous Id: " + anonymousId);
});
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely.GetAnonymousUserId();
```

The backend shall respond with the entitlements associated with the user ID or anonymous user ID.

# ACKNOWLEDGING MESSAGES

Upon the reception of an event, you MUST return a `HTTP 200` (or `HTTP 404` if the user ID is unknown) to confirm to the Purchasely Platform that your backend has successfully handled the event. 

If you don't we will continue sending you the message following our retry strategy. Any other reponse code than `HTTP 200` and `HTTP 404` will generate a retry.