---
title: Kotlin
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
### CALLING A PLACEMENT FROM THE APP CODE

```kotlin
let placementId = "SAMPLE_PLACEMENT"
paywallCtrl = Purchasely.presentationController(for: placementId, contentId: contentId, loaded: { _, _, _ in
            }, completion: completion)
```