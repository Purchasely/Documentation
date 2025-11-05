---
title: App Store - StoreKit 1 vs StoreKit 2
excerpt: ''
deprecated: false
hidden: false
metadata:
  title: ''
  description: >-
    Apple introduced StoreKit 2 at WWDC 2021 as a Swift-first replacement for
    the deprecated StoreKit 1, offering improved in-app purchase logic,
    security, and native Swift concurrency. Developers are encouraged to migrate
    to StoreKit 2 for enhanced features and support, with Purchasely providing
    automatic handling and fallback options.
  keywords:
    - storekit
    - ' migration'
    - ' transaction'
    - ' in-app purchase'
    - ' subscription'
    - ' entitlement'
  robots: index
next:
  description: ''
---
# 🧭 Overview

Apple introduced **StoreKit 2** at **WWDC 2021** as a modern, Swift-first replacement for the legacy **StoreKit 1** framework.\
While StoreKit 1 powered in-app purchases for over a decade, it has now been officially **deprecated** and will no longer receive updates or support for new features.

StoreKit 2 simplifies in-app purchase logic, improves reliability, enhances security, and offers native Swift concurrency and built-in paywall UI components.

> 👍 Purchasely handles it automatically
>
> Purchasely automatically uses **StoreKit 2**, with a seamless fallback to StoreKit 1 on devices running iOS 14 or earlier.\
> You can still force StoreKit 1 if needed, but **this is not recommended** and should only be used temporarily while migrating your own codebase to StoreKit 2.
>
> We recommend using the Purchasely SDK in [full mode](process-transactions-full-mode) and letting Purchasely **manage all StoreKit transactions** for you.\
> This way, you benefit from the latest Apple frameworks, zero configuration, and a fully reliable purchase flow out of the box.

***

# ⚠️ Deprecation and Lifecycle

| Aspect         | StoreKit 1                                         | StoreKit 2                                                   |
| :------------- | :------------------------------------------------- | :----------------------------------------------------------- |
| Status         | **Deprecated** as of WWDC 2024                     | Actively developed                                           |
| OS support     | iOS 3 → iOS 18 (legacy)                            | iOS 15 +                                                     |
| New features   | ❌ None                                             | ✅ Continuous updates                                         |
| Future support | Maintenance only, may break in future iOS versions | Full support for new features, APIs, and server integrations |

<Callout icon="🔹" theme="default">
  ### **Apple announced the deprecation of “Original StoreKit API” at WWDC 2024.**

  Developers are strongly encouraged to migrate to StoreKit 2 as StoreKit 1 behaviour may change or stop functioning in future OS versions.
</Callout>

***

# 🧩 Feature Comparison

| Category                | StoreKit 1                                                                          | StoreKit 2                                                                          |
| ----------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| **Language design**     | Objective-C and early Swift; delegate-based (`SKPaymentQueue`, `SKProductsRequest`) | Swift-native; async/await concurrency, strongly typed APIs                          |
| **Product retrieval**   | `SKProductsRequest` with delegate callbacks                                         | `Product.products(for:)` (async)                                                    |
| **Purchase flow**       | Add `SKPayment` to queue, handle observer updates manually                          | `try await product.purchase()` returns structured results                           |
| **Restore purchases**   | Manual “Restore” button, complex logic                                              | `Transaction.currentEntitlements` provides real-time entitlements automatically     |
| **Subscription status** | Requires server validation and custom logic                                         | Built-in `SubscriptionStatus` and `Transaction` API                                 |
| **Receipt validation**  | Manual receipt parsing (ASN.1 / JSON)                                               | Built-in cryptographic verification (`VerificationResult`)                          |
| **Security**            | Developer-managed                                                                   | Transactions cryptographically signed by Apple (JWS)                                |
| **UI / Paywall**        | Fully custom                                                                        | Built-in SwiftUI views: `StoreView`, `SubscriptionStoreView`, etc.                  |
| **Testing**             | Sandbox only; limited StoreKit configuration support                                | Enhanced StoreKit Testing in Xcode with simulated renewals, billing issues, refunds |
| **Server integration**  | App Store Server API (v1, deprecated)                                               | App Store Server API v2 with richer transaction data                                |
| **Cross-device sync**   | Manual restore logic                                                                | Automatic entitlement syncing across devices                                        |

***

# 🔐 Security Enhancements

StoreKit 2 introduces **end-to-end cryptographic verification**:

* All transactions are signed by Apple using **JSON Web Signature (JWS)**.  
* The SDK validates signatures locally, reducing the need for complex receipt parsing.  
* Built-in transaction verification ensures authenticity and integrity.  
* Better protection against tampering or fraudulent unlocks.  
* Simplified server-side validation through App Store Server API v2.

***

# 💡 Implementation Overview

## StoreKit 1 (Legacy Example)

