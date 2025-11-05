---
title: Application setup
excerpt: >-
  This section describe how to configure your application in the Purchasely
  Console
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    Plug your app with your App Store Connect and Google Play Store accounts or
    start with the SDK Integration
  pages:
    - type: basic
      slug: app-store-configuration
      title: Apple App Store configuration
    - type: basic
      slug: play-store-configuration
      title: Google Play Store configuration
    - type: basic
      slug: sdk-quick-start
      title: SDK Quick start
---
# Creating a new app

> 📘 **⚠️ Staging vs Production**
> 
> **If you have both a staging and a production apps**
> 
> - start by creating a staging application in Purchasely's console
> - implement and test on this app
> - once done, you can create your production app in Purchasely's console and configure your full catalog and paywalls
> 
> **If you have a staging environment but only 1 app for both staging and production**
> 
> - we do not advise creating the application in our console as you can test in-app purchases with sandbox purchases.
> - **However**, if you really need two API keys and/or need to set up two different webhooks, then you should create two applications. You will be able to duplicate screens between them, but you will have to manually set up the plans, placements, and audiences again

<br />

To create a new app, click on the `➕ Add new application` in the drop-down menu in the top-left corner.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/d64ae54-Screenshot_2024-05-22_at_12.43.352x.png",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Then fill in the following form:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/26f8d3e-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

- **Name**: The name of the application as it will be displayed in the Purchasely Console.  
  _This value can be changed after the app has been created._
- **Default Language**: This will define which language will be used when the language on a user device is not supported by the app or not configured for an in-app screen  
  **_⚠️ This value cannot be changed later after the app has been created. ⚠️_**
- **Default dashboard Currency**: This is the currency unit displayed in your Purchasely Dashboards. All other currencies used for in-app payments will automatically be converted to the default currency.  
  _This value can be changed after the app has been created._
- **Default Integration Currency**: This currency unit is used to send price information to the Webhook and 3rd party integrations.  
  _This value can be changed after the app has been created._

<br />

# Configuring the App stores

You can add up to four different App stores + Stripe to your app by clicking on the tab `2. Plug it with the stores` then selecting the App store you want to configure.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/9ba07f2-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

The step-by-step configuration for each store is explained below in dedicated sections:

- [Apple App Store Configuration](app-store-configuration)
- [Google Play Store Configuration](play-store-configuration)
- [Stripe Configuration](stripe-configuration)

<br />

Once you've finished configuring the first App store, click on the `Save` button

# Configuring the backend and SDK

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/5921b4a-Screenshot_2024-05-22_at_13.24.192x.png",
        "",
        "Click on \"Copy\" to copy the API key to your clipboard directly."
      ],
      "align": "center",
      "border": true,
      "caption": "Click on \"Copy\" to copy the API key to your clipboard directly."
    }
  ]
}
[/block]


In the Backend & SDK Configuration section, you can:

- Get your API Key to [initialize](sdk-initialization) the SDK.
- Set your endpoint to receive [webhook](webhook) events.
- Get your Shared Secret to [authenticate](webhook-messages-authentication) webhooks sent by Purchasely.

<br />

> ❗️ Don't forget to click on the "Save" button