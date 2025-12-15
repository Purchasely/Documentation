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
A segmented progress bar is a progress indicator divided into distinct sections (segments) rather than a single continuous bar.

Each segment usually represents:

* a step in a multi-step process
* a portion of total progress (for example, milestones, tasks, or phases).

Segmented progress bars are commonly used in onboarding flows, checkout processes, surveys, fitness goals, dashboards, and learning platforms.

Purchasely’s Segmented Progress Bar is composed of three elements:

* Total progress
* Completed steps
* Current step

<br />

# General Overview

<br />

## Segmented Progress Bar Structure:

The Segmented Progress Bar is a single parent component and does not contain any subsections.

<Image align="center" border={true} src="https://files.readme.io/d6c9e1096edea47f43193d0d8ddd4450339fba8cf16028c893dc12ba135abd32-image.png" className="border" />

<br />

***

## Segmented progress Bar configuration:

<Image align="center" border={true} src="https://files.readme.io/ffc39510c46a5c743ade930784532166b3698a2d3244fb2df85ab82474ed9847-image.png" className="border" />

<br />

### Progress Steps

**Total Steps**
Represents the total number of screens (or slides) in your entire flow.

Example:
If your onboarding flow contains 7 screens, then Total Steps = 7.

**Current Step**
Indicates the position of the screen currently being customized within the flow.

Example:
If you are configuring the first screen of the onboarding flow, then Current Step = 1.

**Gap Between Steps:**Defines the spacing between each step in the progress bar.
The value is set in pixels.

<Image align="center" border={true} src="https://files.readme.io/feb98d3c10e21031641a4f63ccf332d31da37266a0e6c7cf4ef54a5b0cea0b0f-image.png" className="border" />

<br />

### Size

Size section has options to set the width and height of the progress bar.

**Width**: Fill option will fill the progress bar component. Fixed option will have to be filled by your in pixels. Relative option will have to be filled in percentage.

<Image align="center" border={true} src="https://files.readme.io/9254c7e678663f37d794084def6788392fe3a0706e78e2574c3878829ba92637-image.png" className="border" />

**Height**: You can set the height of the progress bar in pixel.

<Image align="center" border={true} src="https://files.readme.io/f5e73aa8dca8293b1bf6ff24089b052a03fdc3ce038c02937bb28cdc1238c720-image.png" className="border" />

**Styles**

Under Styles, you can customize the background color of the progress and the not progress section of the progress bar. You can also set the border radius and width.

<Image align="center" border={true} src="https://files.readme.io/f578cc2fea1f21d4dcc9d7e3f319946773a162886fcbbcf1c7aa196d29ad4524-image.png" className="border" />

**Margin**

You can set the space outside the border of an progress bar, pushing it away from surrounding elements.

<Image align="center" border={true} src="https://files.readme.io/03ae1204ecfe75a7bdc2cfe420632f68eec7cfbbe367f3860c9dc3775421754c-image.png" className="border" />

<br />
