---
title: Regular labels vs Offer labels
excerpt: >-
  This section provides details on how Regular Labels / Trial labels are managed
  by the SDK
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    Let's now have an overview of the different Action Types available for the
    buttons and Call To Action
  pages:
    - type: basic
      slug: action-types
      title: Action types for buttons
---
# Defining Labels for Buttons and Pickers

The Purchasely Screen Builder allows you to define distinct labels for buttons and pickers depending on the presence of an <Glossary>Introductory Offer</Glossary> and the eligibility of the User to it.

<Image alt="For the 3 fields PROMO / TITLE / SUBTITLE, 2 different labels can be associated." align="center" border={true} src="https://files.readme.io/4b641de-image.png">
  For the 3 fields PROMO / TITLE / SUBTITLE, 2 different labels, Regular and Offer can be associated.
</Image>

When you associate the button with the action `Purchase`, the SDK will be in charge of determining:

1. whether or not an Introductory Offer has been configured for the Plan 
2. and whether or not the User is eligible to this Introductory Offer

Depending on this, it will AUTOMATICALLY switch the Paywall between the 2 display modes:

1. Regular Labels
2. Offer Labels

You don't have anything to do on your end, it's automatic.

<br />

### Regular Labels

Regular Labels are displayed by the SDK when:

* No <Glossary>Introductory Offer</Glossary> has been defined in the App store

**OR**

* When the User is not eligible to the Introductory Offer because they already benefited from it

<Image alt="Regular Labels (R) are displayed in the Preview (2) when the Switch SHOW TRIAL (1) is switched OFF or when the focus is on a field Regular Label" align="center" border={true} src="https://files.readme.io/eaba293-image.png">
  Regular Labels (R) are displayed in the Preview (2) when the Switch SHOW TRIAL (1) is switched OFF or when the focus is on a field Regular Label (R)
</Image>

In these fields, the [Introductory Offers tags](tags#introductory-offer-tags) and [Promotional offer tags](tags#promotional-offer-tags) are not available to avoid confusion, as they are only displayed when the user cannot benefit from these offers.

### Offer Labels

Offer Labels (also called Trial Labels or Introductory Offer Label) are displayed by the SDK when:

* An <Glossary>Introductory Offer</Glossary> has been defined in the App store

**AND**

* When the User is eligible to the Introductory Offer (they never benefited from it)

<Image alt="Trial Labels ($) are displayed in the Preview (2) when the Switch SHOW TRIAL (1) is switched ON or when the focus is on a field Trial Label" align="center" border={true} src="https://files.readme.io/aa903ef-image.png">
  Offer Labels ($) are displayed in the Preview (2) when the Switch SHOW TRIAL (1) is switched ON or when the focus is on a field Offer Label ($)
</Image>

In the Offer Labels, you can add specific Introductory Offers tags:

<TagsIntroductoryOffersTags />

More details on Introductory Offers tags [here](tags#introductory-offers-tag)

The good practice is to display a specific Offer label with the form " *`TRIAL_AMOUNT`during`TRIAL_DURATION` then`PRICE`*".

> 🚧 Don't forget to inform the User about the Regular Price!
>
> The [App Store review guidelines](https://developer.apple.com/app-store/review/guidelines/) are very clear on the fact that you must not be misleading users and that you should inform users on the Regular price of the subscription after the Introductory Offer or Promotional Offer has terminated. 
>
> *E.g.: you cannot be content with only writing "START FOR FREE" without informing informing users how much they are going to pay once the free trial has ended*
>
> As a result, you must also include the Regular price tags and the Purchasely Paywall Builder will not allow you to publish the Paywall if the tags PRICE or AMOUNT + DURATION are not associated to the button.

<br />

### Special case for Promotional Offers (retention / win-back offers)

When you associate a Button with the Action `Winback / retention Offer`, you can propose a Promotional Offer.

<Image alt="Offer Labels ($) are displayed in the Preview (2) when the Switch SHOW TRIAL (1) is switched ON or when the focus is on a field Offer Label ($)" align="center" border={true} src="https://files.readme.io/e1dd056-image.png">
  Offer Labels ($) are displayed in the Preview (2) when the Switch SHOW TRIAL (1) is switched ON or when the focus is on a field Offer Label ($)
</Image>

In this particular case, the SDK will ALWAYS display the Offer Labels, if a Promotional Offer has been configured in the App store.

The reason is that it is not possible to compute the eligibility for such Promotional Offer before the user tries to purchase it (they indeed need to be signed by the App Store).

When proceeding with the purchase after clicking on the purchase button, if the User is not eligible to the Promotional Offer associated: 

1. a modal will be displayed to inform the User that they are not eligible to the Offer 
2. and then the Paywall will switch to displaying the Regular Labels.

When the button or picker has been mapped with a Win-back / retention action, you can use   Offers tags in the Offer Labels:

<TagsPromotionOffersTags />

<br />

> 🚧 Introductory Offer eligibility can only be computed in buttons and pickers
>
> You can use <Glossary>Introductory Offer</Glossary> tags outside of buttons and pickers (e.g.: in a carrousel, feature list, title or subtitle of a Screen), by referencing the associated Plan explicitly.
>
> <Image alt="When you add a tag in a text field which does not belong to a button or a picker, you are asked to choose the associated Plan" align="center" border={true} src="https://files.readme.io/e20a501-image.png">
>   When you add a tag in a text field which does not belong to a button or a picker, you are asked to choose the associated Plan
> </Image>
>
> In that case, **NO ELIGIBILITY** will be computed by the SDK and the tags will be directly displayed.
>
> In other words, if you make a reference to an Introductory Offer (e.g.: `TRIAL_PRICE` or `TRIAL_AMOUNT`) or Promotional Offer (e.g.: `OFFER_PRICE` or `OFFER_DURATION`) outside of a button, the tag will be displayed even when the user is NOT eligible to the Offer.
>
> If you need to have 2 different Paywall title or subtitle depending on the User Eligibility, you will need to duplicate the paywall and use the [segment your user base](segmenting-your-user-base) to display each variant to the relevant users.
>
> **Example**
>
> Let us say you want to display the subtitle "*First 2 weeks free, then $57.99 per year*" but only to users who did not benefit from the free trial, here is how you could do that:
>
> <Image align="center" className="border" border={true} src="https://files.readme.io/386aba7-image.png" />
>
> 1. Create an Audience `Eligible to free trial`, leveraging the attribute `Has expired subscription = false`
> 2. Create a `Paywall #1` with the subtitle *"First`TRIAL_DURATION(ANNUAL)` free, then `PRICE(ANNUAL)`"*
> 3. Duplicate this Paywall as `Paywall #2` with the subtitle *"Reactivate your subscription for`PRICE(ANNUAL)`"*
> 4. Map the `Paywall #1`  with the Audience `Eligible to free trial` on the desired placement.
> 5. Map the `Paywall #2` with the Audience `Everyone else`.
>
> Users who do not have an expired subscription and therefore never benefitted from the Free trial will fall in the Audience `Eligible to free trial` and see `Paywall #1`. Users who do not match this audience will fall in the Audience `Everyone else` and see `Paywall #2`
