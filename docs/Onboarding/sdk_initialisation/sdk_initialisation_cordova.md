---
title: Cordova
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
* @params String userId
* @params Purchasley.LogLevel logLevel
* @params Purchasely.RunningMode runningMode
**/
Purchasely.startWithAPIKey(
    '<<X-API-KEY>>', 
    ['Google'],
    true, // true for StoreKit 1, false for StoreKit 2
    null, // user id of user
    Purchasely.LogLevel.DEBUG, 
    Purchasely.RunningMode.full
);
```

### USER IDENTIFICATION

If you want the purchases and subscriptions to be associated to a user and not a device you can provide a user id in the `Purchasely.startWithAPIKey()`method.