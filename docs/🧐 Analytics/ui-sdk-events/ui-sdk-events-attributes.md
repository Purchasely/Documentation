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

| Attribute | Mandatory | Description |
| :--- | :--- | :--- |
| `sdk_version` | Yes | **string**<br><br>Contains the SDK version.<br><br>This attribute will be filled for all events. |
| `event_name` | Yes | **string**<br><br>Contains the name of the event.<br>[See the full list of SDK / UI Events](ui-sdk-events-list) |
| `event_created_at_ms` | Yes | **int**<br>_in milliseconds since the Epoch_<br><br>Contains the date which the event was sent the first time. In case of retry that attribute will still be set with the time at the first try. |
| `event_created_at` | Yes | **string**<br>_in ISO 8601_<br><br>Contains the date which the event was sent the first time. In case of retry that attribute will still be set with the time at the first try. |
| `user_id` | No | **string**<br><br>Contains the `user_id` associated to the <Glossary>Connected User</Glossary> when they are logged-in.<br><br>This attribute or the `anonymous_user_id` will be filled for all events |
| `anonymous_user_id` | No | **string**<br><br>Contains the `anonymous_user_id` associated to the <Glossary>Anonymous User</Glossary> when they are not logged-in (anonymous then)<br><br>This attribute or the `user_id` will be filled for all events |
| `displayed_presentation` | No | **string**<br><br>Contains the Presentation ID (field `ID` in the Purchasely Screen & Paywall Builder) that was displayed to the user.<br><br>_This attribute will be filled for every[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)_ |
| `placement_id` | No | **string**<br><br>Contains the Placement ID from where the presentation was triggered if any.<br><br>_This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)_ |
| `audience_id` | No | **string**<br><br>Contains the Audience ID matched for the user.<br><br>*This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) * |
| `ab_test_id` | No | **string**<br><br>Contains the AB test ID if the Event was triggered within an A/B Test.<br><br>_This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)_ |
| `ab_test_variant_id` | No | **string**<br><br>Contains the AB test variant ID if the Event was triggered within an A/B Test.<br><br>*This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) * |
| `flow_id` | No | **string**<br><br>Contains the Flow ID if the Event was triggered within a Flow.<br><br>*This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) * |
| `step_id` | No | **string**<br><br>Contains the Flow Step ID if the Event was triggered within a Flow.<br><br>*This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) * |
| `flow_version` | No | **string**<br><br>Contains the Flow Version ID if the Event was triggered within a Flow.<br><br>*This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) * |
| `from_action_id` | No | **string**<br><br>Contains the Flow Action Id of the previous step if the Event was triggered within a Flow as a next step.<br><br>*This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) * |
| `from_step_id` | No | **string**<br><br>Contains the previous Flow Step ID if the Event was triggered within a Flow.<br><br>*This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) * |
| `flow_session_id` | No | **string**<br><br>Contains the Flow Session ID if the Event was triggered within a Flow.<br><br>*This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) * |
| `display_mode` | No | **string**<br><br>Contains the Display Mode of the Screen if the Event was triggered.<br>It can be:<br><br>* full_screen<br>* push<br>* modal<br>* drawer<br>* popin<br><br>*This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) * |
| `content_id` | No | **string**<br><br>Contains the [Content ID](associating-content) provided by the App. |
| `deeplink_identifier` | No | **string**<br><br>Contains the deeplink used to display the Screen if any.<br><br>*This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) * |
| `purchasable_plans` | No | * *Array of Plans** (object described [here](#plans))<br><br>Contains all the Plans that are displayed in the Screen.<br><br>_This attribute will be filled for every[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)_ |
| `link_identifier` | No | **string**<br><br>Contains the url of the link the user just tapped on.<br><br>*This attribute will only be filled for the event`LINK_OPENED` * |
| `carousels` | No | * *Array of carousels** (object described [here](#carousels))<br><br>Contains all attributes for all displayed carousels in the Screen.<br><br>*This attribute will only be filled for[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)  if the Screen contains at least one carousel * |
| `language` | No | **string**<br>_in ISO 639-1_<br><br>Contains the language used in the displayed Screen.<br><br>_This attribute will be filled for every[UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)_ |
| `device` | Yes | string<br><br>Contains the device model used by the user. |
| `os_version` | Yes | **string**<br><br>Contains the OS version running on the user's device. |
| `type` | Yes | **string**<br><br>Contains the type of device used by the user.<br>Possible values:<br><br>* `PHONE`<br>* `TABLET`<br>* `TV` |
| `error_message` | No | **string**<br><br>Contains the error message the store returned when trying the action.<br><br>* That attribute will be filled for the events:<br>* `IN_APP_PURCHASE_FAILED`<br>* `IN_APP_NOT_AVAILABLE`<br>* `RESTORE_FAILED`<br>* `RECEIPT_FAILED` _ |
| `plan` | No | **string**<br><br>Contains the Plan ID of the Plan associated to the action if any (field `ID` of the Plan in the Purchasely Console)<br><br>* This attribute will be filled for events:<br>* [In-App Purchase Flow](ui-sdk-events-list##in-app-purchase-flow-events)<br>* [Restore](ui-sdk-events-list#restore-events)<br>* [Receipts](ui-sdk-events-list#receipts-events)<br>* `SUBSCRIPTION_CANCELLED_TAPPED`<br>* `SUBSCRIPTION_PLAN_TAPPED` |
| `selected_presentation` | No | **string**<br><br>Contains the currently selected Screen ID (field `ID` in the Screen & Paywall Builder).<br><br>_This attribute will be filled for`OPEN_PRESENTATION` and `SELECTED_PRESENTATION`_ |
| `previous_selected_presentation` | No | **string**<br><br>Contains the previously selected Screen ID (field `ID` in the Screen & Paywall Builder).<br><br>_This attribute will be filled for`OPEN_PRESENTATION` and `SELECTED_PRESENTATION`_ |
| `selected_product` | No | **string**<br><br>Contains the Product ID that is selected.<br><br>_This attribute will be filled for`SUBSCRIPTION_DETAILS_VIEWED` event._ |
| `plan_change_type` | No | **string**<br><br>Contains the type of plan change the user did.<br>Possible values:<br><br>* `CROSSGRADE`<br>* `DOWNGRADE`<br>* `UPGRADE`_This attribute will be filled for`SUBSCRIPTION_PLAN_TAPPED` event_ |
| `running_subscriptions` | No | **Array of string**<br><br>Contains pairs of Plan ID and Product ID for each active subscriptions the users has.<br><br>_This attribute will be filled for every SDK events_ |
| `cancellation_reason_id` | No | **string**<br><br>Contains the ID of the reason the user answered through the cancellation survey triggered with Purchasely.<br><br>_That attribute will be filled for`CANCELLATION_REASON_PUBLISHED` event_ |
| `cancellation_reason` | No | **string**<br><br>Contains the reason the user answered through the [cancellation survey](cancellation-survey) displayed by the Purchasely SDK.<br><br>_This attribute will be filled for`CANCELLATION_REASON_PUBLISHED` event_ |
| `selected_options` | NO | **string**<br><br>Contains the reason the user answered through the [cancellation survey](cancellation-survey)  displayed by the Purchasely SDK.<br><br>* This attribute will be filled for `OPTIONS_SELECTED` and `OPTIONS_VALIDATED` events |
| `selected_option_id` | NO | **string**<br><br>Contains the Option Id as set in the [Screen Composer](screen-composer) for a [plan picker](plan-pickers-horizontal), [survey](mcq), [faq](faq) or switch component.<br><br>_This attribute will be filled for`OPTIONS_SELECTED` and `OPTIONS_VALIDATED` events_ |
| `selected_options` | NO | **Array of Strings**<br><br>Contains options selected (event `OPTIONS_SELECTED`) or validated (event `OPTIONS_VALIDATED`) by the user. The values provided match with the options configured in the [Screen Composer](screen-composer).<br><br>_This attribute will be filled for`OPTIONS_SELECTED` and `OPTIONS_VALIDATED` events_ |
| `displayed_options` | NO | **Array of Strings**<br><br>List of options values displayed to the user. The values provided match with the options configured in the [Screen Composer](screen-composer).<br><br>_This attribute will be filled for`OPTIONS_SELECTED` and `OPTIONS_VALIDATED` events_ |

<br />

# Plans

| Attribute | Description |
| :--- | :--- |
| `type` | **string**<br><br>Contains the string representation of the type of plan of one of the available plan.<br><br>Possible values:<br><br>* `CONSUMABLE`<br>* `NON_CONSUMABLE`<br>* `NON_CONSUMABLE`<br>* `AUTO_RENEWING_SUBSCRIPTION`<br>* `NON_RENEWING_SUBSCRIPTION` |
| `purchasely_plan_id` | **string**<br><br>Contains the Plan ID of one of the purchasable Plan<br>(field `ID` of the Plan in the Purchasely Console) |
| `store` | **string**<br><br>Contains the store on which is available one of the available plan. |
| `store_country` | **string**<br>_in ISO 3166_<br><br>Contains the store country to which the user store account is associated<br>_E.g.: US for an iOS user which Apple ID was created on the US App Store_ |
| `store_product_id` | **string**<br><br>Contains the Product ID associated to the In-App Purchase or In-App Subscription in the store console (App Store Connect or Google Play Console) |
| `price_in_customer_currency` | **float**<br><br>Contains the standard price in the customer currency for one the available plan. |
| `customer_currency` | **string**<br>_in ISO 4217_<br><br>Contains the customer currency code. |
| `period` | **string**<br><br>Contains the string representation of the standard period of one of the available plan<br><br>Possible values:<br><br>* `DAY`<br>* `WEEK`<br>* `MONTH`<br>* `YEAR`This attribute will be filled only if the "type" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION` |
| `duration` | **int**<br><br>Contains the string representation of the number "period" of the standard periodicity of one of the available Plan. To get the standard periodicity of the plan you have to concatenate "duration" and "period".<br><br>This attribute will be filled only if the "type" of the corresponding plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION` |
| `intro_price_in_customer_currency` | **float**<br><br>Contains the introductory offer price in the customer currency for one the available Plan.<br><br>That attribute will be filled only if the Plan has a introductory offer available. |
| `intro_period` | **string**<br><br>Contains the string representation of the introductory offer period of one of the available plan<br><br>Possible values:<br><br>* `DAY`<br>* `WEEK`<br>* `MONTH`<br>* `YEAR`This attribute will be filled only if the "type" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION` only if the Plan has an introductory offer available. |
| `intro_duration` | **int**<br><br>Contains the string representation of the number "period" of the introductory offer periodicity of one of the available Plan. To get the introductory offer periodicity of the Plan you have to concatenate "duration" and "period".<br><br>This attribute will be filled only if the "type" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION`" only if the Plan has an introductory offer available. |
| `has_free_trial` | **bool**<br><br>True if a free trial is available for the plan. |
| `free_trial_period` | **string**<br><br>Contains the string representation of the free trial offer period of one of the available Plans<br><br>Possible values:<br><br>* `DAY`<br>* `WEEK`<br>* `MONTH`<br>* `YEAR`This attribute will be filled only if the "type" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION` only if the Plan has an free trial offer available. |
| `free_trial_duration` | **int**<br><br>Contains the string representation of the number "period" of the free trial offer periodicity of one of the available Plan. To get the free trial periodicity of the plan you have to concatenate "duration" and "period".<br><br>This attribute will be filled only if the "type" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION` only if the Plan has an free trial offer available. |
| `discount_referent` | **string**<br><br>Contains the Plan ID of the Plan that is used on the presentation to make a pricing comparison. |
| `discount_percentage_comparison_to_referent` | **string**<br><br>Contains the percentage of discount the Plan offers in comparison to the referent. |
| `discount_price_comparison_to_referent` | **float**<br><br>Contains the price difference between, the Plan and the referent. |
| `is_default` | **bool**<br><br>True if the Plan is selected by default in the Screen. |

<br />

# Carousels

| Attribute | Description |
| :--- | :--- |
| `selected_slide` | **int**<br><br>Contains the number of the current selected slide. |
| `number_of_slides` | **int**<br><br>Contains the total number of slides of the carousel. |
| `is_carousel_auto_playing` | **bool**<br><br>`true` if the carousel's slides switch automatically. |
| `default_slide` | **int**<br><br>Contains the number of the default selected slide. |
| `previous_slide` | **int**<br><br>Contains the number of the previously selected slide.<br><br>That attribute will only be filled for the event `CAROUSEL_SLIDE_SWIPED`. |

<br />

# Surveys

The following properties are only set for the events `OPTIONS_SELECTED` and `OPTIONS_VALIDATED` which are triggered when users interact with a Survey (Multiple Choice Component) or a Switch Component.

| Attribute | Description |
| :--- | :--- |
| `selected_option_id` | **string**<br><br>Contains the [Survey ID](https://docs.purchasely.com/docs/mcq#1-configuring-the-survey). |
| `selected_options` | **Array of Strings**<br><br>Contains answers selected (event `OPTIONS_SELECTED`) or validated (event `OPTIONS_VALIDATED`) by the user. The values provided match with the [Answers values](https://docs.purchasely.com/docs/mcq#4-configuring-the-answers-available-and-associated-texts) configured. |
| `displayed_options` | **Array of Strings**<br><br>List of Answers values displayed to the user. The values provided match with the [Answers values](https://docs.purchasely.com/docs/mcq#4-configuring-the-answers-available-and-associated-texts)  configured. |

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
  "running_subscriptions" : [
    {
      "plan" : "PURCHASELY_PLUS_MONTHLY",
      "product" : "PURCHASELY_PLUS"
    }
  ],
  "plan_change_type" : "UPGRADE"
}
```
```json OPTIONS_VALIDATED
{
  "event_created_at_ms_original": 1728564123906,
  "session_count": 34,
  "template": "COMPOSER",
  "language": "en",
  "displayed_presentation": "tc_nico",
  "event_created_at_original": "2024-10-10T12:42:03.906Z",
  "device": "iPhone14,2",
  "session_id": "3FFF09CC-25FF-4F6B-B089-C43DB068FE06",
  "type": "PHONE",
  "presentation_type": "NORMAL",
  "event_created_at_ms": 1728564123907,
  "os_version": "iOS 18.0",
  "session_duration": 747,
  "sdk_version": "5.0.0",
  "event_created_at": "2024-10-10T12:42:03.907Z",
  "app_installed_at_ms": 1727858985920,
  "is_fallback_presentation": false,
  "anonymous_user_id": "D2C2CE73-F5F0-4A27-A945-000635CFE39B",
  "app_installed_at": "2024-10-02T08:49:45.920Z",
  "event_name": "OPTIONS_VALIDATED",
  "user_id": "nico",
  "screen_duration": 339,
  "name": "OPTIONS_VALIDATED",
  "selected_option_id": "survey_1", // ID of the survey
  "selected_options": [
    "reponse_b",
    "reponse_c"
  ],																// Answers picked up by the user
  "displayed_options": [
    "reponse_a",
    "reponse_b",
    "reponse_c",
    "reponse_d",
    "reponse_e"
  ]																	// Answers displayed to the user
}
```
