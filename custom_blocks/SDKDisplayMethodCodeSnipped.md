---
name: SDK - Display method code snipped
---
```swift Swift
Purchasely.fetchPresentation(for: "onboarding", fetchCompletion: { presentation, error in
      guard error == nil,
            let presentation = presentation else { return }
                                                                  
     // Calling display() to launch the flow
		 // Source UIViewController is optional 
     presentation.display(from: myUIViewController) 
})
```
```kotlin Kotlin
Purchasely.fetchPresentation(placementId = "onboarding") { presentation, error ->
  if(error != null) {
    Log.d("Purchasely", "Error fetching Screen", error)
    return@fetchPresentation
  }
  
  // Calling display() to launch the flow 
  presentation?.display(context)
}
```
```javascript React Native
try {
  // Fetch presentation to display
  const presentation = await Purchasely.fetchPresentation({
      placementId: 'onboarding'
  })

  if(presentation.type == PLYPresentationType.DEACTIVATED) {
    // No Screen to display
    return
  }

  if(presentation.type == PLYPresentationType.CLIENT) {
    // Display my own Screen
    return
  }

  //Display Purchasely Screen
  await Purchasely.presentPresentation({
    presentation: presentation
  })

} catch (e) {
  console.error(e);
}
```
```javascript Flutter
try {
  var presentation = await Purchasely.fetchPresentation("onboarding");

  if (presentation == null) {
    print("No presentation found");
    return;
  }

  if (presentation.type == PLYPresentationType.deactivated) {
    // No Screen to display
    return;
  }

  if (presentation.type == PLYPresentationType.client) {
    // Display my own Screen
    return;
  }

  //Display Purchasely Screen

  await Purchasely.presentPresentation(presentation,
      isFullscreen: false);

} catch (e) {
  print(e);
}
```
```javascript Cordova
Purchasely.fetchPresentationForPlacement(
		'onboarding', //placementId
		null, //contentId
		(presentation) => {
			Purchasely.presentPresentation(presentation, false, null,
				(callback) => {
				}, (error) => {
					console.log("Error with present : " + error);
				});
		},
		(error) => {
			console.log("Error with purchase : " + error);
		}
	);
```