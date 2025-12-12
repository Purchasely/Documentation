---
title: Leveraging Conditional Visibility to Personalize Screens
excerpt: >-
  Conditional visibility allows you to show or hide components within a Screen
  based on user interactions or user data. It helps you build dynamic,
  personalized Screens without needing to duplicate them.
deprecated: false
hidden: true
metadata:
  robots: index
---
# What is Conditional Visibility?

Conditional visibility controls whether a component is displayed or hidden at runtime, depending on predefined conditions.

Conditions can be based on:

* Screen interactions (what the user does in the Screen)
* User data (who the user is or what is known about them)

<br />

# Enabling Conditional Visibility

1. Select a component in the Screen composer.
2. Enable Conditional visibility.
3. Choose a Condition type.
4. Configure the condition that determines when the component is shown.

<br />

## Screen Interactions

Use Screen interactions to control visibility based on the user’s actions within the current Screen.

Available interaction triggers:

* [Plan selected](conditional-visibility#plan-selected) – a specific plan is selected in a plan picker
* Quiz answer selected – a specific answer is selected in a quiz
* Switch state – a switch is ON or OFF
* Tab selected – a specific tab (segmented control) is selected

<br />

### Plan selected

<Callout icon="📘">
  **Compatible with SDK v5.0**

  This feature is retro-compatible until SDK v5.0
</Callout>

This interaction lets you show a component only when a particular plan is selected. This is particularly useful when you want to change the price or CTA.

To assign a visibility condition to a particular picker:

* Enable the condition visibility 

  <Image align="center" border={true} width="400px" src="https://files.readme.io/c14d0f68c958f30cf04bc9223ca98a47fdd5fad8125e0b35a1d425f306090c27-image.png" className="border" />
* Condition type: select "Screen interactions"

  <Image align="center" border={true} width="400px" src="https://files.readme.io/614b56c28698dcd3eda488bad4701c32f2ad8c9c1a8560f8fe2af51c7e929a44-image.png" className="border" />
* Interaction trigger: select "Plan selected"

  <Image align="center" border={true} width="400px" src="https://files.readme.io/bbfc055a955e7e1024eb938024034f8b8926888f0681a15f8bfefde6e81c4f93-image.png" className="border" />
* Then select the desired Plan picker ID y

  <Image align="center" border={true} width="400px" src="https://files.readme.io/5255f60dd2c491d79a1126d02a1603d0bb6d29cbb93a606877f37643c5cc377f-image.png" className="border" />
* And finally select the desired Plan 

  <Image align="center" border={true} width="400px" src="https://files.readme.io/477cd41b5afe9c801077f413c595b83b83a997fbb4eeab4ad6d4f5feea3733d0-image.png" className="border" />

  <br />

**Example**:

In the example below, the Yearly Plan has a free trial but not the Weekly Plan.

<Image
  align="center"
  border={true}
  caption="To show different CTA copies depending on the Plan selected:  
1. duplicate your CTA and adapt the copy  
2. configure a Conditional visibility rule for each button and associate with the desired plan"
  src="https://files.readme.io/d1de49fd10e3ccfabec3f3b4568f0efc9fb2aaa315aedeba2b3bd347f8000912-photoroom_cv.gif"
/>

<br />

### Quiz answer selected

<Callout icon="📘" theme="info">
  **Compatible with SDK v5.0**

  This feature is retro-compatible until SDK v5.0
</Callout>

This interaction lets you show a component only when a particular answer is selected in a Quiz. This can be useful if you want to display additional information when the user selects a particular answer.

To assign a visibility condition to a particular picker:

* enable the condition visibility
* Condition type: select "Screen interactions"
* Interaction trigger: select "Plan selected"
* Then select then select the plan picker ID you want
* And finally select the Plan you want
