---
title: Migration guide
excerpt: >-
  This section provides an overlook of the steps to follow to migrate to
  Purchasely
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    Start migrating to Purchasely by importing your catalogue of In-App
    Purchases & Subscriptions
  pages:
    - type: basic
      slug: catalogue-import
      title: Importing your catalogue of In-App Purchases & Subscriptions
---
If you're building in-app purchases into your app for the first time, a migration should not be required and you should start instead from the [Quick start guide](sdk-quick-start).

If you already have an existing app that is using subscriptions, you can follow this guide to migrate to Purchasely.

<br />

Follow these steps to migrate to Purchasely:

### 1. [Import your catalogue In-App Purchases & Subscriptions](catalogue-import)

*This step will avoid you to recreate all your catalogue of In-App Purchases and In-App Subscriptions manually in the Purchasely Console.*

If you only have a few products configured in the App Store Connect and Google Play Store console, you can do it manually but above 10 products, it can become fastidious.

> 🚧 Finalize the import of your catalogue
>
> Before importing your active subscriber base, it is really important to fully finalize the import / configuration of your catalogue of In-App Purchases and Subscriptions. Even the legacy plans that you don't sell anymore. In other words, every product ever sold in production in the App stores and purchased by at least one customer should be integrated in the Purchasely Console.
>
> If you don't, the Purchasely Platform will auto-generate Plans when receiving renewing notifications from the App stores for existing subscribers who are still active on legacy plans.

<br />

### 2. [Import your active subscriber base](subscribers-base-import)

*This step will allow you to have up-to-date numbers in the Purchasely Dashboards.*

If you don't import the subscribers who started their subscription prior to the integration of Purchasely into your app, the Purchasely Dashboards will only be able to show the subscribers it knows. In other words: 

* the subscribers who have purchased their subscription from an app version integrating the Purchasely SDK
* the subscribers for which a Server notification has been received from the App stores. Subscribers that have only been fetched by Purchasely through Server notifications will be counted as <Glossary>unknown user</Glossary>, as Purchasely could only get the receipt without being able to attach it to a `user ID` or `anonymous user ID`

<br />

> 🚧 Discuss with a Purchasely expert to build your custom migration plan
>
> Depending on your volume, the migration of your active subscriber base can require you to pay a migration fee. 
>
> Don't hesitate to [contact sales](https://www.purchasely.com/plan-demo) to see how we can help with the process.
