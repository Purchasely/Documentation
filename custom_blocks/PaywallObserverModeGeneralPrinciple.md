---
name: paywallObserver mode - general principle
---
A typical purchase flow will be as follows:

1. the Paywall is displayed by the Purchasely SDK
2. when the user clicks on a purchase button, the Purchasely SDK hands over to the app using the <Glossary>Paywall Action Interceptor</Glossary>, providing the app with the references of the plan that was tapped\
   [More details on processing transactions with the <Glossary>Paywall Action Interceptor</Glossary>](process-transactions-with-paywall-action-interceptor)\
   [More details on using Purchasely with RevenueCat](revenuecat)
3. the app processes the transaction on its own
   * either through a 3rd party SDK (like RevenueCat)
   * or directly through StoreKit or Google Play Billing
4. once processed, the app synchronizes the transaction with the Purchasely SDK by calling the  `Purchasely.synchronize()` method
5. and notifies the Purchasely SDK that the paywall can now be closed
