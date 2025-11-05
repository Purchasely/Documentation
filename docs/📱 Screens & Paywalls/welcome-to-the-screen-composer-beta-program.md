---
title: Welcome to the Screen Composer Beta program! (COPY)
excerpt: This sections provides an overlook of the Screen Composer Beta Program
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Create your first Screen and explore the Screen Composer documentation
  pages:
    - type: basic
      slug: screen-composer
      title: Configuring a Screen with the Screen Composer
---
# General overview

**Purchasely Screen Composer** provides an intuitive and flexible way to design and deploy custom screens for your app. 

The module integrates a comprehensive library of pre-built components, that users can simply drag and drop into their screen structure and organize in different layouts to best fit their needs.

Screens can be created either from a white slate or from a pre-configured template that can be customized as desired and on which components can be added / removed or reordered.

Once components are placed, they can be easily reordered and individually configured to match the desired design and branding. The layout can be adjusted at any time, providing full flexibility to adapt your design as your needs evolve. This ensures a seamless and dynamic experience in creating personalized app screens.

<br />

# What are the pre-requisites for participating to the beta program

* Your app needs to be a **Native app** (Swift on iOS / Kotlin on Android)
* You need to integrate the **Purchasely SDK v5.0 beta** ([iOS](https://github.com/Purchasely/Purchasely-iOS/tree/Beta/5.0.0) / [Android](https://github.com/Purchasely/Purchasely-Android/tree/beta/5.0.0)) in a **staging** application

<br />

# What are we expecting from you?

This version 5.0 of the Purchasely SDK is a major release and we want to make sure that most of the potential issues have been fixed before releasing a production version, which is why it's been released in beta.

This beta version of the SDK and the Screen Composer have been tested by the Purchasely team but some issues might remain. The potential issues include:

* SDK - graphical glitches on new Screens created with the Screen Composer 
* SDK - regressions / graphical glitched on legacy Screens created with the previous Screen & Paywall Builder
* SDK - any kind of functional regressions that you might encounter on edge cases in the Purchase flow
* Console - graphical glitches in the preview of the Screen Composer

We count on your help to move swiftly towards a production ready version. 

The mobile SDK are the most critical parts as they are embedded in your application. To that extent, testing the composer without testing the Screen rendering in the native SDK is not really helping 🙂

<br />

# Instructions to follow

* To participate to the beta test, you must integrate the **Purchasely SDK v5.0.0 beta** ([iOS](https://github.com/Purchasely/Purchasely-iOS/tree/Beta/5.0.0) / [Android](https://github.com/Purchasely/Purchasely-Android/tree/beta/5.0.0)) into a **staging** application.
* During the first phase of the beta test, the SDK will be made available for native apps only (Swift on iOS, Kotlin on Android). SDK bridges for hybrid applications will be made available later.
* New SDK updates might be released on a regular base when the main issues raised will be fixed by our engineering team. We thank you in advance for updating them regularly.
* The bugs encountered must be reported into this [Notion Board](https://www.notion.so/purchasely/Screen-Composer-Beta-bugs-board-127b887cdced80e195e5ceca031fcbdb?pvs=4).\
  \=> [See How to report an issue or a bug](#how-to-report-an-issue-or-a-bug) for more details.

<br />

# What should you test?

* New Screens created with the Screen Composer and visualize them both in the Console and app
* Your legacy Screens and Paywalls created with the legacy Paywall Builder to check that there is no regression on your existing Paywalls
* Everything related to purchasing in-app subscriptions and promotional offers

<br />

# How to seek for help, report an issue or a bug?

While testing the Screen Composer, you might encounter 3 types of issues:

1. **A misunderstanding of how a feature works** => thanks for reaching out via the chat module integrated to the Console to seek for help
2. **A bug** => thanks for reporting it into this [Notion Board](https://www.notion.so/purchasely/Screen-Composer-Beta-bugs-board-127b887cdced80e195e5ceca031fcbdb).\
   For each bug, please fill in the following information:
   * your email address so that we can reach out to you if needed
   * the platform (iOS / Android)
   * the app concerned
   * the version of the SDK integrated (ex: v5.0.0 beta 1)
   * a few explanations on the bug observed and the expected behavior / display which is buggy
   * a screenshot
3. **A general feedback or feature request on the Screen Composer** => thanks for using this form to submit a general feedback or feature request on the Screen Composer

<br />

# How does the Screen Composer work?

Here is the link to the [Screen Composer documentation](screen-composer)

<br />

Thank you for being a valued customer and for considering this opportunity to shape the future of our product.

**The Purchasely Team**
