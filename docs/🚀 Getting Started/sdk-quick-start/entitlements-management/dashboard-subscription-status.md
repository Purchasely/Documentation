---
title: SDK entitlements - Getting the Subscription Status
excerpt: >-
  This section provides details on how to manage entitlements by getting the
  subscription status from the Purchasely SDK
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Limitation

If you consider using that feature instead of managing the entitlements yourself with your own backend, be aware that this approach is limited.

First of all, this approach can only be used in the following cases:

1. Your app doesn't sell consumables
2. The content / service is blocked by the app
3. All your subscribers are handled by Purchasely, you do not have a web payment system or a website where users can purchase or access your service.

Then, you should be aware that it is **less secured than checking with your server**.

If your device obfuscates the content or block the features based on a server info telling you are subscribed, if this info is altered by a third party you would be offering the content. This is exactly the case of a **man in the middle approach**.\
The most secure method is to manage the subscription through your backend and transmit the appropriate data based on the status.

# Retrieve user subscriptions

Purchasely offers a way to retrieve active subscriptions directly from your mobile app without calling your own backend.

```swift Swift
Purchasely.userSubscriptions(success: { (subscriptions) in
	// Subscription object contains the plan purchased and the source it was purchased from (iOS or Android)
	// Calling unsubscribe() will either switch the user to its AppStore settings 
	// or display a procedure on how to unsubscribe on Android
}, failure: { (error) in
	// Display error
})
```
```kotlin Kotlin
Purchasely.userSubscriptions(
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
  const subscriptions = await Purchasely.userSubscriptions();
  console.log(' ==> Subscriptions');
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
      await Purchasely.userSubscriptions();
  print(' ==> Subscriptions');
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
_purchasely.GetUserSubscriptions(OnGetSubscriptionsSuccess, Log);
...

private void OnGetSubscriptionsSuccess(List<SubscriptionData> subscriptionData)
	{
		Log("Get Subscription Data Success.");

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
Purchasely.userSubscriptions(subscriptions => {
       console.log("Subscriptions " + subscriptions);
		}, (error) => {
		   console.log(error);
		}
);
```

> 📘 Delay after a purchase or restoration
>
> There is a **few seconds delay** for `Purchasely.userSubscriptions()` to be updated after a purchase or a restoration. If you rely on this method to get the current subscription status of your user right after a purchase, you should **wait for 3 seconds** before calling this method

# Subscription class

<SDKGetUserSubscriptionsSubscriptionObject />

# Caching

`Purchasely.userSubscriptions()` uses an internal cache system that invalidate automatically based on the status of the subscriptions (new, renewed or cancelled)

In special cases where you find it necessary to manually invalidate the cache following a particular action in your application, you have the option to do so. 

However, we **strongly recommend consulting with our support team** beforehand to ensure your implementation aligns with best practices. 

This is crucial, as improper use of this feature may lead to its deactivation for your account (refer to the warning below for more details).

```swift Swift
Purchasely.userSubscriptions(refresh: true, success: { (subscriptions) in
	// Subscription object contains the plan purchased and the source it was purchased from (iOS or Android)
	// Calling unsubscribe() will either switch the user to its AppStore settings 
	// or display a procedure on how to unsubscribe on Android
}, failure: { (error) in
	// Display error
})
```
```kotlin Kotlin
Purchasely.userSubscriptions(invalidate = true,
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
  const subscriptions = await Purchasely.userSubscriptions();
  console.log(' ==> Subscriptions');
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
      await Purchasely.userSubscriptions();
  print(' ==> Subscriptions');
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
_purchasely.GetUserSubscriptions(OnGetSubscriptionsSuccess, Log);
...

private void OnGetSubscriptionsSuccess(List<SubscriptionData> subscriptionData)
	{
		Log("Get Subscription Data Success.");

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
Purchasely.userSubscriptions(subscriptions => {
       console.log("Subscriptions " + subscriptions);
		}, (error) => {
		   console.log(error);
		}
);
```

> 🚧 Usage limitation
>
> This API is designed for robust and consistent performance, catering to heavy usage and ensuring high availability. Nevertheless, should we observe **exceptionally high usage** that deviates from normal patterns, please be advised that we may need to impose limitations or temporarily deactivate this feature for your account to maintain overall system stability.
