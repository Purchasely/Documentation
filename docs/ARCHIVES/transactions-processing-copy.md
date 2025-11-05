---
title: Archive - Transactions processing (COPY)
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
Transaction processing differs depending on the SDK running mode.

* In Full Mode, transactions are processed automatically by the Purchasely SDK.\
  \=> [Implementation guide for processing transactions in Full Mode](process-transactions-full-mode)
* In paywallObserver Mode, you need to use the <Glossary>Paywall Action Interceptor</Glossary> to intercept the click on the purchase button and process the transaction manually.\
  \=> [Implementation guide for processing transactions using the Paywall Action Interceptor](process-transactions-with-paywall-action-interceptor)
* <br />

# Full mode

Display paywalls and manage in-app transactions

## When to use this mode?

In the Full mode, Purchasely handles transactions, analytics and paywall.

Most of Purchasely customers use this mode because it allows to take benefit of all powerful features from Purchasely.

This mode is particularly relevant for teams starting their journey with in-app subscriptions as it will avoid developers to:

* code an in-house transaction processor, manage the subscribers lifecycle and produce store-specific code to plug with the app stores (3 to 6 months of work in average) 
* waste time on developing the paywall(s)

Instead, teams can focus on developing their core product and features and use subscriptions as a convenience.

## What can you do in this mode?

* Display paywalls and change them remotely
* Create as many paywalls as you want to multiply the touch points
* Process transactions and extract meaningful data from stores receipts
* Receive unified subscription events from our Webhook to trigger your automations
* Connect this data with your marketing tools using our integrations
* Analyse your business with the dashboards integrated in the Purchasely Console

## Implementation

### 1. Start the SDK

The first thing you need to do is to call the start method passing the mode `paywallObserver` / `PLYRunningModePaywallObserver`.

[View implementation details]()

### 2. Set user identifier

We need to know whenever a user is logged in or logged out to:

* Hide the login button in the paywalls
* Check if the user already used a trial and display the correct price

[View implementation details]()

### 3. Configure and present paywalls

To display a paywall, you need to can get a Controller / Fragment from Purchasely.

[View implementation details]()

### 4. Save/Verify user subscriptions

Purchases can be performed without any paywall involved. This is what happens for kids with ask-to-buy or with PSD2 flows.\
In these cases your app is notified by the SDK and you must unlock the content / service.

[View implementation details]()

After the initial purchase you will want to check the status. To do so you can use one of the following options:

* Using your backend (if you implemented Webhook)
* Using Firebase (if you have our Firebase extension)
* Using the SDK's userSubscriptions method

### 5. Configure deeplinks (optional)

Paywalls can be used in many othe ways that can be:

* Promoted In-App Purchase
* Deeplinks
* Push notifications deeplinks

### 6. Migrate your existing subscriber base (optional)

If your app already has subscribers, you must migrate them to Purchasely to:

* Have complete dashboards including every subscriber acquired in the past
* Handle status using the userSubscriptions

Follow [this guide]() to import your subscribers to Purchasely.

# PaywallObserver mode

## When to use it ?

This mode is perfect to use Purchasely data and Purchasely paywalls without changing your existing purchase layer.\
You can use this mode if you want to:

* use Purchasely remotely modifiable paywalls
* benefit of our unified data set of subscription events to get a better understanding of your subscribers' lifecycle
* fuel your marketing tools with these events and create no-code automations
* all this without changing your legacy transaction processor / backend

## What you can do in this mode ?

You can:

* Display paywalls and modify them remotely
* Create as many paywalls as you need and multiply the touch points
* Receive our subscription events from our Webhook to trigger your automations
* Connect our data with your marketing tools using our integrations
* Analyse your business with our great charts

Purchasely will provide the controllers (iOS) and fragments (Android) for your paywalls and will inform you about subscription events through our Webhook and integrations.

> ❗️ Important
>
> In this mode Purchasely won't consume your purchases or acknowledge purchases made.
>
> * On iOS we won't finish the transaction of your consumables that will remain in the queue if you don't do that in your code.
> * On Android the transactions will be cancelled and refunded after 3 days.

## Implementation

### 1. Start the SDK

The `start` method must be called as soon as possible to catch every purchase / renewal.

> 📘
>
> In this mode, Purchasely will be able to display paywalls and observe transactions but will not process them and validate them with Apple and Google

The most important argument to set, besides `apiKey` , of course, is the `runningMode` in **paywallObserver**

The `userID` parameter is optional and allows you to associate the purchase to a user instead of a device. You can also set it up later if you wish to.

