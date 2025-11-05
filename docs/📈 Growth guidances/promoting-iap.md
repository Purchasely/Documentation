---
title: Promoting your subscriptions on the App Store
excerpt: >-
  Leverage promoted In-App Purchases for a better ASO, searchability and
  conversion.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
67% of App Stores downloads come from the search, what if you could get **more opportunities for featuring, better ranking** and **more real estate on the App Store** search.\
This is what [Promoted In App Purchases](https://developer.apple.com/app-store/promoting-in-app-purchases/) is all about.

<Image alt="Example of Promoted subscriptions on the app product page on the App Store" align="center" border={true} src="https://files.readme.io/4c22485-Untitled.001.jpeg">
  Example of Promoted subscriptions on the app product page on the App Store
</Image>

<br />

# What are Promoted In App Purchases

Promoted IAP are subscriptions, consumables and non-consumables you can display on your app product page. They are also discoverable through the search and thus offer you more exposure.

Few things to know:

* You **need to chose** which products you want to promote. It can be a good opportunity for you to settle a price in your customers head, either cheaper than the competition or a high price you will be able to discount once the app is downloaded.
* You can promote up to 20 in-app purchases at a certain time, you can select them and will have to provide different images for each.
* If a user chooses to purchase he will first download the app (if he doesn't have it) then he will be redirected to the app.\
  Once the app is opened:
  * If it is a consumable you can proceed to payment directly
  * **If it is a subscription**, you cannot process to purchase and **must display a paywall** containing the terms and conditions (a mandatory step for Apple).

<br />

# How Purchasely helps

Purchasely handles:

* The action triggered (purchase or paywall display) depending on the product type is handled
* Hiding the products that are already purchased so that the user won't see something he already purchased

<br />

# Setting-up the App Store and Purchasely

<Image alt="App Store Connect offers the possibility to set promotional in each product and subscription" align="center" src="https://files.readme.io/b9e6ce4-Screenshot_2024-05-27_at_09.50.01.png">
  App Store Connect offers the possibility to set promotional in each product and subscription
</Image>

In App Store Connect, you will have to 

1. Add a promotional artwork following [Apple Guidelines](https://developer.apple.com/help/app-store-connect/manage-in-app-purchases/view-and-edit-in-app-purchase-information/)
2. [Select In-App Purchases](https://developer.apple.com/help/app-store-connect/configure-in-app-purchase-settings/promote-in-app-purchases/) you would like to promote

<br />

As Apple requires that subscriptions are first presented on a paywall. **Purchasely allows you to select which paywall** for each product. That way, if a customer selected a yearly offer you can avoid second thoughts by displaying a paywall only with yearly choice.\
This can be done from `Products & Plans > Edit`

<Image alt="In Purchasely Console, for each product you can select which paywall is displayed when the user purchases from the store. " align="center" src="https://files.readme.io/7df2158-Screenshot_2024-05-27_at_10.29.42.png">
  In Purchasely Console, for each product you can select which paywall is displayed when the user purchases from the store. 
</Image>

<br />

# Implementation

The **only thing you have to do** is tell Purchasely whenever it is ok to launch the process (purchase or paywall). To do that you need to call the following method whenever your app finished initialization / on-boarding or any other step that shall defer the purchase.

Keep in mind the more you add steps before the less likely the user will finish the transaction.

```swift Swift
Purchasely.readyToOpenDeeplink(true)
```
```objectivec Objective-C
[Purchasely isReadyToPurchase: YES];
```

<br />

# Testing

To test the flow before you submit your app or your promotion, you can do the following:\
Copy `itms-services://?action=purchaseIntent&bundleId=APP_BUNDLE_ID&productIdentifier=IN_APP_PRODUCT_ID` 

Replace `APP_BUNDLE_ID` and `IN_APP_PRODUCT_ID` by the appropriate values and paste it into **Notes** or **Safari** app.

Clicking on it will start a purchase action just like the App Store would.
