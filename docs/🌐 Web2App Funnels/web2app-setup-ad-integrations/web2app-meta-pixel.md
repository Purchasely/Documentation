---
title: Meta Pixel & Conversions API
excerpt: >-
  Report your funnel events to Meta Events Manager, from the browser and from
  Purchasely's servers, to optimize Facebook and Instagram campaigns.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: web2app-google-ads
      title: Google Ads
---
The Meta integration sends your funnel events to a **dataset** in Meta Events Manager. The **Meta Pixel** reports events from the visitor's browser; the **Conversions API** reports purchases again from Purchasely's servers, so a conversion is never lost to an ad blocker or an in-app browser. Both are configured from the same screen in the Console.

| Purchasely event | Meta event                          | Browser | Server                           |
| ---------------- | ----------------------------------- | ------- | -------------------------------- |
| Page View        | `PageView`                          | Yes     | —                                |
| Screen Viewed    | `ViewContent`                       | Yes     | —                                |
| Purchase Tapped  | `InitiateCheckout`                  | Yes     | —                                |
| Purchase         | `Purchase`, with value and currency | Yes     | Yes, when an access token is set |

Browser and server copies of a purchase share the same event ID, so Meta deduplicates them and counts one conversion.

<Callout icon="📘" theme="info">
  ### One dataset, one ad account

  Use a dedicated dataset for your Web2App funnels, connected to a single ad account. Sharing a pixel between several ad accounts, or sending browser and server events to different datasets, creates discrepancies in Events Manager.
</Callout>

## 1. Create a dataset and get the Pixel ID

Skip this step if you already have a pixel for your website: its Dataset ID is the Pixel ID.

1. Open [Meta Events Manager](https://business.facebook.com/events_manager2/) and click **Connect data**.


<Image src="https://files.readme.io/21c1d82bf2bad99c73a21ab30b060fbe4e50aac5130332c7add777a7d8f442b8-ads-meta-01-events-manager-connect-data.png" border={true} />


2. Select **Web** and continue.


   <Image src="https://files.readme.io/60a33a6cb0c2a27b050285f3750431b06d93ab225fba18296576219ab9ff3dd3-image.png" border={true} />


3) Click **Create new dataset**, name it after your app and create it.


<Image src="https://files.readme.io/8bff207253d37772da1e131d49792a5089a7279027b91a855238c0a1ec1361db-image.png" align="center" border={true} />


<br />


<Image src="https://files.readme.io/c65512cd362f7e2b7b26e7f5ed01329da72bf0f7539be7473c7940118f49bce0-image.png" align="center" border={true} />


4. Open the dataset, then its **Settings** tab, and copy the **Dataset ID**. This is your Pixel ID: a number, without letters.


<Image src="https://files.readme.io/516a08285cbff86f6cbde4d3b9853051ae6ca1f35343411248606f7c7a6ab440-image.png" align="center" border={true} />


## 2. Enter the Pixel ID in the Console

1. In **Web2App → Setup**, section _4. External integrations_, open **Meta Pixel**.
2. Enable the integration and paste the Dataset ID into **Pixel ID**.


<Image src="https://files.readme.io/ccffbbaa9567b320087a4f91f204f1d1383ce0bc395866efe8a554216d7dd4f8-image.png" align="center" border={true} />


<br />

3. In the **Front events** tab, keep the four events enabled, or disable the ones you do not want to send.

