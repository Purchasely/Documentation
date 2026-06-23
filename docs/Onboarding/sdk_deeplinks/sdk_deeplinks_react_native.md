---
title: React Native
excerpt: ''
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
To manage deeplinks you need to do up to 3 things:

* Pass the deeplink to the Purchasely SDK when it is received by the application
* Optionally control when Purchasely is allowed to display content over your interface
* Set a default presentation handler to get the result of what was done by the user on the paywall / screen

### PASSING THE DEEPLINK TO THE PURCHASELY SDK

To enable the Purchasely SDK to analyze the deeplink, the app needs to pass it using the following code:

```javascript React Native
Purchasely.isDeeplinkHandled('app://ply/presentations/')
          .then((value) => console.log('Deeplink handled by Purchasely ? ' + value));
```

### FORBIDDING THE DISPLAY

By **default**, Purchasely deeplinks are displayed **immediately** when they are received.

If your app has a launch routine that must complete before a screen can be shown (splash screen, onboarding, login, displaying an ad…), you can **temporarily prevent** the display, then re-enable it once you are ready:

```kotlin React Native
Purchasely.allowDeeplink(false);
// later, once your app is ready
Purchasely.allowDeeplink(true);
```

### SETTING THE DEFAULT PRESENTATION HANDLER

Usually when a paywall / screen is instantiated by the app, a closure is called back to inform the app of what has happened with the paywall / screen. However, when a deeplink is called, as you don't instantiate the paywall / screen yourself, no closure will be called.

You can retrieve the result of the user action in a paywall opened with a deeplink by setting the global default dismiss handler with `setDefaultPresentationDismissHandler`. It is the v6 replacement for the v5 `setDefaultPresentationResultCallback` / `setDefaultPresentationResultHandler`.

```javascript React Native
const subscription = Purchasely.setDefaultPresentationDismissHandler((outcome) => {
  // outcome: { presentation, purchaseResult, plan, closeReason, error }
  // `presentation` is always populated — use it to identify which screen closed.
  console.log('Presentation dismissed:', outcome.purchaseResult); // 'purchased' | 'restored' | 'cancelled' | null

  if (outcome.plan != null) {
    console.log('Plan Vendor ID:', outcome.plan.vendorId);
    console.log('Plan Name:', outcome.plan.name);
  }
});

// Only one handler is active at a time (re-registering replaces it).
// Remove it when you no longer need it:
//   subscription.remove();
//   // or Purchasely.removeDefaultPresentationDismissHandler();
```
