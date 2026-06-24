---
title: Cordova observer
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
### SDK INITIALISATION

```javascript Cordova
/**
* @params String apiKey
* @params StringArray stores : may be Google, Amazon and Huawei
* @params Boolean storeKit1 : true for StoreKit 1, false for StoreKit 2 (iOS)
* @params String userId
* @params Purchasely.LogLevel logLevel
* @params Purchasely.RunningMode runningMode
**/
Purchasely.start(
    '<<X-API-KEY>>',
    ['Google'],
    false, // false for StoreKit 2 (recommended), true for StoreKit 1
    null, // user id of user
    Purchasely.LogLevel.DEBUG,
    Purchasely.RunningMode.observer, // observe transactions; your app owns purchases
    (isConfigured) => { /* Purchasely is started */ },
    (error) => { console.error(error); }
);
```

> 📘 Observer mode
>
> `Purchasely.RunningMode.observer` (value `2`) replaces v5's `observer`. In Observer mode your app owns the purchase flow; intercept the purchase/restore actions, run your billing, then call `Purchasely.synchronize()`.

### USER IDENTIFICATION

If you want the purchases and subscriptions to be associated to a user and not a device you can provide a user id in the `Purchasely.start()` method.
