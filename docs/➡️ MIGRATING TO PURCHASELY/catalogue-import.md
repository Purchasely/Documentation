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

The following values for the field `Type` are accepted

- `RENEWING_SUBSCRIPTION`
- `NON_RENEWING_SUBSCRIPTION`
- `CONSUMABLE`
- `NON_CONSUMABLE`

<br />

The following values for the field `Periodicity` are accepted (only for renewing and non renewing subscriptions)

- `P1W`: weekly subscriptions
- `P2W`: bi-weekly subscriptions
- `P1M`: monthly subscriptions
- `P2M`: bi-monthly subscriptions
- `P3M`: quarterly subscriptions
- `P6M`: 6 months subscriptions
- `P1Y`: yearly subscriptions

<br />

> 📘 Google Play Base Plan
> 
> Google Base Plan Id is required to work with Google Play Billing v5 and v6  
> If you only want to do the import for Apple subscriptions, you can leave it empty