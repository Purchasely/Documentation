---
title: Amplitude
excerpt: >-
  Purchasely can send all your transactional events to Amplitude to enrich your
  users data.
deprecated: false
hidden: false
metadata:
  title: ''
  description: >-
    To map Amplitude user IDs with Purchasely user IDs, set the appropriate
    attributes in the Purchasely SDK using provided code snippets for various
    platforms, and configure the integration in the Purchasely Console by
    activating it, entering your API key, and selecting the server location.
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: firebase
      title: Firebase Analytics / Google Analytics
---
# SDK Implementation

To accurately map your Amplitude user ID with your Purchasely user ID, you need to set the appropriate attribute in the Purchasely SDK. You must provide your Amplitude user ID and device ID to Purchasely so that events can be properly associated to your anonymous and connected users.

```swift Swift
let amplitudeUserId = Amplitude.instance().getUserId()
Purchasely.setAttribute(.amplitudeUserId, value: String(amplitudeUserId))

let amplitudeDeviceId = Amplitude.instance().getDeviceId()
Purchasely.setAttribute(.amplitudeDeviceId, value: String(amplitudeDeviceId))
```
```kotlin Kotlin
Purchasely.setAttribute(
    Attribute.AMPLITUDE_USER_ID,
    Amplitude.getInstance().userId.toString()
)

Purchasely.setAttribute(
    Attribute.AMPLITUDE_DEVICE_ID,
    Amplitude.getInstance().deviceId.toString()
)
```
```typescript ReactNative
Purchasely.setAttribute(Attributes.AMPLITUDE_USER_ID, Amplitude.getInstance().getUserId());
Purchasely.setAttribute(Attributes.AMPLITUDE_DEVICE_ID, Amplitude.getInstance().getDeviceId());
```
```typescript Flutter
Purchasely.setAttribute(PLYAttribute.amplitudeUserId, Amplitude.getInstance().getUserId());
Purchasely.setAttribute(PLYAttribute.amplitudeDeviceId, Amplitude.getInstance().getDeviceId());
```
```javascript Cordova
Purchasely.setAttribute(Purchasely.Attribute.AMPLITUDE_USER_ID, Amplitude.getInstance().getUserId());
Purchasely.setAttribute(Purchasely.Attribute.AMPLITUDE_DEVICE_ID, Amplitude.getInstance().getDeviceId());
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;
...
_purchasely.SetAttribute(PLYAttribute.AMPLITUDE_USER_ID, Amplitude.getInstance().getUserId());
_purchasely.SetAttribute(PLYAttribute.AMPLITUDE_DEVICE_ID, Amplitude.getInstance().getDeviceId());
```

# Console configuration

In the Purchasely Console, navigate to the [Integrations](https://console.purchasely.io/external-integrations) section and click on Amplitude

1. Activate the integration
2. Enter your API Key, that you can get in your Amplitude Console
3. Select the server location of your Amplitude data

<Image align="center" className="border" border={true} src="https://files.readme.io/a5a352d-SCR-20240717-plrg.png" />

<Image align="center" className="border" border={true} src="https://files.readme.io/5686308-SCR-20240717-plyz.png" />

## Retrieve your Amplitude API Key

To find your Amplitude project's unique API key and secret key, follow these steps.

* In the Amplitude Analytics web app, click [Settings](http://analytics.amplitude.com/amp-dev-docs/settings/projects) in the upper right navigation.
* Click Projects, then find your target project.
* On the General tab, copy your API key.

<Image align="center" className="border" border={true} src="https://files.readme.io/53b91c5-image.png" />

## Events

<Image align="center" className="border" border={true} src="https://files.readme.io/814f3da-SCR-20240717-pmjp.png" />

<EventsIntegration />
