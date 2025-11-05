---
title: Tailoring Flows to the user insights
excerpt: >-
  This section describes how integrate Questions into your Flow, configure them
  and define the decision logic to tailor the Flow based on users responses
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Flows allow you to tailor the user journey based on user insights, enabling deeply personalized experiences that drive higher engagement and conversion. For your users, this means a more relevant and frictionless journey - from onboarding to paywall exposure - aligned with their needs, goals, or motivations. Instead of receiving a generic flow, each user is guided through content, features, and offers that actually resonate with them.

For you, this unlocks the ability to deliver differentiated, intent-based journeys in no-code without duplicating screens or hardcoding decision logic. It simplifies experimentation, maximizes reusability, and makes personalization scalable - resulting in better performance across key KPIs like opt-in rates, trial starts, and subscriptions.

> 🚧 SDK v5.3.0+ required
>
> To leverage Flows, your app must be running [SDK version `v5.3.0`](https://docs.purchasely.com/changelog/53)

# Setting up personalized Flows based on user insights

Creating a personalized user journey with Flows integrating Quizzes is a powerful way to guide users based on what truly matters to them. The process involves three key steps:

1. [**Integrate a Quiz into your Flow**](tailoring-flows-to-user-insights#1-integrate-a-quiz-into-your-flow)
2. **Create conditional transitions and define the eligibility conditions for each transition** to route users to different destination Screens based on their insights

This approach transforms static flows into dynamic, insight-driven journeys—improving relevance, engagement, and conversion from the very first interaction.

## 1. Integrate a Quiz into your Flow

The first step consists in:

* [Creating and setting up a Quiz and integrating it into a Screen](user-insights#1-creating-and-setting-up-a-quiz)
* [Designing the Quiz](user-insights#2-integrating-the-quiz-into-a-screen-and-designing-it)  and the Screen carrying it

<Image align="center" className="border" border={true} src="https://files.readme.io/4df9c83fd6752376ca7a9a5a75591cb8b8f4938ce8d137123c6203f712b55df5-quiz.gif" />

Once the Screen integrating your Quiz has been created and designed, simply drag & drop it into your Flow and link it to the next Screen.

You can repeat this process for each Quiz of your Flow.

<Image align="center" className="border" border={true} src="https://files.readme.io/694ff0249cffd52d38e8208c2fa1e775087f1d11d542dc5f33705da96c702900-flow.gif" />

## 2. Create conditional transitions and define the eligibility conditions for each transition

When users answer a Question, their selected values are stored as Insight Attributes — which can then be used to personalize navigation within your Flow.

If you want to configure a conditional Transition — i.e., a transition that dynamically routes users to different Screens based on their responses — follow these steps:

1. **Link the action cartridge of the source Screen to multiple destination Screens**\
   Attach several possible target Screens to the same interactive component (e.g. a Continue button).
2. **Edit the Transition logic**\
   Click on the Transition to open the configuration panel, then map the eligibility conditions for every destination Screen by:

   * leveraging existing Audiences
   * creating a new one

   <Image alt="To create an Audience for users who selected a specific answer, simply select the Quiz (e.g.: What would you like some help with?) and then the corresponding value(s) (e.g.: stress or anxiety)" align="center" border={true} src="https://files.readme.io/0d2a7bfc14f53fbdcbdf51735188f2f9a6f07f61cec075abfaa609ff37829d85-audience.gif">
     To create an Audience for users who selected a specific answer, simply select the Quiz (e.g.: What would you like some help with?) and then the corresponding value(s) (e.g.: stress or anxiety)
   </Image>
3. **Order the routes**\
   Prioritize Audiences by ordering the Routes, just like you would in a Placement, ensuring the most specific conditions are evaluated first.

<Image align="center" className="border" border={true} src="https://files.readme.io/9d45652982f1e8725a42b9eb9490a6d02be3614a6cb660e831fa6ec59971e108-flow_3.gif" />

You're all set!

This setup allows you to deliver deeply personalized journeys tailored not just by behavior but by declared user intent without duplicating screens or flows.

<Image align="center" className="border" border={true} src="https://files.readme.io/d7ccf7b48fccb704b04e3475aa966dce09b11656e563057df3bc3de4598fe75d-precommitment.gif" />

# Fetching the Quiz insights in the app

The answers submitted by the user can also be fetched in the app, to be sent to your own backend or any 3rd-party analytics, CRM or engagement platform.

📚 Follow the guide: [Fetching the Quiz insights in the app](fetching-quiz-insights)
