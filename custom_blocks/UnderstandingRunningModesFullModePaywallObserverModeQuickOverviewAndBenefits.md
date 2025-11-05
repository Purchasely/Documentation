---
name: >-
  Understanding running modes | full mode & paywallObserver mode quick overview
  and benefits
---
# Understanding running modes

Purchasely offers two distinct running modes to accommodate different app development needs:

- `full` mode (default): Purchasely managed the in-app transactions
- `paywallObserver` mode: the in-app transaction are managed by your existing system (either in-house or using a 3rd party solution such as RevenueCat)

In both modes, the same [no-code growth features are available](main-features).

By choosing the appropriate running mode, you can tailor Purchasely SDK to fit your application's specific needs.

You can switch between these modes at any time by updating the parameter `runningMode` passed to [`Purchasely.start()`](sdk-setup) during the SDK initialization process with the values `full` or `paywallObserver`

<br />

# `paywallObserver` Mode

The `paywallObserver` mode is designed for applications that already have a subscription infrastructure in place and prefer not to alter it. By implementing the Purchasely SDK in `paywallObserver` mode, you can use the same set of no-code growth features without needing to migrate your existing subscription management system.

This mode is recommended for:

- Applications that have an established in-app purchase system and wish to swiftly grow their revenue by leveraging purchasely's no-code growth features without undergoing a full migration.

## When to use the `paywallObserver` mode?

This mode is perfect to use Purchasely data and Purchasely paywalls without changing your existing subscription infrastructure.

You can use this mode if you want to:

- use Purchasely remotely modifiable paywalls and screens
- benefit of our unified data set of subscription events to get a better understanding of your subscribers' lifecycle
- fuel your marketing tools with these events and create no-code automations
- all this without changing your legacy transaction processor / backend

## Key benefits

- run in-app monetization campaigns and optimization strategies 10x faster
- empower growth and marketing teams and make them autonomous in building in-app funnels in no-code and publishing them instantly, without depending on the developers or requiring an app update
- free developers' bandwidth and have them focus on the product itself, rather than on the marketing funnels
- run experiments safely and remain compliant with the App stores guidelines thanks to the built-in paywall verifications

This can be achieved that by leveraging the no-code features of the Purchasely Platform:

- No-code Native Paywall & In-App Screen Builder: Easily create and customize your app's paywalls and in-app screens without writing any code.
- A/B Testing: Test different paywall designs and strategies to optimize conversion rates.
- Audience Targeting: Deliver personalized content and offers based on user behavior and demographics.
- Campaign Automations: Automate marketing campaigns to engage users at the right time with the right offers and convert them to loyal subscribers, retain churning subscribers and win-back lapsed subscribers.
- 3rd Party Integrations: Enhance your app with a variety of third-party tools and services for analytics, marketing, and more.

[For more details on how the paywallObserver mode works click here](paywallobserver-mode)

<br />

# `full` mode

In `full` mode, Purchasely takes charge of the entire purchase process. It combines both the subscription infrastructure and the no-code growth features.

This includes **handling the purchase flow, validating, and acknowledging receipts** directly with the app stores and updating the users entitlements. 

### When to use the `full` mode?

In the `full` mode, Purchasely handles transactions, analytics and paywall display.

Most of Purchasely customers use this mode because it allows to take benefit of all powerful features from Purchasely.

This mode is highly recommended for:

- Applications that are new to implementing in-app purchases to avoid developers to:
  - code an in-house transaction processor and build their own subscription infrastructure
  - manage the subscribers lifecycle and develop store-specific code to plug with the app stores (3 to 6 months of work in average)
  - waste time on developing the paywall(s)
- Developers looking to benefit from Purchasely's comprehensive and thoroughly tested platform for managing their in-app purchases.

By choosing this mode, teams will be able to use in-app purchases as a convenience and as such, focus on developing their core product and features.

### Key Benefits

**Benefits for the overall organization:**

- Simplified Management: Automate the purchase process, from presentation to receipt validation and managing entitlements
- Reliability: Leverage a platform tested across various scenarios and app stores.
- Ease of Use: Ideal for new applications or those looking to upgrade their purchase management system without extensive development effort.

**Benefits for developers teams:**

- no need to develop the transaction management system and the interface with the different App stores
- no DevOps required to deploy, monitor and scale a robust subscription infrastructure - the Purchasely platform plays this role
- no more maintenance nor update of the code  when new versions of the libraries are released each year by the App stores  
  (eg: Google Billing v5 -> v6 -> v7 for the Play Store or StoreKit 1 -> StoreKit 2 for the App Store)
- no need to manually implement advanced features and new features released by the App stores  
  (eg: promotional offers to leverage retention)

**Benefits for the marketing, product & growth teams:**

- run in-app monetization campaigns and optimization strategies 10x faster
- empower growth and marketing teams and make them autonomous in building in-app funnels in no-code and publishing them instantly, without depending on the developers or requiring an app update
- free developers' bandwidth and have them focus on the product itself, rather than on the marketing funnels
- run experiments safely and remain compliant with the App stores guidelines thanks to the built-in paywall verifications

This can be achieved that by leveraging the no-code features of the Purchasely Platform:

- No-code Native Paywall & In-App Screen Builder: Easily create and customize your app's paywalls and in-app screens without writing any code.
- A/B Testing: Test different paywall designs and strategies to optimize conversion rates.
- Audience Targeting: Deliver personalized content and offers based on user behavior and demographics.
- Campaign Automations: Automate marketing campaigns to engage users at the right time with the right offers and convert them to loyal subscribers, retain churning subscribers and win-back lapsed subscribers.
- 3rd Party Integrations: Enhance your app with a variety of third-party tools and services for analytics, marketing, and more.

[For more details on how the full mode works here](full-mode)