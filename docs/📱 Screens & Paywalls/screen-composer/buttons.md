---
title: Buttons
excerpt: This page provides details on the component Button in the screen composer
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

A button is a generic clickable Screen component that can be mapped with different actions.

# Configuration

## Structure of a button

Here is the structure of a button:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/0143e6c3178d71d97cca85383ea43d0d918b9aa3228e8f53f180a3fb919408e1-image.png",
        null,
        ""
      ],
      "align": "center",
      "sizing": "400px",
      "border": true
    }
  ]
}
[/block]


It is composed of a parent element (highlighted in the image above) and a set of _text collections_.

<br />

<br />

<br />

When mapped with a Purchase action (to trigger the In-App Purchase flow), button are directly mapped with  They are different from the component CTA for Plan picker, which work with a Plan picker and require the user to first choose a plan using the Pickers and then click on the CTA to trigger the Purchase.

Eg: in the Sticky button layout, the Plan picker can be put in the surface **Body**, and the CTA for Plan picker can be associated to the surface **Bottom bar**, to be always visible to the user.

<br />

## Configuring the action associated with the button

Here is the list of actions that can be associated with a button:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/18b10d83f8f3e67b6d013fccc61679f8ba90ac87943fa743fe128e3bcae2c482-image.png",
        null,
        ""
      ],
      "align": "center",
      "sizing": "400px",
      "border": true
    }
  ]
}
[/block]


<ActionList />

<br />

## Configuring the Texts associated with the button

A button has 4 different _collections of Texts_: 

- promo label
- Texts above button
- Texts inside button
- Texts below button

Each collection can be associated with 1 to 4 Texts. Click on the + button to add a new Text.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/8219004d782a07d81a3feeb231df3d009d11cd550ee14e388b56a62fee5b475d-ezgif-5-736ee43d12.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


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

<br />

## Configuring the Promo overlay

You can display a Promo overlay on any button / picker or CTA. A promo overlay is a Text with a background and a border. You can adjust its horizontal positioning by using changing the text alignement (left / center / right) and adjusting the left & right margin

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/2d098b184d87104964629dfc6c405359b42f3eeede0d8d429e640fb02616b38b-ezgif-3-f19a93e9c7.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]