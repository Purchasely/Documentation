# SDK Documentation Compilation Process

This document describes the process for creating comprehensive, client-facing SDK documentation files for each platform (Android, iOS, React Native, Flutter, Cordova).

---

## Overview

The goal is to compile all scattered documentation into a single, comprehensive file per platform that clients can use as a standalone integration guide.

---

## Target version & sources of truth (v6)

The compiled docs target **SDK 6.0.0-rc.1**. When compiling or re-compiling, verify every API name, signature, enum case and default against the authoritative sources — **do not guess or rely on the scattered docs alone**:

| Platform | Migration guide (authoritative) | SDK source to grep |
|----------|---------------------------------|--------------------|
| iOS | `../iOS/MIGRATION-6.0.0.md` | `../iOS/Purchasely/Classes/` (confirm a method is `public`, not `internal`/removed) |
| Android | `../Android/MIGRATION_V6.md` | `../Android/core/src/main/java/io/purchasely/` |

Also see the client-facing migration guides under `docs/➡️ MIGRATING TO PURCHASELY/migrating-from-sdk-5-to-6/`.

> **Major v6 change — default running mode is now Observer.** Every compiled doc's Initialization section MUST state this and show how to set Full explicitly (iOS `.runningMode(.full)`, Android `.runningMode(PLYRunningMode.Full)`) for Purchasely to handle and validate purchases.

> **Objective-C & Java are no longer documented.** The iOS doc contains **Swift only**; the Android doc contains **Kotlin only**. The languages are still supported by the SDK — we just no longer publish their snippets.

To re-compile after a version bump, pass `--force` to the script (otherwise an existing `platform/<platform>.md` is left untouched):
```bash
./compilation/compile_sdk_docs.sh ios --force
./compilation/compile_sdk_docs.sh all --force
```

---

## Step-by-Step Process

### Step 1: Identify All Relevant Documentation Files

Search for platform-specific documentation files using these patterns:

```bash
# For each platform, search for files containing platform-specific code
```

| Platform | Search Terms | File Patterns |
|----------|--------------|---------------|
| Android/Kotlin | `kotlin`, `android`, `Kotlin`, `GoogleStore` | `*kotlin*.md`, `*android*.md` |
| iOS/Swift | `swift`, `Swift`, `iOS`, `UIKit` | `*swift*.md`, `*ios*.md` |
| React Native | `react-native`, `ReactNative`, `React Native` | `*react*.md`, `*rn*.md` |
| Flutter | `flutter`, `Flutter`, `dart` | `*flutter*.md` |
| Cordova | `cordova`, `Cordova` | `*cordova*.md` |

**Key directories to search:**

```
docs/🚀 Getting Started/sdk-quick-start/
docs/Onboarding/
docs/📱 Screens & Paywalls/
docs/✈️ GOING FURTHER/
docs/👤 Users/
docs/📈 Growth guidances/
custom_blocks/
```

### Step 2: Read Core Documentation Files

Read these files in order, extracting platform-specific code:

#### 2.1 Installation
- `docs/🚀 Getting Started/sdk-quick-start/sdk-installation/installation-{platform}.md`
- `docs/Onboarding/onboarding-sdk-installation/sdk_install_{platform}.md`
- `custom_blocks/{Platform}SdkInstallation.md` (e.g., `AndroidSdkInstallation.md`, `iOSSdkInstallation.md`)

#### 2.2 SDK Initialization
- `docs/🚀 Getting Started/sdk-quick-start/sdk-initialization.md`
- `docs/Onboarding/sdk_initialisation/sdk_initialisation_{platform}.md`
- `docs/Onboarding/sdk_initialisation/sdk_initialisation_{platform}_observer.md`

#### 2.3 Displaying Screens/Paywalls
- `docs/🚀 Getting Started/sdk-quick-start/screens-display.md`
- `docs/📱 Screens & Paywalls/displaying-screens/displaying-screens-placements.md`
- `docs/📱 Screens & Paywalls/displaying-screens/displaying-screens.md`
- `docs/📱 Screens & Paywalls/displaying-screens/pre-fetching.md`

