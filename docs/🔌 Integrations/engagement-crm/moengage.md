---
title: MoEngage
excerpt: This section describes how to integrate MoEngage with Purchasely
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
> 🚧 The minimal version of the Purchasely SDK supporting this integration is 3.6.0. If the Purchasely SDK integrated in your app is under the minimal version, please update it. The **MoEngage** SDK also needs to be integrated inside the app.

<br />

# General overview

[MoEngage](https://www.moengage.com/) is a leading Customer Engagement Platform.

This integration will allow you to get all the available Purchasely events to CleverTap and get a better and deeper understanding of your subscription business and customer behavior. In addition you will be able to trigger automated communication based on those events, messages that could be linked to a Purchasely powered Screen to engage, upsell, retain customers.

<br />

# Integrating Purchasely with MoEngage

The integration requires 5 steps:

1. Associate users with the `MoEngage Unique ID` (SDK implementation)
2. Activate the **MoEngage** integration in the Purchasely Console
3. Enable the forwarding of [Server Events](server-events) in the Purchasely Console
4. Enable the update of User Properties in the Purchasely Console

<br />

<br />

## 1 - Associating users with the MoEngage Unique ID (SDK implementation)

Associate the user to events by providing the `MoEngage Unique ID` to the Purchasely SDK

```Text Swift
Purchasely.setAttribute(.moEngageUnqueId, value: "your moEngage Unique Id")
```
```Text Kotlin
Purchasely.setAttribute(Attribute.MOENGAGE_UNIQUE_ID, "Your unique id")
```
```Text ReactNative
Purchasely.setAttribute(Attributes.MOENGAGE_UNIQUE_ID, id);
```
```Text Cordova
Purchasely.setAttribute(Purchasely.Attribute.MOENGAGE_UNIQUE_ID, id);
```
```Text Flutter
Purchasely.setAttribute(PLYAttribute.moengageUniqueId, id);
```
```Text Unity
private PurchaselyRuntime.Purchasely _purchasely;
...
_purchasely.SetAttribute(PLYAttribute.MOENGAGE_UNIQUE_ID, id);
```

See the[ MoEngage Documentation ](https://developers.moengage.com/)for more information

## 2 - Activating the MoEngage integration

### Enabling the MoEngage integration in the Purchasely Console

Go in the "External integrations" section, and open the edition form for **MoEngage**:

<Image align="center" className="border" border={true} src="https://files.readme.io/3b289d3-Capture_decran_2024-07-22_a_15.45.06.png" />

Enable the integration and configure it

<Image align="center" className="border" border={true} src="https://files.readme.io/ef5e3b2-Capture_decran_2024-07-22_a_15.45.16.png" />

1. Set your **MoEngage** *APP\_ID*
2. Set your **MoEngage** *DATA API ID*
3. Set your **MoEngage***DATA API KEY*

<br />

### Retrieving your MoEngage APP ID from MoEngage's dashboard

* The *APP\_ID* for your MoEngage account is available on the MoEngage Dashboard in *Settings > App Settings > General Settings > Account Settings > APP ID*.
* Write down your *APP ID*

### Retrieving your MoEngage DATA API ID from MoEngage's dashboard

* The *APP\_ID* for your MoEngage account is available on the MoEngage Dashboard in *Settings > App Settings > General Settings > Data API settings > DATA API ID*
* Write down your *DATA API ID*

### Retrieve your MoEngage DATA API ID from MoEngage's dashboard

* The *APP\_ID* for your MoEngage account is available on the MoEngage Dashboard in *Settings > App Settings > General Settings > Data API settings > DATA API KEY*
* Write down your *DATA API KEY*

<br />

<br />

## 3 - Enable the forwarding of Server Events in the Purchasely Console

1. Enable the events you want to be sent to **MoEngage**

   <Image align="center" className="border" border={true} src="https://files.readme.io/6d41eba-Capture_decran_2024-07-22_a_15.45.27.png" />

(Optional) Events names can be overridden to match with your tacking plan.

<br />

## 4 - Enable the update of User Properties in the Purchasely Console

![](https://files.readme.io/134c6ba-image.png)

<br />

1. Enable the user properties you want to be sent to **MoEngage**
2. (Optional) Override the names of the user properties that will be sent to **MoEngage**
3. Save

# Testing your integration

To test your integration, you can perform a set of in-app purchases in a Sandbox environment (eg: TestFlight for the App Store) and verify your events are received in the **MoEngage** dashboard [https://www.moengage.com](https://www.moengage.com).
