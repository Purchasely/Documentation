---
name: Event listener for Custom User Attributes Implementation
---
```swift Swift
class UserAttributeHandler: PLYUserAttributeDelegate {
  func onUserAttributeSet(key: String, type: PLYUserAttributeType, value: Any?, source: PLYUserAttributeSource) {
    print("onUserAttributeSet: \(key) \(type) \(String(describing: value)) \(source)")
  }
  
  func onUserAttributeRemoved(key: String, source: PLYUserAttributeSource) {
    print("onUserAttributeRemoved: \(key) \(source)")
  }
}

Purchasely.setUserAttributeDelegate(UserAttributeHandler())

```
```kotlin
Purchasely.userAttributeListener = object : UserAttributeListener {
  override fun onUserAttributeSet(key: String, type: PLYUserAttributeType, value: Any, source: PLYUserAttributeSource) {
    Log.d(TAG, "User attribute added: $key, $type, $value from $source")
  }

  override fun onUserAttributeRemoved(key: String, source: PLYUserAttributeSource) {
    Log.d(TAG, "User attribute removed: $key")
  }
}
```
```typescript ReactNative
Purchasely.addUserAttributeSetListener((attribute: PurchaselyUserAttribute) => {
  console.log('Attribute set:', attribute);
});

Purchasely.addUserAttributeRemovedListener(attribute => {
  console.log('Attribute removed:', attribute);
});

// -- Definition of a Purchasely User Attribute -- //
export type PurchaselyUserAttribute = {
  key: string;
  value?: any | null;
  type?: PLYUserAttributeType | null;
  source?: PLYUserAttributeSource | null;
};
```
```typescript Flutter
class MyUserAttributeListener implements UserAttributeListener {
  @override
  void onUserAttributeSet(String key, PLYUserAttributeType type, dynamic value, PLYUserAttributeSource source){
    print("Attribute set: $key, Type: $type, Value: $value, Source: $source");
  }

  @override
  void onUserAttributeRemoved(String key, PLYUserAttributeSource source) {
    print("Attribute removed: $key, Source: $source");
  }
}

Purchasely.setUserAttributeListener(MyUserAttributeListener());
```
