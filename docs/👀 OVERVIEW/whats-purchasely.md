---
title: What's Purchasely?
excerpt: >-
  This section describes what is the Purchasely Platform, its benefits and main
  components
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
---
Purchasely is a platform to build, personalize, and measure native in-app experiences—and, for subscription apps, to also streamline in-app purchase processing and entitlement management.

Purchasely helps mobile teams:

- Ship and iterate on in-app experiences (Screens, Surveys, Quizzes, Flows) without releasing a new app version.
- Personalize journeys based on user insights and attributes (e.g., answers, intent, behaviors).
- Measure and optimize key KPIs (activation, engagement, retention—and monetization metrics for subscription apps).

# What you can do with Purchasely

### Build in-app experiences (for all apps)

Use Purchasely to create and orchestrate native experiences such as Screens, Surveys, Quizzes, and Flows. In the SDK, these are called Presentations, rendered natively and configured remotely from the Console.

Typical use cases:

- **Onboarding**: multi-step onboarding sequences, progressive disclosure, intent capture.
- **Activation**: guide users to first value with contextual steps and decision-tree logic.
- **Engagement & retention**: personalize journeys over time and iterate rapidly.
- **User feedback & insights**: collect preferences and intent through Quizzes, and reuse those insights for personalization.

### Personalize journeys with Flows

Flows let product and marketing teams craft dynamic, logic-driven journeys: create sequences of Screens, ask questions, branch paths, and tailor content in real time.

### Combine Purchasely and your native UI (BYOS)

If you want to keep parts of your onboarding fully native, BYOS lets you orchestrate your own screens alongside Purchasely screens—reorder, insert, or remove steps from the Console.

### Track journeys and connect your stack

Purchasely generates UI/SDK events for user interactions with experiences, which you can forward to your analytics and engagement tools to power reporting, segmentation, and automation.

<br />

### Subscription apps: optional monetization infrastructure

For subscription apps, Purchasely can also:

- Streamline Store integration and transaction processing
- Manage entitlements and Subscription Lifecycle data
- Support growth experimentation on Paywalls and Offers

This monetization layer is optional and depends on your setup and running mode.

<br />

# How Purchasely works

It is composed of:

1. **A mobile SDK** (iOS, Android, and bridges) integrated in your app to render experiences and emit events.
2. **A web Console** to build Screens, create Flows, configure targeting and experiments, and access analytics.
3. **A platform** which can also serve as subscription infrastructure for subscription apps.

<br />

### Platform Components

![](https://files.readme.io/b3a78cf17de41fdccaedad9c1da8fa4c6bc3fd5b056a6c8620b7de5d935562a9-image.png)

<br />

### Typical architecture for subscription apps


<Image src="https://files.readme.io/004c51c-image.png" align="center" border={true} />


<br />

<br />

# What’s next

- To understand the platform foundations: [General principles](general-principles)
- To explore Purchasely main features: [Main features](main-features)
- To discover the advantages of using Purchasely for in-app experiences and growth: [Why use Purchasely](purchasely-advantages)
- To start implementation:
  - Subscription apps: [Quick Start Guide for Subscription Apps](sdk-quick-start)
  - Non subscription apps: [Quick start](general-quick-start-guide)

<br />
