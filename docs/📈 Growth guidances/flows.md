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
    In the next section, we will explain how to tailor a Flow to the user
    insights
  pages:
    - type: basic
      slug: tailoring-flows-to-user-insights
      title: Tailoring Flows to the user insights
---
In today’s saturated app market, the first few moments of a user's journey are make-or-break. Personalizing onboarding isn’t just a best practice - it’s a competitive necessity. By asking questions, segmenting users based on their answers, and aligning the experience with their goals using the Jobs-To-Be-Done (JTBD) framework, product teams can deeply connect with users' intent from the start.

Instead of guiding everyone through a one-size-fits-all journey, a personalized flow adapts the experience: showing the right value proposition, surfacing the right features, and triggering the right messages at the right time. This not only boosts activation and engagement but also dramatically increases conversion into paying, loyal subscribers.

>  **74% of users** expect apps to be **personalized** to their needs and interests. 

Creating personalized sequences of Screens and onboarding, that collects user insights and surface their jobs to be done is a key element to engage them, convert them into loyal subscribers and retain them.

This is precisely the role **Flows** are designed to fulfill.

**Flows** empower marketers and product teams to craft modular, dynamic onboarding and engagement journeys -without writing code. With visual control over decision trees, contextual screens, and logic-driven paths, Flows make it easy to:

* Craft entire sequences of Screens designed with the Purchasely Screen Composer
* Ask relevant questions (e.g., goals, motivations, usage preferences)
* Personalize content and screens in real time,
* Align messaging with user intent and JTBD insights,
* Optimize conversion paths and continuously test variants.

The result? A tailored native onboarding experience that feels smart, and deeply relevant - accelerating time-to-value and reducing churn from day one.

<br />

# Access to the Flow feature

The Flow feature integrates a freemium version accessible to all our customers which allows you to create and modify one single Flow. This Flow can be published and integrated into your app.

To create additional Flows you need to have the Flows module integrated in your Purchasely Plan.

If you're interested in enabling this feature, please contact your Customer Success Manager. We’ll be happy to walk you through the upgrade options and help you get started.

| Benefit / feature                                                                                       | Flows Freemium version | Flows Premium version |
| :------------------------------------------------------------------------------------------------------ | :--------------------- | :-------------------- |
| Create, publish and modify a Flow into your app                                                         | ✅                      | ✅                     |
| Leverage Quizzes to collect user insights                                                               | ✅                      | ✅                     |
| Tailor Flows to the user insights                                                                       | ✅                      | ✅                     |
| Associate a Flow with a Placement                                                                       | ✅                      | ✅                     |
| Associate a Flow to a Campaign to launch it automatically when the app starts                           | ❌                      | ✅                     |
| A/B test different Flows to optimize conversion and retention                                           | ❌                      | ✅                     |
| Access Flow analytics and Flow dedicated dashboard to measure your funnel's performance and optimize it | ❌                      | Coming soon           |
| Integrate your own Screens into a Flow                                                                  | ❌                      | Coming soon           |

<br />

# Build sequences of Screens with Flows