```coffeescript Swift
import Purchasely

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Purchasely.start(withAPIKey: "API_KEY,
                         appUserId: nil,
			 runningMode: .paywallObserver,
			 eventDelegate: nil,
			 logLevel: .debug) { (success, error) in
		print(success)
        }
	return true
}
```
```Text Objective-C
#import <Purchasely/Purchasely-Swift.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.

	[Purchasely startWithAPIKey:@"API_KEY"
			  appUserId:@"USER_ID"
			runningMode: PLYRunningModePaywallObserver
	              eventDelegate:nil
			 uiDelegate:nil
	  paywallActionsInterceptor:nil
		           logLevel: LogLevelInfo
			initialized: nil];
	return YES;
}
```
```coffeescript Kotlin
import io.purchasely.ext.Purchasely

Purchasely.Builder(applicationContext)
    .apiKey("API_KEY")
    .logLevel(LogLevel.DEBUG) // set to warning or error for release
    .userId("USER_ID")
    .runningMode(PLYRunningMode.PaywallObserver)
    .stores(listOf(GoogleStore(), HuaweiStore()))
    .build()

// When you are ready for Purchasely to initialize,
// you must call start() method that will grab configuration and products
// from the selected stores.
Purchasely.start { isConfigured ->
}
```
```coffeescript Java
List<Store> stores = new ArrayList();
stores.add(new GoogleStore(), new HuaweiStore());

new Purchasely.Builder(getApplicationContext())
    .apiKey("API_KEY")
    .logLevel(LogLevel.DEBUG) // set to warning or error for release
    .userId("USER_ID")
    .runningMode(PLYRunningMode.Full.PaywallObserver)
    .stores(stores)
    .build();

// When you are ready for Purchasely to initialize,
// you must call start() method that will grab configuration and products
// from the selected stores.
Purchasely.start(isConfigured -> {
    null;
});
```
```typescript React Native
import Purchasely from 'react-native-purchasely';

/**
* @params String apiKey
* @params StringArray stores : may be Google, Amazon and Huawei
* @params String userId
* @params Purchasley.LogLevel logLevel
* @params RunningMode runningMode
**/
Purchasely.startWithAPIKey(
  'API_KEY',
  ['Google'],
  'USER_ID',
  Purchasely.logLevelDebug,
  RunningMode.PaywallObserver
);

```
```coffeescript Flutter
/**
* @params String apiKey
* @params StringArray stores : may be Google, Amazon and Huawei
* @params String userId
* @params PLYLogLevel logLevel
* @params PLYRunningMode runningMode
**/
bool configured = await Purchasely.startWithApiKey(
        'API_KEY',
        ['Google'],
        null,
        PLYLogLevel.debug,
        PLYRunningMode.paywallObserver
    );
    
if (!configured) {
        print('Purchasely SDK not configured');
        return;
}
```
```coffeescript Unity
var userId = Guid.NewGuid().ToString();
_purchasely = new PurchaselyRuntime.Purchasely(userId,
                                               false,
                                               LogLevel.Debug,
                                               RunningMode.Full,
                                               OnPurchaselyStart);

paywall.Init(_purchasely);
```
```javascript Cordova
/**
* @params String apiKey
* @params StringArray stores : may be Google, Amazon and Huawei
* @params String userId
* @params Purchasley.LogLevel logLevel
* @params Purchasely.RunningMode runningMode
**/
Purchasely.startWithAPIKey(
    'API_KEY', 
    ['Google'], 
    null, 
    Purchasely.LogLevel.DEBUG, 
    Purchasely.RunningMode.paywallObserver
);
```

[View implementation details]()

### 2. Set user identifier

We need to know whenever a user is logged in or logged out to:

* Hide the login button in the paywalls
* Check if the user already used a trial and display the correct price

[View implementation details]()

Use a PaywallActionInterceptor to handle login from a paywall and display your login screen

### 3. Configure and present paywalls

To display a paywall, you need to can get a Controller / Fragment from Purchasely.

[View implementation details]()

Then you must use the Paywall Actions Interceptor to perform the purchase triggered from Purchasely's paywalls with your purchase system.

Here is an example where `MyPurchaseSystem` is your internal subscription management system.

