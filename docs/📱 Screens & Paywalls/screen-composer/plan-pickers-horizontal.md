---
title: Plan pickers horizontal
excerpt: >-
  This page provides details on the configuration of Plan pickers horizontal in
  the screen composer
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Associate your Plan picker with a CTA for Plan picker
  pages:
    - type: basic
      slug: cta-for-plan-picker
      title: CTA for Plan picker
---
# General overview

A Plan Picker is a paywall component that allows users to view and select subscription Plans or one-time purchase options. User can choose which Plan they want to purchase and confirm it by clicking on the purchase CTA.

In the Screen Composer, the purchase CTA is a separated component from the Plan picker, called [CTA for Plan pickers](cta-plan-pickers) that can be put in a different surface:

* Plan pickers allow user to choose which plan they are interested in
* CTAs for Plan pickers are required to trigger the purchase action of the selected Plan

<br />

# Configuration

## Plan picker structure

The Plan picker horizontal has the following structure:

<Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/f4f00cf804668e0cd8931d456f3b9c3fcc3e96d95d392d7edf4805ae9dad3f03-image.png" />

The component is composed of:

* a parent element (highlighted on the picture above), where general configuration options valid for all the pickers can be defined
* child elements that represent each Picker individually (Picker 1 & Picker 2 on the picture above). They are stacked horizontally and can be reordered.

<br />

## Configuring the general parameters of the component

Here are all the parameters that can be adjusted for the Plan picker:

<Image align="center" className="border" border={true} src="https://files.readme.io/2160d23d2a114fda1212215dcdf34e516edf1d22e643e31093a5f6b941a6ce98-image.png" />

<br />

* `Plan picker id`: the default value "plan\_picker\_1" works fine. Only change it if you want to have several Plan pickers on the same Screen:
  * Pickers on a same Screen which are are mapped with the same `Plan picker id` interact together. 
  * Plan pickers with different `Plan picker ids` are independent.

<br />

* **Picker styles**

  * You can define 2 different `background` and `border` for each picker depending on its state: `unselected` / `selected`

    <Image align="center" className="border" border={true} src="https://files.readme.io/bc4f2b08bbbadf7e7b29479ee3e12cbc5af0e1954bedb1ced2a6dea9f3e72965-selected_unselected.gif" />

    <br />
* **Pickers layout**

  * `Scrollable`: If you want the picker to be scrollable horizontally and overflow from the Screen, you can enable this switch. In this case, you will need to define the `Width` for the pickers

    <Image align="center" className="border" border={true} src="https://files.readme.io/074dcfa19855ae2beef851165d7f97e28ec3e54511bbea0ac0f64c30a91dbc05-image.png" />
  * `Pickers per row`: you can define the number of pickers per row. If the number of pickers is superior to the number of pickers per row, a new row of pickers will be created below.

    <Image align="center" className="border" border={true} src="https://files.readme.io/f3deb8814884d4764efb7d2c0d7debdf5aa5b2cfb7ebb0e4ff20f56c588281f4-horizontal.gif" />
  * `Space between pickers` and `Space between rows`: allow you to define the general layout of the component
  * `Min height`: defines the minimum height of the picker. If the text overflows (eg: on devices on which the OS Accessibility feature has been enable), the picker will be automatically enlarged.
  * `Alignment`: allows you to define whether the text should be vertically centered inside each picker or if the text should be vertically aligned on top.

<br />

* **Pickers padding**: As usual, you can adjust the spacing between the pickers borders and the contents (Texts) inside the picker.
* **Margin**: This allows you to define the spacing between the outside border of the whole component and the other components (top & bottom) or the edges (left and right) of the surface.

## Configuring the pickers

