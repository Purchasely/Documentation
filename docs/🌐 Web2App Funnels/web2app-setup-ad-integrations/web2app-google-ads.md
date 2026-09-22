---
title: Google Ads
excerpt: >-
  Report your funnel purchases as Google Ads conversions to measure and optimize
  your Search, YouTube and Demand Gen campaigns.
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
      slug: web2app-tiktok-pixel
      title: TikTok Pixel & Events API
---
The Google Ads integration loads the **Google tag** on your funnels and reports your funnel events as **conversions** from the visitor's browser. Google matches each conversion to the ad click through the click identifier (`gclid`) that auto-tagging adds to your landing URL and that Purchasely keeps until the purchase.

In Google Ads, each conversion you want to measure is a **conversion action**, identified by a **conversion label**. All the conversion actions of an account share the same **Conversion ID**, in the form `AW-123456789`.

| Purchasely event | Suggested conversion action | What to enter in the Console |
| --- | --- | --- |
| Page View | Page view | Its conversion label |
| Screen Viewed | Page view or custom | Its conversion label |
| Purchase Tapped | Begin checkout | Its conversion label |
| Purchase | Purchase, with value and currency | Its conversion label |

Only events with a conversion label are sent. Each conversion carries a unique transaction ID, so Google deduplicates repeated events.

## 1. Enable auto-tagging

Auto-tagging appends the click ID to your funnel URL when a visitor clicks an ad. Without it, Google cannot attribute conversions.

1. In [Google Ads](https://ads.google.com/), open **Admin → Account settings**.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-google-01-admin-account-settings-CROP.png" alt="Google Ads: Admin, Account settings" />

2. Expand **Auto-tagging**, tick the option and save.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-google-02-auto-tagging-CROP.png" alt="Google Ads: auto-tagging enabled" />

## 2. Create the conversion actions

Create at least the **Purchase** action. Repeat for *Begin checkout* if you want to optimize on checkout starts.

1. Open **Goals → Conversions → Summary** and click **+ Create conversion action**.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-google-03-goals-conversions-summary-CROP.png" alt="Google Ads: Goals, Conversions, Summary" />

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-google-04-create-conversion-action-CROP.png" alt="Google Ads: create conversion action" />

2. Choose **Website** as the source, enter your funnel domain (`web.purchasely.io` or your subdomain) and continue.
3. Under *Create conversion actions manually*, add an action with the **Purchase** category. Name it, for example *Web2App Purchase*, set **Value** to *Use different values for each conversion*, and **Count** to *Every*.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-google-05-choose-purchase-CROP.png" alt="Google Ads: choose the Purchase category" />

4. Optionally add a second action with the **Begin checkout** category, with no value and *One* count.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-google-06-choose-begin-checkout-CROP.png" alt="Google Ads: choose the Begin checkout category" />

5. Save. Google now proposes to set up the tag.

## 3. Get the Conversion ID and labels

1. On the conversion action, open the tag setup and choose **Use Google Tag Manager**. Google displays the **Conversion ID** (`AW-123456789`) and the **Conversion label** (a short string such as `AbC-dEfGhIjK1LmNoPqR`).

<Image align="center" border={true} src="TODO-NICO-UPLOAD/ads/ads-google-07-tag-setup-conversion-id-label.png" alt="Google Ads: tag setup showing the Conversion ID and Conversion label" />

2. Copy the Conversion ID once, and the label of each action you created. You do not need Google Tag Manager: Purchasely loads the tag for you.

## 4. Enter the Conversion ID and labels in the Console

1. In **Web2App → Setup**, section *4. External integrations*, open **Google Ads**.
2. Enable the integration and paste the **Conversion ID**.
3. In the **Front events** tab, enable **Purchase** and paste its **Conversion Label**. Do the same for *Purchase Tapped* if you created a *Begin checkout* action. Leave the label empty for events you do not want to send.
4. Save.

<Image align="center" border={true} src="TODO-NICO-UPLOAD/setup-ads-05-google-ads-form.png" alt="Purchasely Console: Google Ads integration with Conversion ID and per-event conversion labels" />

## 5. Check that conversions arrive

Open the **sandbox URL** of a Web Flow from a Google ad preview, or with a `gclid` parameter in the URL, browse a few screens and complete a purchase with a [Stripe test card](https://docs.stripe.com/testing). In **Goals → Conversions → Summary**, the action status changes from *Inactive* to *Recording conversions* once Google has received an event; conversions can take a few hours to be processed.

Sandbox purchases are real conversions for Google Ads. Test with a low volume, or remove the label while you iterate on a funnel.

## Troubleshooting

| Problem | Cause and solution |
| --- | --- |
| The action stays *Inactive*. | The conversion label is missing in the Console, or auto-tagging is off. Google also needs a few hours after a first conversion. |
| Conversions are recorded but not attributed to campaigns. | Auto-tagging is disabled, or the ad links to a URL that strips query parameters. Point ads to the funnel URL directly. |
| Conversion values are missing. | The action's *Value* setting must be *Use different values for each conversion*. |
| Purchases are under-counted. | Google receives browser events only. Ad blockers and some in-app browsers block them; compare with your Purchasely dashboards. |
