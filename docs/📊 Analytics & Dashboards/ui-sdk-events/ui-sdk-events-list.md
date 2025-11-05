---
title: List of UI/SDK events
excerpt: This section provides details on all the UI/SDK events
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: View which attributes are associated to these UI / SDK Events
  pages:
    - type: basic
      slug: ui-sdk-events-attributes
      title: UI / SDK events attributes
---
# SDK events

[block:parameters]
{
  "data": {
    "h-0": "Event",
    "h-1": "Description",
    "h-2": "Value `iOS` / `Android`",
    "0-0": "`APP_INSTALLED`",
    "0-1": "First installation of the SDK",
    "0-2": "`.appInstalled` / `AppInstalled`",
    "1-0": "`APP_CONFIGURED`",
    "1-1": "The SDK is ready to make purchases",
    "1-2": "`.appConfigured` / `AppConfigured`",
    "2-0": "`APP_STARTED`",
    "2-1": "The app was launched",
    "2-2": "`.appStarted` / `AppStarted`",
    "3-0": "`APP_UPDATED`",
    "3-1": "The application version changed since last launch",
    "3-2": "`.appUpdated`  \n/ `AppUpdated`",
    "4-0": "`STORE_PRODUCT_FETCH_FAILED`",
    "4-1": "The Purchasely SDK couldn't fetch the product from the store",
    "4-2": "`.productFetchError` / `ProductFetchError`"
  },
  "cols": 3,
  "rows": 5,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


# UI & User Behavioral Events

[block:parameters]
{
  "data": {
    "h-0": "Event",
    "h-1": "Description",
    "h-2": "Value `iOS` / `Android`",
    "0-0": "`PRESENTATION_LOADED`",
    "0-1": "The Screen was loaded and is ready to be displayed",
    "0-2": "`.presentationLoaded` / `PresentationLoaded`",
    "1-0": "`PRESENTATION_VIEWED`",
    "1-1": "The Screen was opened",
    "1-2": "`.presentationViewed` / `PresentationViewed`",
    "2-0": "`PRESENTATION_CLOSED`",
    "2-1": "The Screen was closed",
    "2-2": "`.presentationClosed` / `PresentationClosed`",
    "3-0": "`PRESENTATION_SELECTED`",
    "3-1": "The user selected a different tab / tile in the Screen",
    "3-2": "`.presentationSelected`  \n/ `PresentationSelected`",
    "4-0": "`PRESENTATION_OPENED`",
    "4-1": "The user opened a different tab / tile in the Screen",
    "4-2": "`.presentationOpened` / `PresentationOpened`",
    "5-0": "`PLAN_SELECTED`",
    "5-1": "The user selected a Plan on the Screen",
    "5-2": "`.planSelected` / `PlanSelected`",
    "6-0": "`PURCHASE_TAPPED`",
    "6-1": "The user tapped on a purchase button",
    "6-2": "`.purchaseTapped` / `PurchaseTapped`",
    "7-0": "`PURCHASE_CANCELLED`",
    "7-1": "The user cancelled the purchase action",
    "7-2": "`.purchaseCancelled` / `PurchaseCancelled`",
    "8-0": "`LOGIN_TAPPED`",
    "8-1": "The user tapped on the login button",
    "8-2": "`.loginTapped` / `LoginTapped`",
    "9-0": "`RESTORE_TAPPED`",
    "9-1": "The user tapped on the restore button",
    "9-2": "`.restoreTapped` / `RestoreTapped`",
    "10-0": "`PROMO_CODE_TAPPED`",
    "10-1": "The user tapped on the promo code button",
    "10-2": "`.promoCodeTapped` / `PromoCodeTapped`",
    "11-0": "`DEEPLINK_OPENED`",
    "11-1": "The user opened a deeplink",
    "11-2": "`.deeplinkOpened` / `DeepLinkOpened`",
    "12-0": "`LINK_OPENED`",
    "12-1": "The user tapped a link (Terms and conditions, …)",
    "12-2": "`.linkOpened` / `LinkOpened`",
    "13-0": "`CAROUSEL_SLIDE_SWIPED`",
    "13-1": "The user  swiped to a different carousel tile",
    "13-2": "`.carouselSlideSwiped` /  \n`CarouselSlideSwiped`"
  },
  "cols": 3,
  "rows": 14,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


<br />

# In-App Purchase Flow Events

[block:parameters]
{
  "data": {
    "h-0": "Event",
    "h-1": "Description",
    "h-2": "Value `iOS` / `Android`",
    "0-0": "`IN_APP_PURCHASING`",
    "0-1": "The purchase started",
    "0-2": "`.inAppPurchasing` / `InAppPurchasing`",
    "1-0": "`IN_APP_PURCHASED`",
    "1-1": "The purchase succeeded",
    "1-2": "`.inAppPurchased` / `InAppPurchased`",
    "2-0": "`IN_APP_PURCHASE_FAILED`",
    "2-1": "The purchase failed",
    "2-2": "`.inAppPurchaseFailed` / `InAppPurchaseFailed`",
    "3-0": "`IN_APP_DEFERRED`",
    "3-1": "The user started a deferred payment (i.e. Ask to buy, PSD2 approval)",
    "3-2": "`.inAppDeferred`  \n/ `InAppDeferred`",
    "4-0": "`IN_APP_NOT_AVAILABLE`",
    "4-1": "The in-app purchase is not available to purchase.",
    "4-2": "NA / `InAppNotAvailable`",
    "5-0": "`PURCHASE_CANCELLED_BY_APP`",
    "5-1": "The app cancelled the purchase process",
    "5-2": "`.purchaseCancelledByApp` / `PurchaseCancelledByApp`"
  },
  "cols": 3,
  "rows": 6,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


# Receipts Events

| Event               | Description                               | Value `iOS` / `Android`                  |
| :------------------ | :---------------------------------------- | :--------------------------------------- |
| `RECEIPT_CREATED`   | The purchase was registered at Purchasely | `.receiptCreated` / `ReceiptCreated`     |
| `RECEIPT_FAILED`    | The purchase was rejected                 | `.receiptFailed` / `ReceiptFailed`       |
| `RECEIPT_VALIDATED` | The purchase was validated                | `.receiptValidated` / `ReceiptValidated` |

# Restore Events

| Event               | Description                                                                             | Value `iOS` / `Android`                  |
| :------------------ | :-------------------------------------------------------------------------------------- | :--------------------------------------- |
| `RESTORE_STARTED`   | The restoration started                                                                 | `.restoreStarted` / `RestoreStarted`     |
| `RESTORE_FAILED`    | The restoration failed                                                                  | `.restoreFailed` / `RestoreFailed`       |
| `IN_APP_RESTORED`   | The user restored its purchases after attempting to purchase a product he already owned | `.inAppRestored` / `InAppRestored`       |
| `RESTORE_SUCCEEDED` | The restoration succeeded                                                               | `.restoreSucceeded` / `RestoreSucceeded` |

# Login Events

| Event             | Description        | Value `iOS` / `Android`            |
| :---------------- | :----------------- | :--------------------------------- |
| `USER_LOGGED_IN`  | The user logged in | `.userLoggedIn` / `UserLoggedIn`   |
| `USER_LOGGED_OUT` | A user logged out  | `.userLoggedOut` / `UserLoggedOut` |

# Miscellaneous Events

| Event                           | Description                                                        | Value `iOS` / `Android`                                        |
| :------------------------------ | :----------------------------------------------------------------- | :------------------------------------------------------------- |
| `CANCELLATION_REASON_PUBLISHED` | The user replied to the [cancellation survey](cancellation-survey) | `.cancellationReasonPublished` / `CancellationReasonPublished` |
| `SUBSCRIPTION_DETAILS_VIEWED`   | Detail page of a subscription viewed                               | `.subscriptionDetailsViewed` / `SubscriptionDetailsViewed`     |
| `SUBSCRIPTION_PLAN_TAPPED`      | Tapped to change plan                                              | `.subscriptionPlanTapped` / `SubscriptionPlanTapped`           |
| `SUBSCRIPTIONS_LIST_VIEWED`     | Subscriptions list viewed                                          | `.subscriptionsListViewed` / `SubscriptionListViewed`          |
| `PURCHASE_FROM_STORE_TAPPED`    | The user opened the app from a Promoted In-App Purchase            | `.purchaseFromStoreTapped` / NA                                |