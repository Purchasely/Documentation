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

| Event | Description | Value `iOS` / `Android` |
| :--- | :--- | :--- |
| `APP_INSTALLED` | First installation of the SDK | `.appInstalled` / `AppInstalled` |
| `APP_CONFIGURED` | The SDK is ready to make purchases | `.appConfigured` / `AppConfigured` |
| `APP_STARTED` | The app was launched | `.appStarted` / `AppStarted` |
| `APP_UPDATED` | The application version changed since last launch | `.appUpdated` / `AppUpdated` |
| `STORE_PRODUCT_FETCH_FAILED` | The Purchasely SDK couldn't fetch the product from the store | `.productFetchError` / `ProductFetchError` |

# UI & User Behavioral Events

| Event | Description | Value `iOS` / `Android` |
| :--- | :--- | :--- |
| `PRESENTATION_LOADED` | The Screen was loaded and is ready to be displayed | `.presentationLoaded` / `PresentationLoaded` |
| `PRESENTATION_VIEWED` | The Screen was opened | `.presentationViewed` / `PresentationViewed` |
| `PRESENTATION_CLOSED` | The Screen was closed | `.presentationClosed` / `PresentationClosed` |
| `PRESENTATION_SELECTED` | The user selected a different tab / tile in the Screen | `.presentationSelected` / `PresentationSelected` |
| `PRESENTATION_OPENED` | The user opened a different tab / tile in the Screen | `.presentationOpened` / `PresentationOpened` |
| `PLAN_SELECTED` | The user selected a Plan on the Screen<br>*Deprecated with SDK versions 5.0+, replaced by `OPTIONS_SELECTED`* | `.planSelected` / `PlanSelected` |
| `PURCHASE_TAPPED` | The user tapped on a purchase button | `.purchaseTapped` / `PurchaseTapped` |
| `PURCHASE_CANCELLED` | The user cancelled the purchase action | `.purchaseCancelled` / `PurchaseCancelled` |
| `LOGIN_TAPPED` | The user tapped on the login button | `.loginTapped` / `LoginTapped` |
| `RESTORE_TAPPED` | The user tapped on the restore button | `.restoreTapped` / `RestoreTapped` |
| `PROMO_CODE_TAPPED` | The user tapped on the promo code button | `.promoCodeTapped` / `PromoCodeTapped` |
| `DEEPLINK_OPENED` | The user opened a deeplink | `.deeplinkOpened` / `DeepLinkOpened` |
| `LINK_OPENED` | The user tapped a link (Terms and conditions, …) | `.linkOpened` / `LinkOpened` |
| `CAROUSEL_SLIDE_SWIPED` | The user swiped to a different carousel tile | `.carouselSlideSwiped` / `CarouselSlideSwiped` |
| `OPTIONS_SELECTED` | The user picks up an option in a survey or selects an option or a plan in a Picker<br>*(>= SDK v5.0)* | `.optionsSelected` / `OptionsSelected` |
| `OPTIONS_VALIDATED` | The user answers a survey<br>*(>= SDK v5.0)* | `.optionsValidated` / `OptionsValidated` |
| `WEB_CHECKOUT_OPENED_IN_WEB_BROWSER` | The web checkout page opened in the browser | `webCheckoutOpenedInWebBrowser` |
| `WEB_CHECKOUT_TAPPED` | The user tapped on the web checkout button | `webCheckoutTapped` |

# In-App Purchase Flow Events

| Event | Description | Value `iOS` / `Android` |
| :--- | :--- | :--- |
| `IN_APP_PURCHASING` | The purchase started | `.inAppPurchasing` / `InAppPurchasing` |
| `IN_APP_PURCHASED` | The purchase succeeded | `.inAppPurchased` / `InAppPurchased` |
| `IN_APP_PURCHASE_FAILED` | The purchase failed | `.inAppPurchaseFailed` / `InAppPurchaseFailed` |
| `IN_APP_DEFERRED` | The user started a deferred payment (i.e. Ask to buy, PSD2 approval) | `.inAppDeferred` / `InAppDeferred` |
| `IN_APP_NOT_AVAILABLE` | The in-app purchase is not available to purchase. | NA / `InAppNotAvailable` |
| `PURCHASE_CANCELLED_BY_APP` | The app cancelled the purchase process | `.purchaseCancelledByApp` / `PurchaseCancelledByApp` |
| `WEB_CHECKOUT_ERROR` | The web checkout failed | `.webCheckoutError` |
| `WEB_CHECKOUT_TIMED_OUT` | The web checkout timed out | `webCheckoutTimedOut` |

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

# Redemption Events

These events report the result of a [Web2App redemption](web2app) deeplink. They are available from SDK 6.1.0 on iOS and on Android. A redemption comes from a deeplink and not from a Screen, so these events carry no paywall context: `displayed_presentation`, `placement_id`, `audience_id`, `ab_test_id` and the Flow attributes are absent.

The SDK also reports `REDEMPTION_CONSUMED` when the user replays a link that was already redeemed. The `replay` flag in the `purchase_context` tells a first redemption and a replay apart.

| Event | Description | Value `iOS` / `Android` |
| :--- | :--- | :--- |
| `REDEMPTION_CONSUMED` | The redemption link was consumed: the subscription was transferred and the receipt was validated | `.redemptionConsumed` / `RedemptionConsumed` |
| `REDEMPTION_FAILED` | The redemption failed: the link is expired, the link is not valid, or the request did not complete | `.redemptionFailed` / `RedemptionFailed` |

# Miscellaneous Events

| Event                           | Description                                                        | Value `iOS` / `Android`                                        |
| :------------------------------ | :----------------------------------------------------------------- | :------------------------------------------------------------- |
| `PURCHASE_FROM_STORE_TAPPED`    | The user opened the app from a Promoted In-App Purchase            | `.purchaseFromStoreTapped` / NA                                |
