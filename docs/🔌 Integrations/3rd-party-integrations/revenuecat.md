---
title: RevenueCat
excerpt: >-
  This section describes how to use Purchasely platform with RevenueCat side by
  side
deprecated: false
hidden: false
metadata:
  title: ''
  description: >-
    The document explains how Purchasely can be integrated with a third-party
    In-App Purchase management platform like RevenueCat to create paywalls,
    determine pricing strategies, optimize user journeys, and ensure a seamless
    experience for visitors on different devices.
  robots: index
next:
  description: ''
---
Purchasely can be used in a multitude of setups depending on the features you wish to enable.

One example is the Integration of Purchasely’s Paywall Builder with a 3rd party In-App Purchase management platform such as RevenueCat.

By adopting Purchasely on top of the existing payment infrastructure, you can achieve the following:

* Creating paywalls in record time without coding
* Determine the right pricing strategy and improve your value proposition
* Optimizing user journey and maximizing conversion with an unlimited number of experiments
* Ensure the best experience for your visitors on different devices

> 📘 Works with any other in-app purchase platform
>
> Please note that the article provides a step-by-step guide to integrating Purchasely with RevenueCat, but the same process can apply to any third-party payment platform.

**Prerequisite**: You must implement Purchasely SDK in your application and configure Server to Server notifications (S2S) to collect the RevenuCat generated subscription data in real-time.

# Console configuration

To grant Purchasely permission to connect to mobile app stores like Apple and Google on your behalf, you need to make a small setup in the Purchasely console.

Head to the [quick start guide](sdk-quick-start) to learn more about the app store access setup.

**Note**: **there is no need to configure S2S notifications** at this stage. The article explains the S2S setup in the dedicated section below.

> 👍 Just an add-on
>
> This will not remove any existing setup you may have done with your system or RevenueCat, Purchasely will get the same access in addition to the ones you already provided to other services.

## Products and plans

Once you’ve given Purchasely permission to connect to app stores, you need to set up your in-app products and subscription plans (the same information set up in the RevenueCat console) in the Purchasely console.

When duplicating the information, **please be aware of the discrepancy in the definition of a “plan” and a “product” used by RevenueCat and Purchasely**.

**In Purchasely’s terms**:\
A “plan” is an item (SKU) you sell on Apple/Google, such as a subscription, consumable or non-consumable. A “product” is a group of plans where you can manage upgrades and downgrades.

**In RevenueCat’s terms**:\
A “product” is an item (SKU) you sell on Apple/Google which is equivalent to what is defined as a “plan” by Purchasely.

Refer to [Products & Plans setup](product-plans-setup) to learn more.

You can also provide us with [a csv file](subscribers-base-import) to fill in all the correct information on your behalf.

# SDK implementation

You can [install](sdk-installation/) Purchasely SDK for your application in iOS and Android native, React Native, Flutter or Cordova. The process differs for each platform, but the SDK usage is almost equivalent.

## Configuration

The `start` method must be called **as soon as possible** to catch every purchase / renewal.

