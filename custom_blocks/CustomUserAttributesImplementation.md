---
name: CustomUserAttributesImplementation
---
Implementing Custom User Attributes into your app lets you:

1. enrich the user data with additional properties computed in the app
2. leverage this data to segment your user base by creating Audiences
3. target segments with specific In-App Experiences

# Manipulating Customer User Attributes in the App code

## Configuring Custom User Attributes in the Console

Prior to setting Custom User Attributes inside of your app, you must configure them in the Purchasely Console

📚 [Follow the guide](custom-user-attributes)

## Setting Custom User Attributes

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
```kotlin Kotlin
//Set one attribute by key and value
Purchasely.setUserAttribute("age", 20)

//Set multiple attributes
Purchasely.setUserAttributes(mapOf(
    Pair("age", 21),
    Pair("gender", "man"),
    Pair("hair", "brown"),
))
```
```typescript React Native
//Set one attribute by key and value
Purchasely.setUserAttributeWithString("gender", "man");
Purchasely.setUserAttributeWithNumber("age", 21);
Purchasely.setUserAttributeWithNumber("weight", 78.2);
Purchasely.setUserAttributeWithBoolean("premium", true);
Purchasely.setUserAttributeWithDate("subscription_date", new Date());
```
```dart Flutter
//Set one attribute by key and value
Purchasely.setUserAttributeWithString("stringKey", "StringValue");
Purchasely.setUserAttributeWithInt("intKey", 3);
Purchasely.setUserAttributeWithDouble("doubleKey", 1.2);
Purchasely.setUserAttributeWithBoolean("booleanKey", true);
Purchasely.setUserAttributeWithDate("dateKey", DateTime.now());
```
```javascript Cordova
//Set one attribute by key and value	
Purchasely.setUserAttributeWithString("key_string", "value_string");
Purchasely.setUserAttributeWithBoolean("key_boolean", true);
Purchasely.setUserAttributeWithInt("key_int", 7);
Purchasely.setUserAttributeWithDouble("key_double", 4.5);
```

## Retrieving Custom User Attributes

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
```kotlin Kotlin
//return an int since it was set with that type
val age = Purchasely.userAttribute("age") 

//return a map of all attributes
val all = Purchasely.userAttributes()
all.forEach { attribute ->
    Log.d("Purchasely", "Attribute ${attribute.key} = ${attribute.value}")
}
```
```javascript React Native
//get all attributes
const attributes = await Purchasely.userAttributes();
console.log(attributes); //returns a PurchaselyUserAttribute object with key and value

//retrive a date attribute
const dateAttribute = await Purchasely.userAttribute("subscription_date"); //returns the value
//for a date you need to parse the iso 8601 string to retrieve the date object
console.log(new Date(dateAttribute).getFullYear());
```
```dart Flutter
Purchasely.setUserAttributeWithInt("age", 21);

dynamic dateAttribute = await Purchasely.userAttribute("age");

Map<dynamic, dynamic> attributes = await Purchasely.userAttributes();
attributes.forEach((key, value) {
  print("Attribute $key is $value");
});
```
```javascript Cordova

Purchasely.userAttribute("key_string", value => {
  console.log("User attribute string " + value);
});
```
## Incrementing / decrementing counters

It is possible to count the number of times a particular action is performed by the User by using an Integer (Int) as a Custom User Attribute. To automatically increase / decrease the counters, the method `incrementUserAttribute()` and `decrementUserAttribute()` can be used.

These methods are only available for the version of the SDK >= 4.3.

