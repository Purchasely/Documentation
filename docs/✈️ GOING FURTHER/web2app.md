---
title: Web-to-app funnels (redemption)
excerpt: >-
  This page provides details on delivering a subscription bought on the web to
  the app with a Purchasely redemption deeplink (Web2App)
deprecated: false
hidden: false
metadata:
  title: ''
  robots: index
next:
  description: ''
---
# Context

Web2App is the opposite direction of [App-to-web funnels](app2web). App2Web sends a user from a Purchasely Paywall to a web checkout. Web2App gives a subscription bought on the web to the app.

The funnel has five steps:

1. The user buys a subscription on the web, through a Stripe checkout.
2. The user gets an email with a redemption link.
3. The user taps the link on the phone and lands in the app.
4. The SDK exchanges the redemption token for the subscription.
5. The SDK refreshes the entitlements and tells the app the result.

<Callout icon="🚧" theme="warn">
  ### SDK v6.1.0+ required

  The redemption result API is available from v6.1.0 on iOS, Android, React Native, Flutter and Cordova.
</Callout>

# The redemption deeplink

The redemption link has this shape:

```text
{app_scheme}://ply/redeem/{token}?auid={anonymous_user_id}
```

The app does not build this link. The Purchasely backend creates the token, the email carries the link, and the landing page opens it.

The SDK parses this link like any other Purchasely deeplink. The query parsing is generic, so the SDK ignores an unknown parameter. The landing page can therefore add a parameter without a new SDK release.

On Android the SDK intercepts the deeplink on its own, and the manual call is only a fallback. On iOS you pass the link to the SDK. You can also give the link to the initialization chain, which every platform accepts.

<DeeplinkImplementation />

## The deeplink gate does not apply

A redemption link is not subject to `allowDeeplink`. The SDK intercepts the link out of band, before the routing branch and before the gate. `allowDeeplink(false)` therefore does NOT block a redemption.

A user who taps a redemption link in an email always gets the subscription, whatever the deeplink gate says.

## Security

The redemption token is a bearer credential. Whoever holds the token can claim the subscription. The SDK therefore keeps the token out of four places:

- The deeplink waiting list.
- The map that the SDK uses to deduplicate a raw URI.
- Every analytics event.
- Every log line.

The SDK deduplicates a redemption with a SHA-256 hash of the token. The SDK never uses the token itself for the deduplication.

# Getting the result of a redemption

Register your callback in the initialization chain. Every SDK provides the method there.

```swift Swift
Purchasely
    .apiKey("<<X-API-KEY>>")
    .webRedemptionDelegate(self, appHandlesRedemptionAlert: false)
    .start()
```
```kotlin Kotlin
Purchasely.Builder(applicationContext)
    .apiKey("<<X-API-KEY>>")
    .webRedemptionListener { result -> }
    .stores(listOf(GoogleStore()))
    .build()
    .start { error -> }
```
```typescript React Native
await Purchasely.builder('<<X-API-KEY>>')
  .webRedemptionListener((result) => {
    if (result.isSuccess) {
      // result.context?.subscription
    }
  })
  .stores(['google'])
  .start();
```
```dart Flutter
await Purchasely.apiKey('<<X-API-KEY>>')
    .webRedemptionListener((result) {
      if (result.isSuccess) {
        // result.context?.subscription
      }
    })
    .stores([PLYStore.google])
    .start();
```
```javascript Cordova
await Purchasely.builder('<<X-API-KEY>>')
    .webRedemptionListener(function (result) {
        if (result.isSuccess) {
            // result.context.subscription
        }
    })
    .stores([Purchasely.Store.google])
    .start();
```

<Callout icon="❗️" theme="error">
  ### Register in the chain, not after `start()`

  A redemption can settle during `start()`. The `ply/redeem` link can be what launches the app, and a previous launch can leave a token pending. A listener that your app adds after `start()` misses exactly the case that the feature exists for.

  The three bridges also provide a runtime function, `addWebRedemptionListener`, for an app that must replace the listener later. That path carries the risk above.
</Callout>

## The registration method of each platform

| Platform | Registration | Callback |
| :--- | :--- | :--- |
| iOS | `webRedemptionDelegate(_ value: PLYWebRedemptionDelegate?, appHandlesRedemptionAlert: Bool = false)` | `webRedemptionCompleted(result: PLYWebRedemptionResult)` |
| Android | `webRedemptionListener(listener)` or `webRedemptionListener(appHandlesRedemptionAlert, listener)`, on `Purchasely.Builder` and on the `Purchasely { }` DSL | `PLYWebRedemptionListener.onRedemptionCompleted` |
| React Native | `webRedemptionListener(callback, appHandlesRedemptionAlert?)` | the callback |
| Flutter | `webRedemptionListener(listener, [appHandlesRedemptionAlert])` | the listener |
| Cordova | `webRedemptionListener(callback, appHandlesRedemptionAlert?)` | the callback |

