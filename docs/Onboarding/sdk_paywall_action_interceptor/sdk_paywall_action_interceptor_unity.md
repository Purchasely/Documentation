---
title: Unity
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
Here is a code sample using the Paywall Action Interceptor to perform the purchase and restore actions triggered from Purchasely's paywall with your own purchase system

```csharp Unity
purchasely.SetPaywallActionInterceptor(OnPaywallActionIntercepted);

private void OnPaywallActionIntercepted(PaywallAction action)
	{
		Log($"Purchasely Paywall Action Intercepted. Action: {action.action}.");

		switch (action.action)
		{
			case "purchase":
				var storeProductId = action.parameters.plan?.storeProductId;
				var basePlanId = action.parameters.plan?.basePlanId;
				var offerId = action.parameters.offer?.storeOfferId;

				MyPurchaseSystem.purchase(storeProductId, basePlanId, offerId);
				// if purchase successful, synchronize all purchases with Purchasely
				purchasely.Synchronize();
				
				// notify Purchasely paywall to stop processing action
				purchasely.ProcessPaywallAction(false);

				break;
			case "restore":
				MyPurchaseSystem.restoreTransactions();
        // synchronize all purchases with Purchasely
				purchasely.Synchronize();
				// notify Purchasely paywall to stop processing action
				purchasely.ProcessPaywallAction(false);
				break;
			default:
					purchasely.ProcessPaywallAction(true);
					break;
		}
}
```
```c RevenueCat
purchasely.SetPaywallActionInterceptor(OnPaywallActionIntercepted);

private void OnPaywallActionIntercepted(PaywallAction action)
	{
		Log($"Purchasely Paywall Action Intercepted. Action: {action.action}.");

		switch (action.action)
		{
			case "purchase":
				var storeProductId = action.parameters.plan?.storeProductId;
				var basePlanId = action.parameters.plan?.basePlanId; //only for Android with Google
				var offerId = action.parameters.offer?.storeOfferId;
        
        var purchases = GetComponent<Purchases>();
        purchases.GetOfferings((offerings, error) =>
        {
          // Get the offering and product that matches the storeProductId and offerID
          // Here just a sample from RevenueCat documentation with the Monthly product
          if (offerings.Current != null && offerings.Current.Monthly != null){
            var product = offerings.Current.Monthly.Product;
            
            purchases.PurchasePackage(package, (product, customerInfo, userCancelled, error) =>
            {
              if (customerInfo.Entitlements.Active.ContainsKey("my_entitlement_identifier")) {
                // synchronize purchases with Purchasely
								purchasely.Synchronize();
              }
              
              // notify Purchasely paywall to stop processing action and hide loader
							purchasely.ProcessPaywallAction(false);
              
              // dismiss the paywall if you want
              purchasely.ClosePresentation();
            });
          }
        });
				break;
			case "restore":
				var purchases = GetComponent<Purchases>();
        purchases.RestorePurchases((info, error) =>
        {
            //... check purchaserInfo to see if entitlement is now active
          
          	// synchronize all purchases with Purchasely
            purchasely.Synchronize();
            // notify Purchasely paywall to stop processing action
            purchasely.ProcessPaywallAction(false);
            // dismiss the paywall if you want
            purchasely.ClosePresentation();
        }
				break;
			default:
					purchasely.ProcessPaywallAction(true);
					break;
		}
}
```
