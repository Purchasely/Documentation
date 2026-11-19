---
title: Subscription status listener
excerpt: >-
  Get the subscription status of the user at start, and each time a
  subscription is purchased, restored, redeemed from the web or expires
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
> 📘 Availability
>
> SDK 6.3.0 and later, on iOS, Android, React Native, Flutter and Cordova.

The subscription status listener tells your app if the user has an active subscription. Use it to unlock or lock the premium content of your app.

On iOS, the listener is a delegate: `PLYUserSubscriptionStatusDelegate`. On Android and on the cross-platform SDKs, it is a listener.

# Two types of calls

The SDK sends a `PLYUserSubscriptionStatus` object to your listener. This object has three properties:

| Property | Description |
| :-- | :-- |
| `isActive` | `true` when the user has one or more active subscriptions. Non-consumable products do not count. |
| `reason` | Why the SDK sends the call. See the table below. |
| `subscription` | The subscription of the call. It is empty only in a status call for a user with no subscription. |

There are two types of calls:

- A **status call** tells the current status. It has no reason: `.none` on iOS, `null` on Android and on the cross-platform SDKs.
- A **change call** tells that a subscription changed. It has one of these reasons:

| Reason | When the SDK sends it |
| :-- | :-- |
| `PURCHASED` | The user bought a subscription. |
| `RESTORED` | The user restored a subscription, for example with the Restore button or the [`ply/restore` deeplink](deeplinks#restore-purchases). |
| `EXPIRED` | A subscription is no longer active. |
| `WEB_REDEEMED` | A subscription arrived through a [Web2App redemption](web2app). |

On iOS, the reasons are `.purchased`, `.restored`, `.expired` and `.webRedeemed`. On Flutter, they are `purchased`, `restored`, `expired` and `webRedeemed`.

`isActive` describes the user, not the subscription of the call. For example, when the user changes from subscription A to subscription B, the listener gets `EXPIRED` for A with `isActive` `true`, then `PURCHASED` for B with `isActive` `true`.

# When the SDK sends a status call

The SDK sends a status call:

- at start, when the SDK has a saved list of subscriptions;
- when the SDK gets the first list of subscriptions of a user;
- when you add a listener and the SDK already knows the status (this listener only);
- at a login or a logout, when the last call said `isActive` `true`. This call has `isActive` `false` and no subscription. Then the first list of the new user gives a new status call.

> 🚧 Observer mode
>
> In [observer mode](observer-mode), your app makes the store purchases. The SDK sends only `EXPIRED`, `PURCHASED` for a web checkout and `WEB_REDEEMED` as change calls. After a purchase of your app and `synchronize()`, the listener gets a status call with `isActive` `true` and no reason.

# Implementation

The SDK calls the listener on the main thread. You can add more than one listener.

```swift Swift
import Purchasely

final class EntitlementsObserver: NSObject, PLYUserSubscriptionStatusDelegate {

    func start() {
        Purchasely.addUserSubscriptionStatusDelegate(self)
    }

    func stop() {
        Purchasely.removeUserSubscriptionStatusDelegate(self)
    }

    func userSubscriptionStatusUpdated(_ status: PLYUserSubscriptionStatus) {
        // Unlock or lock the premium content
        let isPremium = status.isActive

        switch status.reason {
        case .none: break        // Status call
        case .purchased: break
        case .restored: break
        case .expired: break
        case .webRedeemed: break
        @unknown default: break
        }
    }
}
```
```kotlin Kotlin
val listener = UserSubscriptionStatusListener { status ->
    // Unlock or lock the premium content
    val isPremium = status.isActive

    when (status.reason) {
        null -> Unit // Status call
        PLYUserSubscriptionStatusReason.PURCHASED -> Unit
        PLYUserSubscriptionStatusReason.RESTORED -> Unit
        PLYUserSubscriptionStatusReason.EXPIRED -> Unit
        PLYUserSubscriptionStatusReason.WEB_REDEEMED -> Unit
    }
}

Purchasely.addUserSubscriptionStatusListener(listener)

// When you do not need it anymore
Purchasely.removeUserSubscriptionStatusListener(listener)
```
```java Java
UserSubscriptionStatusListener listener = status -> {
    // Unlock or lock the premium content
    boolean isPremium = status.isActive();
    PLYUserSubscriptionStatusReason reason = status.getReason(); // null for a status call
};

Purchasely.addUserSubscriptionStatusListener(listener);

// When you do not need it anymore
Purchasely.removeUserSubscriptionStatusListener(listener);
```
```typescript React Native
import Purchasely from 'react-native-purchasely';

const subscription = Purchasely.addUserSubscriptionStatusListener((status) => {
  // Unlock or lock the premium content
  const isPremium = status.isActive;
  // status.reason: 'PURCHASED' | 'RESTORED' | 'EXPIRED' | 'WEB_REDEEMED', or null for a status call
});

// When you do not need it anymore
Purchasely.removeUserSubscriptionStatusListener(subscription);
```
```dart Flutter
Purchasely.addUserSubscriptionStatusListener((status) {
  // Unlock or lock the premium content
  final isPremium = status.isActive;
  // status.reason: purchased, restored, expired, webRedeemed, or null for a status call
});

// When you do not need it anymore
Purchasely.removeUserSubscriptionStatusListener();
```
```javascript Cordova
Purchasely.addUserSubscriptionStatusListener((status) => {
  // Unlock or lock the premium content
  const isPremium = status.isActive;
  // status.reason: 'PURCHASED', 'RESTORED', 'EXPIRED', 'WEB_REDEEMED', or null for a status call
});

// When you do not need it anymore
Purchasely.removeUserSubscriptionStatusListener();
```

## Kotlin Flow (Android)

On Android, `Purchasely.userSubscriptionStatusFlow()` gives the same calls as a Kotlin `Flow`. Each collection adds its own listener. When you cancel the collection, the SDK removes the listener.

```kotlin Kotlin
lifecycleScope.launch {
    Purchasely.userSubscriptionStatusFlow().collect { status ->
        // Unlock or lock the premium content
    }
}
```

## Platform rules

- **iOS:** the SDK holds the delegate weakly. Keep a strong reference to your delegate object.
- **Android:** `Purchasely.close()` removes all the listeners. Add them again after the next start.
- **Flutter and Cordova:** the SDK keeps one listener. A second call replaces the first listener.
- **React Native:** you can add more than one listener. Only the first listener is sure to get the status call.

# Deprecated APIs

This listener replaces the previous purchase APIs. They continue to work. On Android, they will be removed in SDK 7.0.

| Platform | Deprecated API |
| :-- | :-- |
| iOS | The `ply_purchasedSubscription` notification |
| Android | `Purchasely.purchaseListener`, `PurchaseListener` and `Purchasely.livePurchase()` |
| React Native | `addPurchasedListener` and `removePurchasedListener` |
| Flutter | `listenToPurchases` and `stopListeningToPurchases` |
| Cordova | `purchasedSubscription()` |

The old APIs tell your app about a purchase only. The new listener also tells the status at start, the restores, the expirations and the Web2App redemptions.
