---
title: User Subscriptions History
excerpt: This section provides details about the history of user subscriptions
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
## Overview

The Purchasely SDK provides the ability to retrieve the list of expired subscriptions for a user, which constitutes the user's subscriptions history, directly from your app without calling your backend.\
This feature is particularly useful for understanding user behavior, analyzing subscription trends, and enhancing user engagement strategies.

> 🚧 Minimum SDK versions
>
> * iOS: 4.4.0
> * Android: 4.4.0
> * Flutter: 4.4.0
> * ReactNative: 4.4.0
> * Cordova: 4.4.0
> * Unity: 4.4.0

## Implementation

To retrieve the subscriptions history, use the appropriate code snippet for your technology.

```swift Swift
Purchasely.userSubscriptionsHistory(success: { (subscriptions) in
	// Subscription object contains the plan purchased and the source it was purchased from (iOS or Android)
	// Calling unsubscribe() will either switch the user to its AppStore settings 
	// or display a procedure on how to unsubscribe on Android
}, failure: { (error) in
	// Display error
})
```
```kotlin Kotlin
Purchasely.userSubscriptionsHistory(
    onSuccess = { list ->
        // Subscription object contains the plan purchased and the source it was purchased from (iOS or Android)
        // Calling unsubscribe() will either switch the user to its Google Play settings
        // or display a procedure on how to unsubscribe on iOS
    },
    onError = { throwable ->
        //Display error
    }
)
```
```typescript React Native
try {
  const subscriptions = await Purchasely.userSubscriptionsHistory();
  console.log(' ==> Subscriptions history');
  if (subscriptions[0] !== undefined) {
    console.log(subscriptions[0].plan);
    console.log(subscriptions[0].subscriptionSource);
    console.log(subscriptions[0].nextRenewalDate);
    console.log(subscriptions[0].cancelledDate);
  }
} catch (e) {
  console.log(e);
}
```
```dart Flutter
try {
  List<PLYSubscription> subscriptions =
      await Purchasely.userSubscriptionsHistory();
  print(' ==> Subscriptions history');
  if (subscriptions.isNotEmpty) {
    print(sdaubscriptions.first.plan);
    print(subscriptions.first.subscriptionSource);
    print(subscriptions.first.nextRenewalDate);
    print(subscriptions.first.cancelledDate);
  }
} catch (e) {
  print(e);
}
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

...
_purchasely.GetUserSubscriptionsHistory(OnGetSubscriptionsHistorySuccess, Log);
...

private void OnGetSubscriptionsHistorySuccess(List<SubscriptionData> subscriptionData)
{
  Log("Get Subscriptions history succeed.");

  foreach (var subscription in subscriptionData)
  {
    Log($"Subscription ID: {subscription.id}");

    var plan = subscription.plan;
    if (plan != null)
      LogPlan(plan);

    var product = subscription.product;
    if (product != null)
      LogProduct(product);
  }
}
```
```javascript Cordova
Purchasely.userSubscriptionsHistory(subscriptions => {
       console.log("Subscriptions history" + subscriptions);
		}, (error) => {
		   console.log(error);
		}
);
```

By implementing the above code, you will retrieve an array of Subscriptions.

<SDKGetUserSubscriptionsSubscriptionObject />

This list of Expired Subscriptions is the one the SDK leverages to fill in the [Built-in Expired Sub. Attributes](user-attributes-list#built-in-expired-subscription-attributes)
