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

To enable the Purchasely SDK to analyze the deeplink, the app needs to pass it using the following code. You can also allow deeplinks at initialization with `Purchasely.builder('YOUR_API_KEY').allowDeeplink(true).start()`.

```javascript React Native
const handled = await Purchasely.handleDeeplink('app://ply/presentations/');
console.log('Deeplink handled by Purchasely? ' + handled);
```

> 📘 `isDeeplinkHandled` was renamed to `handleDeeplink`
>
> In v6 the runtime method is `Purchasely.handleDeeplink(uri)` (same signature, `Promise<boolean>`). The v5 names `isDeeplinkHandled` and `readyToOpenDeeplink` **no longer exist** (no alias). Allow deeplinks at startup with `allowDeeplink(true)` on the builder; for a deeplink captured at cold start, pass it to the builder with `handleDeeplink(url)` and the SDK replays it once `start()` completes.

### FORBIDDING THE DISPLAY

By **default**, Purchasely deeplinks are displayed **immediately** when they are received.

If your app has a launch routine that must complete before a screen can be shown (splash screen, onboarding, login, displaying an ad…), you can **temporarily prevent** the display, then re-enable it once you are ready:

```javascript React Native
// Prevent the display (e.g. while your onboarding is on screen)
Purchasely.allowDeeplink(false);

// Re-enable it once ready — any queued deeplink displays immediately
Purchasely.allowDeeplink(true);
```

> 📘 You only need this if you want to **defer** deeplinks. Do nothing and they display as soon as they are received. `allowDeeplink` replaces the v5 deeplink-permission method.

### SETTING THE DEFAULT PRESENTATION HANDLER

Usually when a paywall / screen is instantiated by the app, a closure is called back to inform the app of what has happened with the paywall / screen. However, when a deeplink is called, as you don't instantiate the paywall / screen yourself, no closure will be called.

You can retrieve the result of the user action in a paywall opened with a deeplink by setting the global default dismiss handler with `setDefaultPresentationDismissHandler`. It is the v6 replacement for the v5 default presentation result callbacks.

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
