---
title: OneSignal
excerpt: >-
  This section describes how to integrate OneSignal with Purchasely to trigger
  automatic campaigns or push notifications
deprecated: false
hidden: false
metadata:
  title: ''
  description: >-
    This document explains how to integrate Purchasely subscription events with
    OneSignal to trigger automated communication based on those events and
    engage, upsell, and retain customers. It provides instructions for SDK
    integration, console configuration, retrieving OneSignal information,
    setting user properties, and testing the integration.
  robots: index
next:
  description: ''
---
# Overview

[OneSignal](https://www.onesignal.com/) is one of the leading customer engagement solutions for Push Notifications, Email, SMS & In-App.

By integrating Purchasely with OneSignal, you can have Purchasely update User Properties in real time when something happens in the subscription lifecycle, which will allow you to create campaigns and automations in OneSignal based on these properties. These engagement messages can then be linked to a Purchasely paywall to enhance customer engagement, encourage upsells, and improve retention.

More information on the kind of automations you can create by combining both platform available [here](engagement-crm#sample-automations--campaigns).

<br />

# Integrating Purchasely with OneSignal

The integration requires 4 steps:

1. Map users with their OneSignal External User ID inside the app (SDK implementation)
2. Activate the **OneSignal** integration in the Purchasely Console
3. Enable the update of User Properties in the Purchasely Console
4. Test your integration

<br />

## 1 - Map users with their OneSignal External User ID inside the app (SDK implementation)

To accurately map your OneSignal External User ID with your Purchasely user ID, you need to set the appropriate attribute in the Purchasely SDK. 

> 📘 Migration from the Player ID model to the User-Centric Model
> 
> OneSignal updated to a new [User-Centric Data Model](https://documentation.onesignal.com/docs/user-model). This new OneSignal User Model, relying on a OneSignal External User ID, matches much better Purchasely's User centric model which will allow a much better match between OneSignal Purchasely users.
> 
> If you are currently using the legacy OneSignal Player ID, we (OneSignal and Purchasely) strongly suggest to update to OneSignal's latest SDKs and APIs as soon as possible, to continue to get the most out of the OneSignal-Purchasely integration.
> 
> Follow [OneSignal's migration guide](https://documentation.onesignal.com/docs/user-model-migration-guide) to achieve this switch.
> 
> Other useful links provided by OneSignal:
> 
> - [OneSignal Mobile SDKs. 5.0.0 and later](https://documentation.onesignal.com/docs/mobile-sdk-reference)
> - [OneSignal Web SDK 16.0.0 and later](https://documentation.onesignal.com/docs/web-sdk-reference)
> - [API Version 11.0 and later](https://documentation.onesignal.com/reference/quick-start-api-guide)
> 
> Please reach out to [support@onesignal.com](mailto:support@onesignal.com) with any questions on this update.
> 
> For information, purchases relying on the legacy OneSignal PlayerID model will continue working but OneSignal Users and Purchasely Users might not be mapped with the same level of accuracy.

To map users, you can choose one of the following two options:

1. (Preferred) [OneSignal External User ID](https://documentation.onesignal.com/docs/mobile-sdk-reference#getonesignalid) which you set to OneSignal SDK
2. [OneSignal User ID](https://documentation.onesignal.com/docs/mobile-sdk-reference#getonesignalid) provided directly by OneSignal that cannot be changed

```swift Swift
// External User ID
if let externalId = OneSignal.User.externalId {
	Purchasely.setAttribute(.oneSignalExternalId, value: externalId)
}

// OR OneSignal User Id
if let onesignalId = OneSignal.User.onesignalId {
	Purchasely.setAttribute(.onesignalUserId, value: onesignalId)
}
```
```kotlin Kotlin
// External User ID
OneSignal.User.externalId?.let {
	Purchasely.setAttribute(Attribute.ONESIGNAL_EXTERNAL_ID, it)
}

// OR OneSignal User Id
OneSignal.User.onesignalId?.let {
	Purchasely.setAttribute(Attribute.ONESIGNAL_USER_ID, it)
}
```
```typescript React Native
// External User ID
const externalId = await OneSignal.User.getExternalId();
Purchasely.setAttribute(Attributes.ONESIGNAL_EXTERNAL_ID, externalId);

// OR OneSignal User Id
const userId = await OneSignal.User.getOnesignalId();
Purchasely.setAttribute(Attributes.ONESIGNAL_USER_ID, userId);
```
```typescript Flutter
// External User ID
const externalId = await OneSignal.User.getExternalId();
Purchasely.setAttribute(Attributes.ONESIGNAL_EXTERNAL_ID, externalId);

// OR OneSignal User Id
const userId = await OneSignal.User.getOnesignalId();
Purchasely.setAttribute(Attributes.ONESIGNAL_USER_ID, userId);
```
```typescript Cordova
// External User ID
const externalId = await window.plugins.OneSignal.User.getExternalId();
Purchasely.setAttribute(Purchasely.Attribute.ONESIGNAL_EXTERNAL_ID, externalId);

// OR OneSignal User Id
const userId = await window.plugins.OneSignal.User.getOnesignalId();
Purchasely.setAttribute(Purchasely.Attribute.ONESIGNAL_USER_ID, userId);
```

> 🚧 Keep in mind
> 
> This attribute will **only be set for new users who perform a new purchase or become subscribers**.
> 
> In other words, you won't receive in OneSignal user properties updates for purchases made before completing the OneSignal integration with the SDK or for subscribers who started their subscription before the OneSignal integration.

All previous purchases with a OneSignal Player ID will still be sent with the old OneSignal API.

## 2 - Activate the OneSignal integration in the Purchasely Console

In the Purchasely Console, navigate to the [Integrations](https://console.purchasely.io/external-integrations) section and click on OneSignal

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/93343c6-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Then,

1. Activate the integration
2. Enter your API Key from you OneSignal dashboard
3. Enter you App ID from your OneSignal dashboard

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/53feee1-SCR-20240712-kvbt.png",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


### Retrieving OneSignal information

Login to your [OneSignal dashboard](https://app.onesignal.com/login)  and navigate to **Settings >> Keys & IDs**

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/52c2b8f-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


1. Get your `OneSignal App ID`
2. Get you `Rest API Key`

## 3 - Enable the update of User Properties in the Purchasely Console

In the Purchasely Console, under the tab User Properties, you can choose with User Properties should be updated in real time along the subscription lifecycle.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/acaf790-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


(Optional) User Properties names can be overridden to match with your nomenclature.

Details on User Properties are accessible [here](engagement-crm#leveraging-user-properties).

## 4 - Test your integration

To test your integration, you can perform a set of in-app purchases in a Sandbox environment (eg: TestFlight for the App Store) and verify your user's tags are properly updated in the [OneSignal dashboard](https://app.onesignal.com/login).

> 📘 Delay for Automated Messages
> 
> If testing using Automated Messages, bear in mind that OneSignal automated messages are sent roughly every 4-6 hours if you are on a free plan, and within a few minutes if you are on a paid plan.