---
title: Leveraging Quizzes to fetch User Insights
excerpt: >-
  This page provide details on Quizzes' data model configuration and User
  insights visualization
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# General overview

**Quizzes** are useful to collect feedback from your users. They can be integrated in a Screen to fetch user insights.

With Purchasely, you can create no-code quizzes and integrate them into Screens designed with the Screen Composer. The users' answers, can then be visualized in the Purchasely Console or leveraged to personalize the journey for each user.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/9d6c700c26873061767a50f154eb7150295d687ec05797c8de838e820c9faaa7-image.png",
        null,
        "Summary of the value proposition of Purchasely's Quizzes"
      ],
      "align": "center",
      "border": true,
      "caption": "Summary of the value proposition of Purchasely's Quizzes"
    }
  ]
}
[/block]


<br />

## Benefits

The Screen Composer offers the following benefits:

- **Ease of creation**: you can create native Quizzes in no-code and deploy them into your app without needing to update it.
- **Flexibility**: the Quiz component is flexible and can be configured in different way. You can define: 
  - whether multiple answers are possible or not
  - whether the Quiz should be mandatory or optional
  - whether the answer should be submitted as soon as the user clicks on it or if a validation is required by click on a validation CTA.
- **Data collection**: when users answer a Quiz, the data is collected by the Purchasely platform and the user Insights can be visualized directly in the Purchasely Platform. User answers can also be exported in a CSV file to feed your CRM or engagement platforms.
- **User segmentation**: answers submitted can be saved as an Insight attribute for each user. This will allow you to segment your user base depending on their answers by creating Audiences.
- **Data integration**: the [Delegate / Listener for User Attribute](custom-user-attribute-listener) is a generic mechanism that lets you fetch the user insights for any Quiz created with the Screen Composer. By integrating it into your app, you can forward the user insights it to any 3rd party engagement/CRM/analytics platform or to your own backend.

### Examples of Quizzes

A typical example is a **cancellation survey**:

- when a user cancels their subscription you can ask them why they canceled their subscription
- the answer provided can be saved in an Insight attribute
- you can then create an audience to target users who submitted a specific answer.  
  Eg: _`cancelation_reason` is equal to `subscription_too_expensive`_
- a specific User Flow can then be created for this particular Audience.  
  Eg: _Presenting a discounted retention offer to the user who said their subscription was too expensive _

<br />

Another example is a **post-paywall survey**:

- when a user closes the paywall at the end of the onboarding, you can ask them why they did not start their free trial
- the answers provided let you learn more about the reasons preventing users to start a free trial right away
- by saving answers in an Insight attribute, you can also tailor journeys addressing their particular concerns

