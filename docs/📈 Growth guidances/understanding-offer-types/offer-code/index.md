---
title: Offer code
excerpt: >-
  This page contains things to know before launching promo code campaign and the
  how to distribute these codes using Paywalls & Screens
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Promo codes or Offer codes can be an alternative ways to entice customers to take advantage of sales, discounts, or get something extra. Whether you're planning a promotional campaign for Halloween or Black Friday, Purchasely can help you create eye-catching and customized paywalls to draw attention to the options you're offering. With these codes, you can provide free trial or discounted-price.

There are two types of offer codes or promo codes:

1. **One-time**: is a unique code per user, can be used only once. eg: YUHKJBKB
2. **Custom code**: is a generic code, it can used more than once. eg: BLACKFRIDAY​

Refer to this page for instructions on how to create [offer code in the App Store](offer-codes-configuration-app-store) and [promo code in the Play Store](promo-code-configuration-play-store)

***

# Things to know before launching a promo code campaign

The App Store and Play Store have different rules about using these codes. Here are key points to know before launching a promo code or offer code campaign.

### Apple App Store Connect

1. You can create free or discounted-price offers
2. You can create custom or one-time codes
3. These codes can be used by a new subscriber or existing or expired subscribers
4. You can choose if you would let them use this offer on top of the intro offer or have the promo replace the intro offer
5. The code can be redeemed either from:
   * the App Store (with a dedicated deeplink)\
     [https://apps.apple.com/redeem?ctx=offercodes\&id=YOUR\_APPLE\_ID\&code=TON\_PROMO\_CODE\_ICI](https://apps.apple.com/redeem?ctx=offercodes\&id=YOUR_APPLE_ID\&code=TON_PROMO_CODE_ICI)
   * or from inside the app through a native redemption sheet triggered from the Promo code link on Purchasely Paywalls
6. To do the promo code campaign using Purchasely - you can use- the `promo code?` link in all the paywall templates, use the Promo code template, or use a custom CTA action.
7. You can't test the offer code in sand box environment.
8. You can also do the campaign using deeplink for OTP and custom code- 

### Google Play Console

1. You can create a free trial offer only.
2. You can create a custom or one-time code for this offer.
3. Custom offers can be used only by the new subscribers
4. One-time code can be used by new subscribers or existing or expired subscribers
5. You can’t explicitly choose if the users can enjoy a promo code on top of the intro offer
6. The custom code can be redeemed only inside the app and the user experience is confusing:
   1. users need to click on a link when they are supposed to pay to access the redemption sheet.
   2. you cannot send them to the redemption sheet with a deeplink
   3. all this makes the overall conversion of custom codes on Android poorly efficient
7. One time code can be redeemed inside the app or in the Play Store
8. With these Google restrictions in place, for custom codes, you can use the custom CTA action to guide the Android users on how to redeem the code from inside the app. One of our clients created a paywall with a custom CTA (Utiliser promo code) and this CTA leads to another paywall explaining the steps to redeem the code with a CTA of the plan this code is linked to.
9. For a one-time code, you can share this code using the deeplink - [https://play.google.com/redeem?code=promo\_code](https://play.google.com/redeem?code=promo_code)

***

# Promo code distribution - best practices

## One time code distribution

You can share the code via In-App messages, push notification, email campaign and also with a deeplink. Please find links below:

Apple deeplink:\
[https://apps.apple.com/redeem?ctx=offercodes\&id=YOUR\_APPLE\_ID\&code=YOUR\_PROMO\_CODE\_HERE](https://apps.apple.com/redeem?ctx=offercodes\&id=YOUR_APPLE_ID\&code=YOUR_PROMO_CODE_HERE)

Google deeplink:\
[https://play.google.com/redeem?code=promo\_code](https://play.google.com/redeem?code=promo_code)

## Custom codes

Before designing the paywalls, you should know that the redeeming custom code in iOS and Android are not same when it comes to the UI. 

In iOS devices, you can click on the `promo code?` link on the Purchasely Paywall or use a special promo code paywall. 

In Android devices, to redeem the custom code, you have to click on the CTA and then go to the other payment methods and apply the code and redeem the offer.

<Image align="center" className="border" border={true} src="https://files.readme.io/36ab33c-image.png" />

### Custom code paywall designing best practices for iOS users campaign:

**Step 1**: `Promo code?` link in each and every paywall

<Image align="center" className="border" border={true} src="https://files.readme.io/74c62ca-image.png" />

**Step 2**: Promo code paywall template

<Image align="center" className="border" border={true} src="https://files.readme.io/5342444-image.png" />

<Image align="center" className="border" border={true} src="https://files.readme.io/e506cc4-image.png" />

**Alternative**: Promo code custom action

Promo code action lets you make promo code campaigns by sharing a custom code.

**ACTION**: Promo code

**PROMO CODE**: Fill in the custom code

**OPEN APPSTORE**: Enable Open link on click

> 🚧 This feature can be used only for Apple custom codes

<Image align="center" className="border" border={true} src="https://files.readme.io/6e587ea-Promo_code_action.gif" />

<br />

### Custom code paywall designing best practices for Android users campaign:

For Android custom promo code campaign, since the custom code redeem Android UI is different than of iOS, 

1. Start with a paywall and add extra button to open a presentation (Redeem a promo code)
2. In the second paywall, add instructions on how to use the promo code in the Android
3. Add a subscribe button with the plan linked to the custom code

The user will then click on the subscribe CTA and redeem the code.

<Image align="center" className="border" border={true} src="https://files.readme.io/d41441a-image.png" />