> 🚧 SDK v5.3.0+ required
>
> To leverage Flows, your app must be running [SDK version `v5.3.0`](https://docs.purchasely.com/changelog/53)

## General overlook

Here is an example of a personalized user journey built for [Headspace](https://www.headspace.com/) a leading app in meditation and well-being.

<Image alt="This flow was imagined and designed by [Irrational Labs](https://irrationallabs.com/) - the leading behavioral science consultancy for designing better choices and aims to increase the user engagement during the free trial and the conversion to paid, by collecting user insights, personalizing the user journey and recommending the relevant contents for each user" align="center" border={true} src="https://files.readme.io/b10fd734530e281d0f34918d2344ca7de4b098dfb32285709a75c1ee90053bf0-headspace_flow.gif">
  This flow was imagined and designed by [Irrational Labs](https://irrationallabs.com/) - the leading behavioral science consultancy for designing better choices and aims to increase the user engagement during the free trial and the conversion to paid, by collecting user insights, personalizing the user journey and recommending the relevant contents for each user
</Image>

<Image alt="This Headspace Flow consists of a series of carefully crafted questions. The user’s responses are used to personalize their experience by assigning them to a profile that reflects their goals, preferences, or challenges, allowing the app to recommend content that best matches their specific needs" align="center" border={true} src="https://files.readme.io/a6abfb503395afe9e9700da4404eea42fcc5de797ed71af42c789c3a86cf9959-headspace_flow_console.gif">
  This Headspace Flow consists of a series of carefully crafted questions. The user’s responses are used to personalize their experience by assigning them to a profile that reflects their goals, preferences, or challenges, allowing the app to recommend content that best matches their specific needs
</Image>

<br />

## How to build a Flow?

Let’s explore how to build a Flow with Purchasely.

The **Flow Composer** lets you:

1. drag and drop Screens built with the Purchasely Screen Composer, 
2. organize them inside a canvas
3. link them together with *Transitions*

<Image align="center" className="border" border={true} src="https://files.readme.io/ee8bf7617c07c37e33cb033a1158aa82757b63bbcc52334ebd21b604607cb579-flow_building.gif" />

<br />

*Transitions* allow you to link a component from a source Screen to the next Screen in the Flow. They can be defined for any interactive component - such as buttons, links, pickers or call-to-action elements - as long as they have an active action (i.e., an action other than “none” or "close"). These transitions allow you to override the default action configured at the Screen level. This makes it possible to reuse the same Screen across multiple Flows while customizing behavior as needed, significantly reducing duplication and improving maintainability.

<Image align="center" className="border" border={true} src="https://files.readme.io/9001640f6472fc7bbc3d0de39f1677d2a16279e26f6710c89cf5a26c6cef9d3e-transitions.gif" />

The components names that appear in the cartridges next to the Screen in the Flow Composer are the names defined for each component in the Screen structure (in the left column of the Screen Composer). 

You can rename a component by double-clicking on it in the Screen structure.

Both the *Main action* and the *Second action* of a component can be re-mapped / overridden with a transition only if they are associated with one of the following values:

* Open Screen
* Open Placement
* Deeplink
* Web Page

For the sake of clarity, if they are associated with any other action value than the ones listed above, they are ignored.

> 🚧 I can't see a cartridge matching my Screen component
>
> When drag & dropping a Screen into the Flow canvas, if you don't see the cartridge corresponding to one of the Screen Components, it's probably because the component isn't mapped with one of the authorized actions.
>
> In this case, simply edit the Screen by clicking on its name in the Flow canvas, then map the component with a compatible action (Open Screen, Open Placement, Web Page or Deeplink) and save.
>
> <Image align="center" src="https://files.readme.io/a1b52740943773d2e38450aa95983e15deab83ee22596d3df0aa0ae14150f28b-no_action.gif" />

A *Transition* can be associated with a "Type", 

<Image align="center" className="border" border={true} src="https://files.readme.io/aa98a791feb3d414337b700ab268ddeb39f0149f6a793409bdb69a16b144d5d3-image.png" />

The transition type can take the following values:

* `Push`
* `Modal`
* `Drawer`
* `Pop-in`
* `Full screen`

Here is how each Transition type looks like:

<Image align="center" className="border" border={true} src="https://files.readme.io/4a3d4c0e5e7ea20876ed959f203e623858cd7e12ac9de95c8c9c6556382ee770-types.gif" />

For drawers and popins, you can set the desired height:

<Image align="center" className="border" border={true} src="https://files.readme.io/b355f6c38b89ae7c02b022e86cfdcc9c96aea71d57cc3ae9d7fee408efb7cf69-image.png" />

To ensure a seamless user experience, the Flow Composer associate the background color of the destination Screen to the Transition (for both light mode and dark mode), but you can change that color if needed.

<Image align="center" className="border" border={true} src="https://files.readme.io/8664a427ae09322cc531333e73d901013b6da9fdd6f1fcfe1b5acbf7c9a31dcb-image.png" />

<br />

# Integrating Flows into your app

Once created, Flows can be associated with a [Placement](placement).

If you have the Flow feature integrated into your Plan, you can associate a Flow with an [A/B Test](ab-tests) or a [Campaign](campaigns).

## Mapping a Flow with a Placement

<Image align="center" className="border" border={true} src="https://files.readme.io/80c311eb197b69a6471f9db09ff67c3d6a67f844aac17ca9cf5efbd719c96ace-placement.gif" />

<br />

## Associating a Flow with a Campaign

This capability is only opened to customers benefitting from the Flows Premium feature.

The **[Campaigns](campaigns)** feature lets you create powerful no-code automations that will display a Purchasely Screen for a particular Audience at the App start.

Flows can be associated with Campaigns to combine both feature: the ability to display a customizable sequence of Screen following the app start.

This integration will automatically take the Display mode into consideration.

<Image align="center" className="border" border={true} src="https://files.readme.io/3d1054aaeb42eeccbd0280f3588472d600b0f5bf02d12c3e117a8b0a0afbeabf-image.png" />

## Running an A/B Test between 2 Flows

This capability is only opened to customers benefitting from the Flows Premium feature.

You can configure an A/B Test between 2 Flows or 1 Flow vs a single Screen.

<Image align="center" className="border" border={true} src="https://files.readme.io/9cf94e6d276d58c496fbb73761ae42bfa78d8ca448380a91aedb37967358265e-image.png" />

<br />

## Tracking events generated within a Flow

[UI / SDK events](ui-sdk-events) & [Server events](server-events) (e.g.: `PRESENTATION_VIEWED`,`SUBSCRIPTION_STARTED`, `TRIAL_STARTED`, `TRIAL_CONVERTED` and all subsequent lifecycle events such as`SUBSCRIPTION_RENEWED`, `RENEWAL_DEACTIVATED`, `SUBSCRIPTION_TERMINATED`) generated through a Flow will cary the `flow_id` .

Sample events:

```json PRESENTATION_VIEWED
{
  "event": {
      "properties": {
        "event_name": "PRESENTATION_VIEWED",
        "event_created_at_ms_original": 1750839495518,
        "event_created_at_original": "2025-06-25T08:18:15.518Z",
        "app_installed_at": "2025-06-24T14:13:51.662Z",
        "anonymous_user_id": "DD844D32-7E64-4F7D-8CA2-C2D3AEB84BE0",
        "type": "PHONE",
        "os_version": "iOS 18.1",
        "sdk_version": "5.3.0",
        "language": "en",
        "display_mode": "modal",
        "orientation": "portrait",
        "placement_id": "COURSE_MATCHING",
        "displayed_presentation": "question_time_spent",
        "presentation_type": "NORMAL",
        "flow_id": "onboarding_personalized_fit_v2",
        "flow_version": "52",
        "step_id": "79ec729d-b601-43e9-ac74-61f1cc8b70a8",
        "from_step_id": "b2720048-dc4c-4988-9133-555dbcca4e44",
        "from_action_id": "ecf27b8c-13db-4367-afda-cfb608518304",
        "flow_session_id": "A30666D8-6736-42FA-A80A-152A0C50469D"
      },
      "user_attributes": { ... },
      "built_in_attributes": { ... },
      "name": "PRESENTATION_VIEWED",
      "id": "168BBEAB-CEF8-4FEB-AD1B-8E28CD3FCC49"
    }
  }
}

```

<br />

# Implementing Flows into your app

There are several ways to display a Flow inside of the app:

1. Pre-fetching the Flow and using the `display()` method 
2. Manually integrating the Flow inside of your app (Android only)
3. Using the Flow deeplink

<br />

## 1. Prefetching the Flow and using the `display()` method

Inside of the app, Flows associated with a Placement can be pre-fetched ([more information on pre-fetching](pre-fetching)) and then showed to the user using the `display()` method (new method coming along with the `v5.3.0` of the SDK)

```swift Swift
Purchasely.fetchPresentation(for: "onboarding", fetchCompletion: { presentation, error in
      guard error == nil,
            let presentation = presentation else { return }
                                                                  
     // Calling display() to launch the flow
		 // Source UIViewController is optional 
     presentation.display(from: myUIViewController) 
})
```
```kotlin Kotlin
Purchasely.fetchPresentation(placementId = "onboarding") { presentation, error ->
  if(error != null) {
    Log.d("Purchasely", "Error fetching Screen", error)
    return@fetchPresentation
  }
  
  // Calling display() to launch the flow 
  presentation?.display(context) { result, plan ->
    when (result) {
      PLYProductViewResult.PURCHASED -> Log.d("Purchasely", "User purchased ${plan?.name}")
      PLYProductViewResult.CANCELLED -> Log.d("Purchasely", "User cancelled purchased")
      PLYProductViewResult.RESTORED -> Log.d("Purchasely", "User restored ${plan?.name}")
    }
  } ?: run {
    Toast.makeText(context, "Presentation display failed: presentation is null", Toast.LENGTH_SHORT).show()
    return@fetchPresentation
  }
}
```

The main benefit of this method is that it is simple and automatically takes the **Display Mode** configured for the Flow into consideration for displaying the first Screen of the Flow.

<Image alt="The display mode defines how the first Screen of the Flow should open" align="center" border={true} src="https://files.readme.io/a276eec6e01d7f867cef0337f4567a612c78e017326579818da016559673cd7f-display_mode.gif">
  The display mode defines how the first Screen of the Flow should open
</Image>

Here are how the different display modes look like:

<Image align="center" className="border" border={true} src="https://files.readme.io/4a3d4c0e5e7ea20876ed959f203e623858cd7e12ac9de95c8c9c6556382ee770-types.gif" />

Notes:

* The **Display mode** `Push` is only available on iOS, if the parent view already contains a navigation bar.\
  On Android or without a navigation bar, the **Display mode** will fallback to `Modal`

> 📘 Difference between the Flow display mode and the Screen transition type
>
> When configuring a Flow, it’s important to distinguish between the **Flow Display Mode** and the Transition Type. Each plays a distinct role in how screens appear within your app.
>
> ### Flow Display Mode
>
> The **Display Mode** determines how the first Screen of the Flow is presented within the app.
>
> It defines the integration behavior between the Flow and the parent view managed by your app—such as whether the Flow is shown as a modal, fullscreen, embedded view, etc.
>
> This setting is configured at the Flow level and applies only to how the Flow starts.
>
> ### Screen Transition Type
>
> The Transition Type defines how navigation occurs between Screens within the Flow.
>
> It controls the animation or visual behavior when moving from one Screen to the next (e.g., slide, fade, instant).
>
> You can configure a default Transition Type at the Flow level, and optionally override it for individual Transitions to customize specific paths in the user journey.
>
> <Image align="center" className="border" border={true} src="https://files.readme.io/5709953934e193f8100d1672d0dad747b394de8cfeaa430b8d02a369552c3751-image.png" />

<br />

## 2. Manually integrating the Flow inside of your app (Only on Android)

If you want to integrate the Flow manually into your app / parent view, you should check the attribute `displayMode` carried by the `PLYPresentation` returned by the pre-fetching

```kotlin Kotlin
Purchasely.fetchPresentation(placementId = "onboarding") { presentation, error ->
  error?.let {
    Toast.makeText(context, "Error fetching presentation", Toast.LENGTH_SHORT).show()
    return@fetchPresentation
  }

  presentation?.let {
    val fragment = it.getFragment(){ result, plan ->
      when(result) {
        PLYProductViewResult.PURCHASED -> Log.d("Purchasely", "User purchased ${plan?.name}")
        PLYProductViewResult.CANCELLED -> Log.d("Purchasely", "User cancelled purchased")
        PLYProductViewResult.RESTORED -> Log.d("Purchasely", "User restored ${plan?.name}")
      }
    }

    when(it.displayMode?.type) {
      PLYTransitionType.PUSH -> {
        // Handle push transition
        Log.d("Purchasely", "Display it as a push transition")
      }
      PLYTransitionType.FULLSCREEN -> {
        // Handle pop transition
        Log.d("Purchasely", "Display it as a fullscreen transition")
      }
      PLYTransitionType.MODAL -> {
        // Handle modal transition
        Log.d("Purchasely", "Display it as a modal transition")
      }
      PLYTransitionType.DRAWER -> {
        // Handle drawer transition
        val heightPercentage = it.displayMode?.heightPercentage
        Log.d("Purchasely", "Display it as a drawer transition with height percentage: $heightPercentage")
      }
      PLYTransitionType.POPIN -> {
        // Handle pop-in transition
        val heightPercentage = it.displayMode?.heightPercentage
        Log.d("Purchasely", "Display it as a pop-in transition with height percentage: $heightPercentage")
      }
      null -> {
        // Handle no transition
      }
    }
  } ?: run {
    Toast.makeText(context, "Presentation is null", Toast.LENGTH_SHORT).show()
    return@fetchPresentation
  }
}
```

<br />

## 3. Using the Flow deeplink

To use this method, you need to have implemented [Deeplink management](deeplinks-management)\
You can trigger the display of a Flow using its deeplink, the SDK will automatically display it.

You can also display the Flow yourself by implementing the [UIHandler](ui-handler-deeplinks)\
Quick example:

```swift Swift

extension myClass: PLYUIHandler {
    func display(presentation: PLYPresentation, from sourceController: UIViewController?, proceed: @escaping () -> ()) {
      presentation.display(from: nil)
    }
}
```
```kotlin Kotlin
Purchasely.uiHandler = object : PLYUIHandler {
  override fun onPresentation(presentation: PLYPresentation, proceed: () -> Unit) {
    // Display the flow
    presentation.display(context)
  }
}

```

In this case, the **Display mode** is automatically taken into consideration by the SDK if you call the method `display`.\
Otherwise, you need to retrieve the display mode from the presentation object to display it accordingly.\
Learn more in our dedicated section about the [UIHandler](ui-handler-deeplinks)

# Going further

Flows can be personalized based on user insights. 

📚 Follow the guides to learn more: 

* [Leveraging Quizzes to fetch user insights](user-insights)
* [Tailoring Flows to the user insights](tailoring-flows-to-user-insights)
