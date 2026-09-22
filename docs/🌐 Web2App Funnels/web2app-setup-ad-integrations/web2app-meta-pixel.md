---
title: Meta Pixel & Conversions API
excerpt: >-
  Report your funnel events to Meta Events Manager, from the browser and from
  Purchasely's servers, to optimize Facebook and Instagram campaigns.
deprecated: false
hidden: true
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

| Purchasely event | Meta event | Browser | Server |
| --- | --- | --- | --- |
| Page View | `PageView` | Yes | — |
| Screen Viewed | `ViewContent` | Yes | — |
| Purchase Tapped | `InitiateCheckout` | Yes | — |
| Purchase | `Purchase`, with value and currency | Yes | Yes, when an access token is set |

Browser and server copies of a purchase share the same event ID, so Meta deduplicates them and counts one conversion.

> 📘 One dataset, one ad account
>
> Use a dedicated dataset for your Web2App funnels, connected to a single ad account. Sharing a pixel between several ad accounts, or sending browser and server events to different datasets, creates discrepancies in Events Manager.

## 1. Create a dataset and get the Pixel ID

Skip this step if you already have a pixel for your website: its Dataset ID is the Pixel ID.

1. Open [Meta Events Manager](https://business.facebook.com/events_manager2/) and click **Connect data**.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-01-events-manager-connect-data.png" alt="Meta Events Manager: Connect data" />

2. Select **Web** and continue.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-02-connect-web.png" alt="Meta Events Manager: connect a new data source, Web" />

3. Click **Create new dataset**, name it after your app and create it.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-03-create-new-dataset.png" alt="Meta Events Manager: create new dataset" />

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-04-dataset-name.png" alt="Meta Events Manager: name the dataset" />

4. Open the dataset, then its **Settings** tab, and copy the **Dataset ID**. This is your Pixel ID: a number, without letters.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-05-dataset-id-CROP.png" alt="Meta Events Manager: dataset settings with the Dataset ID" />

## 2. Enter the Pixel ID in the Console

1. In **Web2App → Setup**, section *4. External integrations*, open **Meta Pixel**.
2. Enable the integration and paste the Dataset ID into **Pixel ID**.
3. In the **Front events** tab, keep the four events enabled, or disable the ones you do not want to send.
4. Save.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/setup-ads-02-meta-pixel-form.png" alt="Purchasely Console: Meta Pixel integration with Pixel ID and Conversions API Access Token" />

Browser events start flowing to your dataset within minutes. Continue with the Conversions API to secure your purchase events.

## 3. Generate a Conversions API access token

You need to be an admin of the Meta business portfolio.

1. In Events Manager, open your dataset. On the overview, click **Set up Conversions API** (or **Start your setup** in the Conversions API card).

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-06-dataset-overview-set-up-capi.png" alt="Meta Events Manager: dataset overview, Set up Conversions API" />

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-07-capi-start-setup-CROP.png" alt="Meta Events Manager: Conversions API, Start your setup" />

2. Click **See other ways to set up**, select **Set up manually** and continue.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-08-capi-set-up-manually-CROP.png" alt="Meta Events Manager: choose your setup, Set up manually" />

3. Select **Conversions API and Meta pixel**, then **Start CAPI setup** and **Finish** on the instructions screen.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-09-capi-and-pixel-CROP.png" alt="Meta Events Manager: Conversions API and Meta pixel" />

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-10-capi-instructions-finish.png" alt="Meta Events Manager: Conversions API instructions, Finish" />

4. Under *Manual implementation*, tick **Events sent using pixel code**, add **Purchase** under *Additional events*, and continue through the parameters and review steps.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-11-events-sent-using-pixel.png" alt="Meta Events Manager: events sent using pixel code" />

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-12-additional-events.png" alt="Meta Events Manager: additional events" />

5. On the *Using the Conversions API* page, go to **Generate an access token**, choose **Set up without Dataset Quality API**, click **Generate Access Token** and copy the token.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-13-using-the-capi.png" alt="Meta Events Manager: Using the Conversions API" />

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-14-generate-access-token.png" alt="Meta Events Manager: generate an access token" />

## 4. Enter the access token in the Console

Back in the Meta Pixel integration of the Console, paste the token into **Conversions API Access Token** and save. Purchases are now also sent from Purchasely's servers. The token is stored encrypted and never exposed to the browser.

## 5. Check that events arrive

1. In Events Manager, open your dataset and go to the **Test events** tab.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-15-test-events-CROP.png" alt="Meta Events Manager: Test events tab" />

2. Open the **sandbox URL** of a Web Flow, browse a few screens and complete a purchase with a [Stripe test card](https://docs.stripe.com/testing). `PageView`, `ViewContent`, `InitiateCheckout` and `Purchase` appear in the tab.
3. To confirm the Conversions API, click **Manage integrations** on the dataset overview: **Conversions API** shows *Active* or *Waiting for first event*. Once a purchase has been made, the `Purchase` event shows *Multiple* in the *Integrations* column, meaning it was received from both the browser and the server.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-16-manage-integrations-CROP.png" alt="Meta Events Manager: manage integrations" />

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-meta-17-integrations-status-CROP.png" alt="Meta Events Manager: Conversions API and Meta pixel active" />

Sandbox purchases are real events for Meta. Use the *Test events* tab, or a dedicated test dataset, if you do not want them mixed with live traffic.

## Troubleshooting

| Problem | Cause and solution |
| --- | --- |
| No event appears in Events Manager. | The Pixel ID must be the numeric Dataset ID, and the integration must be enabled. Check the *Front events* tab too. |
| Events appear but Meta shows a domain warning. | Add your funnel domain (`web.purchasely.io` or your subdomain) to the dataset's **traffic permissions** allow list in Events Manager. |
| `Purchase` is counted twice. | Browser and server events reach different datasets, or the Pixel ID in the Console does not match the dataset of the token. Use the same dataset for both. |
| Purchases from in-app browsers are missing. | Configure the Conversions API access token: server events do not depend on the browser. |
