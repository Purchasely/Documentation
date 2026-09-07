---
title: SDK installation
excerpt: >-
  This section provides a quick overivew of the supported platform and SDK
  version naming convention
deprecated: false
hidden: false
metadata:
  robots: index
next:
  pages:
    - slug: installation-swift
      title: Swift/Objective-C
      type: basic
    - slug: installation-kotlin
      title: Kotlin/Java
      type: basic
    - slug: installation-react-native
      title: React Native
      type: basic
    - slug: installation-flutter
      title: Flutter
      type: basic
    - slug: installation-cordova
      title: Cordova
      type: basic
---
# Supported Platforms

Purchasely SDK supports multiple platforms. The SDK is developed in Swift for iOS and Kotlin for Android but you can use a <Glossary>bridge sdk</Glossary> to integrate it in hybrid apps. The supported platforms are:

* iOS (Swift)
* Android (Kotlin)
* React Native
* Flutter
* Cordova

# SDK Version Naming Convention

The Purchasely SDK follows the version naming convention `x.y.z`:

* **Major (x)**: Incremented for breaking changes.
* **Minor (y)**: Incremented for new features, compatible with the current major version.
* **Patch (z)**: Incremented for backward-compatible bug fixes.

The latest version is **6.1.0** on every platform. Pin that exact version, and do not use a floating range. Here is the pin for each platform:

* **iOS (Swift, CocoaPods)**
  ```ruby Podfile
  pod 'Purchasely', '6.1.0'
  ```
* **Android (Kotlin, Gradle)**  
  ```groovy Gradle
  implementation 'io.purchasely:core:6.1.0'
  ```
* **React Native**  
  ```json package.json
  "dependencies": {  
    "react-native-purchasely": "6.1.0"  
  }
  ```
* **Flutter**
  ```yaml pubspec.yaml
  dependencies:  
    purchasely_flutter: 6.1.0
  ```
* **Cordova**  
  ```json package.json
  "dependencies": {  
    "@purchasely/cordova-plugin-purchasely": "6.1.0"  
  }
  ```

Every Purchasely dependency of one app must carry the same version.

<br />

# SDK Installation guides

You can find the detailed installation guides for each platform via the following links:

* **iOS (Swift)**: [iOS SDK Documentation](installation-swift)
* **Android (Kotlin)**: [Android SDK Documentation](installation-kotlin)
* **React Native**: [React Native SDK Documentation](installation-react-native)
* **Flutter**: [Flutter SDK Documentation](installation-flutter)
* **Cordova**: [Cordova SDK Documentation](installation-cordova)
