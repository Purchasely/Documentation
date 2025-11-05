---
title: Using Placements to display Screens & Paywalls
excerpt: >-
  This section describes how to use and implement Placements inside your
  application
deprecated: false
hidden: false
metadata:
  title: ''
  description: >-
    Placements are a core feature of the Purchasely platform, allowing for easy
    implementation of screens, audiences, and A/B tests. They can be called from
    the application code and displayed automatically, with the option to disable
    them for specific audiences or screens.
  robots: index
next:
  description: ''
---
# Overview

<PlacementOverview />

Placements are a core principle of the Purchasely platform. To use our [Audience](segmenting-your-user-base) and [A/B tests](ab-tests) features, you need to use Placements.

Placements are also useful for a common use case: changing the Screen to display by default at any time.\
By calling a Placement from your application, you never have to change your code afterwards as any Screen, audience, or A/B test that you apply to that Placement will be live right away. You can also "disable" it by setting no Screen for a specific Audience or for the entire Placement.

<Image align="center" className="border" border={true} src="https://files.readme.io/581b709-SCR-20240620-oatg.png" />

## Example with New Yorker application

Let's take the example of the New Yorker app, which has many triggers to display paywalls.

<Image align="center" className="border" border={true} src="https://files.readme.io/84f38f1-Paywalls_image.avif" />

<br />

<Image align="center" className="border" border={true} src="https://files.readme.io/6c9ba6f-Paywalls_presentation.avif" />

For this specific case the New Yorker should create 5 Placements:

* App launch
* Nav bar
* Magazine issue
* Toaster
* Settings

# Implementation

## Direct call

In one line of code in your application, you can retrieve the UIViewController (iOS) / View (Android) to display it. It will be displayed automatically with our <Glossary>bridge sdk</Glossary>, unless you want to use a [nested view](nesting-views).

```swift Swift
let placementId = "<<default_placement>>"
// Get the UIViewController to present
let purchaselyController = Purchasely.presentationController(for: placementId)
```
```kotlin Kotlin
// Retrieve the view to display in your layout hierarchy
val purchaselyView = Purchasely.presentationViewForPlacement(
    context = context,
    placementId = "<<default_placement>>",
    onClose = {
			 //TODO remove view from layout hierarchy
 		}
)
```
```typescript React Native
await Purchasely.presentPresentationForPlacement({
    placementVendorId: '<<default_placement>>',
    isFullscreen: true,
});
```
```typescript Flutter
await Purchasely.presentPresentationForPlacement('<<default_placement>>');
```
```csharp Unity
private PurchaselyRuntime.Purchasely _purchasely;

_purchasely.PresentPresentationForPlacement(
  	'<<default_placement>>',
  	OnPresentationResult,
  	OnPresentationContentLoaded,
  	OnPresentationContentClosed,
  	'contentId',
  	true
);
```
```javascript Cordova
Purchasely.presentPresentationForPlacement('<<default_placement>>');
```

## Deeplinks

Placements can also be shown directly from a deeplink if the [related implementation](deeplinks-management) has been completed.\
A deeplink for a Placement can be copied directly from the console in the Placements section and should look like this:\
`yourapp://ply/placements/{placement_id}`

<Image align="center" className="border" border={true} src="https://files.readme.io/6f2715c-SCR-20240620-papo.png" />

# Limitations

<LimitationsSynchronousDisplay />
