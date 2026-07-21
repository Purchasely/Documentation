---
name: >-
  Understanding running modes | full mode & observer mode quick overview
  and benefits
---
# Understanding running modes

Purchasely offers two running modes to fit your app's setup:

* `observer` mode (default): your existing system keeps processing the in-app transactions (in-house or a 3rd party such as RevenueCat) — Purchasely just observes them.
* `full` mode: Purchasely processes the in-app transactions end to end and acts as your subscription infrastructure.

> 📘 `observer` is the default running mode
>
> Since v6, the SDK starts in `observer` mode by default. Set the `runningMode` parameter of [`Purchasely.start()`](sdk-initialization) to `full` if you want Purchasely to handle the transactions.

<br />

## `full` mode vs. `observer` mode

|                                             | `observer` mode *(default)*                               | `full` mode                                      |
| ------------------------------------------- | --------------------------------------------------------- | ------------------------------------------------ |
| **Who processes the transaction**           | Your existing system (in-house / RevenueCat…)             | Purchasely                                       |
| **Receipt validation & acknowledgement**    | You (the developer)                                       | Purchasely, automatically                        |
| **Subscription infrastructure to maintain** | Yours — kept as-is                                        | None — Purchasely *is* the infrastructure        |
| **How a purchase is triggered**             | The SDK hands over to your app via the Action Interceptor | The SDK launches the native in-app purchase flow |
| **No-code growth features**                 | ✅                                                         | ✅                                                |
| **Best for**                                | Apps with an existing purchase system                     | New apps or teams starting with in-app purchases |

<br />

## The same no-code features in both modes

Whichever mode you pick, you get the full set of [no-code growth features](main-features):

* **No-code Paywall & Screen builder** — create and update paywalls and in-app screens without writing code
* **A/B Testing** — test designs and offers to optimize conversion
* **Audience Targeting** — deliver personalized content and offers
* **Campaign Automations** — win-back, retention and conversion campaigns
* **3rd-party integrations** — analytics, CRM, attribution and more

They let growth and marketing teams ship in-app funnels instantly — no developer involvement, no app update — while staying compliant with the App stores guidelines thanks to the built-in paywall verifications.

<br />

## Which mode should I choose?

* Choose **`observer`** if you already have a working subscription system (in-house or a 3rd party like RevenueCat) and just want Purchasely's paywalls, analytics and growth tools on top — no migration required.
* Choose **`full`** if you're starting with in-app purchases and want Purchasely to be your subscription infrastructure. It saves the 3–6 months usually spent building store integrations, and removes the maintenance when stores ship new billing versions (Google Play Billing, StoreKit…).

You can switch between modes at any time from the SDK initialization.

[How the observer mode works](observer-mode) · [How the full mode works](full-mode)
