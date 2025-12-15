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

**Total Steps**: Total Steps is exactly equivalent to the number of slides your entire Flow consists of.

For an instance, if this is a onboarding flow and it has 7 screens, the Total Step =7

**Current Steps**: Current step number is the actual position of the screen you are customizing.

For an instance ,if the current screen is the first screen of your Onboarding flow, the Current step =1

<Image align="center" border={true} src="https://files.readme.io/f5a5119843636ce8af62769a7764105676f10a78bb4fe6501db8cb6aae0cca4d-image.png" className="border" />

### Size

Size section has options to set the width and height of the progress bar.

**Width**: Fill option will fill the progress bar component. Fixed option will have to be filled by your in pixels. Relative option will have to be filled in percentage.

<Image align="center" border={true} src="https://files.readme.io/9254c7e678663f37d794084def6788392fe3a0706e78e2574c3878829ba92637-image.png" className="border" />

**Height**: You can set the height of the progress bar in pixel.

<Image align="center" border={true} src="https://files.readme.io/f5e73aa8dca8293b1bf6ff24089b052a03fdc3ce038c02937bb28cdc1238c720-image.png" className="border" />

**Styles**

Under Styles, you can customize the background color of the progress and the not progress section of the progress bar. You can also set the border radius and width.

<Image align="center" border={true} src="https://files.readme.io/92aa7cccb9e023b2b1dd36b634f50fd2c079c462ff56f20d6d8d51919d5631af-image.png" className="border" />

<br />

**Margin**

Padding and Margin: Padding is the space between the content of an element and its border. Margin is the space outside the border of an element, pushing it away from surrounding elements.
