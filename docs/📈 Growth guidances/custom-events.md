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

  Custom Events are available from version **6.2.0** of the Purchasely SDK on **iOS**, **Android**, **React Native**, **Flutter** and **Cordova**. An older SDK sends no Custom Event and ignores the campaigns and the Screen actions that use them.
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
3. Click **Add**.<br />

   <Image src="https://files.readme.io/e7fcf7633fc440a3f5985ca849a993ed8ff919e80509be6b10dc0d1f167bc58e-2-property-types.png" align="center" caption="The Properties tab, with the list of property types" border={true} />


The **Events** column shows the events that use each property. In this example, `category` is shared by `ARTICLE_READ` and `ARTICLE_SHARED`.<br />


<Image src="https://files.readme.io/1a76baf82d6321fe61a876731bfd33c3353b64189f382ee0b554373b5b4bd3ff-6-properties-tab.png" align="center" caption="The Properties tab: category is linked to two events" border={true} />


<Callout icon="🚧" theme="warn">
  ### A change to a property applies to every event

  A property is shared by all the events of the app. When you rename, retype or delete a property in the **Properties** tab, the change applies to every event that uses it.
</Callout>

# 2. Create the event

In **Targeting > Events**, click **New Custom Event**.

1. Type the **Name** of the event. Use the exact name that your app sends. The SDK compares names exactly, case and spaces included: `ARTICLE_READ` and `article_read` are two different events.
2. Optionally, click the color button to select the color of the event in the Console, and add **Tags** to sort your events.
3. In **Event properties**, select **Link an existing property...** to add a property that you declared before.
4. Click **Create**.<br />

   <Image src="https://files.readme.io/a8725d1904c613ab99907d9f034c1c77073b219be0198cbd5eac6a4423045dd8-4-link-property.png" align="center" caption="Link an existing property to the event" border={true} />



<Image src="https://files.readme.io/2a4f27429d1ab67b6fe68e94f3a82ae7d9296a7667dd440f8a4f892a63d7fe70-3-new-event.png" align="center" caption="The ARTICLE_READ event with three linked properties" border={true} />


You can also create a new property directly in the event dialog: type its name, select its type and click **Add**. The Console marks it **new**, and adds it to the **Properties** tab when you save the event. In this example, `ARTICLE_SHARED` reuses `category` and creates `share_channel`.


<Image src="https://files.readme.io/ded71327c760a104ffd2c2b0655d179380304a70a151dd177abde4570778d6d9-5-new-property-in-event.png" align="center" caption="ARTICLE_SHARED reuses category and creates share_channel" border={true} />


The **Events** tab shows one card for each event.


<Image src="https://files.readme.io/cce1054f1c60439c28d35188a3b7b027425502400a80c3ac93a2b23aa1426465-1-events-list.png" align="center" caption="The Events tab with the ARTICLE_READ and ARTICLE_SHARED cards" border={true} />


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
```typescript React Native
Purchasely.emit('ARTICLE_READ', {
  article_id: 42,
  category: 'sport',
  is_premium: true,
});
```
```dart Flutter
await Purchasely.emit('ARTICLE_READ', {
  'article_id': 42,
  'category': 'sport',
  'is_premium': true,
});
```
```javascript Cordova
Purchasely.emit('ARTICLE_READ', {
  article_id: 42,
  category: 'sport',
  is_premium: true
});
```

The native call returns immediately and never throws. You can call `emit` before `start()`.

On Cordova, you can give a `success` callback and an `error` callback as the third and fourth arguments. Both are optional.

## Properties

* The name and the property keys are sent as given: no case change and no trim.
* Supported types are numbers, booleans, strings, dates and lists of strings. On Android: `Int`, `Long`, `Float`, `Double`, `Boolean`, `String`, `Date` and a list of `String`.
* Dates are sent as ISO 8601 strings. On React Native, Flutter and Cordova, pass a date as an ISO 8601 string. On Flutter, a `DateTime` or any value that the platform channel cannot encode makes the call fail.
* On React Native, Flutter and Cordova, the bridge checks no property type. The backend casts each value to the type that you declare in the Console.
* On iOS and Android, the SDK drops a value that it cannot send, such as `NaN` or a custom object, and logs a warning. It sends the rest of the event normally. This does not apply to Flutter: see the previous bullets.

## What the event carries

Each event carries your [custom user attributes](custom-user-attributes) and the built-in attributes, as they were at the moment of the call.

