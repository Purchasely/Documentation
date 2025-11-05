---
title: UI / SDK Events
excerpt: This section provides an overlook on UI / SDK Events
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: View the full list of UI / SDK Events
  pages:
    - type: basic
      slug: ui-sdk-events-list
      title: List of UI/SDK events
---
# What are UI / SDK Events?

<UISDKEventsDefinition />

[The full list of UI / SDK Events is available here](ui-sdk-events-list)

# What are they used for?

UI / SDK Events are useful to:

* determine which Screens users are exposed to
* understand how they navigate throughout the app and the different touch-points and Placements
* understand how users interact with the Screens and Paywalls

They are sent to the Purchasely Platform to compute [Paywall Conversion Rates](dashboard-conversion).

<br />

# How to leverage them by implementing an Event delegate inside the app?

<UISDKEventsEventDelegatedEventListener />

<br />

# What data is associated with UI / SDK Events

UI / SDK Events consist of JSON payloads. They all share a common structure and have a comprehensive set of attributes

[More details on UI / SDK Events Attributes](ui-sdk-events-attributes)
