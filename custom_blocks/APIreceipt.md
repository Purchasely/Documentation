---
name: API /receipt
---
**POST[https://s2s.purchasely.io/receipts](https://s2s.purchasely.io/receipts)**

**HEADERS**

<Table align={["left","left","left","left"]}>
  <thead>
    <tr>
      <th style={{ textAlign: "left" }}>
        Name
      </th>

      <th style={{ textAlign: "left" }}>
        Type
      </th>

      <th style={{ textAlign: "left" }}>
        Mandatory for
      </th>

      <th style={{ textAlign: "left" }}>
        Description
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td style={{ textAlign: "left" }}>
        X-API-KEY
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        All
      </td>

      <td style={{ textAlign: "left" }}>
        API Key associated to your application (available in the Purchasely console)
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        X-PLATFORM-TYPE
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        All
      </td>

      <td style={{ textAlign: "left" }}>
        possible values:  

        * `APP_STORE`
        * `PLAY_STORE`
        * `APPGALLERY`
        * `STRIPE`
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        Content-Type
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        All
      </td>

      <td style={{ textAlign: "left" }}>
        `application/json`
      </td>
    </tr>
  </tbody>
</Table>

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

    <tr>
      <td>
        ply\_context
      </td>

      <td>
        String
      </td>

      <td>
        Stripe
      </td>

      <td>
        Parameter attached to the body of the POST request when opening a web checkout flow from the app, containing the  context of the purchase initiated in the app.\
        Encoded in `base64`
      </td>
    </tr>
  </tbody>
</Table>
