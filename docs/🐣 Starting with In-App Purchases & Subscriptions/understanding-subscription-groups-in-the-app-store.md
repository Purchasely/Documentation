---
title: App Store - Understanding subscription groups
excerpt: This section contains useful details on subscription groups
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages:
    - type: link
      title: App Store resources on subscriptions groups
      url: https://developer.apple.com/app-store/subscriptions/
---
# Purpose of subscription groups

In the App Store Connect console, each subscription is assigned to a subscription group.

A subscription group is a group of subscriptions with different access levels (e.g.: silver, gold, platinium), prices and durations (e.g.: weekly, monthly, yearly) that users can choose from.

<Image align="center" className="border" border={true} src="https://files.readme.io/4fe4c25-image.png" />

### Functioning of subscription groups

When dealing with subscription groups, there are 3 important rules to have in mind.

> 📘 Rule #1: One user can only have one active subscription per group
>
> When several subscriptions are assigned to the same subscription group, it means that the users can only have one of them active at any given time. 
>
> *E.g.: a user can only have one active subscription among:`PLATINIUM A - YEARLY`, `PLATINIUM A - MONTHLY`, `GOLD A - YEARLY`, `GOLD A - MONTHLY`, `SILVER A - YEARLY` and `SILVER A - MONTHLY` because they are all assigned to the same subscription group`SUBSCRIPTION GROUP A`*

> 📘 Rule #2: The original subscription is automatically terminated when a new subscription from the same group begins
>
> When a user already has an active subscription and purchases another one within the same group, **the App Store will automatically terminate the original subscription at the same time the new one is activated**.
>
> *E.g.: a user already has the`GOLD A - MONTHLY` as an active subscription and purchases either the `GOLD A - YEARLY` or `PLATINIUM A - MONTHLY` => the `GOLD A - MONTHLY` is automatically cancelled to avoid a double invoicing for the user*
>
> Refer to the paragraph **Upgrade, downgrade and crossgrade policies** below in this page to know more about the precise rules applied.

> 📘 Rule #3: Only one Introductory price per subscription group
>
> **A user can only benefit from ONE introductory price** (free trial or discounted price) for any subscription **from the same subscription group**.
>
> *E.g.: a user has already benefited from a 1 week free trial when they purchased their`GOLD A - MONTHLY` subscription.\
> If they now purchase the `PLATINIUM A - MONTHLY`, they won't get the 1 week free trial, even if it is proposed, as the App Store considers that the user already had the opportunity to try the product. They will therefore start paying immediately*

### Limitations and risks

> 🚧 You can't change things afterwards
>
> * Once a subscription has been assigned to a subscription group, it cannot be changed afterwards or migrated. Even if you ask Apple directly :)
> * It is not possible to migrate a user from one subscription to another (within the same subscription group or a different one).
>
> \=> All this to stay: think twice when creating your subscription groups and assigning subscriptions to them, because if you don't configure them properly and have some users purchase them, you might end up with a very complex set-up, that will remain with you until the end.

> ❗️ Risk for users of having 2 subscriptions invoiced in parallel if they belong to 2 different groups
>
> **A user can simultaneously have several active subscriptions that belong to different subscription groups**
>
> *E.g.: a user already has the`GOLD A - MONTHLY` as an active subscription and purchases either the `GOLD B - MONTHLY` or `SILVER B - YEARLY` => the `GOLD A - MONTHLY` will remain active, which means that the user will be invoiced for the 2 different subscriptions in parallel.*
>
> This means that **you should be cautious when displaying paywalls in your app to users who already have an active subscription**. If the paywalls propose subscriptions that belong to a different subscription group than the one already active for the user, they will be able to purchase it without having their original subscription terminated, which means that **they will be invoiced two times in parallel for the 2 subscriptions**.

### Upgrade, downgrade and crossgrade policies

The order in which subscriptions are ranked within the subscription group determines the policy applied by the App Store for the start of the new subscription and the termination of the original one.

<Image align="center" className="border" border={true} src="https://files.readme.io/5f7c5c0-image.png" />

There are 3 possibilities:

1. **upgrade**: a user purchases a subscription that offers a higher level of service than their current subscription. They’re immediately upgraded and receive a refund of the prorated amount of their original subscription. If you’d like people to immediately access more content or features, rank the subscription higher to make it an upgrade
2. **Downgrade**: a user selects a subscription that offers a lower level of service than their current subscription. The subscription continues until the next renewal date, then is renewed at the lower level and price.
3. **Crossgrade**: a user switches to a new subscription of the equivalent level. If the subscriptions are the same duration, the new subscription begins immediately. If the durations are different, the new subscription goes into effect at the next renewal date. One the picture above, the subscription called `Quarterly` and `3 months` are grouped together and have the same rank (3).

# Mapping your subscription groups in Purchasely

In the Purchasely Console, the equivalent of a Subscription Group is called a <Glossary>Product</Glossary>. Because subscription groups do not have an equivalent in the Google Play Store, <Glossary>Product</Glossary>s allow to replicate the App Store behaviors (regarding plans concurrency and migration policies) in the Play Store.

What you should do, is map your <Glossary>Product</Glossary> in the Purchasely Console exactly the same way as your subscription groups (grouping plans associated to a same Subscription group together in the same Product).

If the mapping is different between the Products and the App Store subscription groups:

1. The App Store behavior will be based on the subscription groups mapping
2. The Play Store behavior will be based on the Purchasely Products mapping

In other words, behaviors and migration policies might differ from one store to the other.

# Subscription groups and price testing

### Testing different regular prices

When testing different prices, several subscriptions (one per price to be tested) need to be created and the way they are attached to subscription groups must be carefully considered.

Indeed, once a user has an active subscription, they can access all other subscriptions available within the same subscription group, directly from their device settings.

From there, they can switch from one subscription to another and it is not possible to prevent them from doing so.

For this reason, testing different prices for the same subscription requires in most cases to isolate them into different subscription groups, to avoid users paying the heavy price to switch to the lower price.

What you want to avoid is this:

<Image alt="Typical example of a flawed subscription group setup" align="center" width="50% " border={true} src="https://files.readme.io/7ab0da6-image.png">
  Typical example of a flawed subscription group setup
</Image>

In the picture above, users paying $76.99 will first feel they've been fooled, which creates brand mistrust, and will also be able to switch to the lower price which will create a direct loss of revenue for you.

The best practice to avoid that is to replicate your hierarchy of subscriptions and different subscription groups.

<Image align="center" className="border" border={true} src="https://files.readme.io/b6923ec-image.png" />

Once again, when doing that, beware of the risk of double invoicing!

### Testing different introductory prices

The regular price is the only one displayed in the device settings. The Introductory price is not displayed.

This means that if you just want to test 2 different Introductory offers (e.g.: 1 week free trial VS a 50% discount for 2 weeks), you will need to create 2 different subscriptions with the same regular price (but within the same group), as each subscription can only have 1 introductory price active at any given moment. 

In this case, having them in the same group is not an issue because the regular price (which is the one displayed) of the subscription will be the same and in any case users can only benefit from 1 introductory offer per group.
