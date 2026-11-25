---
title: 'Creating Screens & Flows: prompt, Figma or Composer'
excerpt: >-
  The three ways to create a Screen or a Flow with Purchasely: describe it in a
  prompt, import it from Figma, or build it in the Screen and Flow Composers.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: figma-plugin
      title: Importing Screens from Figma
    - type: basic
      slug: screen-composer
      title: Configuring a Screen with the Screen Composer
    - type: basic
      slug: flow-configuration
      title: Building a Flow with the Flow Composer
---
There are three ways to create a Screen (paywall, onboarding step, quiz, offer…) or a Flow (a sequence of Screens) in Purchasely. They all produce the same object: a standard Screen or Flow, rendered natively by the SDK, that you can edit, localize, A/B test and publish without an app release.

| Starting point                    | How                                                                                           | Best for                                                             |
| --------------------------------- | --------------------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| **A prompt** (AI)                 | Describe the Screen or the Flow in plain words in the Console **Chat**, or attach an image.   | The fastest way to get a first version, or to recreate an existing Screen from a screenshot. |
| **A Figma design**                | Export one or several frames with the **Purchasely Figma plugin**.                            | Teams whose designers already work in Figma and want a pixel-faithful result. |
| **The Screen and Flow Composers** | Assemble components by drag and drop, link Screens with transitions.                          | Building by hand, and fine-tuning anything created with the two other methods. |

The methods combine: most teams generate or import a first version, then refine it in the Composer.

# 1. From a prompt

Open the **Chat** in the Purchasely Console and describe what you want. The assistant designs the Screen with the components of the Screen Composer and shows you the result.

* **Describe it.** _"Design a paywall for my yearly and monthly plans, with a 7-day free trial timeline and three benefits."_
* **Start from an image.** Attach a screenshot or a mockup and ask the assistant to recreate it.
* **Ask for a whole Flow.** _"Build a 5-step onboarding: welcome, two quiz questions about the user's goal and level, a loading screen, then the paywall."_ The assistant generates the Screens, saves each quiz answer in a user attribute, links the steps together and creates the Flow. The same works for a [Web Flow](web2app-build-a-web-flow).
* **Iterate.** From the Screen Composer, open the Chat and describe a change: _"Make the CTA sticky and add a reviews carousel above it."_

Before a Flow is created, the assistant lists its steps and waits for your approval.

<Callout icon="📘" theme="info">
  ### Teach the AI your brand

  In your app settings, the **Brand identity** step lets the assistant learn the look of your app (colors, typography, component style) and its voice. Set it up once: every generated Screen then follows your brand.
</Callout>

Generated Screens and Flows are regular ones. Open them in the [Screen Composer](screen-composer) or the [Flow Composer](flow-configuration) to adjust any detail.

# 2. From a Figma design

The [Purchasely Figma plugin](https://www.figma.com/community/plugin/1600830924110318702/purchasely) turns Figma frames into Purchasely Screens. Select one frame to export a Screen, or several frames to export a whole Flow. Buttons, pickers and quizzes are recognized and become real Purchasely components.

📚 See [Importing Screens from Figma](figma-plugin).

# 3. With the Screen and Flow Composers

The **Screen Composer** is the no-code editor of the Console: choose a layout, drag and drop components, configure them, then handle dark mode and localization. The **Flow Composer** places Screens on a canvas and links them with transitions and conditions.

📚 See [Configuring a Screen with the Screen Composer](screen-composer) and [Building a Flow with the Flow Composer](flow-configuration).

# What happens next

Whatever the method, a Screen or a Flow is displayed in your app the same way: associate it with a [Placement](displaying-screens-placements) or a [Campaign](campaigns), target an Audience, and optionally run an A/B test.
