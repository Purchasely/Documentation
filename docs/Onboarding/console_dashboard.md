---
title: Console - dashboards
excerpt: ''
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# How the languages are managed by the SDK?

Any language available for iOS and Android can be used with the Purchasely Platform.  
The Purchasely SDK fetches from the app, the preferred language that has been configured.  
It can be either:

- the default language of the OS
- or the preferred language configured in the app settings

![](https://files.readme.io/1514105-image.png)

The SDK will then automatically use this language to display the SDK messages (eg: confirmation messages, error messages etc). 

The SDK messages are available in more than 20 languages but every message can be overridden at the app level.

If the language used by the app is not available in the Purchasely SDK, the English (EN) will be used by default.

# Why do I need a default language for the app?

To display screens & paywalls, the mechanism is similar. At the app start, the Purchasely SDK automatically fetches the preferred language for the app and will then attempt to display the screens and paywalls in this language.

When a screen or paywalls has not been translated into the corresponding language, the default language of the app will be used instead.

Eg: 

- the default language for an app is English
- the Onboarding paywall has not been translated in Italian
- the  preferred language defined for the app is currently Italian
- the paywall will be displayed in English instead (the default language)
- If the paywall had been translated into Italian, it would have been displayed in Italian

If your app is available in multiple territories using different languages, we advise you to define English as the default language.

If your app is mainly used in 1 language or in 1 principal territory, you should set this language as the default language.

⚠️ It is not possible to change the default language once you've set it and saved ⚠️

# What’s the default currency for the dashboard?

The default currency for the dashboard is the one that will be used to display the Dashboards in the Purchasely Console.

Every transaction which will be processed in a locale currency (eg: £ in the UK) will automatically be converted in the default currency when displayed in the Purchasely Dashboards.

We advise you to use Euro (EUR) or US Dollard (USD) as the default currency for the dashboard.

# What’s the default currency for the 3rd party integrations?

The default currency for the 3rd party integration is the one that will be used to communicate revenue information to 3rd party tools, when enabling 3rd party integrations from the Purchasely Console.

Every transaction which will be processed in a locale currency (eg: £ in the UK) will automatically be provided in the currency used for the transaction and in the default currency for 3rd party integrations.

We advise you to use US Dollard (USD) as the default currency for 3rd party integrations.