---
title: App Store - Configuring In-App Subscriptions
excerpt: >-
  This section provides details on how to configure In-App Subscriptions in the
  App Store with the App Store Connect Console
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
To create an in-app subscription for the first time, you need to create a <Glossary>subscription group</Glossary> 

**Subscription groups** are a way to organize your products in App Store Connect. If you already have a subscription group and wish to create a plan within it, you can skip this step.

> 🚧 Important information to read if you're building in-app subscription into your app for the first time
>
> Understanding how subscription groups work is key to manage your upgrade, downgrade and crossgrade policies and to avoid users to pay for 2 active subscriptions at the same time. And unfortunately, they cannot be changed if the initial setup is not done properly.
>
> We strongly invite you to read the following article: [Understanding Subscription Groups](understanding-subscription-groups-in-the-app-store) before starting to configure your subscriptions in the App Store.

## Creating Subscription Group

Go to[ App Store Connect'](https://appstoreconnect.apple.com/login)s '**Apps**' page 

<Image align="center" className="border" border={true} src="https://files.readme.io/0b4cbc8-image.png" />

and select the **name** of your app from the list.

<Image align="center" className="border" border={true} src="https://files.readme.io/a30f4bf-image.png" />

In the sidebar, select '**Subscriptions**' under **Monetization**,

<Image align="center" className="border" border={true} src="https://files.readme.io/16f5242-image.png" />

 then click the '+' symbol to create a Subscription Group.

<Image align="center" className="border" border={true} src="https://files.readme.io/bb563eb-image.png" />

When you have prompted to provide a **Reference Name** you can set any String as this is not user-facing.

<Image align="center" className="border" border={true} src="https://files.readme.io/921e64d-image.png" />

<br />

### Adding Localization

Before you can submit your in-app purchase for review, you must add at least one localization to your subscription group.

The next piece to set up is localization information for the App Store. This is the name and description of the in-app purchase that the user will see.

In the App Store Localization section just below the Subscriptions section in the Susbcription group page.  

Click the create button next to Localization and choose the language you with to set up.

<Image align="center" className="border" border={true} src="https://files.readme.io/d00d213-image.png" />

Next, you'll need to provide: 

* `Localization`: You can use different subscription group display names and app name display options for each localization. Users will see these names when they manage subscriptions on their devices.
* `Subscription Display Name`: This is the subscription group display name as it will appear to users for this localization.
* `Description`: This is your app name as it will appear when shown with this subscription group to users.

![](https://files.readme.io/507fecc-image.png)

## Creating a Subscription

To create a subscription plan, click on the subscription group you have created or the one of your choice,\
and click on the create button to create you subscription.

<Image align="center" className="border" border={true} src="https://files.readme.io/56c0498-image.png" />

Next, you fill the a Reference Name and a Product ID.

<Image align="center" className="border" border={true} src="https://files.readme.io/949eeb8-image.png" />

* `Reference Name`: The reference name will be used on **App Store Connect** and in **Sales and Trends reports**. It won’t be displayed on the App Store. The name can’t be longer than 64 characters.
* `Product ID`: A unique **alphanumeric ID** that is used for reporting. Only alphanumeric characters, periods, and underscores are allowed. After you use a `Product ID` for one product, it can’t be used again, even if the product is deleted. We recommend you to use consistent nomenclature across all your plans for your easy of use. This `Product ID` will have to be mapped with the corresponding <Glossary>Plan</Glossary> in the Purchasely Console.

<br />

### Setting Subscription Duration

Once your product is created, you'll be able to set the duration of the auto-renewable subscription. Use the duration dropdown to choose an option, and click Save.

<Image align="center" className="border" border={true} src="https://files.readme.io/cd6ae01-image.png" />

<br />

### Setting Subscription Price

<AppStoreConfiguringTheRegularPrice />

<Image align="center" className="border" border={true} src="https://files.readme.io/92683f8-image.png" />

### Adding Localization

The next step is to set up localization information of the plan created above.  This is the name and description of the in-app purchase that the user will see.

In the App Store Information section, click the Add localization button. 

<Image align="center" className="border" border={true} src="https://files.readme.io/fd1baba-image.png" />

<br />

Choose the language, display name and add a description and click add once done. 

The Subscription Display Name and Description will be visible to the user on the App Store and in their subscription management settings. 

<Image align="center" className="border" border={true} src="https://files.readme.io/3f4f538-image.png" />

<br />

### Add Reviewer Information

The last part of setting up an In-app subscription in iOS is adding information for the reviewer. This is a Screenshot, and optional Review Notes. You'll be unable to submit your product for review without it.

Screenshot: A required image of your in-app purchase paywall for the reviewer. While testing, it's okay to upload an empty 640 x 920 image here of whatever you want. Before submitting for review, you should add a picture of your paywall.\
Review Notes: An optional text area to clarify anything about your in-app purchase for the reviewer.

<Image align="center" className="border" border={true} src="https://files.readme.io/79537d3-image.png" />

<br />

<br />

## Adding Introductory Offers and Free Trials

To add an introductory offer or free trial to your product, from the same Subscription prices section, click on the View all subscription pricing

<Image align="center" className="border" border={true} src="https://files.readme.io/b878dbe-image.png" />

In the Introductory Offers tab 

on the same page you just configured pricing. Click the Set up Introductory Offers button. 

<Image align="center" className="border" border={true} src="https://files.readme.io/b5e6ffa-image.png" />

You'll be presented with a modal with a following configuration screens:

Countries or Regions for Introductory Offer: Use this if you want the introductory offer or trial to be region specific. Most of the time the answer here is "no", so go ahead and click Next.

<Image align="center" className="border" border={true} src="https://files.readme.io/12ca933-image.png" />

<br />

Introductory Offer Start/End Date: Set the start and end dates if you want the introductory offer or trial to be a limited time deal. In most cases, you'll be setting the Start Date to today and No End Date, then click Next.

<Image align="center" className="border" border={true} src="https://files.readme.io/94ab59c-image.png" />

<br />

On the last screen, you'll get to choose the type of Introductory Offer. 

1. Free is the free trial, 
2. Pay as you go - the subscriber will pay for the plan periodically
3. Pay upfront - the subscriber will pay for the entire period of promotion and then revert to the default pricing.

We'll set up free trial in this demo. Please notes, you can have only one introductory offer active for a subscription.  

<Image align="center" className="border" border={true} src="https://files.readme.io/983c71d-image.png" />

Select the Free radio button and choose the desired Duration from the dropdown.

<Image align="center" className="border" border={true} src="https://files.readme.io/3b4ed33-image.png" />

You will be presented the summary of the offer for different regions, check and confirm

<Image align="center" className="border" border={true} src="https://files.readme.io/355787c-image.png" />

<br />

You can read more about the different Introductory Offer strategies [here](https://dash.readme.com/project/purchasely/v4.4.0/docs/introductory-offer).

## Grace period:

A billing grace period lets subscribers retain access to your app's paid content even after their subscription expires due to a billing issue. If Apple successfully recovers the subscription during this grace period, you will not experience any interruption in your revenue. This step is optional.

You can choose the grace period in Apple App Store connect: 

<Image align="center" className="border" border={true} src="https://files.readme.io/d058d02-image.png" />

You can set the grace period duration, eligible subscribers and environments. 

<Image align="center" className="border" border={true} src="https://files.readme.io/319d767-image.png" />

> 📘 Avoid freeloaders
>
> To avoid free trial users who never paid for your subscription to enjoy freely the benefits of your premium membership, we advise you to choose the option **Only Paid-to-Paid**

Once you are good with your set up you can confirm it. You can turn off this grace period any time you want.
