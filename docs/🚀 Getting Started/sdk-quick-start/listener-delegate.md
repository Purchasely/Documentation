---
title: Listeners / Delegates for UI / SDK events and Custom User Attributes
excerpt: >-
  This page describes how to implement listeners / delegates for UI / SDK events
  and Custom User Attributes
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
To enhance your integration and gain deeper insights into user interactions, implement the following event listeners.

While these steps are not mandatory strictly speaking to make the Purchasely SDK work, we encourage you to implement them as it only takes a few minutes of work.

<br />

# UI / SDK Events Listener

When users interact with Purchasely Screens, the Purchasely SDK triggers [UI / SDK events](ui-sdk-events). 

These events are triggered internally inside the application and sent to the Purchasely Platform, to compute all the KPIs related to conversion. However, contrary to Server events, these UI / SDK events cannot be forwarded to a 3rd party integration using a server-to-server integration, directly from the Console.

If you want to leverage these analytics and gain real-time insights on how users interact with the Screens managed by the Purchasely SDK, you need to implement an event delegate / listener, to fetch the events in the app and process them (i.e.: forward them to any analytics or engagement platform)

## Implementation

<UISDKEventsEventDelegatedEventListener />

<br />

# Custom User Attributes Listener

The Purchasely SDK allows you to publish [Surveys](mcq), [gain insights on users and leverage them to personalize the journey](user-surveys).

When a user validates an answer to a survey, a Custom User Attribute can be set by the SDK and fetch by the app thanks to a listener / delegate.

By implementing Custom User Attribute listener, you will be able to:

1. publish surveys in no-code using the Screen Composer 
2. automatically fetch the user data `{attribute, type, value(s)}` in the app
3. and process it to send it to your backend or any 3 party integration

... without needing to update your app every time you publish a new survey.

<br />

This feature is available starting from the following versions:

- iOS: v5.0.2+
- Android: v5.0.4+
- React Native: v5.0.4+

## Functionning

When the user submit their answer(s) to the Survey, if a user attribute has been associated to the survey, this listener / delegate will automatically be called by the SDK to handover to the app. 

After the app has been notified, it can: 

- fetch the data `{attribute ID, type, value(s)}` 
- and process it

## Implementation

<EventListenerForCustomUserAttributesImplementation />

The listener should be implemented for the following types of Custom User Attributes:

- `String`
- `Int`
- `Float`
- `Bool`
- `Date`
- `Array of Strings`

> 📘 Surveys allowing multiple choice answers are associated with the type Array of Strings
> 
> When configuring your survey, you can define whether multiple answers are allowed or not.
> 
> - If the Survey is configured to allow ONE single answer, the attribute returned will be a **String**
> - If the Survey is configured to allow MULTIPLE answers, the attribute returned will be an **Array of Strings**.

Once fetched, the data can be processed, which consist in sending it to your backend or any 3rd party integration directly from the app.

## Understanding the `PLYUserAttributeSource`

The `source` parameter of the listener/delegate methods indicates where the user attribute update originated. It can have two possible values:

- **PURCHASELY**: The change was initiated internally by the Purchasely’s SDK. 
- **CLIENT**: The change was triggered directly by your app. 

```swift Swift
@objc public enum PLYUserAttributeSource: Int {
     case purchasely, client
 }
```
```kotlin
enum class PLYUserAttributeSource {
    PURCHASELY, 
    CLIENT
}
```
```java ReactNative
export enum PLYUserAttributeSource {
  PURCHASELY,
  CLIENT
}
```
```java Flutter
enum PLYUserAttributeSource {
  purchasely,
  client,
}
```

This distinction helps you understand whether the attribute change was driven automatically by Purchasely's SDK or explicitly by your app's logic.

> 🚧 Ignore the delegate when the parameter `source` is set to `client`
> 
> When your app sets a [Custom User Attribute](custom-user-attributes), the listener / delegate will be called back by the SDK with the parameter `source` set to `client`.
> 
> To avoid processing a data that you already have - because the app has set it in the first place - in most cases, you can ignore the event triggered when the parameter `source` is set to `client`.