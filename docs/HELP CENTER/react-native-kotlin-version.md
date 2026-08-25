---
title: React Native — Kotlin version required by SDK 6
excerpt: Android build fails with "incompatible version of Kotlin" after the v6 upgrade
deprecated: false
hidden: false
metadata:
  robots: index
---
<Callout icon="far fa-info" theme="info">
  ### Applies to React Native SDK 6.0.x on Android

  This article applies to **both** bare React Native projects and Expo projects. It is not specific to Expo.
</Callout>

## Symptoms

The Android build fails after the upgrade to `react-native-purchasely` 6.0.x. The Kotlin compiler stops with this error:

```text
e: kotlin-stdlib-2.3.21.jar!/META-INF/kotlin-stdlib.kotlin_module
   Module was compiled with an incompatible version of Kotlin.
   The binary version of its metadata is 2.3.0, expected version is 2.1.0.
e: Unresolved reference 'ArrayList'.
e: Unresolved reference 'HashMap'.
```

The error can also name `kotlinx-serialization-core` or `kotlinx-serialization-json`. The iOS build is not affected.

***

## Who is affected

Every React Native project that compiles with **Kotlin 2.1.x or lower**. This is the default of the current templates:

| Project type                                       | Default Kotlin version | Result with SDK 6.0.x |
| -------------------------------------------------- | ---------------------- | --------------------- |
| Bare React Native 0.83 / 0.86 (community template) | 2.1.20                 | Build fails           |
| Expo SDK 54 / 55 (no `kotlinVersion` set)          | 2.0.21                 | Build fails           |
| Any project set to 2.2.x                           | 2.2.0 and later        | Build succeeds        |

<Callout icon="⚠️" theme="warn">
  ### Kotlin 2.2.x is sufficient

  Do **not** move the project to Kotlin 2.3.x. Kotlin 2.2.x is sufficient, and 2.3.x breaks several React Native and Expo modules that are locked to an earlier line.
</Callout>

***

## Root cause

Purchasely Android SDK compiles against `kotlin-stdlib:2.3.21` even when it asks for an earlier version.

A Kotlin compiler reads metadata up to **one minor version ahead** of itself. The compiler states the limit in its own message: _"the compiler version 2.1.0 can read versions up to 2.2.0"_. A 2.1.x compiler therefore rejects metadata 2.3.0, and a 2.2.x compiler accepts it.

<Callout icon="far fa-lightbulb" theme="info">
  A dependency with newer metadata breaks the build even when the code does not use it. The compiler scans the `META-INF/*.kotlin_module` entry of every archive on the classpath.
</Callout>

***

## Fix for a bare React Native project

Open `android/build.gradle` and make **two** changes.

**1. Set the Kotlin version.**

```gradle
buildscript {
    ext {
        // …
        kotlinVersion = "2.2.20"
    }
```

**2. Put that version on the Kotlin Gradle Plugin.**

The template declares the plugin without a version. React Native's own Gradle plugin then supplies 2.1.20, and step 1 alone has no effect on the compiler. Add the version:

```gradle
    dependencies {
        classpath("com.android.tools.build:gradle")
        classpath("com.facebook.react:react-native-gradle-plugin")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:${kotlinVersion}")
    }
}
```

Then clean and build:

```bash
cd android && ./gradlew clean && cd ..
npx react-native run-android
```

***

## Fix for an Expo project

An Expo project has no `android/build.gradle` under version control, so apply the same two changes through the configuration.

**1. Set the Kotlin version with&#x20;**`expo-build-properties`**.**

```json
{
  "expo": {
    "plugins": [
      [
        "expo-build-properties",
        {
          "android": {
            "kotlinVersion": "2.2.20"
          }
        }
      ]
    ]
  }
}
```

<Callout icon="⚠️" theme="warn">
  ### Filtered kotlin versions on Expo

  Use a Kotlin version that the Expo KSP table accepts: `2.2.20`, `2.2.10`, `2.2.0`, `2.1.21`, `2.1.20`, `2.0.21`. Expo stops the build on any other version with the message `Can't find KSP version for Kotlin version …`. Of these, only the 2.2.x versions solve the problem.
</Callout>

**2. Pin the Kotlin Gradle Plugin with a config plugin.**

`android.kotlinVersion` moves KSP and the Expo modules, but it does not move the Kotlin Gradle Plugin. Create `plugins/withKotlinGradlePluginVersion.js`:

```js
const { withProjectBuildGradle } = require('expo/config-plugins');

module.exports = function withKotlinGradlePluginVersion(config) {
  return withProjectBuildGradle(config, (cfg) => {
    const classpath = "classpath('org.jetbrains.kotlin:kotlin-gradle-plugin')";
    if (!cfg.modResults.contents.includes(classpath)) return cfg;
    cfg.modResults.contents = cfg.modResults.contents
      .replace(
        'buildscript {',
        "buildscript {\n  ext.kotlinVersion = findProperty('android.kotlinVersion') ?: '2.0.21'"
      )
      .replace(
        classpath,
        'classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")'
      );
    return cfg;
  });
};
```

Register it after `expo-build-properties` in `app.json`:

```json
"plugins": [
  ["expo-build-properties", { "android": { "kotlinVersion": "2.2.20" } }],
  "./plugins/withKotlinGradlePluginVersion"
]
```

Then regenerate the Android project:

```bash
npx expo prebuild --platform android --clean
npx expo run:android
```

***

## If a third-party module fails on Kotlin 2.2

The Kotlin 2.2 compiler refuses some constructions that 2.1 accepted. `react-native-gesture-handler` 2.30.0 is one example:

```text
e: RNGestureHandlerModule.kt:173:53 Function invocation 'getRootViewTag()' expected.
```

This is a different problem from the one above, and it has a simple answer. The **compiler version** and the **language version** are independent:

- the metadata that the build can read follows the **compiler version**;
- the constructions that the sources may use follow the **language version**.

Keep the compiler on 2.2.x and compile the modules at language version 2.1. Add this block to the root `android/build.gradle`, after the `apply plugin` lines:

```gradle
subprojects { subproject ->
  subproject.plugins.withId('org.jetbrains.kotlin.android') {
    subproject.tasks.withType(org.jetbrains.kotlin.gradle.tasks.KotlinCompile).configureEach {
      compilerOptions {
        languageVersion.set(org.jetbrains.kotlin.gradle.dsl.KotlinVersion.KOTLIN_2_1)
      }
    }
  }
}
```

On an Expo project, append the same block from the config plugin above.

***

## What not to do

- **Do not force&#x20;**`kotlin-stdlib`**&#x20;or&#x20;**`kotlinx-serialization-json`**&#x20;to an earlier version.** The Purchasely artifacts are built and tested against those versions. An earlier runtime can fail at purchase time with `NoSuchMethodError`.

***

## Reference project

A working Expo project that carries every fix in this article is available in the SDK repository. It uses Expo SDK 55, React Native 0.83, the New Architecture, `react-native-purchasely` 6.0.0, `react-native-gesture-handler` and `react-native-true-sheet`.

👉 [test-projects/expo-purchasely-test](https://github.com/Purchasely/Purchasely-ReactNative/tree/main/test-projects/expo-purchasely-test)
