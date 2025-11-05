---
title: Google Analytics for Firebase
excerpt: >-
  This section describes how to integrate Google Analytics for Firebase with
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
Purchasely can send all your transactional events to Firebase through Google Analytics to enrich your users data. These events can then be used in Google Analytics, Firebase, Big Query...

> 📘 Read through [Google Analytics for Firebase documentation](https://firebase.google.com/docs/analytics) to setup your Firebase project with Google Analytics. Google Analytics integration needs to be enabled before continuing.

<br />

# Events

<EventsIntegration />

<br />

# Associate your users

In order to associate those events back to your users, you will need to configure the Purchasely SDK to give us the `firebaseAppInstanceId` value:

```swift Swift

if let firebaseAppInstanceId = Analytics.appInstanceID() {
	Purchasely.setAttribute(.firebaseAppInstanceId, value: firebaseAppInstanceId)
}
```
```kotlin Kotlin
FirebaseAnalytics.getInstance(applicationContext).appInstanceId.addOnSuccessListener {
    Purchasely.setAttribute(Attribute.FIREBASE_APP_INSTANCE_ID, it)
}
```
```javascript ReactNative
/*
 Reference : https://rnfirebase.io/analytics/usage#app-instance-id
*/

import analytics from '@react-native-firebase/analytics';

async function getInstanceId() {
  const id = await analytics().getAppInstanceId();
  id && Purchasely.setAttribute(Attributes.FIREBASE_APP_INSTANCE_ID, id);
}
```
```javascript Cordova
// Add plugin firebase-x to your project
// https://ionicframework.com/docs/native/firebase-x

//Retrieve the Firebase App Instance Id and forward it to Purchasely
FirebasePlugin.getId(function(appInstanceId) {
    Purchasely.setAttribute(Purchasely.Attribute.FIREBASE_APP_INSTANCE_ID, appInstanceId);
}, function(error) {
    console.error(error);
});
```
```Text Flutter
```
```Text Unity
```

> 📘 You can always give your custom User ID to Analytics if you need more detailed metrics, as detailed in[ Set a User ID documentation](https://firebase.google.com/docs/analytics/userid). But make sure it matches the `vendor_id` you give to Purchasely to avoid discrepancies.

<br />

# Configure the integration in the Purchasely Console

Go in the "External integrations" section, and open the edition form for Firebase:

<Image align="center" className="border" border={true} src="https://files.readme.io/9b03438-firebase1.png" />

<Image align="center" className="border" border={true} src="https://files.readme.io/4a8eeb6-firebase2.png" />

For each platform, you will find your Firebase App ID in your Firebase Project settings:

<Image align="center" className="border" border={true} src="https://docs.purchasely.com/~gitbook/image?url=https%3A%2F%2Ffiles.gitbook.com%2Fv0%2Fb%2Fgitbook-legacy-files%2Fo%2Fassets%252F-MHAzdlUVqKyZvwTnNIE%252F-MX7ErI23u2HnavK6KyA%252F-MX7Hqr_smhS9lIGbBnr%252Fimage.png%3Falt%3Dmedia%26token%3D3190ff02-1db7-4a7c-b194-6538c9699d03&width=768&dpr=2&quality=100&sign=76080560&sv=1" />

<br />

# Retrieving API secrets

Go to your Firebase project Settings > Integration > (Google Analytics) Manage:

<Image align="center" className="border" border={true} src="https://files.readme.io/3f33f193ffc591cd4dd31ebb1407e9ad942b3219467463e729ed04ef248fb824-image.png" />

<br />

Click on your linked Google Analytics account, to open Google Analytics settings:

<Image align="center" className="border" border={true} src="https://files.readme.io/fab23def2921ae9f03ee348da188f91eb0584e677de153629d5ed4585695a3a7-image.png" />

<br />

In the ***Google Analytics Admin*** section, make sure you have selected the correct project. Then click on ***Data Streams***:

<Image align="center" className="border" border={true} src="https://files.readme.io/07d0e1c21004c8cf343846f9809de097459f2645c3abb8d759a9bb0f6a2343b7-image.png" />

<br />

Click on one of your apps (make sure they match the apps that you are configuring in Purchasely!):

<Image align="center" className="border" border={true} src="https://files.readme.io/aafff603250357c208ad682161e0cc64c7e1478e2a5c260289fc7c314fb6d8c4-image.png" />

<br />

Go to the ***Additional settings*** section, then click on ***Measurement Protocol API secrets*** section:

<Image align="center" className="border" border={true} src="https://files.readme.io/ad5b5b9392e40fbd695ff711e4b7987cd76916cec3c6774369555a25b701919d-image.png" />

<br />

***Review terms***, then click on ***Create***:

<Image align="center" className="border" border={true} src="https://files.readme.io/ccbf2c0af6e06fbbaaa39593d29516377633b3771051f05925b7a2aaa15efdd1-image.png" />

<br />

Give an appropriate nickname to the API secret (e.g. "Purchasely Platform"), then click ***Create***:

<Image align="center" className="border" border={true} src="https://files.readme.io/9446c69fe654a939dd9af6ed45ba6e3d6a41ae104d76b1623446f07c42796ca3-image.png" />

<br />

You can finally copy the obtained ***Secret*** value into Purchasely ***API Secret*** for the relevant platform.

> 📘 You will need to repeat the procedure for each platform.

Don't forget to toggle the Integration Enabled switch on the ***Account Parameters*** page.

<br />

# Customizing Server Event Names

If you want to, you can rename events sent to Google Analytics:

<Image align="center" className="border" border={true} src="https://files.readme.io/1353368-firebase3.png" />

> 📘 Event names must be 40 characters or fewer, may only contain alphanumeric characters and underscores, and must start with an alphabetic character. See Google Analytics documentation on [Limitations](https://developers.google.com/analytics/devguides/collection/protocol/ga4/sending-events?client_type=firebase#limitations) for more info.
