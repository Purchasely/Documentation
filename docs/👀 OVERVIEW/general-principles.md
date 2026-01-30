---
title: General principles
excerpt: This section describes the general principles of the Purchasely Platform
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
<br />

# Components of the platform

Purchasely is composed of 3 major components:

1. **The mobile SDK** integrated in your app

   Renders Purchasely experiences natively and exposes SDK/UI events to your codebase.
2. **The Purchasely Console** (web interface)

   Configure your app, build Screens, create Flows, manage targeting/experiments, and access dashboards.
3. **The Purchasely Cloud Platform**

   Hosts your configuration and content, and powers analytics.

   For subscription apps, it can also be used as the subscription infrastructure (transactions + entitlements)

<br />

<br />

How Purchasely is used



### For apps: In-app experiences (default setup)

Apps typically start by using Purchasely to:

* build Screens (including Quizzes) and Flows in no-code,
* display them in the app (placements / deeplinks),
* track interactions through SDK/UI events and connect them to analytics/CRM.

<br />

### For subscription apps: choose a running mode

For subscription apps, Purchasely can be used in two running modes, depending on whether you want Purchasely to manage in-app transactions or not.

1. **`full` mode**

   In this mode, Purchasely manages in-app transactions and entitlements. It acts as the subscription infrastructure and avoids building your own.

   Use this mode if you:
   * start a subscription app from scratch, or
   * want to migrate your existing subscription infrastructure.
2. **`paywallObserver` mode**

   In this mode, Purchasely works on top of your existing subscription infrastructure (in-house or a third-party solution such as RevenueCat). Purchasely does not process transactions; transactions are observed by the SDK to feed dashboards.

   Use this mode if you:
   * want Purchasely Paywalls/Screens and no-code growth features,
   * without changing your current transaction processor / backend.

✅ In both modes, the same [no-code growth features](main-features) are available.

➡️ More details: [Running modes](running-modes).

<br />
