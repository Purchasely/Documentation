---
title: SDK Implementation
description: Integrate the Purchasely SDK in 4 steps (v6)
hidden: false
recipe:
  color: '#018FF4'
  icon: 🦉
---
```kotlin Android
// 1) build.gradle.kts — add the dependencies
implementation("io.purchasely:core:6.0.0-rc.1")
implementation("io.purchasely:google-play:6.0.0-rc.1")

// 2) Initialize and start the SDK (e.g. in Application.onCreate)
Purchasely {
    context(applicationContext)
    apiKey("<<X-API-KEY>>")
    stores(listOf(GoogleStore()))
    runningMode(PLYRunningMode.Full) // default is Observer in v6
    onInitialized { error -> }
}

// 3) Display the paywall configured for a placement
PLYPresentation { placementId("<<default_placement>>") }
    .preload { loaded, error -> loaded?.display(context) }

// 4) Handle the result via a default handler
Purchasely.setDefaultPresentationDismissHandler { outcome ->
    when (outcome.purchaseResult) {
        PLYPurchaseResult.PURCHASED,
        PLYPurchaseResult.RESTORED -> { /* unlock content */ }
        else -> { }
    }
}
```
```swift iOS
// 1) Podfile — add the dependency
pod 'Purchasely'

// 2) Initialize and start the SDK (e.g. in AppDelegate)
Purchasely
    .apiKey("<<X-API-KEY>>")
    .runningMode(.full) // default is .observer in v6
    .start { error in }

// 3) Display the paywall configured for a placement
Purchasely.display(for: "<<default_placement>>")

// 4) Handle the result via a default handler
Purchasely.setDefaultPresentationDismissHandler { outcome in
    switch outcome.purchaseResult {
    case .purchased, .restored: break // unlock content
    default: break
    }
}
```

# Installation

Add the Purchasely SDK dependency to your project. On Android, also add the store dependency (`google-play`); on iOS, install it via CocoaPods or Swift Package Manager.

<!-- kotlin@1-3 -->
<!-- swift@1-2 -->

# Initialization

Start the SDK as early as possible. ⚠️ In v6 the default running mode is `Observer` — set `Full` (`.runningMode(PLYRunningMode.Full)` / `.runningMode(.full)`) if you want Purchasely to handle and validate purchases. On Android you can also use the fluent `Purchasely.Builder(...)` chain.

<!-- kotlin@5-12 -->
<!-- swift@4-8 -->

# Display a paywall

Display the paywall configured for a [placement](displaying-screens-placements). On Android, `PLYPresentation { … }.preload { … }` loads then displays it; on iOS, `Purchasely.display(for:)` is the one-line convenience.

<!-- kotlin@14-16 -->
<!-- swift@10-11 -->

# Handle the result

A paywall opened from a deeplink or placement reports its outcome through the default presentation result handler.

<!-- kotlin@18-25 -->
<!-- swift@13-19 -->
