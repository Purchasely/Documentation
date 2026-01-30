---
title: What you can do with Purchasely
excerpt: 'This page provides an overview of how '
deprecated: false
hidden: true
metadata:
  robots: index
---
Purchasely helps All types of Apps improve onboarding, activation, engagement/retention, and user feedback by shipping native In-App Experiences (Screens, Flows, Quizzes) that you can build and iterate in no-code - while your app stays fully in control of where/when to display them.

<br />

## Typical use cases

Use Purchasely to:

* **Onboarding**
  * Welcome users with a branded onboarding sequence (multi-step, contextual).
  * Ask a few questions to understand intent and tailor the journey.
* **Activation**
  * Guide users to the “aha moment” (feature discovery, setup completion, first success).
  * Branch the experience based on what the user answers or does.
* **Engagement & retention**
  * Nudge feature adoption, re-engage dormant users, and reduce early churn with contextual screens and tailored paths.
* **User feedback**
  * Run in-app surveys/quizzes (preferences, goals, satisfaction) and use answers immediately in the experience.

<br />

## What you can build with Purchasely

1. **Design any in-app Screen (no-code)**  

   Create custom screens from scratch or templates using a drag-and-drop component library, then iterate remotely.
2. **Integrate Screens with multiple display modes**

   Choose how a screen is presented in-app (e.g., modal, embedded/inline, push, drawer) and change it remotely from the Console.
3. **Craft personalized Flows (dynamic journeys)**

   Build decision-tree journeys made of multiple Screens:
   * ask questions (Quizzes),
   * route users through different paths,
   * tailor messaging and screens based on insights.
4. **Bring Your Own Screen (BYOS) when needed**

   Mix Purchasely screens with your own native screens inside a Flow to keep full UX consistency where you need it most.
5. **Track journeys and forward events to your stack**

   When users interact with Purchasely Screens, the SDK emits [UI/SDK events](ui-sdk-events). You can listen to them in the app and forward them to your analytics or CRM (e.g., Amplitude, Braze) for reporting, audiences, automation, and experimentation.
6. **Fetch user insights (Quiz answers) in real time**

   Collect user answers and expose them to your app logic via SDK listeners/delegates so you can:
   * store them as insight attributes for targeting purposes
   * tailor Flows bases on users insights
   * sync them to your CRM/data warehouse.

<br />

## What you’ll implement in this Quick start

By the end, you will have:

* The Purchasely SDK installed and initialized
* Deeplinks/placements handled so you can trigger experiences reliably
* Your first Screen displayed in-app (with the right display mode)
* Your first Flow (optionally with a Quiz)
* Event and User Attributes listeners to forward UI / SDK events and User Insights to your analytics/CRM