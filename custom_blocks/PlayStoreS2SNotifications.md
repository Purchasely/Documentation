---
name: Play Store - S2S notifications
---
We connect to Google Cloud Pub/Sub automatically for you by using your service account access.\
Finalize the S2S connection by clicking on **Connect to Google** in the Purchasely Console and let it guide you.\
If you already have it configured with your own server or another provider, after clicking on the button select the topic that you have configured. Purchasely will add a subscription to the same topic to also receives notifications without other steps required on your side.

> 🚧 Manual configuration
>
> If the button is red, it means that we do no have the right to configure Pub/Sub notifications from Google cloud with the Access Key you have provided. In that case, you need to configure [Server to Server notifications](play-store-configuring-server-to-server-notifications) manually

<Image align="center" className="border" border={true} src="https://files.readme.io/93da668-image.png" />
