---
title: SDK integration
excerpt: >-
  What your app needs to activate web subscriptions, and how to use the
  redemption delegate to tailor the welcome experience, handle sign-in and read
  the subscription.
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: 'Next, the events and webhooks that report web purchases.'
  pages:
    - type: basic
      slug: web2app-events-and-webhooks
      title: Events, attribution & webhooks
---
The Purchasely SDK activates web subscriptions on its own: it recognizes the redemption link, calls Purchasely, refreshes the user's entitlements and confirms the outcome to the user. In most apps, **no code is needed beyond the deeplink handling you already have**, with one condition: the deeplink that opened the app must be **passed to the SDK when it is initialized**, as described in [SDK initialization](sdk-initialization) and [Deeplinks management](deeplinks-management). The way to pass it changed in SDK 6, so check your integration against those pages if you migrated from v5.

This page covers the minimum to check, then the optional hooks to build your own welcome experience: a confirmation Screen, a sign-in or sign-up prompt, reading the subscription that was just activated.

| Capability | Minimum SDK |
| --- | --- |
| Activate a web subscription from the redemption link | **6.1** |
| Redemption delegate (iOS) / listener (Android) | **6.1** |
| Campaign triggered on the `REDEMPTION_CONSUMED` event | **6.2** |

## 1. Forward deeplinks to the SDK

The redemption link opens your app through its custom URL scheme. The SDK needs to receive that URL, in both situations: when the app is **already running** and when it is **launched by the link**. If your app already forwards deeplinks to Purchasely as documented in [Deeplinks management](deeplinks-management), nothing changes. Redemption links are handled even when you gate other Purchasely deeplinks behind your onboarding.

**iOS**

```swift
// UIKit — AppDelegate
func application(_ app: UIApplication, open url: URL,
                 options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    return Purchasely.handleDeeplink(url)
}

// SwiftUI
.onOpenURL { url in
    _ = Purchasely.handleDeeplink(url)
}
```

**Android**

```kotlin
// Activity that declares the scheme in its intent-filter
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    intent?.data?.let { Purchasely.handleDeeplink(it) }
}

override fun onNewIntent(intent: Intent) {
    super.onNewIntent(intent)
    intent.data?.let { Purchasely.handleDeeplink(it) }
}
```

`handleDeeplink` returns `true` when the URL was a Purchasely link and is being handled.

### Cold start: pass the launch deeplink at initialization

When the app is launched by the link, the URL is available before the SDK is started. Hand it to the **start builder** with `handleDeeplink`, as shown in [SDK initialization](sdk-initialization). This is what guarantees that a redemption link opened on a cold start is consumed, and it lets the SDK adopt the web visitor's identity before its first network call, so the analytics of the journey stay continuous.

```swift
Purchasely.apiKey("YOUR_API_KEY")
    .handleDeeplink(launchOptions?[.url] as? URL)
    .start { error in }
```

```kotlin
Purchasely.Builder(applicationContext)
    .apiKey("YOUR_API_KEY")
    .handleDeeplink(intent.data)
    .build()
    .start { isConfigured, error -> }
```

## 2. Default behaviour

With no further code, when a redemption link is opened the SDK:

1. shows a progress indicator,
2. activates the subscription and refreshes the entitlements,
3. shows a **native alert** with the outcome: subscription active, link expired (a new one was emailed), or link invalid.

The alert is localized and managed by the SDK. Once the user dismisses it, your app is back where it was.

## 3. Tailor the experience with the redemption delegate

To replace the alert with your own experience, register a **redemption delegate** (iOS) or **listener** (Android) at SDK initialization, with `appHandlesRedemptionAlert` set to `true`. The SDK then shows nothing and calls you as soon as the redemption settles, on success and on failure, on the main thread.

With `appHandlesRedemptionAlert` left to `false`, the SDK keeps its alert and calls your delegate **after** the user dismisses it: use this to react without redrawing the outcome.

The result carries:

| Field | Meaning |
| --- | --- |
| Success or failure | `isSuccess` on iOS, `Success` / `Failure` subclasses on Android. |
| `context.subscription` | The activated subscription, with its plan and product. Same type as the ones returned by the SDK's subscription methods. |
| `replay` | `true` when the link had already been consumed by this user; the entitlements were simply refreshed. |
| `errorCode`, `errorMessage` | On failure: `EXPIRED_REDEMPTION_TOKEN` (a new link was emailed; the message contains the masked address), `INVALID_REDEMPTION_TOKEN`, or `nil` when the request never reached the server. |

### A common pattern: confirm, then sign in or sign up

Many apps want the subscriber to have an account. The recommended sequence is: confirm the activation first, then invite the user to create an account or sign in. The subscription is already secured on this device, and it follows the account as soon as your app identifies the user with the SDK.

**iOS**

```swift
import Purchasely

final class AppDelegate: UIResponder, UIApplicationDelegate, PLYWebRedemptionDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Purchasely.apiKey("YOUR_API_KEY")
            .appUserId(Session.currentUserId)            // nil when the user is not signed in
            .handleDeeplink(launchOptions?[.url] as? URL)
            .webRedemptionDelegate(self, appHandlesRedemptionAlert: true)
            .start { error in }
        return true
    }

    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return Purchasely.handleDeeplink(url)
    }

    // MARK: - PLYWebRedemptionDelegate

    func webRedemptionCompleted(result: PLYWebRedemptionResult) {
        switch result.asResult() {
        case .success(let context, let replay):
            let planName = context?.subscription?.plan.name
            if Purchasely.isAnonymous() {
                // 1. Confirm, 2. invite to create an account or sign in
                Router.showWelcome(planName: planName, thenPrompt: .signUpOrSignIn)
            } else {
                Router.showWelcome(planName: planName, thenPrompt: .none)
            }
            if !replay { Analytics.track("web_subscription_activated") }

        case .failure(let errorCode, let errorMessage):
            // EXPIRED_REDEMPTION_TOKEN: a new link was emailed, errorMessage says where
            Router.showRedemptionError(code: errorCode, message: errorMessage)
        }
    }
}
```

