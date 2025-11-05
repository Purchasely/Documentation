---
title: Using deeplinks to create automations
excerpt: This section explains how to create deeplink automations with Purchasely
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# General principle

Purchasely allows marketing and growth team to create no-code automations. A few examples of campaigns that can be created:

1. Welcoming new premium members with an email and engaging them with a product overview or tutorial
2. Converting long term freemium members with a particular promotion
3. Mitigating involuntary churn by inviting premium members in grace period to update their billing details
4. Retaining premium members about to churn with promotional offers
5. Winning-back lapsed subscribers with discounted offers

<br />

These automations can be created by combining together various features of the platform:

1. The [subscription events](subscription-events) and the [associated attributes](understanding-user-attributes), allowing to map every subscriber in their subscription lifecycle
2. [The native integrations with engagement and CRM platforms](engagement-crm), allowing to send real-time server events and user properties from Purchasely to these 3rd-party platforms and leverage Purchasely data into them
3. [The segmenting capabilities of the Purchasely Platform](segmenting-your-user-base), allowing to tailor the screen displayed to the audience to which a user belongs
4. The [deeplink capabilities of the SDK](deeplinks-management), allowing to automatically display a Placement or Screen from a deeplink

For [retention and win-back automations](retention-winback), [promotional offers](understanding-promotional-offers-developer-determined-offers) allowing to discount a price to existing or lapsed subscribers will also be used

<br />

# Configuring an automation

To make these automations work, the following steps must be achieved:

1. Configure the screens to be displayed and mapping the Call-To-Actions with [the desired offers or action types](action-types)
2. Configure the [audience matching the targeted users](understanding-audiences)
3. [Map the screen with the audience together with the desired placement](displaying-screens-placements)
4. Activate [the integration with the desired 3rd party engagement and CRM platform](engagement-crm) and definz which Server Events and User Properties must be forwarded to the 3rd party platform.
   1. [Subscription Events](subscription-events) are convenient to play the role of trigger  
      _E.g.: send a push notification when a user enters in Grace Period (Subscription Event `GRACE_PERIOD_STARTED` triggered)_
   2. User Properties are convenient to create cohorts of users  
      _E.g.: create a campaign for all users who are in Grace Period (User Property `subscription_status` = `IN_GRACE_PERIOD`_  
      => They are updated at the same time a Subscription Event is generate in the Subscription Lifecycle.
5. Create an engagement campaign in the 3rd-party platform and associating it with the [placement deeplink (created at step 3)](deeplink-automations#supported-deeplinks)

<br />

# Deeplinks implementation

Follow these [deeplinks implementation guidelines](deeplinks-management) to enable deeplinks management.

<br />

<DeeplinksSupportedDeeplinks />