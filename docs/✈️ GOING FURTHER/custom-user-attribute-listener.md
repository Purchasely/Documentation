---
title: Implementing a Listener / Delegate for Custom User Attributes
excerpt: >-
  This page provide details on how to set up an Event Listener / Delegate to
  fetch Custom User Attributes inside the application and process it
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
## Context

The feature described in this page is particularly useful to fetch the user answers to a survey. The [Screen Composer](screen-composer) can be leveraged to publish [user surveys](mcq) (ie: onboarding questions, cancellation surveys etc...) that can be associated with a [Custom User Attribute](custom-user-attributes). 

By implementing this feature, you will be able to:

1. publish surveys in no-code using the Screen Composer 
2. automatically fetch the user data `{attribute, type, value(s)}` in the app
3. and process it to send it to your backend or any 3 party integration

... without needing to update your app every time you publish a new survey.

To handle changes in user attributes, you can implement a listener (Android) or a delegate (iOS). This allows you to capture when a user attribute is set or removed within your app.

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

Once fetched, the data can be processed, which consists in sending it to your backend or any 3rd party integration directly from the app.

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
> To avoid processing a data that you already have - because the app has set it in the first place - in most cases, you should be able to ignore the event triggered when the parameter `source` is set to `client`.