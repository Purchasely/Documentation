---
title: App Store - Configuring Non-Renewing Subscriptions
excerpt: >-
  This section provides details on how to configure Non-Renewing Subscriptions
  in the App Store with the App Store Connect Console
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The Non-Renewing Subscriptions allows users to access content for a limited duration of time. This type of Subscription does not renew automatically. 

> 🚧 Your first non-renewing subscription must be submitted with a new app version.

## Creating Non-Renewing Subscriptions

Go to [App Store Connect](https://appstoreconnect.apple.com/login)'s '**Apps**' page 

<Image align="center" className="border" border={true} src="https://files.readme.io/0b4cbc8-image.png" />

and select the **Name** of your app from the list.

<Image align="center" className="border" border={true} src="https://files.readme.io/a30f4bf-image.png" />

In the sidebar, select '**Subscriptions**' under **Monetization**,

![](https://files.readme.io/abde655-image.png)

Click on **Manage** under the Non-Renewing Subscriptions:

<Image align="center" className="border" border={true} src="https://files.readme.io/c86b70f-image.png" />

Click on the "**+**" button to create your Non-Renewing Subscriptions:

<Image align="center" className="border" border={true} src="https://files.readme.io/fa9915d-image.png" />

Fill the 

`Reference Name`: The reference name will be used on App Store Connect and in Sales and Trends reports. It won't be displayed on the App Store. The name can't be longer than 64 characters.

`Product id`: A unique alphanumeric ID that is used for reporting. After you use a Product ID for one product, it can’t be used again, even if the product is deleted.

<Image align="center" className="border" border={true} src="https://files.readme.io/b0dc9f2-image.png" />

### Adding Availability

Choose the countries you want to see this product,

![](https://files.readme.io/ac05212-image.png)

<br />

### Setting the price

Set the price and click **Next**

![](https://files.readme.io/d743593-image.png)

<br />

In the next screen, you can modify the price for specific country of region

![](https://files.readme.io/b420548-image.png)

<br />

The following screen will show the summary of the plan, price and region. If it looks fine, you can click **Confirm**

![](https://files.readme.io/18562fc-image.png)

<br />

### Adding Localization

The next step is to set up localization information of the plan created above.  This is the name and description of the Non-Renewing Subscription that the user will see.

In the App Store Information section, click the Add localization button. 

<Image align="center" className="border" border={true} src="https://files.readme.io/aa4584e-image.png" />

Choose the language, display name and add a description and click add once done. 

![](https://files.readme.io/54716f2-image.png)

The Non-Renewing Subscription Display Name and Description will be visible to the user on the App Store and in their subscription management settings. 

### Add Reviewer Information

The last part of setting up an Non-Renewing Subscription in iOS is adding information for the reviewer. This is a Screenshot, and optional Review Notes. You'll be unable to submit your product for review without it.

Screenshot: A required image of your in-app purchase paywall for the reviewer. While testing, it's okay to upload an empty 640 x 920 image here of whatever you want. Before submitting for review, you should add a picture of your paywall.\
Review Notes: An optional text area to clarify anything about your in-app purchase for the reviewer.

<Image align="center" className="border" border={true} src="https://files.readme.io/66d19d1-image.png" />
