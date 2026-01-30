---
title: Why use Purchasely?
excerpt: >-
  This section describes the advantages and technical characteristics of
  Purchasely
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Mobile teams constantly iterate on onboarding, activation, engagement, and conversion. Growth teams need to ship ideas quickly, while engineering teams need reliability, maintainability, and safe release cycles. Purchasely reduces friction between teams by letting you build and iterate on native in-app experiences in no-code, while keeping engineers in control of integration, performance, and data flows.

<br />

# Advantages for apps (in-app experiences)

### Ship faster, iterate safely

* Build and update native Screens remotely (no app update required for content changes).
* Preview and validate experiences in your app before rolling out, with eligibility conditions and real-device rendering.

### Personalize journeys without duplicating content

* Use Flows to design multi-step journeys and route users based on insights and conditions.
* Use Conditional Visibility to show/hide components within a Screen based on user data or Screen interactions (deeper personalization without cloning Screens).

### Collect user insights in-context (no-code)

* Add Quizzes to capture preferences, intent, and feedback directly in-app.
* Fetch Quiz answers in your app (to enrich your data model, CRM, or analytics).

### Connect to your analytics and CRM stack

* Listen to UI/SDK events and custom user attributes to forward user journey signals to tools like analytics and CRM platforms.
* Use audiences/segmentation to tailor which experiences are displayed.

<br />

# A solution with no downside

### SDK characteristics

Purchasely’s SDK is designed to be:

Our SDK is:

* **Super lightweight**: Less than {user.sdk_ios_size} on iOS and less than {user.sdk_android_size} on Android
* **Native**: developed in **Swift** and **Kotlin**, relies on core OS technologies to provide the best possible experience (dark mode, haptic feedback, localization, support for all devices and orientations…).
* **Always up to date**: We implement the latest StoreKit and Play Store features so that you don't have to bother with that. This opens up your marketing team to a lot of new possibilities.
* **Backward compatible** and built to avoid forcing upgrades:
  * We can add new screens and templates without requiring you to update the SDK.
  * We support OS down to {user.sdk_ios_minimum_version} on iOS and {user.sdk_android_minimum_version} on Android.
* **Performant**: We cache data on device, we use local ressources and CDN network to initialise our payment stack and display paywalls almost as fast as your local home made paywalls. Proof is we have never failed an A/A test against one of those.
* **Resources efficient**: We cache some data in memory and some other on device based on their nature. We react on both memory and disk usage limits to free the most that we can. We group some network calls and trigger some of them later if they are not critical.
* **Privaccy-conscious **: Every possible computation is made on device to keep the data private. The SDK has an anonymous mode, can be used with a based userId and is compliant with kids privacy regulations. As this was made in Europe we are respecting the most restricting regulations from day-1 (GDPR).
* **Heavily tested**: Unit, integration and UI tests are everywhere to make sure everything works in the countless possible configurations.

<br />

### Platform characteristics

Beyond the SDK, our platform is:

* **Efficient**: We save a huge amount of time in development and numerous App Store deployments
* **Robust**: Handling more than {user.platform_requests_monthly} requests per month.
* **Responsive**: with a very high cache hit ratio and CDNs located in more than 300 locations the responses are often provided by an infrastructure in your users' neighbourhood.
* **Always up to date** with latest dependencies, CVRs …
* **Heavily tested**: Unit and integration tests with above 90%+ test coverage.
* **Compliant** with GDPR, COPPA, CCPA and we are [SOC 2 certified](https://www.purchasely.com/security).
