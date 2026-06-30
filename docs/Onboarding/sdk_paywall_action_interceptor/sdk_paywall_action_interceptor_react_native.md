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
Here is a code sample using the Action Interceptor to perform the purchase and restore actions triggered from Purchasely's paywall with your own purchase system.

Register **one handler per action kind** with `Purchasely.interceptAction(kind, handler)`. The handler simply returns an intercept result string (`'success'` / `'failed'` / `'notHandled'`) to tell Purchasely whether the action was handled — there is no callback to notify the paywall anymore.

> **Observer mode:** after handling a purchase, do your own billing and return `'success'` — the SDK calls `synchronize()` automatically to report the transaction.

```typescript In-House
import { Platform } from 'react-native'
import Purchasely from 'react-native-purchasely'

Purchasely.interceptAction('purchase', async (info, payload) => {
  if (payload?.kind !== 'purchase') {
    return 'notHandled'
  }
  try {
    // The store product id (sku) the user tapped on in the paywall
    const storeProductId = payload.plan.productId

    if (Platform.OS === 'android') {
      // Only for Android you can retrieve the subscription offer details
      const basePlanId = payload.subscriptionOffer?.basePlanId
      const offerId = payload.subscriptionOffer?.offerId
      const offerToken = payload.subscriptionOffer?.offerToken
    }

    const success = await MyPurchaseSystem.purchase(storeProductId)
    if (success) {
      // SDK auto-synchronizes on success in observer mode
      return 'success' // notify Purchasely the action was handled
    }
    return 'failed'
  } catch (e) {
    console.log(e)
    return 'failed'
  }
})

Purchasely.interceptAction('restore', async (info, payload) => {
  try {
    await MyPurchaseSystem.restorePurchases()
    // SDK auto-synchronizes on success in observer mode
    return 'success' // notify Purchasely the action was handled
  } catch (e) {
    // Error restoring purchases
    return 'failed'
  }
})
```
```typescript RevenueCat
import { Platform } from 'react-native'
import Purchasely from 'react-native-purchasely'
import Purchases from 'react-native-purchases'

Purchasely.interceptAction('purchase', async (info, payload) => {
  if (payload?.kind !== 'purchase') {
    return 'notHandled'
  }
  try {
    // The store product id (sku) the user tapped on in the paywall
    const storeProductId = payload.plan.productId

    if (Platform.OS === 'android') {
      // Only for Android you can retrieve the subscription offer details
      const basePlanId = payload.subscriptionOffer?.basePlanId
      const offerId = payload.subscriptionOffer?.offerId
      const offerToken = payload.subscriptionOffer?.offerToken
    }

    const offerings = await Purchases.getOfferings()
    if (offerings.current !== null && offerings.current.availablePackages.length !== 0) {
      // get your package
      const pkg = offerings.current.monthly

      // and purchase with RevenueCat
      try {
        const { customerInfo } = await Purchases.purchasePackage(pkg)
        if (typeof customerInfo.entitlements.active.my_entitlement_identifier !== 'undefined') {
          // SDK auto-synchronizes on success in observer mode
          return 'success' // notify Purchasely the action was handled
        }
      } catch (e) {
        if (!e.userCancelled) {
          showError(e)
        }
        return 'failed'
      }
    }
    return 'failed'
  } catch (e) {
    console.log(e)
    return 'failed'
  }
})

Purchasely.interceptAction('restore', async (info, payload) => {
  try {
    await Purchases.restorePurchases()
    // ... check restored customerInfo to see if entitlement is now active

    // SDK auto-synchronizes on success in observer mode
    return 'success' // notify Purchasely the action was handled
  } catch (e) {
    // Error restoring purchases
    return 'failed'
  }
})
```

You can register handlers for other action kinds the same way (e.g. `'login'`, or `'navigate'` with its typed payload — `payload.url`). To clean up, use `Purchasely.removeActionInterceptor(kind)` or `Purchasely.removeAllActionInterceptors()`.
