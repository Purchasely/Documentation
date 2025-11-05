---
title: Intercept Screens Actions with the Paywall Action Interceptor
excerpt: >-
  This section provides a details overview of the Paywall Action Interceptor and
  how to intercept actions
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    If you need to use the Paywall Action Interceptor to process transactions
    with your own subscription infrastructure
  pages:
    - type: basic
      slug: process-transactions-with-paywall-action-interceptor
      title: paywallObserver - using the Paywall Action Interceptor
---
<PaywallActionInterceptorWhatIsIt />

<br />

<PaywallActionInterceptorActionsIntercepted />

# Intercepting an action

Here is a sample code to show how to intercept a login or to make the user accept terms & conditions before proceeding to the purchase.

Note: This mechanism can also be used in `full` mode.

```swift
Purchasely.setPaywallActionsInterceptor { [weak self] (action, parameters, info, proceed) in

	switch action {
	
	// Intercept the tap on login
	case .login:
		// When the user has completed the process
		// Pass true to reload the paywall if user is logged in
		self?.presentLogin(above: info?.controller) { (loggedIn) in
			Purchasely.userLogin(with: "MY_USER_ID")
			proceed(loggedIn)
		}
	
	// Intercept the tap on purchase to display the terms and condition
	case .purchase:
		self?.presentTermsAndConditions(above: info?.controller) { (userAcceptedTerms) in
			proceed(userAcceptedTerms)
		}
	default:
		proceed(true)
		break
	}
}

```
```kotlin
Purchasely.setPaywallActionsInterceptor { info, action, parameters, processAction ->
    if (info?.activity == null) return@setPaywallActionsInterceptor

    when(action) {
        PLYPresentationAction.PURCHASE -> {
            presentTermsAndConditions(info.activity) { userAcceptedTerms ->
    		// Don't forget to notify the SDK by calling `processAction`
    		processAction(userAcceptedTerms)
        }
        PLYPresentationAction.LOGIN -> {
            // Call your method to display your view 
            // and return boolean result to userLoggedIn
            presentLogin(info.activity) { userLoggedIn ->
                Purchasely.userLogin("MY_USER_ID")
            // Pass true to reload the paywall if user is logged in
            processAction(userLoggedIn)
            }
        }
        else -> {
            Log.d("PLYActionInterceptor", action.value + " " + parameters)
            processAction(true)
        }
    }
}
```
```javascript React Native
Purchasely.setPaywallActionInterceptorCallback((result) => {
    console.log('Received action from paywall ' + result.info.presentationId);

    if (result.action === PLYPaywallAction.NAVIGATE) {
      console.log(
        'User wants to navigate to website ' +
          result.parameters.title +
          ' ' +
          result.parameters.url
      );
      Purchasely.onProcessAction(true);
    } else if (result.action === PLYPaywallAction.CLOSE) {
      console.log('User wants to close paywall');
      Purchasely.onProcessAction(true);
    } else if (result.action === PLYPaywallAction.LOGIN) {
      console.log('User wants to login');
      //Present your own screen for user to log in
      Purchasely.closePresentation();
      Purchasely.userLogin('MY_USER_ID');
      //Call this method to update Purchasely Paywall
      Purchasely.onProcessAction(true);
    } else if (result.action === PLYPaywallAction.OPEN_PRESENTATION) {
      console.log('User wants to open a new paywall');
      Purchasely.onProcessAction(true);
    } else if (result.action === PLYPaywallAction.PURCHASE) {
      console.log('User wants to purchase');
      //If you want to intercept it, close presentation and display your screen
      Purchasely.closePresentation();
    } else if (result.action === PLYPaywallAction.RESTORE) {
      console.log('User wants to restore his purchases');
      Purchasely.onProcessAction(true);
    } else {
      console.log('Action unknown ' + result.action);
      Purchasely.onProcessAction(true);
    }
  });
```
```javascript Flutter
Purchasely.setPaywallActionInterceptorCallback(
          (PaywallActionInterceptorResult result) {
  if (result.action == PLYPaywallAction.navigate) {
    print('User wants to navigate');
    Purchasely.onProcessAction(true);
  } else if (result.action == PLYPaywallAction.close) {
    print('User wants to close paywall');
    Purchasely.onProcessAction(false);
  } else if (result.action == PLYPaywallAction.login) {
    print('User wants to login');
    //Present your own screen for user to log in
    Purchasely.closePresentation();
    Purchasely.userLogin('MY_USER_ID');
    //Call this method to update Purchasely Paywall
    Purchasely.onProcessAction(true);
  } else if (result.action == PLYPaywallAction.open_presentation) {
    print('User wants to open a new paywall');
    Purchasely.onProcessAction(true);
  } else if (result.action == PLYPaywallAction.purchase) {
    print('User wants to purchase');
    //If you want to intercept it, close presentation and display your screen
    Purchasely.closePresentation();
    Purchasely.onProcessAction(false);
  } else if (result.action == PLYPaywallAction.restore) {
    print('User wants to restore his purchases');
    Purchasely.onProcessAction(true);
  } else {
    print('Action unknown ' + result.action.toString());
    Purchasely.onProcessAction(true);
  }
});
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
```csharp Unity
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

[Using the Paywall Action Interceptor to process transactions in paywallObserverMode](process-transactions-with-paywall-action-interceptor)
