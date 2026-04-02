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

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th style={{ textAlign: "left" }}>
        Event
      </th>

      <th style={{ textAlign: "left" }}>
        Description
      </th>

      <th style={{ textAlign: "left" }}>
        Value 

        `iOS`

         / 

        `Android`
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td style={{ textAlign: "left" }}>
        `APP_INSTALLED`
      </td>

      <td style={{ textAlign: "left" }}>
        First installation of the SDK
      </td>

      <td style={{ textAlign: "left" }}>
        `.appInstalled` / `AppInstalled`
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `APP_CONFIGURED`
      </td>

      <td style={{ textAlign: "left" }}>
        The SDK is ready to make purchases
      </td>

      <td style={{ textAlign: "left" }}>
        `.appConfigured` / `AppConfigured`
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `APP_STARTED`
      </td>

      <td style={{ textAlign: "left" }}>
        The app was launched
      </td>

      <td style={{ textAlign: "left" }}>
        `.appStarted` / `AppStarted`
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `APP_UPDATED`
      </td>

      <td style={{ textAlign: "left" }}>
        The application version changed since last launch
      </td>

      <td style={{ textAlign: "left" }}>
        `.appUpdated`\
        / `AppUpdated`
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        `STORE_PRODUCT_FETCH_FAILED`
      </td>

      <td style={{ textAlign: "left" }}>
        The Purchasely SDK couldn't fetch the product from the store
      </td>

      <td style={{ textAlign: "left" }}>
        `.productFetchError` / `ProductFetchError`
      </td>
    </tr>
  </tbody>
</Table>

