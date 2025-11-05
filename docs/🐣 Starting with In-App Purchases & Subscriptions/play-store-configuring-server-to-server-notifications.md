---
title: Play Store - configuring Server to Server notifications
excerpt: >-
  This page describes how to configure manually Server to Server notifications
  (known as Pub/Sub) with Google Cloud Console and Google Play Console
deprecated: false
hidden: false
metadata:
  title: Purchasely - Configure Server to Server notifications with Google
  description: >-
    To connect the Purchasely Cloud Platform with the App Store, ensure the
    correct service account and permissions are set, retrieve the endpoint URL
    from Purchasely, create a Pub/Sub topic and subscription in Google Cloud,
    add a publisher, and configure the Play Store to send test notifications.
  keywords:
    - pub
    - ' sub'
    - ' google'
    - ' s2s'
    - ' purchasely'
  robots: index
next:
  description: ''
---
# Connecting the Purchasely Cloud Platform with the App Store

If you get an error when you click on "Connect to Google" from Purchasely console, it means that you did not set the proper service account or the rights you provided for the service account are not sufficient for Purchasely to set up S2S automatically.

You can set it up yourself by following this procedure.

## Getting the endpoint URL from the Purchasely Console

1. Connect to the Purchasely Console
2. Access the settings of the application you want to connect
3. Get the value of the parameter `Google S 2 S Notifications Endpoint`  
   _Purchasely > Mobile Applications > \[YOUR APPLICATION] > Application settings_

![](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FGgUdOzhqa07uh7nB2iZA%2Fuploads%2FAayaLhsAm9GOOp2Fcb6L%2Fimage.png?alt=media&token=80e5051d-6a10-4050-8155-7d5d3b830628)

## Creating a new Pub/Sub Topic

1. Connect to the [Google Cloud Platform Console](https://cloud.google.com/pubsub)
2. Create new Pub/Sub topic  
   _Google Cloud Platform > PubSub > Topics > `+ Create new topic`_
3. Suggested name for the topic `Playstore-S2S-notifications`
4. Leave the encryption set on `Key managed by Google`

> 📘 Complex configuration
> 
> If you have multiple applications under the same Google Project, create one topic and one subscription per application.

## Creating a subscription on the topic

1. Access the topic you just created
2. Click on `+ Create a subscription`
3. Set the `Type of distribution` to `Push`
4. In the URL field, enter the value of the field Google Play S2S Notifications Endpoint retrieved from the Purchasely Console
5. Set `no expiration date`
6. Set the `confirmation delay` to `60 seconds`
7. Set `Messages conservation` to `7 days`

> 📘 Multiple endpoints
> 
> To receive S2S notifications on mutiple endpoints, you can create another subscription linked to the same topic.

## Adding a publisher to the topic

1. Add a new Pub/Sub Editor to the topic in the [Google Cloud Platform Console](https://cloud.google.com/pubsub)  
   _Google Cloud Platform > PubSub > Topics > \[Playstore-S2S-Notifications] > `+ Add principal`_
2. Copy & paste the following value `google-play-developer-notifications@system.gserviceaccount.com` in the `member` field
3. Set the `role` to `Pub/Sub Publisher`

## Play Store configuration

1. Connect to the [Google Play Console](https://play.google.com/apps/publish) and go to the following section  
   _Google Play Console > \[YOUR APPLICATION] > Monetization > Setup_
2. Type the full name of the topic. It shall have the shape `projects/[YOUR PROJECTS]/topics/Playstore-S2S-Notifications`
3. Click on the button Send test notification.  
   You can send several notifications at the same time
4. Click on **Save changes**
5. Check the good reception of the test notification at the `topic` level

   in the [Google Cloud Platform Console](https://cloud.google.com)  
   _Google Cloud Platform > Topics > Googleplay-S2S-Notifications_
6. Check the good reception of the test notification at the `subscription` level

   in the [Google Cloud Platform Console](https://cloud.google.com)  
   _Google Cloud Platform > Subscriptions > Purchasely-Subscriptions_