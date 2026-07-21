---
title: Plan pickers vertical
excerpt: >-
  This page provides details on the configuration of the Plan picker vertical in
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
<PlanPickerShared />

# Configuration

## Plan picker structure

The Plan picker vertical has the following structure:

<Image align="center" className="border" border={true} src="https://files.readme.io/6de99f39765670d23bb1c4c7f70d40b9c22f079a8fac43d433e47ea88a88c10a-image.png" />

<br />

The component is composed of:

* a parent element (highlighted on the picture above), where general configuration options valid for all the pickers can be defined
* child elements that represent each Picker individually (Picker 1 & Picker 2 on the picture above). They are stacked vertically and can be reordered.

<br />

## Configuring the general parameters of the component

Here are all the parameters that can be adjusted for the Plan picker:

<Image align="center" className="border" border={true} src="https://files.readme.io/ce02a4b00f490882635dc68bf81876af00fd834776c82510b5d211e6cb354928-image.png" />

* `Id`: the default value "plan\_picker\_1" works fine. Only change the Id if you want to have several Plan pickers on the same Screen:
  * Pickers on a same Screen which are are mapped with the same `Id` interact together. 
  * Plan pickers with different `Ids` are independent.
<PlanPickerStyles />
* **Pickers icon**

  * You can activate or deactivate the icon
  * If you activate it, you can define 2 different images depending on the state of the picker: `unselected` / `selected`

    <Image align="center" className="border" border={true} src="https://files.readme.io/8f4896bd887aae28cff3f23b0f7e959009f9ba0ec1cd5a47e6b144c990bb63f9-image.gif" />
  * The `icon size` and `icon alignment` (`left` or `right`) can be adjusted
  * By enabling `Text and Icon centered`, you can wrap the icon & the Texts inside button at the center of the button

    <Image align="center" className="border" border={true} src="https://files.readme.io/7d4ce360420818e02feb6e0154139a152df4ed3a07c1438087be9b5446b271f0-layout2.gif" />

  <br />
* **Pickers layout**
  * `Full width`: allows you to extend the picker to fit 100% of the width available. If deactivated, the width of the picker will hug its content.
  * `Min height`: defines the minimum height for the picker. If the content overflows and does not fit in that height, the picker will extend its height.
  * `Space between pickers`: defines the spacing between the pickers

<br />

<PlanPickerConfiguringPickers />

## Configuring Texts in the collections of Texts

To give you maximum flexibility and allow you to create as many lines and font-styles as you wish, each Picker has a *collection of texts* (ex: Promo label, Texts above button, Texts inside button etc...). [Texts](texts) can be added inside a collection by clicking on the `+` button:

* Each collection maps a specific location

  <Image align="center" className="border" border={true} src="https://files.readme.io/a49afd6dc56249a5e6b08084d38709e364dab0d0e835ec26a28a38d0e554da1b-ezgif-4-5b5234ca4e.gif" />
* Depending on the collection, up to 4 Texts can be added, which brings you a lot of flexibility to match the desired design.
* Within a collection, Texts can be reordered by drag & dropping them
* Spacing between the Texts can be set by adjusting each Text Top & Bottom margin. 

<CTAOverridingCTALabelsInPickers />

<DisplayingRegularLabelsVsOfferLabels />

<br />

<PlanPickerTagsUsage />

<Image align="center" className="border" border={true} src="https://files.readme.io/c4cafadf7e99a626b4e25db4d19e5d4a229871106e7b27b8acec7b3afe3cac41-image.png" />

<br />

## Configuring the Promo overlay

You can display a Promo overlay on any button / picker or CTA. A promo overlay is a `Text` with a `background` and a `border`. You can adjust its horizontal positioning by using changing the text alignement (left / center / right) and adjusting the left & right margin

<Image align="center" className="border" border={true} src="https://files.readme.io/4a17e3542f69f3acdb72d7c5f43a46998689bb6eaae8cfb73593fe1527892959-cta3.gif" />

This overlay  can be associated with 2 styles: `selected` / `unselected`
