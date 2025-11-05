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

[Piano](piano.io) is a platform that helps digital content businesses manage their online subscriptions, paywalls, and audience engagement. It offers tools for personalized content delivery, monetization strategies, and analytics to optimize user experience and maximize revenue. By integrating with media outlets and publishers, Piano.io enables companies to streamline access control, grow their subscriber base, and generate insights for better audience targeting and retention. Contrary to Purchasely which has a mobile-first focus, Piano offers web-oriented services.

Integrating Piano with Purchasely combines the strengths of both platforms to enhance in-app subscription management and growth. This integration allows businesses to offer more personalized subscription experiences across mobile (what Piano does not allow them to do), and gain unified insights into user behavior and subscription performance on both mobile and web. Additionally, it helps streamline subscription management across multiple channels, improving retention and engagement.

# Pre-requisite

The minimal version of the Purchasely SDK supporting this integration is 3.3.0. If the Purchasely SDK integrated with your app is under the minimal version, please update it.

The Piano also needs to be integrated inside the app.

# Integrating Purchasely with Piano

The activation requires 7 steps

1. Retrieving your `Site ID` from the Piano Dashboard
2. Setting up a new Javascript Tag Composer Configuration in the Piano Dashboard
3. Retrieving your `Collect Server` from the Piano Dashboard
4. Picking a `Collect Path` (ie "*subscription*")
5. Configuring Piano to accept the event names you will be using
6. Enabling the `Piano` integration in the Purchasely Console
7. Enabling the forwarding of [Server Events](server-events) to Piano in the Purchasely Console

<br />

## 1 - Associate users with a AT Internet Client ID (SDK implementation)

This has to be done at the app level by using the following piece of code:

```coffeescript Swift
Purchasely.setAttribute(.atInternetIdClient, value: ATInternet.sharedInstance.defaultTracker.getUserId())
```
```coffeescript Kotlin
ATInternet.getInstance().defaultTracker.getUserId {
    if(it != null) Purchasely.setAttribute(Attribute.AT_INTERNET_ID_CLIENT, it)
}
```
```coffeescript React Native
Purchasely.setAttribute(Attributes.AT_INTERNET_ID_CLIENT, atInternetUserId);
```

See the [CleverTap Documentation](https://developer.clevertap.com/docs/api-quickstart-guide) for more information.

## 2 - Retrieve your `Site ID` from the Piano Dashboard

1. Log into your Piano Dashboard
2. You will find your `Site ID` next to your site's name

<Image align="center" className="border" border={true} src="https://files.readme.io/4e7578fb8c9f0a26eacc0357a546dd1275a43dc3ae0094f5382b046eb15c8241-image.png" />

## 3. Set up a new Javascript Tag Composer Configuration in the Piano Dashboard

1. Access the Tag Composer section of your AT Internet Dashboard
2. Create a new Configuration
3. Pick a name
4. On the next screen, choose the "Websites" environment
5. On the next screen, deselect all plugins
6. On the next screen, deselect all options and create your Configuration

<br />

## 4. Retrieve your `Collect Server` from the Piano Dashboard

1. Access the Tag Composer section of your AT Internet Dashboard
2. Open your newly created configuration
3. On the next screen, click on the button to deploy your Configuration
4. On the sites list, select your website and continue
5. On the settings screen, retrieve and write down your Configuration's SSL Collect Server
6. Pick a collect path to be used later when configuring your Piano integration in the Purchasely Console

<br />

## 5. Configure Piano to accept the event names you will be using

1. Access the Data Models Events configuration section of your Piano Dashboard
2. Create and configure your custom events

> 🚧 Events using any other name than Piano's default ones or the ones set up here will be ignored by Piano.

<br />

## 6. Enable the Piano integration in the Purchasely Console

1. Go in the "Integrations" section, and open the edition form for Piano:

<Image align="center" className="border" border={true} src="https://files.readme.io/7610cc018ec62196e5d0d6e4bed941ca33ffcd06bed899b08e9045ef5ed3c29f-image.png" />

2. Enable the integration
3. Set your Piano `Collection Domains`
4. Set your Piano `Collect Path`
5. Set your Piano `Site ID`
6. Save

<Image align="center" className="border" border={true} src="https://files.readme.io/c89c25a6183fe2e8f7ba921fd108efc7b6bad3f9decaade1d4eba95527a89d78-image.png" />

<br />

## Enable the forwarding of [Server Events](server-events) to Piano in the Purchasely Console

1. Go in the tab Server events

![](https://files.readme.io/c12c500ab6b76a6a5eefc8544433a946d403cd2221386d997bfb79b858cab4ee-image.png)

2. Activate the Server events to be forwarded to Piano Analytics
3. Check that the Event names match [the ones enabled in Piano Analytics during step 5](piano-analytics#5-configure-piano-to-accept-the-event-names-you-will-be-using).
