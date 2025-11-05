---
title: Braze
excerpt: >-
  This section describes how to integrate Braze with Purchasely to trigger
  automatic campaigns or push notifications
deprecated: false
hidden: false
metadata:
  title: ''
  description: >-
    Purchasely can send transactional events to Braze to enrich user data and
    trigger automatic campaigns. Implementing the SDK involves setting up the
    Braze SDK and adding aliases for anonymous users. The document also provides
    instructions for configuring the integration in the Purchasely Console and
    retrieving the Braze API Key.
  robots: index
next:
  description: ''
---
# Integrating Purchasely with Braze

The integration requires 5 steps:

1. Set the **Braze User ID** in the app
2. Activate the **Braze** integration in the Purchasely Console
3. Enable the forwarding of [Server Events](server-events) in the Purchasely Console
4. Enable the update of User Properties in the Purchasely Console

<br />

## 1 - Set the Braze User ID in the app (SDK Implementation)

There is nothing special to be done to associate Purchasely events to your logged in users in Braze. Just setup Braze SDK as you would normally, and use the `changeUser` method to set the user ID in Braze:

```swift Swift
Appboy.sharedInstance()?.changeUser("YOUR_USER_ID")
```
```kotlin Kotlin
Appboy.getInstance(context).changeUser("YOUR_USER_ID")
```
```typescript React Native
ReactAppboy.changeUser("YOUR_USER_ID");
```
```typescript Flutter
BrazePlugin braze = BrazePlugin();
braze.changeUser("{YOUR_USER_ID}");
```
```typescript Cordova
AppboyPlugin.changeUser("YOUR_USER_ID");
```

**Handling anonymous users**

If you have anonymous users in your app, you will need to add their Purchasely anonymous\_id as a user alias to Braze

```swift Swift
Appboy.sharedInstance()?.user.addAlias(  
    Purchasely.anonymousUserId,  
    withLabel: "purchasely_anonymous_id"  
)
```
```kotlin Kotlin
Appboy.getInstance(applicationContext)?.currentUser?.addAlias(
    Purchasely.anonymousUserId,
    "purchasely_anonymous_id"
)
```
```typescript React Native
ReactAppboy.addAlias(
    Purchasely.getAnonymousUserId(),
    "purchasely_anonymous_id"
);
```
```typescript Flutter
BrazePlugin braze = BrazePlugin();
braze.addAlias("{YOUR_USER_ID}", "purchasely_anonymous_id");
```
```typescript Cordova
AppboyPlugin.addAlias(
    Purchasely.anonymousUserId, 
    withLabel: "purchasely_anonymous_id"
);
```

> 🚧 Keep the label provided above
>
> The label **must** be set to `purchasely_anonymous_id`, as our servers refer to this label when sending events while the user is anonymous.

When the anonymous user later becomes logged in, Purchasely will automatically send following events using the provided user id

## 1 - Activate the Braze integration in the Purchasely Console

To use Braze with Purchasely, go to the section [Integrations](https://console.purchasely.io/external-integrations) of Purchasely Console and click on Braze

<Image align="center" className="border" border={true} src="https://files.readme.io/64864c3-SCR-20240709-mwtr.png" />

<br />

<Image align="center" className="border" border={true} src="https://files.readme.io/cd27542-SCR-20240709-mxcd.png" />

You can:

1. Activate the integration
2. Set your API Key
3. Set your iOS App ID
4. Set your Android App ID
5. Select the Braze Server you are using\
   Refer to [Braze API Endpoints table](https://www.braze.com/docs/api/basics/#endpoints). You can use your Braze Dashboard URL find the correct server. E.g. if your dashboard is accessible at [https://dashboard-01.braze.eu](https://dashboard-01.braze.eu), then you should select the\
   EU-01 server.

**Retrieving Braze API Key**

Go to your Braze Developer Console, and click on "Create New API Key"

<Image align="center" className="border" border={true} src="https://files.readme.io/a8cfbb1-Braze_Purchasely_Image.png" />

Give a relevant name to your API Key. In the "User Data" permission area, check\
`users.track` as our servers need this permission to report backend events to Braze.

<Image align="center" className="border" border={true} src="https://files.readme.io/ef24404-Braze_Purchasely_Image.avif" />

Click "Save API Key" at the bottom of the page.

<Image align="center" className="border" border={true} src="https://files.readme.io/546e596-Braze_Purchasely_Image_1.avif" />

<br />

## 3 - Enable the forwarding of Server Events in the Purchasely Console

In the Purchasely Console, under the tab Server Events, you can choose with Server Events must be forwarded to **Braze**.

<Image align="center" className="border" border={true} src="https://files.readme.io/11ef011-SCR-20240709-mxkv.png" />

(Optional) Events names can be overridden to match with your tacking plan.

> 📘 Keep in mind
>
> UI / SDK Events triggered by the Purchasely SDK cannot be forwarded to **Braze** directly from the Purchasely Console. 
>
> This has to be done at the app level by intercepting the [SDK events](https://start.purchasely.com/docs/ui-sdk-events) and forwarding them to the **Braze** SDK.

Each event sent to Braze carries a set of [properties](server-events-attributes) that you can use to further personalize your campaigns. 

## 4 - Enable the update of User Properties in the Purchasely Console

In the Purchasely Console, under the tab User Properties, you can choose with User Properties should be updated in real time along the subscription lifecycle.

<Image align="center" className="border" border={true} src="https://files.readme.io/76cc84f-SCR-20240709-mxpi.png" />

(Optional) User Properties names can be overridden to match with your nomenclature.

Details on User Properties are accessible [here](engagement-crm#leveraging-user-properties).
