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

[block:parameters]
{
  "data": {
    "h-0": "Attribute",
    "h-1": "Mandatory",
    "h-2": "Description",
    "0-0": "`sdk_version`",
    "0-1": "Yes",
    "0-2": "**string**  \n  \nContains the SDK version.  \n  \nThis attribute will be filled for all events.",
    "1-0": "`event_name`",
    "1-1": "Yes",
    "1-2": "**string**  \n  \nContains the name of the event.  \n[See the full list of SDK / UI Events](ui-sdk-events-list)",
    "2-0": "`event_created_at_ms`",
    "2-1": "Yes",
    "2-2": "**int**  \n_in milliseconds since the Epoch_  \n  \nContains the date which the event was sent the first time. In case of retry that attribute will still be set with the time at the first try.",
    "3-0": "`event_created_at`",
    "3-1": "Yes",
    "3-2": "**string**  \n_in ISO 8601_  \n  \nContains the date which the event was sent the first time. In case of retry that attribute will still be set with the time at the first try.",
    "4-0": "`user_id`",
    "4-1": "No",
    "4-2": "**string**  \n  \nContains the `user_id` associated to the <<glossary:Connected User>> when they are logged-in.  \n  \nThis attribute or the `anonymous_user_id` will be filled for all events",
    "5-0": "`anonymous_user_id`",
    "5-1": "No",
    "5-2": "**string**  \n  \nContains the `anonymous_user_id` associated to the <<glossary:Anonymous User>> when they are not logged-in (anonymous then)  \n  \nThis attribute or the `user_id` will be filled for all events",
    "6-0": "`displayed_presentation`",
    "6-1": "No",
    "6-2": "**string**  \n  \nContains the Presentation ID (field `ID` in the Purchasely Screen & Paywall Builder) that was displayed to the user.  \n  \n_This attribute will be filled for every [UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)_",
    "7-0": "`placement_id`",
    "7-1": "No",
    "7-2": "**string**  \n  \nContains the Placement ID from where the presentation was triggered if any.  \n  \n_This attribute will only be filled for [UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)_",
    "8-0": "`audience_id`",
    "8-1": "No",
    "8-2": "**string**  \n  \nContains the Audience ID matched for the user.  \n  \n_This attribute will only be filled for [UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) _",
    "9-0": "`ab_test_id`",
    "9-1": "No",
    "9-2": "**string**  \n  \nContains the AB test ID if the Event was triggered within an A/B Test.  \n  \n_This attribute will only be filled for [UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)_",
    "10-0": "`ab_test_variant_id`",
    "10-1": "No",
    "10-2": "**string**  \n  \nContains the AB test variant ID if the Event was triggered within an A/B Test.  \n  \n_This attribute will only be filled for [UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) _",
    "11-0": "`content_id`",
    "11-1": "No",
    "11-2": "**string**  \n  \nContains the [Content ID](associating-content) provided by the App.",
    "12-0": "`deeplink_identifier`",
    "12-1": "No",
    "12-2": "**string**  \n  \nContains the deeplink used to display the Screen if any.  \n  \n_This attribute will only be filled for [UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events) _",
    "13-0": "`purchasable_plans`",
    "13-1": "No",
    "13-2": "**Array of Plans** (object described [here](#plans))  \n  \nContains all the Plans that are displayed in the Screen.  \n  \n_This attribute will be filled for every [UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)_",
    "14-0": "`link_identifier`",
    "14-1": "No",
    "14-2": "**string**  \n  \nContains the url of the link the user just tapped on.  \n  \n_This attribute will only be filled for the event `LINK_OPENED` _",
    "15-0": "`carousels`",
    "15-1": "No",
    "15-2": "**Array of carousels** (object described [here](#carousels))  \n  \nContains all attributes for all displayed carousels in the Screen.  \n  \n_This attribute will only be filled for [UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)  if the Screen contains at least one carousel _",
    "16-0": "`language`",
    "16-1": "No",
    "16-2": "**string**  \n_in ISO 639-1_  \n  \nContains the language used in the displayed Screen.  \n  \n_This attribute will be filled for every [UI & User Behavior events](ui-sdk-events-list#ui--user-behavioral-events)_",
    "17-0": "`device`",
    "17-1": "Yes",
    "17-2": "string  \n  \nContains the device model used by the user.",
    "18-0": "`os_version`",
    "18-1": "Yes",
    "18-2": "**string**  \n  \nContains the OS version running on the user's device.",
    "19-0": "`type`",
    "19-1": "Yes",
    "19-2": "**string**  \n  \nContains the type of device used by the user.  \nPossible values:  \n  \n- `PHONE`\n- `TABLET`\n- `TV`",
    "20-0": "`error_message`",
    "20-1": "No",
    "20-2": "**string**  \n  \nContains the error message the store returned when trying the action.  \n  \n\\_That attribute will be filled for the events:  \n  \n- `IN_APP_PURCHASE_FAILED`\n- `IN_APP_NOT_AVAILABLE`\n- `RESTORE_FAILED`\n- `RECEIPT_FAILED` \\_",
    "21-0": "`plan`",
    "21-1": "No",
    "21-2": "**string**  \n  \nContains the Plan ID of the Plan associated to the action if any (field `ID` of the Plan in the Purchasely Console)  \n  \n\\_This attribute will be filled for events:  \n  \n- [In-App Purchase Flow](ui-sdk-events-list##in-app-purchase-flow-events)\n- [Restore](ui-sdk-events-list#restore-events)\n- [Receipts](ui-sdk-events-list#receipts-events)\n- `SUBSCRIPTION_CANCELLED_TAPPED`\n- `SUBSCRIPTION_PLAN_TAPPED`",
    "22-0": "`selected_presentation`",
    "22-1": "No",
    "22-2": "**string**  \n  \nContains the currently selected Screen ID (field `ID` in the Screen & Paywall Builder).  \n  \n_This attribute will be filled for `OPEN_PRESENTATION` and `SELECTED_PRESENTATION`_",
    "23-0": "`previous_selected_presentation`",
    "23-1": "No",
    "23-2": "**string**  \n  \nContains the previously selected Screen ID (field `ID` in the Screen & Paywall Builder).  \n  \n_This attribute will be filled for `OPEN_PRESENTATION` and `SELECTED_PRESENTATION`_",
    "24-0": "`selected_product`",
    "24-1": "No",
    "24-2": "**string**  \n  \nContains the Product ID that is selected.  \n  \n_This attribute will be filled for `SUBSCRIPTION_DETAILS_VIEWED` event._",
    "25-0": "`plan_change_type`",
    "25-1": "No",
    "25-2": "**string**  \n  \nContains the type of plan change the user did.  \nPossible values:  \n  \n- `CROSSGRADE`\n- `DOWNGRADE`\n- `UPGRADE`_This attribute will be filled for `SUBSCRIPTION_PLAN_TAPPED` event_",
    "26-0": "`running_subscriptions`",
    "26-1": "No",
    "26-2": "**Array of string**  \n  \nContains pairs of Plan ID and Product ID for each active subscriptions the users has.  \n  \n_This attribute will be filled for every SDK events_",
    "27-0": "`cancellation_reason_id`",
    "27-1": "No",
    "27-2": "**string**  \n  \nContains the ID of the reason the user answered through the cancellation survey triggered with Purchasely.  \n  \n_That attribute will be filled for `CANCELLATION_REASON_PUBLISHED` event_",
    "28-0": "`cancellation_reason`",
    "28-1": "No",
    "28-2": "**string**  \n  \nContains the reason the user answered through the [cancellation survey](cancellation-survey) displayed by the Purchasely SDK.  \n  \n_This attribute will be filled for `CANCELLATION_REASON_PUBLISHED` event_",
    "29-0": "`selected_options`",
    "29-1": "NO",
    "29-2": "**string**  \n  \nContains the reason the user answered through the [cancellation survey](cancellation-survey)  displayed by the Purchasely SDK.  \n  \n\\_This attribute will be filled for `OPTIONS_SELECTED` and `OPTIONS_VALIDATED` events",
    "30-0": "`selected_option_id`",
    "30-1": "NO",
    "30-2": "**string**  \n  \nContains the Option Id as set in the [Screen Composer](screen-composer) for a [plan picker](plan-pickers-horizontal), [survey](mcq), [faq](faq) or switch component.  \n  \n_This attribute will be filled for `OPTIONS_SELECTED` and `OPTIONS_VALIDATED` events_",
    "31-0": "`selected_options`",
    "31-1": "NO",
    "31-2": "**Array of Strings**  \n  \nContains options selected (event `OPTIONS_SELECTED`) or validated (event `OPTIONS_VALIDATED`) by the user. The values provided match with the options configured in the [Screen Composer](screen-composer).  \n  \n_This attribute will be filled for `OPTIONS_SELECTED` and `OPTIONS_VALIDATED` events_",
    "32-0": "`displayed_options`",
    "32-1": "NO",
    "32-2": "**Array of Strings**  \n  \nList of options values displayed to the user. The values provided match with the options configured in the [Screen Composer](screen-composer).  \n  \n_This attribute will be filled for `OPTIONS_SELECTED` and `OPTIONS_VALIDATED` events_"
  },
  "cols": 3,
  "rows": 33,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


<br />

# Plans

[block:parameters]
{
  "data": {
    "h-0": "Attribute",
    "h-1": "Description",
    "0-0": "`type`",
    "0-1": "**string**  \n  \nContains the string representation of the type of plan of one of the available plan.  \n  \nPossible values:  \n  \n- `CONSUMABLE`\n- `NON_CONSUMABLE`\n- `NON_CONSUMABLE`\n- `AUTO_RENEWING_SUBSCRIPTION`\n- `NON_RENEWING_SUBSCRIPTION`",
    "1-0": "`purchasely_plan_id`",
    "1-1": "**string**  \n  \nContains the Plan ID of one of the purchasable Plan  \n(field `ID` of the Plan in the Purchasely Console)",
    "2-0": "`store`",
    "2-1": "**string**  \n  \nContains the store on which is available one of the available plan.",
    "3-0": "`store_country`",
    "3-1": "**string**  \n_in ISO 3166_  \n  \nContains the store country to which the user store account is associated  \n_E.g.: US for an iOS user which Apple ID was created on the US App Store_",
    "4-0": "`store_product_id`",
    "4-1": "**string**  \n  \nContains the Product ID associated to the In-App Purchase or In-App Subscription in the store console (App Store Connect or Google Play Console)",
    "5-0": "`price_in_customer_currency`",
    "5-1": "**float**  \n  \nContains the standard price in the customer currency for one the available plan.",
    "6-0": "`customer_currency`",
    "6-1": "**string**  \n_in ISO 4217_  \n  \nContains the customer currency code.",
    "7-0": "`period`",
    "7-1": "**string**  \n  \nContains the string representation of the standard period of one of the available plan  \n  \nPossible values:  \n  \n- `DAY`\n- `WEEK`\n- `MONTH`\n- `YEAR`This attribute will be filled only if the \"type\" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION`",
    "8-0": "`duration`",
    "8-1": "**int**  \n  \nContains the string representation of the number \"period\" of the standard periodicity of one of the available Plan. To get the standard periodicity of the plan you have to concatenate \"duration\" and \"period\".  \n  \nThis attribute will be filled only if the \"type\" of the corresponding plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION`",
    "9-0": "`intro_price_in_customer_currency`",
    "9-1": "**float**  \n  \nContains the introductory offer price in the customer currency for one the available Plan.  \n  \nThat attribute will be filled only if the Plan has a introductory offer available.",
    "10-0": "`intro_period`",
    "10-1": "**string**  \n  \nContains the string representation of the introductory offer period of one of the available plan  \n  \nPossible values:  \n  \n- `DAY`\n- `WEEK`\n- `MONTH`\n- `YEAR`This attribute will be filled only if the \"type\" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION` only if the Plan has an introductory offer available.",
    "11-0": "`intro_duration`",
    "11-1": "**int**  \n  \nContains the string representation of the number \"period\" of the introductory offer periodicity of one of the available Plan. To get the introductory offer periodicity of the Plan you have to concatenate \"duration\" and \"period\".  \n  \nThis attribute will be filled only if the \"type\" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION`\" only if the Plan has an introductory offer available.",
    "12-0": "`has_free_trial`",
    "12-1": "**bool**  \n  \nTrue if a free trial is available for the plan.",
    "13-0": "`free_trial_period`",
    "13-1": "**string**  \n  \nContains the string representation of the free trial offer period of one of the available Plans  \n  \nPossible values:  \n  \n- `DAY`\n- `WEEK`\n- `MONTH`\n- `YEAR`This attribute will be filled only if the \"type\" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION` only if the Plan has an free trial offer available.",
    "14-0": "`free_trial_duration`",
    "14-1": "**int**  \n  \nContains the string representation of the number \"period\" of the free trial offer periodicity of one of the available Plan. To get the free trial periodicity of the plan you have to concatenate \"duration\" and \"period\".  \n  \nThis attribute will be filled only if the \"type\" of the corresponding Plan is `AUTO_RENEWING_SUBSCRIPTION` and `NON_RENEWING_SUBSCRIPTION` only if the Plan has an free trial offer available.",
    "15-0": "`discount_referent`",
    "15-1": "**string**  \n  \nContains the Plan ID of the Plan that is used on the presentation to make a pricing comparison.",
    "16-0": "`discount_percentage_comparison_to_referent`",
    "16-1": "**string**  \n  \nContains the percentage of discount the Plan offers in comparison to the referent.",
    "17-0": "`discount_price_comparison_to_referent`",
    "17-1": "**float**  \n  \nContains the price difference between, the Plan and the referent.",
    "18-0": "`is_default`",
    "18-1": "**bool**  \n  \nTrue if the Plan is selected by default in the Screen."
  },
  "cols": 2,
  "rows": 19,
  "align": [
    "left",
    "left"
  ]
}
[/block]


<br />

# Carousels

[block:parameters]
{
  "data": {
    "h-0": "Attribute",
    "h-1": "Description",
    "0-0": "`selected_slide`",
    "0-1": "**int**  \n  \nContains the number of the current selected slide.",
    "1-0": "`number_of_slides`",
    "1-1": "**int**  \n  \nContains the total number of slides of the carousel.",
    "2-0": "`is_carousel_auto_playing`",
    "2-1": "**bool**  \n  \n`true` if the carousel's slides switch automatically.",
    "3-0": "`default_slide`",
    "3-1": "**int**  \n  \nContains the number of the default selected slide.",
    "4-0": "`previous_slide`",
    "4-1": "**int**  \n  \nContains the number of the previously selected slide.  \n  \nThat attribute will only be filled for the event `CAROUSEL_SLIDE_SWIPED`."
  },
  "cols": 2,
  "rows": 5,
  "align": [
    "left",
    "left"
  ]
}
[/block]


<br />

# Surveys

The following properties are only set for the events `OPTIONS_SELECTED` and `OPTIONS_VALIDATED` which are triggered when users interact with a Survey (Multiple Choice Component) or a Switch Component.

[block:parameters]
{
  "data": {
    "h-0": "Attribute",
    "h-1": "Description",
    "0-0": "`selected_option_id`",
    "0-1": "**string**  \n  \nContains the [Survey ID](https://docs.purchasely.com/docs/mcq#1-configuring-the-survey).",
    "1-0": "`selected_options`",
    "1-1": "**Array of Strings**  \n  \nContains answers selected (event `OPTIONS_SELECTED`) or validated (event `OPTIONS_VALIDATED`) by the user. The values provided match with the [Answers values](https://docs.purchasely.com/docs/mcq#4-configuring-the-answers-available-and-associated-texts) configured.",
    "2-0": "`displayed_options`",
    "2-1": "**Array of Strings**  \n  \nList of Answers values displayed to the user. The values provided match with the [Answers values](https://docs.purchasely.com/docs/mcq#4-configuring-the-answers-available-and-associated-texts)  configured."
  },
  "cols": 2,
  "rows": 3,
  "align": [
    "left",
    "left"
  ]
}
[/block]


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