# UI & User Behavioral Events

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Event
      </th>

      <th>
        Description
      </th>

      <th>
        Value 

        `iOS`

         / 

        `Android`
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        `PRESENTATION_LOADED`
      </td>

      <td>
        The Screen was loaded and is ready to be displayed
      </td>

      <td>
        `.presentationLoaded` / `PresentationLoaded`
      </td>
    </tr>

    <tr>
      <td>
        `PRESENTATION_VIEWED`
      </td>

      <td>
        The Screen was opened
      </td>

      <td>
        `.presentationViewed` / `PresentationViewed`
      </td>
    </tr>

    <tr>
      <td>
        `PRESENTATION_CLOSED`
      </td>

      <td>
        The Screen was closed
      </td>

      <td>
        `.presentationClosed` / `PresentationClosed`
      </td>
    </tr>

    <tr>
      <td>
        `PRESENTATION_SELECTED`
      </td>

      <td>
        The user selected a different tab / tile in the Screen
      </td>

      <td>
        `.presentationSelected`\
        / `PresentationSelected`
      </td>
    </tr>

    <tr>
      <td>
        `PRESENTATION_OPENED`
      </td>

      <td>
        The user opened a different tab / tile in the Screen
      </td>

      <td>
        `.presentationOpened` / `PresentationOpened`
      </td>
    </tr>

    <tr>
      <td>
        `PLAN_SELECTED`
      </td>

      <td>
        The user selected a Plan on the Screen\
        *Deprecated with SDK versions 5.0+ => replaced by OPTIONS\_SELECTED* 
      </td>

      <td>
        `.planSelected` / `PlanSelected`
      </td>
    </tr>

    <tr>
      <td>
        `PURCHASE_TAPPED`
      </td>

      <td>
        The user tapped on a purchase button
      </td>

      <td>
        `.purchaseTapped` / `PurchaseTapped`
      </td>
    </tr>

    <tr>
      <td>
        `PURCHASE_CANCELLED`
      </td>

      <td>
        The user cancelled the purchase action
      </td>

      <td>
        `.purchaseCancelled` / `PurchaseCancelled`
      </td>
    </tr>

    <tr>
      <td>
        `LOGIN_TAPPED`
      </td>

      <td>
        The user tapped on the login button
      </td>

      <td>
        `.loginTapped` / `LoginTapped`
      </td>
    </tr>

    <tr>
      <td>
        `RESTORE_TAPPED`
      </td>

      <td>
        The user tapped on the restore button
      </td>

      <td>
        `.restoreTapped` / `RestoreTapped`
      </td>
    </tr>

    <tr>
      <td>
        `PROMO_CODE_TAPPED`
      </td>

      <td>
        The user tapped on the promo code button
      </td>

      <td>
        `.promoCodeTapped` / `PromoCodeTapped`
      </td>
    </tr>

    <tr>
      <td>
        `DEEPLINK_OPENED`
      </td>

      <td>
        The user opened a deeplink
      </td>

      <td>
        `.deeplinkOpened` / `DeepLinkOpened`
      </td>
    </tr>

    <tr>
      <td>
        `LINK_OPENED`
      </td>

      <td>
        The user tapped a link (Terms and conditions, …)
      </td>

      <td>
        `.linkOpened` / `LinkOpened`
      </td>
    </tr>

    <tr>
      <td>
        `CAROUSEL_SLIDE_SWIPED`
      </td>

      <td>
        The user  swiped to a different carousel tile
      </td>

      <td>
        `.carouselSlideSwiped` /\
        `CarouselSlideSwiped`
      </td>
    </tr>

    <tr>
      <td>
        `OPTIONS_SELECTED`
      </td>

      <td>
        The users picks up an option in a survey or selects an option or a plan in a Picker\
        *(>= SDK v5.0)*
      </td>

      <td>
        `.optionsSelected`/`OptionsSelected\`
      </td>
    </tr>

    <tr>
      <td>
        `OPTIONS_VALIDATED`
      </td>

      <td>
        The user answers a survey\
        *(>= SDK v5.0)*
      </td>

      <td>
        `.optionsValidated` / `OptionsValidated`
      </td>
    </tr>

    <tr>
      <td>

      </td>

      <td>

      </td>

      <td>

      </td>
    </tr>

    <tr>
      <td>
        `WEB_CHECKOUT_OPENED_IN_WEB_BROWSER`
      </td>

      <td>
        The web checkout page opened in the browser
      </td>

      <td>
        `webCheckoutOpenedInWebBrowser`
      </td>
    </tr>

    <tr>
      <td>
        `WEB_CHECKOUT_TAPPED`
      </td>

      <td>
        The user tapped on the web checkout button
      </td>

      <td>
        `webCheckoutTapped`
      </td>
    </tr>
  </tbody>
</Table>

# In-App Purchase Flow Events

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Event
      </th>

      <th>
        Description
      </th>

      <th>
        Value 

        `iOS`

         / 

        `Android`
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        `IN_APP_PURCHASING`
      </td>

      <td>
        The purchase started
      </td>

      <td>
        `.inAppPurchasing` / `InAppPurchasing`
      </td>
    </tr>

    <tr>
      <td>
        `IN_APP_PURCHASED`
      </td>

      <td>
        The purchase succeeded
      </td>

      <td>
        `.inAppPurchased` / `InAppPurchased`
      </td>
    </tr>

    <tr>
      <td>
        `IN_APP_PURCHASE_FAILED`
      </td>

      <td>
        The purchase failed
      </td>

      <td>
        `.inAppPurchaseFailed` / `InAppPurchaseFailed`
      </td>
    </tr>

    <tr>
      <td>
        `IN_APP_DEFERRED`
      </td>

      <td>
        The user started a deferred payment (i.e. Ask to buy, PSD2 approval)
      </td>

      <td>
        `.inAppDeferred`\
        / `InAppDeferred`
      </td>
    </tr>

    <tr>
      <td>
        `IN_APP_NOT_AVAILABLE`
      </td>

      <td>
        The in-app purchase is not available to purchase.
      </td>

      <td>
        NA / `InAppNotAvailable`
      </td>
    </tr>

    <tr>
      <td>
        `PURCHASE_CANCELLED_BY_APP`
      </td>

      <td>
        The app cancelled the purchase process
      </td>

      <td>
        `.purchaseCancelledByApp` / `PurchaseCancelledByApp`
      </td>
    </tr>

    <tr>
      <td>
        `WEB_CHECKOUT_ERROR`
      </td>

      <td>
        The web checkout failed
      </td>

      <td>
        `.webCheckoutError`
      </td>
    </tr>

    <tr>
      <td>
        `WEB_CHECKOUT_TIMED_OUT`
      </td>

      <td>
        The web checkout timed out
      </td>

      <td>
        `webCheckoutTimedOut`
      </td>
    </tr>
  </tbody>
</Table>

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
