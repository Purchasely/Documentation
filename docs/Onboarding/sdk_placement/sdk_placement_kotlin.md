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
Purchasely.fetchPresentation(placementId = "ONBOARDING") { presentation, error ->
  if(error != null) {
    Log.d("Purchasely", "Error fetching Screen", error)
    return@fetchPresentation
  }

  // call the display method and provide your Activity
  presentation.display(activity)
}
```
