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
paywallCtrl = Purchasely.presentationController(for: placementId, contentId: contentId, loaded: { _, _, _ in
            }, completion: completion)
```
