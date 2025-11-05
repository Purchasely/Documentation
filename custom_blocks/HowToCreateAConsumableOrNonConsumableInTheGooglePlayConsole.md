---
name: How to create an In-App Product in the Google Play Console?
---
# How to create an In-App Product in the Google Play Console?

1. Connect to the App Store Connect Console
2. Navigate to the following section:  
   _Google Play Console > [YOUR APP] > In-App Products _
3. Click on the blue button Create product in the upper right corner
4. Fill in the field `Product ID`.  
   The value of the Product ID will have to be reported in the Purchasely Console

   [block:image]{"images":[{"image":["https://files.readme.io/482aa6b-image.png",null,""],"align":"center","border":true}]}[/block]

<!----->

6. Fill in the Product details (`Name` & `Description`)

   [block:image]{"images":[{"image":["https://files.readme.io/f1f3809-image.png",null,""],"align":"center","border":true}]}[/block]
7. Set the Price either by selecting a pricing template or setting the price directly.  
   ⚠️ Multi-quantity products in a single transaction cannot be managed by the Purchasely Platform. You should therefore not check the box
8. Save

> 📘 Difference between consumable and non-consumable products in the Google Play Store
> 
> In the Google Play Console, In-App Product are not associated with a type (consumable / non consumable) like in the App Store.
> 
> Depending on which type (consumable / non consumable) you associate to the Plan in the Purchasely Console, the Purchasely SDK will indicate to the Google Play Store that the In-App Product has been consumed or not when completing the transaction.