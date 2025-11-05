---
title: Leveraging Audiences
excerpt: >-
  This section describes how to leverage Audiences to display different Screens
  and find them in Purchasely Analytics
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Customizing the screen displayed for an audience for a specific placement

Audiences can be used to customize the screen displayed for a particular placement.

To do so:

1. Navigate to the section Placement of your Purchasely Console
2. Pick the desired placement
3. Click on the button **`+ Customize for an audience`**
4. Choose the desired audience and the associated paywall

   <Image align="center" className="border" border={true} src="https://files.readme.io/bf220a9-image.png" />
5. Then click on the **`Publish`** button in the bottom right corner

> ℹ️ Immediately after publishing, the modifications become visible to the end users of the app

When several audiences are associated with the same placement, you need to define the priority.

To do so:

1. Click on the **`⋮`** button on the right of the placement
2. Then on `Prioritize audiences`
3. Or simply use the handler **`⋮⋮`** on the left of each line to drag & drop each audience in the correct position

   <Image align="center" className="border" border={true} src="https://files.readme.io/651ac08-image.png" />

A user can belong to several audiences at the same time. The rule for choosing which screen shall be displayed for a user is the following:

<AudiencePrioritizationRuleForAPlacement />

# Fetching the `audience ID` in the [Purchasely Analytics](purchasely-analytics)

When a user interacts with a placement, an event (either a [UI/SDK event](ui-sdk-events) or a [Server event](server-events)) can be triggered.

*Eg:*

* *`PRESENTATION_VIEWED`(UI/SDK event) if a screen is displayed to the user*
* *`SUBSCRIPTION_STARTED`(Server event) if the user purchases a new subscription from this screen*

In both cases, if the user was matching an audience associated to the placement, the events will carry the parameter `audience_id`, filled in with the ID defined for that particular audience.

```json PRESENTATION_VIEW (UI/SDK event)
{
  "language" : "en",
  "sdk_version" : "2.0.0",
  "user_id" : "23DE2D20-7878-414C-B2EC-4B1E632995EB",
  "event_name" : "PRESENTATION_VIEWED",
  "audience_id" : "<YOUR_AUDIENCE_ID>",
  ...
}
```
```json SUBSCRIPTION_STARTED (server event)
{
  "plan": "<plan vendorID defined in the Purchasely console>",
  "store": "APPLE_APP_STORE",
  "user_id" : "23DE2D20-7878-414C-B2EC-4B1E632995EB",
  "event_name": "SUBSCRIPTION_STARTED",
  "displayed_presentation" : "YOUR_SCREEN_ID",
  "audience_id" : "<YOUR_AUDIENCE_ID>",
  ...
  
}
```

The Purchasely Platform will ensure that this parameter remains attached for subsequent server events in the subscription lifecycle.\
*Eg: if the property`audience_id` = `apple` has been attached to a `SUBSCRIPTION_STARTED` event, the same property will be attached to the `SUBSCRIPTION_RENEWED` events that might follow when the subscription is renewed.*
