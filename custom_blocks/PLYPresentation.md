---
name: PLYPresentation
---
```coffeescript Swift
class PLYPresentation {
  let id: String?
  let height: Int?
  let language: String
  let placementId: String?
  let audienceId: String?
  let abTestId: String?
  let abTestVariantId: String?
  let type: PLYPresentationType
  let controller: PLYPresentationViewController?
  let plans: [PLYPresentationPlan]
  let metadata: PLYPresentationMetadata?
  let backgroundColor: UIColor?
}

```
```coffeescript Kotlin
data class PLYPresentation(
    val id: String?,
    val height: Int?,
    val placementId: String?,
    val audienceId: String?,
    val abTestId: String?,
    val abTestVariantId: String?,
    val language: String?,
    val type: PLYPresentationType,
    val plans: List<PLYPresentationPlan>,
    val metadata: PLYPresentationMetadata?,
    val backgroundColor: String?
}
```
```typescript React Native
export type PurchaselyPresentation = {
  id: string;
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
