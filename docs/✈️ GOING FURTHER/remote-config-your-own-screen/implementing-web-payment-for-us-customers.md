---
title: Implementing web payment for US customers
excerpt: >-
  This page provides details on linking web checkout flows to a Purchasely
  Paywall following the new App Store ruling
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Context

On May 1st 2025, Epic v. Apple judge Yvonne Gonzalez Rogers just ruled that, effective immediately, Apple is no longer allowed to collect fees on purchases made outside apps and blocks the company from restricting how developers can point users to where they can make purchases outside of apps. Apple says it will appeal the order.\_

📰 More details in this [article from the Verge](https://www.theverge.com/news/659246/apple-epic-app-store-judge-ruling-control)

Following the judge ruling, Apple updated their [App Store review guidelines](https://developer.apple.com/app-store/review/guidelines/#business) as follows (§3.1):

![](https://files.readme.io/385e0fa840709cf4289c13d2f0281bd6f6f3d686eb4a8a4a03f8383bb101d6a8-image.png)

<br />

# What are the consequences?

<br />

* Developers can now invite US users (i.e. iOS users of their app connected to the US App Store) to purchase digital goods without necessarily using In-App Purchase mechanisms
* Purchases performed by US users outside of the app will not generate App Store fees
* Linking from the App to a web funnel is no longer against the App Store review guidelines (which means you cannot get banned for that) and does [no longer require specific app entitlements](https://developer.apple.com/documentation/storekit/external-link-account) as it used to do.
* The new rules only apply for the United States. In other words, for all other territories (different for the US App Store), the rules remain unchanged.
* If the app is not a reader app, the app must continue to offer In-App Purchase alongside other options. This means that to remain compliant with the App Store Review guidelines, you cannot be content to propose ONLY the web checkout to US consumers. They need to have the choice.

<br />

<br />

# Implementation guide

The most basic implementation of web checkout with Purchasely is very straightforward. 

It simply consists in:

1. Creating a web Paywall and opening a web page from a Purchasely Screen
2. Targeting US consumers and mapping the web Paywall with them
3. Opening back the app after the checkout has been finalized

Let's dig into the details of each step.

## 1. Creating a web paywall & opening a web page from a Purchasely Screen

### Leveraging the action Web Page

The next step consists in creating a Purchasely Screen / Paywall, which integrates components linking to the web checkout flow.

The Screen composer allows you to associate different actions to the buttons / links / calls to action. Here is how to do it.

<Image align="center" className="border" border={true} src="https://files.readme.io/b6ed24774726918effe1bf2008bb9348c46dfc1c3789b94a4733316518d00207-ezgif-7de77eb26af367.gif" />

A first simple way to integrate an external link to the Screen composer is to integrate a **Button** to your Paywall and map it with the action `Web page`.

The same can be achieved with a **Text** component:

<Image align="center" src="https://files.readme.io/c99ebb05dcaeb72ed127f96090ca84960fc93e730da37a144eaca9b5b9a3b769-ezgif-7732e2eb44dd17.gif" />

<br />

You can finally leverage Plan Pickers to allow users to choose their Plan directly inside the application and be redirected to different URLs depending on the Plan they chose.

To do that:

1. map your pickers with the Action **Select action to perform**
2. choose the CTA action **Web page**
3. then enter the **Link URL** for each specific picker

\=> Thanks to this, the web page URL opened when users click on the CTA for Plan Picker, will be the one associated to the picker.

<Image alt="The Yearly plan has been mapped with the URL <https://www.mywebsite.com/checkout/yearly> and the Monthly plan with the URL <https://www.mywebsite.com/checkout/monthly>. " align="center" border={true} src="https://files.readme.io/bf1caeb69d3bd215578978691dbbe279847e818c27466cda9ae9821a28007351-ezgif-58faccd81fef7f.gif">
  The Yearly plan has been mapped with the URL [https://www.mywebsite.com/checkout/yearly](https://www.mywebsite.com/checkout/yearly) and the Monthly plan with the URL [https://www.mywebsite.com/checkout/monthly](https://www.mywebsite.com/checkout/monthly). 
</Image>

<br />

### Alternative method: leveraging the action Deeplink

> 📘 Limitations of the action Web Page
>
> In the Screen composer, the action **Web Page**   only allows you to integrate a static URL, without contextual information specific to the user.
>
> If you want to be able to A/B test the web checkout flow (vs an in-app purchase flow within the app) you will need to track the conversion in the Purchasely platform and therefore to pass contextual user information between the app and the website.

Instead of using the action **Web page**, you can use the action **Deeplink**. 

<Image align="center" className="border" border={true} src="https://files.readme.io/962a7fed8d44de715671243d730dcb62542eec1c49b886a367a8caa202f2cdbf-ezgif-89c4b032af5c29.gif" />

This method is not fully no-code because it requires the app to manage the deeplink associated to the picker / link / button / CTA. You shall therefore need to involve your mobile engineers.

However it has more potential because it gives the opportunity to the app to enrich the web page opened with contextual information about the user, for instance to auto connect them when the arrive on the website and therefore avoid the need to login again, which might hurt the conversion.

<br />

<br />

## 2. Targeting US consumers and mapping them with the web Paywall

The new App Store Review Guidelines only apply to the *United State Storefront*. The Purchasely SDK provides 2 Built-In Attribute called `Store name` and `Store country` that allow you to target iOS users connected to the US storefront.

To do so, you need to create the following Audience:

<Image align="center" className="border" border={true} src="https://files.readme.io/7b2470b8411782bfec069c50e41ba7239f3f26918880051003cd5fbc7e513a28-image.png" />

<br />

The last step simply consists in mapping the Audience "US Consumers" created during step 1 with the web Paywall created during the step 2.

1. On the desired Placement, click on the button "Customize for an audience"
2. Select the Audience "US consumers" and the Web Paywall created
3. That's it! You're all set

<Image align="center" className="border" width="400px" border={true} src="https://files.readme.io/4c9d2b717129b277465135e9d773b5a1c96085e243db5570442c24ff051614b9-image.png" />

<br />

<br />

## 3. Opening back the app after the checkout has been finalized

To send the user back to the app once the transaction has been processed in the web browser, you can use a simple deeplink, managed by your app.

The screen associated to this deeplink should:

1. confirm that the payment has been successfully processed 
2. reload the entitlements from your backend to grant them access to their premium benefits

<br />

## Limitation of this basic implementation

This basic implementation offers the advantage to be very simple to set up, but it has a few limitations. 

Let us see them:

1. it is not possible to make the checkout flow totally seamless by enriching the web URL with the app context. As a result and depending on how your website works, users will most likely need to login
2. you cannot measure the conversion of this flow in the Purchasely Console since it's happening outside of the app itself
3. it does not allow you to A/B test the web checkout flow versus an in-app flow

In the next paragraphs, we explore the impact that web payments might have on your conversion and retention how to remove these limitations if you are using Stripe.

<br />

<br />

# Measuring the impact of web payments on your conversion

## Web checkout will impact your conversion and retention!

Depending on how your web checkout works and how seamless is your flow, you can expect a drop-off in the initial conversion rate between **10% to 40%**. 

Moreover, every stage of the funnel will be impacted:

* the conversion from free trial to paid might increase from 5% to 25% - mainly because it's more complex for subscribers to cancel their subscription.
* the long-term retention might also increase for the same reason.

Obviously, it's still very early to have significant data about this and we will communicate on market benchmarks when we will have gathered enough data.

## The necessity to have a seamless flow

Avoiding the App Store fees is tempting, but one of the core advantages of In-App Purchase is that it is fully trusted by consumers and seamless, which generally fosters a good conversion rate. 

On the other hand, sending users from the App to their web browser to finalize their checkout makes the whole flow much more complicated for the user, and can therefore impact the conversion rate in a significant manner:

* users might need to login again - and have probably forgotten their credentials
* they might be reluctant to provide their credit card details - do they trust your brand enough?
* and might simply get lost in their journeys between the app and the web browser

To overcome these challenges, the most seamless flow has the following characteristics:

1. users don't need to choose their plan again if they already chose it within the app\
   \=> You can achieve that by mapping each picker in the Purchasely Paywall with a dedicated URL
2. users are automatically logged-in when they arrive on the web browser\
   \=> You can achieve that by enabling the Shared Web Credentials.\
   📚 Read Apple documentation about [Shared Web Credentials](https://developer.apple.com/documentation/security/shared-web-credentials)\
   📚 Read Stripe documentation about creating a [Checkout session](https://docs.stripe.com/mobile/digital-goods/checkout#open-checkout)
3. users can directly use Apple Pay for web payments\
   📚 Read Apple documentation about [Apple Pay on the Web](https://developer.apple.com/documentation/applepayontheweb) and [implementing Apple Pay](https://developer.apple.com/apple-pay/implementation/)\
   📚 Read Stripe documentation about [Apple Pay for web payments](https://docs.stripe.com/apple-pay?platform=web)

<br />

# Going further with Stripe

## Integrating Stripe with Purchasely

Web payments can be tracked in the Purchasely Dashboard if you are using Stripe.

The associated benefits are the following:

* track you subscriptions in one centralized dashboard - the Purchasely Console
* get the same Server Events for web subscribers as for in-app subscribers
* A/B test a web checkout flow VS an in-app purchase flow to assess which one performs best - see below
* \[full mode only] leverage the Purchasely webhook to manage the entitlements in a unified way for web subscribers and in-app subscribers

📚 To configure the Stripe integration, follow [the guide](stripe-configuration)!

## Setting up the appropriate Stripe checkout flow

Stripe proposes several methods to configure the web checkout flow. 

📚 Read [Stripe documentation](https://docs.stripe.com/mobile/digital-goods) to understand which one best fits your needs

## Web Payment A/B Testing

Currently not possible but stay tuned, we will provide a solution in the coming weeks
