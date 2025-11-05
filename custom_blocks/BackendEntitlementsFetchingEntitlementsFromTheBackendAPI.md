---
name: Backend entitlements - Fetching entitlements from the backend API
---
Once the Entitlement Events have been acknowledged with a response code` HTTP 200`, the Purchasely Platform notifies the SDK, which returns the result to the app.

The app shall then fetch a backend API and provide the `user ID` as an entry parameter to determine which entitlements shall be granted to the user inside the app.

If the user is logged-out, the entry parameter should be the `anonymous user ID` provided by the SDK.

```swift Swift
Purchasely.anonymousUserId
```
```kotlin Kotlin
Purchasely.anonymousUserId
```
```javascript React Native
Purchasely.getAnonymousUserId();
```
```javascript Flutter
Purchasely.anonymousUserId;
```
```javascript Cordova
Purchasely.getAnonymousUserId((anonymousId) => {
	console.log("Purchasely anonymous Id: " + anonymousId);
});
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely.GetAnonymousUserId();
```

The backend shall respond with the entitlements associated with the `user ID` or `anonymous user ID`.