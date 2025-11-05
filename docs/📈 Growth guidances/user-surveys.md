---
title: Gaining Insights and Driving Personalization with Surveys
excerpt: >-
  This page describes the process to build a personalized user journey based on
  user insights collected inside that journey
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
**74% of users** expect apps to be **personalized** to their needs and interests. 

Gaining insights with user surveys can help you personalize the user journey and make your service better match your user needs and interests.

Purchasely enables seamless integration of surveys into your app, unlocking valuable user insights that can be fetched and processed in real time. These insights empower you to personalize the user journey dynamically, delivering tailored experiences that drive engagement and satisfaction.

Here is an example of a personalized user journey built for [Headspace](https://www.headspace.com/) a leading app in meditation and well-being.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/5163e70c93ac5df593742006fa020ca245943c3e26b0e74383a1465dea19e56c-headspace_flow.png",
        null,
        "This user journey aims to increase the user engagement during the free trial and the conversion to paid, by collecting user insights, personalizing the user journey and recommending the relevant contents for each users"
      ],
      "align": "center",
      "border": true,
      "caption": "This user journey aims to increase the user engagement during the free trial and the conversion to paid, by collecting user insights, personalizing the user journey and recommending the relevant contents for each users"
    }
  ]
}
[/block]


<br />

Here is a firsthand look at the app with this preview:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/bcdcbd9922ddb595fcd199edf1cb0a15a29dbe61a00e6609c5d78809dc6a13c3-headspace_reveal.gif",
        "",
        "Depending on user insights and the combination of answers, the reveal Screen can showcase multiple profiles: The Balance Builder or The Peaceful Thinker"
      ],
      "align": "center",
      "border": true,
      "caption": "Depending on user insights and the combination of answers, the reveal Screen can showcase multiple profiles: The Balance Builder or The Peaceful Thinker"
    }
  ]
}
[/block]


<br />

Let’s explore how you can implement this!

## General functioning

- The Purchasely Screen Composer allows you to integrate inside your Screens a **[Multiple Choice Question (MCQ)](mcq)** component.
- With this component, you can ask users a Question and present different Answers that they can choose from
- The answer(s) - depending on how you configure the component, it can allow multiple answers or not - can then be saved as a Custom User attribute: when the user picks an answer, the SDK will automatically save the corresponding value in the associated Custom User Attribute
- The user data - the attribute, its type and the value()s picked up by the user - can be fetched in the app by using the [Event Listener / Delegate for Custom User Attributes](custom-user-attribute-listener).
- These Custom User Attributes can then be reused to create Audiences. By leveraging Placements, you can personalize the Journey in real time, depending on the insights provided by the User

<br />

## How to set up a MCQ component?

Follow the [guide](mcq)!

When configuring the component, you should make sure that:

1. the `Survey Id` configured has an explicit name which matches the question asked
   - the default Survey Id `survey_1` can be changed by clicking on the button **+ Create new Survey Id**
2. the parameter `Save answer in Custom User Attribute` is activated and associated with an attribute with the relevant type:

   - if the parameter Allow multiple (answers) is deactivated, the associated Custom User Attribute type should be a `String`

     [block:image]{"images":[{"image":["https://files.readme.io/9af64264b2334a0a2a33da44215e48427b86cd281760e56a6147c5bdcbc1344f-goal.gif","",""],"align":"center","border":true}]}[/block]
   - if the parameter Allow multiple (answers) is activated, the associated Custom User Attribute type should be an `Array of Strings`

     [block:image]{"images":[{"image":["https://files.readme.io/176bd69cd30e503757922fc0ba3737ebb55941f40d0580f55b5463f5756ad748-goals.gif","",""],"align":"center","border":true}]}[/block]
   - you can directly create a new Custom User Attribute and associate the relevant type by clicking on the button **+ Create new User Attribute**
3. Each Answer is associated with a `value`, consistent with the Text of the Answer.

   [block:image]{"images":[{"image":["https://files.readme.io/49be6be00c2e443f18a40f5f5e5186738b7143f425e16d223dc00faf7709b2ff-answers.gif","",""],"align":"center","border":true}]}[/block]

   - this is the value that you will get when fetching the data and processing it in the app
   - it is the same value for all the languages
4. If the parameter `Validate on selection` is deactivated, your Screen should integrate a component CTA for Multiple Choice Question, associated with the same `Survey Id`

<br />

## How to fetch the user insights in the app?

You can use the [Event Listener for Custom User Attributes](custom-user-attribute-listener).

Upon the submission of the user's Answer, if the MCQ has been associated with a Custom User Attribute, the app will be notified via this listener / delegate.

The SDK provides:

- the `key` of the attribute
- the `type` of the attribute
  - `String` for single answer MCQs
  - `Array of Strings` for multiple answers MCQs
