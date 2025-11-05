---
title: Appsflyer
excerpt: This section describes how to integrate AppsFlyer with Purchasely
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Learn how to integrate Branch with Purchasely
  pages:
    - type: basic
      slug: branch
      title: Branch
---
# Integration

The integration of AppsFlyer requires 2 steps:

1. Associate the user to events by providing the `AppsFlyer ID` to the Purchasely SDK
2. Activate the AppsFlyer integration in the Purchasely Console

> 🚧 Version compatibility
>
> The minimal version of the Purchasely SDK supporting this integration is `v3.2.0`. 
>
> If the Purchasely SDK integrated in your app is under the minimal version, please upgrade it.
>
> The AppsFlyer SDK also needs to be integrated inside the app.

## 1. Associating users to events

See [iOS](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#getappsflyeruid) or [Android](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#getappsflyeruid) Appsflyer documentation for more information.

```coffeescript Swift
Purchasely.setAttribute(.appsflyerId, value: AppsFlyerLib.shared().getAppsFlyerUID())
```
```coffeescript Kotlin
AppsFlyerLib.getInstance().getAppsFlyerUID(applicationContext)?.let {
    Purchasely.setAttribute(Attribute.APPSFLYER_ID, it)
}

```
```coffeescript React Native
appsFlyer.getAppsFlyerUID((err, appsFlyerUID) => {
  if (err) {
    console.error(err);
  } else {
    Purchasely.setAttribute(Attributes.APPSFLYER_ID, appsFlyerUID);
  }
});

```
```coffeescript Flutter
appsFlyerSdk.getAppsFlyerUID().then((AppsFlyerId) {
  Purchasely.setAttribute(PLYAttribute.appsflyer_id,AppsFlyerId);
});
```
```coffeescript Cordova
var  getUserIdCallbackFn = function(id) {
alert('received id is: ' + id);
}

var appsFlyerId = window.plugins.appsFlyer.getAppsFlyerUID(getUserIdCallbackFn);

Purchasely.setAttribute(Purchasely.Attribute.APPSFLYER_ID, appsFlyerId);
```
```coffeescript Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely.SetAttribute(PLYAttribute.APPSFLYER_ID, "test_appsflyer_id");
```

## 2. Activating the AppsFlyer integration

### Retrieving your app id in the AppsFlyer Dashboard

1. Go to your AppsFlyer dashboard: [https://hq1.appsflyer.com/apps/myapps](https://hq1.appsflyer.com/apps/myapps)
2. You will find your app's ids beneath their names

<Image align="center" className="border" border={true} src="https://files.readme.io/3fd09fd-image.png" />

### Retrieving your API key in the AppsFlyer Dashboard

1. Go to your AppsFlyer dashboard: [https://hq1.appsflyer.com/apps/myapps](https://hq1.appsflyer.com/apps/myapps)
2. Using the app's top right menu, access your app's settings

<Image align="center" className="border" border={true} src="https://files.readme.io/597bf73-image.png" />

3. You will find your app's API key at the top of the page

<Image align="center" className="border" border={true} src="https://files.readme.io/fca3b46-image.png" />

4. (optional) repeat for your Android / iOS app

### Enabling the AppsFlyer integration in the Purchasely Console

1. Visit your [Purchasely app's console](https://console.purchasely.io/)
2. Access your apps Integrations settings

<Image align="center" className="border" border={true} src="https://files.readme.io/9f8ca67-Capture_decran_2024-07-15_a_11.33.57.png" />

3. Access the AppsFlyer Integration's Settings

4. Enable the AppsFlyer integration

5. Set your **iOS** AppsFlyer app's `API key` & `app ID`

6. Set your **Android** AppsFlyer app's `API key` & `App ID`

<Image align="center" className="border" border={true} src="https://files.readme.io/65b729b-Capture_decran_2024-07-15_a_11.41.41.png" />

7. (optional) Override the name of events sent to AppsFlyer

8. Save
