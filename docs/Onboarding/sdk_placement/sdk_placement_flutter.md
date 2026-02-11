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

```swift Flutter
try {
  var presentation = await Purchasely.fetchPresentation("ONBOARDING");

  //Display Purchasely Screen
  var presentResult = await Purchasely.presentPresentation(presentation);
} catch (e) {
  print(e);
}
```

<br />
