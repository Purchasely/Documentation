---
title: Leveraging Conditional Visibility to Personalize Screens
excerpt: >-
  Conditional visibility allows you to show or hide components within a Screen
  based on user interactions or user data. It helps you build dynamic,
  personalized Screens without needing to duplicate them.
deprecated: false
hidden: false
metadata:
  robots: index
---
# What is Conditional Visibility?

Conditional Visibility lets you control whether a component is displayed or hidden in a Screen based on:

* Screen interactions - what the user does in the current Screen
* User data - who the user is, what attributes they have, or audiences they belong to

Use this to personalize Screens without duplicating content.

# Enabling Conditional Visibility

1. Select any component in the Screen composer.
2. Turn on Conditional visibility.

   <Image align="left" border={true} width="400px" src="https://files.readme.io/240a7415a56dcbb0010bac781741127d203c1a2407097ffad406a7813a4a5776-image.png" className="border" />
3. Choose a Condition type (Screen interactions or User data).

   <Image align="left" border={true} width="400px" src="https://files.readme.io/8b7889302dd0d93d78cfe974bb93a0565fe37d02c43c865a8199b30f6bd406d8-image.png" className="border" />
4. Pick the specific interaction trigger / user condition, then configure its parameters (see the table below).
5. Preview your Screen in different combinations of conditions.

<br />

> 📘 Compatible with SDK v5.0
>
> All condition types below are retro-compatible until SDK v5.0, **except Eligibility for an Offer, which requires SDK v5.6+** (see table below).

## Condition type parameters

| Category | Condition type | Parameters to configure | Minimum SDK |
| --- | --- | --- | --- |
| Screen interaction | [Plan selected](#plan-selected) | Plan picker ID, then the Plan | v5.0 |
| Screen interaction | [Quiz answer selected](#quiz-answer-selected) | Quiz ID, then the Answer | v5.0 |
| Screen interaction | [Switch state](#switch-state) | Switch ID, then the state (`on` / `off`) | v5.0 |
| Screen interaction | [Tab selected](#tab-selected) | Tab component, then the Tab | v5.0 |
| User data | [Eligibility for an Offer](#eligibility-for-an-offer) | Eligibility rule (is eligible / is not eligible for the Introductory Offer) | **v5.6+** |
| User data | [User attribute value](#user-attribute-value) | User attribute, then its value | v5.0 |
| User data | [Audience](#audience) | Audience | v5.0 (requires a Placement or Flow) |

<br />

## Screen Interactions

Use when visibility depends on actions the user takes in the current Screen.

### Plan selected

This interaction lets you show a component only when a particular plan is selected. This is particularly useful when you want to change the price or CTA.

**Example**:

In the example below, the Yearly Plan has a free trial (and the CTA copy should therefore reflect that) but not the Weekly Plan.

<Image align="center" border={true} src="https://files.readme.io/d1de49fd10e3ccfabec3f3b4568f0efc9fb2aaa315aedeba2b3bd347f8000912-photoroom_cv.gif" className="border" />

<br />

To display different CTA copies depending on the Plan selected:

1. duplicate your Button / CTA and adapt the copy to each Plan
2. configure a Conditional Visibility rule for each CTA / Button and associate with the desired Plan
3. the CTA will then automatically hide / show when the associated Plan is selected

<br />

### Quiz answer selected

This interaction lets you show a component only when a particular answer is selected in a [Quiz](quiz). This can be useful if you want to display additional information when the user selects a particular answer.

**Example:**

<Image align="center" border={true} src="https://files.readme.io/fa77584faeef40e38f91b3f0d736ea18e681d4065d363ee025e5e4b9929cc347-fitness30.gif" className="border" />

<br />

### Switch state

This interaction lets you show a component depending on whether a Switch is ON or OFF. This can be useful activate an optional free trial and adjust the copy / components accordingly.

**Example:**

<Image align="center" border={true} src="https://files.readme.io/97a382a7d072a18744d58ded423af828326cc7d1cd41710fdf9308bc2f0ad6d0-switch.gif" className="border" />

<br />

### Tab selected

This interaction lets you show a component depending on whether a particular Tab / segmented control is selected or not. This can be update the header of a paywall based on the Tab / segmented control selected

**Example:**

<Image align="center" border={true} src="https://files.readme.io/a2f2c8fdcedc33fb3527fc7d915e7ad929909cb88fb9bea21bdfd71bab07cce6-headspace_pw.gif" className="border" />

## User data

Use when visibility depends on the user profile or context.

### Eligibility for an Offer

<Callout icon="❗️" theme="error">
  **Requires SDK v5.6 and above**

  Eligibility-based rules are NOT retro-compatible with SDK below v5.6. You should upgrade to until SDK v5.6 and above to use them.

  If your Screen is displayed by a SDK version below v5.6, components associated with this type of Conditional visibility ruled will simply not be displayed.
</Callout>

This user condition lets you display a component if the a user is eligible / not eligible to the Introductory Offer of any of the Offerings associated with the Paywall. Combined with [Offer mode text override capabilities](offer-mode), it is particularly useful when you want to personalize your Paywall with a "Blinkist timeline" component - explaining how the free trial works - only when the user can still benefit from the free trial.

**Example:**

<Image align="center" border={true} src="https://files.readme.io/a12d5e2951c3aae805fa1fad7571c2c8613c680be5d9879220c1634139ed18a0-heaspace_pw2.gif" className="border" />

<br />

### User attribute value

This user condition lets you display a component depending on the value of a user attribute. This is particularly useful if you want to tailor your Paywall / Screen based on the user insights (e.g.: how the user has responsed to a Quiz).

It is limited to one single user attribute and one single value. If you want to combine several User attributes and values with Boolean Operators, check [Audience-based conditional visibility rules](conditional-visibility#audience) below.

**Example:**

<Image align="center" border={true} caption="In this famous Paywall by Headspace, a benefit tailored to the user insights fetched during the onboarding has been added as a subtitle." src="https://files.readme.io/6b47f4bfaff486ef9329d8a54e72c1bf9125a9cc8e548931120f506266dfe266-headspace_pw3.gif" />

<br />

To visualize a component associated with a User attribute value, use the Preview widget and check the corresponding rule(s).

<Image align="center" border={true} src="https://files.readme.io/f3c9a66e44ace9f4000f06d23b5f5d1326699cd4b96cbeb34b3d70a1b2342f2e-image.png" className="border" />

More info about the [Preview](preview)

<br />

### Audience

<Callout icon="❗️" theme="error">
  **Only works with a Placement or within a Flow**

  For an Audience-based rule to work, you need to display or fetch the Screen through a Placement or the Screen must be integrated inside a Flow.

  If the Screen containing the rule is directly fetched or opened from another Screen (using the Open Screen action), the Audience will not be evaluated and therefore the component associated with the Audience will not be displayed.
</Callout>

This user condition lets you display a component only if the User belongs to a particular Audience. This is particularly useful to tailor the Screen or Paywall to the user insights. The [Audiences](audiences) used are the same ones as those used to target users in a Placement.

**Example:**

<Image align="center" border={true} src="https://files.readme.io/811864fb3cdcb75e15cac730730c6f740c1ab4b1f4b8400470f1867bc4760a3a-photoroom.gif" className="border" />

To visualize a component associated with an Audience, use the Preview widget and check the corresponding rule(s).

<Image align="center" border={true} src="https://files.readme.io/b7704a188be6afedff9c7c48a9c6564001425ac2cd90ea5b85679aa666c4e1b0-image.png" className="border" />

More info about the [Preview](preview)

<br />
