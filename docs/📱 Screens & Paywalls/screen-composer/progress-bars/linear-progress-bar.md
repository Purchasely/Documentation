---
title: Linear Progress bar
excerpt: This page describes how to configure Linear Progress bar in Purchasley Console
deprecated: false
hidden: false
metadata:
  robots: index
---
This type of simple, low-profile progress bar is commonly used in places where you want to show quick, lightweight progress without taking up much screen space.

# Benefits of this progress bar:

It’s especially useful in:

Onboarding flows: Guiding users through steps like choosing goals, setting preferences, or creating an account.

Setup wizards: For apps that require initial configuration (fitness apps, finance apps, learning apps, etc.).

Form completion: Multi-step forms such as surveys, applications, or checkouts.

Feature walkthroughs: When introducing new app features and helping users complete a short tutorial.

Profile completion indicators: Showing how much of a profile or setup is done (common in social, productivity, or job-search products).

Overall, this style works best in short, guided, multi-step experiences where you want users to feel momentum and stay oriented.

***

# General Overview

## Linear Progress Bar Structure:

The Linear Progress Bar is just one parent component with no sub section to it.

<Image align="center" border={true} src="https://files.readme.io/2431a6930a0e5514a2d850e7c720ae76855f88706aeb2b2c0507356375f2de1f-image.png" className="border" />

***

<br />

## Linear progress Bar configuration:

<Image align="center" border={true} src="https://files.readme.io/bcb1f80644bf1e05760a96ebd07eb3f8c330557a5bb54d933421491325e0ae24-image.png" className="border" />

### Progress Steps

**Total Steps**
Represents the total number of screens (or slides) in your entire flow.

Example:
If your onboarding flow contains 7 screens, then Total Steps = 7.

**Current Step**
Indicates the position of the screen currently being customized within the flow.

Example:
If you are configuring the first screen of the onboarding flow, then Current Step = 1.

<Image align="center" border={true} src="https://files.readme.io/f5a5119843636ce8af62769a7764105676f10a78bb4fe6501db8cb6aae0cca4d-image.png" className="border" />

### Size

The Size section allows you to configure the width and height of the progress bar.

**Width**

* Fill: The progress bar fills the available container width.
* Fixed: The width is defined in pixels.
* Relative: The width is defined as a percentage.

<Image align="center" border={true} src="https://files.readme.io/9254c7e678663f37d794084def6788392fe3a0706e78e2574c3878829ba92637-image.png" className="border" />

**Height**: Sets the height of the progress bar in pixels.

<Image align="center" border={true} src="https://files.readme.io/f5e73aa8dca8293b1bf6ff24089b052a03fdc3ce038c02937bb28cdc1238c720-image.png" className="border" />

**Styles**

In the Styles section, you can customize:

* the background colour of the completed progress
* the background colour of the remaining (not completed) progress
* the border radius
* the border width

<Image align="center" border={true} src="https://files.readme.io/92aa7cccb9e023b2b1dd36b634f50fd2c079c462ff56f20d6d8d51919d5631af-image.png" className="border" />

<br />

**Margin**

The Margin option lets you define the space outside the progress bar’s border, pushing it away from surrounding elements.

<Image align="center" border={true} src="https://files.readme.io/03ae1204ecfe75a7bdc2cfe420632f68eec7cfbbe367f3860c9dc3775421754c-image.png" className="border" />
