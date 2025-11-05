---
title: Onboarding - Apple - Setup - Swift
fullscreen: false
hidden: true
metadata:
  title: ''
  description: ''
---
# Installation

```Text SPM
install Purchasely
```
```Text CocoaPods
pod install Purchasely
```
```Text Carthage
```

# Setup

```Text Swift
Purchasely.start("<<X-API-KEY>>")
```

API KEY is: {user["X-API-KEY"]}

## StoreKit version

### StoreKit 1

<Image align="center" src="https://files.readme.io/443bd9b-spaces_KuAJGBnHJWZbqzA4g8yO_uploads_git-blob-904a1eb89e37fa1cbce00a969259ac66b1d911a6_image_59_1.webp" />

### StoreKit 2

## User identification

# Display a placement

Display a paywall

```Text Swift
Purchasely.presentationController("onboarding")
```

# Paywall Action Interceptor
