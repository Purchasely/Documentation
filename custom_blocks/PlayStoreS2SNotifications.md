---
name: Play Store - S2S notifications
---
We connect to Google Cloud Pub/Sub automatically for you by using your service account access.\
Finalize the S2S connection by clicking on **Connect to Google** in the Purchasely Console and let it guide you.\
If you already have it configured with your own server or another provider, after clicking on the button select the topic that you have configured. Purchasely will add a subscription to the same topic to also receives notifications without other steps required on your side.

> 🚧 Manual configuration
>
> **Connect to Google** needs the "Pub/Sub Admin" role on the service account of your Access Key. If the button shows an error or does not show, check these items:
>
> * The Access Key is valid.
> * The service account of the Access Key has the "Pub/Sub Admin" role.
>
> You can also configure [Server to Server notifications](play-store-configuring-server-to-server-notifications) manually. After the setup, you can remove the role. The notifications continue to work, but the Console can no longer show the setup status.

<Image align="center" className="border" border={true} src="https://files.readme.io/93da668-image.png" />
