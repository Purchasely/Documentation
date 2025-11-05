---
title: Purchasely advantages
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
# Why Purchasely?

Our founders are all engineers having experienced the complex relationships and dependencies between marketing product and tech.

Marketing teams have hundred of ideas to implement that could lead to some growth.  
They can do some A/B testing but the more mature the product the more likely the variations won't beat the original. There is nothing more frustrating for developers to trash something 2 weeks after its development especially when it took the same time to develop it. This increases the communication issues between teams.

<br />

Marketers are right

- Marketers will always need to test
- 80% of the time, variants fail to beat the original
- The winning test can have a huge impact on revenues like [Tomtom](https://www.purchasely.com/case-study-tomtom-experiment-based-app-growth) who increased their revenues by 85%

<br />

Developers are right

- It is not efficient to spend so much time for something that will be trashed 80% of the time
- You cannot do quick and dirty with paywalls, breaking analytics, or worst, purchase flow can have harmful consequences
- These numerous requests are distracting them from their real job
- Implementing each of these tactics everywhere in the code often leads to a gigantic mess up

<br />

Purchasely is here to solve that situation by allowing marketers and growth teams to experiments in no-code and create automations without depending on their developers.

<br />

# A solution with no downside

The technology you are about to implement is **the technology we would have loved to integrate**.

Our SDK is:

- **Super lightweight**: Less than <<sdk_ios_size>> on iOS and less than <<sdk_android_size>> on Android
- **Native**: developed in **Swift** and **Kotlin**, relies on core OS technologies to provide the best possible experience (dark mode, haptic feedback, localization, support for all devices and orientations…).
- **Always up to date**: We implement the latest StoreKit and Play Store features so that you don't to bother with that. This opens up your marketing team to a lot of new possibilities.  
- **Backward compatible**:
  - We will never force you to update it and never did. Each time we introduce a new feature we first consider the impact on prior SDK versions. We still have users of our customers running versions released more than 3 years ago.
  - We can add new screens and templates without requiring you to update the SDK.
  - We support OS down to <<sdk_ios_minimum_version>> on iOS and <<sdk_android_minimum_version>> on Android.
- **Performant**: We cache data on device, we use local ressources and CDN network to initialise our payment stack and display paywalls almost as fast as your local home made paywalls. Proof is we have never failed an A/A test against one of those.
- **Resources efficient**: We cache some data in memory and some other on device based on their nature. We react on both memory and disk usage limits to free the most that we can. We group some network calls and trigger some of them later if they are not critical.
- **Conscious about privacy**: Every possible computation is made on device to keep the data private. The SDK has an anonymous mode, can be used with a based userId and is compliant with kids privacy regulations. As this was made in Europe we are respecting the most restricting regulations from day-1 (GDPR).
- **Heavily tested**: Unit, integration and UI tests are everywhere to make sure everything works in the countless possible configurations.

<br />

Beyond the SDK, our platform is:

- **Efficient**: We save a huge amount of time in development and numerous App Store deployments
- **Robust**: Handling more than <<platform_requests_monthly>> requests per month.
- **Responsive**: with a very high cache hit ratio and CDNs located in more than 300 locations the responses are often provided by an infrastructure in your users' neighbourhood.
- **Always up to date** with latest dependencies, CVRs …
- **Heavily tested**: Unit and integration tests with above 90%+ test coverage.
- **Compliant** with GDPR, COPPA, CCPA and we are [SOC 2 certified](https://www.purchasely.com/security).