---
title: Google Ads
excerpt: >-
  Report your funnel purchases as Google Ads conversions to measure and optimize
  your Search, YouTube and Demand Gen campaigns.
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
      slug: web2app-tiktok-pixel
      title: TikTok Pixel & Events API
---
The Google Ads integration loads the **Google tag** on your funnels and reports your funnel events as **conversions** from the visitor's browser. Google matches each conversion to the ad click through the click identifier (`gclid`) that auto-tagging adds to your landing URL and that Purchasely keeps until the purchase.

In Google Ads, each conversion you want to measure is a **conversion action**, identified by a **conversion label**. All the conversion actions of an account share the same **Conversion ID**, in the form `AW-123456789`.

| Purchasely event | Suggested conversion action       | What to enter in the Console |
| ---------------- | --------------------------------- | ---------------------------- |
| Page View        | Page view                         | Its conversion label         |
| Screen Viewed    | Page view or custom               | Its conversion label         |
| Purchase Tapped  | Begin checkout                    | Its conversion label         |
| Purchase         | Purchase, with value and currency | Its conversion label         |

Only events with a conversion label are sent. Each conversion carries a unique transaction ID, so Google deduplicates repeated events.

## 1. Enable auto-tagging

Auto-tagging appends the click ID to your funnel URL when a visitor clicks an ad. Without it, Google cannot attribute conversions.

1. In [Google Ads](https://ads.google.com/), open **Admin → Account settings**.

![](https://files.readme.io/33879e71226c3f529c36094bbda4650254fcbdbac9e2481f143a2fd5242092dd-image.png)

2. Expand **Auto-tagging**, tick the option and save.

![](https://files.readme.io/907c7e8eeef8a8f303bedbc96fcc4315f3656e2f4ee28bd413f318a67d8f7da0-image.png)

## 2. Create the conversion actions

Create at least the **Purchase** action. Repeat for _Begin checkout_ if you want to optimize on checkout starts.

1. Open **Goals → Conversions → Summary** and click **+ Create conversion action**.

![](https://files.readme.io/c2627a3ab551cdfe4040c1b6eb9fdce28a3587730f0c4bc99fd5e9ac7cf8264c-image.png)

2. Choose **Website** as the source, enter your funnel domain (`web.purchasely.io` or your subdomain) and continue.
3. Under _Create conversion actions manually_, add an action with the **Purchase** category. Name it, for example _Web2App Purchase_, set **Value** to _Use different values for each conversion_, and **Count** to _Every_.

![](https://files.readme.io/6ded37e4db89c91afa6fbc2e0847bb17804ccc5b11d5c3a62eeb25906e8d4fc1-image.png)

4. Optionally add a second action with the **Begin checkout** category, with no value and _One_ count.

![](https://files.readme.io/9ec721a6970fd5c40bdb308d812e8277d45eaa5fcdf66af436d1caa7b15dddd8-image.png)

5. Save. Google now proposes to set up the tag.

## 3. Get the Conversion ID and labels

1. On the conversion action, open the tag setup and choose **Use Google Tag Manager**. Google displays the **Conversion ID** (`AW-123456789`) and the **Conversion label** (a short string such as `AbC-dEfGhIjK1LmNoPqR`).


<Image src="TODO-NICO-UPLOAD/ads/ads-google-07-tag-setup-conversion-id-label.png" alt="Google Ads: tag setup showing the Conversion ID and Conversion label" align="center" border={true} />


2. Copy the Conversion ID once, and the label of each action you created. You do not need Google Tag Manager: Purchasely loads the tag for you.

## 4. Enter the Conversion ID and labels in the Console

1. In **Web2App → Setup**, section _4. External integrations_, open **Google Ads**.
2. Enable the integration and paste the **Conversion ID**.
3. In the **Front events** tab, enable **Purchase** and paste its **Conversion Label**. Do the same for _Purchase Tapped_ if you created a _Begin checkout_ action. Leave the label empty for events you do not want to send.
4. Save.


<Image src="TODO-NICO-UPLOAD/setup-ads-05-google-ads-form.png" alt="Purchasely Console: Google Ads integration with Conversion ID and per-event conversion labels" align="center" border={true} />


## 5. Check that conversions arrive

Open the **sandbox URL** of a Web Flow from a Google ad preview, or with a `gclid` parameter in the URL, browse a few screens and complete a purchase with a [Stripe test card](https://docs.stripe.com/testing). In **Goals → Conversions → Summary**, the action status changes from _Inactive_ to _Recording conversions_ once Google has received an event; conversions can take a few hours to be processed.

Sandbox purchases are real conversions for Google Ads. Test with a low volume, or remove the label while you iterate on a funnel.

## Troubleshooting

| Problem                                                   | Cause and solution                                                                                                              |
| --------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| The action stays _Inactive_.                              | The conversion label is missing in the Console, or auto-tagging is off. Google also needs a few hours after a first conversion. |
| Conversions are recorded but not attributed to campaigns. | Auto-tagging is disabled, or the ad links to a URL that strips query parameters. Point ads to the funnel URL directly.          |
| Conversion values are missing.                            | The action's _Value_ setting must be _Use different values for each conversion_.                                                |
| Purchases are under-counted.                              | Google receives browser events only. Ad blockers and some in-app browsers block them; compare with your Purchasely dashboards.  |
