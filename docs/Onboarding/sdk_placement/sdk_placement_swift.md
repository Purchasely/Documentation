---
title: Swift
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

```swift
let placementId = "ONBOARDING"
PLYPresentationBuilder.forPlacementId(placementId)
    .contentId(contentId)
    .onDismissed(completion)
    .build()
    .preload { presentation, error in
    }
```