#### 2.4 Processing Transactions
- `docs/🚀 Getting Started/sdk-quick-start/processing-transactions/process-transactions-full-mode.md`
- `docs/🚀 Getting Started/sdk-quick-start/processing-transactions/process-transactions-observer-mode.md`

#### 2.5 Paywall Action Interceptor
- `docs/✈️ GOING FURTHER/paywall-action-interceptor.md`
- `docs/Onboarding/sdk_paywall_action_interceptor/sdk_paywall_action_interceptor_{platform}.md`

#### 2.6 User Management
- `docs/👤 Users/user-identification.md`
- `docs/🚀 Getting Started/sdk-quick-start/entitlements-management/subscription-status.md`

#### 2.7 Custom User Attributes
- `docs/📈 Growth guidances/segmenting-your-user-base/custom-user-attributes.md`

#### 2.8 Event Listeners
- `docs/🚀 Getting Started/sdk-quick-start/listener-delegate.md`

#### 2.9 Deeplinks
- `docs/Onboarding/sdk_deeplinks/sdk_deeplinks_{platform}.md`
- `docs/🚀 Getting Started/sdk-quick-start/deeplinks-management.md`

### Step 3: Extract Platform-Specific Code Blocks

In each documentation file, code blocks are marked with language identifiers:

```markdown
```swift Swift
// iOS code here
```
```kotlin Kotlin
// Android code here
```
```typescript React Native
// React Native code here
```
```typescript Flutter
// Flutter code here
```
```javascript Cordova
// Cordova code here
```
```

**Extract only the code blocks relevant to the target platform.**

### Step 4: Compile Into Standard Structure

Use this standard structure for all platform documentation:

```markdown
# Purchasely {Platform} SDK Documentation

## Table of Contents
1. Requirements
2. Installation
3. SDK Initialization
4. Displaying Paywalls
5. Processing Transactions
6. Paywall Action Interceptor
7. User Identification
8. Subscription Status & Entitlements
9. Custom User Attributes
10. Event Listeners
11. Pre-fetching Screens
12. Deeplinks Management
13. Platform-Specific Features (if applicable)
14. Troubleshooting
15. Additional Resources
```

---

## Platform-Specific Notes

### Android/Kotlin
- **Kotlin only** — do NOT include Java snippets (no longer documented)
- Default running mode is **Observer**; show `.runningMode(PLYRunningMode.Full)` for purchase handling
- Include alternative stores section (Huawei, Amazon)
- Presentation API: `PLYPresentation { }.preload`, `display(context) { outcome -> }`, `buildView`/`getFragment`, `onCloseRequested` (renamed from `onClose`); presentation types live in `io.purchasely.ext.presentation.*`
- Include ProGuard rules
- Dependencies: `io.purchasely:core`, `io.purchasely:google-play`, `io.purchasely:player` (version **6.0.0-rc.1**); Gradle 9.3.0+, Kotlin 2.2.x, JDK 11, minSdk 23, compileSdk 35

### iOS/Swift
- **Swift only** — do NOT include Objective-C snippets (no longer documented)
- Default running mode is **`.observer`**; show `.runningMode(.full)` for purchase handling
- Initialization uses the fluent builder `Purchasely.apiKey(…)…start { error in }` (the positional `start(withAPIKey:)` is removed); also show the async/await variant
- Presentation API: `PLYPresentationBuilder.forPlacementId/forScreenId(…).build().preload { }`; per-action `interceptAction(.x)` returning `PLYInterceptResult`; SwiftUI via `presentation.swiftUIView`, UIKit via `presentation.controller`
- Include StoreKit version selection (StoreKit 1 vs StoreKit 2)
- Include CocoaPods and SPM installation options

### React Native
- Include both npm/yarn installation
- Note iOS pod install requirement
- Include Android gradle configuration
- Mention `storeKit1` parameter for iOS
- Include `androidStores` parameter
- **CRITICAL**: Include Android Dependencies section (see below)

### Flutter
- Include pub.dev installation
- Note iOS pod install requirement
- Include Android gradle configuration
- Mention `storeKit1` parameter for iOS
- Include `androidStores` parameter
- **CRITICAL**: Include Android Dependencies section (see below)

