---
title: SDK Paywall Observer Mode
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
# What is the `paywallObserver` mode?

<PaywallObserverModeIntro />

The `paywallObserver` mode allows the use Purchasely on top of an existing subscription infrastructure, such as RevenueCat or an existing in-house subscription platform.

The existing subscription infrastructure continues to process transactions and the Purchasely platform is used on top of it. The Purchasely SDK observes these transactions to fill the Purchasely Dashboards with the data, but it does not acknowledge them with the App stores.

<PaywallObserverModeGeneralPrinciple />

A typical purchase flow will be as follows:

1. the Paywall is displayed by the Purchasely SDK
2. when the user clicks on a purchase button, the Purchasely SDK hands over to the app using the <<glossary:Paywall Action Interceptor>>, providing the app with the references of the plan that was tapped  
   [More details on processing transactions with the <<glossary:Paywall Action Interceptor>>](process-transactions-with-paywall-action-interceptor)  
   [More details on using Purchasely with RevenueCat](revenuecat)
3. the app processes the transaction on its own
   - either through a 3rd party SDK (like RevenueCat)
   - or directly through StoreKit or Google Play Billing
4. once processed, the app synchronizes the transaction with the Purchasely SDK by calling the  `Purchasely.synchronize()` method
5. and notifies the Purchasely SDK that the paywall can now be closed

<br />

<PaywallActionInterceptorWhatIsIt />

# What is the Paywall Action Interceptor?

The Paywall Action Interceptor allows to intercept and override every interaction the users have with a Purchasely Screen.

This can be used to:

- Intercept purchase and restore actions to perform them using your own code or another SDK
- Intercept the login button tapped to display your login form
- Force the explicit acceptance of terms and conditions before a purchase
- Intercept the call to a webview to inject credentials and be directly logged in
- Block promo codes in Kids category apps to add a parental permission gate
- Block direct access to external content (webview or link to Safari) in Kids category apps to add a parental permission gate

With the action interceptor, you get everything you need to:

- Get the action (and context)
- Display views, errors, messages, … above the Purchasely Screens
- Choose if Purchasely should continue the action or not

<PaywallActionInterceptorActionsIntercepted />

# What Paywall Actions can be intercepted?

You can intercept the following buttons being tapped:

- Close
- Login
- Navigate (web or deeplink)
- Purchase
- Win-back / retention offer
- Restore
- Open another paywall
- Promo code

<PaywallObserverModeTransactionProcessing />

# What happens with the transaction processed by my own system?

Once the app has processed the transaction, the Purchasely SDK fetches the receipt created and sends it to the Purchasely Platform, to feed the platform with all the analytics associated to the receipt (subscription events, revenue, mapping with the user etc).

The transaction will however not be finished (App Store) nor acknowledged (Google Play Store). In the Paywall Observer Mode, this is the responsibility of the developer to do it.