```swift Swift
import Purchasely

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Purchasely
        .apiKey("API_KEY")
        .appUserId(nil)
        .runningMode(.observer)
        .logLevel(.debug)
        .start { error in
            print(error == nil)
        }
	return true
}
```
```kotlin Kotlin
import io.purchasely.ext.Purchasely

Purchasely.Builder(applicationContext)
    .apiKey("API_KEY")
    .logLevel(LogLevel.DEBUG) // set to warning or error for release
    .userId("USER_ID")
    .runningMode(PLYRunningMode.Observer)
    .stores(listOf(GoogleStore(), HuaweiStore()))
    .build()

// When you are ready for Purchasely to initialize,
// you must call start() method that will grab configuration and products
// from the selected stores.
Purchasely.start { error ->
}
```
```typescript React Native
import Purchasely from 'react-native-purchasely';

const configured = await Purchasely.builder('API_KEY')
  .appUserId('USER_ID')          // optional
  .stores(['google'])            // Android: 'google' | 'huawei' | 'amazon'
  .runningMode('observer')       // 'observer' (default) | 'full'
  .logLevel('debug')             // 'debug' | 'info' | 'warn' | 'error'
  .start();

if (!configured) {
  console.log('Purchasely SDK not configured');
}
```
```typescript Flutter
bool configured = await Purchasely.apiKey('API_KEY')
        .stores([PLYStore.google])              // google | huawei | amazon
        .runningMode(PLYRunningMode.observer)   // observer (default) | full
        .logLevel(PLYLogLevel.debug)            // debug | info | warn | error
        .start();

if (!configured) {
        print('Purchasely SDK not configured');
        return;
}
```
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
    'API_KEY',
    ['Google'],
    false, // false for StoreKit 2 (recommended), true for StoreKit 1
    null, // user id (optional)
    Purchasely.LogLevel.DEBUG,
    Purchasely.RunningMode.observer,
    (isConfigured) => {},
    (error) => console.error(error)
);
```

The `userID` parameter is optional and allows you to associate the purchase to a user instead of a device. You can also [set it up](user-identification) later if you wish to.

The most important argument to set, besides `apiKey` , of course, is the `runningMode` in **observer**

> 📘 Transactions
>
> In this mode, Purchasely will be able to display paywalls and observe transactions but **will not process** them and validate them with Apple and Google

## Display paywalls

All paywalls are displayed using Placements.

A Placement represents a specific location in your user journey inside your app (e.g., Onboarding, Settings, Home page, Article). A placement is linked to a paywall, and a single paywall can be used for different Placements. You can create as many Placements as you want, and it is the only thing that ties the app developer to the marketer.

Once the placements are defined and called from the app, you can change the displayed paywall remotely without any developer action.

> 📘 Pre-fetching
>
> We show here how to retrieve easily the Purchasely Screen to display but you should consider [pre-fetching](pre-fetching) the screen to handle more features like not displaying a screen

```swift Swift
let placementId = "ONBOARDING"
PLYPresentationBuilder.forPlacementId(placementId)
    .contentId(contentId)
    .onDismissed(completion)
    .build()
    .display(completion: nil)
```
```kotlin Kotlin
val placementId = "onboarding"
val contentId = "my_content_id" //or null
PLYPresentation {
    placementId(placementId)
    contentId(contentId)
}.preload { loaded, error ->
    if (error != null || loaded == null) return@preload
    val fragment = loaded.getFragment { outcome ->
        Log.d("Purchasely", "Result is ${outcome.purchaseResult} with plan ${outcome.plan}")
    }
}
```
```typescript React Native
await Purchasely.presentation
  .placement('onboarding')
  .contentId('my_content_id')
  .build()
  .display();
```
```Text Flutter
await PLYPresentationBuilder.placement('onboarding').build().display();
```
```typescript Cordova
Purchasely.presentPresentationForPlacement('onboarding');
```

## Implement an Interceptor

Finally, you must use the Paywall Actions Interceptor in your purchase system to register the purchase triggered by Purchasely's paywalls.

Here is an example where RevenueCat is used to make the purchase, which requires you to [fetch products](https://www.revenuecat.com/docs/displaying-products) from their SDK and then [start the purchase](https://www.revenuecat.com/docs/making-purchases)

```swift Swift
// Intercept the tap on purchase to make the purchase with RevenueCat
Purchasely.interceptAction(.purchase) { [weak self] info, params, completion in
	// Grab the plan to purchase
	guard let plan = params?.plan, let appleProductId = plan.appleProductId else {
		completion(.notHandled)
		return
	}

	Purchases.shared.getOfferings { (offerings, error) in
	    if let packages = offerings?.current?.availablePackages {
	        if( let package = packages.first { $0.storeProduct.productIdentifier == appleProductId}) {
			Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
			  //stop process on Purchasely side
	                  completion(.success)
			  if customerInfo.entitlements["your_entitlement_id"]?.isActive == true {
			    // Unlock that great "pro" content              
			  }
			}
		}
	    }
	}
}

Purchasely.interceptAction(.restore) { info, params, completion in
	Purchases.shared.restorePurchases { customerInfo, error in
	    //stop process on Purchasely side
	    completion(.success)
	}
}
```
```kotlin Kotlin
Purchasely.interceptAction<PLYPresentationAction.Purchase> { info, purchase ->
    val sku = purchase.plan?.store_product_id

    //get RevenueCat package
    Purchases.sharedInstance.getOfferingsWith({ error ->
    // An error occurred
    }) { offerings ->
        offerings.current
            ?.availablePackages
            ?.takeUnless { it.isNullOrEmpty() }
            ?.let { list ->
             val rcPackage = list.firstOrNull { it.product.sku == sku }

             Purchases.sharedInstance.purchasePackage(
                this,
                rcPackage,
                onError = { error, userCancelled ->
                    /* No purchase */
                },
                onSuccess = { product, customerInfo ->
                    if (customerInfo.entitlements["my_entitlement_identifier"]?.isActive == true) {
                        // Unlock that content
                        // SDK auto-synchronizes on success in observer mode
                    }
            })
        }
    }
    //stop process on Purchasely side
    PLYInterceptResult.SUCCESS
}

