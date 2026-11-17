---
title: observer - using the Action Interceptor
excerpt: >-
  How a purchase works in observer mode, step by step, and how to process
  transactions with the Paywall Action Interceptor
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: It's time to test that everything is functioning correctly
  pages:
    - type: basic
      slug: process-transactions-full-mode
      title: full mode
---
In `observer` mode, your app processes the transactions and Purchasely observes them. The Purchasely SDK displays the screens. When the user taps a purchase or restore button, the SDK gives the action to your app with the <Glossary>Action Interceptor</Glossary>. Your app does the purchase, then tells the SDK the result.

This page shows the full flow, what the SDK does after each result, and the code for each platform.

<PaywallActionInterceptorActionsIntercepted />

# How a purchase works in observer mode

## Who does what

| Step | Purchasely SDK | Your app |
| :-- | :-- | :-- |
| Display the screen | ✅ | |
| Show the loading state on the button and call your interceptor | ✅ | |
| Start the purchase or the restore (StoreKit, Google Play Billing, RevenueCat, your own system) | | ✅ |
| Finish the transaction (StoreKit) or acknowledge it (Google Play) | | ✅ |
| Unlock the content | | ✅ |
| Return the result to the interceptor (`success`, `failed` or `notHandled`) | | ✅ |
| Send the transaction to Purchasely (`synchronize()`) | ✅ after `success` on a purchase, and after a restore on Android | ✅ after a purchase on a screen of your app, and after a restore on iOS |
| Close the screen | ✅ only when the button has a close action after the purchase | ✅ in all other cases, with `Purchasely.closeAllScreens()` |

In observer mode, the SDK never starts a purchase with the store. It also does not finish (StoreKit) or acknowledge (Google Play) a transaction. Your app must do these steps.

The interceptor receives:

* `info` (`PLYInterceptorInfo`): the `contentId` and the `presentation` object of the screen. With the native SDKs, it also gives the view that displays the screen: `info.controller` on iOS, `info.activity` on Android. Use it to show your own views or error messages above the screen.
* the parameters of the action: for a purchase, the `plan` that the user selected (and, on Android, the `subscriptionOffer`). A restore has no parameters.

## Flow 1: purchase on a Purchasely screen

{/* TODO(screenshot): upload tmp/observer-interceptor/1-storyboard.png to ReadMe, then replace this comment with:
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="A purchase in observer mode, steps 1 to 4: the Purchasely screen, the loading state, the App Store purchase sheet, the store confirmation" />
*/}

```mermaid
sequenceDiagram
    actor User
    participant SDK as Purchasely screen (SDK)
    participant App as Your app
    participant Store as App Store / Google Play
    participant PLY as Purchasely backend

    User->>SDK: 1. Taps the purchase button
    Note over SDK: Loading state, PURCHASE_TAPPED event
    SDK->>App: 2. Calls the purchase interceptor with info and plan
    App->>Store: 3. Starts the purchase
    Store-->>App: 4. Returns the transaction
    App->>Store: 5. Finishes or acknowledges the transaction
    Note over App: Unlocks the content
    App-->>SDK: 6. Returns success
    SDK->>PLY: 7. synchronize() sends the transaction
    Note over SDK: 8. Stops the loading state and runs the next actions of the button
    App->>SDK: 8. Closes the screen with Purchasely.closeAllScreens() if the button has no close action
```

1. The user taps the purchase button. The SDK shows the loading state on the button and sends the `PURCHASE_TAPPED` event.
2. The SDK calls your purchase interceptor with `info` and the `plan` (and the `subscriptionOffer` on Android).
3. Your app starts the purchase with its system: StoreKit, Google Play Billing, RevenueCat or your own system.
4. The store returns the transaction to your app.
5. Your app finishes (StoreKit) or acknowledges (Google Play) the transaction, and unlocks the content.
6. Your app returns `success` to the interceptor.
7. The SDK calls `synchronize()`. It sends the transaction to the Purchasely backend, which updates the subscription, the events and the dashboards.
8. The SDK stops the loading state and runs the next actions of the button. If the button has no close action after the purchase, your app closes the screen with `Purchasely.closeAllScreens()`.

