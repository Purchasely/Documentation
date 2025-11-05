---
title: Finding users in the Console
excerpt: >-
  This page describes how to lookup user and subscriptions in the Purchasely
  console
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
In Purchasely, once you've completed the SDK implementation and have successfully performed sandbox testing, you can proceed to the production phase. To effectively track sandbox or live subscriptions and users, Purchasely provides two lookup pages: the Subscription , One time purchases and the User. 

Here’s a breakdown of them

## Subscription Lookup

To provide a comprehensive list of both renewing and non-renewing subscriptions that have been purchased through your application. You can use this page to monitor and manage all the subscriptions, seeing their status, renewal dates, and other relevant details. 

<Image align="center" className="border" border={true} src="https://files.readme.io/60e0875-image.png" />

You can filter the list based on the country, platform, plans, offer types and etc. 

Even though the page looks self explanatory, there are some key points to remember while using:

1. **Created at**- Denotes the date the subscription was created in Purchasely database and it may not be always equal to the date of purchase. The date and time are based on your system time zone. The entire list is sorted based on the created at date. 
2. **Search tab**: You can search for a user with the userID, subscription ID, if not the store transaction ID(Apple and Google). 

## One time purchases lookup

To provide a comprehensive list of both consumables and non consumables or lifetime purchases that have been purchased through your application. This page looks same as the subscription lookup we discussed above. 

<Image align="center" className="border" border={true} src="https://files.readme.io/484b604-image.png" />

## User Lookup

To offer a detailed view of the entire subscription evolution of an individual user. This page allows you to track a user’s subscription history, includes all the changes or updates to their subscription status. 

You can search user with their user ID or anonymous ID. Purchasely doesn't contain or store their store ID. 

> 🚧 Warning:
>
> An anonymous user who creates an account later, they cannot be found with their anonymous ID ever again in this page.

<Image align="center" className="border" border={true} src="https://files.readme.io/85d8f02-image.png" />

<br />

> 📘 Note
>
> This page can provide you the history of subscribers or OTP purchased users only. You can not search for the users who had just seen the paywall.

 The user history page contains many useful information to know about the user subscription lifecycle. Let us say, this page contains three sections. 

1. Section 1 consists of the Main properties of the user such as their store name, pruchased date, the [subscription current status](https://start.purchasely.com/docs/user-attributes-list#built-in-active-subscription-attributes), the subscription ID, transaction ID sent from the stores and etc.
2. Section 2 consists of the history of the user subscription
3. Section 3 links to another page, which shows all the historique and the present Webhook events triggered for this specific user. 

   <Image align="center" className="border" border={true} src="https://files.readme.io/96b071d-image.png" />
