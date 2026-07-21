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

- On the **Apple App Store**, this is the _monthly subscription with a 12-month commitment_ billing plan introduced with iOS 26.4. It requires a dedicated configuration in the Purchasely Console, detailed in the [Apple App Store](#apple-app-store) section below.
- On **Google Play**, the equivalent mechanism is _installment subscriptions_, which Purchasely supports out of the box: everything is configured in the Google Play Console, see the [Google Play Store](#google-play-store) section below.

# Apple App Store

<Callout icon="📘" theme="info">
  ### Availability

  - **Apple App Store** — the commitment billing plan requires **iOS / iPadOS / tvOS / visionOS 26.4+** (and macOS Tahoe 26.4+), with general availability since 26.5
  - **Purchasely SDK 6.0+**, in **StoreKit 2** mode — available with our **iOS, Flutter, React Native and Cordova** SDKs
  - Available in **all countries except the United States and Singapore** (Apple restriction). You don't need to handle this yourself: Purchasely automatically serves the _1 Year Upfront_ billing plan to users whose App Store country is not eligible, and to users on older iOS versions or older SDK versions
</Callout>

## How it works

The 12-month commitment is **not a new product**: it is an additional _billing plan_ on an auto-renewable yearly subscription in App Store Connect. An eligible yearly product can therefore be sold in two ways:

| Billing plan                         | User is charged             | Example                            |
| :----------------------------------- | :-------------------------- | :--------------------------------- |
| **1 Year Upfront** (default)         | The full price, once a year | $119.88 today                      |
| **Monthly with 12-Month Commitment** | Every month, for 12 months  | $9.99/month, $119.88/year in total |

With the monthly billing plan:

- Each monthly payment is an independent transaction that grants one month of access, like a regular monthly subscription.
- The user is committed to the full year: **if they cancel during the commitment, the monthly billing continues** until the end of the 12 periods, and they keep their access until the end of the commitment.
- At the end of the 12 payments, the commitment **renews automatically** for a new 12-month cycle, unless the user cancelled.
- **Upgrades** take effect immediately and end the commitment (standard Apple proration rules apply). **Downgrades** are deferred to the end of the commitment.
- The Billing Grace Period does not apply to commitments: if a monthly payment fails, access is suspended immediately and restored when the payment is recovered.

## Configuring your Plan

The first step is to enable the monthly commitment billing plan on your **yearly** Plan in the Purchasely Console:

1. Open your Plan in the Console (its **Period** must be _1 year (P1Y)_)
2. Select the **Apple** application store and fill in the **App Store Product id**
3. Under **Commitment billing type**, check **Monthly with 12-Month Commitment**


<Image src="https://files.readme.io/804800d736893609c5a65fca7fcd8dd63143bcecf7d175b9e6bb7759939a0165-CleanShot_2026-07-21_at_10.43.152x.png" align="center" caption="Enable Monthly with 12-Month Commitment for your Yearly plan" border={true} />


<br />

- **1 Year Upfront** is always enabled for yearly plans and cannot be unchecked.
- **Monthly with 12-Month Commitment** requires the matching billing plan to be enabled on the same SKU in App Store Connect.

<Callout icon="📘" theme="info">
  ### Disabling the option afterwards

  If you uncheck _Monthly with 12-Month Commitment_ while some screens still use it, those screens automatically fall back to the _1 Year Upfront_ billing plan. No app update is needed.
</Callout>

## Configuring your Screen

Once enabled on the Plan, the monthly commitment can be selected per offering in the **Screen Composer**:

1. Open your Screen and go to the **Offering** tab
2. Select the **Plan** for your offering
3. A **Commitment billing type** field appears: select **Monthly with 12-Month Commitment**


<Image src="https://files.readme.io/f87ed0dc5ddd476d761be10c513d8c2ea7febca93f7f06ad6c4cc548f8d87c97-CleanShot_2026-07-21_at_10.44.222x.png" align="center" caption="Select the billing type Monthly for your offering in your Screen" border={true} />


<br />

The **Offer** dropdown depends on the selected billing type: promotional offers are scoped to a billing plan, so changing the _Commitment billing type_ resets the selected offer. Make sure your promotional offers are associated with the right billing plan when you create them.

<Callout icon="🚧" theme="warn">
  ### Plan usage restrictions

  On a screen, the same plan can only be used once. This means you cannot have a _1 Year Upfront_ offering and a _Monthly with 12-Month Commitment_ offering using the same plan (App Store product id). To display both billing options side by side on the same paywall, you need to use 2 different plans.
</Callout>

## Displaying the right prices with Tags

When an offering uses the **Monthly with 12-Month Commitment** billing type, the price [Tags](tags) are automatically interpreted against the commitment:

| Tag                  | Displays                                           | Example      |
| :------------------- | :------------------------------------------------- | :----------- |
| `{{PRICE}}`          | The total annual commitment price, with its period | $119.88/year |
| `{{AMOUNT}}`         | The total annual commitment amount, without period | $119.88      |
| `{{MONTHLY_AMOUNT}}` | The monthly installment amount                     | $9.99        |

_Example for a plan billed $9.99 every month, i.e. $119.88 over the 12-month commitment._

For offerings using _1 Year Upfront_ (or any plan without a commitment), the tags keep their usual behavior described in the [Tags](tags) section.

<Callout icon="🚧" theme="warn">
  ### Apple requirement

  Apple requires you to **display both the monthly billing price and the total commitment amount** to the customer before they initiate a purchase. Combining `{{MONTHLY_AMOUNT}}` and `{{PRICE}}` (or `{{AMOUNT}}`) in your offering copy — e.g. _"\{\{MONTHLY_AMOUNT\}\}/month for 12 months (\{\{PRICE\}\} in total)"_ — covers this requirement by default.
</Callout>

## SDK behavior

The billing plan is entirely driven by the Screen configuration: the SDK purchases with the billing plan you selected in the Console, with no code change required.

If your app takes over the purchase flow (**Observer** mode or a custom `purchase` action interceptor), you need to know which billing plan the offering is selling to pass the matching purchase option to StoreKit. The [action interceptor](paywall-action-interceptor) gives you all the commitment information:

* `params.billingPlanType` (iOS): the billing plan selected on the offering in the Screen Composer (`upFront`, `monthly`, or `unspecified` for a regular plan)
* `plan.commitmentInfo`: the billing plans available on the store product, each with its billing price, billing period, total price and number of payments

```swift Swift
Purchasely.interceptAction(.purchase) { info, params, completion in
    guard let plan = params?.plan,
          let productId = plan.appleProductId else {
        completion(.notHandled)
        return
    }

    // Billing plan selected on the offering in the Screen Composer:
    // .upFront, .monthly, or .unspecified for a regular plan
    let billingPlanType = params?.billingPlanType ?? .unspecified

    // Billing plans available on the store product (empty below iOS 26.4)
    for commitment in plan.commitmentInfo {
        print("""
        \(commitment.billingPlanType): \
        \(commitment.billingPrice) per \(commitment.billingPeriod), \
        \(commitment.totalPrice) in total over \(commitment.totalDuration) payment(s)
        """)
        // monthly: 9.99 per P1M, 119.88 in total over 12 payment(s)
        // upFront: 119.88 per P1Y, 119.88 in total over 1 payment(s)
    }

    Task {
        do {
            guard let product = try await Product.products(for: [productId]).first else {
                completion(.failed)
                return
            }

            var options: Set<Product.PurchaseOption> = []
            if billingPlanType == .monthly, #available(iOS 26.4, *) {
                options.insert(.billingPlanType(.monthly))
            }

            let result = try await product.purchase(options: options)
            // Process the result with your own purchase infrastructure,
            // then let the SDK synchronize the transaction
            completion(.success)
        } catch {
            completion(.failed)
        }
    }
}
```
```dart Flutter
await Purchasely.interceptAction(
  PLYPresentationActionKind.purchase,
  (info, payload) async {
    if (payload is! PLYPurchasePayload) {
      return PLYInterceptResult.notHandled;
    }

    final storeProductId = payload.plan.productId;

    // Billing plans available on the store product
    // (Apple only, empty below iOS 26.4 and on other platforms)
    for (final commitment in payload.plan.commitmentInfo) {
      debugPrint('${commitment.billingPlanType}: '
          '${commitment.billingPrice} per ${commitment.billingPeriod}, '
          '${commitment.totalPrice} in total over ${commitment.totalDuration} payment(s)');
      // PLYBillingPlanType.monthly: 9.99 per P1M, 119.88 in total over 12 payment(s)
      // PLYBillingPlanType.upFront: 119.88 per P1Y, 119.88 in total over 1 payment(s)
    }

    final success = await MyPurchaseSystem.purchase(storeProductId);
    if (success) {
      // SDK auto-synchronizes on success in observer mode
      await info.presentation?.close();
      return PLYInterceptResult.success;
    }
    return PLYInterceptResult.failed;
  },
);
```

# Google Play Store

On Google Play, the same mechanism is called an **installment subscription**: the subscriber pays a fixed amount every month over a commitment period, and the plan renews automatically at the end of the commitment.

Purchasely supports Google Play installment subscriptions out of the box, with no particular prerequisite: there is no billing type to enable on your Plan or your Screen. The whole configuration lives in the **Google Play Console**, where you create an installment base plan (commitment duration and renewal type) on your subscription. Purchasely then sells and tracks it like any other subscription.

To learn more about creating installment plans, check Google's documentation:

* [Installment subscriptions in the Play Billing overview](https://developer.android.com/google/play/billing/subscriptions)
* [Create and manage subscriptions in the Play Console](https://support.google.com/googleplay/android-developer/answer/140504)

> 📘 Google installment subscriptions are only available in a limited set of countries (Brazil, France, Italy and Spain at the time of writing). Refer to Google's documentation above for the up-to-date list.

# Server events

On the backend side, each monthly installment billed to a committed subscriber generates an `INSTALLMENT_PAID` webhook event (12 per year for a committed subscription). Refunding a past installment generates `INSTALLMENT_REFUNDED` instead, without closing the subscription or ending the commitment. Events for a committed subscription also carry dedicated `commitment_*` attributes (installment number, commitment expiration date, auto-renewal status, and more). See [Lifecycle Events](lifecycle-events) and [Server Events Attributes](server-events-attributes) for details.
