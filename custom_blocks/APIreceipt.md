---
name: API /receipt
---
**POST <https://s2s.purchasely.io/receipts>**

**HEADERS**

[block:parameters]
{
  "data": {
    "h-0": "Name",
    "h-1": "Type",
    "h-2": "Mandatory for",
    "h-3": "Description",
    "0-0": "X-API-KEY",
    "0-1": "String",
    "0-2": "All",
    "0-3": "API Key associated to your application (available in the Purchasely console)",
    "1-0": "X-PLATFORM-TYPE",
    "1-1": "String",
    "1-2": "All",
    "1-3": "possible values:  \n  \n- `APP_STORE`\n- `PLAY_STORE`\n- `APPGALLERY`\n- `STRIPE`",
    "2-0": "Content-Type",
    "2-1": "String",
    "2-2": "All",
    "2-3": "`application/json`"
  },
  "cols": 4,
  "rows": 3,
  "align": [
    "left",
    "left",
    "left",
    "left"
  ]
}
[/block]


**JSON BODY**

[block:parameters]
{
  "data": {
    "h-0": "Name",
    "h-1": "Type",
    "h-2": "Mandatory for",
    "h-3": "Description",
    "0-0": "user_id",
    "0-1": "String",
    "0-2": "All",
    "0-3": "Identifier of your user as defined in your backend (and declared to our SDK).  \n  \nThe purchase will be associated to this id in all Purchasely's platform (console, webhooks, integrations)",
    "1-0": "store_product_id",
    "1-1": "String",
    "1-2": "All",
    "1-3": "Product identifier, as defined in your store's console.  \n  \n⚠ if you're using Google Play Billing with a version >= 5, please format your store_product_id this way: `subscription_id:base_plan_id`",
    "2-0": "original_transaction_id",
    "2-1": "String",
    "2-2": "Apple",
    "2-3": "Only if **you have configured StoreKit2** on Purchasely (this value is exclusive with `receipt_data`).  \n  \n[original_transaction_id](https://developer.apple.com/documentation/appstoreserverapi/originaltransactionid) associated with your purchase.",
    "3-0": "receipt_data",
    "3-1": "String",
    "3-2": "Apple",
    "3-3": "Only if **you have NOT configured StoreKit2** on Purchasely (this value is exclusive with `original_transaction_id`).  \n  \nBase64 encoded receipt data given by the SDK during the purchase, used to request App Store servers.",
    "4-0": "purchase_token",
    "4-1": "String",
    "4-2": "Google & Huawei",
    "4-3": "Purchase token given by the SDK during the purchase, which is a unique identifier that represents the user and the product ID for the in-app product they purchased",
    "5-0": "subscription_id",
    "5-1": "String",
    "5-2": "Huawei",
    "5-3": "Huawei Subscription ID",
    "6-0": "account_flag",
    "6-1": "Integer",
    "6-2": "Huawei",
    "6-3": "possible values:  \n  \n- `0` for \"Germany\"\n- `1` for \"AppTouch site of Germany\"  \n  @see [Site Information](https://developer.huawei.com/consumer/en/doc/HMS-References/iap-api-specification-related-v4#h1-1578554539083-0)",
    "7-0": "stripe_object_type",
    "7-1": "String",
    "7-2": "Stripe",
    "7-3": "possible values:  \n  \n- `subscription`\n- `checkout_session`",
    "8-0": "stripe_object_id",
    "8-1": "String",
    "8-2": "Stripe",
    "8-3": "Stripe identifier of the [subscription](https://docs.stripe.com/api/subscriptions)/[checkout_session](https://docs.stripe.com/api/checkout/sessions)",
    "9-0": "stripe_price_id",
    "9-1": "String",
    "9-2": "Stripe",
    "9-3": "Stripe identifier for the [price](https://docs.stripe.com/api/prices) associated to your purchase",
    "10-0": "ply_context",
    "10-1": "String",
    "10-2": "Stripe",
    "10-3": "Parameter attached to the body of the POST request when opening a web checkout flow from the app, containing the  context of the purchase initiated in the app.  \nEncoded in `base64`"
  },
  "cols": 4,
  "rows": 11,
  "align": [
    "left",
    "left",
    "left",
    "left"
  ]
}
[/block]