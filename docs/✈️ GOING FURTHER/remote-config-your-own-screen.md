---
title: Use Purchasely to remotely configure your own Screens
excerpt: This section describes how to remotely configure your own Screens.
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
> 🚧 Minimum SDK versions
>
> * iOS: 3.5.0
> * Android: 3.5.0
> * ReactNative: 2.5.0
> * Cordova: 2.5.0
> * Flutter: 1.5.0

# Overview

Using your custom paywall within a No-Code Screen environment may initially seem counterintuitive. However, it offers significant advantages:

* **A/A Testing:** Compare your own Screen directly against Purchasely's one.
* **Benchmarking:** Test your existing screen against Purchasely's No-Code Screens to find opportunities for improvement.
* **Price A/B Testing:** Easily deploy price [A/B testing](https://help.purchasely.io/en/articles/6990589-price-a-b-test) infrastructure without changing your UI.

# Implementation

The [basic Screen implementation](screens-display) directly returns a piece of UI but to be able to make both your own Screen alongside with Purchasely's Screen you will need to proceed differently.

First, you must declare your own Screen in our console along with the plans you wish to offer if you want to do price A/B tests

Then you will need to fetch the Screens and therefore you won't be able to directly display a Screen returned by Purchasely.

You will have to first fetch the Screen then check whether you should display your own Screen or display the provided one.

### Declare you own Screen

To declare your own Screen on Purchasely's console, first go the the section **"Paywall and Screen"** and click on **"New Screen"**.

<Image align="center" className="border" border={true} src="https://files.readme.io/21f7597-Capture_decran_2024-07-11_a_17.51.37.png" />

Then, in **"Template"** section select the template **"Your own Screen"** .

Don't forget to complete other mandatory information such as name and id in **"Information"** section, and the desired plans in the section **"Plans"**.

<Image align="center" className="border" border={true} src="https://files.readme.io/b55eb70-Capture_decran_2024-07-11_a_17.57.12.png" />

### Fetch and display your Screen

```swift Swift
Purchasely.fetchPresentation(for: "onboarding", fetchCompletion: { presentation, error in
            guard let presentation = presentation, error == nil else {
                print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
                return
            }
            
            if presentation.type == .normal || presentation.type == .fallback {
                let paywallController = presentation.controller
                
                // display Screen controller.
                
            } else if presentation.type == .deactivated {
                
                // nothing to display
                
            } else if presentation.type == .client {
                let presentationId = presentation.id
                let plans = presentation.plans
                let metadata = presentation.metadata // look section below
                
                // display your own Screen
                
            }
        })
```
```kotlin
Purchasely.fetchPresentationForPlacement(this, "onboarding") { presentation, error ->
    if(error != null) {
        Log.d("Purchasely", "Error fetching Screen", error)
        return@fetchPresentationForPlacement
    }

    when(presentation?.type) {
        PLYPresentationType.NORMAL,
        PLYPresentationType.FALLBACK -> {
            val paywallView = presentation.buildView(
                context = this@MainActivity,
                viewProperties = PLYPresentationViewProperties(
                    onClose = {
                        // TODO remove view
                    }
                )
            )
            // Display Purchasely Screen
        }
        PLYPresentationType.DEACTIVATED -> {
            // Nothing to display
        }
        PLYPresentationType.CLIENT -> {
            val paywallId = presentation.id
            val plans = presentation.plans
            val metadata = presentation.metadata // look section below
            
            // Display your own Screen
        }
        else -> {
            //No presentation, it means an error was triggered
        }
    }
}
```
```typescript ReactNative
try {
  // Fetch presentation to display
  const presentation = await Purchasely.fetchPresentation({
      placementId: 'onboarding'
  })

  if(presentation.type == PLYPresentationType.CLIENT) {
    // Display your own Screen
    return
  }

} catch (e) {
  console.error(e);
}
```
```typescript Flutter
try {
  var presentation = await Purchasely.fetchPresentation("ONBOARDING");

  if (presentation == null) {
    print("No presentation found");
    return;
  }

  if (presentation.type == PLYPresentationType.deactivated) {
    // No Screen to display
    return;
  }

  if (presentation.type == PLYPresentationType.client) {
    // Display your own Screen
    return;
  }

  //Display Purchasely Screen

  var presentResult = await Purchasely.presentPresentation(presentation, isFullscreen: false);

  switch (presentResult.result) {
    case PLYPurchaseResult.cancelled:
      {
        print("User cancelled purchased");
      }
      break;
    case PLYPurchaseResult.purchased:
      {
        print("User purchased ${presentResult.plan?.name}");
      }
      break;
    case PLYPurchaseResult.restored:
      {
        print("User restored ${presentResult.plan?.name}");
      }
      break;
  }
} catch (e) {
  print(e);
}
```
```javascript Cordova
//TODO
```
```csharp Unity
//TODO
```

### Keep the SDK updated

Then you should inform the Purchasely SDK when your Screen is displayed and closed.

These steps are mandatory for Purchasely to compute conversion on your Screen and measure the performance of A/B tests.

```swift Swift
// Call when your Screen is displayed
// in ViewDidAppear for example
Purchasely.clientPresentationOpened(with: presentation)
            
// Call when your Screen has been closed
// in viewWillDisappear for example
Purchasely.clientPresentationClosed(with: presentation)

// Call clientPresentationClosed in Purchasely.syncPurchase() closure 
// if you are in paywallObserverMode
```
```kotlin
// Call when your Screen is displayed
// For example in the onCreate() method of your Activity
Purchasely.clientPresentationDisplayed(presentation)

// Call when your Screen is closed
// For example in the onDestroy() method of your Activity
Purchasely.clientPresentationClosed(presentation)
```
```typescript ReactNative
// Call when your Screen is displayed
Purchasely.clientPresentationDisplayed(presentation);

// Call when your Screen is closed
Purchasely.clientPresentationClosed(presentation);
```
```typescript Flutter
// Call when your Screen is displayed
Purchasely.clientPresentationDisplayed(presentation);

// Call when your Screen is closed
Purchasely.clientPresentationClosed(presentation);
```
```javascript Cordova
//TODO
```
```csharp Unity
//TODO
```

### Trigger purchase process manually

You can also trigger the purchase process manually from your own Screen by calling the method **`Purchasely.purchase(plan)`**. more information [here](manual-purchase).

# Metadata

> 🚧 Minimum SDK version
>
> This feature is available starting with SDK version 4.1.0

Including metadata is essential for Purchasely to accurately compute conversions on your Screen and assess the performance of **A/B tests**. You can declare metadata for your own Screen, which supports the following types:

* String (capable of representing various types, as shown in the example code below).
* Boolean.
* Image.

## Declare your Metadata

To declare metadata for your screen, follow these steps:

* Open the previously declared screen on the Purchasely console.
* Navigate to the **"Metadata"** section.
* Add your metadata by specifying a key, a type, and a value.
* Click **"Publish"** to save and publish your changes.

<Image align="center" className="border" border={true} src="https://files.readme.io/b3fbac7-Capture_decran_2024-07-11_a_18.08.47.png" />

## Retrieve your Metadata

When your Screen is fetched, you can retrieve the associated metadata as follows:

```swift Swift
Purchasely.fetchPresentation(for: "onboarding", fetchCompletion: { presentation, error in
     guard let presentation = presentation, error == nil else {
        print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
        return
     }
            
		 if presentation.type == .client {
       let presentationId = presentation.id
       let plans = presentation.plans
       let metadata = presentation.metadata

       for (key, value) in metadata {
            print("Key: \(key), Value: \(value)")
        }
       // display your own Screen
                
      }
})
```
```kotlin
Purchasely.fetchPresentationForPlacement(this, "onboarding") { presentation, error ->
    if(error != null) {
        Log.d("Purchasely", "Error fetching paywall", error)
        return@fetchPresentationForPlacement
    }
    
    if(presentation?.type == PLYPresentationType.CLIENT) {
        val paywallId = presentation.id
        val plans = presentation.plans
        val metadata = presentation.metadata
        
        // Get string metadata, this method is asynchronous as it will parse tags
        val myString = metadata.getString("myString", callback = {
            Log.d("Demo", "myString: $it")
        })
        // You can also use coroutine
        scope.launch {
            val myString = metadata.getString("myString")
        }
        
        // If you do not use Purchasely tags
        val myString2 = metadata.getStringWithoutTags("myString2")
        
        val myBoolean = metadata.getBoolean("myBoolean")

        // Even if declared as a String in our console, 
        // Purchasely SDK will automatically try to convert to specific type 
        // For example: "4.7" is a double or float
        val myInt = metadata.getInt("myInt")
        val myLong = metadata.getLong("myLong")
        val myFloat = metadata.getFloat("myFloat")
        val myDouble = metadata.getDouble("myDouble")
        
        // If you set a metadata with a String ISO 8601, you can retrieve the date
        // "2023-09-21T09:48:25Z"
        val myDate = metadata.getDate("myDate")
        // or Instant
        val myDateAsInstant = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            metadata.getInstant("myDate")
        } else null
        
        // If you set a medata with a String which is a json, you can retrieve it
        // "{"name":"Stranger","int_value":4,"child":{"title":"Things"}}"
        val myJson = metadata.getJsonObject("myJson")
    }
}
```
```typescript ReactNative
try {
  // Fetch presentation to display
  const presentation = await Purchasely.fetchPresentation({
      placementId: 'onboarding'
  })

  if(presentation.type == PLYPresentationType.CLIENT) {
    console.log('metadata: ' + JSON.stringify(presentation.metadata, null, 2));
    // Display your own Screen
    return
  }

} catch (e) {
  console.error(e);
}
```
```typescript Flutter
var presentation = await Purchasely.fetchPresentation("ONBOARDING");

if (presentation == null) {
  print("No presentation found");
  return;
}

print("Presentation: ${presentation}");

if (presentation.type == PLYPresentationType.client) {
  print("Presentation metadata: ${presentation.metadata}");
  return;
}

} catch (e) {
  print(e);
}
}
```
```javascript Cordova
//TODO
```
```csharp Unity
//TODO
```
