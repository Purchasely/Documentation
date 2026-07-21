---
title: 12-Month Commitment (Paid Monthly)
excerpt: >-
  Sell an annual subscription paid in monthly installments with a 12-month
  commitment
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
A **12-month commitment paid monthly** lets your users subscribe to an annual plan while paying month by month: they commit to the full year, but instead of being charged the total price upfront, they are billed a smaller amount every month for 12 months.

This billing structure lowers the entry barrier of your annual plan (a $9.99 first charge converts better than a $119.88 one) while securing 12 months of revenue.

* On the **Apple App Store**, this is the *monthly subscription with a 12-month commitment* billing plan introduced with iOS 26.4.
* On **Google Play**, the equivalent mechanism is *installment subscriptions*. Purchasely support for Google Play installments is coming in a future release; this article currently covers Apple.

> 📘 Availability
>
> * **Apple App Store** — the commitment billing plan requires **iOS / iPadOS / tvOS / visionOS 26.4+** (and macOS Tahoe 26.4+), with general availability since 26.5
> * **Purchasely SDK 6.0+**, in **StoreKit 2** mode — available with our **iOS, Flutter, React Native and Cordova** SDKs
> * Available in **all countries except the United States and Singapore** (Apple restriction). You don't need to handle this yourself: Purchasely automatically serves the *1 Year Upfront* billing plan to users whose App Store country is not eligible, and to users on older iOS versions or older SDK versions

# How it works

The 12-month commitment is **not a new product**: it is an additional *billing plan* on an auto-renewable yearly subscription in App Store Connect. An eligible yearly product can therefore be sold in two ways:

| Billing plan | User is charged | Example |
| :--- | :--- | :--- |
| **1 Year Upfront** (default) | The full price, once a year | $119.88 today |
| **Monthly with 12-Month Commitment** | Every month, for 12 months | $9.99/month, $119.88/year in total |

With the monthly billing plan:

* Each monthly payment is an independent transaction that grants one month of access, like a regular monthly subscription.
* The user is committed to the full year: **if they cancel during the commitment, the monthly billing continues** until the end of the 12 periods, and they keep their access until the end of the commitment.
* At the end of the 12 payments, the commitment **renews automatically** for a new 12-month cycle, unless the user cancelled.
* **Upgrades** take effect immediately and end the commitment (standard Apple proration rules apply). **Downgrades** are deferred to the end of the commitment.
* The Billing Grace Period does not apply to commitments: if a monthly payment fails, access is suspended immediately and restored when the payment is recovered.

# Configuring your Plan

The first step is to enable the monthly commitment billing plan on your **yearly** Plan in the Purchasely Console:

1. Open your Plan in the Console (its **Period** must be *1 year (P1Y)*)
2. Select the **Apple** application store and fill in the **App Store Product id**
3. Under **Commitment billing type**, check **Monthly with 12-Month Commitment**

![Commitment billing type on a yearly Plan](images/commitment-plan-configuration.png)

* **1 Year Upfront** is always enabled for yearly plans and cannot be unchecked.
* **Monthly with 12-Month Commitment** requires the matching billing plan to be enabled on the same SKU in App Store Connect.

> 📘 Disabling the option afterwards
>
> If you uncheck *Monthly with 12-Month Commitment* while some screens still use it, those screens automatically fall back to the *1 Year Upfront* billing plan. No app update is needed.

# Configuring your Screen

Once enabled on the Plan, the monthly commitment can be selected per offering in the **Screen Composer**:

1. Open your Screen and go to the **Offering** tab
2. Select the **Plan** for your offering
3. A **Commitment billing type** field appears: select **Monthly with 12-Month Commitment**

![Commitment billing type on an offering in the Screen Composer](images/commitment-screen-offering.png)

The **Offer** dropdown depends on the selected billing type: promotional offers are scoped to a billing plan, so changing the *Commitment billing type* resets the selected offer. Make sure your promotional offers are associated with the right billing plan when you create them.

> 🚧 Plan usage restrictions
>
> On a screen, the same plan can only be used once. This means you cannot have a *1 Year Upfront* offering and a *Monthly with 12-Month Commitment* offering using the same plan (App Store product id). To display both billing options side by side on the same paywall, you need to use 2 different plans.

# Displaying the right prices with Tags

When an offering uses the **Monthly with 12-Month Commitment** billing type, the price [Tags](tags) are automatically interpreted against the commitment:

| Tag | Displays | Example |
| :--- | :--- | :--- |
| `{{PRICE}}` | The total annual commitment price, with its period | $119.88/year |
| `{{AMOUNT}}` | The total annual commitment amount, without period | $119.88 |
| `{{MONTHLY_AMOUNT}}` | The monthly installment amount | $9.99 |

*Example for a plan billed $9.99 every month, i.e. $119.88 over the 12-month commitment.*

For offerings using *1 Year Upfront* (or any plan without a commitment), the tags keep their usual behavior described in the [Tags](tags) section.

> 🚧 Apple requirement
>
> Apple requires you to **display both the monthly billing price and the total commitment amount** to the customer before they initiate a purchase. Combining `{{MONTHLY_AMOUNT}}` and `{{PRICE}}` (or `{{AMOUNT}}`) in your offering copy — e.g. *"\{\{MONTHLY_AMOUNT}}/month for 12 months (\{\{PRICE}} in total)"* — covers this requirement by default.

# SDK behavior

The billing plan is entirely driven by the Screen configuration: the SDK purchases with the billing plan you selected in the Console, with no code change required.

If your app takes over the purchase flow (**PaywallObserver** mode or a custom `purchase` action interceptor), the purchase action parameters expose the `billingPlanType` of the plan (`upFront` or `monthly`), so you can pass the matching purchase option to StoreKit.
