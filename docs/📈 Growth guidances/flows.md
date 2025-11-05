---
title: Gaining Insights and Driving Personalization with Flows
excerpt: >-
  This page describes the process to build a personalized user journey based on
  user insights collected inside that journey
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    In the next section, we explore the prerequisites to implementing Flows into
    your app
  pages:
    - type: basic
      slug: flow-implementation
      title: Prerequisites & Flows Implementation
---
> 🚧 SDK v5.5.0+ recommended
> 
> Flows require to integrate SDK v5.3 and above. They are supported since this version, but we recommend v5.5.0 for a better stability and data consistency.

In today’s saturated app market, the first few moments of a user's journey are make-or-break. Personalizing onboarding isn’t just a best practice - it’s a competitive necessity. By asking questions, segmenting users based on their answers, and aligning the experience with their goals using the Jobs-To-Be-Done (JTBD) framework, product teams can deeply connect with users' intent from the start.

Instead of guiding everyone through a one-size-fits-all journey, a personalized flow adapts the experience: showing the right value proposition, surfacing the right features, and triggering the right messages at the right time. This not only boosts activation and engagement but also dramatically increases conversion into paying, loyal subscribers.

>  **74% of users** expect apps to be **personalized** to their needs and interests. 

Creating personalized sequences of Screens and onboarding, that collects user insights and surface their jobs to be done is a key element to engage them, convert them into loyal subscribers and retain them.

This is precisely the role **Flows** are designed to fulfill:

[block:html]
{
  "html": "<div style=\"margin: 30px 0; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(0,0,0,0.08);\">\n  <div style=\"position: relative; padding-bottom: 56.25%; height: 0;\">\n    <iframe \n      src=\"https://www.loom.com/embed/fbcccc1ca8c2489ca004af9e174aece4\"\n      frameborder=\"0\"\n      allowfullscreen\n      webkitallowfullscreen\n      mozallowfullscreen\n      style=\"position: absolute; top: 0; left: 0; width: 100%; height: 100%;\">\n    </iframe>\n  </div>\n</div>\n\n<p style=\"text-align:center; font-size:14px; color:#777; margin-top:8px;\">\n  🎬 Trailer — Discover how Flows transforms your onboarding experience\n</p>\n"
}
[/block]


<br />

**Flows** empower marketers and product teams to craft modular, dynamic onboarding and engagement journeys -without writing code. With visual control over decision trees, contextual screens, and logic-driven paths, Flows make it easy to:

- Craft entire sequences of Screens designed with the Purchasely Screen Composer
- Ask relevant questions (e.g., goals, motivations, usage preferences)
- Personalize content and screens in real time,
- Align messaging with user intent and JTBD insights,
- Optimize conversion paths and continuously test variants.

The result? A tailored native onboarding experience that feels smart, and deeply relevant - accelerating time-to-value and reducing churn from day one.

<br />

# Access to the Flow feature

The Flow feature integrates a freemium version accessible to all our customers which allows you to create and modify one single Flow, limited to 5 Screens. This Flow can be published and integrated into your app.

To create additional Flows you need to have the Flows module integrated in your Purchasely Plan.

If you're interested in enabling this feature, please contact your Customer Success Manager. We’ll be happy to walk you through the upgrade options and help you get started.

| Benefit / feature                                                                                       | Flows Freemium version | Flows Premium version                |
| :------------------------------------------------------------------------------------------------------ | :--------------------- | :----------------------------------- |
| Create, publish and modify a Flow into your app                                                         | ✅                      | ✅                                    |
| Leverage Quizzes to collect user insights                                                               | ✅                      | ✅                                    |
| Tailor Flows to the user insights                                                                       | ✅                      | ✅                                    |
| Associate a Flow with a Placement                                                                       | ✅                      | ✅                                    |
| Access Flow analytics and Flow dedicated dashboard to measure your funnel's performance and optimize it | ✅                      | ✅                                    |
| Number of Flows                                                                                         | Limited to 1           | Unlimited                            |
| Number of Screens per Flow                                                                              | Limited to 5           | Unlimited                            |
| A/B test different Flows to optimize conversion and retention                                           | ❌                      | ✅                                    |
| Integrate your own Screens into a Flow                                                                  | ❌                      | ✅ (Coming soon with SDK version 5.6) |

<br />

# Pre-requisites & Implementation

To implement Flows into your app, you should use Purchasely [SDK version 5.5.0](https://docs.purchasely.com/changelog/55) 

Prefetch the Flow presentation associated to a Placement, then call the new `display()` of the SDK.

📚 More details on the [new `display()` method and implementing Flows into your app](flow-implementation)

<br />

# Build sequences of Screens with Flows

A Flow is composed of a sequence of Screens crafted with Purchasely Screen Composer. Here is a short video tutorial that explains how to build a Flow.

📚 For more details, follow the [step by step Flow and configuration guide](flow-configuration)

[block:html]
{
  "html": "<div style=\"margin: 30px 0; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(0,0,0,0.08);\">\n  <div style=\"position: relative; padding-bottom: 56.25%; height: 0;\">\n    <iframe \n      src=\"https://www.loom.com/embed/0e5369b8c0b04a60aa1528ee345d0aca\"\n      frameborder=\"0\"\n      allowfullscreen\n      webkitallowfullscreen\n      mozallowfullscreen\n      style=\"position: absolute; top: 0; left: 0; width: 100%; height: 100%;\">\n    </iframe>\n  </div>\n</div>\n\n<p style=\"text-align:center; font-size:14px; color:#777; margin-top:8px;\">\n  🎥 Tutorial — Create your first Flow in minutes\n</p>\n"
}
[/block]


> 📘 Acknowledgement
> 
> \_The flow presented in the video is a personalized user journey built for [Headspace](https://www.headspace.com) a leading app in meditation and well-being, and one of the most recognized for the personalization of its user journeys. 
> 
> - _It consists of a series of carefully crafted questions._
> - _The user’s responses are used to personalize their experience by assigning them to a profile that reflects their goals, preferences, or challenges, allowing the app to recommend content that best matches their specific need_
> 
> _The Headspace Flow was imagined and designed by [Irrational Labs](https://irrationallabs.com/) - the leading behavioral science consultancy for designing better choices and aims to increase the user engagement during the free trial and the conversion to paid, by collecting user insights, personalizing the user journey and recommending the relevant contents for each user_

# Going further

Flows can be personalized based on user insights. 

📚 Follow the guides to learn more: 

- [Leveraging Quizzes to fetch user insights](user-insights)
- [Tailoring Flows to the user insights](tailoring-flows-to-user-insights)