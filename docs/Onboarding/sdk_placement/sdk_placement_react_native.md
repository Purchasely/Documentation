---
title: React Native
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

```javascript React Native
const placementId = 'SAMPLE_PLACEMENT';

const request = Purchasely.presentation
    .placement(placementId)
    .contentId(contentId)
    .build();

const presentation = await request.preload();
if (presentation == null) return;

const outcome = await request.display();
```

<br />