Each picker must be associated with a Plan and can be optionally associated to an Offer (Promotional Offer). You must have associated the Plans to the Screen ([Manage Plan section](screen-composer#1-paywalls-only-define-the-plans)) prior to mapping it with the pickers.

<Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/699b637d2f04b8464a232f2a4b65ccd4b32e96f508a5f4f2fc8da40c0fe683ac-image.png" />

The `Default` switch allows you define that one Picker should be selected by default when the Screen is displayed (without need for the User to manually select it). Only one picker can be selected by default.

Margin Top / Bottom / Left & Right can be defined specifically for each picker.

<br />

An `Icon` can be configured for each picker individually. When enabled, you can define:

* the `Images` for both states (`selected` / `unselected`)
* the `Size` of the image 
* its `Alignment` (`Top`: above the Texts inside the picker or `Bottom`: below the Labels inside the picker)

<Image align="center" className="border" border={true} src="https://files.readme.io/ed9cd4b9d68393da5b5b7e14fef75a3c7e9581525ad62a6eb4d0e7d633f07518-picker_horizontal.gif" />

<br />

## Configuring Texts in the collections of Texts

To give you maximum flexibility and allow you to create as many lines and font-styles as you wish, each Picker has a *collection of Texts* (ex: Promo label, Text inside button...). [Texts](texts) can be added inside a collection by clicking on the `+` button:

* Each collection maps a specific location

  <Image align="center" className="border" border={true} src="https://files.readme.io/143721814ff5afa8c102573cf8cd1feb8dd07d90cbfcaf1d82d06bb4b90c87d4-ezgif-6-295dcc5b43.gif" />
* Depending on the collection, up to 4 Texts can be added, which brings you a lot of flexibility to match the desired design.
* Within a collection, Texts can be reordered by drag & dropping them
* Spacing between the Texts can be set by adjusting each Text Top & Bottom margin. 

## Overriding the Texts of the CTA

In the Plan Picker, the collections starting with `CTA` allow to override the Texts of the CTA depending on which picker is currently selected:

* When the Picker will be selected by the user, the Texts in these collections will override the default Texts associated at the Purchase CTA level.
* Overriding the Texts is optional but if you override one of them, you must override them all.

Example:

* The default Text defined for the CTA is "Start my premium membership"
* This Text is overridden for each picker: 

  * "Start my **monthly** membership" for the Picker associated to the Monthly Plan
  * "Start my **yearly** membership" for the Picker associated to the Yearly Plan

    <Image align="center" className="border" border={true} src="https://files.readme.io/54bc1fc2116dad90e15ff4bddb30b9e244a4a60063f76cae1aeb9317130358cd-ezgif-6-28e9888568.gif" />
* When a Picker is selected, the Text inside the CTA changes to match the value defined at the picker level

<br />

<DisplayingRegularLabelsVsOfferLabels />

<br />

## Leveraging tags

[Tags](tags) can be used inside Texts. You can either type them directly in plain text by putting them between pairs of curly brackets (eg: `{{PRICE}}` `{{AMOUNT}}` `{{DURATION}}`). You can also click on the **`{{TAGS}}`** button in the bar just above the text input.

If you want the tag to refer to the button mapped with the element, choose the option "Use element's plan / default plan" after selecting your tag:

<Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/d3f414ad991b1762ae6c9fce2a8bbbd43f05157bed88c6bdf74dafff06de766f-image.png" />

* In this case, the tag should appear without parameters when displayed in the text field.
* The advantage is that you will not need to update the tag if you update the Plan associated to the picker.

If you want the tag to refer to another Plan (eg: to strike through a former price), you can pick the desired Plan directly

<br />

## Configuring the Promo overlay

You can display a Promo overlay on any button / picker or CTA. A promo overlay is a Text with a background and a border. You can adjust its horizontal positioning by using changing the text alignement (left / center / right) and adjusting the left & right margin

<Image align="center" className="border" border={true} src="https://files.readme.io/c9cf149720193d6c698be56999788e3d3ca259b4aabb39652f36153c3a572c7e-promo_label_2.gif" />

This overlay can be associated with 2 styles: `selected` / `unselected`
