---
title: Importing your active subscribers base
excerpt: >-
  This section provides details on how to import your active subscribers base
  into the Purchasely Platform
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# ⚠️ Prerequisites ⚠️

To use any of the methods in this article, [you must have previously imported your catalog](catalogue-import), both current and past.\
Otherwise, we will not be able to import your subscribers.

<br />

# Different Methods

There are several ways to import your users into the Purchasely platform:

* **Using the “Server to Server” notifications from the stores** (not recommended)
* **Using the Purchasely SDK** (for a team without backend developer, or if you don't have the raw receipts/tokens)
* **Using our dedicated endpoint** (for less than 10k purchases)
* **Bulk import** (for large imports)

# Using Stores' S2S Notifications

| Easiness | Speed | Accuracy |
| :------- | :---- | :------- |
| ★★★★★    | ☆☆☆☆☆ | ★☆☆☆☆    |

The stores have the ability to call our servers to inform us of any status changes related to a purchase (renewal, cancellation, refund, grace period, etc.). Upon receiving these notifications, we will create the corresponding purchases on the Purchasely side.

This method has significant limitations :

* S2S notifications can take up to a year to reach us (at the renewal of an annual subscription) => this means you would have to wait that long to have updated dashboards
* S2S notifications do not contain your user identifiers => it will be impossible for us to link these purchases to your internal identifiers. Users associated to a subscription generated from a S2S notification will be marked in the Purchasely Console as **Unknown users**.

For these two reasons, this migration method is not recommended.

<br />

## Steps

* [Configure the Apple's App Store Server Notifications](app_store_s2s)
* [Configure the Google's Real-Time Developer Notifications](play_store_s2s)

<br />

# Using the Purchasely SDK

| Easiness | Speed | Accuracy |
| :------- | :---- | :------- |
| ★★★★★    | ★★☆☆☆ | ★★★★☆    |

We have the ability to synchronize user purchases the very first time your app is launched with the Purchasely SDK.

This allows you to import your subscribers gradually as they update and launch your application.

There are 2 limitations to this method:

* it can take time for your users to update and launch your application for the first time
* subscribers who are not using the app (e.g.: mobile subscribers using their premium membership only on the web or not using it but still paying for it) or a version of the app that contains the Purchasely SDK) will not be seen by the Purchasely Platform

<br />

## Steps

Ask our team to activate the automatic import of your subscribers, et voilà.

<br />

# Using our dedicated endpoint

| Easiness | Speed | Accuracy |
| :------- | :---- | :------- |
| ★★★☆☆    | ★★★☆☆ | ★★★★★    |

We have set up a dedicated endpoint to inform us of any **new subscriptions** or **existing subscriptions** you have. This makes it easy to migrate all your subscriptions to Purchasely.

⚠️ Once all existing subscriptions are imported, it will still be necessary to send us the **new subscriptions** for users purchasing subscriptions on a version of your application that do not contain the Purchasely SDK.

## Steps

Call this endpoint with the appropriate headers/body for each one of your active subscriptions:

<br />

**POST[https://s2s.purchasely.io/receipts](https://s2s.purchasely.io/receipts)**

**HEADERS**

<Table align={["left","left","left","left"]}>
  <thead>
    <tr>
      <th>
        Name
      </th>

      <th>
        Type
      </th>

      <th>
        Mandatory for
      </th>

      <th>
        Description
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        X-API-KEY
      </td>

      <td>
        String
      </td>

      <td>
        All
      </td>

      <td>
        API Key associated to your application (available in the Purchasely console)
      </td>
    </tr>

    <tr>
      <td>
        X-PLATFORM-TYPE
      </td>

      <td>
        String
      </td>

      <td>
        All
      </td>

      <td>
        possible values:  

        * `APP_STORE`
        * `PLAY_STORE`
        * `APPGALLERY`
        * `STRIPE`
      </td>
    </tr>

    <tr>
      <td>
        Content-Type
      </td>

      <td>
        String
      </td>

      <td>
        All
      </td>

      <td>
        `application/json`
      </td>
    </tr>
  </tbody>
</Table>

<br />

**JSON BODY**

<Table align={["left","left","left","left"]}>
  <thead>
    <tr>
      <th>
        Name
      </th>

      <th>
        Type
      </th>

      <th>
        Mandatory for
      </th>

      <th>
        Description
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        user\_id
      </td>

      <td>
        String
      </td>

      <td>
        All
      </td>

      <td>
        Identifier of your user as defined in your backend (and declared to our SDK).  

        The purchase will be associated to this id in all Purchasely's platform (console, webhooks, integrations)
      </td>
    </tr>

    <tr>
      <td>
        store\_product\_id
      </td>

      <td>
        String
      </td>

      <td>
        All
      </td>

      <td>
        Product identifier, as defined in your store's console.  

        ⚠ if you're using Google Play Billing with a version >= 5, please format your store\_product\_id this way: `subscription_id:base_plan_id`
      </td>
    </tr>

    <tr>
      <td>
        original\_transaction\_id
      </td>

      <td>
        String
      </td>

      <td>
        Apple
      </td>

      <td>
        Only if **you have configured StoreKit2** on Purchasely (this value is exclusive with `receipt_data`).  

        [original\_transaction\_id](https://developer.apple.com/documentation/appstoreserverapi/originaltransactionid) associated with your purchase.
      </td>
    </tr>

    <tr>
      <td>
        receipt\_data
      </td>

      <td>
        String
      </td>

      <td>
        Apple
      </td>

      <td>
        Only if **you have NOT configured StoreKit2** on Purchasely (this value is exclusive with `original_transaction_id`).  

        Base64 encoded receipt data given by the SDK during the purchase, used to request App Store servers.
      </td>
    </tr>

    <tr>
      <td>
        purchase\_token
      </td>

      <td>
        String
      </td>

      <td>
        Google & Huawei
      </td>

      <td>
        Purchase token given by the SDK during the purchase, which is a unique identifier that represents the user and the product ID for the in-app product they purchased
      </td>
    </tr>

    <tr>
      <td>
        subscription\_id
      </td>

      <td>
        String
      </td>

      <td>
        Huawei
      </td>

      <td>
        Huawei Subscription ID
      </td>
    </tr>

    <tr>
      <td>
        account\_flag
      </td>

      <td>
        Integer
      </td>

      <td>
        Huawei
      </td>

      <td>
        possible values:  

        * `0` for "Germany"
        * `1` for "AppTouch site of Germany"\
          @see [Site Information](https://developer.huawei.com/consumer/en/doc/HMS-References/iap-api-specification-related-v4#h1-1578554539083-0)
      </td>
    </tr>

    <tr>
      <td>
        stripe\_object\_type
      </td>

      <td>
        String
      </td>

      <td>
        Stripe
      </td>

      <td>
        possible values:  

        * `subscription`
        * `checkout_session`
      </td>
    </tr>

    <tr>
      <td>
        stripe\_object\_id
      </td>

      <td>
        String
      </td>

      <td>
        Stripe
      </td>

      <td>
        Stripe identifier of the [subscription](https://docs.stripe.com/api/subscriptions)/[checkout\_session](https://docs.stripe.com/api/checkout/sessions)
      </td>
    </tr>

    <tr>
      <td>
        stripe\_price\_id
      </td>

      <td>
        String
      </td>

      <td>
        Stripe
      </td>

      <td>
        Stripe identifier for the [price](https://docs.stripe.com/api/prices) associated to your purchase
      </td>
    </tr>
  </tbody>
</Table>

<br />

Body examples:

```json Apple App Store - StoreKit 1
{
  // Mandatory
  "receipt_data": "abcdFEbsbs",
  "user_id": "1234",
  
  // Country - highly recommanded
  "country": "FR",
}
```
```json Apple App Store - StoreKit 2
{
  // Mandatory
  "original_transaction_id": "310001721313211",
  "user_id": "1234",
}
```
```json Google Play Store - < Billing v5
{
  // Mandatory
  "purchase_token": "aaaNNNcccDDDeeeFFF",
  "store_product_id": "subscription_id",
  "user_id": "1234",
}
```
```json Google Play Store - < Billing v5
{
  // Mandatory
  "purchase_token": "aaaNNNcccDDDeeeFFF",
  "store_product_id": "subscription_id:base_plan_id",
  "user_id": "1234",
}
```

<br />

The purchase is processed asynchronously (therefore, you may not see it appear immediately in the Purchasely console).

An import identifier is returned by this endpoint (it will allow our support team to locate the import for this purchase).

```json 200
{ "id": "00001111-2222-3333-4444-555566667777" }
```
```json 403
{ "errors": ["unknown api_key"] }
```
```json 422
{ "errors": ["missing mandatory property \"purchase_token\""] }
```

<br />

Here are some requests examples:

```shell
curl \
  --request POST \
  -i \
  -H "Content-Type: application/json" \
  -H "X-API-KEY:00000000-1111-2222-3333-444444444444" \
  -H "X-PLATFORM-TYPE:PLAY_STORE" \
  --data '{"purchase_token":"aaaNNNcccDDDeeeFFF","user_id":"1234","store_product_id":"subscription_id:base_plan_id"}' \
  https://s2s.purchasely.io/receipts
```
```ruby Ruby
require 'net/http'
require 'json'

# Url
url = URI('https://s2s.purchasely.io/receipts')
request = Net::HTTP::Post.new(url)

# Headers
request['Content-Type'] = 'application/json'
request['X-API-KEY'] = '00000000-1111-2222-3333-444444444444'
request['X-PLATFORM-TYPE'] = 'PLAY_STORE'

# Payload
payload = {
  purchase_token: "aaaNNNcccDDDeeeFFF",
  user_id: "1234",
  store_product_id: "subscription_id:base_plan_id"
}
request.body = payload.to_json

# Send request
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
response = http.request(request)

# Response
case response.code
when '200'
  transaction_id = JSON.parse(response.body)['id']
when '403', '422'
  errors = JSON.parse(response.body)['errors']
end
```

<br />

<br />

# Bulk import

| Easiness | Speed | Accuracy |
| :------- | :---- | :------- |
| ★★☆☆☆    | ★★★☆☆ | ★★★★★    |

This method is reserved for imports of more than 10k purchases. Please contact our team to schedule it.

> 🚧 Good to Know
>
> Depending on the number of purchases, this import can take anywhere from several hours to several weeks. It might be including in your licence fee or require to pay an extra fee. Reach out to your Customer Success team to discuss it.

To ensure we have all your subscriptions, you will need to proceed in two steps:

1. Use the endpoint described in the previous section to send us any new purchase made on a version of your application that does not contain the Purchasely SDK. From this date, we will be aware of all new subscriptions.
2. Export all your existing active subscriptions. Up to this date, we will be aware of all existing purchases.

<Image align="center" src="https://files.readme.io/4cbe9c3-import-migration.drawio.svg" />

<br />

## Steps

1. Use our dedicated endpoint for you new purchases (cf. previous section)
2. Export your existing active purchases into a CSV
   1. we'll need different files for each platform (Apple, Google, ...)
   2. each file should contain the exact same data as the one sent to our endpoint:

<br />

<Table align={["left","left","left","left"]}>
  <thead>
    <tr>
      <th>
        Column name
      </th>

      <th>
        Type
      </th>

      <th>
        Mandatory for
      </th>

      <th>
        Description
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        user\_id
      </td>

      <td>
        String
      </td>

      <td>
        All
      </td>

      <td>
        Identifier of your user as defined in your backend (and declared to our SDK).  

        The purchase will be associated to this id in all Purchasely's platform (console, webhooks, integrations)
      </td>
    </tr>

    <tr>
      <td>
        store\_product\_id
      </td>

      <td>
        String
      </td>

      <td>
        All
      </td>

      <td>
        Product identifier, as defined in your store's console.  

        ⚠ if you're using Google Play Billing with a version >= 5, please format your store\_product\_id this way: `subscription_id:base_plan_id`
      </td>
    </tr>

    <tr>
      <td>
        original\_transaction\_id
      </td>

      <td>
        String
      </td>

      <td>
        Apple
      </td>

      <td>
        Only if **you have configured StoreKit2** on Purchasely (this value is exclusive with `receipt_data`).  

        [original\_transaction\_id](https://developer.apple.com/documentation/appstoreserverapi/originaltransactionid) associated with your purchase.
      </td>
    </tr>

    <tr>
      <td>
        receipt\_data
      </td>

      <td>
        String
      </td>

      <td>
        Apple
      </td>

      <td>
        Only if **you have NOT configured StoreKit2** on Purchasely (this value is exclusive with `original_transaction_id`).  

        Base64 encoded receipt data given by the SDK during the purchase, used to request App Store servers.
      </td>
    </tr>

    <tr>
      <td>
        purchase\_token
      </td>

      <td>
        String
      </td>

      <td>
        Google & Huawei
      </td>

      <td>
        Purchase token given by the SDK during the purchase, which is a unique identifier that represents the user and the product ID for the in-app product they purchased
      </td>
    </tr>

    <tr>
      <td>
        subscription\_id
      </td>

      <td>
        String
      </td>

      <td>
        Huawei
      </td>

      <td>
        Huawei Subscription ID
      </td>
    </tr>

    <tr>
      <td>
        account\_flag
      </td>

      <td>
        Integer
      </td>

      <td>
        Huawei
      </td>

      <td>
        possible values:  

        * `0` for "Germany"
        * `1` for "AppTouch site of Germany"\
          @see [Site Information](https://developer.huawei.com/consumer/en/doc/HMS-References/iap-api-specification-related-v4#h1-1578554539083-0)
      </td>
    </tr>

    <tr>
      <td>
        stripe\_object\_type
      </td>

      <td>
        String
      </td>

      <td>
        Stripe
      </td>

      <td>
        possible values:  

        * `subscription`
        * `checkout_session`
      </td>
    </tr>

    <tr>
      <td>
        stripe\_object\_id
      </td>

      <td>
        String
      </td>

      <td>
        Stripe
      </td>

      <td>
        Stripe identifier of the [subscription](https://docs.stripe.com/api/subscriptions)/[checkout\_session](https://docs.stripe.com/api/checkout/sessions)
      </td>
    </tr>

    <tr>
      <td>
        stripe\_price\_id
      </td>

      <td>
        String
      </td>

      <td>
        Stripe
      </td>

      <td>
        Stripe identifier for the [price](https://docs.stripe.com/api/prices) associated to your purchase
      </td>
    </tr>
  </tbody>
</Table>

<br />

Here are some CSV examples:

```json Apple App Store - StoreKit 1
receipt_data;user_id;country
abcdFEbsbs;1234;FR
```
```json Apple App Store - StoreKit 2
original_transaction_id;user_id
310001721313211;1234
```
```json Google Play Store - < Billing v5
purchase_token;store_product_id;user_id
aaaNNNcccDDDeeeFFF;subscription_id;1234
```
```json Google Play Store - < Billing v5
purchase_token;store_product_id;user_id
aaaNNNcccDDDeeeFFF;subscription_id:base_plan_id;1234
```
