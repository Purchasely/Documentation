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

* enable the condition visibility
* Condition type: select "Screen interactions"
* Interaction trigger: select "Plan selected"
* Then select then select the plan picker ID you want
* And finally select the Plan you want

<Image align="center" border={true} width="400px" src="https://files.readme.io/688782f0f72aca2035cfe16bd32ddc2037e41b2fd3ccc23fbc4bb9d602899aa1-image.png" className="border" />

<br />

Example:

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
