# Purchasely Documentation - Claude Context

## About This Repository

This repository contains the markdown documentation for **Purchasely** (https://www.purchasely.com), hosted at https://docs.purchasely.com using the ReadMe platform (https://readme.com).

---

## What is Purchasely?

Purchasely is a **SaaS platform empowering subscription apps**. It helps mobile organizations:

1. **Streamline subscription integration** with major app stores (Apple App Store, Google Play Store, Huawei AppGallery, Amazon App Store) and web payments (Stripe)
2. **Run no-code growth experiments** without developer involvement or app updates (paywall builder, A/B tests, audience targeting)
3. **Measure and optimize** conversion, engagement, and retention KPIs

### Core Components

1. **Mobile SDK** - Available in Swift, Kotlin, Objective-C, Java, React Native, Flutter, Cordova, and Unity
2. **Cloud Backend** - Subscription infrastructure for transaction processing and entitlement management
3. **Web Console** - Design user journeys, build paywalls, run campaigns, and access analytics

---

## Repository Structure

```
Documentation/
├── docs/                    # Main documentation pages
│   ├── 👀 OVERVIEW/         # Platform introduction
│   ├── 🚀 Getting Started/  # SDK setup and configuration
│   ├── 📱 Screens & Paywalls/  # Paywall builder documentation
│   ├── 📈 Growth guidances/ # A/B tests, audiences, campaigns
│   ├── 👤 Users/            # User management
│   ├── 📊 Analytics & Dashboards/  # Events and dashboards
│   ├── 🔌 Integrations/     # Third-party integrations
│   ├── ✈️ GOING FURTHER/    # Advanced features
│   └── ARCHIVES/            # Deprecated documentation
├── custom_blocks/           # Reusable content blocks (MDX)
├── custom_pages/            # Special custom pages
├── recipes/                 # Implementation recipes
└── reference/               # API reference and ReadMe config
```

---

## SDK Overview

### Supported Platforms

| Platform | Language | Package |
|----------|----------|---------|
| iOS | Swift/Objective-C | `pod 'Purchasely'` or SPM |
| Android | Kotlin/Java | `io.purchasely:core` (Maven) |
| React Native | JavaScript/TypeScript | `react-native-purchasely` (npm) |
| Flutter | Dart | `purchasely_flutter` (pub.dev) |
| Unity | C# | `io.purchasely:unity` |
| Cordova | JavaScript | `cordova-plugin-purchasely` |

### SDK Version Naming

Format: `x.y.z`
- **Major (x)**: Breaking changes
- **Minor (y)**: New features (backward compatible)
- **Patch (z)**: Bug fixes

Current major version: **5.x**

### Minimum Requirements

- **iOS**: Check `{user.sdk_ios_minimum_version}` in docs
- **Android**: minSdkVersion 23, compileSdkVersion 34, Kotlin 2.+, Gradle 8.+

---

## Running Modes

Purchasely offers two distinct modes:

### 1. Full Mode (Default)
- Purchasely handles **entire purchase flow**
- Validates and acknowledges receipts with app stores
- Manages user entitlements
- Best for: New apps or those wanting a complete subscription infrastructure

### 2. PaywallObserver Mode
- Works alongside **existing subscription infrastructure** (RevenueCat, in-house, etc.)
- Transactions observed but not processed by Purchasely
- Access to all no-code growth features
- Best for: Apps with established IAP systems wanting growth tools

Switch modes via `runningMode` parameter in `Purchasely.start()`

---

## Key Concepts

### Placements
A **Placement** represents a specific location in the user journey (Onboarding, Settings, Home, etc.). Benefits:
- Change associated Screen without app update
- Map different Audiences to different experiences
- Prioritize when placements overlap

### Screens & Paywalls
Built with the **Screen Composer** (requires SDK 5.0.0+):
- Drag-and-drop components
- Multiple layouts (Fill height, Scroll, Sticky button, Tabs, Carousel, etc.)
- Dark mode support
- Localization support
- Custom fonts

### Offerings
Define what products/subscriptions are available on a paywall:
- Link to Plans configured in Console
- Optional Promotional Offers
- Automatic eligibility handling for intro vs promo offers

### Entitlements
Two ways to manage:
1. **Backend Entitlements** - Use webhook events (ACTIVATE/DEACTIVATE)
2. **SDK Entitlements** - Query subscription status directly from SDK

---

## Server Events

### Event Categories

1. **Entitlement Events**: `ACTIVATE`, `DEACTIVATE`
2. **Lifecycle Events**: 27 events mapping subscription lifecycle (started, renewed, terminated, etc.)
3. **Offer Events**: 12 events for trials, intro offers, promo codes
4. **Transactional Event**: `TRANSACTION_PROCESSED` (revenue tracking)

### UI/SDK Events
- `PRESENTATION_VIEWED`
- Various UI interaction events

---

## A/B Testing

### How It Works
- Cohort assignment via MD5 hash of user ID
- `user_bucket_value` (0-99) determines variant
- Consistent experience per user
- Bayesian statistical significance calculation

### Best Practices
1. Define clear hypothesis
2. Be bold but don't change everything
3. Use only 2 variants per test
4. Wait for 95%+ statistical significance
5. Run for 1-2 weeks minimum

---

## Third-Party Integrations

### Attribution/MMPs
- Adjust, AppsFlyer, Branch

### Analytics
- Amplitude, Mixpanel, Google Analytics for Firebase, Piano (AT-Internet)

### Engagement/CRM
- Airship, Braze, Batch, Customer.io, Iterable, MoEngage, OneSignal, Brevo

### Other
- Firebase, Segment, Slack, RevenueCat

---

## Store Compatibility

### Apple App Store
- StoreKit 1 and StoreKit 2
- Promotional Offers
- Offer Codes

### Google Play Store
- Billing v4, v5, v6, v7
- Developer-determined offers
- Promo codes

### Other Stores
- Huawei AppGallery (HMS)
- Amazon Appstore

---

## Documentation File Format

Documentation files use **markdown with YAML frontmatter**:

```markdown
---
title: Page Title
excerpt: Brief description
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: next-page-slug
      title: Next Page Title
---

# Content here
```

### Custom Components

The documentation uses custom MDX components:
- `<Image>` - Images with border/alignment
- `<Glossary>` - Term definitions
- `<HTMLBlock>` - Raw HTML embeds
- `<Embed>` - External embeds
- Various custom blocks in `/custom_blocks/`

---

## Key Files Reference

| Purpose | Location |
|---------|----------|
| **Claude context file** | `CLAUDE.md` (this file) |
| **SDK compilation process** | `SDK_COMPILATION_PROCESS.md` |
| **Compiled Android SDK docs** | `android.md` |
| Platform overview | `docs/👀 OVERVIEW/whats-purchasely.md` |
| SDK installation | `docs/🚀 Getting Started/sdk-quick-start/sdk-installation/` |
| Running modes | `custom_blocks/UnderstandingRunningModesFullModePaywallObserverModeQuickOverviewAndBenefits.md` |
| Screen Composer | `docs/📱 Screens & Paywalls/screen-composer/` |
| A/B Testing | `docs/📈 Growth guidances/ab-tests/` |
| Server Events | `docs/📊 Analytics & Dashboards/server-events/` |
| Placements | `custom_blocks/PlacementOverview.md` |

---

## Console URLs

- **Purchasely Console**: https://console.purchasely.io
- **Screens Section**: https://console.purchasely.io/screens
- **Placements Section**: https://console.purchasely.io/placements

---

## Code Examples Location

SDK code examples are primarily in:
- `custom_blocks/SDKDisplayMethodCodeSnipped.md` - Display methods
- `custom_blocks/*SdkInstallation.md` - Installation per platform
- Individual doc files with code blocks for Swift, Kotlin, React Native, Flutter, Cordova, Unity

---

## Common Tasks

### Adding/Editing Documentation
1. Navigate to appropriate directory in `docs/`
2. Edit or create markdown file with proper frontmatter
3. Use existing custom blocks from `custom_blocks/` when available

### Updating SDK Code Examples
1. Check `custom_blocks/` for reusable snippets
2. Use language-specific code blocks: ```swift, ```kotlin, ```typescript, etc.

### Working with Custom Blocks
Custom blocks are reusable MDX components in `custom_blocks/` that can be included in documentation pages using their name as a tag, e.g., `<PlacementOverview />`

---

## SDK Compilation Process

For creating comprehensive, client-facing SDK documentation files for each platform, refer to:

**`SDK_COMPILATION_PROCESS.md`**

This document contains the complete process for compiling platform-specific SDK documentation files:

### When to Use
- Creating new platform documentation (e.g., `ios.md`, `react-native.md`, `flutter.md`)
- Updating existing platform documentation for new SDK versions
- Ensuring consistency across all platform documentation

### What It Contains
1. **Step-by-step compilation process** - How to identify and extract platform-specific content
2. **File mapping** - Source documentation files for each topic (installation, initialization, display, etc.)
3. **Code extraction patterns** - How to identify platform-specific code blocks in markdown
4. **Standard document structure** - 13-section template used across all platforms
5. **Platform-specific notes** - Unique considerations for Android, iOS, React Native, Flutter, Cordova
6. **Custom blocks reference** - Reusable content components
7. **Quality checklists** - Pre-publication verification steps
8. **Automation commands** - Grep patterns to find relevant files quickly

### Current Compiled Documentation
- ✅ **`android.md`** - Complete Android/Kotlin SDK guide (v5.x)
- ⏳ **`ios.md`** - iOS/Swift SDK guide (pending)
- ⏳ **`react-native.md`** - React Native SDK guide (pending)
- ⏳ **`flutter.md`** - Flutter SDK guide (pending)
- ⏳ **`cordova.md`** - Cordova SDK guide (pending)

### Key Source Directories for SDK Documentation
```
docs/🚀 Getting Started/sdk-quick-start/sdk-installation/
docs/Onboarding/sdk_initialisation/
docs/Onboarding/sdk_paywall_action_interceptor/
docs/Onboarding/sdk_deeplinks/
docs/📱 Screens & Paywalls/displaying-screens/
docs/✈️ GOING FURTHER/paywall-action-interceptor.md
custom_blocks/*SdkInstallation.md
```

---

## Important Notes

- SDK 5.0.0+ required for new Screen Composer features
- Legacy screens can be set as fallback for older SDK versions
- Always test paywalls on actual devices using the preview feature
- Webhook events use JSON payloads with comprehensive attributes
