---
name: observer mode - general principle
---
A typical purchase flow will be as follows:

1. the Paywall is displayed by the Purchasely SDK
2. when the user clicks on a purchase button, the Purchasely SDK hands over to the app using the <Glossary>Action Interceptor</Glossary>, providing the app with the references of the plan that was tapped\
   [More details on processing transactions with the <Glossary>Action Interceptor</Glossary>](process-transactions-with-paywall-action-interceptor)\
   [More details on using Purchasely with RevenueCat](revenuecat)
3. the app processes the transaction on its own
   * either through a 3rd party SDK (like RevenueCat)
   * or directly through StoreKit or Google Play Billing
4. once processed, the app returns a success result to the <Glossary>Action Interceptor</Glossary>; the Purchasely SDK then automatically synchronizes the transaction (it is observed, not processed, by Purchasely) — no manual `Purchasely.synchronize()` call is needed
5. and notifies the Purchasely SDK that the paywall can now be closed
