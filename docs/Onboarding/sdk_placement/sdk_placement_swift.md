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
Purchasely.fetchPresentation(
    for: "ONBOARDING",
    fetchCompletion: { presentation, error in
         guard let presentation = presentation, error == nil else {
             print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
             return
         }
         
         // call the display method and provide the currently displayed UIViewController
         presentation.display(from: myUIViewController)
    }
)
```
