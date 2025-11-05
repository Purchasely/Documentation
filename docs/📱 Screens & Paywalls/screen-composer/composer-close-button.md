---
title: Close button
excerpt: >-
  This section describes options to personalize the close button in the Screens
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
With SDK version `4.4.0` or above, you have the capability to fully customize the close button displayed in the Screens. This feature can be essential for marketing and product teams as it allows for control over the appearance and behavior of the close button, which can significantly impact user experience and conversion rates.

The Close button parameters are accessible by clicking on the Layout (first element in the Screen structure).

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/dfc9a69991287c67f6b3d42e2ea1e9e4e117e3a4416090b7384fc0d95ae3bff1-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Here’s how you can customize the close button:

- `Appearance`: Modify the icon, color, size, and position of the close button to align with your brand’s design guidelines.
- `Behavior`: Determine when the close button should be visible. For instance, you may choose to display the close button after a daly of 5 seconds.

<br />

Please find the following list of options available to customize a close button in your Screens and Paywalls. 

## SHOW CLOSE BUTTON

You can enable or disable to show a close button in your screens. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/9f4108672cfe2b3874f47ff56f818d1fa672bdc89d189c5bd6974c9cf279e9ab-ezgif-3-cdc987b3ab.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


## ACTIONS ASSOCIATED WITH THE CLOSE BUTTON

2 different actions can be associated to the Close button: a primary action and a secondary action.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/f415e2ca193f66df065a06cff2dc4e74260088c3a666fa0ac425421b18fc0201-image.png",
        null,
        ""
      ],
      "align": "center",
      "sizing": "350px",
      "border": true
    }
  ]
}
[/block]


<br />

They will be executed in that order.

This allows you for instance, to close the current Screen, but to open another one directly. This is particularly useful to build no-code scenarios where a second paywall with a discount is displayed when users dismiss the first one.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/f460cb31f17b1be8015c075df90da38af8818dbbd4a3caf3c17695874e242edc-ezgif-1-bdfe68fe2e.gif",
        "",
        ""
      ],
      "align": "center",
      "sizing": "350px",
      "border": true
    }
  ]
}
[/block]


## CUSTOM CLOSE BUTTON

Purchasely provides close button by default. You can chose to enable it or use your own icon. When you choose to upload your own icon for the close button, you can set the icon size. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/2837379540a78ee6aed5471dab5fd7f78e5005d11432fb3096e618b508635b29-ezgif-3-018a146a12.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


## CLOSE BUTTON COLOR

When the default close button is used, you can change  its color

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/3b9317697e27224ad913ac6810d71a273f51d0560e2c9c26040e9dcfcfdc0290-image.png",
        null,
        ""
      ],
      "align": "center",
      "sizing": "350px",
      "border": true
    }
  ]
}
[/block]


<br />

## ALIGNMENT

There are three different alignments you can choose: `Leading`, `Trailing` and `Center`

1. `Leading`: This sets the close button:

   - to the left of the Screen for left-to-right languages
   - to the right of the Screen for right-to-left languages
2. `Trailing`: This sets the close button:

   - to the right in the Screen for left-to-right languages
   - to the left in the Screen for right-to-left languages
3. `Center`: This sets the close button to the center in the screen. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/7ebd667f619dd9e341bd00db136abff54b295ec0eca93373b6669519c6c61c57-ezgif-3-3202019d5d.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


## TEXT, TEXT SIZE, TEXT ALIGNEMENT & COLOR

You can add a label along side of the close button or just use this label for the close. The text font can't be changed but you can adjust the text size, text color, the space between the icon and the text, and text alignment 

1. `Leading`: The icon followed by the label
2. `Trailing`: The label followed by the icon

<br />

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/5da3280cd7f3fef4e75e3fcc70b5a8a8d810273c5c3d7e38c1d36138337dcd5a-ezgif-3-47ccfd5dc4.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


## DELAY BEFORE DISPLAY

You can set the delay **in milliseconds** before which the close button will appear on the Screen: at the Screen opening, the SDK will wait for this time before displaying the Close button.

_You should test it in the device directly. Preview will not show the close button with delay. _

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/536bccdfe220736448cc65545d8213853ef56f7079b9a888a220b81f943a5755-image.png",
        null,
        ""
      ],
      "align": "center",
      "sizing": "350px",
      "border": true
    }
  ]
}
[/block]