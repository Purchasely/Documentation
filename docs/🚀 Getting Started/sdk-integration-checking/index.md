---
title: Check your Implementation of Purchasely
excerpt: This page provides the resources to check your SDK implementation
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    If your app is a subscription app, check that In-App Purchases and
    transactions are properly processed
  pages:
    - slug: subscription-app-implementation-checking
      title: Subscription apps transaction management testing
      type: basic
---
Here is a checklist for your Purchasely Integration

<Callout icon="💡" theme="default">
  ### AI Plugin

  You can also use the [Purchasely AI Plugin](purchasely-ai-plugin) to review your implementation. The `purchasely-review` skill scans your codebase for missing setup, deprecated APIs, risky patterns and common integration mistakes before you run the manual checks below.
</Callout>

## 0. The App is properly set up

📚 Documentation: [Application setup](application-setup)

- [ ] You have configured the app basic parameters

## 1. The SDK is properly initialized

📚 Documentation: [SDK Initialization](general-sdk-initialization)

- [ ] The SDK is started ASAP in the start routine of your app

## 2. Deeplinks are properly handled

📚 Documentation: [Deeplinks management](deeplinks-management)

### Technical instructions

- [ ] You have filled-in the app scheme parameter in the [Purchasely Console](https://console.purchasely.io/settings?step=stores) for both iOS (tab `App Store`) and Android (tab `Play Store`)


  <Image src="https://files.readme.io/1ebfcee799479f89ce24ef8a0f9ab1be4da6f775b3044ff6ec7ed7bcab1f1a09-image.png" align="center" border={true} />


  Note: for Android, we recommend you to use Universal Links rather than an app scheme because the OS does not allow you to open deeplinks leveraging an app scheme from the camera which is what you will need to for the preview

- [ ] You have integrated the code snippet to manage deeplinks

- [ ] You execute the code allowing the Purchasely SDK to open deeplinks

### Functional test

- [ ] When you create a Screen and save it in the Purchasely Console, you are able to preview it in your app by scanning the QR code


<Image src="https://files.readme.io/5920aa891ff42ce628a2a1c4b99026d17f8e4a3ae684706b64af349ea6ede9d8-image.png" align="center" border={true} />


- [ ] When copy / pasting a Screen deeplink from the Purchasely Console and opening it with your device, you are able to visualize the desired Screen


<Image src="https://files.readme.io/c8ac543415eaaeffdf8ca3fd772ab0712d5dfa10806023d8c757a86d1cd2954a-image.png" align="center" border={true} />


## 3. Users are properly identified

### Managing signed-in users

- [ ] The User ID is properly set when users sign-in

- [ ] When users are already signed-in upon the start of the app, the `user_ID` is provided to the SDK in the initialization method.

- [ ] When users sign-in during the session, the `userLogIn` method of the SDK is being properly called (📚 [documentation](user-identification#authenticate-users))

- [ ] In the [Subscriptions section of the Console](https://console.purchasely.io/subscriptions), transactions associated with an identified users are associated with the `user_ID` provided by the app


<Image src="https://files.readme.io/0441c42c4cbe572cfac03b742b84f36f861911f7646d3e017f4d7ce3e68d0c1c-image.png" align="center" border={true} />


### Signing-out users

- [ ] The log out method is properly called when users sign-out

- [ ] In the [Subscriptions section of the Console](https://console.purchasely.io/subscriptions), transactions associated with an anonymous user are associated with an `anonymous ID`


  <Image src="https://files.readme.io/1b34f03b1f317daa956c37f3e2e47d6b5019082b71375ec6a801710f7d19dec4-image.png" align="center" border={true} />


## 4. Screens are displayed through Placements

- [ ] You have displayed a Screen by associating it with a Placement and by making a direct call to the placement on the app side (📚 [documentation](general-in-app-experiences-display))

- [ ] **\[Optional]** - You've leveraged Placement pre-fetching (📚 [documentation](pre-fetching)) when you need to fetch a Screen in advance and display it later, or when you want to nest a Purchasely view into a parent view (📚 [documentation](nesting-views)

## 5. \[Optional] Custom User Attributes have been implemented to segment users

📚 Documentation: [Segmenting you user base](segmenting-your-user-base)

- [ ] When that makes sense, you leverage Custom User Attributes (📚 [documentation](general-custom-user-attributes-integration)) to attach properties to users and be able to segment them with your own data

### Technical instructions

- [ ] You have created the Custom User Attributes in the Purchasely Console

- [ ] You properly set the attribute and its value

- [ ] You have created an Audience leveraging the Custom User Attribute (📚 [documentation](audiences))

### Functional test

- [ ] You have associated a customized the Screen displayed for your Audience on the Placement of your choice

- [ ] When you display this Placement inside the app and that the user belongs to that Audience, you see the associated Screen instead of the default one displayed to _Everyone else_.


<Image src="https://files.readme.io/e2b7125ce2daf265bdf63d296ab6d2466cab6f565eeb2b3a31741516991e59ab-image.png" align="center" width="400px" border={true} />


## 6. \[Optional] You fetch user insights in the app upon a Quizz submission

📚 Documentation: [Gaining Insights and Driving Personalization with Surveys](user-surveys)

### Technical instructions

- [ ] You have implemented the listener / delegate for Custom User Attributes (📚 [documentation](analytics-integration#custom-user-attributes-listener))

- [ ] You have created a new [Custom User Attribute in the Purchasely Console](https://console.purchasely.io/user-attributes), with the appropriate type

- [ ] You have configured a Survey leveraging the [MCQ component](mcq), activated option "Save as a custom user attribute" and associated the MCQ to the Custom User Attribute created

### Functional test

- [ ] When users answer to the Survey created, the app fetches the `{key, type, value}` of the Custom User Attribute

- [ ] This data is sent to wherever you choose to send it to (e.g.: backend, data warehouse, 3rd party analytics, 3party engagement / CRM platform...)

- [ ] You have created an Audience leveraging the Custom User Attributes and are able to tailor the Screen viewed depending on user insights.

## 7. \[Optional and advanced] You process the UI / SDK events generated by the SDK and forward them to your analytics platform

### Technical instructions

- [ ] You have implemented the listener / delegate for UI / SDK Events (📚 [documentation](ui-sdk-events#how-to-leverage-them-by-implementing-an-event-delegate-inside-the-app))

### Functional test

- [ ] When you interact with Purchasely Screens, you see the Purchasely UI / SDK analytics in the 3rd party analytics / engagement platform you've forwarded them to

<br />
