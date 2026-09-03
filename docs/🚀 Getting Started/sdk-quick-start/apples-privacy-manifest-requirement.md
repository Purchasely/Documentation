---
title: Apple's Privacy Manifest Requirement
excerpt: ''
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
## **Apple’s Privacy Requirement**

Starting **May 1st, 2024**, Apple mandated that any newly developed app or update uploaded to the App Store **must include a privacy manifest for all third-party SDKs** used in the app. You can find Apple’s official statement [here](https://developer.apple.com/news/?id=3d8a9yyh).

To comply with this requirement, **third-party SDKs must provide their own privacy manifest files**, detailing the types of data they collect.  

We want to reassure you that **Purchasely SDKs fully comply with these regulations**. The iOS SDK has shipped a privacy manifest since v4.3.5. The list of declared data types **grew in 6.1.0**, when the SDK gained its [diagnostics and observability](sdk-diagnostics-and-observability) feature.

Our `PrivacyInfo.xcprivacy` declares the following data types. It sets `NSPrivacyCollectedDataTypeLinked` to `false` and `NSPrivacyCollectedDataTypeTracking` to `false` for every one of them:

* **User ID**  
* **Device ID (IDFV)**  
* **Product Interaction**  
* **Purchase History**  
* **`NSPrivacyCollectedDataTypePerformanceData`** *(new in 6.1.0)*  
* **`NSPrivacyCollectedDataTypeOtherDiagnosticData`** *(new in 6.1.0)*  
* **`NSPrivacyCollectedDataTypeCrashData`** *(new in 6.1.0)*  

> 📘 About the three data types added in 6.1.0
>
> The three new data types each declare the single purpose `NSPrivacyCollectedDataTypePurposeAppFunctionality`. They are not linked to the user, and they are not used for tracking.
>
> The SDK detects its own crashes through MetricKit. It installs **no** crash handler, so it does not interfere with Crashlytics, Sentry or any other crash reporter in your app.
>
> The SDK collects no personal data, and it sanitizes the free text of a crash report.
>
> Update your App Store privacy answers when your report copies the SDK manifest.
>
> 📚 More information: [SDK diagnostics and observability](sdk-diagnostics-and-observability)

To ensure compliance and avoid potential app submission rejections, it is essential that you **update the Purchasely iOS SDK**.

***

## **📌 Action Required**

### **Update the Purchasely iOS SDK**

* Ensure you **update the Purchasely iOS SDK** in your next app release to comply with Apple’s new privacy policies.
* Failure to update may result in **app update rejections**, leading to potential disruptions in availability.

<br />

***

## **📖 FAQ: What Should the Integrating App Do?**

Purchasely's SDK **already includes the required privacy manifest**, and **Apple automatically merges SDK privacy manifests** into the app’s privacy settings.  

As an app developer, you do not need to duplicate it. However, we recommend the following actions:

* **Review** Purchasely SDK’s declared data collection practices.  
* **Ensure** your app’s privacy manifest does not conflict with Purchasely’s data usage declarations.  
* **Verify** the merged privacy report in Xcode:  
  * Go to **Product > Archive > Distribute App > Privacy Report** before submitting to the App Store.  

### **When Should the App Declare Additional Privacy Information?**

If your app **collects additional data** beyond what Purchasely declares, such as location, contact information, or health data, you must include those in your own **PrivacyInfo.xcprivacy** file.

***

By updating the Purchasely SDK and verifying your privacy declarations, you can ensure a **smooth app submission process** and continued compliance with Apple's guidelines.