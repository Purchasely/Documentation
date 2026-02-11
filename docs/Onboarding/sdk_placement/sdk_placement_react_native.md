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
try {
  const presentation = await Purchasely.fetchPresentation({
      placementId: 'ONBOARDING'
  })

  //Display Purchasely Screen
  const result = await Purchasely.presentPresentation({
    presentation: presentation
  })
} catch (e) {
  console.error(e);
}
```

<br />
