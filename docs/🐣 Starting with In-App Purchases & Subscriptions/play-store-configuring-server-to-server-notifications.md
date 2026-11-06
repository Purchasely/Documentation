---
title: Play Store - configuring Server to Server notifications
excerpt: >-
  This page describes how to configure manually Server to Server notifications
  (known as Pub/Sub) with Google Cloud Console and Google Play Console
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Connecting the Purchasely Cloud Platform with Google Play

Use this procedure in these cases:

* **Connect to Google** in the Purchasely Console shows an error or does not show.
* You do not want to give the "Pub/Sub Admin" role to the Purchasely service account.

With this procedure, the Purchasely service account needs no Google Cloud role. You do the steps yourself in Google Cloud and in Google Play Console. Your Google Cloud user must have the right to create topics and to change their permissions. For example, the "Owner" or "Pub/Sub Admin" role on the project gives these rights.

## Getting the endpoint URL from the Purchasely Console

1. Connect to the Purchasely Console
2. Open the settings of the application you want to connect
3. In the Google Play section, copy the value of the field `Server to server endpoint`\
   _Purchasely > Mobile Applications > [YOUR APPLICATION] > Application settings_

<Image border={false} src="https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FGgUdOzhqa07uh7nB2iZA%2Fuploads%2FAayaLhsAm9GOOp2Fcb6L%2Fimage.png?alt=media&token=80e5051d-6a10-4050-8155-7d5d3b830628" />

## Creating a new Pub/Sub topic

1. Connect to the [Google Cloud console](https://console.cloud.google.com/cloudpubsub/topic/list) and select the project of your service account
2. Click `+ Create topic`\
   _Google Cloud > Pub/Sub > Topics > `+ Create topic`_
3. Set the Topic ID, for example `Play-Store-Notifications`
4. Clear `Add a default subscription`
5. Keep the encryption set to `Google-managed encryption key`
6. Click `Create`

> 📘 Several applications
>
> If you have several applications in the same Google Cloud project, create one topic and one subscription for each application. Give each topic and each subscription a different ID, for example with the application name. Use your IDs in the next steps.

## Creating a subscription on the topic

1. Open your topic
2. Click `+ Create subscription`
3. Set the Subscription ID, for example `Purchasely`
4. Set `Delivery type` to `Push`
5. In `Endpoint URL`, paste the `Server to server endpoint` that you copied from the Purchasely Console
6. Set `Expiration period` to `Never expire`
7. Set `Acknowledgement deadline` to `60` seconds
8. Set `Message retention duration` to `7` days
9. Click `Create`

> 📘 Several endpoints
>
> To also send the notifications to another endpoint, create another subscription on the same topic.

## Allowing Google Play to publish to the topic

Google Play sends the notifications to the topic with its own service account. Give this account the right to publish to the topic.

1. In the topic list, select the checkbox of your topic\
   _Google Cloud > Pub/Sub > Topics_
2. In the info panel, open `Permissions` and click `Add principal`. If you do not see the info panel, click `Show info panel`.
3. In `New principals`, paste `google-play-developer-notifications@system.gserviceaccount.com`
4. Set the role to `Pub/Sub Publisher`
5. Click `Save`

> 🚧 Domain restricted sharing
>
> Google Cloud can show this error:
>
> "One or more users named in the policy do not belong to a permitted customer"
>
> Then your organization uses the Domain restricted sharing policy (`iam.allowedPolicyMemberDomains`). Ask your Google Cloud administrator to [add an exception](https://cloud.google.com/resource-manager/docs/organization-policy/restricting-domains#configure-exceptions) for `google-play-developer-notifications@system.gserviceaccount.com`.

## Google Play Console configuration

1. Connect to the [Google Play Console](https://play.google.com/console) and open this section\
   _Google Play Console > [YOUR APPLICATION] > Monetize > Monetization setup_
2. In `Real-time developer notifications`, select `Enable real-time notifications`
3. In `Topic name`, type the full name of your topic: `projects/[YOUR PROJECT ID]/topics/[YOUR TOPIC ID]`
4. Click `Send Test Message`
5. Select `Get all notifications for subscriptions and one-time products`. With the other choice, Purchasely gets no notification for one-time product purchases.
6. Click `Save changes`
7. Make sure that the test message is in the subscription metrics\
   _Google Cloud > Pub/Sub > Subscriptions > [YOUR SUBSCRIPTION ID] > Metrics_
