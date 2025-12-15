---
title: Segmented Progress bar
excerpt: >-
  This page describes how to configure Segmented Progress bar in Purchasley
  Console
deprecated: false
hidden: false
metadata:
  robots: index
---
A segmented progress bar is a progress indicator divided into distinct sections (segments) instead of one continuous bar.
Each segment usually represents:

a step in a multi-step process, or

a portion of total progress (e.g., milestones, tasks, phases).

You’ll often see it in onboarding flows, checkout processes, surveys, fitness goals, dashboards, and learning platforms.

Purchasely's Segmented Progress bar consists of three parts: Total progress, steps completed and the current step.

<br />

# General Overview

<br />

## Segmented Progress Bar Structure:

The Segmented Progress Bar is just one parent component with no sub section to it.

<Image align="center" border={true} src="https://files.readme.io/d6c9e1096edea47f43193d0d8ddd4450339fba8cf16028c893dc12ba135abd32-image.png" className="border" />

<br />

***

## Segmented progress Bar configuration:

<Image align="center" border={true} src="https://files.readme.io/ffc39510c46a5c743ade930784532166b3698a2d3244fb2df85ab82474ed9847-image.png" className="border" />

<br />

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

<Image align="center" border={true} src="https://files.readme.io/6cabedd5c826f15806cae6ce26a32b9662830ead2559bd8e17ccd2b2226c4b7f-image.png" className="border" />
