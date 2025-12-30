---
title: Progress Bars
excerpt: This page describes the Progress bar component in Purchasely Screen Composer
deprecated: false
hidden: false
metadata:
  robots: index
---
Progress Bars help you **visualize user progression**at a glance and **guide** users through **multi-step experiences** with clarity and motivation.

They are especially useful in **Flows**, **onboarding journeys**, **questionnaires**, or any **step-based experience**, where showing progress helps **reduce friction**, **set expectations**, and **increase completion rates**.

## **Benefits of using Progress Bars**

1. Give users a **clear** sense of where they are and what’s left;
2. **Reinforce engagement** by making progress **visible** and **rewarding**;
3. Create **smoother**, more **transparent** user journeys across your app.

***

Purchasely provides you with 2 types of progress bars:

<Image align="center" border={false} src="https://files.readme.io/c3d4318799f58e6b142ca1fd39e986058d87a4e201a8257c16cb58b297ef930c-Progress_bars.gif" />

<br />

## **Progress Bars Configuration**

Progress Bars are **fully customizable** to match your app’s layout and **visual identity**.

### Steps-based logic

Progress Bars rely on a **very simple step-based configuration.**

To set them up, you only need to:

1. **Define the total number of steps** in the journey
2. **Specify the current step** for the screen where the Progress Bar is displayed

<Image align="center" border={false} src="https://files.readme.io/07cf68e24e1098430634012785bfabe373abb63c81e3480aeb6ee020131b6103-progress_steps.gif" />

That’s it!

The Progress Bar automatically calculates and displays the corresponding progress, making it **easy to reflect user advancement without complex logic or dependencies**.

This lightweight setup allows you to quickly add Progress Bars to any step-based experience, while keeping full control over how progress is represented across screens.

### Size

You can adjust the dimensions of the Progress Bar to fit different screen contexts:

**Width:** Define how the Progress Bar adapts to the screen or container

<Image align="center" border={false} src="https://files.readme.io/9e431c9997767318f57b7e371f729beba96808d526ca17fa01b9add543a42303-width.gif" />

**Height:** Control the bar thickness for subtle or more prominent displays

<Image align="center" border={false} src="https://files.readme.io/840fa7c2e6860fd1498103e10bda4c2c02bf4f230bd5bcd0bbe6c95f7c9fe13e-height.gif" />

### Styles

Progress Bars offer **flexible styling options** depending on the selected type.

For **Linear Progress Bars**, you can define different colors for:

* Completed steps
* Upcoming steps

<Image align="center" border={false} src="https://files.readme.io/ad049ec721557cf950cfaf83b0dd32ac268a12e95de4f318eba32f661aef5ddd-inear.gif" />

For **Segmented Progress Bars**, you can configure distinct colors for:

* Completed steps
* Current step
* Upcoming steps

<Image align="center" border={false} src="https://files.readme.io/604a4045587e6126d9ccd3fb4f40ef9ac06b67c11b7df0d277b40d7984203ad6-progress.gif" />

This allows you to clearly differentiate progress states and make the user’s current position immediately understandable.

You can also use a **gradient background** for the filled portion of the Progress Bar, enabling **more dynamic** and **visually engaging** designs.

<Image align="center" border={false} src="https://files.readme.io/36d6fd3da26d69d9358bb9311a7912b8b4cd5e4203abca9e0a2cf72d797febf3-gradient.gif" />

In addition, you can further customize the Progress Bar appearance by configuring:

* **Background color** to highlight the Progress Bar section
* **Border color** for clearer visual separation
