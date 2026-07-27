---
name: PLYPresentation
---
```swift Swift
// In v6 PLYPresentation is a protocol, not a class
@objc public protocol PLYPresentation: NSObjectProtocol {
  var screenId: String { get }
  var height: Int { get }
  var language: String { get }
  var flowId: String? { get }
  var placementId: String? { get }
  var audienceId: String? { get }
  var abTestId: String? { get }
  var abTestVariantId: String? { get }
  var campaignId: String? { get }
  var type: PLYPresentationType { get }
  var transition: PLYTransition { get }
  var controller: PLYPresentationViewController? { get }
  var plans: [PLYPresentationPlan] { get }
  var metadata: PLYPresentationMetadata? { get }
  var backgroundColor: UIColor? { get }
  var connections: Set<PLYConnection> { get }
  var isFlow: Bool { get }
}
```
```kotlin Kotlin
// PLYPresentation is a typealias for PLYPresentationBase.Loaded
class Loaded(
    val screenId: String? = null,
    val height: Int = 0,
    val flowId: String? = null,
    val placementId: String? = null,
    val audienceId: String? = null,
    val abTestId: String? = null,
    val abTestVariantId: String? = null,
    val language: String? = null,
    val type: PLYPresentationType,
    val displayMode: PLYTransition? = null,
    val plans: List<PLYPresentationPlan>,
    val metadata: PLYPresentationMetadata? = null,
    val backgroundColor: String? = null,
    val connections: List<PLYConnection> = listOf(),
)
```
```typescript React Native
export type PurchaselyPresentation = {
  screenId: string;
  height: int | null;
  placementId?: string | null;
  audienceId?: string | null;
  abTestId?: string | null;
  abTestVariantId?: string | null;
  language?: string | null;
  type?: PLYPresentationType | null;
  plans?: PLYPresentationPlan[] | null;
  metadata: PLYPresentationMetadata;
};
```
