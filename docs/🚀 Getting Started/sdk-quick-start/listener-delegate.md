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

# Web2App Redemption Delegate / Listener

When a user opens a `ply/redeem/TOKEN` deeplink, the Purchasely SDK redeems the web subscription. The SDK reports the outcome to your app. Your app can also draw the result screen itself, instead of the built-in alert.

This feature is available starting from the following versions:

* iOS: v6.1.0+
* Android: v6.1.0+

## Functionning

The SDK calls your delegate or your listener on the main thread. It calls it exactly once for each settled redemption.

Keep `appHandlesRedemptionAlert` at `false`, the default value, to let the SDK present its own success or failure alert. The SDK then calls your app once the user acknowledges that alert. On Android the listener fires when the user dismisses the outcome alert, unless the app owns the alert. Set `appHandlesRedemptionAlert` to `true` to suppress the built-in alert. The SDK then calls your app as soon as the redemption settles, and your app must show its own result screen.

## Implementation

```swift Swift
import Purchasely

// In your AppDelegate
Purchasely
    .apiKey("<<X-API-KEY>>")
    .webRedemptionDelegate(self, appHandlesRedemptionAlert: false)
    .start()

extension AppDelegate: PLYWebRedemptionDelegate {

    func webRedemptionCompleted(result: PLYWebRedemptionResult) {
        if result.isSuccess {
            // Unlock the content and draw your result screen
        } else {
            print("Redemption failed: \(result.errorCode) \(result.errorMessage)")
        }
    }
}
```
```kotlin
Purchasely.Builder(applicationContext)
    .apiKey("<<X-API-KEY>>")
    .webRedemptionListener { result ->
        when (result) {
            is PLYWebRedemptionResult.Success -> {
                val subscription = result.context?.subscription
                // Unlock the content and draw your result screen
            }
            is PLYWebRedemptionResult.Failure -> {
                println("Redemption failed: ${result.errorCode} ${result.errorMessage}")
            }
        }
    }
    .build()
    .start { error -> }
```

On iOS the protocol is `PLYWebRedemptionDelegate`, and it requires the single method `webRedemptionCompleted(result:)`. The `PLYWebRedemptionResult` object exposes `isSuccess`, `errorCode`, `errorMessage`, `replay` and `context`. The `context` is a `PLYWebRedemptionContext`, and its `subscription` property is an optional `PLYSubscription`.

On Android the callback method is `PLYWebRedemptionListener.onRedemptionCompleted`. The `PLYWebRedemptionResult` class is a sealed class of `Success(context, replay)` and `Failure(errorCode, errorMessage)`. The `subscription` property of the context is a `PLYSubscriptionData`, the type that `Purchasely.userSubscriptions()` returns.

Check both levels for `null` on Android. The `context` of a `Success` is `null` when the response of the server carries nothing to describe. The `subscription` of a present context is separately `null` when the redemption unlocks no subscription. The SDK today always builds a context on a success, but the field stays nullable for a future response shape. The `errorCode` and the `errorMessage` of a `Failure` are also nullable.

The `replay` value is `true` when the server reports that the token was already redeemed. It is `false` for a fresh redemption. The flag is a verdict of the server about the token, not an observation of the behaviour of the user. The SDK keeps no cache of the outcome, and it calls the server on every attempt.

Android also provides a two-argument form of the builder method and of the DSL method: `webRedemptionListener(appHandlesRedemptionAlert = true) { result -> }`. Both forms take `appHandlesRedemptionAlert` first, then the listener.

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

* iOS: v5.0.2+
* Android: v5.0.4+
* React Native: v5.0.4+

## Functionning

When the user submit their answer(s) to the Survey, if a user attribute has been associated to the survey, this listener / delegate will automatically be called by the SDK to handover to the app. 

After the app has been notified, it can: 

* fetch the data `{attribute ID, type, value(s)}` 
* and process it

## Implementation

<EventListenerForCustomUserAttributesImplementation />

The listener should be implemented for the following types of Custom User Attributes:

* `String`
* `Int`
* `Float`
* `Bool`
* `Date`
* `Array of Strings`

> 📘 Surveys allowing multiple choice answers are associated with the type Array of Strings
>
> When configuring your survey, you can define whether multiple answers are allowed or not.
>
> * If the Survey is configured to allow ONE single answer, the attribute returned will be a **String**
> * If the Survey is configured to allow MULTIPLE answers, the attribute returned will be an **Array of Strings**.

Once fetched, the data can be processed, which consist in sending it to your backend or any 3rd party integration directly from the app.

## Understanding the `PLYUserAttributeSource`

The `source` parameter of the listener/delegate methods indicates where the user attribute update originated. It can have two possible values:

* **PURCHASELY**: The change was initiated internally by the Purchasely’s SDK. 
* **CLIENT**: The change was triggered directly by your app. 

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
