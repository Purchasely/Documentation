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
3. Choose a Condition type

   <Image align="left" border={true} width="400px" src="https://files.readme.io/8b7889302dd0d93d78cfe974bb93a0565fe37d02c43c865a8199b30f6bd406d8-image.png" className="border" />
4. Configure the condition that determines when the component is shown (see below)
5. Preview your Screen in different combinations of conditions

<br />

## Screen Interactions

Use when visibility depends on actions the user takes in the current Screen.

Available interaction triggers:

* [Plan selected](conditional-visibility#plan-selected) – a plan/an offering is selected in a plan picker
* [Quiz answer selected](conditional-visibility#quiz-answer-selected) – a quiz answer is chosen
* [Switch state](conditional-visibility#switch-state) – a switch is ON or OFF
* [Tab selected](conditional-visibility#tab-selected) – a tab / segmented control is selected

<br />

### Plan selected

<Callout icon="📘" theme="info">
  **Compatible with SDK v5.0**

  Plan-based rules are retro-compatible until SDK v5.0
</Callout>

This interaction lets you show a component only when a particular plan is selected. This is particularly useful when you want to change the price or CTA.

To assign a visibility condition to a particular plan:

* Turn on Conditional Visibility

  <Image align="left" border={true} width="400px" src="https://files.readme.io/c14d0f68c958f30cf04bc9223ca98a47fdd5fad8125e0b35a1d425f306090c27-image.png" className="border" />
* Condition type: select "Screen interactions"

  <Image align="left" border={true} width="400px" src="https://files.readme.io/614b56c28698dcd3eda488bad4701c32f2ad8c9c1a8560f8fe2af51c7e929a44-image.png" className="border" />
* Interaction trigger: select "Plan selected"

  <Image align="left" border={true} width="400px" src="https://files.readme.io/bbfc055a955e7e1024eb938024034f8b8926888f0681a15f8bfefde6e81c4f93-image.png" className="border" />
* Then select the desired Plan picker ID

  <Image align="left" border={true} width="400px" src="https://files.readme.io/5255f60dd2c491d79a1126d02a1603d0bb6d29cbb93a606877f37643c5cc377f-image.png" className="border" />
* And finally select the desired Plan

  <Image align="left" border={true} width="400px" src="https://files.readme.io/477cd41b5afe9c801077f413c595b83b83a997fbb4eeab4ad6d4f5feea3733d0-image.png" className="border" />

  <br />

<br />

<br />

**Example**:

In the example below, the Yearly Plan has a free trial (and the CTA copy should therefore reflect that) but not the Weekly Plan.

<Image align="center" border={true} src="https://files.readme.io/d1de49fd10e3ccfabec3f3b4568f0efc9fb2aaa315aedeba2b3bd347f8000912-photoroom_cv.gif" className="border" />

<br />

To display different CTA copies depending on the Plan selected:

1. duplicate your Button / CTA and adapt the copy to each Plan
2. configure a Conditional Visibility rule for each CTA / Button and associate with the desired Plan
3. the CTA will then automatically hide / show when the associated Plan is selected

<br />

<br />

### Quiz answer selected

<Callout icon="📘" theme="info">
  **Compatible with SDK v5.0**

  Answer-based rules are retro-compatible until SDK v5.0
</Callout>

This interaction lets you show a component only when a particular answer is selected in a [Quiz](quiz). This can be useful if you want to display additional information when the user selects a particular answer.

To assign a visibility condition to a Quiz answer:

* Turn on Conditional Visibility

  <Image align="left" border={true} width="400px" src="https://files.readme.io/c14d0f68c958f30cf04bc9223ca98a47fdd5fad8125e0b35a1d425f306090c27-image.png" className="border" />
* Condition type: select "Screen interactions"

  <Image align="left" border={true} width="400px" src="https://files.readme.io/614b56c28698dcd3eda488bad4701c32f2ad8c9c1a8560f8fe2af51c7e929a44-image.png" className="border" />
* Interaction trigger: select "Quiz answer selected"

  <Image align="left" border={true} width="400px" src="https://files.readme.io/e14287a5754137376df5cc1ea2988ca0c76faba437cdadf75a0fbd2f2ab1b639-image.png" className="border" />

  <br />
* Then select the desired Quiz ID

  <Image align="left" border={true} width="400px" src="https://files.readme.io/bcf1bd1044fe71703b319970f4504aaae4929155fb077c414e96a3b12c3d96f6-image.png" className="border" />

  <br />
* And finally select the desired Answer

  <Image align="left" border={true} width="400px" src="https://files.readme.io/02ddf2634e7f42931f015b2790d335f13d87f4e65fc39d18d9c369ebbbe49e8a-image.png" className="border" />

  <br />

<br />

<br />

<br />

<br />

**Example:**

<Image align="center" border={true} src="https://files.readme.io/fa77584faeef40e38f91b3f0d736ea18e681d4065d363ee025e5e4b9929cc347-fitness30.gif" className="border" />

<br />

### Switch state

<Callout icon="📘" theme="info">
  **Compatible with SDK v5.0**

  Switch-based rules are retro-compatible until SDK v5.0
</Callout>

This interaction lets you show a component depending on whether a Switch is ON or OFF. This can be useful activate an optional free trial and adjust the copy / components accordingly.

To assign a visibility condition to a Switch state:

* Turn on Conditional Visibility

  <Image align="left" border={true} width="400px" src="https://files.readme.io/c14d0f68c958f30cf04bc9223ca98a47fdd5fad8125e0b35a1d425f306090c27-image.png" className="border" />
* Condition type: select "Screen interactions"

  <Image align="left" border={true} width="400px" src="https://files.readme.io/614b56c28698dcd3eda488bad4701c32f2ad8c9c1a8560f8fe2af51c7e929a44-image.png" className="border" />
* Interaction trigger: select "Switch state"

  <Image align="left" border={true} width="400px" src="https://files.readme.io/10ccfe1b1f9707ae4f382f37d162f52c0926390e152d219a528e9da245aec119-image.png" className="border" />

  <br />
* Then select the desired Switch ID

  <Image align="left" border={true} width="400px" src="https://files.readme.io/055ad62c4d87a85d458706f6a2f6107e321c2b5535e1f3734c2d48fb3c8a3705-image.png" className="border" />
* And finally select the desired state (`on` or `off`)

  <Image align="left" border={true} width="400px" src="https://files.readme.io/22585862032dc1b5a31aa836272456d2ec382dac0c949e55e1a02bcd8d8fe96c-image.png" className="border" />

  <br />

<br />

<br />

**Example:**

<Image align="center" border={true} src="https://files.readme.io/97a382a7d072a18744d58ded423af828326cc7d1cd41710fdf9308bc2f0ad6d0-switch.gif" className="border" />

<br />

### Tab selected

<Callout icon="📘" theme="info">
  **Compatible with SDK v5.0**

  Tab-based rules are retro-compatible until SDK v5.0
</Callout>

This interaction lets you show a component depending on whether a particular Tab / segmented control is selected or not. This can be update the header of a paywall based on the Tab / segmented control selected

To assign a visibility condition to a Tab selected:

* Turn on Conditional Visibility

  <Image align="left" border={true} width="400px" src="https://files.readme.io/c14d0f68c958f30cf04bc9223ca98a47fdd5fad8125e0b35a1d425f306090c27-image.png" className="border" />
* Condition type: select "Screen interactions"

  <Image align="left" border={true} width="400px" src="https://files.readme.io/614b56c28698dcd3eda488bad4701c32f2ad8c9c1a8560f8fe2af51c7e929a44-image.png" className="border" />
* Interaction trigger: select "Tab selected"

  <Image align="left" border={true} width="400px" src="https://files.readme.io/1340a79ba22bb2d83ded37b15e2eb45585c3ce158a33d060f281053a285b8244-image.png" className="border" />
* Then select the desired Tab component

  <Image align="left" border={true} width="400px" src="https://files.readme.io/68e8aa271fb27f7b06448c724d2c9d1de7132e0853d7c4154708dd801c7557a0-image.png" className="border" />

  <br />
* And finally select the desired tab

  <Image align="left" border={true} width="400px" src="https://files.readme.io/599afca6198a7d983cf2bccfb4fd79a96be02067b8a0eb26785a1a4eff02f9ce-image.png" className="border" />

  <br />

<br />

<br />

<br />

**Example:**

<Image align="center" border={true} src="https://files.readme.io/a2f2c8fdcedc33fb3527fc7d915e7ad929909cb88fb9bea21bdfd71bab07cce6-headspace_pw.gif" className="border" />

## User data

Use when visibility depends on the user profile or context.

Available User conditions are:

* [Eligibility for an Offer](conditional-visibility#eligibility-for-an-offer) - User is eligible / not eligible to the Introductory Offer
* [User attribute value](conditional-visibility#user-attribute-value) - User has a given `User attribute, value`
* [Audience](conditional-visibility#audience) - User belongs to an Audience

<br />

### Eligibility for an Offer

<Callout icon="❗️">
  **Requires SDK v5.6 and above**

  Eligibility-based rules are NOT retro-compatible with SDK below v5.6. You should upgrade to until SDK v5.6 and above to use them. 

  If your Screen is displayed by a SDK version below v5.6, components associated with this type of Conditional visibility ruled will simply not be displayed.
</Callout>

This user condition lets you display a component if the a user is eligible / not eligible to the Introductory Offer of any of the Offerings associated with the Paywall. Combined with [Offer mode text override capabilities](offer-mode), it is particularly useful when you want to personalize your Paywall with a "Blinkist timeline" component - explaining how the free trial works - only when the user can still benefit from the free trial.

To assign a Visibility Condition based on the a user eligibility for an Introductory Offer:

* Turn on Conditional visibility

  <Image align="left" border={true} width="400px" src="https://files.readme.io/df90612b7cf117b34107864db34e6ff4cc58777c74539738c66cf8ad487381a5-image.png" className="border" />

  <br />

<br />

* Condition type: select "User data"

  <Image align="left" border={true} width="400px" src="https://files.readme.io/7b3cdbbdad8a6415ff04a5b8f32a4eefad25a0f6846e5aba3be48e0bc7459d07-image.png" className="border" />

<br />

<br />

* User condition: select Eligibility to an Offer

  <Image align="left" border={true} width="400px" src="https://files.readme.io/30432644ed0550dd3266ee360b19c85b6164cee44518ccafd7c8acdf35dda6e2-image.png" className="border" />

<br />

<br />

<br />

* And finally select the eligibility rule: is eligible / is not available for the Introductory Offer

<Image align="left" border={true} width="400px" src="https://files.readme.io/4dbd068f3b3b7c0359c8065c0cdf369402fe8e40f501b6e907b53f4c7bcc5673-image.png" className="border" />

<br />

<br />

<br />

**Example:**

<Image align="center" border={true} src="https://files.readme.io/a12d5e2951c3aae805fa1fad7571c2c8613c680be5d9879220c1634139ed18a0-heaspace_pw2.gif" className="border" />

<br />

### User attribute value

<Callout icon="📘" theme="info">
  **Compatible with SDK v5.0**

  This user-attribute-based rules are retro-compatible until SDK v5.0
</Callout>

This user condition lets you display a component depending on the value of a user attribute. This is particularly useful if you want to tailor your Paywall / Screen based on the user insights (e.g.: how the user has responsed to a Quiz).

It is limited to one single user attribute and 1 single value. If you want to combine several user attributes and values, check [Audience-based conditional visibility rules](conditional-visibility#audience) below.

To assign a visibility condition based on a user attribute:

* enable the condition visibility

  <Image align="left" border={true} width="400px" src="https://files.readme.io/a3a4de535bae97a896f31de2cbaa963b3b60407b21e9b09446d309bfe3fede84-image.png" className="border" />

  <br />

<br />

* Condition type: select "User data"

  <Image align="left" border={true} width="400px" src="https://files.readme.io/dc082c5e96333518fe07d5e4d4c58ae4eb31d717abcf6f0a667e71187e38be37-image.png" className="border" />

<br />

<br />

* User condition: select User attribute value

  <Image align="left" border={true} width="400px" src="https://files.readme.io/1e7bfc7d00aa9a832bfb1f1d9663b6357787e163e4a3ae112ac1a126cca11ce3-image.png" className="border" />

<br />

<br />

<br />

<br />

<br />

<br />

* And finally select / type the desired value

  <Image align="left" border={true} width="400px" src="https://files.readme.io/2ce65518201ee18cc835eccf11aff40e52600e54365d099374c091b148c242ba-image.png" className="border" />

<br />

**Example:**

<Image align="center" border={true} src="https://files.readme.io/6b47f4bfaff486ef9329d8a54e72c1bf9125a9cc8e548931120f506266dfe266-headspace_pw3.gif" className="border" />

<br />

If you want to visualize a component associated with a user attribute, you can use the Preview widget and check the desired rule.

<Image align="center" border={true} src="https://files.readme.io/f3c9a66e44ace9f4000f06d23b5f5d1326699cd4b96cbeb34b3d70a1b2342f2e-image.png" className="border" />

More info about the [Preview](preview)

<br />

### Audience

<Callout icon="📘" theme="info">
  **Compatible with SDK v5.0**

  This conditional visibility rule is retro-compatible until SDK v5.0
</Callout>

<Callout icon="❗️">
  **Only works with a Placement or within a Flow**

  For an audience-based rule to work, you need to display or fetch the Screen through a Placement.

  If the Screen containing the rule is directly fetched or opened from another Screen (using the Open Screen action), the Audience will not be evaluated and therefore the component associated with the Audience will not be displayed.
</Callout>

This user condition lets you display a component depending on whether the user belongs to a particular Audience. This is particularly useful to tailor the Screen or Paywall based on the user insights. The [Audiences](audiences) used are the same ones as those used for target users in a Placement.

<br />

To assign a visibility condition based on a user attribute:

* enable the condition visibility

  <Image align="left" border={true} width="400px" src="https://files.readme.io/c14d0f68c958f30cf04bc9223ca98a47fdd5fad8125e0b35a1d425f306090c27-image.png" className="border" />

<br />

<br />

* Condition type: select "User data"

  <Image align="left" border={true} width="400px" src="https://files.readme.io/dc082c5e96333518fe07d5e4d4c58ae4eb31d717abcf6f0a667e71187e38be37-image.png" className="border" />

<br />

* User condition: select Audience

  <Image align="left" border={true} width="400px" src="https://files.readme.io/476cf9be1b7df4c7c7c0be2371bc4bf1a79dd01c2f997dca445e2aa918e5b379-image.png" className="border" />

<br />

<br />

<br />

* Finally select the desired Audience or create a new one

  <Image align="left" border={true} width="400px" src="https://files.readme.io/cadc8b30b7c83d7e937f6767c923148b93baa46285d32489aa9e5a595f8cd8db-image.png" className="border" />

<br />

<br />

<br />

<br />

**Example:**

<Image align="center" border={true} src="https://files.readme.io/811864fb3cdcb75e15cac730730c6f740c1ab4b1f4b8400470f1867bc4760a3a-photoroom.gif" className="border" />

If you want to visualize a component associated with an Audience, you can use the Preview widget and check the desired rule.

<Image align="center" border={true} src="https://files.readme.io/b7704a188be6afedff9c7c48a9c6564001425ac2cd90ea5b85679aa666c4e1b0-image.png" className="border" />

More info about the [Preview](preview)

<br />