- the `value` (String - single answer) or `values` (Array of Strings - multiple answers) matching the Answers picked up by the user.

<br />

<EventListenerForCustomUserAttributesImplementation />

> 📘 Value of the parameter source
> 
> After the submission of the MCQ, the parameter `source` as the value `purchasely` to indicate to the app that the Custom User Attribute has been set by the SDK and not by the app.

<br />

## How to send the insights to my backend?

Once the app has been notified through the event listener / delegate, you can execute your own code and associate the Custom User Attribute returned and its value as a user trait and send this to your backend. 

This processing has to be done by your app. Purchasely does not provide a server to server integration to do it.

<br />

## How to send the data to 3rd party integrations?

It's the same with 3rd party integrations. After fetching the Custom User Attribute and its value, associate it to the user and leverage the mobile SDK API of your 3rd-party platform to send it.

For instance, this can be achieved with the following platforms (the list is not exhaustive):

- [Amplitude](amplitude)
- [Braze](braze)
- [MixPanel](mixpanel)
- [Iterable](iterable)
- [Clevertap](clevertap)
- [OneSignal](onesignal)
- [Batch](batch)
- [Google Analytics for Firebase](google-analytics-for-firebase)
- [Piano analytics](piano-analytics)
- [Airship](airship)
- [MoEngage](moengage)
- or any 3rd party SDK integrated inside your application

This processing has to be done by your app. Purchasely does not provide a server to server integration to do it.

<br />

## How to nest my flow inside a navigation viewController on iOS?

By default, Screen get displayed in modale by the Purchasely SDK. If you want to nest the sequence of Screens in a navigation viewController, you need to implement it on the app side:

1. Pre-fetch the Placement associated with the first Screen of your flow
2. Nest the view returned by the SDK in a Parent view, integrating a navigation bar

```swift Swift
to be completed 
```

<br />

## How to create Journeys composed of several questions?

To link Screens together, you can leverage the different [Action types](action-types) supported by the Screen Composer.

- **Open Screen** allows you to link to another Screen built with the Screen Composer or the Legacy Paywall Builder
- **Open Placement** allows you to link to a Placement - giving you opportunity to [create a personalized User Journey](https://docs.purchasely.com/docs/user-surveys#how-to-personalize-the-user-journey-based-on-the-insights-provided)
- **Deeplink** allows you to link to any supported deeplink - either inside of the application or in another app
- **Web Page** allows you to open a web page in the web browser (iOS) or in a web view inside the application (Android)
- **Close** and **Close all** allow you to dismiss the current Screen or all the Screens from the sequence at once

<br />

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/9453ab7d72cbfc37669ace3e57d5f5667cb511ba3795e84e9985b0db1ebd5dda-image.png",
        null,
        "For 1 to 1 transitions => use the action **Open Screen**  \nFor 1 to N transitions => use the action **Open Placement**"
      ],
      "align": "center",
      "border": true,
      "caption": "For 1 to 1 transitions => use the action **Open Screen**  \nFor 1 to N transitions => use the action **Open Placement**"
    }
  ]
}
[/block]


<br />

<br />

## How to personalize the User Journey based on the insights provided?

[Placements](displaying-screens-placements) allow you to map Screens with specific Audiences.

When the next Screen (N+1) can vary depending on Audience, you need to use on the previous Screen (N), the action **Open Placement**

If you want to personalize the User Journey depending on the user insights provided, proceed as follows:

1. For each MCQ component of your flow, activate the parameter `Save answer in custom user attribute` and map them with the desired Custom User Attribute  
   _E.g.: _
   - _the MCQ component of the Screen What is your experience in meditation? is mapped with the attribute experience (String) - single answer_
   - _the MCQ component of the Screen What can Headspace help you improve? is mapped with the attribute goals (Array of Strings) - multiple answers_ 
     1. <br />
2. Create the desired Audiences leveraging these Custom User Attributes  
   _E.g.: _

   [block:image]{"images":[{"image":["https://files.readme.io/bec64538b5564775cf03139fbd23eb283840f091fb3e868eb1c564451e7179c9-image.png",null,""],"align":"center","sizing":"600px"}]}[/block]

   <br />
3. Create a new Placement, and map the different Audiences created with each Screen  
   _E.g.:_

   [block:image]{"images":[{"image":["https://files.readme.io/eeeefc057159772a4f7cc0840e026828f8127ed4217a6ff2e6ed19e96ee428b7-image.png",null,""],"align":"center","sizing":"3px"}]}[/block]
4. Map the action of the Screen N with action **Open Placement** and the Placement created

   [block:image]{"images":[{"image":["https://files.readme.io/e469df40b297e59bac36b1f32505f69b8939b561530ab5ad9fb6de50e9e0e475-image.png",null,""],"align":"center","sizing":"400px"}]}[/block]

You're all set!