![](https://files.readme.io/35f9b3b8aab2a68b6471bdd38a6f55f2bdcd1b75c17648f742f3d0cf2a570ebc-image.png)

<br />

<br />

# Quiz configuration

## General process

Here is the process to create a Quiz and link it to a Screen.

1. [Create and set up a Quiz](htuser-insights#1-creating-a-quiz) in the [section Quizzes of the Console](https://console.purchasely.io/quizzes)
2. [Integrate a Quiz component inside a Screen and design it](user-insights#2-integrating-the-quiz-into-a-screen-and-designing-it)
3. [Visualize the Users insights in the Console](user-insights#3-visualizing-the-user-insights-in-the-console)
4. [Export the user insights in CSV](user-insights#4-exporting-the-user-insights-in-csv)

<br />

## 1. Creating and setting up a Quiz

The Quiz created in the [section User Insights of the Console](https://console.purchasely.io/user-insights) carries the data model and the stored answers. It will let you visualize and export the user insights based on the responses.

Create a Quiz by clicking on the button in the upper right corner.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/0adaec0bfb9c11b76d47eaa001a9ed049cde3a2c6d0014135acefbb2f10553b2-image.png",
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

### Setting up the Quiz basic parameters

Fill the following fields:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/7e8ba81b3cab48dc8f369864631613412b6c7d55447ec0a027150cb8a7dce2d6-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


- `Quiz Question`: simply write down Question you want to ask to your users in natural language or in the default locale of the app.  
  Note: This string will only be displayed in the Purchasely Console and you will have the opportunity to configure - and localize- the actual question displayed to the end user later, when setting up the Screen and the Quiz component.
- `ID`: this is a unique identifier that will be used by the SDK to link answers submitted by the users with the associated data. This field is automatically generated when you type the question (it removes spaces and special characters) but you can change it before saving. If you do, enter an explicit and meaningful string.
- `Tags`: like for any object in the Purchasely Console, you can associate tags with them that allow you to classify them and organize the console. You can add as many tags as desired.
- `Multiple answers`: this toggle allows you to define whether users will be able to select several answers or only one when responding to the Quiz.

  [block:image]{"images":[{"image":["https://files.readme.io/dcf00da8843ee808a8094d82c294e14eb20755d42aefd8b4e99b26bb9028c2f7-quiz.gif","",""],"align":"center","border":true}]}[/block]

  - If you activate multiple Answers, you can define the minimum number of answers that need to be selected before being able to submit the form
- `Save answer(s) as an Insight Attribute`: when a user responds to a quiz, the answer(s) can be store in an Insight attribute, that you can then leverage to tailor the user journey:
  - if your Quiz is part of an onboarding Flow and you want to personalize the Flow based on users answers, you need to activate this toggle
  - if your Quiz is a simple poll simply used for user research purposes, without the need for further personalization, you can deactivate the toggle

<br />

### Configuring the Quiz answers

To finalize the configuration of the Quiz, you need configure the `Answers` users can chose from.

- For each answer, you must provide a unique, language-independent value that will be used to track answers individually and display them in charts.  
  This string is only used to identify the response submitted by the user and build the chart. You will have the opportunity to configure - and localize - the actual answers displayed to the user later when setting up the Screen and the Quiz component.  
  This separation lets you display answers in multiple languages while ensuring consistent tracking across locales.

<br />

Example:

_For the Question “What would you like some help with?”_

| #        | Displayed Text (defined in the Quiz component) | Answer's `value` (defined in the Quiz Data Model) |
| :------- | :--------------------------------------------- | :------------------------------------------------ |
| Answer 1 | Practicing self-care                           | `selfcare`                                        |
| Answer 2 | Building healthy relationships                 | `relationships`                                   |
| Answer 3 | Sleeping soundly                               | `sleeping`                                        |
| Answer 4 | Releasing stress                               | `stress`                                          |

Once saved, Answers cannot not be modified or deleted.

<br />

## 2. Integrating the Quiz into a Screen and designing it

### Adding and configuring the Quiz Component

To integrate your Quiz into a Screen, you must use the Quiz component inside the Screen Composer.

Add this element to your Screen and link it to the Data model - [the Quiz created in step 1](htuser-insights#1-creating-a-quiz) - by selecting it in the list.

![](https://files.readme.io/a695313cfa3d5023067c018ebed351b61376cd58045eb88f64f3d67582aea821-image.png)

<br />

You can also create a new Quiz directly from the Screen Composer by clicking on the button "+ Create new Quiz"

Once associated, you can personalize the Quiz behavior:

- `Skippable`: whether the Quiz can be skipped or not - the submit button will be activated directly if it's not mandatory
- `Validate on selection`: for Quizzes configured with a unique answer, whether the response should be validated by clicking on a confirm button (toggle deactivated) or directly submitted when the user selects it (toggle activated)

  <br />

  [block:image]{"images":[{"image":["https://files.readme.io/518a261108875c0896ee6275e961e107a5d1971b398532951624142f81037633-skip__validate.gif","",""],"align":"center","border":true}]}[/block]

<br />

### Designing the Quiz Component

The Screen Composer let you customize the look and feel of your Quiz.

📚 Follow the guide: [Designing a Quiz component](quiz)

<br />

## 3. Visualizing the user insights in the Console

Depending on the Quiz data model, you can visualize user insights in 2 different types of charts:

**Pie charts (unique answer)**

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/2d29441daf6bb7d760ed103fb6c700ba2a715c7e4aba0e5d8514452e1691b80e-image.png",
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

**Bar charts (multiple answers)**

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/895aa15e7fb0384085e54dc61bdf70f7c96dba07ed5f0b15c155eff530c31b12-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


You can leverage the filters on the top of the Screen to refine / narrow the data presented:

- between a specific date range
- per platform
- per country
- per Screen

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/d9a948cadb73a570aa9964295be073af8516f729c421556a2a807a0974905489-image.png",
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

## 4. Exporting the user insights in CSV

To export the user insights in CSV, simply click on the button. You will receive the CSV file by email a few minutes after.

The export carries [the user ID if the user is logged-in](user-identification) and if they have given their consent to be tracked.

![](https://files.readme.io/0a88177282d3c208907be182c72b25a4286710ebe5039cc5653054ae938efb60-image.png)

If not, a randomly generated `user anonymous ID` will be used and the column `Is anonymous?` will be set to 1.

<br />

# Tailoring the journey to the user insights

When configuring the Quiz, if you have activated the option "Save answer(s) as an insight attribute", the answer(s) submitted by the users will be automatically associated to the user and you will be able to leverage the corresponding attribute in an [Audience](audiences).

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/846d9bdcad7e8abe9f5587ab73a2ce3a783a2fc27f89a5dbb44ca78b74fa5f97-audience.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


The Audience created can then be associated to an In-App Experience for a particular Placement:

📚 Follow the guide: [Leveraging Audiences to tailor the In-App Experience for specific user segments](leveraging-audiences)

You can also leverage the answers directly within the Flows to tailor the journey to the user insights by defining conditional transitions

📚 Follow the guide: [Tailoring flows to the user insights](tailoring-flows-to-user-insights)

<br />

# Fetching the Quiz insights in the app

The answers submitted by the user can also be fetched in the app, to be sent to your own backend or any 3rd-party analytics, CRM or engagement plateform.

📚 Follow the guide: [Fetching the Quiz insights in the app](fetching-quiz-insights)