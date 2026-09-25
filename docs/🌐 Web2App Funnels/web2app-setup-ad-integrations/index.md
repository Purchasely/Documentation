---
title: Setup 4 · Ad platform integrations
excerpt: >-
  Send your funnel events to Meta, Google Ads, TikTok and X so your campaigns
  can measure and optimize on real conversions.
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Start with the platform you advertise on the most.
  pages:
    - type: basic
      slug: web2app-meta-pixel
      title: Meta Pixel & Conversions API
---
Paid acquisition is the reason most apps build Web2App Funnels, and ad platforms need to know what happens after the click. This optional setup section connects your funnels to **Meta**, **Google Ads**, **TikTok** and **X**: every step a visitor takes in a funnel is reported to the platform, and every purchase becomes a conversion your campaigns can optimize on, in seconds rather than days.

Open [**Web2App → Setup**](https://console.purchasely.io/web2app?tab=setup), section _4. External integrations_. Each platform is also available under <Anchor target="_blank" href="https://console.purchasely.io/external-integrations">**External Integrations**</Anchor>, where the same screen opens.

![](https://files.readme.io/85f836fdeace498071fa54271d1b52bff618c5191ff63955255d20189faa2ac6-image.png)

## What is sent

Purchasely fires four events on the web. In the Console, each one can be enabled or disabled per platform under the **Front events** tab of the integration.

| Purchasely event    | When it fires                                                         | Meta               | TikTok             | X                  | Google Ads                    |
| ------------------- | --------------------------------------------------------------------- | ------------------ | ------------------ | ------------------ | ----------------------------- |
| **Page View**       | Once, when the visitor opens the funnel                               | `PageView`         | `Pageview`         | `PageView`         | Conversion, if a label is set |
| **Screen Viewed**   | Every time a Screen of the flow is displayed                          | `ViewContent`      | `ViewContent`      | `ViewContent`      | Conversion, if a label is set |
| **Purchase Tapped** | When the visitor taps a purchase button and the Stripe checkout opens | `InitiateCheckout` | `InitiateCheckout` | `InitiateCheckout` | Conversion, if a label is set |
| **Purchase**        | When the Stripe checkout is completed                                 | `Purchase`         | `CompletePayment`  | `Purchase`         | Conversion, if a label is set |

Purchase events carry the **amount and currency** of the subscription, so the platforms can compute your return on ad spend. Every event carries the flow's identifier as content name, so you can break down results funnel by funnel in the platform's reports.

<Callout icon="📘" theme="info">
  ### Web funnel events only

  These integrations report what happens on the web. Events from inside your app, such as store purchases, are forwarded by the mobile integrations configured under **App settings → Integrations**, as before.
</Callout>

## Browser events and server events

Ad platforms receive events in two ways:

* **From the browser**, through the platform's pixel loaded on your funnel pages. This is what all four integrations do as soon as you enter the pixel or conversion ID. Browser events can be blocked by ad blockers, privacy settings or in-app browsers.
* **From Purchasely's servers**, through the platform's conversion API. Purchasely sends the purchase again from its servers when the checkout is confirmed, so the conversion reaches the platform even when the browser event was blocked. Both copies share the same event identifier, and the platform keeps a single conversion.

| Platform                         | Browser events | Server events        | What you need                                         |
| -------------------------------- | -------------- | -------------------- | ----------------------------------------------------- |
| [Meta](web2app-meta-pixel)       | Yes            | Yes, Conversions API | Pixel ID, and an access token for the Conversions API |
| [TikTok](web2app-tiktok-pixel)   | Yes            | Yes, Events API      | Pixel ID, and an access token for the Events API      |
| [X](web2app-x-pixel)             | Yes            | No                   | Pixel ID, and one Event ID per event                  |
| [Google Ads](web2app-google-ads) | Yes            | No                   | Conversion ID, and one conversion label per event     |

We recommend configuring the server events for Meta and TikTok: they are the platforms where a missed purchase costs you the most in campaign optimization.

## Attribution parameters

Purchasely keeps the click identifiers of each platform (`fbclid`, `ttclid`, `gclid`, `twclid`) and the UTM parameters from the first page of the funnel to the purchase, even when the visitor navigates several screens. They are attached to the server events, and returned to you in the [purchase webhooks](web2app-events-and-webhooks) with the `web2app` channel.

Point your ads to the **live URL** of the funnel with your UTM parameters, for example:

```
https://start.yourapp.com/abc123XYZ?utm_source=meta&utm_medium=cpc&utm_campaign={{campaign.name}}&utm_content={{ad.name}}
```

## Set up each platform

* [Meta Pixel & Conversions API](web2app-meta-pixel)
* [Google Ads](web2app-google-ads)
* [TikTok Pixel & Events API](web2app-tiktok-pixel)
* [X Pixel](web2app-x-pixel)

Each guide covers where to find the identifiers in the ad platform, what to enter in the Console, and how to check that events arrive. Changes to an integration apply to your live funnels within minutes, without republishing.
