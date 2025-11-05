---
title: Clevertap
excerpt: This section describes how to integrate CleverTap with Purchasely
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Learn how to integrate Customer.io with Purchasely
  pages:
    - type: basic
      slug: customer-io
      title: Customer.io
---
# Overview

[CleverTap](https://clevertap.com/) is an all-in-one platform that combines the best analytics, segmentation, and engagement tools so that companies can build valuable, long-term relationships with their customers.

This integration will allow you to get all the available Purchasely events to CleverTap and get a better and deeper understanding of your subscription business and customer behavior. In addition you will be able to trigger automated communication based on those events, messages that could be linked to a Purchasely powered Screen to engage, upsell, retain customers.

<br />

# Integrating Purchasely with Clevertap

The integration requires 5 steps:

1. Associate the users with a `CleverTap Distinct ID` (SDK implementation)
2. Activate the **Clevertap** integration in the Purchasely Console
3. Enable the forwarding of [Server Events](server-events) in the Purchasely Console
4. Enable the update of User Properties in the Purchasely Console

<br />

## 1 - Associate users with a CleverTap Distinct ID (SDK implementation)

This has to be done at the app level by using the following piece of code:

```coffeescript Swift
CleverTap.autoIntegrate()
if let clevertapId = CleverTap.sharedInstance()?.profileGetID() {
    Purchasely.setAttribute(.clevertapId, value: clevertapId)
}
```
```coffeescript Kotlin
val cleverTap = CleverTapAPI.getDefaultInstance(applicationContext)
cleverTap?.cleverTapID?.let {
    Purchasely.setAttribute(Attribute.CLEVER_TAP_ID, it)
}
```
```coffeescript React Native
CleverTap.getCleverTapID((err, res) => {
    Purchasely.setAttribute(Attributes.CLEVER_TAP_ID, res);
});
```
```coffeescript Flutter
Purchasely.setAttribute(PLYAttribute.clever_tap_id, "clever_tap_id");
```
```coffeescript Cordova
Purchasely.setAttribute(Purchasely.Attribute.CLEVER_TAP_ID, "clever_tap_id");
```
```coffeescript Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely.SetAttribute(PLYAttribute.CLEVER_TAP_ID, "clever_tap_id");
```

See the [CleverTap Documentation](https://developer.clevertap.com/docs/api-quickstart-guide) for more information.

## 2 - Activate the Clevertap integration

The activation requires 3 steps:

* Retrieving your account's region from the CleverTap Dashboard.
* Retrieving your account's ID and passcode from the CleverTap Dashboard.
* Enabling the CleverTap integration in the Purchasely Console.

<br />

### Retrieving your account's region from the CleverTap Dashboard

1. Follow the [CleverTap documentation](https://developer.clevertap.com/docs/api-quickstart-guide#get-clevertap-account-credentials-to-authenticate-api-requests) and retrieve your account's region.
2. Write down your account's region.

<br />

### Retrieving your account's id and passcode from the CleverTap Dashboard

1. Follow the [CleverTap documentation](https://developer.clevertap.com/docs/api-quickstart-guide#get-clevertap-account-credentials-to-authenticate-api-requests) and retrieve your account's ID and passcode.
2. Write down your account's ID and passcode.

<br />

### Enabling the CleverTap integration in the Purchasely Console

1. Go in the **"Integrations"** section, and open the edition form for CleverTap :

<Image align="center" className="border" border={true} src="https://files.readme.io/12d134e-Capture_decran_2024-07-09_a_15.57.39.png" />

2. Enable the integration

3. Set your CleverTap region. (Note that if you are in the EU region, you should put EU1)

4. Set your CleverTap account ID

5. Set your CleverTap account passcode

<br />

## 3 - Enable the forwarding of Server Events in the Purchasely Console

In the Purchasely Console, under the tab Server Events, you can choose with Server Events must be forwarded to **Clevertap**.

<Image align="center" className="border" border={true} src="https://files.readme.io/5838fc8-Capture_decran_2024-07-09_a_16.00.19.png" />

(Optional) Events names can be overridden to match with your tacking plan.

<br />

## 4 - Enable the update of User Properties in the Purchasely Console

In the Purchasely Console, under the tab User Properties, you can choose with User Properties should be updated in real time along the subscription lifecycle.

<Image align="center" className="border" border={true} src="https://files.readme.io/e701a3c-image.png" />

(Optional) User Properties names can be overridden to match with your nomenclature.

Details on User Properties are accessible [here](engagement-crm#leveraging-user-properties).
