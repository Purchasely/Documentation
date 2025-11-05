---
name: SDK - getUserSubscriptions - Subscription Object
---
```swift Swift
public class PLYSubscription: NSObject {
	
  public var product: PLYProduct
  public var plan: PLYPlan
  public var subscriptionSource: PLYSubscriptionSource
  public var nextRenewalDate: Date?
  public var cancelledDate: Date?
  public var originalPurchasedDate: Date?
  public var purchasedDate: Date?
  public var offerType: PLYSubscriptionOfferType
  public var status: PLYSubscriptionStatus
  public var environment: PLYSubscriptionEnvironment
  public var storeCountry: String?
  public var isFamilyShared: Bool
  public var contentId: String?
  public var offerIdentifier: String?

}
```
```kotlin Kotlin
class PLYSubscriptionData(
    val data: PLYSubscription,
    val plan: PLYPlan,
    val product: PLYProduct
)

class PLYSubscription(
    val id: String? = null,
    val storeType: StoreType? = null,
    val purchaseToken: String? = null,
    val planId: String? = null,
    val cancelledAt: String? = null,
    val nextRenewalAt: String? = null,
    val originalPurchasedAt: String? = null,
    val purchasedAt: String? = null,
    val offerType: PLYOfferType? = PLYOfferType.NONE,
    val environment: PLYEnvironment? = null,
    val storeCountry: String? = null,
    val isFamilyShared: Boolean? = null,
    val contentId: String? = null,
    val offerIdentifier: String? = null,
    val subscriptionStatus: PLYSubscriptionStatus? = null,
    val cumulatedRevenuesInUSD: Double? = null,
    val subscriptionDurationInDays: Int? = null,
    val subscriptionDurationInWeeks: Int? = null,
    val subscriptionDurationInMonths: Int? = null,
)
```
```typescript React Native
type PurchaselySubscription = {
  purchaseToken: string;
  subscriptionSource: SubscriptionSource;
  nextRenewalDate: string;
  cancelledDate: string;
  plan: PurchaselyPlan;
  product: PurchaselyProduct;
};
```
```dart Flutter
class PLYSubscription {
  String? purchaseToken;
  PLYSubscriptionSource? subscriptionSource;
  String? nextRenewalDate;
  String? cancelledDate;
  PLYPlan? plan;
  PLYProduct? product;
}
```
```csharp Unity
public class SubscriptionData
{
  public Plan plan;
  public Product product;
  public string contentId;
  public string environment;
  public string id;
  public bool isFamilyShared;
  public string offerIdentifier;
  public SubscriptionOfferType offerType;
  public string originalPurchasedAt;
  public string purchaseToken;
  public string purchasedDate;
  public string nextRenewalDate;
  public string cancelledDate;
  public string storeCountry;
  public StoreType storeType;
  public SubscriptionStatus status;
}
```
```javascript Cordova
subscription.id;
subscription.storeType;
subscription.purchaseToken;
subscription.planId;
subscription.cancelledAt;
subscription.nextRenewalAt;
subscription.originalPurchasedAt;
subscription.purchasedAt;
subscription.plans
subscription.offerType;
subscription.environment;
subscription.storeCountry;
subscription.isFamilyShared;
subscription.contentId;
subscription.offerIdentifier;
subscription.subscriptionStatus;
subscription.cumulatedRevenuesInUSD;
subscription.subscriptionDurationInDays;
subscription.subscriptionDurationInWeeks;
subscription.subscriptionDurationInMonths;
```