---
title: CTA for Plan picker
excerpt: >-
  This page provides details on the component CTA for Plan picker in the Screen
  Composer
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# General overview

A Plan Picker is a paywall component that allows users to view and select subscription Plans or one-time purchase options. User can choose which Plan they want to purchase and confirm it by clicking on a purchase CTA.

In the Screen Composer, the CTA to trigger the purchase action (once the Plan has been chosen) is a separated component from the Plan picker. 

- Plan pickers ([horizontal](plan-pickers-horizontal) / [vertical](plan-picker-vertical)) allow user to choose which Plan they are interested in
- CTAs for Plan pickers are required to trigger the purchase action of the selected Plan

The CTA can be put in a different surface from the Plan picker.

Eg: in the Sticky button layout, the Plan picker can be put in the surface **Body**, and the CTA for Plan picker can be associated to the surface **Bottom bar**, to be always visible to the user.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/425e4cff03213fcbcb2dd53401364296c5838b11599e7d4c05f16c1d84f430e7-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

# Configuration

## CTA for Plan picker structure

The CTA for Plan picker has the following structure:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/02b37b9325db6c0ab7d5b51c8daa4bf1356b5b0a13cbbfb20f5f1b83fc9367b9-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


The component is composed of:

- a single element (highlighted on the picture above)
- a set of collections of Texts allowing to associate different Texts above, inside or below the button, or in a promotional overlay

  [block:image]{"images":[{"image":["https://files.readme.io/2219d2368c487d6159992f6195623c4234d430cc36322cd24e5040ee4fc65c28-image.png",null,""],"align":"center","border":true}]}[/block]

<br />

## Configuring the general parameters of the component

Here are all the parameters that can be adjusted for the CTA for Plan picker:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/20e3bc050f50b3aba699bebf536665e3e0f889371fb1cd681f63a73cc48ecf96-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

- `Plan picker id`: The value should match the Plan picker id associated to the Plan picker.
  - The default value is set to the id of the first Plan picker created in the Screen
  - Only change it it you have several independent Plan pickers (with several different ids) in the Screen
- **Layout**:

  - `Full width`: 

    - when enabled (by default), the CTA takes the full width available in the surface.
      - The surface left & right padding quand the component left & right margin are taken into consideration to determine the width available
    - when disabled, you can manually set the `Width` of the CTA

    [block:image]{"images":[{"image":["https://files.readme.io/8e915736ab8b49359259ddba23769ca86216152006dfe6b9b1336d2028154eb5-cta.gif","",""],"align":"center","border":true}]}[/block]
  - `Min height`: allows to set the minimum height of the CTA. If the content inside the CTA does not fit (eg: for devices on which the accessibility settings have been activated), the CTA get enlarged.
  - `Icon`: You can activate or deactivate the icon
  - The `icon size` and `icon alignment` (`left` or `right`) can be adjusted
  - By enabling `Text and Icon centered`, you can wrap the icon & the Texts inside button at the center of the button
- **Styles**:

  - You can define 2 different `background` and `border` for the CTA depending on its state: `active` / `disabled`

    [block:image]{"images":[{"image":["https://files.readme.io/951e1b705cfe0e78935cd4c41a7b3c369c68b218baf229ad7dabafb36779c804-cta2.gif","",""],"align":"center","border":true}]}[/block]
  - The CTA is deactivated only when no Picker has been selected. 
  - Note that at the level of the Plan picker, it is possible to define one picker has selected by default, in which case, the disabled state will never be displayed.

<CTAOverridingCTALabelsInPickers />

<br />

<DisplayingRegularLabelsVsOfferLabels />

<br />

## Leveraging tags

[Tags](tags) can be used inside Texts. You can either type them directly in plain text by putting them between pairs of curly brackets (eg: `{{PRICE}}` `{{AMOUNT}}` `{{DURATION}}`). You can also click on the **`{{TAGS}}`** button in the bar just above the text input.

If you want the tag to refer to the button mapped with the element, choose the option "Use element's plan / default plan" after selecting your tag:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/d3f414ad991b1762ae6c9fce2a8bbbd43f05157bed88c6bdf74dafff06de766f-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


- In this case, the tag should appear without parameters when displayed in the text field.
- The advantage is that the tag will automatically be updated when another picker gets selected

If you want the tag to refer to another Plan (eg: to strike through a former price), you can pick the desired Plan directly

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/d2ea90c70dd82467772e05a0322d9323e9a98b3d13b2c913397b83fdbe5df047-override_cta.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

## Configuring the Promo overlay

You can display a Promo overlay on any button / picker or CTA. A promo overlay is a Text with a background and a border. You can adjust its horizontal positioning by using changing the text alignement (left / center / right) and adjusting the left & right margin

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/2f0d39b1b43c92e9b817263ded209bfdb7ed1f8c305bfe0f8ca1431716e6b2f0-promo_label.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


For pickers, this overlay sometimes need to be associated with 2 styles: selected / unselected