### Cordova
- Include plugin installation command
- Note platform-specific setup for iOS and Android
- Include config.xml modifications if needed
- **CRITICAL**: Include Android Dependencies section (see below)

---

## Android Dependencies for Cross-Platform Frameworks

**IMPORTANT**: For React Native, Flutter, and Cordova SDKs, the Installation section MUST include detailed information about Android-specific dependencies. This is critical because:

1. **Purchasely Core does NOT include store implementations** - The main package only contains the SDK core functionality
2. **Google Play Billing is a SEPARATE package** - Must be explicitly installed to use Google Play Store
3. **Video Player is a SEPARATE package** - Required for paywalls containing videos on Android
4. **Version matching is MANDATORY** - All packages must be the exact same version

### Why This Matters

When developers specify `androidStores: ['Google']` in initialization, the SDK looks for the Google Play Billing implementation at runtime. If the Google dependency is not installed:
- The SDK will fail to initialize properly on Android
- Purchases will not work on Google Play Store
- The app may crash when attempting to display paywalls

### Package References by Platform

| Platform | Main Package | Google Play Billing | Android Video Player |
|----------|--------------|---------------------|----------------------|
| React Native | `react-native-purchasely` | `@purchasely/react-native-purchasely-google` | `@purchasely/react-native-purchasely-android-player` |
| Flutter | `purchasely_flutter` | `purchasely_google` | `purchasely_android_player` |
| Cordova | `@purchasely/cordova-plugin-purchasely` | `@purchasely/cordova-plugin-purchasely-google` | N/A |

### Required Documentation Pattern

For each cross-platform framework, the Installation section must include:

1. **Main Dependency Installation** - The core SDK package
2. **Android Setup Section** with:
   - Explanation that stores are NOT included by default
   - Google Play Billing subsection with installation command
   - Video Player subsection with installation command (if applicable)
   - Version matching warning with example
3. **iOS Setup Section** (if applicable) - pod install, StoreKit version
4. **Initialization Example** showing `androidStores: ['Google']` parameter

### Example Version Matching Warning

Include a note like this in each platform:

> ⚠️ **Version Matching Required**
>
> All Purchasely packages must be the **exact same version**. Mismatched versions will cause runtime errors.
>
> Example for React Native (use the matching released version for your platform):
> ```json
> "dependencies": {
>   "react-native-purchasely": "6.0.0",
>   "@purchasely/react-native-purchasely-google": "6.0.0",
>   "@purchasely/react-native-purchasely-android-player": "6.0.0"
> }
> ```

---

## Code Block Language Identifiers

When reading documentation files, look for these language identifiers to extract the correct code:

| Platform | Identifiers to INCLUDE in the compiled doc | Notes |
|----------|--------------------------------------------|-------|
| Android | `kotlin`, `Kotlin` (+ `groovy` for Gradle) | `java` / `Java` blocks are **no longer documented** — skip them |
| iOS | `swift`, `Swift` | `objectivec` / `Objective-C` blocks are **no longer documented** — skip them |
| React Native | `typescript React Native`, `javascript React Native`, `ReactNative` | |
| Flutter | `typescript Flutter`, `dart`, `Flutter` | |
| Cordova | `javascript Cordova`, `Cordova` | |

> ⚠️ Trust the **label** after the fence (e.g. `swift Swift`), not the highlighter token: some Cordova/Flutter snippets are mislabeled `swift`/`kotlin`. The label identifies the real platform.

---

## Custom Blocks Reference

The documentation uses custom blocks (React components) that contain platform-specific content. Key custom blocks to check:

| Block Name | Content |
|------------|---------|
| `AndroidSdkInstallation` | Android installation requirements and dependencies |
| `iOSSdkInstallation` | iOS installation via CocoaPods/SPM |
| `SDKInitializationAdvice` | General initialization advice |
| `StoreKitDifferentVersions` | StoreKit 1 vs 2 explanation |
| `UserType` | User identification explanation |
| `APIKey` | API key location explanation |
| `PlacementOverview` | Placement concept explanation |
| `UISDKEventsEventDelegatedEventListener` | Event listener implementation |
| `EventListenerForCustomUserAttributesImplementation` | Custom attribute listener |

Custom blocks are located in: `custom_blocks/`

---

## Checklist for Each Platform