> 🚧 Return the result only when the purchase is complete
>
> The SDK calls `synchronize()` as soon as you return `success`. If you return `success` before the store confirms the purchase, Purchasely receives no new transaction.

> 🚧 React Native: the bridge waits 30 seconds for the result
>
> On React Native, the bridge waits 30 seconds for the result of your interceptor. After 30 seconds, it returns `notHandled`: the SDK does not call `synchronize()`, and it runs the next actions of the button. If a purchase ends after this delay, call `Purchasely.synchronize()` yourself.

## Flow 2: purchase on a screen of your app

When the user buys from a screen of your app (not a Purchasely screen), no interceptor runs. The SDK does not know about the purchase. Your app must call `Purchasely.synchronize()` after the transaction.

```mermaid
sequenceDiagram
    actor User
    participant App as Your app (your own screen)
    participant Store as App Store / Google Play
    participant SDK as Purchasely SDK
    participant PLY as Purchasely backend

    User->>App: 1. Taps the purchase button of your screen
    App->>Store: 2. Starts the purchase
    Store-->>App: 3. Returns the transaction
    App->>Store: 4. Finishes or acknowledges the transaction
    App->>SDK: 5. Calls Purchasely.synchronize()
    SDK->>PLY: 6. Sends the transaction
```

Call `Purchasely.synchronize()` after each transaction that your app completes outside of a Purchasely screen:

```swift
// After the transaction is complete (and finished) in your app
Purchasely.synchronize(success: {
    // Purchasely received the transaction
}, failure: { error in
    // Log the error: the purchase itself is not affected
})
```
```kotlin
// After the purchase is complete (and acknowledged) in your app
Purchasely.synchronize(
    onSuccess = { /* Purchasely received the purchase */ },
    onError = { error -> /* Log the error: the purchase itself is not affected */ }
)
```
```javascript React Native
// After the purchase is complete in your app
try {
  await Purchasely.synchronize();
} catch (e) {
  // Log the error: the purchase itself is not affected
}
```
```javascript Flutter
// After the purchase is complete in your app
try {
  await Purchasely.synchronize();
} on PlatformException catch (e) {
  // Log the error: the purchase itself is not affected
}
```
```javascript Cordova
// After the purchase is complete in your app
Purchasely.synchronize(
  () => { /* Purchasely received the purchase */ },
  (error) => { /* Log the error: the purchase itself is not affected */ }
);
```

## Restore

The restore flow is the same as Flow 1, with these differences:

* The SDK sends the `RESTORE_TAPPED` event and calls your restore interceptor. A restore has no parameters.
* Your app restores the purchases with its system, then returns `success` or `failed`.

> 🚧 On iOS, call `Purchasely.synchronize()` in your restore interceptor
>
> On iOS (SDK 6.2), the SDK does not call `synchronize()` after a restore that returns `success`. Call `Purchasely.synchronize()` in your restore interceptor, before you return `success`. On Android, the SDK calls it for you.
>
> This also applies to React Native, Flutter and Cordova apps on iOS.

## What the SDK does after each result

| Result | Purchase | Restore | Loading state | Next actions of the button |
| :-- | :-- | :-- | :-- | :-- |
| `success` | The SDK calls `synchronize()` | Android: the SDK calls `synchronize()`. iOS: no call, call it yourself | Stops | The SDK runs them (for example a close) |
| `failed` | No synchronization | No synchronization | Stops | Cancelled: the screen stays open. The SDK shows no error message: show your own if necessary |
| `notHandled` | Nothing: in observer mode, the SDK does not start a store purchase | Nothing | Stops | The SDK runs them |

> 📘 The user cancels the purchase
>
> No `cancelled` result exists. Return `failed` when the user cancels in the store sheet: the screen stays open and no synchronization occurs. With `success` or `notHandled`, the SDK runs the next actions of the button, for example a close.

In observer mode, if no interceptor is registered for a purchase or restore button, the SDK stops the loading state. It does not start a store purchase.

# Implementing the Action Interceptor

You register one interceptor per action with `Purchasely.interceptAction`. The samples below show the `purchase` and `restore` interceptors.

## Processing transactions with your in-house system

Here is a code sample using the Action Interceptor to process transactions **with your own in-house purchase system** , for the actions `purchase` and `restore`:

```swift
Purchasely.interceptAction(.purchase) { info, params, completion in
    // Grab the plan to purchase
    guard let plan = params?.plan, let appleProductId = plan.appleProductId else {
        completion(.failed)
        return
    }

    MyPurchaseSystem.purchase(appleProductId) { success in
        // Called when your purchase system completes the purchase
        if success {
            // The SDK synchronizes the transaction after success
            completion(.success) // notify Purchasely paywall to stop processing action
        } else {
            completion(.failed) // also when the user cancels: the screen stays open
        }
    }
}

Purchasely.interceptAction(.restore) { info, params, completion in
    MyPurchaseSystem.restorePurchases { success in
        guard success else {
            completion(.failed)
            return
        }
        // iOS: the SDK does not synchronize after a restore. Call it before you return success.
        Purchasely.synchronize(success: {}, failure: { _ in })
        completion(.success) // notify Purchasely paywall to stop processing action
    }
}
```
```kotlin
Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
    val subscriptionId = purchase.subscriptionOffer?.subscriptionId
    val basePlanId = purchase.subscriptionOffer?.basePlanId
    val offerId = purchase.subscriptionOffer?.offerId
    val offerToken = purchase.subscriptionOffer?.offerToken

    // you just need to pass the offerToken to BillingClient
    val success = MyPurchaseSystem.purchase(offerToken)

    if (success) {
        // The SDK synchronizes the purchase after SUCCESS
        PLYInterceptResult.SUCCESS // notify Purchasely paywall to stop processing action
    } else {
        PLYInterceptResult.FAILED // also when the user cancels: the screen stays open
    }
}

Purchasely.interceptAction<PLYPresentationAction.Restore> { info, _ ->
    val success = MyPurchaseSystem.restoreAllPurchases()
    // Android: the SDK synchronizes after SUCCESS
    if (success) PLYInterceptResult.SUCCESS else PLYInterceptResult.FAILED
}

// The interceptAction<T> { … } lambda above is a suspend lambda: you RETURN the result.
// If your call site is not a coroutine (e.g. your billing system reports through a callback),
// use the Class-based overload (::class.java) and return the result via the `result` lambda:
Purchasely.interceptAction(PLYPresentationAction.Purchase::class.java) { info, action, result ->
    val purchase = action as PLYPresentationAction.Purchase   // not cast for you here
    val offerToken = purchase.subscriptionOffer?.offerToken

    MyPurchaseSystem.purchase(offerToken) { success ->
        // called later from your billing callback — call result exactly once
        result(if (success) PLYInterceptResult.SUCCESS else PLYInterceptResult.FAILED)
    }
}
```
```javascript React Native
// Register one interceptor per action kind; each returns 'success' | 'failed' | 'notHandled'.
Purchasely.interceptAction('purchase', async (info, payload) => {
  if (payload?.kind !== 'purchase') {
    return 'notHandled';
  }
  try {
    // the store product id (sku) the user clicked on in the paywall
    const storeProductId = payload.plan.productId;

    if (Platform.OS === 'android') {
      // Only for Android you can retrieve other information about the purchase
      const basePlanId = payload.subscriptionOffer?.basePlanId;
      const offerId = payload.subscriptionOffer?.offerId;
      const offerToken = payload.subscriptionOffer?.offerToken;
    }

    const success = await MyPurchaseSystem.purchase(storeProductId);
    if (success) {
      // The SDK synchronizes the transaction after success
      return 'success'; // notify Purchasely paywall to stop processing action
    }
    return 'failed';
  } catch (e) {
    console.log(e);
    return 'failed';
  }
});

Purchasely.interceptAction('restore', async (info, payload) => {
  try {
    await MyPurchaseSystem.restorePurchases();
    if (Platform.OS === 'ios') {
      // iOS: the SDK does not synchronize after a restore (Android does)
      Purchasely.synchronize().catch((e) => console.log(e));
    }
    return 'success'; // notify Purchasely paywall to stop processing action
  } catch (e) {
    return 'failed';
  }
});
```
```javascript Flutter
// Register one handler per action kind; each returns a PLYInterceptResult.
await Purchasely.interceptAction(
  PLYPresentationActionKind.purchase,
  (info, payload) async {
    if (payload is! PLYPurchasePayload) {
      return PLYInterceptResult.notHandled;
    }
    try {
      //the store product id (sku) the user clicked on in the paywall
      final productId = payload.plan.productId;

      if (Platform.isAndroid) {
        // Only for Android you can get other interesting parameters
        final basePlanId = payload.subscriptionOffer?.basePlanId;
        final offerId = payload.subscriptionOffer?.offerId;
        final offerToken = payload.subscriptionOffer?.offerToken;
      }

      final success = await MyPurchaseSystem.purchase(productId);
      if (success) {
        // The SDK synchronizes the transaction after success
        return PLYInterceptResult.success;
      }
      return PLYInterceptResult.failed;
    } catch (e) {
      print(e);
      return PLYInterceptResult.failed;
    }
  },
);

await Purchasely.interceptAction(
  PLYPresentationActionKind.restore,
  (info, payload) async {
    try {
      await MyPurchaseSystem.restoreAllPurchases();
      if (Platform.isIOS) {
        // iOS: the SDK does not synchronize after a restore (Android does)
        Purchasely.synchronize().catchError((_) => false);
      }
      return PLYInterceptResult.success;
    } on PlatformException {
      // Error restoring purchases
      return PLYInterceptResult.failed;
    }
  },
);
```
```javascript Cordova
// Register one handler per action; each returns (or resolves to) a Purchasely.InterceptResult.
Purchasely.interceptAction(Purchasely.PresentationAction.purchase, async (info, parameters) => {
  // the store product id (sku) the user clicked on in the paywall
  const storeProductId = parameters.plan.productId;
  try {
    const success = await MyPurchaseSystem.purchase(storeProductId);
    return success
      ? Purchasely.InterceptResult.success // the SDK synchronizes the transaction after success
      : Purchasely.InterceptResult.failed; // also when the user cancels: the screen stays open
  } catch (e) {
    // Error making purchase
    return Purchasely.InterceptResult.failed;
  }
});

Purchasely.interceptAction(Purchasely.PresentationAction.restore, async (info, parameters) => {
  try {
    await MyPurchaseSystem.restoreTransactions();
    if (cordova.platformId === 'ios') {
      // iOS: the SDK does not synchronize after a restore (Android does)
      Purchasely.synchronize();
    }
    return Purchasely.InterceptResult.success;
  } catch (e) {
    // Error restoring purchases
    return Purchasely.InterceptResult.failed;
  }
});
```

