---
title: Using Your Own Paywall
excerpt: How to use your own paywall within Purchasely environment.
deprecated: false
hidden: false
metadata:
  title: ''
  description: >-
    This document provides information on how to set up and implement your own
    custom paywall in a No Code environment using Purchasely, allowing for A/A
    testing and price A/B testing infrastructure deployment without changing
    your UI.
  robots: index
next:
  description: >-
    Want to know more on how to leverage this feature to personalize remotely
    your own paywall?
  pages:
    - type: basic
      slug: remote-config-your-own-screen
      title: Remotely configure your own screens
---
> 🚧 The feature described in this section is supported on the following versions and above:
>
> * iOS: **3.5.0**
> * Android: **3.5.0**
> * ReactNative: **2.5.0**
> * Cordova: **2.5.0**
> * Flutter: **1.5.0**

It might seem odd to use your custom paywall in a No Code environment, but it can actually be very useful for:

* Perform A/A testing of your paywall against the same one implemented using Purchasely's template
* Test your existing paywall against one of our No Code paywalls and run tests to outperform your baseline
* Easily deploy price A/B testing infrastructure without changing your UI

# Setup in the console

In the [Paywalls and screens](configuring-screens) section of the console use the *new screen* button.

<Image align="center" className="border" border={true} src="https://files.readme.io/1907d30-Capture_decran_2024-07-01_a_09.53.53.png" />

In the **Template** section, select the *Your own paywall* template

<Image align="center" className="border" border={true} src="https://files.readme.io/ab51ea7-Capture_decran_2024-07-01_a_07.19.47.png" />

## Declare your plans

If you wish to retrieve the plans to offer in your own paywall or do an A/B test of your own paywalls with different plans, you can declare the plans of your paywall in Purchasely console and create a price A/B test of your paywall.\
Purchasely will automatically return the plans that you should display according to the a/b test variant of your user.

<Image align="center" className="border" border={true} src="https://files.readme.io/c2cfc02-SCR-20240702-netp.png" />

# Implementation

The basic paywall implementation directly returns a View which cannot work for your own screen.\
To be able to retrieve the information to display your own screen, you must use `Purchasely.fetchPresentation()` method.

First, you must declare your own paywall in our console along with the plans you wish to offer on your paywall if you want to do price A/B tests

Then you will need to fetch the paywalls and therefore you won't be able to directly display a screen returned by Purchasely.

You will have to first fetch the paywall then check whether you should display your own paywall or display the provided paywall.

```swift Swift
Purchasely.fetchPresentation(for: "onboarding", fetchCompletion: { presentation, error in
            guard let presentation = presentation, error == nil else {
                print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
                return
            }
            
            if presentation.type == .normal || presentation.type == .fallback {
                let paywallController = presentation.controller
                
                // display paywall controller.
                
            } else if presentation.type == .deactivated {
                
                // nothing to display
                
            } else if presentation.type == .client {
                let presentationId = presentation.id
                let plans = presentation.plans
                let metadata = presentation.metadata
                
                // display your own paywall
                
            }
        })
```
```kotlin Kotlin
Purchasely.fetchPresentationForPlacement(this, "onboarding") { presentation, error ->
    if(error != null) {
        Log.d("Purchasely", "Error fetching paywall", error)
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
            // Display Purchasely paywall
        }
        PLYPresentationType.DEACTIVATED -> {
            // Nothing to display
        }
        PLYPresentationType.CLIENT -> {
            val paywallId = presentation.id
            val plans = presentation.plans
            val metadata = presentation.metadata // look section below
            
            // Display your own paywall
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
    // Display my own paywall
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
    // No paywall to display
    return;
  }

  if (presentation.type == PLYPresentationType.client) {
    // Display my own paywall
    return;
  }

  //Display Purchasely paywall

  var presentResult = await Purchasely.presentPresentation(presentation,
      isFullscreen: false);

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
```typescript Cordova
// coming soon
```
```csharp Unity
// coming soon
```

Then call `clientPresentationDisplayed(presentation)` when your paywall is displayed and `clientPresentationClosed(presentation)` when your paywall is closed.

These steps are mandatory for Purchasely to compute conversion on your paywall and measure the performance of A/B tests.

```swift Swift
// Call when your paywall is displayed
// in ViewDidAppear for example
Purchasely.clientPresentationOpened(with: presentation)
            