Use this checklist when creating documentation for a new platform:

- [ ] **Requirements** - SDK version, OS version, language version
- [ ] **Installation** - Package manager commands, dependencies
- [ ] **Initialization** - Full mode and PaywallObserver mode
- [ ] **API Key** - Where to find it
- [ ] **Display Paywall** - Basic placement display
- [ ] **Handle Results** - Purchase, restore, cancel callbacks
- [ ] **Close Presentation** - Platform-specific close method
- [ ] **Paywall Action Interceptor** - All action types
- [ ] **User Login/Logout** - Authentication methods
- [ ] **User Subscriptions** - Fetch subscription status
- [ ] **Custom Attributes** - Set, get, clear, increment
- [ ] **Event Listeners** - UI events and attribute changes
- [ ] **Pre-fetching** - Fetch before display
- [ ] **Deeplinks** - Handle and enable deeplinks
- [ ] **Troubleshooting** - Debug logging, common issues

---

## Output File Location

All compiled platform documentation files are stored in the `platform/` folder:

```
platform/{platform}.md
```

Examples:
- `platform/android.md` - Android/Kotlin
- `platform/ios.md` - iOS/Swift
- `platform/react-native.md` - React Native
- `platform/flutter.md` - Flutter
- `platform/cordova.md` - Cordova

### Folder Structure

```
Documentation/
├── platform/                    # Compiled SDK documentation (output)
│   ├── android.md
│   ├── ios.md
│   ├── react-native.md
│   ├── flutter.md
│   └── cordova.md
├── compilation/                 # Compilation tooling and instructions
│   ├── SDK_COMPILATION_PROCESS.md
│   ├── compile_sdk_docs.sh
│   └── COMPILE_*_INSTRUCTION.md
├── docs/                        # Source documentation (input)
├── custom_blocks/               # Reusable content blocks (input)
└── CLAUDE.md                    # Repository context
```

---

## Automation Commands

To find all files containing code for a specific platform:

```bash
# Android/Kotlin
grep -rl "```kotlin" docs/ --include="*.md"
grep -rl "```Kotlin" docs/ --include="*.md"

# iOS/Swift
grep -rl "```swift" docs/ --include="*.md"
grep -rl "```Swift" docs/ --include="*.md"

# React Native
grep -rl "React Native" docs/ --include="*.md"

# Flutter
grep -rl "Flutter" docs/ --include="*.md"

# Cordova
grep -rl "Cordova" docs/ --include="*.md"
```

To list all custom blocks:
```bash
ls custom_blocks/
```

---

## Version Updates

When updating for a new SDK version:

1. Check the version number in installation sections
2. Verify any API changes in the changelog
3. Update code examples if methods changed
4. Update requirements if minimum versions changed
5. Add any new features introduced in the version
6. Remove deprecated methods/features

---

## Quality Checklist

Before finalizing the documentation:

- [ ] All code examples compile/are syntactically correct
- [ ] **Every API name, signature, enum case and default verified against the source of truth** (MIGRATION guide + SDK source) — not invented
- [ ] **No removed v5 identifiers remain in code** — grep the file:
  - iOS: `start(withAPIKey`, `setPaywallActionsInterceptor`, `fetchPresentation`, `presentationController`, `closeDisplayedPresentation`, `.PresentationView`, `PLYPresentationInfo`
  - Android: `setPaywallActionsInterceptor`, `fetchPresentation`, `presentationView`, `PLYPresentationProperties`, `PLYProductViewResult`, `PaywallObserver`, `readyToOpenDeeplink`, `isDeeplinkHandled`
- [ ] **No Objective-C (iOS) / Java (Android) code fences** in the output
- [ ] Initialization section states the **default running mode is now Observer** and how to set Full
- [ ] No placeholder values left (except intentional ones like `YOUR_API_KEY`)
- [ ] Consistent formatting throughout
- [ ] All sections have content
- [ ] Links to Purchasely Console are correct
- [ ] Version number is **6.0.0-rc.1**
- [ ] Table of contents matches actual sections

---

*Last updated: June 2026*
*Updated for Purchasely SDK Documentation v6.x (iOS = Swift only, Android = Kotlin only; default running mode is Observer)*