## Consent

When the user refuses the `analytics` [data processing purpose](privacy-settings), the SDK sends no new Custom Events.

## Separate from the SDK events

Custom Events have their own queue and their own retries. They never reach your `PLYEventDelegate` (iOS), your `EventListener` (Android) or the event listener of your React Native, Flutter or Cordova app. The [UI/SDK events](ui-sdk-events-list) of Purchasely keep their content and their delivery.

<Callout icon="⚠️" theme="warn">
  ### Android: exhaustive `when` on `PLYEvent`

  `PLYEvent` has a new internal subclass for Custom Events. If your Kotlin code uses `when (event)` on `PLYEvent` without an `else` branch, add an `else` branch.
</Callout>

# 4. Trigger a campaign with the event

There are two ways to start:

* On the card of the event, in **Targeting > Events**, click **Map with a new campaign**. The Console opens a new campaign with the event already selected as the trigger.
* In a [campaign](campaign-configuration), turn on the **When** section and select the event in **Trigger**.

The **Trigger** list contains `APP_STARTED`, the SDK events that can be triggers, and your Custom Events. You can select more than one event: the campaign starts when one of them fires.


<Image src="https://files.readme.io/d9dc079c05662566b1079f7d6b4a2317faec5423a492ac3bc70b50e8428b5a8f-7-campaign-trigger-list.png" align="center" caption="The Trigger list of a campaign, with ARTICLE_READ selected" border={true} />


## Filter on the properties

Under **Filters**, click **Filter on properties** to start the campaign only when the properties of the event match. Each condition has a **Property**, an **Operation** and, for most operations, a value.

* Click **AND/OR** to add a condition to the group, then select **AND** or **OR** between the conditions.
* Click **Add condition group** to add a group of conditions.

In this example, the campaign starts when the user reads a premium article of the `sport` category:


<Image src="https://files.readme.io/bbd19683bb64386006aaeb03b1d40bd545778c56784b1fdcf493099dd2fde7e4-8-campaign-trigger-filters.png" align="center" caption="Filters: is_premium is true AND category equals to sport" border={true} />


The operations depend on the type of the property:

| Type     | Operations                                                                                                                     |
| :------- | :----------------------------------------------------------------------------------------------------------------------------- |
| `string` | equals to, is different from, contains, starts with, ends with, is one of                                                      |
| `int`    | equals to, is different from, is greater than, is greater than or equal to, is less than, is less than or equal to, is between |
| `bool`   | is true, is false, is true or not set, is false or not set                                                                     |

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


<Image src="https://files.readme.io/15200e381c4a1626c677a1fd91b8350522374da4d2dc5f4c6ebc91b9a54d543e-9-action-list.png" align="center" caption="The Track event action in the Action list" border={true} />


3. In **Custom event**, select the event.


<Image src="https://files.readme.io/878b5d1d7097049916182e5498a825a39268ed457e517a09336fd26cc088b5c6-10-select-custom-event.png" align="center" caption="Select the custom event of the Track event action" border={true} />


4. Optionally, select a **Second action**, for example **Close/Back**.


<Image src="https://files.readme.io/3326eb19ae01f4d5cfac0cb5a5abe0cb0d411a7c2259de0641d70092e8120a6a-11-track-event-action.png" align="center" caption="A Learn More button that sends ARTICLE_READ and then closes the Screen" border={true} />


<br />The event carries the context of the Screen: presentation, placement, audience, A/B test and variant, campaign, and flow and step. You do not set property values in the action.

* Your app cannot intercept this action.
* This action never blocks the actions next to it. A button that tracks an event and then purchases still closes the paywall after the purchase.
* An SDK older than 6.2 ignores this action and sends nothing.

# 6. Measure the event in an experiment

When you create an experiment, the **Primary KPI** step lists your Custom Events under **Custom Events**. Select one to make it the metric that determines the winner. In this example, the experiment measures the number of shared articles.


<Image src="https://files.readme.io/4e00921ad673124376d5ce62c03f6afdea71b686ff9a8766395f568fb9266ac6-12-experiment-kpi.png" align="center" caption="The Primary KPI step of an experiment, with ARTICLE_SHARED selected" border={true} />


<br />A **Local experiment** can also target your Custom Events in its **When** section, the same way as a campaign trigger. Refer to [Measuring experiment impact](measuring-experiment-impact) for more details.

<br />