// Call when your paywall has been closed
// in viewWillDisappear for example
Purchasely.clientPresentationClosed(with: presentation)

// Call clientPresentationClosed in Purchasely.syncPurchase() closure 
// if you are in paywallObserverMode

```
```kotlin Kotlin
// Call when your paywall is displayed
// For example in the onCreate() method of your Activity
Purchasely.clientPresentationDisplayed(presentation)

// Call when your paywall is closed
// For example in the onDestroy() method of your Activity
Purchasely.clientPresentationClosed(presentation)
```
```typescript ReactNative
// Call when your paywall is displayed
Purchasely.clientPresentationDisplayed(presentation);

// Call when your paywall is closed
Purchasely.clientPresentationClosed(presentation);

```
```typescript Flutter
// Call when your paywall is displayed
Purchasely.clientPresentationDisplayed(presentation);

// Call when your paywall is closed
Purchasely.clientPresentationClosed(presentation);
```
```typescript Cordova
// coming soon
```
```csharp Unity
// coming soon
```

> 📘 Purchase with Purchasely SDK
>
> You can, of course, initiate the purchase from your own paywall using Purchasely by using `Purchasely.purchase(plan)`, more information [here](processing-transactions)

# Improving the visibility by adding a screenshot

To enhance the visibility of your paywall, you can add a screenshot of your own paywall. This will make it easier and more readable while using our console.

You can do this by uploading a screenshot in the information section.

<Image align="center" className="border" border={true} src="https://files.readme.io/afd94b0-Capture_decran_2024-07-01_a_07.17.44.png" />

Example:

<Image align="center" className="border" border={true} src="https://files.readme.io/0f1dfbd-Capture_decran_2024-07-01_a_08.55.16.png" />

# Use Metadata

You can declare your metadata with Your Own Paywall which can be:

* **String** (but you can set different types with it, look at example code below)

![](https://files.readme.io/d1c74c27a82b98c2fcb96d45a1d4d455d133658c5fa59b09e718cbe66f05cfe4-image.png)

<br />

* **Image**

![](https://files.readme.io/8bf95edbdf27c0e7f3eb457c092709c151e36c50e0a7f6bef23030d157609356-image.png)

<br />

* **Boolean**

![](https://files.readme.io/cd5649ab4a297fda36b301a86d7aeb47d3b425e9c50da08f5463d319bdd12961-image.png)

<br />

To retrieve and use those metadata in your application, you must retrieve the presentation from with the [pre-fetch](pre-fetching) method [Purchasely.fetchPresentation()]()

```swift Swift
// fetch presentation for placement
Purchasely.fetchPresentation(
    for: "onboarding",
    fetchCompletion: { presentation, error in
         // closure to get presentation and display it
         guard let presentation = presentation, error == nil else {
             print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
             return
         }

         if presentation.type == .client {
            let presentationId = presentation.id
            let planIds = presentation.plans
            let metadata = presentation.metadata

            guard let metadata = presentation?.metadata else { return }
             
            // Get string metadata, this method is asynchronous as it will parse tags
             let myString: () = metadata.getString(with: "myString") { value in
                 print("myString: \(value ?? "")")
            }

            // If you do not use Purchasely tags
             //let myString2 = metadata.getStringWithoutTag(with: "myString2")

             let myBoolean = metadata.getBool(with: "myBoolean")

            // Even if declared as a String in our console,
            // Purchasely SDK will automatically try to convert to specific type
            // For example: "4.7" is a double or float
             let myInt = metadata.getInt(with: "myInt")
             let myFloat = metadata.getFloat(with: "myFloat")
             let myDouble = metadata.getDouble(with: "myDouble")

            // If you set a medata with a String which is a json, you can retrieve it
            // "{"name":"Stranger","int_value":4,"child":{"title":"Things"}}"
             do {
                 let myJson = try metadata.getJsonObject(with: "myJson")
            } catch {
               SampleLogger.shared.addLog(message: "Failed to parse myJson from metadata: \(error.localizedDescription)")
            }


            // display your own Screen
             
         }
    }
)
```
```kotlin Kotlin
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