> 📘 When to call `synchronize()` yourself
>
> When your purchase interceptor returns `success`, the SDK calls `synchronize()`. It sends the transaction to Purchasely, and it does not finish or acknowledge the transaction.
>
> Call `Purchasely.synchronize()` yourself in two cases only: after a purchase on a screen of your app (Flow 2), and in your restore interceptor on iOS.

## Processing transaction with RevenueCat

Here is a code sample using the Action Interceptor to process transactions **with RevenueCat** , for the actions `purchase` and `restore`:

```swift
Purchasely.interceptAction(.purchase) { info, params, completion in
    // Grab the plan to purchase
    guard let plan = params?.plan, let appleProductId = plan.appleProductId else {
        completion(.failed)
        return
    }

    Purchases.shared.getOfferings { (offerings, error) in
        guard let package = offerings?.current?.availablePackages
            .first(where: { $0.storeProduct.productIdentifier == appleProductId }) else {
            completion(.failed) // call completion in every code path
            return
        }
        Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
            // Return the result only when RevenueCat completes the purchase
            guard error == nil, !userCancelled else {
                completion(.failed) // also when the user cancels: the screen stays open
                return
            }
            if customerInfo?.entitlements["your_entitlement_id"]?.isActive == true {
                // Unlock that great "pro" content
            }
            // The SDK synchronizes the transaction after success
            completion(.success)
        }
    }
}

Purchasely.interceptAction(.restore) { info, params, completion in
    Purchases.shared.restorePurchases { customerInfo, error in
        guard error == nil else {
            completion(.failed)
            return
        }
        // iOS: the SDK does not synchronize after a restore. Call it before you return success.
        Purchasely.synchronize(success: {}, failure: { _ in })
        completion(.success)
    }
}
```
```kotlin
// RevenueCat reports through callbacks: use the Class-based overload,
// and call `result` exactly once, when RevenueCat completes.
Purchasely.interceptAction(PLYPresentationAction.Purchase::class.java) { info, action, result ->
    val purchase = action as PLYPresentationAction.Purchase
    val subscriptionId = purchase.subscriptionOffer?.subscriptionId
    val activity = info.activity

    if (activity == null) {
        result(PLYInterceptResult.FAILED)
    } else {
        // get the RevenueCat package
        Purchases.sharedInstance.getOfferingsWith({ error ->
            result(PLYInterceptResult.FAILED)
        }) { offerings ->
            val rcPackage = offerings.current?.availablePackages
                ?.firstOrNull { it.product.sku == subscriptionId }

            if (rcPackage == null) {
                result(PLYInterceptResult.FAILED)
            } else {
                Purchases.sharedInstance.purchasePackage(
                    activity,
                    rcPackage,
                    onError = { error, userCancelled ->
                        result(PLYInterceptResult.FAILED) // also when the user cancels: the screen stays open
                    },
                    onSuccess = { product, customerInfo ->
                        // Unlock the content, then return SUCCESS: the SDK synchronizes the purchase
                        result(PLYInterceptResult.SUCCESS)
                    }
                )
            }
        }
    }
}

Purchasely.interceptAction(PLYPresentationAction.Restore::class.java) { info, action, result ->
    // restore purchases with RevenueCat
    Purchases.sharedInstance.restorePurchases({ error ->
        result(PLYInterceptResult.FAILED)
    }) { customerInfo ->
        // ... check customerInfo to see if entitlement is now active
        // Android: the SDK synchronizes after SUCCESS
        result(PLYInterceptResult.SUCCESS)
    }
}
```
```javascript React Native
// Register one interceptor per action kind; each returns 'success' | 'failed' | 'notHandled'.
Purchasely.interceptAction('purchase', async (info, payload) => {
  if (payload?.kind !== 'purchase') {
    return 'notHandled';
  }
  try {
    // the store product id (sku) the user clicked on in the paywall
    const storeProductId = payload.plan.productId;

    if (Platform.OS === 'android') {
      // Only for Android you can retrieve other information about the purchase
      const basePlanId = payload.subscriptionOffer?.basePlanId;
      const offerId = payload.subscriptionOffer?.offerId;
      const offerToken = payload.subscriptionOffer?.offerToken;
    }

    const offerings = await Purchases.getOfferings();
    // get the RevenueCat package of the plan that the user selected
    const rcPackage = offerings.current?.availablePackages.find(
      (p) => p.product.identifier === storeProductId
    );
    if (rcPackage) {

      // and purchase with RevenueCat (a user cancel throws: see catch)
      const { customerInfo, productIdentifier } = await Purchases.purchasePackage(rcPackage);
      if (typeof customerInfo.entitlements.active.my_entitlement_identifier !== 'undefined') {
        // Unlock the content
      }
      // The SDK synchronizes the transaction after success
      return 'success'; // notify Purchasely paywall to stop processing action
    }
    return 'failed';
  } catch (e) {
    console.log(e);
    return 'failed';
  }
});

Purchasely.interceptAction('restore', async (info, payload) => {
  try {
    await Purchases.restorePurchases();
    // ... check restored purchaserInfo to see if entitlement is now active

    if (Platform.OS === 'ios') {
      // iOS: the SDK does not synchronize after a restore (Android does)
      Purchasely.synchronize().catch((e) => console.log(e));
    }
    return 'success'; // notify Purchasely paywall to stop processing action
  } catch (e) {
    return 'failed';
  }
});
```
```javascript Flutter
// Register one handler per action kind; each returns a PLYInterceptResult.
await Purchasely.interceptAction(
  PLYPresentationActionKind.purchase,
  (info, payload) async {
    if (payload is! PLYPurchasePayload) {
      return PLYInterceptResult.notHandled;
    }
    try {
      //the store product id (sku) the user clicked on in the paywall
      final productId = payload.plan.productId;

      if (Platform.isAndroid) {
        // Only for Android you can get other interesting parameters
        final basePlanId = payload.subscriptionOffer?.basePlanId;
        final offerId = payload.subscriptionOffer?.offerId;
        final offerToken = payload.subscriptionOffer?.offerToken;
      }

      Offerings offerings = await Purchases.getOfferings();
      // get the RevenueCat package of the plan that the user selected
      final rcPackage = offerings.current?.availablePackages
          .where((p) => p.storeProduct.identifier == productId)
          .firstOrNull;
      if (rcPackage != null) {
        //start the purchase (a user cancel throws: see catch)
        final purchaserInfo = await Purchases.purchasePackage(rcPackage);
        if (purchaserInfo.entitlements.all["my_entitlement_identifier"]?.isActive == true) {
          // Unlock the content
        }
        // The SDK synchronizes the transaction after success
        return PLYInterceptResult.success;
      }
      return PLYInterceptResult.failed;
    } catch (e) {
      print(e);
      return PLYInterceptResult.failed;
    }
  },
);

await Purchasely.interceptAction(
  PLYPresentationActionKind.restore,
  (info, payload) async {
    try {
      PurchaserInfo restoredInfo = await Purchases.restoreTransactions();
      // ... check restored purchaserInfo to see if entitlement is now active

      if (Platform.isIOS) {
        // iOS: the SDK does not synchronize after a restore (Android does)
        Purchasely.synchronize().catchError((_) => false);
      }
      return PLYInterceptResult.success;
    } on PlatformException {
      // Error restoring purchases
      return PLYInterceptResult.failed;
    }
  },
);
```
```javascript Cordova
Purchasely.interceptAction(Purchasely.PresentationAction.purchase, async (info, parameters) => {
  // the store product id (sku) the user clicked on in the paywall
  const storeProductId = parameters.plan.productId;
  try {
    const offerings = await Purchases.getOfferings();
    // get the RevenueCat package of the plan that the user selected
    const packageToBuy = offerings.current?.availablePackages.find(
      (p) => p.product.identifier === storeProductId
    );
    if (packageToBuy) {
      const { purchaserInfo } = await Purchases.purchasePackage(packageToBuy);
      if (typeof purchaserInfo.entitlements.active.my_entitlement_identifier !== 'undefined') {
        // Unlock the content
      }
      // The SDK synchronizes the transaction after success
      return Purchasely.InterceptResult.success;
    }
    return Purchasely.InterceptResult.failed;
  } catch (e) {
    // Error making purchase
    return Purchasely.InterceptResult.failed;
  }
});

Purchasely.interceptAction(Purchasely.PresentationAction.restore, async (info, parameters) => {
  try {
    await Purchases.restoreTransactions();
    if (cordova.platformId === 'ios') {
      // iOS: the SDK does not synchronize after a restore (Android does)
      Purchasely.synchronize();
    }
    return Purchasely.InterceptResult.success;
  } catch (e) {
    // Error restoring purchases
    return Purchasely.InterceptResult.failed;
  }
});
```

