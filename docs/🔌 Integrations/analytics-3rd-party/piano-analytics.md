---
title: Piano Analytics
excerpt: >-
  This section provides details on how to activate the Piano Analytics <>
  Purchasely integration
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

[Piano](https://piano.io) is a platform that helps digital content businesses manage their online subscriptions, paywalls, and audience engagement. It offers tools for personalized content delivery, monetization strategies, and analytics to optimize user experience and maximize revenue. By integrating with media outlets and publishers, Piano.io enables companies to streamline access control, grow their subscriber base, and generate insights for better audience targeting and retention. Contrary to Purchasely which has a mobile-first focus, Piano offers web-oriented services.

Integrating Piano with Purchasely combines the strengths of both platforms to enhance in-app subscription management and growth. This integration allows businesses to offer more personalized subscription experiences across mobile (what Piano does not allow them to do), and gain unified insights into user behavior and subscription performance on both mobile and web. Additionally, it helps streamline subscription management across multiple channels, improving retention and engagement.

# Pre-requisite

The minimal version of the Purchasely SDK supporting this integration is 3.3.0. If the Purchasely SDK integrated with your app is under the minimal version, please update it.

The Piano Analytics SDK must also be integrated in your app ([iOS](https://github.com/at-internet/piano-analytics-apple), [Android](https://github.com/at-internet/piano-analytics-android)). The AT Internet SmartTag SDK is not supported anymore by Piano: use the Piano Analytics SDK.

# Integrating Purchasely with Piano

The activation requires 6 steps

1. Associating users with the Piano Analytics visitor ID (SDK implementation)
2. Retrieving your `Site ID` from the Piano Dashboard
3. Retrieving your `Collection Domain` and picking a `Collect Path` (we recommend `event`)
4. Configuring Piano to accept the event names and properties you will be using
5. Enabling the `Piano` integration in the Purchasely Console
6. Enabling the forwarding of [Server Events](server-events) to Piano in the Purchasely Console

<br />

## 1. Associate users with the Piano Analytics visitor ID (SDK implementation)

Initialize the Piano Analytics SDK in your app first. Then give the Piano visitor ID to Purchasely. Purchasely sends it as `idclient` with each event, so Piano attaches the server events to the same visitor as your app events.

> 📘 The Purchasely attribute keeps its historical name (`atInternetIdClient` / `AT_INTERNET_ID_CLIENT`). It contains the Piano Analytics visitor ID.

```swift Swift
import PianoAnalytics

pa.getVisitorId { visitorId in
    Purchasely.setAttribute(.atInternetIdClient, value: visitorId)
}
```
```kotlin Kotlin
// Call after PianoAnalytics.init(...)
PianoAnalytics.getInstance().visitorId?.let { visitorId ->
    Purchasely.setAttribute(Attribute.AT_INTERNET_ID_CLIENT, visitorId)
}
```
```typescript React Native
// pianoVisitorId: the visitor ID read from the Piano Analytics SDK on the native side
Purchasely.setAttribute(Attributes.AT_INTERNET_ID_CLIENT, pianoVisitorId);
```
```dart Flutter
// pianoVisitorId: the visitor ID read from the Piano Analytics SDK on the native side
Purchasely.setAttribute(PLYAttribute.atInternetIdClient, pianoVisitorId);
```
```javascript Cordova
// pianoVisitorId: the visitor ID read from the Piano Analytics SDK on the native side
Purchasely.setAttribute(Purchasely.Attribute.AT_INTERNET_ID_CLIENT, pianoVisitorId);
```

> 🚧 The Piano visitor ID depends on the `visitorIDType` and on the privacy mode configured in the Piano SDK. Set the attribute again when the visitor ID changes. Do not send it if the user did not give consent.

See the [Piano Analytics developer documentation](https://developers.piano.io/) for more information on the visitor ID.

## 2. Retrieve your `Site ID` from the Piano Dashboard

1. Log into your Piano Dashboard
2. You will find your `Site ID` next to your site's name

<Image align="center" className="border" border={true} src="https://files.readme.io/4e7578fb8c9f0a26eacc0357a546dd1275a43dc3ae0094f5382b046eb15c8241-image.png" />

## 3. Retrieve your `Collection Domain` and choose a `Collect Path`

1. Log into your Piano Analytics account.
2. Retrieve the collection domain of your site (for example `xxxxxxx.pa-cd.com`). It is the same value as the `collectDomain` you use to configure the Piano Analytics SDK in your app.
3. Pick a collect path. We recommend `event`, the default path of the Piano Analytics SDKs.

<br />

## 4. Configure Piano to accept the event names and properties you will be using

1. Access the Data Model section of your Piano Analytics account
2. Create your custom events with the event names you will use in Purchasely
3. Declare the custom properties that Purchasely sends (for example `event_collection_platform`, `device_timestamp_utc` and the server event properties)

> 🚧 Events using any other name than Piano's default ones or the ones set up here will be ignored by Piano.

<br />

## 5. Enable the Piano integration in the Purchasely Console

1. Go in the "Integrations" section, and open the edition form for Piano:

<Image align="center" className="border" border={true} src="https://files.readme.io/7610cc018ec62196e5d0d6e4bed941ca33ffcd06bed899b08e9045ef5ed3c29f-image.png" />

2. Enable the integration
3. Set your Piano `Collection Domain`
4. Set your Piano `Collect Path`
5. Set your Piano `iOS Site Id` and `Android Site Id` (use the same value twice if you use one Piano site for both platforms)
6. Save

<Image align="center" className="border" border={true} src="https://files.readme.io/c89c25a6183fe2e8f7ba921fd108efc7b6bad3f9decaade1d4eba95527a89d78-image.png" />

<br />

## 6. Enable the forwarding of [Server Events](server-events) to Piano in the Purchasely Console

1. Go in the tab Server events

![](https://files.readme.io/c12c500ab6b76a6a5eefc8544433a946d403cd2221386d997bfb79b858cab4ee-image.png)

2. Activate the Server events to be forwarded to Piano Analytics
3. Check that the Event names match [the ones enabled in Piano Analytics during step 4](piano-analytics#4-configure-piano-to-accept-the-event-names-and-properties-you-will-be-using).
