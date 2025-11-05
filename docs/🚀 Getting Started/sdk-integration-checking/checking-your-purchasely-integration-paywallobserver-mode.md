---
title: paywallObserver mode - Checking your Purchasely Integration
excerpt: >-
  This page gives you an outlook of everything you can check once you've
  finished the implementation of the Purchasely SDK
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Here is a checklist for your Purchasely Integration

## 0. The App is properly set up and plugged with the app stores

📚 Documentation: [Application setup](application-setup)

- [ ] You have configured the app basic parameters

<br />

### Subscription apps only

- [ ] You've configured one Product & Plan and mapped it with the App Store and Play Store product IDs (📚 [documentation](product-plans-setup))

## 1. The SDK is properly initialized

📚 Documentation: [SDK Initialization](sdk-initialization)

- [ ] The SDK is started ASAP in the start routine of your app

### Subscription apps only

- [ ] The `running mode` parameter is set to `paywallObserver` mode (📚 [documentation](paywallObserver-mode))

<br />

- [ ] On iOS, the StoreKit version configured for the SDK matches the desired one (we strongly recommend using StoreKit 2 though)

<br />

- [ ] In the [Console App settings,](https://console.purchasely.io/settings?step=stores) you have configured the StoreKit 2 settings (issuer ID, private key).  
  It will be useful to the Purchasely platform to fetch more accurate data even if your app is currently working with StoreKit 1.

<br />

## 2. Deeplinks are properly handled

📚 Documentation: [Deeplinks management](deeplinks-management)

### Technical instructions

- [ ] You have filled-in the app scheme parameter in the [Purchasely Console](https://console.purchasely.io/settings?step=stores) for both iOS (tab `App Store`) and Android (tab `Play Store`)

  [block:image]{"images":[{"image":["https://files.readme.io/1ebfcee799479f89ce24ef8a0f9ab1be4da6f775b3044ff6ec7ed7bcab1f1a09-image.png",null,""],"align":"center","border":true}]}[/block]

  Note: for Android, we recommend you to use Universal Links rather than an app scheme because the OS does not allow you to open deeplinks leveraging an app scheme from the camera which is what you will need to for the preview

<br />

- [ ] You have integrated the code snippet to manage deeplinks
- [ ] You execute the code allowing the Purchasely SDK to open deeplinks

<br />

### Functional test

- [ ] When you create a Screen and save it in the Purchasely Console, you are able to preview it in your app by scanning the QR code

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/5920aa891ff42ce628a2a1c4b99026d17f8e4a3ae684706b64af349ea6ede9d8-image.png",
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

- [ ] When copy / pasting a Screen deeplink from the Purchasely Console and opening it with your device, you are able to visualize the desired Screen

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/c8ac543415eaaeffdf8ca3fd772ab0712d5dfa10806023d8c757a86d1cd2954a-image.png",
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

<br />

## 3. Users are properly identified

### Managing signed-in users

- [ ] The User ID is properly set when users sign-in

<br />

- [ ] When users are already signed-in upon the start of the app, the `user_ID` is provided to the SDK in the initialization method.

<br />

- [ ] When users sign-in during the session, the `userLogIn` method of the SDK is being properly called (📚 [documentation](user-identification#authenticate-users))

<br />

- [ ] In the [Subscriptions section of the Console](https://console.purchasely.io/subscriptions), transactions associated with an identified users are associated with the `user_ID` provided by the app

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/0441c42c4cbe572cfac03b742b84f36f861911f7646d3e017f4d7ce3e68d0c1c-image.png",
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

### Signing-out users

- [ ] The log out method is properly called when users sign-out

<br />

- [ ] In the [Subscriptions section of the Console](https://console.purchasely.io/subscriptions), transactions associated with an anonymous user are associated with an `anonymous ID`

  [block:image]{"images":[{"image":["https://files.readme.io/1b34f03b1f317daa956c37f3e2e47d6b5019082b71375ec6a801710f7d19dec4-image.png",null,""],"align":"center","border":true}]}[/block]

<br />

## 4. Screens are displayed through Placements

- [ ] You have displayed a Screen by associating it with a Placement and by making a direct call to the placement on the app side (📚 [documentation](displaying-screens-placements#direct-call))

<br />

- [ ] **[Optional]** - Alternatively, you've leveraged deeplinks to display Placements (📚 [documentation](https://docs.purchasely.com/docs/displaying-screens-placements#deeplinks))

<br />

- [ ] **[Optional]** - You've leveraged Placement pre-fetching (📚 [documentation](pre-fetching)) when you need to fetch a Screen in advance and display it later, or when you want to nest a Purchasely view into a parent view (📚 [documentation](nesting-views) and example with [inline paywalls](displaying-inline-paywalls))

<br />

### [Optional] A/A testing your paywall

- [ ] You created a Screen leveraging the feature "Use Your Own Paywall" (📚 [documentation](use-your-own-paywall)) and implemented the code to display it

<br />

- [ ] You have configured and started an A/A test with your own Paywall as the control (50%) and the Purchasely Screen as the variant (50%) for a particular (set of) Placement(s). 50% of the users see your existing Screen, and the other 50% see the new one designed with Purchasely

<br />

## 5. Transactions are properly processed

- [ ] A Plan has been properly configured and mapped with a Paywall

<br />

- [ ] When users tap on the purchase button, you leverage the Paywall Action Interceptor to process the transaction (📚 [documentation](paywall-action-interceptor))

<br />

- [ ] After the transaction has been processed, you synchronize it with the SDK (📚 [documentation](process-transactions-with-paywall-action-interceptor#implementing-the-paywall-action-intercept)) and close the paywall

<br />

- [ ] When testing a purchase in the sandbox environment, you can find the transaction in the [Purchasely Console](https://console.purchasely.com/subscriptions)

<br />

For more details on Sandbox purchases and sandbox testing, please refer to the 📚 [documentation](testing).

<br />

<br />

## 6. [Optional] You are properly leveraging Custom User Attributes to segment users

📚 Documentation: [Segmenting you user base](segmenting-your-user-base)

- [ ] When that makes sense, you leverage Custom User Attributes (📚 [documentation](custom-user-attributes)) to attach properties to users and be able to segment them with your own data

<br />

### Technical instructions

- [ ] You have created the Custom User Attributes in the Purchasely Console

<br />

- [ ] You properly set the attribute and its value

<br />

- [ ] You have created an Audience leveraging the Custom User Attribute (📚 [documentation](audiences))

<br />

### Functional test

- [ ] You have associated a customized the Screen displayed for your Audience on the Placement of your choice

<br />

- [ ] When you display this Placement inside the app and that the user belongs to that Audience, you see the associated Screen instead of the default one displayed to _Everyone else_.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/e2b7125ce2daf265bdf63d296ab6d2466cab6f565eeb2b3a31741516991e59ab-image.png",
        null,
        ""
      ],
      "align": "center",
      "sizing": "400px",
      "border": true
    }
  ]
}
[/block]


<br />

## 8. [Optional] You fetch user insights in the app upon a survey submission

📚 Documentation: [Gaining Insights and Driving Personalization with Surveys](user-surveys)

<br />

### Technical instructions

- [ ] You have implemented the listener / delegate for Custom User Attributes (📚 [documentation](custom-user-attribute-listener))

<br />

- [ ] You have created a new [Custom User Attribute in the Purchasely Console](https://console.purchasely.io/user-attributes), with the appropriate type

<br />

- [ ] You have configured a Survey leveraging the [MCQ component](mcq), activated option "Save as a custom user attribute" and associated the MCQ to the Custom User Attribute created

<br />

### Functional test

- [ ] When users answer to the Survey created, the app fetches the `{key, type, value}` of the Custom User Attribute

<br />

- [ ] This data is sent to wherever you choose to send it to (e.g.: backend, data warehouse, 3rd party analytics, 3party engagement / CRM platform...)

<br />

- [ ] You have created an Audience leveraging the Custom User Attributes and are able to tailor the Screen viewed depending on user insights.

<br />

## 9. [Optional and advanced] You process the UI / SDK events generated by the SDK and forward them to your analytics platform

### Technical instructions

- [ ] You have implemented the listener / delegate for UI / SDK Events (📚 [documentation](ui-sdk-events#how-to-leverage-them-by-implementing-an-event-delegate-inside-the-app))

<br />

- [ ] **[If relevant]** You have associated the 3rd-party analytics / engagement SDK `user_ID`  and passed it to the Purchasely SDK

<br />

### Functional test

- [ ] When you interact with Purchasely Screens, you see the Purchasely UI / SDK analytics in the 3rd party analytics / engagement platform you've forwarded them to

<br />

## 10. [Optional and advanced] You leverage the Purchasely Server Events to fetch the subscription lifecycle events and process it

### Webhook

- [ ] You have implemented an endpoint on your backend to receive the [Server Events](server-events) generated by Purchasely 

<br />

- [ ] You have configured this endpoint and activated the desired events in the [Webhook Section of the Purchasely Console](https://console.purchasely.io/webhooks)

<br />

- [ ] Every time an event is generated in a subscriber lifecycle, you see it flow in your data warehouse

<br />

### 3rd-party analytics integration

📚 Documentation: [Combining Analytics Platforms with Purchasely](analytics-3rd-party))

- [ ] You have enable the 3rd party integration with the desired analytics platform

<br />

- [ ] You have activated the desired Server Events

<br />

- [ ] **[If relevant]** You have associated the 3rd-party analytics SDK `user_ID`  and passed it to the Purchasely SDK

<br />

- [ ] When subscription lifecycle events are generated by the app stores, they are automatically forwarded to the 3rd-party analytics platform and you can visualize them into your analytics platform

<br />

### 3rd-party engagement & CRM integration

📚 Documentation: [Combining Engagement/CRM platforms with Purchasely](engagement-crm))

- [ ] You have enable the 3rd party integration with the desired analytics platform

<br />

- [ ] You have activated the desired Server Events

<br />

- [ ] **[If relevant]** You have associated the 3rd-party analytics SDK `user_ID`  and passed it to the Purchasely SDK

<br />

- [ ] When subscription lifecycle events are generated by the app stores, they are automatically forwarded to the 3rd-party engagement & CRM platform and you can create automations leveraging these events and user properties