**Android**

```kotlin
import io.purchasely.ext.Purchasely
import io.purchasely.models.PLYWebRedemptionResult

class App : Application() {

    override fun onCreate() {
        super.onCreate()
        Purchasely.Builder(applicationContext)
            .apiKey("YOUR_API_KEY")
            .userId(Session.currentUserId)               // null when the user is not signed in
            .webRedemptionListener(appHandlesRedemptionAlert = true) { result ->
                when (result) {
                    is PLYWebRedemptionResult.Success -> {
                        val planName = result.context?.subscription?.plan?.name
                        if (Purchasely.isAnonymous()) {
                            // 1. Confirm, 2. invite to create an account or sign in
                            Router.showWelcome(planName, prompt = Prompt.SIGN_UP_OR_SIGN_IN)
                        } else {
                            Router.showWelcome(planName, prompt = Prompt.NONE)
                        }
                        if (!result.replay) Analytics.track("web_subscription_activated")
                    }
                    is PLYWebRedemptionResult.Failure -> {
                        // EXPIRED_REDEMPTION_TOKEN: a new link was emailed, errorMessage says where
                        Router.showRedemptionError(result.errorCode, result.errorMessage)
                    }
                }
            }
            .build()
            .start { isConfigured, error -> }
    }
}
```

The delegate must be registered **before** `start`: there is no runtime setter. The code above assumes the app schemes are declared as described in [Setup 3](web2app-setup-mobile-app).

### Attach the subscription to the account after sign-in

Once the user has signed in or created an account, identify them with the SDK as you already do for in-app purchases. The subscription activated for the anonymous user is **automatically transferred** to the user ID you provide, and your webhooks report the transfer. This is the same mechanism as the restore and transfer of in-app subscriptions: nothing specific to the web.

```swift
Purchasely.userLogin(with: account.id) { shouldRefresh in
    if shouldRefresh { /* reload your entitlements */ }
}
```

```kotlin
Purchasely.userLogin(account.id) { shouldRefresh ->
    if (shouldRefresh) { /* reload your entitlements */ }
}
```

See [User identification](general-user-identification) for the rules that apply to identification and logout.

> 🚧 Sign in before or after, not during
>
> Do not block the redemption behind a login wall: activate first, then ask. A subscriber who paid and cannot get in is the first cause of refunds. If the user is already signed in when the link opens, the subscription goes straight to their account.

## 4. Read the subscription

The redemption result already carries the activated subscription. At any later time, read the user's subscriptions with the SDK, as for any subscription:

```swift
Purchasely.userSubscriptions(success: { subscriptions in
    let web = subscriptions?.first { $0.subscriptionSource == .stripe }
    // web?.plan, web?.product, web?.status, web?.nextRenewalDate
}, failure: { error in })
```

```kotlin
Purchasely.userSubscriptions(
    onSuccess = { subscriptions ->
        val web = subscriptions.firstOrNull { it.data.storeType == StoreType.STRIPE }
        // web?.plan, web?.product, web?.data
    },
    onError = { error -> }
)
```

Web subscriptions carry Stripe as their store. See [Entitlements management](entitlements-management) for the two ways of granting access, from the SDK or from your backend through webhooks.

## 5. Events and campaigns

Every redemption also emits exactly one event to your Purchasely event listener:

| Event | When | Notable properties |
| --- | --- | --- |
| `REDEMPTION_CONSUMED` | The subscription was activated (or re-confirmed, with `replay: true`). | `redemption.subscriptions`, `redemption.purchase_context` with the `utm_*` attributes and the user attributes collected in the funnel. |
| `REDEMPTION_FAILED` | The link could not be consumed. | `error_message`, `redemption.error_code`. |

`REDEMPTION_CONSUMED` fires after the funnel's context has been restored, so the UTM parameters are readable through the SDK's built-in attributes and the quiz answers through the user attributes, without parsing the event.

From SDK **6.2**, `REDEMPTION_CONSUMED` is also available as a **Campaign trigger** in the Console. Use it to display a welcome Screen or an onboarding Flow to web subscribers without writing the delegate above: create a Campaign, choose *Redemption consumed* as trigger, and pick the Screen or Flow to display. See [Campaigns](campaigns).

## Cross-platform SDKs

`handleDeeplink` exists on React Native, Flutter and Cordova, so the automatic activation and its alert work on these platforms with SDK 6.1. The typed redemption delegate is exposed by the native SDKs; check the release notes of your bridge for its availability.

## Troubleshooting

| Problem | Cause and solution |
| --- | --- |
| The app opens but nothing happens. | The URL is not forwarded to `handleDeeplink`, or only when the app is already running and not at initialization, or the SDK is older than 6.1. See [SDK initialization](sdk-initialization) and [Deeplinks management](deeplinks-management). |
| The delegate is never called. | It must be registered on the builder before `start`. With `appHandlesRedemptionAlert = false`, it is called only after the user dismisses the SDK alert. |
| `context.subscription` is `nil` on success. | The products were not loaded yet when the result arrived. The subscription is active: read it with `userSubscriptions`. |
| The subscription disappears after the user signs in. | The app calls the SDK's logout, or logs in with an identifier that differs between sessions. Identify the user with a stable identifier. |