```swift Swift
let payment = SKPayment(product: product)  
SKPaymentQueue.default().add(payment)

func paymentQueue(\_ queue: SKPaymentQueue,  
                  updatedTransactions transactions: [SKPaymentTransaction]) {  
    for transaction in transactions {  
        switch transaction.transactionState {  
        case .purchased:  
            // Unlock content  
            SKPaymentQueue.default().finishTransaction(transaction)  
        case .restored:  
            // Restore purchases  
            SKPaymentQueue.default().finishTransaction(transaction)  
        case .failed:  
            // Handle error  
            SKPaymentQueue.default().finishTransaction(transaction)  
        default:  
            break  
        }  
    }  
}
```

## StoreKit 2 (Modern Example)

```swift
import StoreKit

let products = try await Product.products(for: ["com.myapp.pro_monthly"])  
if let product = products.first {  
    let result = try await product.purchase()  
    switch result {  
    case .success(let verification):  
        if case .verified(let transaction) = verification {  
            // Unlock content  
            await transaction.finish()  
        } else {  
            // Handle unverified transaction  
        }  
    case .pending:  
        // Ask to Buy / SCA  
        break  
    case .userCancelled:  
        break  
    @unknown default:  
        break  
    }  
}


for await transaction in Transaction.currentEntitlements {  
    // Automatically includes all active purchases  
    print("User owns: \(transaction.productID)")  
}
```

### Checking Entitlements (No Restore Needed)

```swift
for await transaction in Transaction.currentEntitlements {  
    // Automatically includes all active purchases  
    print("User owns: \(transaction.productID)")  
}
```

# 🧱 Architecture Differences

| Concept                       | StoreKit 1                                         | StoreKit 2                                                                           |
| ----------------------------- | -------------------------------------------------- | ------------------------------------------------------------------------------------ |
| **Transaction handling**      | Observer pattern with delegate callbacks           | Async/await return values with structured types                                      |
| **Entitlements**              | Must be persisted manually and restored explicitly | Managed automatically via `Transaction.currentEntitlements`                          |
| **Restore flow**              | Requires calling `restoreCompletedTransactions()`  | Automatic entitlement sync across devices                                            |
| **Receipt validation**        | App receipt must be read and verified manually     | Built-in cryptographic validation (JWS signed transactions)                          |
| **Server communication**      | App Store Server API v1                            | App Store Server API v2 (modern JSON Web Signature model)                            |
| **Subscription renewal info** | Requires custom server logic                       | Built-in APIs like `RenewalInfo` and `SubscriptionStatus`                            |
| **UI integration**            | Fully custom implementation                        | Built-in SwiftUI paywall views (`StoreView`, `ProductView`, `SubscriptionStoreView`) |
| **Language support**          | Objective-C and Swift                              | Swift-only (async/await concurrency)                                                 |
| **Testing tools**             | Sandbox + limited StoreKit Config support          | Xcode StoreKit Testing with full simulation (renewal, refund, billing retry)         |

***

# ⚙️ Testing Improvements

StoreKit 2 introduces a more robust and developer-friendly testing environment:

* **Xcode StoreKit Testing Configuration** allows local simulation of subscriptions, renewals, refunds, and billing issues.
* **Async purchase simulation** enables easy testing of success, pending, and cancellation flows.
* **Unified transaction model** ensures identical behaviour on simulator and real devices.
* **Automatic entitlement refresh** prevents stale purchase states during tests.

***

# 🚧 Restrictions & Compatibility

| Limitation                    | Description                                                       |
| ----------------------------- | ----------------------------------------------------------------- |
| **Minimum OS version**        | StoreKit 2 requires iOS 15+, macOS 12+, tvOS 15+, or watchOS 8+   |
| **Backward compatibility**    | For users on iOS 14 or older, StoreKit 1 fallback may be required |
| **Promoted in-app purchases** | Some legacy App Store flows remain StoreKit 1-only                |
| **Objective-C projects**      | StoreKit 2 is Swift-native — migration or bridging needed         |
| **Server integration**        | Requires App Store Server API v2 adoption                         |
| **Migration cost**            | Code refactor required for purchase logic and validation          |

<br />

***

# 🧭 Recommendations

> 👍 Use Purchasely SDK in [full mode](process-transactions-full-mode)
>
> To simplify entitlement management, paywall configuration, and cross-platform consistency.

* **For new apps:** adopt **StoreKit 2 only**.  
* **For existing apps:** implement a **hybrid setup** during migration.  
* **Avoid building new logic on StoreKit 1** — it’s deprecated and will eventually stop functioning.  
* **Update your backend** for App Store Server API v2 and JWS verification.  
* **Test critical edge cases**: refunds, family sharing, Ask to Buy, and billing retry.  

***

# 📚 References

* [Apple Developer — StoreKit 2 Overview](https://developer.apple.com/storekit/)  
* [WWDC 2024 — What’s New in StoreKit and In-App Purchase](https://developer.apple.com/videos/play/wwdc2024/10061/)
