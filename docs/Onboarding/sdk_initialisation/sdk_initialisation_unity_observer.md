---
title: Unity observer
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

```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely = new PurchaselyRuntime.Purchasely("USER_ID",
			false, // true for StoreKit 1, false for StoreKit 2
			LogLevel.Debug,
			RunningMode.PaywallObserver,
			OnPurchaselyStart,
			OnPurchaselyEvent);
```

### USER IDENTIFICATION

If you want the purchases and subscriptions to be associated to a user and not a device you can provide a user id in the `PurchaselyRuntime.Purchasely()`method.