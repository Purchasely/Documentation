---
title: User attributes
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
Starting with the following versions of SDKs, you can set user attributes to build your Audiences:

- iOS: 3.4.0
- Android: 3.4.0
- ReactNative: 2.4.0
- Cordova: 2.4.0
- Flutter: 1.4.0

## Sending user attributes

All values type must be the exact same than the ones you have set in Purchasely console, for exemple if you have setup an Age property with the key age and the type Int then in your code your have to set it with an integer value like `Purchasely.setUserAttribute("age", 21)`

```swift Swift
//Set one attribute by key and value
Purchasely.setUserAttribute(withIntValue: 20, forKey: "age")
Purchasely.setUserAttribute(withDoubleValue: 175.5, forKey: "size")
Purchasely.setUserAttribute(withBoolValue: true, forKey: "subscribed")
Purchasely.setUserAttribute(withDateValue: Date(), forKey: "date")
Purchasely.setUserAttribute(withStringValue: "Female", forKey: "gender")

//Set multiple attributes
 Purchasely.setUserAttributes(
   [
     "age": 20,
     "size": 175.5,
     "subscribed": true,
     "date": Date(),
     "gender": "Female"
   ]
 )        
```
```coffeescript Kotlin
//Set one attribute by key and value
Purchasely.setUserAttribute("age", 20)

//Set multiple attributes
Purchasely.setUserAttributes(mapOf(
    Pair("age", 21),
    Pair("gender", "man"),
    Pair("hair", "brown"),
))
```
```coffeescript Java
//Set one attribute by key and value
Purchasely.setUserAttribute("age", 20);

//Set multiple attributes
HashMap<String, Object> map = new HashMap<>();
map.put("age", 21);
map.put("gender", "man");
map.put("hair", "brown");
Purchasely.setUserAttributes(map);
```
```typescript React Native
//Set one attribute by key and value
Purchasely.setUserAttributeWithString("gender", "man");
Purchasely.setUserAttributeWithNumber("age", 21);
Purchasely.setUserAttributeWithNumber("weight", 78.2);
Purchasely.setUserAttributeWithBoolean("premium", true);
Purchasely.setUserAttributeWithDate("subscription_date", new Date());
```
```coffeescript Flutter
//Set one attribute by key and value
Purchasely.setUserAttributeWithString("stringKey", "StringValue");
Purchasely.setUserAttributeWithInt("intKey", 3);
Purchasely.setUserAttributeWithDouble("doubleKey", 1.2);
Purchasely.setUserAttributeWithBoolean("booleanKey", true);
Purchasely.setUserAttributeWithDate("dateKey", DateTime.now());
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

//Set one attribute by key and value
_purchasely.SetUserAttribute("StringAttribute", "String message");
_purchasely.SetUserAttribute("IntAttribute", -100);
_purchasely.SetUserAttribute("FloatAttribute", 147.5f);
_purchasely.SetUserAttribute("BoolAttribute", true);
_purchasely.SetUserAttribute("DateAttribute", DateTime.Now);
```
```javascript Cordova
//Set one attribute by key and value	
Purchasely.setUserAttributeWithString("key_string", "value_string");
Purchasely.setUserAttributeWithBoolean("key_boolean", true);
Purchasely.setUserAttributeWithInt("key_int", 7);
Purchasely.setUserAttributeWithDouble("key_double", 4.5);
```

## Retrieve user attributes

You can retrieve user attributes by fetching a specific attribute using its designated key, or gather all attributes at once

```swift Swift
//return an int since it was set with that type
if let age =  Purchasely.getUserAttribute(for: "age") as? Int {
    // Do Something
}

//return a dictionary of all attributes
Purchasely.userAttributes.forEach { attribute in
    print("Attribute \(attribute.key) = \(attribute.value)")
}
```
```coffeescript Kotlin
//return an int since it was set with that type
val age = Purchasely.userAttribute("age") 

//return a map of all attributes
val all = Purchasely.userAttributes()
all.forEach { attribute ->
    Log.d("Purchasely", "Attribute ${attribute.key} = ${attribute.value}")
}
```
```coffeescript Java
//return an int since it was set with that type
int age = (int) Purchasely.userAttribute("age");

//return a map of all attributes
Map<String, Object> all = Purchasely.userAttributes();
for (String key : all.keySet()) {
    Log.d("Purchasely", "Attribute" + key + " = " + all.get(key));
}
```
```Text React Native
//get all attributes
const attributes = await Purchasely.userAttributes();
console.log(attributes); //returns a PurchaselyUserAttribute object with key and value

//retrive a date attribute
const dateAttribute = await Purchasely.userAttribute("subscription_date"); //returns the value
//for a date you need to parse the iso 8601 string to retrieve the date object
console.log(new Date(dateAttribute).getFullYear());
```
```coffeescript Flutter
Purchasely.setUserAttributeWithInt("age", 21);

dynamic dateAttribute = await Purchasely.userAttribute("age");

Map<dynamic, dynamic> attributes = await Purchasely.userAttributes();
attributes.forEach((key, value) {
  print("Attribute $key is $value");
});
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely.GetUserAttribute("AttributeID")
```
```javascript Cordova

Purchasely.userAttribute("key_string", value => {
  console.log("User attribute string " + value);
});
```

## Clear user attributes

You can clear either a specific attribute, identified by its key, or all attributes at once.

```swift Swift
//Remove one attribute
Purchasely.clearUserAttribute(forKey: "size")

//Remove all attributes
Purchasely.clearUserAttributes()
```
```coffeescript Kotlin
//Remove one attribute
Purchasely.clearUserAttribute("size")

//Remove all attributes
Purchasely.clearUserAttributes()
```
```coffeescript Java
//Remove one attribute
Purchasely.clearUserAttribute("size");

//Remove all attributes
Purchasely.clearUserAttributes();
```
```typescript React Native
//Remove one attribute
Purchasely.clearUserAttribute("size")

//Remove all attributes
Purchasely.clearUserAttributes()
```
```coffeescript Flutter
//Remove one attribute
Purchasely.clearUserAttribute("dateKey");

//Remove all attributes
Purchasely.clearUserAttributes();
```
```csharp Unity
//Remove one attribute
_purchasely.ClearUserAttribute("StringAttribute");
	
//Remove all attributes
_purchasely.ClearUserAttributes();
```
```javascript Cordova
//Remove one attribute
Purchasely.clearUserAttribute("key_string");
	
//Remove all attributes
Purchasely.clearUserAttributes();
```

> 👍 Clear after log out
> 
> You should call `Purchasely.clearUserAttributes()` when a user is logged out, after calling `Purchasely.userLogout()`, so that he does not keep attributes you have set previously with his profile.
> 
> Be aware though, this method remove all attributes so you must set device attributes again