---
title: BYOS - Configuration guide
deprecated: false
hidden: true
metadata:
  robots: index
---
# Creating a Bring Your Own Screen

<br />

<br />

<br />

## Using BYOS Within a Flow

BYOS allows you to blend native app screens and Purchasely-generated screens into one seamless user journey.

1. Insert your BYOS node anywhere in a Flow via the Console (it can even be in the first position)
2. It behaves like any other step: you can set entry/exit transitions, tracking, and analytics.
3. All events (viewed, closed, next) are automatically logged by the SDK.
4. Each connection leads to the appropriate next screen or action, as defined in the Flow graph.

Using BYOS Within a Paywall A/B Test

You can also include BYOS nodes inside paywall experiments to test different entry paths or onboarding variants:

Define the BYOS step within each test variant.

Use the same analytics logic — events from custom screens are tracked once the Flow resumes.

Measure the impact of your native step (e.g., a custom login, survey, or tutorial) on conversion, engagement, or retention.

BYOS ensures A/B tests remain consistent across both Purchasely-rendered and app-rendered experiences.
