---
name: SDK - Display method code snipped
---
```swift Swift
PLYPresentationBuilder.forPlacementId("onboarding").build().preload { presentation, error in
      guard error == nil,
            let presentation = presentation else { return }

     // Calling display() to launch the flow
		 // Source UIViewController is optional 
     presentation.display(from: myUIViewController) 
}

// If for some specific configuration you need to check if the presentation is a flow, that's possible but it should only be done if required by your implementation
if presentation.isFlow {
  // presentation is a flow
  presentation.display()
}

```
```kotlin Kotlin
PLYPresentation {
  placementId("onboarding")
}.preload { presentation, error ->
  if(error != null) {
    Log.d("Purchasely", "Error fetching Screen", error)
    return@preload
  }
  
  // Calling display() to launch the flow 
  presentation?.display(context)
}

// If for some specific configuration you need to check if the presentation is a flow, that's possible but it should only be done is required by your implementation
if (presentation.flowId != null) {
	// presentation is a flow
}
```
```javascript React Native
try {
  const request = Purchasely.presentation.placement('onboarding').build();

  // Preload resolves once the Screen is loaded
  const presentation = await request.preload();

  if (presentation.type === PLYPresentationType.DEACTIVATED) {
    // No Screen to display
    return;
  }

  if (presentation.type === PLYPresentationType.CLIENT) {
    // Display my own Screen
    return;
  }

  // Display Purchasely Screen; resolves at dismiss
  await request.display();

} catch (e) {
  console.error(e);
}
```
```dart Flutter
try {
  final request = PresentationBuilder.placement("onboarding").build();

  // Preload resolves once the Screen is loaded
  final presentation = await request.preload();

  if (presentation.type == PresentationType.deactivated) {
    // No Screen to display
    return;
  }

  if (presentation.type == PresentationType.client) {
    // Display my own Screen
    return;
  }

  // Display Purchasely Screen; resolves at dismiss
  await request.display(const Transition.modal());

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
