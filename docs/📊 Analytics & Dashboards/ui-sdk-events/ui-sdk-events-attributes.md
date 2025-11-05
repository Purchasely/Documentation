---
title: UI / SDK events attributes
excerpt: This section provides details on the UI / SDK events attributes
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Events properties

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th style={{ textAlign: "left" }}>
        Attribute
      </th>

      <th style={{ textAlign: "left" }}>
        Mandatory
      </th>

      <th style={{ textAlign: "left" }}>
        Description
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td style={{ textAlign: "left" }}>
        `sdk_version`
      </td>

      <td style={{ textAlign: "left" }}>
        Yes
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the SDK version.  

        This attribute will be filled for all events.
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `event_name`
      </td>

      <td style={{ textAlign: "left" }}>
        Yes
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the name of the event.\
        [See the full list of SDK / UI Events](ui-sdk-events-list)
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `event_created_at_ms`
      </td>

      <td style={{ textAlign: "left" }}>
        Yes
      </td>

      <td style={{ textAlign: "left" }}>
        **int**\
        *in milliseconds since the Epoch*  

        Contains the date which the event was sent the first time. In case of retry that attribute will still be set with the time at the first try.
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `event_created_at`
      </td>

      <td style={{ textAlign: "left" }}>
        Yes
      </td>

      <td style={{ textAlign: "left" }}>
        **string**\
        *in ISO 8601*  

        Contains the date which the event was sent the first time. In case of retry that attribute will still be set with the time at the first try.
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `user_id`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the `user_id` associated to the <Glossary>Connected User</Glossary> when they are logged-in.  

        This attribute or the `anonymous_user_id` will be filled for all events
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `anonymous_user_id`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the `anonymous_user_id` associated to the <Glossary>Anonymous User</Glossary> when they are not logged-in (anonymous then)  

        This attribute or the `user_id` will be filled for all events
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `displayed_presentation`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the Presentation ID (field `ID` in the Purchasely Screen & Paywall Builder) that was displayed to the user.  

        *This attribute will be filled for every[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `placement_id`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the Placement ID from where the presentation was triggered if any.  

        *This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `ab_test_id`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the AB test ID if the Event was triggered within an A/B Test.  

        *This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `variant_id`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the AB test variant ID if the Event was triggered within an A/B Test.  

        *This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) *
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `deeplink_identifier`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the deeplink used to display the Screen if any.  

        *This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) *
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `purchasable_plans`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        * \*Array of Plans\*\* (object described [here](#plans))  

        Contains all the Plans that are displayed in the Screen.  

        *This attribute will be filled for every[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `selected_plan`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the Plan ID of the selected Plan if any (field `ID` of the Plan in the Purchasely Console)  

        *This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `previous_selected_plan`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the Plan ID of the previously selected Plan if any (field `ID` of the Plan in the Purchasely Console)  

        *This attribute will only be filled for the event`PLAN_SELECTED`* 
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `link_identifier`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the url of the link the user just tapped on.  

        *This attribute will only be filled for the event`LINK_OPENED` *
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `carousels`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        * \*Array of carousels\*\* (object described [here](#carousels))  

        Contains all attributes for all displayed carousels in the Screen.  

        *This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)  if the Screen contains at least one carousel *
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `language`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**\
        *in ISO 639-1*  

        Contains the language used in the displayed Screen.  

        *This attribute will be filled for every[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `device`
      </td>

      <td style={{ textAlign: "left" }}>
        Yes
      </td>

      <td style={{ textAlign: "left" }}>
        string  

        Contains the device model used by the user.
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `os_version`
      </td>

      <td style={{ textAlign: "left" }}>
        Yes
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the OS version running on the user's device.
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `type`
      </td>

      <td style={{ textAlign: "left" }}>
        Yes
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the type of device used by the user.\
        Possible values:  

        * `PHONE`
        * `TABLET`
        * `TV`
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `error_message`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the error message the store returned when trying the action.  

        * That attribute will be filled for the events:  
        * `IN_APP_PURCHASE_FAILED`
        * `IN_APP_NOT_AVAILABLE`
        * `RESTORE_FAILED`
        * `RECEIPT_FAILED` \_
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `plan`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the Plan ID of the Plan associated to the action if any (field `ID` of the Plan in the Purchasely Console)  

        * This attribute will be filled for events:  
        * [In-App Purchase Flow](ui-sdk-events-list##in-app-purchase-flow-events)
        * [Restore](ui-sdk-events-list#restore-events)
        * [Receipts](ui-sdk-events-list#receipts-events)
        * `SUBSCRIPTION_CANCELLED_TAPPED`
        * `SUBSCRIPTION_PLAN_TAPPED`
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `selected_presentation`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the currently selected Screen ID (field `ID` in the Screen & Paywall Builder).  

        *This attribute will be filled for`OPEN_PRESENTATION` and `SELECTED_PRESENTATION`*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `previous_selected_presentation`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the previously selected Screen ID (field `ID` in the Screen & Paywall Builder).  

        *This attribute will be filled for`OPEN_PRESENTATION` and `SELECTED_PRESENTATION`*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `selected_product`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the Product ID that is selected.  

        *This attribute will be filled for`SUBSCRIPTION_DETAILS_VIEWED` event.*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `plan_change_type`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the type of plan change the user did.\
        Possible values:  

        * `CROSSGRADE`
        * `DOWNGRADE`
        * `UPGRADE`*This attribute will be filled for`SUBSCRIPTION_PLAN_TAPPED` event*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `running_subscriptions`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **Array of string**  

        Contains pairs of Plan ID and Product ID for each active subscriptions the users has.  

        *This attribute will be filled for every SDK events*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `cancellation_reason_id`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the ID of the reason the user answered through the cancellation survey triggered with Purchasely.  

        *That attribute will be filled for`CANCELLATION_REASON_PUBLISHED` event*
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `cancellation_reason`
      </td>

      <td style={{ textAlign: "left" }}>
        No
      </td>

      <td style={{ textAlign: "left" }}>
        **string**  

        Contains the reason the user answered through the [cancellation survey](cancellation-survey) displayed by the Purchasely SDK.  

        *This attribute will be filled for`CANCELLATION_REASON_PUBLISHED` event*
      </td>
    </tr>
  </tbody>
</Table>

<br />

<br />

# Plans

<Table align={["left","left"]}>
  <thead>
    <tr>
      <th>
        Attribute
      </th>

      <th>
        Description
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        `type`
      </td>

      <td>
        **string**  

        Contains the string representation of the type of plan of one of the available plan.  

        Possible values:  

        * `CONSUMABLE`
        * `NON_CONSUMABLE`
        * `NON_CONSUMABLE`
        * `AUTO_RENEWING_SUBSCRIPTION`
        * `NON_RENEWING_SUBSCRIPTION`
      </td>
    </tr>

    <tr>
      <td>
        `purchasely_plan_id`
      </td>

      <td>
        **string**  

        Contains the Plan ID of one of the purchasable Plan\
        (field `ID` of the Plan in the Purchasely Console)
      </td>
    </tr>

    <tr>
      <td>
        `store`
      </td>

      <td>
        **string**  

        Contains the store on which is available one of the available plan.
      </td>
    </tr>

    <tr>
      <td>
        `store_country`
      </td>

      <td>
        **string**\
        *in ISO 3166*  

        Contains the store country to which the user store account is associated\
        *E.g.: US for an iOS user which Apple ID was created on the US App Store*
      </td>
    </tr>

    <tr>
      <td>
        `store_product_id`
      </td>

      <td>
        **string**  

        Contains the Product ID associated to the In-App Purchase or In-App Subscription in the store console (App Store Connect or Google Play Console)
      </td>
    </tr>

    <tr>
      <td>
        `price_in_customer_currency`
      </td>

      <td>
        **float**  

        Contains the standard price in the customer currency for one the available plan.
      </td>
    </tr>

    <tr>
      <td>
        `customer_currency`
      </td>

      <td>
        **string**\
        *in ISO 4217*  

        Contains the customer currency code.
      </td>
    </tr>

    <tr>
      <td>
        `period`
      </td>

      <td>
        **string**  

        Contains the string representation of the standard period of one of the available plan  

        Possible values:  

        * `DAY`
        * `WEEK`
        * `MONTH`
        * `YEAR`This attribute will be filled only if the "type" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION`
      </td>
    </tr>

    <tr>
      <td>
        `duration`
      </td>

      <td>
        **int**  

        Contains the string representation of the number "period" of the standard periodicity of one of the available Plan. To get the standard periodicity of the plan you have to concatenate "duration" and "period".  

        This attribute will be filled only if the "type" of the corresponding plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION`
      </td>
    </tr>

    <tr>
      <td>
        `intro_price_in_customer_currency`
      </td>

      <td>
        **float**  

        Contains the introductory offer price in the customer currency for one the available Plan.  

        That attribute will be filled only if the Plan has a introductory offer available.
      </td>
    </tr>

    <tr>
      <td>
        `intro_period`
      </td>

      <td>
        **string**  

        Contains the string representation of the introductory offer period of one of the available plan  

        Possible values:  

        * `DAY`
        * `WEEK`
        * `MONTH`
        * `YEAR`This attribute will be filled only if the "type" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION` only if the Plan has an introductory offer available.
      </td>
    </tr>

    <tr>
      <td>
        `intro_duration`
      </td>

      <td>
        **int**  

        Contains the string representation of the number "period" of the introductory offer periodicity of one of the available Plan. To get the introductory offer periodicity of the Plan you have to concatenate "duration" and "period".  

        This attribute will be filled only if the "type" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION`" only if the Plan has an introductory offer available.
      </td>
    </tr>

    <tr>
      <td>
        `has_free_trial`
      </td>

      <td>
        **bool**  

        True if a free trial is available for the plan.
      </td>
    </tr>

    <tr>
      <td>
        `free_trial_period`
      </td>

      <td>
        **string**  

        Contains the string representation of the free trial offer period of one of the available Plans  

        Possible values:  

        * `DAY`
        * `WEEK`
        * `MONTH`
        * `YEAR`This attribute will be filled only if the "type" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION` only if the Plan has an free trial offer available.
      </td>
    </tr>

    <tr>
      <td>
        `free_trial_duration`
      </td>

      <td>
        **int**  

        Contains the string representation of the number "period" of the free trial offer periodicity of one of the available Plan. To get the free trial periodicity of the plan you have to concatenate "duration" and "period".  

        This attribute will be filled only if the "type" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION` only if the Plan has an free trial offer available.
      </td>
    </tr>

    <tr>
      <td>
        `discount_referent`
      </td>

      <td>
        **string**  

        Contains the Plan ID of the Plan that is used on the presentation to make a pricing comparison.
      </td>
    </tr>

    <tr>
      <td>
        `discount_percentage_comparison_to_referent`
      </td>

      <td>
        **string**  

        Contains the percentage of discount the Plan offers in comparison to the referent.
      </td>
    </tr>

    <tr>
      <td>
        `discount_price_comparison_to_referent`
      </td>

      <td>
        **float**  

        Contains the price difference between, the Plan and the referent.
      </td>
    </tr>

    <tr>
      <td>
        `is_default`
      </td>

      <td>
        **bool**  

        True if the Plan is selected by default in the Screen.
      </td>
    </tr>
  </tbody>
</Table>

<br />

# Carousels

<Table align={["left","left"]}>
  <thead>
    <tr>
      <th>
        Attribute
      </th>

      <th>
        Description
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        `selected_slide`
      </td>

      <td>
        **int**  

        Contains the number of the current selected slide.
      </td>
    </tr>

    <tr>
      <td>
        `number_of_slides`
      </td>

      <td>
        **int**  

        Contains the total number of slides of the carousel.
      </td>
    </tr>

    <tr>
      <td>
        `is_carousel_auto_playing`
      </td>

      <td>
        **bool**  

        `true` if the carousel's slides switch automatically.
      </td>
    </tr>

    <tr>
      <td>
        `default_slide`
      </td>

      <td>
        **int**  

        Contains the number of the default selected slide.
      </td>
    </tr>

    <tr>
      <td>
        previous\_slide
      </td>

      <td>
        **int**  

        Contains the number of the previously selected slide.  

        That attribute will only be filled for the event `CAROUSEL_SLIDE_SWIPED`.
      </td>
    </tr>
  </tbody>
</Table>

<br />

# Payload sample

```json PRESENTATION_VIEWED
{
  "event_name" : "PRESENTATION_VIEWED",
  "event_created_at" : "2021-12-06T10:20:44.818Z",
  "event_created_at_ms" : 1638786044818,
  "device" : "arm64",
  "type" : "PHONE",
  "os_version" : "iOS 16.1.1",
  "sdk_version" : "4.1.0",
  "language" : "en",
  "user_id" : "23DE2D20-7878-414C-B2EC-4B1E632995EB",
  "displayed_presentation" : "YOUR_PAYWALL_ID",
  "template" : "PRES_Y90FJV4M1ZZQF1C8PECVZC3WPMKYUP",
  "selected_plan" : "PURCHASELY_PLUS_MONTHLY",
  "purchasable_plans" : [
    {
      "store_country" : "FRA",
      "price_in_customer_currency" : 40.99,
      "duration" : 1,
      "period" : "YEAR",
      "has_free_trial" : true,
      "free_trial_duration" : 2,
      "free_trial_period" : "MONTH",
      "customer_currency" : "EUR",
      "is_default" : false,
      "type" : "AUTO_RENEWING_SUBSCRIPTION",
      "store" : "APPLE_APP_STORE",
      "purchasely_plan_id" : "PURCHASELY_PLUS_YEARLY",
      "store_product_id" : "com.purchasely.plus.yearly"
    },
    {
      "customer_currency" : "EUR",
      "has_free_trial" : false,
      "duration" : 6,
      "store" : "APPLE_APP_STORE",
      "purchasely_plan_id" : "PURCHASELY_PLUS_6MONTHS",
      "price_in_customer_currency" : 65.99,
      "type" : "AUTO_RENEWING_SUBSCRIPTION",
      "period" : "MONTH",
      "store_product_id" : "com.purchasely.plus.6months",
      "is_default" : false,
      "store_country" : "FRA"
    },
    {
      "is_default" : true,
      "intro_price_in_customer_currency" : 0.49,
      "price_in_customer_currency" : 9.49,
      "intro_period" : "MONTH",
      "type" : "AUTO_RENEWING_SUBSCRIPTION",
      "store_product_id" : "com.purchasely.plus.monthly",
      "intro_duration" : 3,
      "store_country" : "FRA",
      "customer_currency" : "EUR",
      "has_free_trial" : false,
      "period" : "MONTH",
      "purchasely_plan_id" : "PURCHASELY_PLUS_MONTHLY",
      "store" : "APPLE_APP_STORE",
      "duration" : 1
    }
  ],
  "carousels" : [
    {
      "default_slide" : 1,
      "is_carousel_auto_playing" : false,
      "number_of_slides" : 8,
      "selected_slide" : 1
    }
  ]
}
```
```json CAROUSEL_SLIDE_SWIPED
{
  "event_name" : "CAROUSEL_SLIDE_SWIPED",
  "event_created_at" : "2021-12-06T10:20:44.818Z",
  "event_created_at_ms" : 1638786044818,
  "device" : "iPhone13,4",
  "type" : "PHONE",
  "os_version" : "iOS 17.1",
  "sdk_version" : "4.3.0",
  "language" : "en",
  "anonymous_user_id" : "67C77206-F279-4932-B322-69DC4319B517",
  "displayed_presentation" : "YOUR_PAYWALL_ID",
  "template" : "A6F9DC4D-6A90-42B6-BBE9-AA9BA3AFFEFC",
  "selected_plan" : "PURCHASELY_PLUS_MONTHLY",
  "purchasable_plans" : [
    {
      "purchasely_plan_id" : "PURCHASELY_PLUS_YEARLY",
      "is_default" : false,
      "store" : "APPLE_APP_STORE",
      "period" : "YEAR",
      "has_free_trial" : true,
      "store_product_id" : "com.purchasely.plus.yearly",
      "price_in_customer_currency" : 43.99,
      "free_trial_period" : "MONTH",
      "customer_currency" : "USD",
      "store_country" : "USA",
      "free_trial_duration" : 2,
      "type" : "AUTO_RENEWING_SUBSCRIPTION",
      "duration" : 1
    },
    {
      "store_product_id" : "com.purchasely.plus.6months",
      "price_in_customer_currency" : 74.99,
      "store" : "APPLE_APP_STORE",
      "is_default" : false,
      "customer_currency" : "USD",
      "type" : "AUTO_RENEWING_SUBSCRIPTION",
      "duration" : 6,
      "purchasely_plan_id" : "PURCHASELY_PLUS_6MONTHS",
      "store_country" : "USA",
      "period" : "MONTH",
      "has_free_trial" : false
    },
    {
      "is_default" : true,
      "period" : "MONTH",
      "intro_price_in_customer_currency" : 0.49,
      "intro_duration" : 3,
      "duration" : 1,
      "store_product_id" : "com.purchasely.plus.monthly",
      "intro_period" : "MONTH",
      "store_country" : "USA",
      "has_free_trial" : false,
      "type" : "AUTO_RENEWING_SUBSCRIPTION",
      "store" : "APPLE_APP_STORE",
      "customer_currency" : "USD",
      "price_in_customer_currency" : 9.99,
      "purchasely_plan_id" : "PURCHASELY_PLUS_MONTHLY"
    }
  ],
  "carousels" : [
    {
      "previous_slide" : 2,
      "number_of_slides" : 8,
      "default_slide" : 1,
      "selected_slide" : 3,
      "is_carousel_auto_playing" : false
    }
  ]
}
```
```json SUBSCRIPTION_PLAN_TAPPED
{
  "event_name" : "SUBSCRIPTION_PLAN_TAPPED",
  "event_created_at" : "2021-12-06T10:20:44.818Z",
  "event_created_at_ms" : 1638786044818,
  "device" : "iPhone13,4",
  "type" : "PHONE",
  "os_version" : "iOS 17.1",
  "sdk_version" : "4.3.0",
  "language" : "en",
  "anonymous_user_id" : "23DE2D20-7878-414C-B2EC-4B1E632995EB",
  "displayed_presentation" : "YOUR_PAYWALL_ID",
  "template" : "A6F9DC4D-6A90-42B6-BBE9-AA9BA3AFFEFC",
  "selected_plan" : "PURCHASELY_PLUS_MONTHLY",
  "running_subscriptions" : [
    {
      "plan" : "PURCHASELY_PLUS_MONTHLY",
      "product" : "PURCHASELY_PLUS"
    }
  ],
  "plan_change_type" : "UPGRADE"
}
```