## The result

| Property | Value |
| :--- | :--- |
| `isSuccess` | `true` for a granted redemption, `false` for a failure |
| `context` | The redemption context. `null` on a failure, and nullable on a success |
| `context.subscription` | The subscription that the redemption granted. This is the type that `userSubscriptions()` returns |
| `replay` | `true` when the server reports that the token was redeemed before. Always `false` on a failure |
| `errorCode` | The backend error code: `EXPIRED_REDEMPTION_TOKEN` or `INVALID_REDEMPTION_TOKEN`. `null` on a success, and `null` on a failure that never reached the server |
| `errorMessage` | The reason, in English. `null` on a success. It never carries the token |

Android is the one exception to the shape of that table. The Kotlin `PLYWebRedemptionResult` is a sealed class of two cases, so the properties sit on the case instead of on one flat object:

- `Success(context, replay)`
- `Failure(errorCode, errorMessage)`

The `replay` value is a verdict about the token, not an observation of the user. The SDK keeps no cache and calls the server on every attempt.

# The delivery contract

The contract is the same on every platform:

- The SDK calls your app on the main thread.
- The SDK calls your app exactly once for each settled redemption.
- Only one redemption runs at a time. The first link wins.
- Other deeplinks queue during a redemption. The SDK replays them in the arrival order when the redemption settles.
- The SDK makes at most three attempts when the server answers with a retryable error.

One guarantee is specific to Android: a watchdog cancels a hung redemption after 90 seconds, and the redemption then settles with a generic error. The user therefore always gets an outcome.

# Who owns the outcome screen

The `appHandlesRedemptionAlert` parameter decides who draws the result.

| Value | The SDK shows | The SDK calls your app |
| :--- | :--- | :--- |
| `false` (the default) | Its own success or failure popin | After the user acknowledges the popin |
| `true` | Nothing | As soon as the redemption settles |

Set the value to `true` when your app must show its own result screen.

<Callout icon="🚧" theme="warn">
  ### Show `errorMessage` to the user, and do not log it

  On the expired case, the SDK builds an `errorMessage` of this shape:

  ```text
  Redemption link has expired. A new link was sent to <masked address>.
  ```

  iOS and Android behave the same way here, and every bridge carries the same value. The masked address is present only when the backend supplies a hint, and it is absent otherwise. The matching analytics event drops the hint on purpose, because the boundary that matters is the device: an analytics event goes to the Purchasely backend and to any third-party listener that your app registered, and the result of the callback never leaves the process.

  Your app needs the hint. With `appHandlesRedemptionAlert` at `true` you suppressed the built-in popin, which is the only other place the hint appears, so your own screen is the only way to tell the user where the fresh link went.

  Display `errorMessage` on your result screen. Do NOT forward it to your own analytics stack, and do NOT forward it to a crash reporter. Either one sends the masked address off the device.
</Callout>

# Purchase context restore

A successful redemption can return a versioned `purchase_context`. This object describes the web funnel that made the sale.

The SDK restores the `built_in_attributes` of that object, for example `utm_source`, `utm_medium` and `utm_campaign`. The SDK also restores its `custom_attributes`. The SDK writes all of them as user attributes BEFORE the entitlement refresh.

Two results follow:

- Every event after the redemption already carries those attributes.
- An Audience can target on those attributes.

The SDK ignores an unknown `version` and does not fail the receipt. A response with no `purchase_context` keeps the earlier behaviour.

# Events

The SDK reports the result of a redemption as a UI/SDK event:

| Result | Android, React Native, Flutter, Cordova | iOS |
| :--- | :--- | :--- |
| Success | `REDEMPTION_CONSUMED` | `redemptionConsumed` |
| Failure | `REDEMPTION_FAILED` | `redemptionFailed` |

Neither event existed before v6.1.0. A replay is a success, so a replay produces the success event on every platform. Read the `replay` value on the result to tell a first redemption from a replay.

📚 See the [List of UI/SDK events](ui-sdk-events-list) for the attributes of these events.

# The anonymous user id

The redemption link carries the web anonymous id of the buyer in the `auid` parameter.

The SDK adopts that id only when it holds no anonymous id yet. The web identity and the app identity therefore stay the same person. An id that your app supplies in the initialization chain always wins over the id in the link. Read [Identifying users](user-identification) for that method and for its rules.
