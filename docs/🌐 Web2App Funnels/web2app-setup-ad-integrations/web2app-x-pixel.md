---
title: X Pixel
excerpt: >-
  Report your funnel events to X Ads to measure and optimize campaigns on X
  (formerly Twitter).
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Next, run your funnel end to end in sandbox before going live.
  pages:
    - type: basic
      slug: web2app-test-and-go-live
      title: Test and go live
---
The X integration loads the **X Pixel** on your funnels and reports your funnel events to X Ads Events Manager from the visitor's browser. Unlike Meta and TikTok, X events are sent from the browser only.

On X, each conversion event you want to measure is an **event** you create in Events Manager, identified by an **Event ID** such as `tw-abcde-fghij`. Purchasely fires the matching event for each of its four front events.

| Purchasely event | Suggested X event type | What to enter in the Console |
| --- | --- | --- |
| Page View | Page view | Its Event ID |
| Screen Viewed | Content view | Its Event ID |
| Purchase Tapped | Checkout initiated | Its Event ID |
| Purchase | Purchase, with value and currency | Its Event ID |

Every event carries a unique conversion ID, so X deduplicates repeated events from the same visit.

> 📘 Prerequisites
>
> The **Tools → Events manager** menu of X Ads Manager is available once a payment method is added to your X Ads account.

## 1. Create the pixel and get the Pixel ID

Skip this step if your X Ads account already has a pixel.

1. In [X Ads Manager](https://ads.x.com), open **Tools → Events manager** and click **Add event source**. Save it.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-x-01-events-manager-add-event-source.png" alt="X Ads Events manager: Add event source" />

2. The pixel appears with its **ID**, a five-character code. Copy it.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-x-02-copy-pixel-id.png" alt="X Ads Events manager: copy the pixel ID" />

## 2. Create one event per Purchasely event

Repeat for each event you want to measure. At minimum, create the **Purchase** event.

1. In Events manager, click **Add events**.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-x-03-add-events.png" alt="X Ads Events manager: Add events" />

2. Enter a **Name** (for example *Purchase*), select the **Event type** from the table above and keep the default attribution windows.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-x-04-event-details.png" alt="X Ads: event details" />

3. Keep **Define event with code** as the setup method.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-x-05-setup-method-define-with-code.png" alt="X Ads: setup method, define event with code" />

4. Under **Event installation**, click **Save** without copying any code: Purchasely fires the event for you.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-x-06-event-installation-save.png" alt="X Ads: event installation, save" />

5. Each event now has an **ID** in the form `tw-xxxxx-xxxxx`. Copy the ID of each event you created.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-x-07-event-id.png" alt="X Ads Events manager: list of events with their IDs" />

## 3. Enter the Pixel ID and Event IDs in the Console

1. In **Web2App → Setup**, section *4. External integrations*, open **X Pixel**.
2. Enable the integration and paste the five-character **Pixel ID**.
3. In the **Front events** tab, enable the events you created in X and paste each **Event ID** next to its event. Disable the others.
4. Save.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/setup-ads-04-x-pixel-form.png" alt="Purchasely Console: X Pixel integration with Pixel ID and Event IDs" />

## 4. Check that events arrive

Open the **sandbox URL** of a Web Flow, browse a few screens and complete a purchase with a [Stripe test card](https://docs.stripe.com/testing). In Events manager, each event switches to **Active** and shows a *Last recorded* time.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-x-08-events-overview.png" alt="X Ads Events manager: events overview" />

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-x-09-events-status-last-recorded.png" alt="X Ads Events manager: status and last recorded columns" />

## Troubleshooting

| Problem | Cause and solution |
| --- | --- |
| Events never become *Active*. | An Event ID is missing or does not belong to this pixel. Check the IDs in the *Front events* tab. |
| Only some events are recorded. | Only events with an Event ID are sent. Add the missing IDs or disable the events you do not track. |
| Purchases are under-counted. | X receives browser events only. Ad blockers and some in-app browsers block them; compare with your Purchasely dashboards. |