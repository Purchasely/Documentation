---
title: Displaying inline paywalls
excerpt: This page provides an overview of how to integrate inline paywalls
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Media publishers can be interested in displaying inline paywalls - ie: paywalls that are displayed inside an a premium article. Technically, this amounts to displaying a Purchasely Screen (child view) into a parent view handled by the application.

![](https://files.readme.io/7985707db099e795c5e29b727a622c74b01ecbeda8675a41dfb843c026ae325e-image.png)

<br />

Let us see how you can do that.

1. Create the desired paywall with the [Screen composer](screen-composer).

   <Image align="center" className="border" border={true} src="https://files.readme.io/8e96ec8402d01f7a2af94bf5707519566404fa1986192cf8ed0e1321a25e82e6-image.png" />

   <br />
2. The desired height of the Purchasely view can be configured by clicking on the first item (the layout) in the Screen structure of the Screen composer

   <Image align="center" className="border" border={true} src="https://files.readme.io/9276b84f2a2fe999f20c59fa746dfa69d095eb61a926fecf8c7c0d9cff19fda6-image.png" />

   <br />
3. Once saved, this Paywall can then be associated to a given Placement (eg: `inline_paywall`) that will be called from the article.
4. To display the block inline with the article, you need to [pre-fetch this Placement](pre-fetching) the Placement
5. The height of the paywall is defined by the property `height` of the object `PLYPresentation` instance retrieved (SDK version >= 5.0.2 on iOS & 5.0.4 on Android)\ <PLYPresentation />\ <br />
6. The view returned can then directly be [nested](nesting-views) in the viewController of the article displayed by the app.

<br />

The CTA inside the Paywall can either:

* link to another full Screen also created with Purchasely. You can do that by associating the action `Open Screen` with the button
* directly trigger the in-app purchase flow with the action `Purchase` but in this case, you should add a link to the Terms & Conditions inside of the block to be compliant with the app stores guidelines.

<br />

If you want to A/B test this inline Paywall, you can configure a standard [UI or Price A/B test](ab-test-configuration) on the Placement `inline_paywall` itself.

If you want to A/B test the positioning of the Paywall inside the article, it's possible but the business rule will have to be integrated on the app side, as it's the app which is in charge of displaying the Paywall. You can leverage the value returned in the property `abTestVariantId` - on which you have control when setting up the A/B test - to determine which variant the user belongs to and adjust the positioning of the block depending on it.
