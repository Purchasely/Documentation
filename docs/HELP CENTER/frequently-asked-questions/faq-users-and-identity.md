---
title: Users & identity
excerpt: >-
  Pseudonymous identifiers, anonymous users, subscription transfer on login,
  logout behavior, and unknown users.
deprecated: false
hidden: false
metadata:
  title: 'FAQ: Users & identity'
  description: >-
    How Purchasely identifies users, whether pseudonymous identifiers are enough,
    how anonymous users behave across devices and reinstalls, what happens on
    userLogin and userLogout, and what unknown users are.
  robots: index
next:
  description: ''
---
# Can Purchasely work entirely with pseudonymous or anonymous identifiers, with no email and no phone number?

Yes, with no loss of functionality. Purchasely never asks for an email address or a phone number. The identifier you pass to `userLogin()` is an **opaque string of your choosing** — an internal UUID is enough.

With a pseudonymous ID:

* **Analytics** — all [UI / SDK events](ui-sdk-events-list) and all [Server Events](server-events) carry that ID.
* **A/B tests** — cohort assignment is a hash of the identifier (bucket 0 to 99), so it is deterministic and stable whether the ID is pseudonymous or not.
* **Segmentation and Audiences** — based on the [user attributes](user-attributes-list) you push yourself. Nothing forces you to put directly identifying data in them.

Two recommendations:

* **Do not use an email address as the user ID.** That would bring PII into the platform for no benefit.
* **Do not hash your ID at the last moment on the app side.** It must stay stable and consistent with your webhooks and your backend, otherwise you lose the link between users and their subscriptions.

<br />

# How do anonymous users work exactly?

If you never call `userLogin()`, the SDK generates an `anonymous_user_id` automatically.

| Topic                             | Behavior                                                                                                                                                                                                                          |
| :-------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Lifetime**                      | Tied to the installation. Stable as long as the app stays installed. Uninstalling loses the ID, with no way to recover it.                                                                                                         |
| **Multi-device**                  | No. The anonymous ID is per installation. Cross-device continuity requires a stable application-level ID that you provide.                                                                                                         |
| **Entitlements**                  | Purchases are attached to the `anonymous_user_id`. Our webhooks carry that field instead of `user_id`.                                                                                                                             |
| **Anonymous → logged-in**         | On `userLogin()`, Purchasely transfers the subscription to your ID automatically. A `shouldRefreshCredentials` callback tells you whether to refresh the user's rights. On the webhook side: `DEACTIVATE` on the anonymous ID and `ACTIVATE` on the connected one. |
| **Logout**                        | `userLogout()` removes the application ID, the SDK falls back to the device's anonymous ID, and user attributes are purged (this last behavior can be disabled).                                                                    |

Two limits worth knowing:

* **Consumables and non-consumables are not transferable** from the anonymous user to the connected account. Subscriptions are.
* If the user **uninstalls before logging in**, the anonymous history is lost. A store restore will still find the subscription, but the original event attribution is gone.

> 💡 Support best practice
>
> Surface the `anonymous_user_id` somewhere in the app — a "My subscriptions" screen, or the footer of your contact email. It saves an enormous amount of time when debugging a user-specific issue. [Debug Mode](debug-mode) also displays it.

📚 [Understanding user types](understanding-user-types) · [Identifying users](user-identification)

<br />

# Are there features that require a direct identifier?

No. You can stay entirely on pseudonymous IDs. The only nuances are architectural constraints, not identifier requirements:

* **Multi-device and account continuity** need a stable ID on your side. Pseudonymous is fine, but the SDK's anonymous ID is not enough.
* **Third-party integrations** (Braze, Airship, Iterable, Amplitude, MMPs…) work with whatever ID you give us. It is the downstream tool that has to resolve it, not us. You can also switch that forwarding off entirely with `revokeDataProcessingConsent([.thirdPartyIntegrations])` — see [Managing user privacy](privacy-settings).
* **Residual case: unknown users.** A purchase that reaches us only through a store notification has no identifier at all. See below.

<br />

# What exactly happens when I call `userLogin()`?

```swift Swift
Purchasely.userLogin(with: "123456789") { shouldRefreshCredentials in
    if shouldRefreshCredentials {
        // A subscription was transferred — refresh the user's rights from your backend
    }
}
```
```kotlin Kotlin
Purchasely.userLogin("123456789") { shouldRefresh ->
    if (shouldRefresh) {
        // A subscription was transferred — refresh the user's rights from your backend
    }
}
```

1. The identifier is attached to the device.
2. If the anonymous user had an active subscription, it is transferred to your identifier.
3. The callback returns `true` when a transfer happened, which is your signal to re-fetch entitlements from your backend.
4. Your webhook endpoint receives a `DEACTIVATE` for the anonymous ID and an `ACTIVATE` for the connected one.

> ❗️ Call `userLogin()` before displaying any paywall
>
> If a purchase is made before the user is identified, it is attached to the anonymous ID and will need a transfer. Set the ID in the builder at init if you already know it, or call `userLogin()` as soon as the session is restored.

<br />

# What happens on `userLogout()`?

```swift Swift
Purchasely.userLogout()
```
```kotlin Kotlin
Purchasely.userLogout(clearUserAttributes = true) // default
```

The application ID is removed and the SDK falls back to the device's anonymous ID. User attributes are cleared by default — pass `false` if you need them to survive the logout.

The subscription itself stays attached to the identifier that owned it. It is not returned to the anonymous user.

<br />

# Should I hash my user ID before passing it?

Only if the hash is **stable and computed the same way everywhere** — app, backend, webhook consumers. A per-session or per-device hash breaks the link between the user, their subscription and your webhooks, and there is no way to repair it afterwards.

In practice, an internal UUID that is already non-identifying is a better answer than hashing something identifying.

<br />

# What are "unknown users"?

A purchase that reaches our servers only through a **store notification**, with no identifier attached. It happens when:

* the purchase was made on an app version that did not have the SDK yet,
* the subscription was obtained through family sharing,
* an error interrupted the purchase (app killed, network loss),
* you are in [Observer mode](observer-mode) and the transaction completed outside the action interceptor without a `Purchasely.synchronize()` call.

Consequences:

* They appear in the subscription and one-time purchase listings in the Console.
* **No webhook is sent** and nothing is forwarded to your integrations (this can be enabled on request — contact us).
* [S2S forwarding](s2s-notifications-forwarding) keeps working.

They resolve themselves in most cases: family-shared subscriptions attach automatically when the member opens the app, and an interrupted purchase is fixed by the user tapping **Restore** at the bottom of the paywall.

📚 [Understanding user types](understanding-user-types)

<br />

# What if the user reinstalls the app?

* **Logged-in user** — nothing to do. `userLogin()` with the same ID restores the entitlements from our backend.
* **Anonymous user** — a new `anonymous_user_id` is generated. The store still knows about the subscription, so **Restore** recovers the entitlement, but the previous anonymous history and its event attribution are gone.

<br />

# Can the same subscription serve two accounts?

Not by design. A subscription is attached to one identifier at a time, and a transfer moves it rather than duplicating it. Family sharing is the exception the stores provide: the member gets access, the event carries `is_family_shared: true`, and `FAMILY_SHARED_REVOKED` fires when the owner removes access.

<br />

# How do I find a specific user in the Console?

Search by user ID, anonymous user ID, or a store transaction identifier.

📚 [Finding users in the Console](finding-users-in-the-console) · [User subscriptions history](user-subscriptions-history)