![](https://files.readme.io/e189b096d1807a48392efc260ff2ddaca827d12e4de5a70c88414464e904dcdc-image.png)

4. Save.

<br />

Browser events start flowing to your dataset within minutes. Continue with the Conversions API to secure your purchase events.

## 3. Generate a Conversions API access token

You need to be an admin of the Meta business portfolio.

1. In Events Manager, open your dataset. On the overview, click **Set up Conversions API** (or **Start your setup** in the Conversions API card).


<Image src="https://files.readme.io/e5051e8e21c033ba80fd7681b61cd50ce2ab9b75f26a7feeef1d7633e66b83fd-image.png" align="center" border={true} />


2. Click **See other ways to set up**, select **Set up manually** and continue.


<Image src="https://files.readme.io/f62abea10cc360749ab3d17f0754045faf9138c226dc29cf87a6ad8e83860c8a-image.png" align="center" border={true} />


3. Select **Conversions API and Meta pixel**, then **Start CAPI setup** and **Finish** on the instructions screen.


<Image src="https://files.readme.io/19c67dfbc87a9fa84a8c1bf5d553a220a05b5011bd95f93e5102fe24c0574537-image.png" align="center" border={true} />


4. Under _Manual implementation_, tick **Events sent using pixel code**, add **Purchase** under _Additional events_, and continue through the parameters and review steps.


<Image src="https://files.readme.io/ca9fdb5ff7873c4f2f5f690fdaf4d2bcea317e191a0d81ca3a039cf9d1e29b7f-image.png" align="center" border={true} />


<br />


<Image src="TODO-NICO-UPLOAD/ads/ads-meta-12-additional-events.png" alt="Meta Events Manager: additional events" align="center" border={true} />


5. On the _Using the Conversions API_ page, go to **Generate an access token**, choose **Set up without Dataset Quality API**, click **Generate Access Token** and copy the token.


<Image src="https://files.readme.io/53bc229de2d7d9cf775bebd216437d09c9d2194a8f2a1eaa49048fa8b8f92e80-image.png" align="center" border={true} />


![](https://files.readme.io/7d588bc456be10cffa8b0c17fc77800ce0450a22c5550f18a03b43f9b87da1df-image.png)

## 4. Enter the access token in the Console

Back in the Meta Pixel integration of the Console, paste the token into **Conversions API Access Token** and save. Purchases are now also sent from Purchasely's servers. The token is stored encrypted and never exposed to the browser.


<Image src="https://files.readme.io/27499cfa0c4841bb2beadbdaba754a99caa3b1d7513b4931ba1c560fe0464962-image.png" align="center" border={true} />


<br />


<Image src="https://files.readme.io/6491d6aef3fe64cc881857ea3515cb1333a840efceb586911e4b32549c1864f0-image.png" align="center" border={true} />


## 5. Check that events arrive

1. In Events Manager, open your dataset and go to the **Test events** tab.


<Image src="https://files.readme.io/e140d27a4341bbcc7cd7ff29900f148eefa1131e4f42664330fd2e01057259d7-image.png" align="center" border={true} />


2. Copy the **sandbox URL** of a Web Flow and paste it in the Test Events field from Meta, then click on Test Events


<Image src="https://files.readme.io/6d6df7aa735df638601289465f4a493faf08f31224e3b4cfce457c7ee8b8aedc-image.png" align="center" border={true} />


3. Browse a few screens and complete a purchase with a [Stripe test card](https://docs.stripe.com/testing). `PageView`, `ViewContent`, `InitiateCheckout` and `Purchase` appear in the tab.


<Image src="https://files.readme.io/1589118e4fe94f9553c4358ae351c3f1edfd01466a9856284af1bf7a9b08862c-image.png" align="center" border={true} />


2. To confirm the Conversions API, click **Manage integrations** on the dataset overview: **Conversions API** shows _Active_ or _Waiting for first event_. Once a purchase has been made, the `Purchase` event shows _Multiple_ in the _Integrations_ column, meaning it was received from both the browser and the server.

<br />

Sandbox purchases are real events for Meta. Use the _Test events_ tab, or a dedicated test dataset, if you do not want them mixed with live traffic.

## Troubleshooting

| Problem                                        | Cause and solution                                                                                                                                         |
| ---------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| No event appears in Events Manager.            | The Pixel ID must be the numeric Dataset ID, and the integration must be enabled. Check the _Front events_ tab too.                                        |
| Events appear but Meta shows a domain warning. | Add your funnel domain (`web.purchasely.io` or your subdomain) to the dataset's **traffic permissions** allow list in Events Manager.                      |
| `Purchase` is counted twice.                   | Browser and server events reach different datasets, or the Pixel ID in the Console does not match the dataset of the token. Use the same dataset for both. |
| Purchases from in-app browsers are missing.    | Configure the Conversions API access token: server events do not depend on the browser.                                                                    |
