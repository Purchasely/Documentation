---
title: Localizing your app
excerpt: This section describes how to localize your app
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The SDK displays some text directly to the user (error messages, restore or login button text…). These texts are translated in **17 languages**:

- English
- French
- German
- Spanish
- Portuguese
- Italian
- Czech
- Polish
- Greek
- Chinese (Simplifed and traditional)
- Japanese
- Russian
- Turkish
- Swedish
- Korean
- Indonesian

That means that every error message and UI element will automatically translated in the user device language (if matching). If the device or app language does not belong to this list, English will be used (fallback language).

> 👍 Help us translate the SDK messages into new languages!
> 
> As of today, the SDK supports natively these 17 languages. You can help us to support new languages in the SDK (for the future versions) by enriching this file
> 
> [Purchasely i18n](https://docs.google.com/spreadsheets/d/1uLKp7QgLI9kXVPndeYhOwEUgQZHUrEIMK3mRKetXwp4/edit?gid=0#gid=0)
> 
> Feel free to reach out to the support via the Purchasely Console to discuss it with us

## Set the language manually

By default, Purchasely uses the device / app language set by the OS.

If your app has an internal language selector, you will want to set that language to your Paywalls. You can force the SDK to be working in a specific language by calling the following method.

Your language code must be [ISO 639-1](https://fr.wikipedia.org/wiki/Liste_des_codes_ISO_639-1) or [ISO 639-2](https://fr.wikipedia.org/wiki/Liste_des_codes_ISO_639-2) 

```swift Swift
// Force language to Spanish
let locale = Locale(identifier: "es")
Purchasely.setLanguage(from: locale)
```
```objectivec Objective-C
// Force language to Spanish
NSLocale *locale = [NSLocale localeWithLocaleIdentifier: @"es"];
[Purchasely setLanguageFrom: locale];
```
```kotlin
// Force language to spanish
Purchasely.language = Locale("es")

// Force language to italian
Purchasely.language = Locale.ITALY
```
```java Java
// Force language to spanish
Purchasely.setLanguage(new Locale("es"));

// Force language to italian
Purchasely.setLanguage(Locale.ITALY);
```
```typescript ReactNative
// Force language to spanish
Purchasely.setLanguage("es");
```
```typescript Flutter
// Force language to spanish
Purchasely.setLanguage("en");
```
```javascript Cordova
// Force language to spanish
Purchasely.setLanguage("es");
```
```csharp Unity
// Force language to spanish
_purchasely.SetLanguage("es");
```

> 🚧 Keep in Mind
> 
> If your paywall is not available in the language you have set, Purchasely will display text inside the paywall in the language of the paywall set in Purchasely console as default and not the language you have enforced for consistency.

## Override default localizations

If you want to change the tone of the messages, you can override our translations and set yours. To do so, you just need to set the key and value corresponding to the message you want to change in your own `Localizable.strings` file (iOS) or `strings.xml` (Android) file.  
The keys that can be overrided are in the following with their value in English:

```python Localizable.strings (iOS)
// en
"ply_modal_alert_in_app_success_title" = "Awesome!";
"ply_modal_alert_in_app_error_title" = "Error";
"ply_modal_alert_in_app_successfull_restore_message_title" = "Restoration completed";
"ply_modal_alert_in_app_restoration_error_title" = "Error";
"ply_modal_alert_in_app_success_content" = "Your purchase has been successfully validated. You can now enjoy it.";
"ply_modal_alert_in_app_success_unauthentified_content" = "Your purchase is active. Sign-in or register to enjoy your subscription on other devices!";
"ply_modal_alert_in_app_restore_status_success_content" = "Purchases have been restored";
"ply_modal_alert_in_app_success_button" = "Let\'s go!";
"ply_modal_alert_in_app_error_button" = "Ok";
"ply_modal_alert_in_app_deferred_title" = "Waiting for approval";
"ply_modal_alert_in_app_deferred_content" = "Thank you! Your purchase couldn\'t be completed yet and requires an external validation. Once the validation is completed you will be able to enjoy your purchase.";
"ply_modal_alert_in_app_deferred_button" = "Ok";
"ply_modal_huawei_not_logged_title" = "Huawei account not found";
"ply_modal_huawei_not_logged_description" = "Please login to your Huawei account in Huawei App Gallery";
"ply_modal_huawei_not_logged_button" = "Ok";
"ply_modal_change_plan_different_store_title" = "Caution!";
"ply_modal_change_plan_different_store_content" = "You already have a subscription with the %@.  Cancel your subscription to avoid a double billing.  Do you want to continue?";
"ply_modal_change_plan_different_store_continue_button" = "Continue";
"ply_modal_change_plan_different_store_cancel_button" = "Cancel";
"ply_modal_alert_default_error_title" = "Error";
"ply_modal_alert_default_error_button" = "Ok";
"ply_configuration_error" = "Configuration error";
"ply_google_developer_error" = "Error with application configuration";
"ply_google_default_error" = "Payment validation failed, please try again";
"ply_google_billing_not_available" = "In-app Purchase is not available with your device or Google account. Make sure Play Store is up to date and a paiment method is configured for your account";
"ply_in_app_already_subscribed_error" = "You\'re already a customer of our online services!";
"ply_in_app_no_product_found_error" = "Unable to find the product.";
"ply_in_app_absent_receipt" = "Receipt not found. Restore your purchases to try again.";
"ply_in_app_client_invalid_error" = "You\'re unauthorized to take this action.";
"ply_in_app_payment_cancelled_error" = "Your request was cancelled";
"ply_in_app_payment_invalid_error" = "The purchase ID is invalid.";
"ply_in_app_payment_not_allowed_error" = "Unable to purchase on this device.";
"ply_in_app_product_not_available_error" = "Product unavailable in your App Store";
"ply_in_app_cloud_permission_error" = "You refused to grant access to this service.";
"ply_in_app_network_error" = "Network connection failed";
"ply_in_app_cloud_service_revoked_error" = "You haven\'t revoked access to this service.";
"ply_in_app_already_being_purchased_error" = "Purchase already in progress for this product";
"ply_in_app_already_being_restored_error" = "Purchase restoration already in progress";
"ply_in_app_restore_status_nothing" = "No purchases were found";
"ply_in_app_psd2_required" = "Your purchase will be active once your payment has been validated by your bank. If you have any trouble, restore your purchases.";
"ply_in_app_validation_failed" = "Receipt confirmation impossible.";
"ply_in_app_validation_timed_out" = "The validation of your purchase is taking a little more time than usual. Please come back later.";
"ply_in_app_restore_status_errors" = "Restoration failed with the following errors:";
"ply_in_app_partial_restore_partial_with_errors" = "The following items have been restored:  %1$@ The following errors have been identified  %2$@";
"ply_in_app_unknown_error" = "Unknown error";
"ply_in_app_parsing_error" = "Couldn\'t handle server response";
"ply_in_app_login_button" = "Already subscribed? Sign in.";
"ply_in_app_restore_button" = "Restore your purchases";
"ply_in_app_error_pending" = "Your payment is being processed.  Your purchase will be validated automatically when your payment has been made.";
"ply_promo_code_button" = "Promo code?";
"ply_in_app_period_day_plural_rule_none" = "day";
"ply_in_app_period_day_plural_rule_one" = "day";
"ply_in_app_period_day_plural_rule_many" = "%d days";
"ply_in_app_period_week_plural_rule_none" = "week";
"ply_in_app_period_week_plural_rule_one" = "week";
"ply_in_app_period_week_plural_rule_many" = "%d weeks";
"ply_in_app_period_month_plural_rule_none" = "month";
"ply_in_app_period_month_plural_rule_one" = "month";
"ply_in_app_period_month_plural_rule_many" = "%d months";
"ply_in_app_period_month_plural_rule_three" = "quarter";
"ply_in_app_period_month_plural_rule_six" = "semester";
"ply_in_app_period_year_plural_rule_none" = "year";
"ply_in_app_period_year_plural_rule_one" = "year";
"ply_in_app_period_year_plural_rule_many" = "%d years";
"ply_in_app_period_day_duration_plural_rule_one" = "1 day";
"ply_in_app_period_day_duration_plural_rule_many" = "%d days";
"ply_in_app_period_week_duration_plural_rule_one" = "1 week";
"ply_in_app_period_week_duration_plural_rule_many" = "%d weeks";
"ply_in_app_period_month_duration_plural_rule_one" = "1 month";
"ply_in_app_period_month_duration_plural_rule_many" = "%d months";
"ply_in_app_period_month_duration_plural_rule_three" = "%d months";
"ply_in_app_period_month_duration_plural_rule_six" = "%d months";
"ply_in_app_period_year_duration_plural_rule_one" = "1 year";
"ply_in_app_period_year_duration_plural_rule_many" = "%d years";
"ply_price_free" = "free";
"ply_unsubscribe_google_title" = "Cancel a subscription";
"ply_unsubscribe_google_content" = "Go to play.google.com. Check if you’re signed in to the correct Google Account. On the left, click My subscriptions. Select the subscription you want to cancel. Click Manage and then Cancel Subscription.";
"ply_unsubscribe_google_button" = "Ok";
"ply_unsubscribe_amazon_title" = "Cancel a subscription";
"ply_unsubscribe_amazon_content" = "Go to amazon.com. Check if you’re signed in to the correct Amazon Account. Go to your Account page. Click on Other Subscriptions in the Memberships and subscriptions section Select the subscription you want to cancel. Then Cancel Subscription.";
"ply_unsubscribe_amazon_button" = "Ok";
"ply_unsubscribe_apple_title" = "Cancel a subscription";
"ply_unsubscribe_apple_content" = "Open the Settings app.   Tap your name.   Tap Subscriptions.   Tap the subscription that you want to manage.   Tap Cancel Subscription.";
"ply_unsubscribe_apple_button" = "Ok";
"ply_subscriptions_title" = "My subscriptions";
"ply_subscriptions_active_group_title" = "Active";
"ply_subscription_title" = "Modify your subscription";
"ply_subscription_detail_group_title" = "Your subscription";
"ply_subscription_plans_group_title" = "Options";
"ply_subscription_unsubscribe_button" = "Cancel subscription";
"ply_subscription_unsubscribe_change_plan_not_available_google" = "This subscription wasn\'t made from the App Store.";
"ply_subscriptions_empty_message" = "You currently have no active subscription";
"ply_cancel_survey_title" = "Why do you want to cancel your subscription ?";
"ply_cancel_survey_message" = "We’re very sorry to see you cancel your subscription. Please help us improve our service by giving us reasons for your cancellation:";
"ply_cancel_survey_reason_1" = "I find the subscription too expensive";
"ply_cancel_survey_reason_2" = "I found a better application";
"ply_cancel_survey_reason_3" = "I no longer need this service";
"ply_cancel_survey_reason_4" = "I don\'t use this service enough";
"ply_cancel_survey_reason_5" = "My decision is related to technical issues";
"ply_cancel_survey_reason_6" = "Other";
"ply_cancel_survey_reason_7" = "I do not wish to answer";
"ply_powered_by_purchasely" = "Powered by Purchasely";
"ply_subscription_renew_pattern" = "Next billing date: %@";
"ply_subscription_cancel_pattern" = "Expires date: %@";
"ply_modal_downgrade_title" = "Congratulations";
"ply_modal_downgrade_description" = "Your plan change has been validated and will be active at the end of the current subscription period on";
"ply_modal_downgrade_button" = "Got it!";
"ply_webview_qr_or_url" = "Scan the QR Code above or visit:";
"ply_webview_url" = "Go to the following URL with your Web browser:";
"ply_untracked_event" = "Event not handled";
"ply_in_app_offer_ineligible_error" = "You are not eligible for this promotional offer.";
"ply_in_app_purchase_not_allowed_error" = "You are not allowed to purchase this product.";
"ply_in_app_offer_invalid_error" = "Purchase with promotional offer failed.";

```
```python strings.xml (Android)
<resources>
	<string name="ply_modal_alert_in_app_success_title">Awesome!</string>
	<string name="ply_modal_alert_in_app_error_title">Error</string>
	<string name="ply_modal_alert_in_app_successfull_restore_message_title">Restoration completed</string>
	<string name="ply_modal_alert_in_app_restoration_error_title">Error</string>
	<string name="ply_modal_alert_in_app_success_content">Your purchase has been successfully validated. You can now enjoy it.</string>
	<string name="ply_modal_alert_in_app_success_unauthentified_content">Your purchase is active. Sign-in or register to enjoy your subscription on other devices!</string>
	<string name="ply_modal_alert_in_app_restore_status_success_content">Purchases have been restored</string>
	<string name="ply_modal_alert_in_app_success_button">Let\'s go!</string>
	<string name="ply_modal_alert_in_app_error_button">Ok</string>
	<string name="ply_modal_alert_in_app_deferred_title">Waiting for approval</string>
	<string name="ply_modal_alert_in_app_deferred_content">Thank you! Your purchase couldn\'t be completed yet and requires an external validation. Once the validation is completed you will be able to enjoy your purchase.</string>
	<string name="ply_modal_alert_in_app_deferred_button">Ok</string>
	<string name="ply_modal_huawei_not_logged_title">Huawei account not found</string>
	<string name="ply_modal_huawei_not_logged_description">Please login to your Huawei account in Huawei App Gallery</string>
	<string name="ply_modal_huawei_not_logged_button">Ok</string>
	<string name="ply_modal_change_plan_different_store_title">Caution!</string>
	<string name="ply_modal_change_plan_different_store_content">You already have a subscription with the %s.  Cancel your subscription to avoid a double billing.  Do you want to continue?</string>
	<string name="ply_modal_change_plan_different_store_continue_button">Continue</string>
	<string name="ply_modal_change_plan_different_store_cancel_button">Cancel</string>
	<string name="ply_modal_alert_default_error_title">Error</string>
	<string name="ply_modal_alert_default_error_button">Ok</string>
	<string name="ply_configuration_error">Configuration error</string>
	<string name="ply_google_developer_error">Error with application configuration</string>
	<string name="ply_google_default_error">Payment validation failed, please try again</string>
	<string name="ply_google_billing_not_available">In-app Purchase is not available with your device or Google account. Make sure Play Store is up to date and a paiment method is configured for your account</string>
	<string name="ply_in_app_already_subscribed_error">You\'re already a customer of our online services!</string>
	<string name="ply_in_app_no_product_found_error">Unable to find the product.</string>
	<string name="ply_in_app_absent_receipt">Receipt not found. Restore your purchases to try again.</string>
	<string name="ply_in_app_client_invalid_error">You\'re unauthorized to take this action.</string>
	<string name="ply_in_app_payment_cancelled_error">Your request was cancelled</string>
	<string name="ply_in_app_payment_invalid_error">The purchase ID is invalid.</string>
	<string name="ply_in_app_payment_not_allowed_error">Unable to purchase on this device.</string>
	<string name="ply_in_app_product_not_available_error">Product unavailable in your App Store</string>
	<string name="ply_in_app_cloud_permission_error">You refused to grant access to this service.</string>
	<string name="ply_in_app_network_error">Network connection failed</string>
	<string name="ply_in_app_cloud_service_revoked_error">You haven\'t revoked access to this service.</string>
	<string name="ply_in_app_already_being_purchased_error">Purchase already in progress for this product</string>
	<string name="ply_in_app_already_being_restored_error">Purchase restoration already in progress</string>
	<string name="ply_in_app_restore_status_nothing">No purchases were found</string>
	<string name="ply_in_app_psd2_required">Your purchase will be active once your payment has been validated by your bank. If you have any trouble, restore your purchases.</string>
	<string name="ply_in_app_validation_failed">Receipt confirmation impossible.</string>
	<string name="ply_in_app_validation_timed_out">The validation of your purchase is taking a little more time than usual. Please come back later.</string>
	<string name="ply_in_app_restore_status_errors">Restoration failed with the following errors:</string>
	<string name="ply_in_app_partial_restore_partial_with_errors">The following items have been restored:  %1$s The following errors have been identified  %2$s</string>
	<string name="ply_in_app_unknown_error">Unknown error</string>
	<string name="ply_in_app_parsing_error">Couldn\'t handle server response</string>
	<string name="ply_in_app_login_button">Already subscribed? Sign in.</string>
	<string name="ply_in_app_restore_button">Restore your purchases</string>
	<string name="ply_in_app_error_pending">Your payment is being processed.  Your purchase will be validated automatically when your payment has been made.</string>
	<string name="ply_promo_code_button">Promo code?</string>
	<string name="ply_in_app_period_day_plural_rule_none">day</string>
	<string name="ply_in_app_period_day_plural_rule_one">day</string>
	<string name="ply_in_app_period_day_plural_rule_many">%d days</string>
	<string name="ply_in_app_period_week_plural_rule_none">week</string>
	<string name="ply_in_app_period_week_plural_rule_one">week</string>
	<string name="ply_in_app_period_week_plural_rule_many">%d weeks</string>
	<string name="ply_in_app_period_month_plural_rule_none">month</string>
	<string name="ply_in_app_period_month_plural_rule_one">month</string>
	<string name="ply_in_app_period_month_plural_rule_many">%d months</string>
	<string name="ply_in_app_period_month_plural_rule_three">quarter</string>
	<string name="ply_in_app_period_month_plural_rule_six">semester</string>
	<string name="ply_in_app_period_year_plural_rule_none">year</string>
	<string name="ply_in_app_period_year_plural_rule_one">year</string>
	<string name="ply_in_app_period_year_plural_rule_many">%d years</string>
	<string name="ply_in_app_period_day_duration_plural_rule_one">1 day</string>
	<string name="ply_in_app_period_day_duration_plural_rule_many">%d days</string>
	<string name="ply_in_app_period_week_duration_plural_rule_one">1 week</string>
	<string name="ply_in_app_period_week_duration_plural_rule_many">%d weeks</string>
	<string name="ply_in_app_period_month_duration_plural_rule_one">1 month</string>
	<string name="ply_in_app_period_month_duration_plural_rule_many">%d months</string>
	<string name="ply_in_app_period_month_duration_plural_rule_three">%d months</string>
	<string name="ply_in_app_period_month_duration_plural_rule_six">%d months</string>
	<string name="ply_in_app_period_year_duration_plural_rule_one">1 year</string>
	<string name="ply_in_app_period_year_duration_plural_rule_many">%d years</string>
	<string name="ply_price_free">free</string>
	<string name="ply_unsubscribe_google_title">Cancel a subscription</string>
	<string name="ply_unsubscribe_google_content">Go to play.google.com. Check if you’re signed in to the correct Google Account. On the left, click My subscriptions. Select the subscription you want to cancel. Click Manage and then Cancel Subscription.</string>
	<string name="ply_unsubscribe_google_button">Ok</string>
	<string name="ply_unsubscribe_amazon_title">Cancel a subscription</string>
	<string name="ply_unsubscribe_amazon_content">Go to amazon.com. Check if you’re signed in to the correct Amazon Account. Go to your Account page. Click on Other Subscriptions in the Memberships and subscriptions section Select the subscription you want to cancel. Then Cancel Subscription.</string>
	<string name="ply_unsubscribe_amazon_button">Ok</string>
	<string name="ply_unsubscribe_apple_title">Cancel a subscription</string>
	<string name="ply_unsubscribe_apple_content">Open the Settings app.   Tap your name.   Tap Subscriptions.   Tap the subscription that you want to manage.   Tap Cancel Subscription.</string>
	<string name="ply_unsubscribe_apple_button">Ok</string>
	<string name="ply_subscriptions_title">My subscriptions</string>
	<string name="ply_subscriptions_active_group_title">Active</string>
	<string name="ply_subscription_title">Modify your subscription</string>
	<string name="ply_subscription_detail_group_title">Your subscription</string>
	<string name="ply_subscription_plans_group_title">Options</string>
	<string name="ply_subscription_unsubscribe_button">Cancel subscription</string>
	<string name="ply_subscription_unsubscribe_change_plan_not_available_google">This subscription wasn\'t made from the App Store.</string>
	<string name="ply_subscriptions_empty_message">You currently have no active subscription</string>
	<string name="ply_cancel_survey_title">Why do you want to cancel your subscription ?</string>
	<string name="ply_cancel_survey_message">We’re very sorry to see you cancel your subscription. Please help us improve our service by giving us reasons for your cancellation:</string>
	<string name="ply_cancel_survey_reason_1">I find the subscription too expensive</string>
	<string name="ply_cancel_survey_reason_2">I found a better application</string>
	<string name="ply_cancel_survey_reason_3">I no longer need this service</string>
	<string name="ply_cancel_survey_reason_4">I don\'t use this service enough</string>
	<string name="ply_cancel_survey_reason_5">My decision is related to technical issues</string>
	<string name="ply_cancel_survey_reason_6">Other</string>
	<string name="ply_cancel_survey_reason_7">I do not wish to answer</string>
	<string name="ply_powered_by_purchasely">Powered by Purchasely</string>
	<string name="ply_subscription_renew_pattern">Next billing date: %s</string>
	<string name="ply_subscription_cancel_pattern">Expires date: %s</string>
	<string name="ply_modal_downgrade_title">Congratulations</string>
	<string name="ply_modal_downgrade_description">Your plan change has been validated and will be active at the end of the current subscription period on</string>
	<string name="ply_modal_downgrade_button">Got it!</string>
	<string name="ply_webview_qr_or_url">Scan the QR Code above or visit:</string>
	<string name="ply_webview_url">Go to the following URL with your Web browser:</string>
	<string name="ply_untracked_event">Event not handled</string>
	<string name="ply_in_app_offer_ineligible_error">You are not eligible for this promotional offer.</string>
	<string name="ply_in_app_purchase_not_allowed_error">You are not allowed to purchase this product.</string>
	<string name="ply_in_app_offer_invalid_error">Purchase with promotional offer failed.</string>
</resources>
```