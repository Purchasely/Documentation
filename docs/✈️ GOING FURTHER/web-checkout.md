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

# What are the consequences?

* Developers can now invite US users (i.e. iOS users of their app connected to the US App Store) to purchase digital goods without necessarily using In-App Purchase mechanisms
* Purchases performed by US users outside of the app will not generate App Store fees
* Linking from the App to a web funnel is no longer against the App Store review guidelines (which means you cannot get banned for that) and does [no longer require specific app entitlements](https://developer.apple.com/documentation/storekit/external-link-account) as it used to do.
* The new rules only apply for the United States. In other words, for all other territories (different for the US App Store), the rules remain unchanged.
* If the app is not a reader app, the app must continue to offer In-App Purchase alongside other options. This means that to remain compliant with the App Store Review guidelines, you cannot be content to propose ONLY the web checkout to US consumers. They need to have the choice.

# Web checkout flow with Purchasey

> 🚧 SDK v5.3.0+ required
>
> To implement Web Checkout, the minimal version of the SDK required is v5.3.0

Web checkout with Purchasely relies on [Stripe Payment Links](https://docs.stripe.com/payment-links) and is very straightforward. 

It is fully no-code and it allows you to A/B test different Paywalls and includes the web transactions processed by Stripe happening in the Web Browser in your A/B test results.

<Image alt="Screen recording of a successful Web Checkout with Stripe & Apple Pay (Purchasely Sample App)" align="center" border={true} src="https://files.readme.io/25c73778dd4ca561e31ab40f4ef59e1e97373942ff48b6b80f7c56d77206b3f7-stripe.gif">
  Screen recording of a successful Web Checkout with Stripe & Apple Pay (Purchasely Sample App)
</Image>

# Implementation process

Here is the process to follow:

1. Configure your Purchasely \<> Stripe integration 
2. Map the Stripe Price IDs with Purchasely Plans
3. Create a Payment Link in the Stripe Dashboard
4. Create a Web Paywall in the Screen Composer
5. Target US consumers and map the Web Paywall with them

Let's dig into the details of each step.

## 1. Configuring the Purchasely \<> Stripe integration

Purchasely is compatible with Stripe and allows you to integrate web transactions processed by Stripe in your Purchasely Console.

📚 Follow the Guide: [Configuring the Stripe integration](stripe-configuration)

## 2. Mapping the Stripe Price IDs with Purchasely Plans

The next step consists in mapping the Price IDs with Purchasely Plans

📚 Follow the Guide: [Configuring the Stripe Plans](stripe-configuration#iii-configuration-of-plans)

You can either:

* map them with already existing Plans (e.g.: your Monthly Plan in the Purchasely Console already mapped with the App Store and Play Store monthly SKUs
* create dedicated Plans only mapped with Stripe SKUs

## 3. Create a Payment Link in your Stripe Dashboard

1. Access to your Stripe Dashboard
2. Navigate to the section *Payments > Payments Links*

   <Image align="center" className="border" border={true} src="https://files.readme.io/87ced62e5a54e767dff685c01023e30cd2a6a88adc5e35f5c4e0dda8c6be698d-image.png" />
3. Then click on the New button
4. Choose the desired Product & Price - one that has been mapped with a Plan in the Purchasely Console
5. Finalize the configuration of your Payment Link and click on the Create link button\
   📚 More information on Payment Links in the [Stripe documentation](https://docs.stripe.com/payment-links) 

## 4. Creating a Web Paywall in the Screen Composer

In the Screen Composer:

1. Create your Web Paywall
2. Map the desired component - a button, a picker or a text - with the action **Web checkout**
3. In your Stripe Dashboard, copy the Payment Link created at step 3.
4. And paste it in the field Link of your component in the Screen Composer

<Image align="center" className="border" border={true} src="https://files.readme.io/ec90c8bd911367395fb207f82a199f7743ef63e575d058d877280b1b11331335-payment_link.gif" />

## 5. Targeting US consumers and mapping them with the web Paywall

The new App Store Review Guidelines only apply to the *United State Storefront*. The Purchasely SDK provides 2 Built-In Attribute called `Store name` and `Store country` that allow you to target iOS users connected to the US storefront.

To do so, you need to create the following Audience:

<Image align="center" className="border" border={true} src="https://files.readme.io/7b2470b8411782bfec069c50e41ba7239f3f26918880051003cd5fbc7e513a28-image.png" />

> 📘 Beware of the SDK version
>
> The Web Checkout Action requires the SDK v5.3.0+
>
> If you have a concern that some users with an old version of the app (SDK version \< v5.3.0) might be exposed to this Web Paywal, you can add the parameter 
>
> AND **SDK version** is greater than or equal to `5.3.0` 
>
> in your Audience
>
> ![](https://files.readme.io/705e08b0db75ac17bcb30fa93f6651a2dc148c594d15a8a196579b4898ea74dd-image.png)

The last step simply consists in mapping this Audience "US Consumers" with the Web Paywall created during the step 4, on the desired Placement(s)

<Image align="center" className="border" width="400px" border={true} src="https://files.readme.io/4c9d2b717129b277465135e9d773b5a1c96085e243db5570442c24ff051614b9-image.png" />

Or to use this Audience for your A/B test

![](https://files.readme.io/c7a404f73eb5b016bea4f8752e23b7460976d89018f3a964c9c7f23bdb3d474c-image.png)

# User journey

Within the app, the user journey looks like this:

<Image align="center" className="border" border={true} src="https://files.readme.io/361f9639b4811b974e79e54871ec4e703173df1b8df69f81378720d6c3f10368-stripe_2.gif" />

* When the user taps on the checkout button, a new `"webCheckout"` action is sent to the Paywall Actions Interceptor if one is provided during the SDK set up. It contains the action name, and the url, query parameter key, web checkout provider and client reference id parameters. We recommend storing the client reference id to simplify reconciliation on your end (see [Stripe documentation](https://docs.stripe.com/payment-links/url-parameters#streamline-reconciliation-with-a-url-parameter))\ <br />
* ```swift
  Purchasely.start(
      withAPIKey: // your Purchasely API key,
      paywallActionsInterceptor: { action, parameters, presentationInfo, proceed in
          switch action {
          // ... other actions
          case .webCheckout:
              parameters?.clientReferenceId    // The unique reference passed as a query parameter using the provided query parameter key
              parameters?.queryParameterKey    // The query parameter key for the client referenne id. In the case of stripe, the key is `client_reference_id`
              parameters?.url                  // The payment page URL
              parameters?.webCheckoutProvider  // The web checkout provider. "stripe" for Stripe, "other" otherwise

              // store the client reference id to simplify reconciliation
              proceed(true)                    // If you want the Purchasely SDK to handle the action and display the payment page. Else, call `proceed(false)` and have your app should handle displaying the web page.
          }
      },
      storekitSettings: // your StoreKit setting
  )
  ```
  ```javascript Flutter
  ```
  ```javascript ReactNative
  ```
* If the user comes back in the app before finalizing the payment, they will see a modal asking them to finalize the  checkout in the web browser:
  * From there, they can click on Cancel checkout and come back on the Paywall
  * After a short period of time, a Continue checkout button appears. If they click on it, it reopens the web checkout flow in their web browser
* When the user comes back in the app after finalizing the payment in the web browser, the confirmation of the successful checkout is triggered automatically.

  To reconcile the payment and subscription status on your backend, you can listen to our [Server Entitlement Events](https://docs.purchasely.com/server-events) and [Transactional Events](https://docs.purchasely.com/server-events), which for Stripe transactions contain additional `stripe_checkout_session_id` and `stripe_purchase_id` properties your backend can use to query the Stripe API. We recommend associating these properties with the `user_id` in your backend so that you can easily identify the user associated with events sent by the [Stripe Webhook](https://docs.stripe.com/webhooks).

# Using a PSP other than Stripe

If you are using another PSP than Stripe, you need to set the parameter Provider to Other

<Image align="center" className="border" border={true} src="https://files.readme.io/1b01d8ee3478b925fa56ce5568eb5e2be25c25bf87b4bfb80b77e9bececb50a9-image.png" />

You can also also define the Query parameter that will be used to pass the user and context information from the app to the web site.

The URL called aggregate the Link value with the Query parameter and its value.

E.g.: [https://payment.mywebsite.com?client\_ref\_id=XXXX](https://payment.mywebsite.com?client_ref_id=XXXX)

TO BE COMPLETED @Thomas

# Measuring the impact of web payments on your conversion

## A/B testing web payment

If you use the Web checkout process detailed in this page and Stripe, web transactions will automatically be included in your Purchasely A/B tests.

If you are using another PSP, they won't and you will have to use another 3rd-party A/B test platform.

In any case, we strongly encourage you to A/B test it because from our experience, the impact on conversion, retention and revenue can vary a lot.

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
