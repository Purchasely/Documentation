---
title: Play Store - Configuring In-App Purchases
excerpt: >-
  This section provides details on how to configure In-App Purchases in the Play
  Store with the Google Play Console
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
<InAppPurchasesOneTimePurchasesDefinition />

## Creating In-App Purchases

> 📘 Non consumable and Lifetime In-App Purchases
>
> There is no concept of Non Consumable or Lifetime product in the Google Play Console. A Non consumable or a Lifetime product is just an In-App Purchases which is never "consumed" by the app.
>
> By matching the proper type in the Purchasely Console, you will configure the behavior of the SDK. In `full` mode:
>
> * the SDK will consume In-App Purchases configured as consumable, right after the transaction was processed, 
> * and do nothing for In-App Purchases configured as Non consumable.
>
> If you would like to create a Life time product for your Android users, you can create a consumable plan as shown in the following steps and mark it as `Non consumable` as its type in the Purchasely Products and Plans section.

<br />

Now, let us see how to create a Consumable product in Google Play Console:

1. Login to your [Google Play Console](https://play.google.com/console/u/0/developers) and select your app

<Image align="center" className="border" border={true} src="https://files.readme.io/3656d81-image.png" />

2. In the following screen, navigate to the following section: **Monetize > Products > In-app products**

<Image align="center" className="border" border={true} src="https://files.readme.io/2e2e99c-image.png" />

3. Click on the **Create product** button

<Image align="center" className="border" border={true} src="https://files.readme.io/8ee663c-image.png" />

4. In the Create in-app product page, provide the
   * `Product ID`:  A unique ID for your in-app product.\
     *This is the ID you have to map to the<Glossary>Plan</Glossary> in the Purchasely Console in the [Products and plans section](https://console.purchasely.io/products-plans)*. 
   * `Name`: A short name of the item (up to 55 characters, but we recommend limiting titles to 25 characters to display properly in all contexts).
   * `Description`: A long description of the item (up to 200 characters).

<Image align="center" className="border" border={true} src="https://files.readme.io/fa67b96-image.png" />

5. Its time to set the price for this product

<Image align="center" className="border" border={true} src="https://files.readme.io/75a9686-image.png" />

6. Type the price and click on the Apply prices button.

<Image align="center" className="border" border={true} src="https://files.readme.io/d995767-image.png" />

7. You can then choose whether this In-App Purchase can be purchased multiple times or not in a single transaction by ticking the checkbox `Multiple quantity`

<Image align="center" className="border" border={true} src="https://files.readme.io/a03dbde-image.png" />
