---
title: Main features
excerpt: This section describes the main features of the Purchasely Platform
deprecated: false
hidden: false
metadata:
  robots: index
next:
  description: Get the overview of the advantages associated with the Purchasely Platform
  pages:
    - slug: purchasely-advantages
      title: Purchasely advantages
      type: basic
---
Purchasely helps mobile teams build, personalize, automate, and measure native in-app experiences—and, for subscription apps, also provides a full monetization layer (stores, transactions, entitlements, offers).

# Features available to all apps

### In-App Experience builder (Screens)

Create and iterate on native Screens in no-code with the [Screen Composer](screen-composer) (including surveys and Quizzes).

### Display & In-App orchestration (Placements, priorities, deeplinks)

Deliver the right In-App Experience at the right time by associating content to [Placements](placements), mapping different Audiences to different experiences, and managing overlaps with priorities—all without an app release.

### Personalized journeys (Flows)

Build multi-step [Flows](flows) to guide users through onboarding, activation, feature discovery, and engagement paths. Flows can branch dynamically based on user insights and conditions.

You can also use [Conditional Visibility](conditional-visibility) to show or hide components within each Screen (inside a Flow) based on user data or Screen interactions, for deeper personalization without duplicating Screens.

### User insights (Quizzes)

Collect structured user insights (preferences, motivations, feedback) through [Quizzes](quizzes) embedded in Screens, then:

* visualize results in the Console,
* leverage answers to personalize experiences.

### Audience targeting & personalization rules

Create [Audiences](audiences) using built-in and custom user attributes to:

* target specific segments,
* personalize which experience is shown,
* support automation.

### A/B tests

Purchasely can randomize users into variants and keep assignments consistent across sessions, letting you target a specific user segment and expose them to different In-App Experiences. 

Experiment outcome should be measured in your own analytics stack (e.g., Amplitude), based on the KPIs that matter for your app (activation, engagement, retention).

### No-code automations (Campaigns)

Use [Campaigns](campaigns) to automatically display a specific Screen to a specific Audience at app start, with capping controls. Campaigns are commonly used for:

* onboarding and activation pushes,
* surveys / user research,
* targeted re-engagement.

### Integrations & event forwarding (analytics / CRM)

Connect Purchasely-generated [UI/SDK events](ui-sdk-events) to your analytics or CRM stack by implementing SDK listeners/delegates, enabling consistent tracking of user journeys and actions.

# Features specific to subscription apps

### Subscription infrastructure

Purchasely can act as your subscription infrastructure (depending on running mode), including store integrations, transaction processing, and entitlement lifecycle management

* **Webhook for entitlements and subscription lifecycle**

  The Purchasely Platform manages the entire subscriber lifecycles and generates a comprehensive and universal set of events for all the stores. These events can be automatically forwarded to your backend using a realtime webhook.

  This avoids the long and painful process of managing entitlements & implementing S2S notifications with each store by yourself.
* **3rd party integrations for subscription lifecycle**

  The Purchasely Platform can be natively integrated with 20 different 3rd-party platforms:

  * MMPs: Adjust, Appsflyer, Branch
  * Analytics: Amplitude, Clevertap, Google Analytics for Firebase, Mixpanel, mParticle, Piano (ex AT-Internet)
  * Mobile Engagement Platforms: Airship, Braze, Batch, Clevertap, Customer.io, Iterable, MoEngage, One Signal, Brevo (ex Sendinblue)
  * and other platforms such as Firebase, Segment, Slack

### Subscription and In-App Purchases dashboards (analyze your subscription business)

Purchasely includes dedicated Console Dashboards to monitor and analyze your subscription business end-to-end, including:

* Live snapshot of your subscriber base and lifecycle events,
* Conversion analysis across paywalls, countries, offers, and segments,
* Subscriptions and One-Time Purchases performance,
* MRR and Cohorts to track recurring revenue and retention over time,
* Trials and Promotional Offers to assess offer performance and conversion dynamics.

### Products, offers, and subscription lifecycle tooling

Subscription apps can leverage Purchasely capabilities for:

* store configuration and subscription catalogue management,
* retention / win-back mechanics via promotional offers.

### A/B tests

Purchasely includes built-in [A/B tests](ab-tests) for UI and price experiments, designed to optimize in-app purchase performance. In the current state, A/B tests are limited to subscription apps because results are measured on IAP KPIs.

<br />
