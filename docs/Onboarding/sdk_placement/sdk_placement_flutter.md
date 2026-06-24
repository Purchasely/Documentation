---
title: Flutter
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

```dart Flutter
await PLYPresentationBuilder.placement('SAMPLE_PLACEMENT')
    .contentId(contentId)
    .build()
    .display(const PLYTransition.fullScreen());
```

<br />