```swift Swift
// Increment a user attribute
// increment by 1 a specific attribute, it will be created if not set
Purchasely.incrementUserAttribute(withKey: "viewed_articles")
// you can also set a specfic number to increment
Purchasely.incrementUserAttribute(withKey: "viewed_articles", value:3)

// Decrement a user attribute
// decrement by 1, it will be created if not set
Purchasely.decrementUserAttribute(withKey: "viewed_articles")
// you can also set a specific number to decrement
Purchasely.decrementUserAttribute(withKey: "viewed_articles", value:7)
```
```kotlin Kotlin
// Increment a user attribute
// increment by 1 a specific attribute, it will be created if not set
Purchasely.incrementUserAttribute("viewed_articles")
// you can also set a specfic number to increment
Purchasely.incrementUserAttribute("viewed_articles", 3)

// Decrement a user attribute
// decrement by 1, it will be created if not set
Purchasely.decrementUserAttribute("viewed_articles")
// you can also set a specific number to decrement
Purchasely.decrementUserAttribute("viewed_articles", 7)
```
```typescript React Native
// Increment a user attribute
// increment by 1 a specific attribute, it will be created if not set
Purchasely.incrementUserAttribute({key: 'viewed_articles'});
// you can also set a specfic number to increment
Purchasely.incrementUserAttribute({key: 'viewed_articles', value: 3});

// Decrement a user attribute
// decrement by 1, it will be created if not set
Purchasely.decrementUserAttribute({key: 'viewed_articles'});
// you can also set a specific number to decrement
Purchasely.decrementUserAttribute({key: 'viewed_articles', value: 7});
```
```dart Flutter
// Increment a user attribute
// increment by 1 a specific attribute, it will be created if not set
Purchasely.incrementUserAttribute("viewed_articles");
// you can also set a specfic number to increment
Purchasely.incrementUserAttribute("viewed_articles", value:3);

// Decrement a user attribute
// decrement by 1, it will be created if not set
Purchasely.decrementUserAttribute("viewed_articles");
// you can also set a specific number to decrement
Purchasely.decrementUserAttribute("viewed_articles", value:7);
```
```javascript Cordova
// Not available at the moment, you can do
Purchasely.userAttribute("viewed_articles", value => {
  Purchasely.setUserAttributeWithInt("viewed_articles", value + 1);
});
```
## Clearing Custom User Attributes

You can clear either a specific attribute, identified by its key, or all attributes at once.

```swift Swift
//Remove one attribute
Purchasely.clearUserAttribute(forKey: "size")

//Remove all attributes
Purchasely.clearUserAttributes()
```
```kotlin Kotlin
//Remove one attribute
Purchasely.clearUserAttribute("size")

//Remove all attributes
Purchasely.clearUserAttributes()
```
```typescript React Native
//Remove one attribute
Purchasely.clearUserAttribute("size")

//Remove all attributes
Purchasely.clearUserAttributes()
```
```dart Flutter
//Remove one attribute
Purchasely.clearUserAttribute("dateKey");

//Remove all attributes
Purchasely.clearUserAttributes();
```
```javascript Cordova
//Remove one attribute
Purchasely.clearUserAttribute("key_string");
	
//Remove all attributes
Purchasely.clearUserAttributes();
```
> 👍 Clear after log out
>
> Purchasely SDK will automatically clear all your user attributes when you call `Purchasely.userLogout()` unless you call `Purchasely.userLogout(false)`
>
> Make sure to pass that argument if you do not wish to clear all your custom user attributes when your user logs out of his account and return to the status of anonymous user.

## About privacy settings

Custom User Attributes can been defined as `essential` or `optional`.

By default they are considered as optional.

### `essential` Custom User Attributes

`essential` Custom User Attributes cannot be disabled as they are mandatory to deliver the service

* They remain stored in the local storage even when users have revoked Data Processing #3 - All the operations enabling the customization of the User journey and of the commercial offers presented
* Targeting based on `essential` user attributes keep on working for users who have revoked Data Processing #3.

> 📘 Example of `essential` Custom User Attribute
>
> If you set the Custom User Attribute `isWebSubscriber` (boolean) defined as `essential` to deliver the service, you will still be able to target web subscribers even if those who have revoke Data Processing #3.