Purchasely.interceptAction<PLYPresentationAction.Restore> { info, _ ->
    // restore purchases with RevenueCat
    Purchases.sharedInstance.restorePurchases(::showError) { customerInfo ->
        //... check customerInfo to see if entitlement is now active
        // SDK auto-synchronizes on success in observer mode
    }
    //stop process on Purchasely side
    PLYInterceptResult.SUCCESS
}
```
```typescript React Native
// One handler per action kind. Return 'success' | 'failed' | 'notHandled'.

Purchasely.interceptAction('purchase', async (info, payload) => {
  if (payload?.kind !== 'purchase') {
    return 'notHandled';
  }

  // the store product id (sku) the user clicked on in the paywall
  const storeProductId = payload.plan.productId;

  try {
    const offerings = await Purchases.getOfferings();
    if (offerings.current !== null && offerings.current.availablePackages.length !== 0) {
      // get your package
      const pkg = offerings.current.monthly;

      // and purchase with RevenueCat
      const { customerInfo } = await Purchases.purchasePackage(pkg);
      if (typeof customerInfo.entitlements.active.my_entitlement_identifier !== 'undefined') {
        // Unlock that content
        // SDK auto-synchronizes on success in observer mode
      }
      return 'success';
    }
    return 'failed';
  } catch (e) {
    if (!e.userCancelled) {
      showError(e);
    }
    return 'failed';
  }
});

Purchasely.interceptAction('restore', async (info, payload) => {
  try {
    await Purchases.restorePurchases();
    // ... check restored customerInfo to see if entitlement is now active
    // SDK auto-synchronizes on success in observer mode
    return 'success';
  } catch (e) {
    return 'failed';
  }
});
```
```typescript Flutter
await Purchasely.interceptAction(
  PLYPresentationActionKind.purchase,
  (info, payload) async {
    if (payload is! PLYPurchasePayload) {
      return PLYInterceptResult.notHandled;
    }
    try {
      //the store product id (sku) the user clicked on in the paywall
      var productId = payload.plan.productId;

      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null && offerings.current.monthly != null) {
        //get your product from revenuecat
        Product product = offerings.current.monthly.product;

        //start purchase
        PurchaserInfo purchaserInfo = await Purchases.purchasePackage(product);
        if (purchaserInfo.entitlements.all["my_entitlement_identifier"].isActive) {
          // Unlock that great "pro" content
          // SDK auto-synchronizes on success in observer mode
        }
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
      // SDK auto-synchronizes on success in observer mode
      return PLYInterceptResult.success;
    } on PlatformException catch (e) {
      // Error restoring purchases
      return PLYInterceptResult.failed;
    }
  },
);
```
```typescript Cordova
Purchasely.interceptAction(Purchasely.PresentationAction.purchase, async (info, parameters) => {
  // the store product id (sku) the user clicked on in the paywall
  const storeProductId = parameters.plan.productId;
  try {
    const offerings = await Purchases.getOfferings();
    if (offerings.current && offerings.current.monthly) {
      const packageToBuy = offerings.current.monthly;
      const { purchaserInfo } = await Purchases.purchasePackage(packageToBuy);
      if (typeof purchaserInfo.entitlements.active.my_entitlement_identifier !== 'undefined') {
        // SDK auto-synchronizes on success in observer mode
      }
    }
    return Purchasely.InterceptResult.success;
  } catch (e) {
    return Purchasely.InterceptResult.failed;
  }
});

