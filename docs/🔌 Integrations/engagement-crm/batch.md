---
title: Batch
excerpt: This section describes how to integrate Batch with Purchasely
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: braze
      title: Braze
---
# Integrating Purchasely with Batch

> 🚧 Integration requirement
>
> The integration of **Purchasely** and **Batch** requires the activation of the [Trigger Events API](https://doc.batch.com/api/trigger-events-api/track-events/) on **Batch** side. Please contact directly your **Batch** account manager to activate the access to this feature.

The integration requires 5 steps:

1. Activate the **Batch** integration in the Purchasely Console
2. Enable the forwarding of [Server Events](server-events) in the Purchasely Console
3. Enable the update of User Properties in the Purchasely Console
4. Enable the events in the **Batch** Dashboard
5. Set **Batch** SDK *Custom User ID*

## 1 - Activate the Batch integration in the Purchasely Console

In the Purchasely Console, go to **"Integration » Batch"** and enable the integration.

<Image align="center" className="border" border={true} src="https://files.readme.io/c8b420a-enable-batch1.png" />

<Image align="center" className="border" border={true} src="https://files.readme.io/2b3143f-enable-batch2.png" />

Then carry the Android / iOS Live / Rest API keys forward from your **Batch** Dashboard to the Purchasely Console.

These parameters can be found in your **Batch** Dashboard in the following location:\
**Batch Dashboard » You[iOS / Android] app » Settings » General » API Keys**

<Image alt="Screenshot of the Batch Dashboard (January 2022)" align="center" border={true} src="https://files.readme.io/2fadbf7-batch-dashboard.png">
  Screenshot of the **Batch** Dashboard (January 2022)
</Image>

## 2 - Enable the forwarding of Server Events in the Purchasely Console

In the Purchasely Console, under the tab Server Events, you can choose with Server Events must be forwarded to **Batch**.

<Image align="center" className="border" border={true} src="https://files.readme.io/ee329a7-enable-batch3.png" />

(Optional) Events names can be overridden to match with your tacking plan.

> 📘 Keep in mind
>
> UI / SDK Events triggered by the Purchasely SDK cannot be forwarded to **Batch** directly from the Purchasely Console. 
>
> This has to be done at the app level by intercepting the [SDK events](https://start.purchasely.com/docs/ui-sdk-events) and forwarding them to the **Batch** SDK.

Each event sent to Braze carries a set of [properties](server-events-attributes) that you can use to further personalize your campaigns or automations. 

## 3 - Enable the update of User Properties in the Purchasely Console

In the Purchasely Console, under the tab User Properties, you can choose with User Properties should be updated in real time along the subscription lifecycle.

<Image align="center" className="border" border={true} src="https://files.readme.io/0a45dbe-image.png" />

(Optional) User Properties names can be overridden to match with your nomenclature.

Details on User Properties are accessible [here](engagement-crm#leveraging-user-properties).

### 4 - Enable the Events and Attribute in the **Batch** Dashboard

Once events have been enabled on Purchasely's side, they must also be enabled on **Batch's** side as well.

To do so, navigate to the following location:\
**Batch Dashboard » You[iOS / Android] app » Settings » Custom Data » Attributes / User events**

<Image alt="Screenshot of the Batch Dashboard (January 2022)" align="center" border={true} src="https://files.readme.io/c1cdcec-batch-dashboard2.png">
  Screenshot of the **Batch** Dashboard (January 2022)
</Image>

> 📘 Keep in mind
>
> Purchasely Events must have been received at least once on **Batch's** side to appear in this list of User events. Same with User Properties (Attributes)

<br />

## 4- Set Batch SDK Custom User ID (SDK implementation)

> 🚧 Mandatory step
>
> This step is very important, otherwise events sent by Purchasely will not be properly associated with users

Configure **Batch** SDK with the same **User ID** that is given to Purchasely SDK through the dedicated method:

```objectivec Swift
Purchasely.userLogin(with "john.doe");
```
```kotlin Kotlin
Purchasely.userLogin(with "john.doe");
```
```kotlin ReactNative
Purchasely.userLogin("john.doe");
```
```kotlin Cordova
Purchasely.userLogin('john.doe');
```
```kotlin Flutter
Purchasely.userLogin('john.doe');
```
```kotlin Unity
private PurchaselyRuntime.Purchasely _purchasely;
...
_purchasely.UserLogin("john.doe", OnUserLoginCompleted);
```

Then set **Batch** SDK with:

```java Batch Example
Batch.User.editor()
    .setIdentifier("john.doe")
    .save();
...
```

For more details, see **Batch** documentation:

* [Custom user ID (Android)](https://doc.batch.com/android/custom-data/customid/#setting-up-a-custom-user-id)
* [Custom user ID (iOS)](https://doc.batch.com/ios/custom-data/customid/#setting-up-a-custom-user-id)

> 🚧 If Batch Custom user ID is actually different from Purchasely User ID
>
> If your users in Batch are tracked using a different ID from Purchasely, you can tell our SDK and we will use this ID instead:
>
> ```coffeescript Swift
> Purchasely.setAttribute(.batchCustomUserId, value: "theUserId")
> ```
> ```coffeescript Kotlin
> Purchasely.setAttribute(Attribute.BATCH_CUSTOM_USER_ID, "YOUR_USER_ID")
> ```

# Setting-up your first automation

To configure your automations navigate to the following location in **Batch**:

**Batch » Campaigns**

<Image align="center" className="border" border={true} src="https://files.readme.io/2d9449d-batch-automation1.png" />

To create an automation triggered by a Purchasely event, choose Trigger in the block When.

<Image align="center" className="border" border={true} src="https://files.readme.io/e5ff32e-batch-automation2.png" />

<br />

All the events that have already been received at least once by **Batch** will appear in the list.

You can even add a filter (set of condition) on the[ event attributes](https://start.purchasely.com/docs/server-events-attributes).

<Image align="center" className="border" border={true} src="https://files.readme.io/446c25e-batch-dashboard3.png" />

You can then define the message that will be sent and the deeplink associated to it.

<Image align="center" className="border" border={true} src="https://files.readme.io/fcf9871-batch-dashboard4.png" />

<br />

If the deeplink matches a pattern handled by Purchasely, it will allow you to:

* display a specific Screen (for upsell and retention flow)
* display a cancellation survey
* notify users that their credit card has expired and send them to their devices settings

More information in the section [deeplinks automations](https://start.purchasely.com/docs/deeplink-automations).

For more information about **Batch** Dashboard and campaigns configuration, please refer directly to [Batch Documentation](https://doc.batch.com/).
