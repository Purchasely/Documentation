---
title: User properties for 3rd-party integrations (CRM / Engagement Platforms)
excerpt: DO NOT PUBLISH
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
<Table align={["left","left","left","left"]}>
  <thead>
    <tr>
      <th style={{ textAlign: "left" }}>
        Property
      </th>

      <th style={{ textAlign: "left" }}>
        Type
      </th>

      <th style={{ textAlign: "left" }}>
        Description
      </th>

      <th style={{ textAlign: "left" }}>
        To be hidden
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td style={{ textAlign: "left" }}>
        `anonymous_user_id`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        If the user didn't create an account, Purchasely creates an anonymous ID.  

        This attribute is meant to be used rather for testing purposes to target a specific anonymous user
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `user_id`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the `user_id` that holds the purchase.  

        That attribute will be filled with the `user_id` you provided to the SDK.
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `has_active_subscription`
      </td>

      <td style={{ textAlign: "left" }}>
        Bool
      </td>

      <td style={{ textAlign: "left" }}>
        If the user has an active subscription.  

        It can be either `true` or `false`.
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `environment`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the environment from where the purchase was made.  

        Possible values:\
        SANDBOX\
        PRODUCTION
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `store`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the name of the Store through which the purchase was made.  

        Possible values:\
        `APPLE_APP_STORE`\
        `GOOGLE_PLAY_STORE`\
        `AMAZON_APPSTORE`\
        `HUAWEI_APPGALLERY`\
        `STRIPE`
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `product`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the Product id (=subscription group id) that carries the plan that was bought.
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `plan`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the Plan ID that was bought.
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `plan_periodicity`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Periodicity of the active Plan.  

        Possible value:\
        `P1W` - weekly\
        `P2W` - bi-weekly\
        `P1M` - monthly\
        `P2M` - bi-monthly\
        `P3M` - quarterly\
        `P6M` - semi-annually\
        `P1Y` - annually
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `subscription_status`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the current status of the subscription.  

        Possible Values :\
        `AUTO_RENEWING`\
        `ON_HOLD`\
        `IN_GRACE_PERIOD`\
        `AUTO_RENEWING_CANCELED`\
        `DEACTIVATED`\
        `REVOKED`\
        `PAUSED`\
        `UNPAID`
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `offer_type`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the current offer the subscription is under.  

        Possible values:\
        `NONE`: the user is paying the normal price, no offer associated\
        `FREE_TRIAL`\
        `INTRO_OFFER`\
        `PROMO_CODE`\
        `PROMOTIONAL_OFFER`
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `is_family_shared`
      </td>

      <td style={{ textAlign: "left" }}>
        Bool
      </td>

      <td style={{ textAlign: "left" }}>
        Contains true or false depending on if the user has access to the subscription thanks to family sharing.
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `content_id`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        [ID of the content that was associated to the purchase](associating-content)   if any
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `original_purchased_at`
      </td>

      <td style={{ textAlign: "left" }}>
        Date
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the date of the first transaction for the active subscription.
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `subscription_started_at`
      </td>

      <td style={{ textAlign: "left" }}>
        Date
      </td>

      <td style={{ textAlign: "left" }}>
        Active subscription start date
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `effective_next_renewal_at`
      </td>

      <td style={{ textAlign: "left" }}>
        Date
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the effective next renewal date, taking any grace or defer periods into account. If the subscription isn’t in grace or deferring period the effective date is equal to next\_renewal\_at.
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `promotional_offer_id`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the promotional offer identifier used when a customer successfully redeems a promotional offer.
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `purchased_at`
      </td>

      <td style={{ textAlign: "left" }}>
        Date
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the date of the last transaction (original purchase or renewal).
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `store_country`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the store country where the purchase was made.  

        Can be NULL in case the subscription was purchased before Purchasely was implemented in your system.
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `store_product_id`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the product\_id you created in the store console.
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `offer_code_ref_name`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the offer code ref name used when a customer successfully redeems an offer code.
      </td>

      <td style={{ textAlign: "left" }}>
        yes (useless at the user level)
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `previous_offer_type`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the previous offer the subscription was under.  

        Possible values:  

        `NONE`: the user was paying the normal price, no offer associated\
        `FREE_TRIAL`\
        `INTRO_OFFER`\
        `PROMO_CODE`\
        `PROMOTIONAL_OFFER`
      </td>

      <td style={{ textAlign: "left" }}>
        yes (useless at the user level)
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `offer_identifier`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the offer identifier used when a customer successfully redeems an offer code or a promotional offer.  

        This attribute is filled for the following event :\
        `PROMO_CODE_STARTED`\
        `PROMO_CODE_CONVERTED`\
        `PROMO_CODE_NOT_CONVERTED`\
        `PROMOTIONAL_OFFER_STARTED`\
        `PROMOTIONAL_OFFER_CONVERTED`\
        `PROMOTIONAL_OFFER_NOT_CONVERTED`
      </td>

      <td style={{ textAlign: "left" }}>
        yes (useless at the user level)
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `previous_plan`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the Plan ID the customer used to have before changing plan.
      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `auto_resume_at`
      </td>

      <td style={{ textAlign: "left" }}>
        Date
      </td>

      <td style={{ textAlign: "left" }}>
        When the subscription is on pause (Google Play only), this is the date at which the subscription will be resumed
      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `placement`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the id of the placement from where the subscription was bought.
      </td>

      <td style={{ textAlign: "left" }}>
        yes (not a user property)
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `purchase_type`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the type of In-App Purchase  

        Possible values:\
        `CONSUMABLE`\
        `NON_CONSUMABLE`\
        `NON_RENEWING_SUBSCRIPTION` `RENEWING_SUBSCRIPTION`
      </td>

      <td style={{ textAlign: "left" }}>
        yes (does not make sense as a user property)
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `presentation`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        Contains the id of the associated presentation when the initial purchase was made.
      </td>

      <td style={{ textAlign: "left" }}>
        yes (not a user property)
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `grace_period_expires_at`
      </td>

      <td style={{ textAlign: "left" }}>
        Date
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `purchasely_one_time_purchase_id`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `purchasely_subscription_id`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `defer_end_at`
      </td>

      <td style={{ textAlign: "left" }}>
        Date
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `store_original_transaction_id`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `store_transaction_id`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `is_auto_renewing`
      </td>

      <td style={{ textAlign: "left" }}>
        Bool
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `is_in_billing_retry`
      </td>

      <td style={{ textAlign: "left" }}>
        Bool
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `is_in_grace_period`
      </td>

      <td style={{ textAlign: "left" }}>
        Bool
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `is_in_intro_offer`
      </td>

      <td style={{ textAlign: "left" }}>
        Bool
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `is_in_trial`
      </td>

      <td style={{ textAlign: "left" }}>
        Bool
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `is_promo_code`
      </td>

      <td style={{ textAlign: "left" }}>
        Bool
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `last_event`
      </td>

      <td style={{ textAlign: "left" }}>
        ?
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `next_renewal_at`
      </td>

      <td style={{ textAlign: "left" }}>
        Date
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `trial_ends_at`
      </td>

      <td style={{ textAlign: "left" }}>
        Date
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        yes
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        Missing Properties to be implemented 👇
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `cumulated_revenue_in_usd`
      </td>

      <td style={{ textAlign: "left" }}>
        Float
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `has_expired_subscription`
      </td>

      <td style={{ textAlign: "left" }}>
        Bool
      </td>

      <td style={{ textAlign: "left" }}>
        `true` if the user has an expired subscription.
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `expired_subscription_expired_at`
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `expired_subscription_status`
      </td>

      <td style={{ textAlign: "left" }}>
        String
      </td>

      <td style={{ textAlign: "left" }}>
        The lapsed subscription status. It will be either one of the following:  

        Onhold: The user is in the billing retry state.  

        Deactivated: The user voluntarily terminated their subscription.  

        Revoked: The user requested for the refund and revoked their subscription.  

        Paused: The user has paused the subscription instead of terminated it. It is available only for Android users.  

        Unpaid: The billing retry has ended.
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `expired_subscription_plan`
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        The name of the plan for which the user's subscription expired or its the last subscription the user had. The value is one of the plans you have created in Products and Plans in the Purchasely console.
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `expired_subscription_offer_type`
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>
        The offer type of the expired subscription when it got terminated. It can have one of the following values:  

        `FREE_TRIAL`: User was in Free Trial.  

        `PROMOTIONAL_OFFER`: User was benefitting from a promotional offer.  

        `INTRO_OFFER`: User was benefitting from a discounted introductory price (not free)  

        `PROMO_CODE`: User was benifiting from a Promo Code.  

        `NONE`: User was paying the full price (regular price) for the subscription
      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `expired_subscrption_duration_in_days`
      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>

      </td>

      <td style={{ textAlign: "left" }}>

      </td>
    </tr>
  </tbody>
</Table>
