---
title: SDK installation
excerpt: >-
  This section provides a quick overivew of the supported platform and SDK
  version naming convention
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
      slug: installation-swift
      title: Swift/Objective-C
    - type: basic
      slug: installation-kotlin
      title: Kotlin/Java
    - type: basic
      slug: installation-react-native
      title: React Native
    - type: basic
      slug: installation-flutter
      title: Flutter
    - type: basic
      slug: installation-unity
      title: Unity
    - type: basic
      slug: installation-cordova
      title: Cordova
---
# Supported Platforms

Purchasely SDK supports multiple platforms. The SDK is developed in Swift for iOS and Kotlin for Android but you can use a <<glossary:bridge sdk>> to integrate it in hybrid apps. The supported platforms are:

- iOS (Swift)
- Android (Kotlin)
- React Native
- Flutter
- Unity
- Cordova

# SDK Version Naming Convention

The Purchasely SDK follows the version naming convention `x.y.z`:

- **Major (x)**: Incremented for breaking changes.
- **Minor (y)**: Incremented for new features, compatible with the current major version.
- **Patch (z)**: Incremented for backward-compatible bug fixes.

We recommend always using the latest version within the current major version (currently <<current_major_version>>). Here are the examples of the version nomenclature for different platforms:

- **iOS (Swift, CocoaPods)**
  ```ruby Podfile
  pod 'Purchasely'
  ```
- **Android (Kotlin, Gradle)**  
  ```groovy Gradle
  implementation 'io.purchasely.core:5.+'
  ```
- **React Native**  
  ```json package.json
  "dependencies": {  
    "react-native-purchasely": "^5.0.0"  
  }
  ```
- **Flutter**
  ```yaml pubspec.yaml
  dependencies:  
    purchasely: ^5.0.0
  ```
- **Unity**  
  ```xml
  <dependency>  
    <groupId>io.purchasely</groupId>  
    <artifactId>unity</artifactId>  
    <version>[4.0,4.999]</version>  
  </dependency>
  ```
- **Cordova**  
  ```json package.json
  "dependencies": {  
    "cordova-plugin-purchasely": "^4.0.0"  
  }
  ```

By following this convention, you ensure that you always have the latest updates and bug fixes compatible with the current major version.

<br />

# SDK Installation guides

You can find the detailed installation guides for each platform via the following links:

- **iOS (Swift)**: [iOS SDK Documentation](installation-swift)
- **Android (Kotlin)**: [Android SDK Documentation](installation-kotlin)
- **React Native**: [React Native SDK Documentation](installation-react-native)
- **Flutter**: [Flutter SDK Documentation](installation-flutter)
- **Unity**: [Unity SDK Documentation](installation-unity)
- **Cordova**: [Cordova SDK Documentation](installation-cordova)