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
val placementId = "SAMPLE_PLACEMENT"
PLYPresentation {
    placementId(placementId)
    contentId(contentId)
}.preload { loaded, error ->
    if (error != null || loaded == null) return@preload
    loaded.display(context)
}
```
