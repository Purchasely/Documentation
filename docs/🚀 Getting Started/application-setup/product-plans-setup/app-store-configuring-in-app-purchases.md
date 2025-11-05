---
title: App Store - Configuring In-App Purchases
excerpt: >-
  This section provides details on how to configure In-App Purchases in the App
  Store with the App Store Connect Console
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

<br />

## Creating Consumables and Non Consumables

Go to [App Store Connect](https://appstoreconnect.apple.com/login)'s '**Apps**' page 

<Image align="center" className="border" border={true} src="https://files.readme.io/0b4cbc8-image.png" />

and select the **name** of your app from the list.

<Image align="center" className="border" border={true} src="https://files.readme.io/a30f4bf-image.png" />

In the sidebar, select '**In App Purchases**' under **Monetization**,

<Image align="center" className="border" border={true} src="https://files.readme.io/f6f0863-image.png" />

Click on the "+" button, 

<Image align="center" className="border" border={true} src="https://files.readme.io/0966342-image.png" />

<br />

Choose the 

1. `Type of the In-App Purchase`: Consumable / Non Consumable
2. `Reference Name`: The reference name will be used on App Store Connect and in Sales and Trends reports. It won't be displayed on the App Store. The name can't be longer than 64 characters.
3. `Product ID`: A unique alphanumeric ID that is used for reporting. After you use a `Product ID` for one product, it can’t be used again, even if the product is deleted. This `Product ID` will have to be mapped with the corresponding <Glossary>Plan</Glossary> in the Purchasely Console.

For this demo, we are choosing Consumable

<Image align="center" className="border" border={true} src="https://files.readme.io/d695f83-image.png" />

Choose the countries you want to see this product, 

<Image align="center" className="border" border={true} src="https://files.readme.io/99b83e9-image.png" />

Set the price and click **Next**

<Image align="center" className="border" border={true} src="https://files.readme.io/26b0819-image.png" />

In the next screen, you can modify the price for specific country of region

<Image align="center" className="border" border={true} src="https://files.readme.io/930a8a7-image.png" />

The following screen will show the summary of the plan, price and region. If it looks fine, you can click **Confirm** 

<Image align="center" className="border" border={true} src="https://files.readme.io/a65decb-image.png" />

### Adding Localization

The next step is to set up localization information of the plan created above.  This is the name and description of the In-App Purchase that the user will see.

In the App Store Information section, click the Add localization button. 

<Image align="center" className="border" border={true} src="https://files.readme.io/6be5339-image.png" />

Choose the language, display name and add a description and click add once done. 

The `In-App Purchase Display Name` and `Description` will be visible to the user on the App Store and in their subscription management settings. 

<Image align="center" className="border" border={true} src="https://files.readme.io/0a8f55c-image.png" />

<br />

### Add Reviewer Information

The last part of setting up an In-App Purchase in iOS is adding information for the reviewer. This is a Screenshot, and optional `Review Notes`. You'll be unable to submit your product for review without it.

`Screenshot`: A required image of your in-app purchase paywall for the reviewer. While testing, it's okay to upload an empty 640 x 920 image here of whatever you want. Before submitting for review, you should add a picture of your paywall.

`Review Notes`: An optional text area to clarify anything about your in-app purchase for the reviewer.

<Image align="center" className="border" border={true} src="https://files.readme.io/34afd11-image.png" />