```swift Swift
//Set one attribute by key and value
Purchasely.setUserAttribute(withIntValue: 20, forKey: "age", processingLegalBasis: .essential)
Purchasely.setUserAttribute(withDoubleValue: 175.5, forKey: "size", processingLegalBasis: .essential)
Purchasely.setUserAttribute(withBoolValue: true, forKey: "subscribed", processingLegalBasis: .essential)
Purchasely.setUserAttribute(withDateValue: Date(), forKey: "date", processingLegalBasis: .essential)
Purchasely.setUserAttribute(withStringValue: "Female", forKey: "gender", processingLegalBasis: .essential)

// Increment a user attribute
// increment by 1 a specific attribute, it will be created if not set
Purchasely.incrementUserAttribute(withKey: "viewed_articles", processingLegalBasis: .essential)
// you can also set a specfic number to increment
Purchasely.incrementUserAttribute(withKey: "viewed_articles", value:3, processingLegalBasis: .essential)

// Decrement a user attribute
// decrement by 1, it will be created if not set
Purchasely.decrementUserAttribute(withKey: "viewed_articles", processingLegalBasis: .essential)
// you can also set a specific number to decrement
Purchasely.decrementUserAttribute(withKey: "viewed_articles", value:7, processingLegalBasis: .essential)
```
```kotlin Kotlin
//Set one attribute by key and value
Purchasely.setUserAttribute("age", 20, PLYDataProcessingLegalBasis.ESSENTIAL)
Purchasely.setUserAttribute("size", 175.5f, PLYDataProcessingLegalBasis.ESSENTIAL)
Purchasely.setUserAttribute("subscribed", true, PLYDataProcessingLegalBasis.ESSENTIAL)
Purchasely.setUserAttribute("date", Date(), PLYDataProcessingLegalBasis.ESSENTIAL)
Purchasely.setUserAttribute("gender", "Female", PLYDataProcessingLegalBasis.ESSENTIAL)

// Increment a user attribute
// increment by 1 a specific attribute, it will be created if not set
Purchasely.incrementUserAttribute("viewed_articles", processingLegalBasis = PLYDataProcessingLegalBasis.ESSENTIAL)
// you can also set a specfic number to increment
Purchasely.incrementUserAttribute("viewed_articles", 3, PLYDataProcessingLegalBasis.ESSENTIAL)

// Decrement a user attribute
// decrement by 1, it will be created if not set
Purchasely.decrementUserAttribute("viewed_articles", processingLegalBasis = PLYDataProcessingLegalBasis.ESSENTIAL)
// you can also set a specific number to decrement
Purchasely.decrementUserAttribute("viewed_articles", 7, PLYDataProcessingLegalBasis.ESSENTIAL)
```
```typescript React Native
//Set one attribute by key and value
Purchasely.setUserAttributeWithString("gender", "man", PLYDataProcessingLegalBasis.ESSENTIAL);
Purchasely.setUserAttributeWithNumber("age", 21, PLYDataProcessingLegalBasis.ESSENTIAL);
Purchasely.setUserAttributeWithNumber("weight", 78.2, PLYDataProcessingLegalBasis.ESSENTIAL);
Purchasely.setUserAttributeWithBoolean("premium", true, PLYDataProcessingLegalBasis.ESSENTIAL);
Purchasely.setUserAttributeWithDate("subscription_date", new Date(), PLYDataProcessingLegalBasis.ESSENTIAL);

// Increment a user attribute
// increment by 1 a specific attribute, it will be created if not set
Purchasely.incrementUserAttribute({key: 'viewed_articles', legalBasis: PLYDataProcessingLegalBasis.ESSENTIAL});
// you can also set a specfic number to increment
Purchasely.incrementUserAttribute({key: 'viewed_articles', value: 3, legalBasis: PLYDataProcessingLegalBasis.ESSENTIAL});

// Decrement a user attribute
// decrement by 1, it will be created if not set
Purchasely.decrementUserAttribute({key: 'viewed_articles', legalBasis: PLYDataProcessingLegalBasis.ESSENTIAL});
// you can also set a specific number to decrement
Purchasely.decrementUserAttribute({key: 'viewed_articles', value: 7, legalBasis: PLYDataProcessingLegalBasis.ESSENTIAL});
```
```dart Flutter
Purchasely.setUserAttributeWithString("stringKey", "StringValue", processingLegalBasis: PLYDataProcessingLegalBasis.essential);
Purchasely.setUserAttributeWithInt("intKey", 3, processingLegalBasis: PLYDataProcessingLegalBasis.essential);
Purchasely.setUserAttributeWithDouble("doubleKey", 1.2, processingLegalBasis: PLYDataProcessingLegalBasis.essential);
Purchasely.setUserAttributeWithBoolean("booleanKey", true, processingLegalBasis: PLYDataProcessingLegalBasis.essential);
Purchasely.setUserAttributeWithDate("dateKey", DateTime.now(), processingLegalBasis: PLYDataProcessingLegalBasis.essential);

// Increment a user attribute
// increment by 1 a specific attribute, it will be created if not set
Purchasely.incrementUserAttribute("viewed_articles", processingLegalBasis: PLYDataProcessingLegalBasis.essential);
// you can also set a specfic number to increment
Purchasely.incrementUserAttribute("viewed_articles", value:3, processingLegalBasis: PLYDataProcessingLegalBasis.essential);

// Decrement a user attribute
// decrement by 1, it will be created if not set
Purchasely.decrementUserAttribute("viewed_articles", processingLegalBasis: PLYDataProcessingLegalBasis.essential);
// you can also set a specific number to decrement
Purchasely.decrementUserAttribute("viewed_articles", value:7, processingLegalBasis: PLYDataProcessingLegalBasis.essential);
```
```javascript Cordova
//Set one attribute by key and value
Purchasely.setUserAttributeWithString("key_string", "value_string", Purchasely.DataProcessingLegalBasis.essential);
Purchasely.setUserAttributeWithBoolean("key_boolean", true, Purchasely.DataProcessingLegalBasis.essential);
Purchasely.setUserAttributeWithInt("key_int", 7, Purchasely.DataProcessingLegalBasis.essential);
Purchasely.setUserAttributeWithDouble("key_double", 4.5, Purchasely.DataProcessingLegalBasis.essential);
```

