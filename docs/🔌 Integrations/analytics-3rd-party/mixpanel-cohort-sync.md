---
title: Mixpanel Cohort Sync
excerpt: >-
  Sync your Mixpanel cohorts to Purchasely Custom Audiences with a Mixpanel
  webhook.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
> 🚧 Pre-requisites
>
> This integration requires the **Custom Audiences** feature on your Purchasely account. Without this feature, the webhook answers `403`. To enable the feature, contact us.
>
> **The Mixpanel SDK and the Purchasely SDK must identify users with the same user ID.**

<br />

# General overview

Mixpanel Cohort Sync sends the members of a Mixpanel cohort to a webhook. Purchasely receives these calls and keeps a [Custom Audience](https://docs.purchasely.com/docs/custom-audiences-api) in sync with the cohort.

Purchasely creates one Custom Audience for each synced cohort. You can then use this Custom Audience in Placements, Campaigns, Flows and A/B tests.

# Integrating Mixpanel Cohort Sync with Purchasely

## 1 - Identifying users with the same user ID

Purchasely matches each cohort member with a Purchasely user through the user ID.

Send the same user ID to `mixpanel.identify()` and to `Purchasely.userLogin()`.

```swift
let userId = "user_123"
Mixpanel.mainInstance().identify(distinctId: userId)
Purchasely.userLogin(with: userId)
```

> 🚧 Anonymous users
>
> Purchasely does not sync anonymous users. A cohort member without a user ID does not go to the Custom Audience.

## 2 - Getting the webhook URL and the API key

The webhook URL of your app is:

```
https://api.purchasely.io/client/mobile_applications/<app_public_id>/custom_audiences/webhook/mixpanel
```

The Purchasely Console shows this URL in **Settings > API keys**.

The webhook uses Basic authentication:

| Field | Value |
| :-- | :-- |
| Username | Any value. Purchasely does not read it. |
| Password | A Client API key of the app. |

## 3 - Adding the webhook destination in Mixpanel

1. In Mixpanel, go to **Data > Destinations**, then open the **Destination Library**.

![](https://files.readme.io/07172f5fb3b51894f83caa132d18cc8e779eb8caf0611239274872f59ed3f3f1-1-destination-library.png)

2. In **Category**, select **Webhooks**, then select **Custom Webhook**.

![](https://files.readme.io/a0093cb7fdb7595a229ae1e3736b98025983935935c17735d9b0a079781f88e0-2-webhooks-category.png)

<br />

3. Fill in the **Connect to Custom Webhook** form:
   - **Connector Name**: a name of your choice, for example `Purchasely`.
   - **URL**: the webhook URL of step 2.
   - **Properties To Export**: leave empty. Purchasely does not read them.
   - **Username**: any value.
   - **Password**: your Client API key.
4. Click **Continue**.

![](https://files.readme.io/4e37118124b5370be027b8399ed7842b953b3b7cbc946cf2dc97964e7b6a1374-3-connect-custom-webhook.png)

The **Configuration** tab of the destination shows the status **Connected**.

![](https://files.readme.io/396e2a86f997dd7ffaac639763856c650120204344a5a0d03a53a3bdd9d851ad-4-destination-configuration.png)

## 4 - Syncing a cohort

1. Open the **Custom Webhook** destination, then open the **Syncs** tab.
2. Click **Add Cohort Sync** and select the cohort.
3. Select a recurring sync.

The **Syncs** tab shows each cohort sync, the number of exported user profiles and the status.

![](https://files.readme.io/8c064fcbdcfd20c4fc401d578a076f2545c6fa0dbd16a2e60dfe3ce7e28e46f9-5-cohort-syncs.png)

Add one recurring sync for each cohort. Each cohort gives one Custom Audience in Purchasely.

> 📘 Sync from Lexicon
>
> You can also start a sync from **Lexicon > Cohorts**. Open the menu of the cohort, select **Export to...**, then select your Custom Webhook connection.

# Data freshness

Mixpanel syncs a cohort every 30 minutes. Purchasely caches audience membership for 15 minutes.

A change in a cohort can therefore take about 45 minutes to reach your users in the worst case. Processing time in Purchasely adds to this delay.

# Limits

| Limit | Value |
| :-- | :-- |
| Recurring syncs per Mixpanel project | 60, for all destinations |
| Users per cohort | 10 million |
| Group cohorts (Group Analytics) | Not supported |
| Anonymous users | Not synced |

These limits come from Mixpanel, except for anonymous users. For more information, see the [Mixpanel Cohort Sync documentation](https://docs.mixpanel.com/docs/cohort-sync/overview).

# Troubleshooting

## The webhook answers 403

The Custom Audiences feature is not enabled on your account. Contact us to enable it.

## The Custom Audience was archived

When you archive the Custom Audience of a cohort, the sync stops. To restore the sync:

1. Create a Custom Audience again with the same `vendor_id` as the archived audience.
2. In Mixpanel, disconnect the webhook sync of the cohort.
3. Connect the webhook sync of the cohort again.

Mixpanel then sends the full cohort again.