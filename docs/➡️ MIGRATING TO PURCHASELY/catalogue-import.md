---
title: Importing your catalogue of In-App Purchases & Subscriptions
excerpt: >-
  This sections provides details on how to ease the creation of your catalogue
  of Products & Plans in the Purchasely Console
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
If you have a lot of In-App Purchases or In-App Subscriptions to import, it becomes fastidious to remap all of them with the Purchasely Console. To ease the process, you can instead:

1. fill in this [CSV file](https://docs.google.com/spreadsheets/d/1ssTdclthE09DAiy1Xul7XfQ8ra4JuUmPKtAC0T-e5TE/edit?usp=sharing)
2. send it to us once filled at [support@purchasely.com.](mailto:support@purchasely.com.)

=> We will import your catalogue of Products and Plans in the Purchasely Console for you.

<br />

<br />

## Products & plans

<Image align="center" border={false} width="700px" src="https://files.readme.io/923bbce36f706f108d4b97a2307392c52817cbec8a89b054cdfb9d8afa8c2f71-Screenshot_2026-01-07_at_14.37.11.png" />

In Purchasely:

* a **product** (green in the screenshot) is the equivalent of an iOS "Subscription Group" or a Google "Subscription". In short, a user can only have 1 subscription at a time within the same product (which means if a user is already a subscriber to a monthly, and subscribed to a yearly in the same product, the monthly will be replaced with the yearly)
* a **plan** (orange in the screenshot) is the equivalent of an iOS "Subscription / In-App Purchase" or a Google "Base plan". A plan is the way to regroup 2 equivalent SKUs from Google and Apple under the same entity in Purchasely. It's particularly useful when creating a paywall: you'll be able to use the same "purchase button" for both iOS and android, and won't need to create 2 identical screens for iOS and android.

<br />

What's expected in the CSV:

* `Product name`: this is the name that will be displayed in the Purchasely console ("Sample product" in the screenshot) and is not used anywhere else. It doesn't need to match any value from Apple or Google
* `Product id`: this is the identifier that will be used by Purchasely ("sample_product" in the screenshot) when communicating with you. For example, it will be used:
  * in our webhooks under the property name `product` (cf. <Anchor label="server events" target="_blank" href="https://docs.purchasely.com/docs/server-events-attributes">server events</Anchor>)
  * when sending events to the configured integrations

<Callout icon="❗️">
  Only alphanumerics characters (0-9, a-z, A-Z), `_`and `-` are authorised
</Callout>

* `Plan name`: this is the name that will be displayed in the Purchasely console ("Sample plan" in the screenshot) and is not used anywhere else. It doesn't need to match any value from Apple or Google
* `Plan id`:  this is the identifier that will be used by Purchasely ("sample_plan" in the screenshot) when communicating with you. For example, it will be used:
  * in our webhooks under the property name `plan` (cf. <Anchor label="server events" target="_blank" href="https://docs.purchasely.com/docs/server-events-attributes">server events</Anchor>)
  * when sending events to the configured integrations

<Callout icon="❗️" theme="error">
  Only alphanumerics characters (0-9, a-z, A-Z), `_`and `-` are authorised
</Callout>

<Callout icon="❗️" theme="error">
  If you import multiple plans for the same product:

  * all the `Product name` columns should be equal
  * all the `Product id` columns should be equal
</Callout>

* `Level`: allows to define upgrade/downgrade/crossgrade policies within a Product (cf. [Ordering the Plans inside a Product](https://docs.purchasely.com/docs/product-plans-setup#ordering-the-plans-inside-a-product) for more details)
* `Type`: the following values are accepted
  * `RENEWING_SUBSCRIPTION`
  * `NON_RENEWING_SUBSCRIPTION`
  * `CONSUMABLE`
  * `NON_CONSUMABLE`
* `ID Apple`: it corresponds to the `PRODUCT ID` column in the App Store Connect (screenshot bellow shows **subscriptions**. You can use the same `PRODUCT ID` column for **In-App Purchases**)

<Image align="center" border={false} src="https://files.readme.io/bc0c95426fecdbcc2543310fb4fd6de266520c12bd61c6e85cd14e428d70062a-Screenshot_2026-01-07_at_15.07.24.png" />

<Callout icon="📘" theme="info">
  If you only want to do the import for Google subscriptions, you can leave it empty
</Callout>

* `ID Google` / `Base plan id Google`: present in the Google Play Console

<Image align="center" border={false} src="https://files.readme.io/fc80f365f967c908568561a13326591fd80fe56774c80fecd67af83d8fe397f6-Screenshot_2026-01-07_at_15.12.58.png" />

<Callout icon="📘" theme="info">
  If you only want to do the import for Apple subscriptions, you can leave them empty
</Callout>

* `Periodicity`: the following values are accepted (only for renewing and non renewing subscriptions)
  * `P1W`: weekly subscriptions
  * `P2W`: bi-weekly subscriptions
  * `P1M`: monthly subscriptions
  * `P2M`: bi-monthly subscriptions
  * `P3M`: quarterly subscriptions
  * `P6M`: 6 months subscriptions
  * `P1Y`: yearly subscriptions

<br />

## Best strategy to fill the CSV file in

* fully read the <Anchor label="Product & plans setup" target="_blank" href="https://docs.purchasely.com/docs/product-plans-setup#ordering-the-plans-inside-a-product">Product & plans setup</Anchor> doc to understand these notions
* **then** for iOS, organize your products/plans the same way they are configured in the store
* **then** for Google:
  * try regrouping equivalent SKU from Apple and Google in the same plans. It will make your life easier when you'll create Purchasely paywalls
  * if no equivalent SKU exists on Apple, create a new Purchasely plan in the appropriate Purchasely product (ie: in a product containing plans a user can't subscribe at the same time with your new plan
