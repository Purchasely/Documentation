---
title: TikTok Pixel & Events API
excerpt: >-
  Report your funnel events to TikTok Events Manager, from the browser and from
  Purchasely's servers, to optimize TikTok Ads campaigns.
deprecated: false
hidden: true
link:
  new_tab: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  pages:
    - slug: web2app-x-pixel
      title: X Pixel
      type: basic
---
The TikTok integration sends your funnel events to a **pixel** in TikTok Events Manager. The **TikTok Pixel** reports events from the visitor's browser; the **Events API** reports purchases again from Purchasely's servers, so a conversion is never lost to an ad blocker or an in-app browser. Both are configured from the same screen in the Console.

| Purchasely event | TikTok event                               | Browser | Server                           |
| ---------------- | ------------------------------------------ | ------- | -------------------------------- |
| Page View        | `Pageview`                                 | Yes     | —                                |
| Screen Viewed    | `ViewContent`                              | Yes     | —                                |
| Purchase Tapped  | `InitiateCheckout`                         | Yes     | —                                |
| Purchase         | `CompletePayment`, with value and currency | Yes     | Yes, when an access token is set |

Browser and server copies of a purchase share the same event ID, so TikTok deduplicates them. In TikTok Ads Manager, `CompletePayment` is the event to optimize purchase campaigns on.

## 1. Create a pixel and get the Pixel ID and access token

TikTok creates the pixel and its Events API token in one guided setup. You need an advertiser account in TikTok Ads Manager.

1. Open [TikTok Events Manager](https://ads.tiktok.com/i18n/events_manager/home) and click **Connect data source**.


<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-01-events-manager-connect-data-source.png" alt="TikTok Events Manager: Connect data source" align="center" border={true} />


2. Select **Web** and continue. When asked for your website URL, click **Skip**.


<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-02-select-web.png" alt="TikTok Events Manager: connect data source, Web" align="center" border={true} />



<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-03-skip-website.png" alt="TikTok Events Manager: skip adding the website" align="center" border={true} />


3. Choose **Manual setup**, then **TikTok Pixel + Events API**.


<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-04-manual-setup.png" alt="TikTok Events Manager: manual setup" align="center" border={true} />



<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-05-pixel-plus-events-api.png" alt="TikTok Events Manager: TikTok Pixel + Events API" align="center" border={true} />


4. Name the pixel after your app and create it.


<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-06-name-pixel.png" alt="TikTok Events Manager: name the pixel" align="center" border={true} />


5. Under **Install base code**, click **Next** without installing anything: Purchasely loads the pixel on your funnels. Keep the defaults under **Manage configurations**.


<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-07-install-base-code-skip.png" alt="TikTok Events Manager: install base code, skip" align="center" border={true} />



<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-08-manage-configurations.png" alt="TikTok Events Manager: manage configurations" align="center" border={true} />


6. Under **Set up events**, click **switch to custom code** and add the events **Initiate Checkout** and **Complete Payment** (add **View Content** if you want it). Keep the predefined parameters.


<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-09-switch-to-custom-code.png" alt="TikTok Events Manager: switch to custom code" align="center" border={true} />



<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-10-select-events.png" alt="TikTok Events Manager: select the events" align="center" border={true} />


7. Click **Next** under **Implement event code** and under **Testing** without doing anything: Purchasely already fires these events.


<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-11-implement-event-code-skip.png" alt="TikTok Events Manager: implement event code, skip" align="center" border={true} />



<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-12-verify-pixel-setup.png" alt="TikTok Events Manager: verify pixel setup, skip" align="center" border={true} />


8. Under **Implement Events API**, click **Generate access token**. The page now shows both your **Pixel ID** and your **access token**. Keep it open.


<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-13-generate-access-token.png" alt="TikTok Events Manager: generate access token" align="center" border={true} />



<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-14-pixel-id-and-token.png" alt="TikTok Events Manager: Pixel ID and access token" align="center" border={true} />


## 2. Enter the Pixel ID and token in the Console

1. In **Web2App → Setup**, section _4. External integrations_, open **TikTok Pixel**.
2. Enable the integration, paste the **Pixel ID** and the token into **Conversions API Access Token**.
3. In the **Front events** tab, keep the four events enabled, or disable the ones you do not want to send.
4. Save.


<Image src="TODO-NICO-UPLOAD/setup-ads-03-tiktok-pixel-form.png" alt="Purchasely Console: TikTok Pixel integration with Pixel ID and access token" align="center" border={true} />


5. Back in TikTok, click **Next** then **Finish**. TikTok may flag the setup as incomplete until it receives a first event.


<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-15-finish.png" alt="TikTok Events Manager: finish the setup" align="center" border={true} />


## 3. Check that events arrive

1. Open the **sandbox URL** of a Web Flow, browse a few screens and complete a purchase with a [Stripe test card](https://docs.stripe.com/testing).
2. In Events Manager, open your pixel. The overview shows the events received, split between browser and server.


<Image src="TODO-NICO-UPLOAD/ads/ads-tiktok-16-events-overview.png" alt="TikTok Events Manager: events overview with browser and server events" align="center" border={true} />


You can also use the **Test events** tab of the pixel: paste your sandbox URL, click **Open website** and interact with the funnel to see events appear live.

## Troubleshooting

| Problem                                          | Cause and solution                                                                                |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------------- |
| No event appears in Events Manager.              | Check the Pixel ID and that the integration is enabled in the Console, then reload the funnel.    |
| `CompletePayment` appears only from the browser. | The access token is missing or was regenerated in TikTok. Paste the current token in the Console. |
| Purchases from in-app browsers are missing.      | Configure the Events API access token: server events do not depend on the browser.                |