Purchasely.interceptAction(Purchasely.PresentationAction.restore, async (info, parameters) => {
  try {
    await Purchases.restoreTransactions();
    // SDK auto-synchronizes on success in observer mode
    return Purchasely.InterceptResult.success;
  } catch (e) {
    return Purchasely.InterceptResult.failed;
  }
});
```

<br />

> 🚧 Synchroniztation
>
> When **a purchase or a restoration** is made with your current flow, return a success result from the action interceptor. The SDK then synchronizes automatically so that new transactions are [caught](https://docs.purchasely.com/quick-start-1/sdk-configuration/observer-mode#4-sync-your-purchases-android-only) by our SDK (but not processed) — you no longer need to call `Purchasely.synchronize()` yourself in the interceptor success path.

# Data processing

You can leverage Purchasely’s data processing capabilities in observer mode to get relevant and useful information about your user subscription journey. Purchasely computes and standardizes all data across stores in real-time.

> 📘 Observer mode
>
> Purchasely only **observes** the data from the SDK or directly from the stores with Server to Server notifications. It does not validate them or grand entitlements, and this must still be done with your In-App Purchase service like RevenueCat.

## S2S notifications with Apple

App Store Connect only allows setting **one** endpoint url for S2S in production and sandbox mode. To circumvent this limitation, you can enable our `S2S Forwardings` integration in Purchasely console.\
In App Store Connect, you need to set the Purchasely url for S2S instead of the RevenueCat url

![](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FGgUdOzhqa07uh7nB2iZA%2Fuploads%2Ft2G6zCEZhHCqZXXwYGEl%2FSCR-20220927-osb.png?alt=media\&token=1ac14bb5-7698-48e5-a073-21358e998a9c)Then in Purchasely Console, you can set up a **S2S Forwardings** integration for Apple with RevenueCat endpoints

<Image align="center" className="border" border={true} src="https://files.readme.io/ac19717-Purchasely_RevenueCat.avif" />

<Image align="center" className="border" border={true} src="https://files.readme.io/0c3122b-Purchasely_RevenueCat_1.avif" />

You are all set! Purchasely and RevenueCat will communicate real-time information about your users' purchases with Apple.

> 📘 Use your own forwarding system
>
> You can also do the opposite by forwarding yourself Apple S2S notifications to Purchasely. RevenueCat also [provides such functionality](https://www.revenuecat.com/docs/platform-resources/server-notifications/apple-server-notifications#option-1-recommended-setting-up-revenuecat-to-forward-apple-notifications-to-your-server) if you prefer to use their own forwarding system.

## S2S notifications with Google

Server-to-Server notifications for Google are called [real-time developer notifications](https://developer.android.com/google/play/billing/rtdn-reference)\
It is possible to set up as many endpoints as you want to receive those notifications so that you can set up another for Purchasely.\
We provide an easy configuration in our console, where we connect directly to Google once you have provided your access key.

<Image align="center" className="border" border={true} src="https://files.readme.io/d61ae2a-Purchasely_RevenueCat_2.avif" />

It’s most likely that you’ve already setup S2S in the RevenueCat environment. This means a topic, probably named Play-Store-Notifications, has already been created on Google Pub/Sub.\
Select this topic from the dropdown list to add Purchasely as a recipient of the same S2S (set as a subscription in Google console)

> 🚧 Google Pub/Sub: One topic but multiple subscriptions
>
> Only one topic is set on Google Play Console to receive notifications in real time. A topic can have multiple endpoints (subscriptions in Google cloud console). Purchasely will add an endpoint to the same topic so that Google sends notifications to Purchasely and RevenueCat at the same time

<Image align="center" className="border" width="600px" border={true} src="https://files.readme.io/4fd3f11-image_17.png" />

Once you have selected your topic (or created a new one if none exists), click on Next so that the setup can be done by Purchasely automatically.

<Image align="center" className="border" width="600px" border={true} src="https://files.readme.io/a8598fa-Purchasely_RevenueCat_3.avif" />

After that, you can follow the instructions to ensure the correct topic is configured on Google Play Console.

## Importing your existing users

Finally you can [import your existing user base](subscribers-base-import) with active subscriptions and/or [setup an endpoint ](progressive-subscribers-migration)to send to Purchasely every new subscriber until you are in production with our SDK

This will provide multiple benefits:

* Accurate and relevant data in our [dashboard](console-dashboards) about your subscribers (active users, free trial, conversion, renewal disabled, grace period...)
* [Cohorts](dashboard-cohorts) of your entire subscription base history
* Historical reconstitution of every subscription with all [related events](server-events) coupled with financial data if the price was provided in the import file
* Recommendations from our customer experience for growth

> 📘 Google API limitation
>
> Due to a technical limitation from Google API, we will retrieve **full historical data of an active subscription** and up to **60 days for an inactive subscription** with Google Play Billing
