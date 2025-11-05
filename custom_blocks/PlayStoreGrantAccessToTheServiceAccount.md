---
name: PlayStoreGrantAccessToTheServiceAccount
---
<Callout icon="⚠️">
  Up to 72 hours delay

  Once you **grant access** to the Service Account for your application, it may take **up to 72 hours** for the changes to take effect on Google’s side. During this time, the Service Account will be updated with the proper access rights to the selected applications.
</Callout>

Grant access to the Service Account under the [Google Play Console](https://play.google.com/console/u/developers/users-and-permissions)  
_Google Play Console> Users & Permissions > Invite new users_

<Image align="center" border={true} src="https://files.readme.io/8aea72a-image.png" className="border" />

Then complete the 3 following steps

1. Set the email of your service account
2. Set "no expiration date" by leaving the "Set access expiry date" unchecked
3. Add your application
4. Select it
5. Apply

<Image align="center" alt="Under the tab **App permissions**  select the application corresponding to the desired App Bundle ID" border={true} caption="Under the tab **App permissions**  select the application corresponding to the desired App Bundle ID" src="https://files.readme.io/ed81f52-image.png" />

Once you've clicked on Apply, make sure the following permissions are selected:

* [x] View app information and download bulk reports
* [x] View financial data, orders, and cancellation survey responses
* [x] Manage orders and subscriptions

<Image align="center" alt="Select the appropriate permissions then click on Apply" border={true} caption="Select the appropriate permissions then click on Apply" src="https://files.readme.io/e12bb41-image.png" />

Finally, click on **Invite user** to grant access to your service account

<Image align="center" border={true} src="https://files.readme.io/f106fb3-image.png" className="border" />
