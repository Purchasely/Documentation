---
title: Unity
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

```csharp Unity
...
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely.PresentPresentationForPlacement('SAMPLE_PLACEMENT',
			OnPresentationResult,
			OnPresentationContentLoaded,
			OnPresentationContentClosed); 
```

<br />