### `optional` Custom User Attributes

`optional` user attributes can be disabled.

* Targeting based on `optional` user attributes stop working for users who have revoked Data Processing #3.
* `optional` Custom User Attributes set prior to revoking Data Processing #3 will be wiped-off
* setting a value to `optional` Custom User Attribute is not possible and no associated tracker is saved in the local storage.

> 📘 Example of `optional` Custom User Attribute
>
> If you set the Custom User Attribute `preferedTopics` (Array of Strings) defined as `optional` to deliver the service, you will not be able to target users who have revoked Data Processing #3 based on their `preferedTopics`.

```swift Swift
//Set one attribute by key and value
Purchasely.setUserAttribute(withIntValue: 20, forKey: "age", processingLegalBasis: .optional)
Purchasely.setUserAttribute(withDoubleValue: 175.5, forKey: "size", processingLegalBasis: .optional)
Purchasely.setUserAttribute(withBoolValue: true, forKey: "subscribed", processingLegalBasis: .optional)
Purchasely.setUserAttribute(withDateValue: Date(), forKey: "date", processingLegalBasis: .optional)
Purchasely.setUserAttribute(withStringValue: "Female", forKey: "gender", processingLegalBasis: .optional)

// Increment a user attribute
// increment by 1 a specific attribute, it will be created if not set
Purchasely.incrementUserAttribute(withKey: "viewed_articles", processingLegalBasis: .optional)
// you can also set a specfic number to increment
Purchasely.incrementUserAttribute(withKey: "viewed_articles", value:3, processingLegalBasis: .optional)

// Decrement a user attribute
// decrement by 1, it will be created if not set
Purchasely.decrementUserAttribute(withKey: "viewed_articles", processingLegalBasis: .optional)
// you can also set a specific number to decrement
Purchasely.decrementUserAttribute(withKey: "viewed_articles", value:7, processingLegalBasis: .optional)
```
```kotlin Kotlin
//Set one attribute by key and value
Purchasely.setUserAttribute("age", 20, PLYDataProcessingLegalBasis.OPTIONAL)
Purchasely.setUserAttribute("size", 175.5f, PLYDataProcessingLegalBasis.OPTIONAL)
Purchasely.setUserAttribute("subscribed", true, PLYDataProcessingLegalBasis.OPTIONAL)
Purchasely.setUserAttribute("date", Date(), PLYDataProcessingLegalBasis.OPTIONAL)
Purchasely.setUserAttribute("gender", "Female", PLYDataProcessingLegalBasis.OPTIONAL)

// Increment a user attribute
// increment by 1 a specific attribute, it will be created if not set
Purchasely.incrementUserAttribute("viewed_articles", processingLegalBasis = PLYDataProcessingLegalBasis.OPTIONAL)
// you can also set a specfic number to increment
Purchasely.incrementUserAttribute("viewed_articles", 3, PLYDataProcessingLegalBasis.OPTIONAL)

// Decrement a user attribute
// decrement by 1, it will be created if not set
Purchasely.decrementUserAttribute("viewed_articles", processingLegalBasis = PLYDataProcessingLegalBasis.OPTIONAL)
// you can also set a specific number to decrement
Purchasely.decrementUserAttribute("viewed_articles", 7, PLYDataProcessingLegalBasis.OPTIONAL)
```
```typescript React Native
//Set one attribute by key and value
Purchasely.setUserAttributeWithString("gender", "man", PLYDataProcessingLegalBasis.OPTIONAL);
Purchasely.setUserAttributeWithNumber("age", 21, PLYDataProcessingLegalBasis.OPTIONAL);
Purchasely.setUserAttributeWithNumber("weight", 78.2, PLYDataProcessingLegalBasis.OPTIONAL);
Purchasely.setUserAttributeWithBoolean("premium", true, PLYDataProcessingLegalBasis.OPTIONAL);
Purchasely.setUserAttributeWithDate("subscription_date", new Date(), PLYDataProcessingLegalBasis.OPTIONAL);

// Increment a user attribute
// increment by 1 a specific attribute, it will be created if not set
Purchasely.incrementUserAttribute({key: 'viewed_articles', legalBasis: PLYDataProcessingLegalBasis.OPTIONAL});
// you can also set a specfic number to increment
Purchasely.incrementUserAttribute({key: 'viewed_articles', value: 3, legalBasis: PLYDataProcessingLegalBasis.OPTIONAL});

// Decrement a user attribute
// decrement by 1, it will be created if not set
Purchasely.decrementUserAttribute({key: 'viewed_articles', legalBasis: PLYDataProcessingLegalBasis.OPTIONAL});
// you can also set a specific number to decrement
Purchasely.decrementUserAttribute({key: 'viewed_articles', value: 7, legalBasis: PLYDataProcessingLegalBasis.OPTIONAL});
```
```dart Flutter
Purchasely.setUserAttributeWithString("stringKey", "StringValue", processingLegalBasis: PLYDataProcessingLegalBasis.optional);
Purchasely.setUserAttributeWithInt("intKey", 3, processingLegalBasis: PLYDataProcessingLegalBasis.optional);
Purchasely.setUserAttributeWithDouble("doubleKey", 1.2, processingLegalBasis: PLYDataProcessingLegalBasis.optional);
Purchasely.setUserAttributeWithBoolean("booleanKey", true, processingLegalBasis: PLYDataProcessingLegalBasis.optional);
Purchasely.setUserAttributeWithDate("dateKey", DateTime.now(), processingLegalBasis: PLYDataProcessingLegalBasis.optional);

// Increment a user attribute
// increment by 1 a specific attribute, it will be created if not set
Purchasely.incrementUserAttribute("viewed_articles", processingLegalBasis: PLYDataProcessingLegalBasis.optional);
// you can also set a specfic number to increment
Purchasely.incrementUserAttribute("viewed_articles", value:3, processingLegalBasis: PLYDataProcessingLegalBasis.optional);

// Decrement a user attribute
// decrement by 1, it will be created if not set
Purchasely.decrementUserAttribute("viewed_articles", processingLegalBasis: PLYDataProcessingLegalBasis.optional);
// you can also set a specific number to decrement
Purchasely.decrementUserAttribute("viewed_articles", value:7, processingLegalBasis: PLYDataProcessingLegalBasis.optional);
```
```javascript Cordova
//Set one attribute by key and value
Purchasely.setUserAttributeWithString("key_string", "value_string", Purchasely.DataProcessingLegalBasis.optional);
Purchasely.setUserAttributeWithBoolean("key_boolean", true, Purchasely.DataProcessingLegalBasis.optional);
Purchasely.setUserAttributeWithInt("key_int", 7, Purchasely.DataProcessingLegalBasis.optional);
Purchasely.setUserAttributeWithDouble("key_double", 4.5, Purchasely.DataProcessingLegalBasis.optional);
```

> ❗️ Custom User Attributes set prior to the upgrading the SDK to version 5.4 onwards
>
> All Custom User Attributes set prior to upgrading the SDK to version 5.4 are considered **by default as`optional` and will therefore be wiped off if the user revokes Processing #3**.
>
> If some of them should be considered as `essential`, do not forget to redefine their privacy setting to essential prior to revoking the Data Processing #3 for the user.

📚 [For more information on managing privacy, see the documentation](privacy-settings).
