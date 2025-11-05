---
title: Google In-App Purchases
excerpt: >-
  This guide covers the essential points for setting up and testing Google Play
  Billing with Purchasely
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Take a deeper dive into our In-App purchases guide for Google
  pages:
    - type: basic
      slug: play-store-starting-with-iap
      title: Play Store - Steps to unlock In-App Purchases & Subscriptions
---
# Key Points

## Add permission

Ensure that the `com.android.vending.BILLING` permission is included in your Android manifest file. This permission is necessary for your app to access Google Play's billing services.

```
<uses-permission android:name="com.android.vending.BILLING" />
```

> 📘 Included with Purchasely SDK
> 
> If you use the Google dependency of our SDK, this permission is included so you do not need to add it yourself.

## Upload to Internal Testing Track

Upload your APK or AAB (Android App Bundle) with the above permission or Purchasely SDK to the internal testing track in the Google Play Console. This step is required to unlock In-App Purchases and subscriptions for testing if you haven't already.

## Tester Configuration

### Be an internal Tester

Make sure you are added as a tester for the current testing track (internal, private, beta, etc.) and also accepted to be a tester of that track, you need to click on "Accept invite" in the web page provided by Google.

### Be a License Tester

In the Google Play Console, navigate to Settings > License Testing and add your Google email correspond to the account in your phone as a license tester.  
Being a license tester allows you to make sandbox purchase for all versions of your application (internal, alpha, beta and production). 

> 📘 Testing in production
> 
> You do not need to test a "real" purchase in production to make sure it works but if you want to, you will need to remove yourself from the list of license tester as it is applied also in production.

## App Bundle ID and Version Code

### App Bundle ID

Ensure the app bundle ID in your project matches the one registered in the Google Play Console. This consistency is crucial for the proper functioning of In-App Purchases.

### Version Code

The version code of your app must be equal to or greater than the version code of the app uploaded to the Google Play Console. This ensures that the latest version of your app is being tested.

## Cache and Propagation Time

### Delay

After creating a subscription or In-App product in the Google Play Console, wait a few hours before testing. This delay is due to Google’s cache needing time to expire and propagate the new products.

### Force Stop and Clear Cache

If In-App Purchases and subscriptions are still not available after a few hours, try the following steps:

- Force stop the Google Play Store app.
- Clear the cache of the Google Play Store app.
- Reopen the Google Play Store app.
- Kill and relaunch your application.

# Promo Codes

Using promo codes is only possible if you are not a license tester. If you are, you need to remove your google account from the list and follow the step above to clear Play Store cache. It can take a few hours to be applied by Google.

Purchasely will automatically retrieve the purchase with a promo code if you have enabled S2S.  
However the SDK will not be aware of the purchase so if a paywall was displayed it won't be automatically dismissed. 

# Reset eligibility and change country

You can use the [Play Billing Lab](https://play.google.com/store/apps/details?id=com.google.android.apps.play.billingtestcompanion&hl=fr) application from Google to change the country of your account and reset the eligibility of your user to offers. This allows you to test different countries and your offers as much as you want.  
It requires your Google account to be a license tester of your application.

[Learn more about Play Billing Lab](https://developer.android.com/google/play/billing/test?hl=fr#play-billing-lab)

# Resources

- [Google Play Console](https://play.google.com/console/u/0/developers)
- [Google Play Billing Library](https://developer.android.com/google/play/billing)
- [Test In-App Purchases](https://developer.android.com/google/play/billing/test)