## Common errors

| Error | Result | Correction |
| :-- | :-- | :-- |
| The interceptor returns `success` before the store confirms the purchase | Purchasely receives no new transaction | Return the result only when the purchase is complete |
| The interceptor returns `success` when the user cancels | The SDK runs the next actions of the button (for example a close) | Return `failed` |
| The screen stays open after the purchase | The button has no close action, and the SDK does not close the screen in observer mode | Call `Purchasely.closeAllScreens()`, or add a close action after the purchase |
| No `Purchasely.synchronize()` after a purchase on a screen of your app | Purchasely does not see the transaction | Call `Purchasely.synchronize()` after each transaction outside of a Purchasely screen (Flow 2) |
| No `Purchasely.synchronize()` in the restore interceptor on iOS | Purchasely does not see the restored purchases | Call `Purchasely.synchronize()` before you return `success` |
| The app does not finish (StoreKit) or acknowledge (Google Play) the transaction | The SDK does not do it in observer mode | Finish or acknowledge each transaction in your app |
| The interceptor does not return a result in one of its code paths | The screen waits: the button keeps its loading state and the other actions do not run. The SDK writes a warning after 10 seconds. On React Native, the bridge returns `notHandled` after 30 seconds | Return exactly one result in each code path |

<br />

[More details on the Action Interceptor and how to intercept of types of actions](action-interceptor)
