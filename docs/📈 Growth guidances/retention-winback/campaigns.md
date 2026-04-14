---
title: Campaigns
excerpt: >-
  Automate the display of Screens to targeted Audiences using event triggers and
  Placements. Schedule promotions, run A/B tests, and track monetization KPIs —
  all without a single line of code.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The **Campaigns** feature lets you create powerful no-code automations that display a Purchasely [Screen](screens) to a particular [Audience](audiences) — either at a specific moment in the user journey (event trigger) or at one or more [Placements](displaying-screens-placements) inside your app.

**⚠️ The minimum SDK version required to use this feature is 5.1.0**

# Why use Campaigns?

Campaigns give you a centralized place to orchestrate **what** your users see, **who** sees it, and **when** or **where** it appears — without touching your codebase.

### Automate time-sensitive promotions

Schedule start and end dates for any commercial operation (Black Friday, seasonal sales, anniversary offers…). The campaign activates and deactivates itself automatically — no need to log into the Console at midnight.

### Centralize display rules across Placements

Before Campaigns, display rules (audience / screen pairs) were configured independently on each Placement. If you had 5 Placements showing the same offer, you had to maintain 5 separate ordered lists.

With Campaigns associated to Placements, you define the audience, the screen, and the priority **once** at the campaign level. The campaign then applies its rules to every associated Placement in a single place.

### Target the right users at the right time

Combine Campaigns with [Audiences](audiences) to build precise targeting strategies: convert free users, retain subscribers about to churn, win back lapsed customers, collect feedback through surveys, and more.

### Run A/B tests and measure impact

Each campaign comes with built-in monetization KPIs — screens displayed, unique viewers, conversions (offer, regular, OTP), and aggregated revenue — so you can evaluate performance at a glance and iterate quickly.

# How Campaigns work

For each campaign you define:

1. **WHO** — the [Audience](audiences) to target.
2. **WHEN** — an event trigger (e.g. `APP_STARTED`) with scheduling and capping parameters.
3. **WHERE** _(new)_ — one or more [Placements](displaying-screens-placements) where the campaign should appear.
4. **WHAT** — the [Screen](screens) to display, or an [A/B test](ab-tests) to run.

A campaign can use a trigger, Placements, or both at the same time, giving you full flexibility over how and where it is delivered.

> 📘 **Trigger vs. Placement behavior**
>
> * **Trigger-based** delivery fires when the configured event occurs (e.g. `APP_STARTED`). Capping rules (frequency cap, impression cap, exposure window) apply only to trigger-based delivery.
> * **Placement-based** delivery shows the campaign every time the associated Placement is called by your app. Capping rules do **not** apply to Placement-based delivery.

# What's next?

| Page                                                    | Description                                                                                                                               |
| :------------------------------------------------------ | :---------------------------------------------------------------------------------------------------------------------------------------- |
| [Campaign configuration](campaign-configuration)        | Step-by-step guide to setting up a campaign: audience, triggers, placements, scheduling, capping, screens, A/B tests, and prioritization. |
| [Campaign SDK implementation](campaigns-implementation) | What you need to do in your app code to allow campaigns to display.                                                                       |
| [Campaign use cases](campaigns-use-cases)               | Ready-made examples: conversion offers, retention strategies, win-back flows, surveys, and more.                                          |
