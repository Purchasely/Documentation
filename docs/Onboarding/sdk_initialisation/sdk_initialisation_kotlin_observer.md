---
title: Kotlin observer
excerpt: ''
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# SDK INITIALISATION

```kotlin Kotlin
import android.app.Application
import io.purchasely.ext.Purchasely
import io.purchasely.ext.PLYRunningMode
import io.purchasely.google.GoogleStore

class YourApplication: Application() {

    override fun onCreate() {
        super.onCreate()

        Purchasely.Builder(applicationContext)
            .apiKey("<<X-API-KEY>>")
            .runningMode(PLYRunningMode.Observer)
            .userId(null) // optional if you already know your user id
            .stores(listOf(GoogleStore())) // Set the list of stores you want to have
            .webRedemptionListener { result -> } // SDK 6.1.0, result of a Web2App redemption deeplink
            .anonymousUserId("YOUR_ID") // SDK 6.1.0, optional, reuses the anonymous id of your app
            // .proxy(api = "https://svc.purchasely.io") // SDK 6.1.0, only if api.purchasely.io is unreachable
            .build()
            .start { error ->
               if (error == null) {
               			// Purchasely setup is complete
               }
            }
    }
}
```

# USER IDENTIFICATION

If you want the purchases and subscriptions to be associated to a user and not a device you can provide a user id in the`Purchasely.Builder()`method.

# WEB2APP REDEMPTION

Requires SDK 6.1.0. Add `.webRedemptionListener { result -> }` to the builder. The SDK calls `PLYWebRedemptionListener.onRedemptionCompleted` on the main thread, once per redemption. Use `.webRedemptionListener(appHandlesRedemptionAlert = true) { result -> }` to draw your own result screen.

# ANONYMOUS USER ID

Requires SDK 6.1.0. The value of `anonymousUserId` must be a canonical UUID, with an optional lowercase origin prefix such as `web_<uuid>` or `mob_<uuid>`. The SDK takes the id only when the device holds no anonymous id yet. Use `.anonymousUserId("YOUR_ID", override = true)` to replace an id that already exists.

# API PROXY

Requires SDK 6.1.0. Add `.proxy(api = "https://svc.purchasely.io")` when `api.purchasely.io` is unreachable, for example behind the Great Firewall in mainland China. The SDK accepts only an `https` URL. It keeps the production host for any other value. The iOS equivalent is not in 6.1.0.
