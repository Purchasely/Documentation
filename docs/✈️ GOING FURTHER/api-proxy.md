---
title: API proxy
excerpt: >-
  How to route the Purchasely API traffic through a proxy when api.purchasely.io
  is unreachable, for example in mainland China
deprecated: false
hidden: false
metadata:
  title: ''
  robots: index
next:
  description: ''
---
# Context

The SDK sends its API requests to `api.purchasely.io`. Some networks block that host. In mainland China, the Great Firewall blocks it, while the paywall host and the tracking host stay reachable. The API proxy gives the SDK a different base URL for the API host.

Purchasely operates a proxy at `https://svc.purchasely.io`. You can also host your own proxy.

<Callout icon="🚧" theme="warn">
  ### SDK v6.1.0+ required

  The proxy is available from v6.1.0 on iOS, Android, React Native, Flutter and Cordova.
</Callout>

# What the proxy moves

Only the API host moves. The proxy never moves `paywall.purchasely.io` and `tracking.purchasely.io`. On iOS, these two hosts follow `environment(_:)`, which targets production by default.

# iOS

```swift Swift
// The Purchasely proxy
Purchasely
    .apiKey("<<X-API-KEY>>")
    .proxy()
    .start()

// Your own proxy
Purchasely
    .apiKey("<<X-API-KEY>>")
    .proxy(api: URL(string: "https://proxy.example.com"))
    .start()

// No proxy: the SDK goes back to api.purchasely.io
Purchasely
    .apiKey("<<X-API-KEY>>")
    .proxy(api: nil)
    .start()
```

The parameter is a `URL?`. The no-argument form `proxy()` selects the Purchasely proxy. The `nil` value restores `api.purchasely.io`. A chain that calls neither form keeps the current setting.

# Android

```kotlin Kotlin
// The Purchasely proxy, or your own
Purchasely.Builder(applicationContext)
    .apiKey("<<X-API-KEY>>")
    .proxy(api = "https://svc.purchasely.io")
    .stores(listOf(GoogleStore()))
    .build()
    .start { error -> }

// No proxy: the SDK goes back to api.purchasely.io
Purchasely.Builder(applicationContext)
    .apiKey("<<X-API-KEY>>")
    .proxy(api = null)
    .stores(listOf(GoogleStore()))
    .build()
    .start { error -> }
```

The parameter is a `String?`. The `null` value restores `api.purchasely.io`, and it also clears a proxy that an earlier `build()` set. The `Purchasely { }` DSL provides the same method.

# React Native, Flutter and Cordova

```typescript React Native
await Purchasely.builder('<<X-API-KEY>>')
  .proxy('https://svc.purchasely.io') // null restores api.purchasely.io
  .stores(['google'])
  .start();
```
```dart Flutter
await Purchasely.apiKey('<<X-API-KEY>>')
    .proxy('https://svc.purchasely.io') // null restores api.purchasely.io
    .stores([PLYStore.google])
    .start();
```
```javascript Cordova
await Purchasely.builder('<<X-API-KEY>>')
    .proxy('https://svc.purchasely.io') // null restores api.purchasely.io
    .stores([Purchasely.Store.google])
    .start();
```

The three bridges take the base URL as a string and forward the value to the native SDK. The rules below therefore apply on every platform. The argument is required on the three bridges. A chain that never calls the method keeps the current setting.

<Callout icon="❗️" theme="error">
  ### The no-argument form does the opposite on the two native platforms

  On iOS, `proxy()` selects the Purchasely proxy. On Android, `proxy()` restores `api.purchasely.io`, because the parameter has a default value of `null`. Always write the URL. The explicit form gives the same result everywhere.
</Callout>

| Call | iOS | Android | React Native, Flutter, Cordova |
| :--- | :--- | :--- | :--- |
| No argument | Selects `https://svc.purchasely.io` | Restores `api.purchasely.io` | Not available. React Native and Flutter require the argument at compile time, and Cordova refuses the call with an error log |
| A URL | Selects that URL | Selects that URL | Selects that URL |
| `nil` and `null` | Restores `api.purchasely.io` | Restores `api.purchasely.io` | Restores `api.purchasely.io` |

The bridges make the argument mandatory for this reason. One shorthand cannot mean two different things on the two native platforms that a bridge drives.

# URL rules

The SDK accepts a base URL that follows these rules:

* The scheme is `https`. The SDK refuses `http`.
* The URL carries a host.
* The URL carries no query and no fragment.
* The URL carries no credentials. Authenticate your own proxy with a header instead.

A path is valid. Both `https://svc.purchasely.io` and `https://proxy.example.com/purchasely` work. Write the URL with or without a trailing slash. Each SDK normalizes that character for its own network layer.

The SDK refuses any other value, writes an error log, and keeps the production host. The refusal never stops the initialization, so a wrong value never breaks the SDK.

# The proxy belongs to the initialization

Both SDKs read the base URL when they build their network clients. They read it once. For this reason, the proxy is an option of the initialization chain, and neither platform provides a runtime setter.

# Logs

The error log redacts the query, the fragment and the credentials of the refused URL, because the message must not carry a secret. The iOS SDK can also upload its logs to Purchasely for support. Read [SDK diagnostics and observability](sdk-diagnostics-and-observability) for more information.
