---
name: Paywall Action Interceptor - actions intercepted
---
# What Paywall Actions can be intercepted?

You can intercept the following buttons being tapped:

* Close
* Login
* Navigate (web or deeplink)
* Purchase
* Win-back / retention offer
* Restore
* Open Screen
* Open Placement
* Promo code

<Callout icon="🚧" theme="warn">
  Overriding the **open_presentation** or **open_placement** actions is not recommended.

  These actions are tightly coupled with Purchasely’s internal context. Overriding them can break the SDK’s ability to properly track A/B tests, audiences, and campaigns, leading to incorrect analytics and unexpected behavior.

  Such overrides should only be considered for very specific and advanced use cases. Before implementing them, please discuss your use case with Purchasely to ensure it does not negatively impact tracking, experimentation, or campaign attribution.
</Callout>
