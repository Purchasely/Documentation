---
name: UI / SDK Events - Event delegated / event listener
---
UI / SDK Events are gathered by the Purchasely Platform but they cannot be routed from the Purchasely Console to the webhook or to 3rd party integrations.

If you wish to track these events in your own Analytics or in a 3rd party analytics tool, you need to set yourself an event delegate / event listener inside the app.

### Listening to events

```swift Swift
 Purchasely.setEventDelegate(self)
```
```kotlin Kotlin
Purchasely.eventListener = eventListener
```
```typescript React Native
// Nothing special to setup, just go to "Receiving events" below
```
```typescript Flutter
// Nothing special to setup, just go to "Receiving events" below
```
```javascript Cordova
// Nothing special to setup, just go to "Receiving events" below
```
```csharp Unity
//not available at the moment
```

This code must be inserted after starting the SDK.

### Receiving events

You will receive the events like this :

```swift Swift
	func eventTriggered(_ event: PLYEvent, properties: [String : Any]?) {
		switch event {
		case .linkOpened:
			print("Link opened")
		default:
			print("Ignored")
		}
	}
```
```kotlin Kotlin
private val eventListener = object : io.purchasely.ext.EventListener {
    override fun onEvent(event: PLYEvent) {
        when (event) {
            PLYEvent.LoginTapped -> Log.d("Purchasely", "Login tapped, we should open login page")
        }
    }
}
```
```typescript React Native
Purchasely.addEventListener((event) => {
    console.log('Event Name ' + event.name);
    console.log(event.properties);
    console.log(event);
});

//When you do not want to listen to events anymore
Purchasely.removeEventListener();
```
```typescript Flutter
Purchasely.listenToEvents((event) =>
  print(event.name)
);
```
```javascript Cordova
Purchasely.addEventsListener((event) => {
       console.log("Event Name " + event.name);
       console.log(event.properties);
       console.log(event);
});
```
```csharp Unity
//not available at the moment
```

Once received, these events can be directly forwarded to your internal Analytics or 3rd-party Analytics SDK inside your app.