```coffeescript Swift
Purchasely.setPaywallActionsInterceptor { [weak self] (action, parameters, presentationInfos, proceed) in
	switch action {
		// Intercept the tap on purchase to display the terms and condition
		case .purchase:
			// Grab the plan to purchase
			guard let plan = parameters?.plan, let appleProductId = plan.appleProductId else {
				proceed(false)
				return
			}

			MyPurchaseSystem.purchase(appleProductId) { (success, error) {
				// We handle the purchase so we tell Purchasley not to handle it
				proceed(false)				
				if success {
					presentationInfos?.controller?.dismiss(animated: true, completion: nil)
				}
			}
		
		default:
			proceed(true)
	}
}
```
```coffeescript Objective-C
[Purchasely setPaywallActionsInterceptor:^(enum PLYPresentationAction action, PLYPresentationActionParameters *parameters, PLYPresentationInfo *presentationInfos, void (^ proceed)(BOOL)) {
        switch (action) {
            // Intercept the tap on purchase to display the terms and condition
            case PLYPresentationActionPurchase:{
                // Grab the plan to purchase
                NSString *appleProductId = parameters.plan.appleProductId;
                
                if (appleProductId == nil) {
                    proceed(NO);
                    return;
                }
                
                [MyPurchaseSystem purchase:appleProductId completion:^(BOOL success, NSError *Error) {
                    // We handle the purchase so we tell Purchasely not to handle it
                    proceed(false);
                    if (success) {
                        [presentationInfos.controller dismissViewControllerAnimated:YES completion:nil];
                    }
                }];

                break;
            }
            default:
                proceed(YES);
                break;
        }
    }];
```
```coffeescript Kotlin
Purchasely.setPaywallActionsInterceptor { info, action, parameters, processAction ->
    if (info?.activity == null) return@setPaywallActionsInterceptor

    when(action) {
        PLYPresentationAction.PURCHASE -> {
            Purchasely.plan("PLAN_VENDOR_ID",
                onSuccess = { plan ->
                    MyPurchaseSystem.purchase(plan.store_product_id)
                    processAction(false)
                },
                onError = { throwable ->
                    //display an error
                    processAction(false)
                }
            )
        }
        else -> processAction(true)
    }
}
```
```coffeescript Java
Purchasely.setPaywallActionsInterceptor((info, action, parameters, listener) -> {
    switch (action) {
        case PURCHASE:
            Purchasely.plan("PLAN_VENDOR_ID", new PlanListener() {
                @Override
                public void onSuccess(@Nullable PLYPlan plan) {
                    MyPurchaseSystem.purchase(plan.store_product_id);
                    listener.processAction(false);
                }

                @Override
                public void onFailure(@NotNull Throwable throwable) {
                    //display an error
                    listener.processAction(false);
                }
            });                    
            break;
        default:
            listener.processAction(true);
    }
});
```
```typescript React Native
Purchasely.setPaywallActionInterceptorCallback((result) => {
    if (result.action === PLYPaywallAction.PURCHASE) {
      try {
        const plan = await Purchasely.planWithIdentifier('PLAN_VENDOR_ID');
        
        //If you want to intercept it, close paywall and display your screen
        Purchasely.closePaywall();
        
        MyPurchaseSystem.purchase(plan.productId)
        
        Purchasely.onProcessAction(false);
      } catch (e) {
        console.log(e);
        Purchasely.onProcessAction(false);
      }
    } else {
      Purchasely.onProcessAction(true);
    }
  });
```
```coffeescript Flutter
```
```coffeescript Unity
```
```javascript Cordova
Purchasely.setPaywallActionInterceptorCallback(
          (PaywallActionInterceptorResult result) {
    if (result.action == PLYPaywallAction.purchase) {
      try {
        var plan = await Purchasely.planWithIdentifier('PLAN_VENDOR_ID');
        
        //If you want to intercept it, close paywall and display your screen
        Purchasely.closePaywall();
        
        MyPurchaseSystem.purchase(plan.productId)
        
        Purchasely.onProcessAction(false);
      } catch (e) {
        print(e);
        Purchasely.onProcessAction(false);
      }
    } else {
      Purchasely.onProcessAction(true);
    }
 });
```

### 4. Sync your purchases (Android only)

In `oberver` and `paywallObserver` modes, when a purchase or a restoration is made with your current flow, call the `synchronize()` method of our SDK to send the receipt to our backend. This allow us to save the receipts on our server to prepare for your migration.

```coffeescript Kotlin
Purchasely.synchronize()
```
```coffeescript Java
Purchasely.synchronize();
```
```typescript React Native
Purchasely.synchronize();
```
```coffeescript Flutter
Purchasely.synchronize
```
```coffeescript Unity
```
```javascript Cordova
Purchasely.synchronize();
```

### 5. Configure deeplinks (optional)

Paywalls can be used in many othe ways that can be:

* Promoted In-App Purchase
* Deeplinks
* Push notifications deeplinks

### 6. Migrate your existing subscriber base (optional)

If your app already has subscribers, you must migrate them to Purchasely to:

* Have complete dashboards including every subscriber acquired in the past
* Handle status using the userSubscriptions

Follow [this guide]() to import your subscribers to Purchasely.
