---
title: Fetching the Quiz insights in the app
excerpt: >-
  This page provides details on how to fetch the Quiz insights in the app and
  process them
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Purchasely Quizzes offer a powerful, no-code way to collect structured user insights directly within your app - whether it's preferences, goals, motivations, or feedback. These insights are instantly accessible in the Purchasely Console for visualization and analysis, and can also be used to collect user data, power backend logic, or enrich third-party integrations.

Thanks to a unified mechanism - [the listener for Custom User Attributes](custom-user-attribute-listener) - you can create and manage unlimited Quizzes via the Console, while still capturing user responses in real time across your systems. No additional SDK logic is required per Quiz, making the solution both scalable and low maintenance.

## How to fetch the user insights in the app?

Upon the submission of the user's Answer(s), if the option "Save answer(s) as an Insight Attribute" has been activated for the Quiz, the app will be notified via an [Event Listener for Custom User Attributes](custom-user-attribute-listener).

<Image align="center" className="border" border={true} src="https://files.readme.io/4682606832e9b598e142ed6ef812f6e63e398fe52a45bbd4c637dcfac1c2364e-image.png" />

To fetch and process the data, here is the generic piece of code to implement into your app

<EventListenerForCustomUserAttributesImplementation />

The SDK provides:

* the `key` of the Insight attribute - the key retrieved corresponds to the `Quiz ID`.
* the `type` of the attribute
  * `String` for single answer Quizzes
  * `Array of Strings` for multiple answers Quizzes
* the `value` (String - single answer) or `values` (Array of Strings - multiple answers) matching the Answers picked up by the user.

> 📘 Value of the parameter source
>
> After the submission of the Quiz, the parameter `source` has the value `purchasely` to indicate to the app that the User Attribute has been set by the SDK and not by the app.

## How to send the insights to my backend?

Once the app has been notified through the event listener / delegate, you can execute your own code and associate the Insight Attribute returned and its value as a user property and/or send this to your backend. 

This processing has to be done by your app. Purchasely does not provide a server to server integration to do it.

## How to send the data to 3rd party integrations?

It's the same with 3rd party integrations. After fetching the Custom User Attribute and its value, associate it to the user and leverage the mobile SDK API of your 3rd-party platform to send it.

For instance, this can be achieved with the following platforms (the list is not exhaustive):

* [Amplitude](amplitude)
* [Braze](braze)
* [MixPanel](mixpanel)
* [Iterable](iterable)
* [Clevertap](clevertap)
* [OneSignal](onesignal)
* [Batch](batch)
* [Google Analytics for Firebase](google-analytics-for-firebase)
* [Piano analytics](piano-analytics)
* [Airship](airship)
* [MoEngage](moengage)
* or any 3rd party SDK integrated inside your application

This processing has to be done by your app. Purchasely does not provide a server to server integration to do it.
