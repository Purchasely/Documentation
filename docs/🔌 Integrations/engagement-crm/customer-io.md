---
title: Customer.io
excerpt: >-
  This section describes how to activate the integration between Customer.io and
  Purchasely
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Overview

[Customer.io](https://customer.io/) is a robust customer engagement platform that enables targeted and automated messaging through Email, Push Notifications, SMS, and more.

By integrating Purchasely with Customer.io, you can send Purchasely [server events](server-events) to Customer.io to trigger automated communications based on these events. These messages can be linked to a Purchasely paywall to enhance customer engagement, encourage upsells, and improve retention.

<br />

# Integrating Purchasely with Customer.io

The integration requires 5 steps:

1. Activate the **Customer.io** integration in the Purchasely Console
2. Enable the forwarding of [Server Events](server-events) in the Purchasely Console
3. Enable the update of User Properties in the Purchasely Console
4. Associate users with a Customer.io User ID (SDK implementation)

## 1 - Activate the Customer.io integration in the Purchasely Console

In the Purchasely Console, navigate to the [Integrations](https://console.purchasely.io/external-integrations) section and click on **Customer.io**

- Activate the integration
- Enter your API Key from **Customer.io** dashboard
- Enter your Site ID from **Customer.io** dashboard
- Set your region (US or EU)

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/159a533-SCR-20240726-ojld.png",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/0a1a340-SCR-20240726-ojps.png",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


### Retrieve Customer.io information

#### API Key

- Access the Customer.io API [Credentials Management dashboard](<>)
- If necessary, create a new Tracking API key for your app
- Write down your API Key and Site ID

#### Region

- Follow [Customer.io documentation](https://customer.io/docs/data-centers/#how-do-i-know-what-region-my-data-is-in)
- Write down your Region

<br />

## 2 - Enable the forwarding of Server Events in the Purchasely Console

In the Purchasely Console, under the tab Server Events, you can choose with Server Events must be forwarded to **Customer.io**.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/eba4247-SCR-20240726-ojws.png",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


(Optional) Events names can be overridden to match with your tacking plan.

<br />

## 3 - Enable the update of User Properties in the Purchasely Console

In the Purchasely Console, under the tab User Properties, you can choose with User Properties should be updated in real time along the subscription lifecycle.

![](https://files.readme.io/b7d3d2e-image.png)

(Optional) User Properties names can be overridden to match with your nomenclature.

Details on User Properties are accessible [here](engagement-crm#leveraging-user-properties).

<br />

## 4 - Associate users with a Customer.io User ID (SDK implementation)

To accurately map your Customer.IO user ID with your Purchasely user ID, you need to set the appropriate attribute in the Purchasely SDK. You can also setup a user email if needed.  
Look at [Customer.IO Documentation](https://customer.io/docs/) to retrieve the mentioned properties.

```swift Swift
// Customer.IO User Id
Purchasely.setAttribute(.customerIOUserId, value: userId)

// Customer.IO Email
Purchasely.setAttribute(.customerIOUserEmail, value: email)
```
```kotlin Kotlin
// Customer.IO User Id
Purchasely.setAttribute(Attribute.CUSTOMERIO_USER_ID, id)

// Customer.IO Email
Purchasely.setAttribute(Attribute.CUSTOMERIO_USER_EMAIL, email)
```
```typescript React Native
// Customer.IO User Id
Purchasely.setAttribute(Attributes.CUSTOMERIO_USER_ID, id);

// Customer.IO Email
Purchasely.setAttribute(Attributes.CUSTOMERIO_USER_EMAIL, email);
```
```typescript Flutter
// Customer.IO User Id
Purchasely.setAttribute(Attributes.CUSTOMERIO_USER_ID, id);

// Customer.IO Email
Purchasely.setAttribute(Attributes.CUSTOMERIO_USER_EMAIL, email);
```
```typescript Cordova
// Customer.IO User Id
Purchasely.setAttribute(Purchasely.Attribute.CUSTOMERIO_USER_ID, id);

// Customer.IO Email
Purchasely.setAttribute(Purchasely.Attribute.CUSTOMERIO_USER_EMAIL, email);
```

This attribute will **only be set for new purchases**. You won't receive events for purchases made before completing the Customer.IO integration with the SDK.