---
title: Close button
excerpt: >-
  This section describes options to personalize the close button in the Screens
  and paywalls.
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
With SDK version `4.4.0` or above, you have the capability to fully customize the close button displayed in the Screens. This feature can be essential for marketing and product teams as it allows for control over the appearance and behavior of the close button, which can significantly impact user experience and conversion rates.

Here’s how you can customize the close button:

* `Appearance`: Modify the icon, color, size, and position of the close button to align with your brand’s design guidelines.
* `Behavior`: Determine when the close button should be visible. For instance, you may choose to display the close button after a daly of 5 seconds.

<Image align="center" className="border" border={true} src="https://files.readme.io/6a9c648-image.png" />

Please find the following list of options available to customize a close button in your Screens and Paywalls. 

## SHOW CLOSE BUTTON

You can enable or disable to show a close button in your screens. 

<Image align="center" className="border" border={true} src="https://files.readme.io/ff4308a-Screen_Recording_2024-06-18_at_13.39.24.gif" />

<br />

## USE DEFAULT CLOSE BUTTON

Purchasely provides close button by default. You can chose to enable it or use your own icon. When you choose to upload your own icon for the close button, you can set the icon size. 

<Image align="center" className="border" border={true} src="https://files.readme.io/c04bc4d-image.png" />

## DEFAULT COLOR

Color of the close button if you choose to use the default icon provided by Purchasely.

<Image align="center" className="border" border={true} src="https://files.readme.io/0e805b3-image.png" />

## ALIGNMENT

There are three different alignments you can choose: `Leading`, `Trailing` and `Center`

1. `Leading`: This sets the close button:

   * to the left of the Screen for left-to-right languages
   * to the right of the Screen for right-to-left languages

   <Image align="center" className="border" border={true} src="https://files.readme.io/b084fc7-image.png" />
2. `Trailing`: This sets the close button:

   * to the right in the Screen for left-to-right languages
   * to the left in the Screen for right-to-left languages

   <Image align="center" className="border" border={true} src="https://files.readme.io/4754f9a-image.png" />
3. `Center`: This sets the close button to the center in the screen. 

   <Image align="center" className="border" border={true} src="https://files.readme.io/9747212-image.png" />

<br />

## TEXT

You can add a label along side of the close button or just use this label for the close. The text font can't be changed. 

<Image align="center" className="border" border={true} src="https://files.readme.io/cf00ca7-image.png" />

<Image align="center" className="border" border={true} src="https://files.readme.io/c1964be-image.png" />

## TEXT SIZE

Customize the size of the label you have added here.

<Image align="center" className="border" border={true} src="https://files.readme.io/6069885-image.png" />

## TEXT COLOR

The color of the label you have added in the **TEXT** box

<Image align="center" className="border" border={true} src="https://files.readme.io/1de06ae-image.png" />

## DELAY BEFORE DISPLAY

You can set the delay **in milliseconds** before which the close button will appear on the Screen: at the Screen opening, the SDK will wait for this time before displaying the Close button.

*You should test it in the device directly. Preview will not show the close button with delay.*

![](https://files.readme.io/96e2f6b-image.png)

<br />

## ICON ALIGNMENT

There are two different order you can choose to display the label and the icon

1. `Leading`: The icon followed by the label

   <Image align="center" className="border" border={true} src="https://files.readme.io/5346e4d-image.png" />
2. Trailing: The label followed by the icon

   <Image align="center" className="border" border={true} src="https://files.readme.io/26b9e92-image.png" />

## SPACER SIZE

Space between the close icon and the label you have provided in the **TEXT** box.

<Image align="center" className="border" border={true} src="https://files.readme.io/255bf0f-image.png" />
