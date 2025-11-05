---
title: Action types for buttons
excerpt: >-
  This section provides details about the different button actions avaialble in
  Purchasely Screen Builder
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    Now that you have understood everything about Actions types, learn how to
    configure the close button
  pages:
    - type: basic
      slug: close-button
      title: Close button
---
As mentioned in the previous sections, the Purchasely Screens can be used for more than just payments. To curate these screens, we provide you with various button actions.

The different types of actions that you can perform are:

1. [Purchase](#purchase)
2. [Winback/retention offer](#winback--retention-offer)
3. [Close](#close)
4. [Open Presentation](#open-presentation)
5. [Deeplink](#deeplink)
6. [Web page](#web-page)
7. [Login](#login)
8. [Restore](#restore)
9. [Promo code](#promo-code)

## Purchase

`Purchase` action lets you map the button or picker with a Plan

\=> When the user clicks on it, it will trigger a purchase action of that Plan.

1. **ACTION**: `Purchase`

<Image align="center" className="border" border={true} src="https://files.readme.io/b68c986-image.png" />

2. **PLAN**: Choose a plan from the dropdown list

<Image align="center" className="border" border={true} src="https://files.readme.io/c28254b-image.png" />

> 🚧 It's mandatory to use PRICE or AMOUNT + DURATION or AMOUNT + PERIOD for a `purchase` action.

<br />

## Winback / retention offer

Winback / retention offer can be used to display offers to expired users or existing users.

[Refer to section to know more about this function.](retention-winback)

1. **ACTION**: Winback / retention offer.

   <Image align="center" className="border" border={true} src="https://files.readme.io/282d3b9-image.png" />
2. **PLAN**: Choose a plan from the dropdown list that has promotional offer linked.

   <Image align="center" className="border" border={true} src="https://files.readme.io/7c7a421-image.png" />
3. **OFFER**: Choose the promotional offer you would like to display in this paywall.

   <Image align="center" className="border" border={true} src="https://files.readme.io/f108507-image.png" />

<br />

> 🚧 It's mandatory to use `OFFER_PRICE` then `PRICE` or `OFFER_AMOUNT` then `PRICE` in the buttons to clearly display the offer price and then what they will pay for the subscription.

## Close

Close action lets you customize your CTA button to close the paywall.

> 📘 For ex., You can use this action for Maybe later / Remind me later / Skip for now.

**ACTION**: Close

<Image align="center" className="border" border={true} src="https://files.readme.io/ea54c38-image.png" />

This way, you can create a simple "No thanks" button, more discrete than the purchase buttons, to let users close the Screen. Combined with the removal of the Close button (X in the upper corner), this can be a good strategy to "force" users to read what you have to propose, and avoid clicking on the Close button instantly out of reflex.

<Image align="center" className="border" border={true} src="https://files.readme.io/a150ae8-image.png" />

<br />

## Open Presentation

Open presentation action lets you link one paywall with another. 

> 📘 For ex., Build a sequence of paywalls to present the advantages of premium features on the first screen and to display a paywall to purchase a plan or OTP.

1. **ACTION**: Open presentation

   <Image align="center" className="border" border={true} src="https://files.readme.io/b16f0e7-image.png" />
2. **PRESENTATION**: Choose a paywall from the dropdown list.

   <Image align="center" className="border" border={true} src="https://files.readme.io/5d9c6e2-image.png" />

Add text to display in the button:

<Image align="center" className="border" border={true} src="https://files.readme.io/1d1d962-image.png" />

<br />

> 🚧 Please try to make a simple paywall link:
>
> If you try to link more paywalls, it will be difficult for you to track them. You can not see the flow of the linked paywall in the Purchasely paywall preview, you can test it in a device. The conversion rate and dashboard statistics will be calculated only for the paywall with which users made a purchase.

## Deeplink

Deeplink action lets you add a deeplinks to a page in your app or the Apple or Google subscription management pages. 

> 📘 For ex., You can add a link to update billing/open my account/show a native screen or paywall.

1. **ACTION**: Deeplink

   <Image align="center" className="border" border={true} src="https://files.readme.io/88d257f-image.png" />
2. **LINK**: Add a deeplink URL

   <Image align="center" className="border" border={true} src="https://files.readme.io/8ec13d3-image.png" />

## Web page

Webpage action lets you add a website URL.

> 📘 For ex., You can provide a link to Q\&A / Survey questionnaire / Terms and Conditions.

1. **ACTION**: Webpage

   <Image align="center" className="border" border={true} src="https://files.readme.io/c64f6cb-image.png" />
2. **LINK**: add a webpage URL

   <Image align="center" className="border" border={true} src="https://files.readme.io/03e7c30-image.png" />

> 🚧 You should not link to the page to purchase outside of the store.

## Login

Login action lets the user login to your application. You can intercept this login action with the [paywall action interceptor](https://start.purchasely.com/docs/process-transactions-with-paywall-action-interceptor). 

1. **ACTION**: Login

   <Image align="center" className="border" border={true} src="https://files.readme.io/2752131-image.png" />

## Restore

Restore action lets the user restore their purchase.

1. **ACTION**: Restore

   <Image align="center" className="border" border={true} src="https://files.readme.io/c7d845c-image.png" />

## Promo code

Promo code action lets you make promo code campaigns by sharing a custom code.

> 🚧 This feature can be used only for Apple custom codes.

1. **ACTION**: Promo code

   <Image align="center" className="border" border={true} src="https://files.readme.io/26a4718-image.png" />
2. **PROMO CODE**: Enable the **Open link on click** and fill in the **promo code**

   <Image align="center" className="border" border={true} src="https://files.readme.io/dc8f874-image.png" />

<br />

> 📘 Picker elements consist of purchase and Winback/retention offer actions and other CTA button have all the above mentioned functions
