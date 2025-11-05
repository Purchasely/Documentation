---
title: Action types for buttons (new)
excerpt: >-
  This section provides details about the different button actions avaialble in
  Purchasely Screen Builder
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Action components

Purchasely Screens can be used for more than just payments. In the Screens built with the Screen Composer, you can integrate various **Action components** - i.e.: components users can interact with to trigger a particular action, such as [Buttons](buttons), [Call-to-Action](cta-plan-pickers), [Pickers](plan-pickers-horizontal), [Text](texts) elements associated with a link or the [Close button](close-button) of the Screen.

This Action can be defined in the **On tap** section of the component, in the fields `Action` and/or `Secondary action`.

<Image align="center" className="border" border={true} src="https://files.readme.io/324c4326a4ca4794d42647a840e0be97a2d8880a80b89872271b52586818bc4d-actions.gif" />

<br />

> 📘 About Secondary Actions
>
> The Purchasely SDK is able to trigger not only one Action when an Action component is clicked, but rather a set of Actions, that are executed one after the other.
>
> For some specific components, a Secondary action is available. Here are the components concerned:
>
> * The [Close button](close-button) of the Screen => allows you to open a new Screen (or execute another Action) when a Screen gets dismissed by the user.
> * The CTA for [Multiple choice questions](mcq#5-configuring-the-cta-associated-to-the-mcq) => this allows you to navigate to another Screen (or execute another action) in addition to submitting a Survey
> * <br />

<br />

# Types of Actions available

The different types of Actions that can be mapped with these elements are:

1. [Purchase](#purchase)
2. [Close](#close)
3. [Open Presentation](#open-presentation)
4. [Deeplink](#deeplink)
5. [Web page](#web-page)
6. [Login](#login)
7. [Restore](#restore)
8. [Promo code](#promo-code)
9. [Close all](https://docs.purchasely.com/docs/action-types#close-all)
10. [Open placement](https://docs.purchasely.com/docs/action-types#open-placement)

<br />

## Purchase

`Purchase` action lets you map the button or picker with a Plan

\=> When the user clicks on it, it will trigger a purchase action of that Plan.

1. **ACTION**: `Purchase`
2. **PLAN**: Choose a plan from the dropdown list
3. **OFFER**: Choose a promotional offer you would like to show in this paywall. It is not mandatory to select an offer; it depends on your use case.

<Image align="center" src="https://files.readme.io/3c7719a039a76ba74055f498ee27ad7e46b475650c5871c9edd5cede153c070b-Screen_Recording_2025-02-12_at_11.15.05.gif" />

> 🚧 Use PRICE or AMOUNT + DURATION or AMOUNT + PERIOD for a 'purchase' action to show the price of the plan along with its duration.

<br />

## Close

Close action lets you customize your CTA button to close the paywall.

> 📘 For ex., You can use this action for Maybe later / Remind me later / Skip for now.

**ACTION**: Close

<Image align="center" className="border" border={true} src="https://files.readme.io/19140fef32d76d33d4c1f81f0507de558349fb2b4043af6be1553c2038839672-image.png" />

<br />

This way, you can create a simple "No thanks" button, more discrete than the purchase buttons, to let users close the Screen. Combined with the removal of the Close button (X in the upper corner), this can be a good strategy to "force" users to read what you have to propose, and avoid clicking on the Close button instantly out of reflex.

<Image align="center" className="border" border={true} src="https://files.readme.io/d7010ffdff034932362ed53063ec835e1c81ee058c7924868f5c55f6aed4b2eb-image.png" />

<br />

## Open Screen

**Open Screen** Action lets you link one paywall with another. 

> 📘 For ex., Build a sequence of paywalls to present the advantages of premium features on the first screen and to display a paywall to purchase a plan or OTP.

1. **Action**: Open presentation

   <Image align="center" className="border" border={true} src="https://files.readme.io/e51c200ec2b3dd55e9af8444b0711c36505a9fab40e10c6f1a749f41cd7a6cda-image.png" />
2. **Screen**: Choose a paywall from the dropdown list.

Add text to display in the button:

<Image align="center" className="border" border={true} src="https://files.readme.io/13240835346d62c0de30b7604f679df40aef4d04cc13cc825a0e8969513f9fdd-image.png" />

<br />

> 🚧 Please try to make a simple paywall link:
>
> If you try to link more paywalls, it will be difficult for you to track them. You can not see the flow of the linked paywall in the Purchasely paywall preview, you can test it in a device. The conversion rate and dashboard statistics will be calculated only for the paywall with which users made a purchase.

## Deeplink

**Deeplink** Action lets you add a deeplink to any location in your app or the Apple or Google subscription management pages. 

> 📘 For ex., You can add a link to update billing/open my account/show a native screen or paywall.

1. **Action**: Deeplink
2. **Deeplink**: Add a deeplink URL

   <Image align="center" className="border" border={true} src="https://files.readme.io/4dd0aeabfbfafbea1d8ce0a866decc67c2fd1f82aec92e0318f7af2c3c14a867-image.png" />

<br />

## Web page

**Web page** Action lets you open a Web page:

* On iOS, the URL will be open in the default web browser
* On Android, it will be open in a webview inside the application

> 📘 For ex., You can provide a link to Q\&A / Survey questionnaire / Terms and Conditions.

1. **Action**: Webpage

   <Image align="center" className="border" border={true} src="https://files.readme.io/75c4de30e70da46503c5a9ef6ff257057af7710b3128252c55a298249a929f92-image.png" />
2. **Link**: add a webpage URL

> 🚧 You should not link to the page to purchase outside of the store.

## Login

**Login** Action lets the user login to your application. You can intercept this login action with the [paywall action interceptor](https://start.purchasely.com/docs/process-transactions-with-paywall-action-interceptor). 

1. **Action**: Login

   <Image align="center" className="border" border={true} src="https://files.readme.io/46eee33ff579bd056ac88ce0ee3c82e0bad4c7c89294b7dbf48eb72938c7df27-image.png" />

## Restore

**Restore** Action lets the user restore their in-app purchase

1. **Action**: Restore

   <Image align="center" className="border" border={true} src="https://files.readme.io/6d6a7bf6a968210c8abbad4c59e27402be3138f1d243f1821e45993c5c47c258-image.png" />

## Promo code

**Promo code** Action lets you make promo code campaigns by sharing a custom code.

> 🚧 This feature can be used only for Apple custom codes.

1. **Action**: Promo code

   <Image align="center" className="border" border={true} src="https://files.readme.io/a161e8bbfd6df24b29d50464c1f4ff86c272f11a98e99d59ff06ea0d63379cc6-image.png" />
2. **Promo code**: Enable the **Open App Store** and fill in the **Promo code**

<br />

## Close all

**Close all** Action will close all the other Purchasely screens that are open. This feature comes handy if you are creating a flow of screens. 

1. **Action**: Close All

   <Image align="center" className="border" border={true} src="https://files.readme.io/255da1f838035de33d183e0656d77fde83c7b1baef76be50d442035ac0b346b4-image.png" />

<br />

## Open placement

Open placement Action lets your text or button to Open a Placement from your current screen. It can be used to create conditional transitions. Depending on the audience the user belong to, they will see different screens while they click on the CTA. Eg: Survey, Onboarding etc. 

1. **Action**: Open Placement

   <Image align="center" className="border" border={true} src="https://files.readme.io/8bb84442cc673259ecccbb9e46026e6606b057c3b7d7af274882a51a4a09d0ce-image.png" />
2. **Placement**: choose the placement from the drop down list. It will be displayed as soon as the user clicks on the CTA button. 

   ![](https://files.readme.io/5863eda04fc5211d3b48a167009a1a9bc81dae98edadf1f2d7596199e6116867-image.png)
