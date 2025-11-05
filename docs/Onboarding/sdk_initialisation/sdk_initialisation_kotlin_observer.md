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
import io.purchasely.google.GoogleStore

class YourApplication: Application() {

    override fun onCreate() {
        super.onCreate()

        Purchasely.Builder(applicationContext)
            .apiKey("<<X-API-KEY>>")
            .runningMode(PLYRunningMode.PaywallObserver)
            .userId(null) // optional if you already know your user id
            .stores(listOf(GoogleStore())) // Set the list of stores you want to have
            .build()
            .start { isConfigured, error ->
               if(isConfigured) {
               			// Purchasely setup is complete 
               )
            }
    }
}
```

# USER IDENTIFICATION

If you want the purchases and subscriptions to be associated to a user and not a device you can provide a user id in the`Purchasely.Builder()`method.
