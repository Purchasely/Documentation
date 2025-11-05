---
title: Managing Custom User Attributes
excerpt: >-
  This section describes how to leverage custom user attributes to create
  audiences and segment users
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Starting with the following versions of SDKs, you can set Custom User attributes to build your Audiences:

* iOS: 3.4.0
* Android: 3.4.0
* ReactNative: 2.4.0
* Cordova: 2.4.0
* Flutter: 1.4.0

<br />

<CustomUserAttributesDefinition />

# Configuring Custom User Attributes in the Console

## Creating a new Customer User Attribute

To create a new Custom User Attribute, you first need to declare it in the Purchasely Console

1. Navigate to the section [User Attributes of your Purchasely Console](https://console.purchasely.io/user-attributes)
2. Click on the button **`+ New user attribute`** in the upper right corner

   <Image align="center" className="border" border={true} src="https://files.readme.io/40bd72a-image.png" />
3. Fill in the following form:

   ![](https://files.readme.io/ad589ff-image.png)

   * `Name`: display name in the Purchasely Console
   * `Key`: name of the key that shall be used in the app code ([see below](custom-user-attributes#set-user-attributes))

     * `Data type`: choose among the following data types:

       <Table align={["left","left","left"]}>
         <thead>
           <tr>
             <th style={{ textAlign: "left" }}>
               Data type
             </th>

             <th style={{ textAlign: "left" }}>
               Description
             </th>

             <th style={{ textAlign: "left" }}>
               Available operators
             </th>
           </tr>
         </thead>

         <tbody>
           <tr>
             <td style={{ textAlign: "left" }}>
               `String`
             </td>

             <td style={{ textAlign: "left" }}>
               Used for a sequence of characters
             </td>

             <td style={{ textAlign: "left" }}>
               `equals to`\
               `is different from`\
               `contains`\
               `does not contain`\
               `starts with`\
               `ends with`\
               `is empty or not set`\
               `is not empty`
             </td>
           </tr>

           <tr>
             <td style={{ textAlign: "left" }}>
               `Array of Strings`
             </td>

             <td style={{ textAlign: "left" }}>
               Array containing multiple sequences of characters
             </td>

             <td style={{ textAlign: "left" }}>
               `contains`\
               `does not contain`\
               `is empty or not set`\
               `is not empty`
             </td>
           </tr>

           <tr>
             <td style={{ textAlign: "left" }}>
               `Float`
             </td>

             <td style={{ textAlign: "left" }}>
               Used for numbers with decimals
             </td>

             <td style={{ textAlign: "left" }}>
               `is greater than`\
               `is greater than or equal`\
               `is lower than`\
               `is lower than or equal`\
               `equals to`\
               `is different from`
             </td>
           </tr>

           <tr>
             <td style={{ textAlign: "left" }}>
               `Int`
             </td>

             <td style={{ textAlign: "left" }}>
               Used for round numbers
             </td>

             <td style={{ textAlign: "left" }}>
               `is greater than`\
               `is greater than or equal`\
               `is lower than`\
               `is lower than or equal`\
               `equals to`\
               `is different from`
             </td>
           </tr>

           <tr>
             <td style={{ textAlign: "left" }}>
               `Bool`
             </td>

             <td style={{ textAlign: "left" }}>
               Used for yes or no attributes
             </td>

             <td style={{ textAlign: "left" }}>
               `is true`\
               `is true or not set`\
               `is false`\
               `is false or not set`
             </td>
           </tr>

           <tr>
             <td style={{ textAlign: "left" }}>
               `Date`
             </td>

             <td style={{ textAlign: "left" }}>
               Used for dates following universal timezone format (UTC)
             </td>

             <td style={{ textAlign: "left" }}>
               `is after`\
               `is before`\
               `is less than '{days}' days ago`\
               `is more than '{days}' days ago`\
               `is less than '{days}' days from now  `\
               `is more than '{days}' days from now`\
               `is false or not set`
             </td>
           </tr>
         </tbody>
       </Table>

       <br />
4. Click on the **`Save`** button in the bottom right corner.

## Modifying an existing Custom User Attribute

To modify an existing Custom User Attribute:

1. click on the **`⋮`** button on the right of the attribute
2. then on `Edit`

   <Image align="center" className="border" border={true} src="https://files.readme.io/dd5bae7-image.png" />

<br />

## Deleting a Custom User Attribute

To delete an existing Custom User Attribute:

1. click on the **`⋮`** button on the right of the attribute
2. then on `Delete`

   <Image align="center" className="border" border={true} src="https://files.readme.io/1566d26-image.png" />

# Manipulating Customer User Attributes in the App code

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
```coffeescript Kotlin
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
```coffeescript Flutter
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
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely.GetUserAttribute("AttributeID")
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
```coffeescript Kotlin
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
```coffeescript Flutter
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
```csharp Unity
// Not available at the moment, you can do
private PurchaselyRuntime.Purchasely _purchasely;

var viewedArticles = _purchasely.GetUserAttribute("viewed_articles");
_purchasely.SetUserAttribute("viewed_articles", viewedArticles + 1);
```

## Clearing Custom User Attributes

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
```javascript Cordova
//Remove one attribute
Purchasely.clearUserAttribute("key_string");
	
//Remove all attributes
Purchasely.clearUserAttributes();
```
```csharp Unity
//Remove one attribute
_purchasely.ClearUserAttribute("StringAttribute");
	
//Remove all attributes
_purchasely.ClearUserAttributes();
```

> 👍 Clear after log out
>
> You should call `Purchasely.clearUserAttributes()` when a user is logged out, after calling `Purchasely.userLogout()`, so that he does not keep attributes you have set previously with his profile.
>
> Be aware though, this method remove all attributes so you must set device attributes again
