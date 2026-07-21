---
title: Intercept Screens Actions with the Action Interceptor
excerpt: >-
  This section provides a details overview of the Action Interceptor and
  how to intercept actions
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    If you need to use the Action Interceptor to process transactions
    with your own subscription infrastructure
  pages:
    - type: basic
      slug: process-transactions-with-paywall-action-interceptor
      title: observer - using the Action Interceptor
---
<PaywallActionInterceptorWhatIsIt />

<br />

<PaywallActionInterceptorActionsIntercepted />

# Responding to an action: `SUCCESS`, `FAILED`, `NOT_HANDLED`

Every interceptor **must return a result** telling the SDK how your app handled the action. The SDK relies on this value to decide what to do next — perform the action itself, stop, or move on to the next action. There are three possible results:

| Result | iOS (Swift) | Android (Kotlin) | React Native | Flutter | What the SDK does |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **`SUCCESS`** | `completion(.success)` | `PLYInterceptResult.SUCCESS` | `return 'success'` | `PLYInterceptResult.success` | Your app handled the action. The SDK marks it done and **moves on to the next action** in the chain. For `purchase` / `restore` in `observer` mode, the SDK also **synchronizes the transaction automatically** — no `synchronize()` call needed. |
| **`FAILED`** | `completion(.failed)` | `PLYInterceptResult.FAILED` | `return 'failed'` | `PLYInterceptResult.failed` | Your app tried but failed. The SDK **stops the chain** (e.g. it won't open a screen after a failed purchase) and the button stops its loading state. |
| **`NOT_HANDLED`** | `completion(.notHandled)` | `PLYInterceptResult.NOT_HANDLED` | `return 'notHandled'` | `PLYInterceptResult.notHandled` | Your app declines to handle this occurrence. The SDK **performs the default action itself** (triggers the native purchase flow, opens the login screen, navigates…). Exception: in `observer` mode Purchasely never processes `purchase` / `restore`, so `NOT_HANDLED` on those does nothing. |

> 👍 You only register the actions you want to override
>
> Any action for which you did **not** register an interceptor is performed by the SDK as usual — so a button never stays stuck spinning. You don't need to return `NOT_HANDLED` for actions you aren't interested in.

> 📘 Cordova &amp; Unity (C#) use a boolean instead
>
> These bridges expose `Purchasely.onProcessAction(processAction)` (Cordova) / `purchasely.ProcessPaywallAction(processAction)` (Unity). Pass **`true`** to let the SDK perform the default action (equivalent to `NOT_HANDLED`), or **`false`** once your app has handled the action itself (equivalent to `SUCCESS`).

> 📘 `synchronize()` is only needed outside the interceptor
>
> In `observer` mode, returning `SUCCESS` on `purchase` / `restore` already triggers synchronization. Call `Purchasely.synchronize()` yourself **only** for transactions completed outside the paywall action interceptor — for example a purchase made in your own store screen or [BYOS](byos-implementation). See [observer — using the Action Interceptor](process-transactions-with-paywall-action-interceptor).

# Chaining several actions on one component

In the Screen Composer, a single component (a button, for instance) can be configured with **more than one action** — for example a `purchase` followed by an `open_screen`. The SDK runs the actions **in order, one after the other, and only moves to the next action if the previous one succeeded**:

* If an action returns **`SUCCESS`** (or you return `NOT_HANDLED` and the SDK's own handling succeeds), the SDK runs the **next** action.
* If an action returns **`FAILED`** (or the SDK's own handling fails), the **remaining actions are skipped**.

**Example** — a paywall button configured with `purchase`, then `open_screen`:

1. the user taps the button → the `purchase` action runs;
2. if the purchase completes successfully, the SDK moves on and runs `open_screen` (e.g. a "thank you" or onboarding screen);
3. if the purchase fails or is cancelled, `open_screen` is **not** executed.

This is exactly why returning the right result matters: returning `SUCCESS` too early would open the follow-up screen even though nothing was purchased, while returning `FAILED` / `NOT_HANDLED` by mistake would break the chain.

# Intercepting an action

Here is a sample code to show how to intercept a login or to make the user accept terms & conditions before proceeding to the purchase.

Note: This mechanism can also be used in `full` mode.

```swift
// Intercept the tap on login
Purchasely.interceptAction(.login) { [weak self] info, params, completion in
	// When the user has completed the process
	// Return .notHandled to reload the paywall if user is logged in
	self?.presentLogin(above: info?.controller) { (loggedIn) in
		Purchasely.userLogin(with: "MY_USER_ID")
		completion(loggedIn ? .notHandled : .success)
	}
}

// Intercept the tap on purchase to display the terms and condition
Purchasely.interceptAction(.purchase) { [weak self] info, params, completion in
	self?.presentTermsAndConditions(above: info?.controller) { (userAcceptedTerms) in
		completion(userAcceptedTerms ? .notHandled : .success)
	}
}
```
```kotlin
Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
    if (info?.activity == null) return@interceptAction PLYInterceptResult.NOT_HANDLED

    presentTermsAndConditions(info.activity) { userAcceptedTerms ->
        // Display your terms & conditions, then proceed
    }
    PLYInterceptResult.NOT_HANDLED
}

Purchasely.interceptAction<PLYPresentationAction.Login> { info, _ ->
    if (info?.activity == null) return@interceptAction PLYInterceptResult.NOT_HANDLED

    // Call your method to display your view
    presentLogin(info.activity) { userLoggedIn ->
        Purchasely.userLogin("MY_USER_ID")
    }
    PLYInterceptResult.NOT_HANDLED
}

// The interceptAction<T> { … } lambda above is a suspend lambda: you RETURN the result.
// If your call site is not a coroutine, use the Class-based overload (::class.java) and
// return the result later via the `result` lambda — call it exactly once:
Purchasely.interceptAction(PLYPresentationAction.Login::class.java) { info, action, result ->
    if (info?.activity == null) return@interceptAction result(PLYInterceptResult.NOT_HANDLED)
    presentLogin(info.activity) { userLoggedIn ->
        Purchasely.userLogin("MY_USER_ID")
        result(PLYInterceptResult.SUCCESS)
    }
}
```
```typescript React Native
import { Linking } from 'react-native';

// Register one handler per action kind.
// Return 'success' | 'failed' | 'notHandled'.

Purchasely.interceptAction('navigate', async (info, payload) => {
  console.log('User wants to navigate');
  if (payload?.kind === 'navigate') {
    Linking.openURL(payload.url);
    return 'success';
  }
  return 'notHandled';
});

Purchasely.interceptAction('close', async (info, payload) => {
  console.log('User wants to close paywall');
  return 'notHandled';
});

Purchasely.interceptAction('login', async (info, payload) => {
  console.log('User wants to login');
  // Present your own screen for user to log in
  Purchasely.userLogin('MY_USER_ID');
  // Return success to update Purchasely Paywall
  return 'success';
});

Purchasely.interceptAction('openPresentation', async (info, payload) => {
  console.log('User wants to open a new paywall');
  return 'notHandled';
});

Purchasely.interceptAction('purchase', async (info, payload) => {
  console.log('User wants to purchase');
  // If you want to intercept it, handle the purchase and display your screen
  return 'success';
});

Purchasely.interceptAction('restore', async (info, payload) => {
  console.log('User wants to restore his purchases');
  return 'notHandled';
});
```
```javascript Flutter
await Purchasely.interceptAction(
  PLYPresentationActionKind.navigate,
  (info, payload) async {
    print('User wants to navigate');
    return PLYInterceptResult.notHandled;
  },
);

await Purchasely.interceptAction(
  PLYPresentationActionKind.close,
  (info, payload) async {
    print('User wants to close paywall');
    return PLYInterceptResult.success;
  },
);

await Purchasely.interceptAction(
  PLYPresentationActionKind.login,
  (info, payload) async {
    print('User wants to login');
    //Present your own screen for user to log in
    Purchasely.userLogin('MY_USER_ID');
    return PLYInterceptResult.success;
  },
);

await Purchasely.interceptAction(
  PLYPresentationActionKind.openPresentation,
  (info, payload) async {
    print('User wants to open a new paywall');
    return PLYInterceptResult.notHandled;
  },
);

await Purchasely.interceptAction(
  PLYPresentationActionKind.purchase,
  (info, payload) async {
    print('User wants to purchase');
    //If you want to intercept it, handle the purchase and display your screen
    return PLYInterceptResult.success;
  },
);

await Purchasely.interceptAction(
  PLYPresentationActionKind.restore,
  (info, payload) async {
    print('User wants to restore his purchases');
    return PLYInterceptResult.notHandled;
  },
);
```
```swift Cordova
Purchasely.setPaywallActionInterceptor((result) => {
	console.log('Received action from paywall' + result.info.presentationId);
	
	if (result.action === Purchasely.PaywallAction.navigate) {
		console.log(
		'User wants to navigate to website ' +
			result.parameters.title +
			' ' +
			result.parameters.url
		);
		Purchasely.onProcessAction(true);
	} else if (result.action === Purchasely.PaywallAction.close) {
		console.log('User wants to close paywall');
		Purchasely.onProcessAction(true);
	} else if (result.action === Purchasely.PaywallAction.login) {
		console.log('User wants to login');
		//Present your own screen for user to log in
		Purchasely.closePresentation();
		Purchasely.userLogin('MY_USER_ID');
		//Call this method to update Purchasely Paywall
		Purchasely.onProcessAction(true);
	} else if (result.action === Purchasely.PaywallAction.open_presentation) {
		console.log('User wants to open a new paywall');
		Purchasely.onProcessAction(true);
	} else if (result.action === Purchasely.PaywallAction.purchase) {
		console.log('User wants to purchase');
		//If you want to intercept it, close presentation and display your screen
		Purchasely.closePresentation();
	} else if (result.action === Purchasely.PaywallAction.restore) {
		console.log('User wants to restore his purchases');
		Purchasely.onProcessAction(true);
	} else {
		console.log('Action unknown ' + result.action);
		Purchasely.onProcessAction(true);
	}
});
```
```csharp
private PurchaselyRuntime.Purchasely _purchasely;

purchasely.SetPaywallActionInterceptor(OnPaywallActionIntercepted);

private void OnPaywallActionIntercepted(PaywallAction action)
{
    Log($"Purchasely Paywall Action Intercepted. Action: {action.action}.");

    switch (action.action)
    {
        case "navigate":
            Log("User wants to navigate");
            purchasely.ProcessPaywallAction(true);
            break;

        case "close":
            Log("User wants to close paywall");
            purchasely.ProcessPaywallAction(false);
            break;

        case "login":
            Log("User wants to login");
            // Present your own screen for user to log in
            purchasely.ClosePresentation();
            purchasely.UserLogin("MY_USER_ID");
            // Call this method to update Purchasely Paywall
            purchasely.ProcessPaywallAction(true);
            break;

        case "open_presentation":
            Log("User wants to open a new presentation");
            purchasely.ProcessPaywallAction(true);
            break;

        case "purchase":
            Log("User wants to purchase");
            // If you want to intercept it, close presentation and display your screen
            purchasely.ClosePresentation();
            purchasely.ProcessPaywallAction(false);
            break;

        case "restore":
            Log("User wants to restore his purchases");
            purchasely.ProcessPaywallAction(true);
            break;

        default:
            Log($"Action unknown {action.action}");
            purchasely.ProcessPaywallAction(true);
            break;
    }
}
```

<br />

# Intercepting the purchase action

[Using the Action Interceptor to process transactions in observerMode](process-transactions-with-paywall-action-interceptor)
