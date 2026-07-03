---
title: Flutter
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

To enable the Purchasely SDK to analyze the deeplink, the app needs to pass it using the following code. You can also allow deeplinks at initialization with `PurchaselyBuilder.apiKey("YOUR_API_KEY").allowDeeplink(true).start()`.

```dart Flutter
final handled = await Purchasely.handleDeeplink('app://ply/presentations/');
print('Deeplink handled by Purchasely? $handled');
```

> 📘 `handleDeeplink` replaces the v5 name
>
> In v6 the runtime method is `Purchasely.handleDeeplink(uri)`. The old `isDeeplinkHandled` name was removed.

#### Cold start (deeplink that launched the app)

If your app is **launched from** a deeplink, pass the captured URL to the start
builder. The SDK resolves it automatically once configured — **no separate
`Purchasely.handleDeeplink(...)` call is needed**:

```dart Flutter
await PurchaselyBuilder.apiKey('YOUR_API_KEY')
    .allowDeeplink(true)
    .handleDeeplink(launchDeeplink) // null when not launched from a deeplink
    .start();
```

`handleDeeplink(null)` (or omitting the modifier) is a no-op. This mirrors the
native `PurchaselyBuilder.handleDeeplink(_:)` (iOS) and
`Purchasely.Builder.handleDeeplink(uri)` (Android).

> 📘 Which events fire on a deeplink open
>
> Opening a presentation via a deeplink emits `DEEPLINK_OPENED`,
> `PRESENTATION_LOADED` and `PRESENTATION_VIEWED` (`PRESENTATION_OPENED` is **not**
> emitted for a deeplink — it only fires when an in-paywall action opens another
> presentation).

### FORBIDDING THE DISPLAY

By **default**, Purchasely deeplinks are displayed **immediately** when they are received.

If your app has a launch routine that must complete before a screen can be shown (splash screen, onboarding, login, displaying an ad…), you can **temporarily prevent** the display, then re-enable it once you are ready:

```dart Flutter
// Prevent the display (e.g. while your onboarding is on screen)
Purchasely.allowDeeplink(false);

// Re-enable it once ready — any queued deeplink displays immediately
Purchasely.allowDeeplink(true);
```

> 📘 You only need this if you want to **defer** deeplinks. Do nothing and they display as soon as they are received. `allowDeeplink` replaces the v5 `readyToOpenDeeplink` name, which was removed.

### SETTING THE DEFAULT PRESENTATION HANDLER

Usually when a paywall / screen is instantiated by the app, a closure is called back to inform the app of what has happened with the paywall / screen. However, when a deeplink is called, as you don't instantiate the paywall / screen yourself, no closure will be called.

You can retrieve the result of the user action in a paywall opened with a deeplink by attaching `onDismissed` to a default-source request.

```dart Flutter
PLYPresentationBuilder.defaultSource()
    .onDismissed((outcome) {
      print('Presentation dismissed: ${outcome.purchaseResult}');
      if (outcome.plan != null) {
        print('Plan: ${outcome.plan?.name}');
      }
    })
    .build()
    .display();
```
