---
title: Custom Events
excerpt: >-
  Declare your own business events in the Console, send them from your app or
  from a Screen, trigger campaigns with them and measure them as KPIs.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: campaign-configuration
      title: Campaign configuration
---

<Callout icon="📘" theme="info">
  ### Availability

  Custom Events are available from version **6.2.0** of the Purchasely SDK on **iOS** and **Android**. An older SDK sends no Custom Event and ignores the campaigns and the Screen actions that use them.
</Callout>

A Custom Event is a business event of your app, for example `ARTICLE_READ`, `ARTICLE_SHARED` or `CHECKOUT_STARTED`. With Custom Events, you can:

* **Trigger a campaign** when the event fires, and filter on the properties of the event.
* **Send the event from a Screen** with the **Track event** action, without app code.
* **Measure the event** as the primary KPI of an experiment.

This page uses one example from start to end: a news app sends `ARTICLE_READ` when the user reads an article, and `ARTICLE_SHARED` when the user shares it.

# 1. Declare the event properties

A property is a value that an event sends, for example the id of the article. You declare a property **once for the app**. Then you link it to each event that sends it. Two events can use the same property.

Open **Targeting > Events** in the [Purchasely Console](https://console.purchasely.io) and select the **Properties** tab.

1. Type the name of the property.
2. Select its type: `string`, `int`, `float`, `bool`, `date` or `array of strings`.
3. Click **Add**.

<!-- TODO(screenshot): upload tmp/custom-events/2-property-types.png to ReadMe, then replace this comment with:
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="The Properties tab, with the list of property types" />
-->

The **Events** column shows the events that use each property. In this example, `category` is shared by `ARTICLE_READ` and `ARTICLE_SHARED`.

<!-- TODO(screenshot): upload tmp/custom-events/6-properties-tab.png to ReadMe, then replace this comment with:
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="The Properties tab: category is linked to two events" />
-->

<Callout icon="🚧" theme="warn">
  ### A change to a property applies to every event

  A property is shared by all the events of the app. When you rename, retype or delete a property in the **Properties** tab, the change applies to every event that uses it.
</Callout>

# 2. Create the event

In **Targeting > Events**, click **New Custom Event**.

1. Type the **Name** of the event. Use the exact name that your app sends. The SDK compares names exactly, case and spaces included: `ARTICLE_READ` and `article_read` are two different events.
2. Optionally, click the color button to select the color of the event in the Console, and add **Tags** to sort your events.
3. In **Event properties**, select **Link an existing property...** to add a property that you declared before.
4. Click **Create**.

<!-- TODO(screenshot): upload tmp/custom-events/4-link-property.png to ReadMe, then replace this comment with:
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="Link an existing property to the event" />
-->

<!-- TODO(screenshot): upload tmp/custom-events/3-new-event.png to ReadMe, then replace this comment with:
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="The ARTICLE_READ event with three linked properties" />
-->

You can also create a new property directly in the event dialog: type its name, select its type and click **Add**. The Console marks it **new**, and adds it to the **Properties** tab when you save the event. In this example, `ARTICLE_SHARED` reuses `category` and creates `share_channel`.

<!-- TODO(screenshot): upload tmp/custom-events/5-new-property-in-event.png to ReadMe, then replace this comment with:
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="ARTICLE_SHARED reuses category and creates share_channel" />
-->

The **Events** tab shows one card for each event.

<!-- TODO(screenshot): upload tmp/custom-events/1-events-list.png to ReadMe, then replace this comment with:
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="The Events tab with the ARTICLE_READ and ARTICLE_SHARED cards" />
-->

<Callout icon="🚧" theme="warn">
  ### Only declared events are sent

  The SDK sends only the event names that are declared in the Console. It ignores an event that is not declared, without an error. A typo in the name in your app code makes the event silent.
</Callout>

# 3. Send the event from your app

Call `emit` when the action occurs in your app. Send the properties that you declared for the event:

```swift Swift
Purchasely.emit(name: "ARTICLE_READ", properties: [
    "article_id": 42,
    "category": "sport",
    "is_premium": true
])
```
```objectivec Objective-C
[Purchasely emitWithName:@"ARTICLE_READ"
              properties:@{@"article_id": @42, @"category": @"sport", @"is_premium": @YES}];
```
```kotlin Kotlin
Purchasely.emit("ARTICLE_READ", mapOf(
    "article_id" to 42,
    "category" to "sport",
    "is_premium" to true
))
```
```java Java
Map<String, Object> properties = new HashMap<>();
properties.put("article_id", 42);
properties.put("category", "sport");
properties.put("is_premium", true);
Purchasely.emit("ARTICLE_READ", properties);
```

The call returns immediately and never throws. You can call `emit` before `start()`.

## Properties

* The name and the property keys are sent as given: no case change and no trim.
* Supported types are numbers, booleans, strings, dates and lists of strings. On Android: `Int`, `Long`, `Float`, `Double`, `Boolean`, `String`, `Date` and a list of `String`.
* Dates are sent as ISO 8601 strings.
* The SDK drops a value that it cannot send, such as `NaN` or a custom object, and logs a warning. It sends the rest of the event normally.

## What the event carries

Each event carries your [custom user attributes](custom-user-attributes) and the built-in attributes, as they were at the moment of the call.

## Consent

When the user refuses the `analytics` [data processing purpose](privacy-settings), the SDK sends no new Custom Events.

## Separate from the SDK events

Custom Events have their own queue and their own retries. They never reach your `PLYEventDelegate` (iOS) or your `EventListener` (Android). The [UI/SDK events](ui-sdk-events-list) of Purchasely keep their content and their delivery.

<Callout icon="⚠️" theme="warn">
  ### Android: exhaustive `when` on `PLYEvent`

  `PLYEvent` has a new internal subclass for Custom Events. If your Kotlin code uses `when (event)` on `PLYEvent` without an `else` branch, add an `else` branch.
</Callout>

# 4. Trigger a campaign with the event

There are two ways to start:

* On the card of the event, in **Targeting > Events**, click **Map with a new campaign**. The Console opens a new campaign with the event already selected as the trigger.
* In a [campaign](campaign-configuration), turn on the **When** section and select the event in **Trigger**.

The **Trigger** list contains `APP_STARTED`, the SDK events that can be triggers, and your Custom Events. You can select more than one event: the campaign starts when one of them fires.

<!-- TODO(screenshot): upload tmp/custom-events/7-campaign-trigger-list.png to ReadMe, then replace this comment with:
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="The Trigger list of a campaign, with ARTICLE_READ selected" />
-->

## Filter on the properties

Under **Filters**, click **Filter on properties** to start the campaign only when the properties of the event match. Each condition has a **Property**, an **Operation** and, for most operations, a value.

* Click **AND/OR** to add a condition to the group, then select **AND** or **OR** between the conditions.
* Click **Add condition group** to add a group of conditions.

In this example, the campaign starts when the user reads a premium article of the `sport` category:

<!-- TODO(screenshot): upload tmp/custom-events/8-campaign-trigger-filters.png to ReadMe, then replace this comment with:
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="Filters: is_premium is true AND category equals to sport" />
-->

The operations depend on the type of the property:

| Type     | Operations                                                                                                                                |
| :------- | :---------------------------------------------------------------------------------------------------------------------------------------- |
| `string` | equals to, is different from, contains, starts with, ends with, is one of                                                                 |
| `int`    | equals to, is different from, is greater than, is greater than or equal to, is less than, is less than or equal to, is between          |
| `bool`   | is true, is false, is true or not set, is false or not set                                                                                |

## Rules of the trigger

The same rules as for an `APP_STARTED` trigger apply:

* The start and end dates of the campaign
* The frequency cap, the impression cap and the exposure window
* The `campaigns` data processing purpose
* [`allowCampaigns`](campaigns-implementation): when it is `false`, the SDK keeps the campaign until your app sets it to `true` again

A Custom Event never opens the campaigns of a Purchasely event that has the same name.

# 5. Send the event from a Screen

The **Track event** [action](action-types#track-event) of the Screen Composer sends one of your Custom Events when the user taps a component. You do not need app code for this action.

1. In the Screen Composer, select the component, for example a button.
2. In **On tap > Action**, select **Track event**.

<!-- TODO(screenshot): upload tmp/custom-events/9-action-list.png to ReadMe, then replace this comment with:
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="The Track event action in the Action list" />
-->

3. In **Custom event**, select the event.

<!-- TODO(screenshot): upload tmp/custom-events/10-select-custom-event.png to ReadMe, then replace this comment with:
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="Select the custom event of the Track event action" />
-->

4. Optionally, select a **Second action**, for example **Close/Back**.

<!-- TODO(screenshot): upload tmp/custom-events/11-track-event-action.png to ReadMe, then replace this comment with:
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="A Learn More button that sends ARTICLE_READ and then closes the Screen" />
-->

The event carries the context of the Screen: presentation, placement, audience, A/B test and variant, campaign, and flow and step. You do not set property values in the action.

* Your app cannot intercept this action.
* This action never blocks the actions next to it. A button that tracks an event and then purchases still closes the paywall after the purchase.
* An SDK older than 6.2 ignores this action and sends nothing.

# 6. Measure the event in an experiment

When you create an experiment, the **Primary KPI** step lists your Custom Events under **Custom Events**. Select one to make it the metric that determines the winner. In this example, the experiment measures the number of shared articles.

<!-- TODO(screenshot): upload tmp/custom-events/12-experiment-kpi.png to ReadMe, then replace this comment with:
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="The Primary KPI step of an experiment, with ARTICLE_SHARED selected" />
-->

A **Local experiment** can also target your Custom Events in its **When** section, the same way as a campaign trigger. Refer to [Measuring experiment impact](measuring-experiment-impact) for more details.

# Built-in attributes

The SDK sends these built-in attributes with the events of the user:

| Attribute                        | Platform      | Content                                                 |
| :------------------------------- | :------------ | :------------------------------------------------------ |
| `ply_custom_events_tracked`      | iOS           | The number of events sent, for each event name          |
| `ply_custom_events_last_tracked` | iOS           | The time of the last event sent, for each event name    |
| `ply_active_subscriptions`       | iOS, Android  | The list of the active subscriptions of the user        |
| `ply_expired_subscriptions`      | iOS, Android  | The list of the expired subscriptions of the user       |
