---
title: Preview
excerpt: >-
  This page describes how you can Preview your Screens in the Console and in
  your app before publishing them to real users
deprecated: false
hidden: false
metadata:
  robots: index
---
# Previewing Screens in Purchasely

The Preview feature lets you validate how a Screen will look and behave before exposing it to end users.
Purchasely provides two complementary preview mechanisms:

1. Console Preview: fast iteration and visual checks directly in the Console
2. In-App Preview: native rendering inside your app, as your users will see it

Both should be used together to ensure design accuracy, functional correctness, and confidence before launch.

<br />

> ⚠️ Rendering differences may exist between the Console Preview and the Native rendering
>
> The Console Preview is rendered in HTML.  
> Screens in your app are rendered natively by the mobile SDKs.
>
> Minor discrepancies (layout, spacing, font rendering, alignment) may occur.
>
> The Console Preview is for design validation, not pixel-perfect guarantees and we strongly advise you to verify the native rendering every Screen published inside of your app.
>
> You should always prioritize the native rendering because it's the one seen by your end users. The HTML rendering in the Console is only seen by you.

<br />

# 1. Preview inside the Purchasely Console

The Console Preview is available directly in the Screen Composer and is designed for rapid iteration and visual validation.

<br />

### Build Mode vs Preview Mode

The Screen Composer offers two complementary modes:

* Build Mode
  * Select components directly from the preview
  * Visualize padding, margin and safe areas
* Preview Mode
  * Interact with the Screen as an end user
  * No overlays or editor controls

Switching between both modes allows you to design and validate interaction flows without friction.

<Image align="center" border={true} src="https://files.readme.io/434bb97cb27e941d1709f779eae16abdff31877c052eaac7fada5ddb7123e5b1-build_vs_preview.gif" className="border" />

<br />

<br />

### Device & Layout Simulation

You can preview your Screen across multiple device contexts to validate layout and responsiveness:

* **Device types**: Smartphone, Tablet, TV
* **Specific devices**: Choose from a predefined list
* **Orientation**: Portrait or Landscape

<Image align="center" border={true} src="https://files.readme.io/58939678f8c7ccedfc86365367b0318836f02e22575d997b63a0fe8b02bc7659-devices.gif" className="border" />

<br />

> 📘 Adapting Screens to device types
>
> When switching to another device type (for example from Smartphone to Tablet), you can override the widths, heights and media of any component for that particular device type.
>
> 📚 More information: [adapting Screens to devices](composer-adapting-screens-to-devices)

<br />

### Visual & Contextual Variations

The Preview allows you to simulate multiple visual and commercial contexts:

* Light mode / Dark mode

  <Image align="center" border={true} src="https://files.readme.io/0d4dc8b6d62a7daf48d4551a2845a0a3dad093c0bc819b83439e6f9666bb4f65-dark_mode.gif" className="border" />

  📚 More information: [Dark mode vs Light mode](dark-mode)
* Regular mode / Offer mode

  <Image align="center" border={true} src="https://files.readme.io/5d49d06ade1b57b8179d93b9d33a7770b51cbccb033a55122a36484237b388bb-offer-mode.gif" className="border" />

  📚 More information: [understanding the Offer mode](offer-mode)
* Languages (localization preview)

  <Image align="center" border={true} src="https://files.readme.io/b6e0257e174caef7fe073f658442c8ce39dca5535b5b66e44dcac2bc7e6263ec-language.gif" className="border" />

  📚 More information: [localizing your Screens](composer-localization)
* Store fronts (App Store / Google Play) and store territories

  <Image align="center" border={false} src="https://files.readme.io/3c513fa3c7e46c12bbfc8c2e357dd75e7f495ace044d294824e98a2b27ebe70c-storefronts.gif" />

### Prices in the Console preview

> 📘 Prices displayed as $X,XX in the Console preview instead of the real price
>
> For **Google Play Store** subscriptions, the Console fetches the prices live from the Play Store: the preview displays the real price and currency of the selected store territory, even if no transaction has ever been observed for the product.
>
> For the **Apple App Store** (as well as Amazon Appstore, Huawei AppGallery and Stripe), the Console relies on past transactions to display the price tags in the Console Preview:
>
> * As long as no transaction has been observed, the price tags are replaced by the string `X.XX`
> * As soon as the first transactions are processed or observed for this particular product, the `X.XX` will be replaced by the pricing observed for the offering.
>
> In every case this only affects the Console preview: the SDK fetches the prices directly from the store, so your users always see the correct price, in the currency of their store territory.

### Preview widget

<br />

The Preview Widget lets you visualize your Screen across all possible configurations, helping you simulate real user contexts and see the Screen exactly as your users would.

If your Screen includes [conditional visibility rules](conditional-visibility), these conditions appear directly in the Preview Widget. You can toggle them on or off to instantly display or hide the associated components and validate each variant of your Screen.

Each time you change an option in the Preview Widget:

* The Console preview updates in real time
* A configuration-specific QR code is generated, allowing you to scan and view the exact same configuration natively inside your app (requires [SDK v5.6](https://docs.purchasely.com/changelog/56) and above)

This makes it easy to iterate quickly in the Console and seamlessly validate the result in-app.

<Image align="center" border={true} src="https://files.readme.io/38333036fffe24aaa0e8b8cddae8cfaa56ef50d387318c19c31a0320c7229d51-widget.gif" className="border" />

<br />

<br />

# 2. Preview inside your app

The In-App Preview lets you visualize a Screen inside your application, using the native SDK renderer.

This is the **source of truth** before shipping.

To visualize a Screen inside your app, simply scan the QR code with your device. 

It will open your app and automatically trigger the associated Screen, which will be displayed in its **draft** version (SDK v5.6 and above)

<Image align="center" border={true} src="https://files.readme.io/b98a72af8ff105246126bada93724af214cd43a8cf543a9ded80bbe4a4a66e95-headspace_pw5.gif" className="border" />

> ❗️ Deeplink implementation required
>
> The scanning of the QR triggers a Purchasely Deeplink that will open the app and automatically get recognized by the SDK to display the associated Screen.
>
> To make it work, it is therefore mandatory to have implemented deeplinks management. 
>
> If you haven't, follow the guide:
>
> 📚 [Deeplink management](deeplinks-management)

> 🚧 **The camera does not open my app scheme**
>
> On some devices, a deeplink like myapp:// is not opened by the camera. This is a limitation from Google.  
> Instead you can use [App Links](https://developer.android.com/training/app-links) like [https://myapp.com/](https://myapp.com/) as the scheme for your application.  
> Purchasely then uses a link in this format: `https://myapp.com/ply/presentations/MY_PAYWALL_ID?preview=1` embedded in the QR code. It works on your device when you have followed the [Android documentation](https://support.google.com/android/search?q=open+by+default).

> 📘 How the preview options reach the Screen
>
> Both SDKs fetch a preview through the regular `presentations/{id}` route. The SDK forwards `preview=1` and the option keys in the query.
>
> The backend honours `theme_mode`, `language`, `intro_offer`, `ply_att` and `ply_audiences` only when `preview=1` is present. On Android this works in every 6.x build. On iOS this works from 6.1.0.
>
> Only the literal value `preview=1` counts. The values `preview=true`, `preview=yes` and a bare `preview` are not a preview on Android and not a preview on iOS. The two SDKs match exactly on this rule.
>
> A preview deeplink bypasses the `allowDeeplink` gate on both platforms. An author who scans a QR code expects the Screen. The gate exists to stop an unsolicited paywall, not a solicited one.
>
> Two limitations apply on both platforms:
>
> * The options apply to a Screen and not to a Flow. A Flow preview renders each step with the device defaults.
> * A hand-edited link without `preview=1` renders a live presentation, and you get no warning.
>
> Before 6.1.0, iOS treated `ply/presentations/{id}?preview=1` as a live paywall: it routed the link to the deprecated `/presentations_preview` endpoint, which drops every option, and it did not bypass the gate. The same link worked on Android.

### Preview before publication

When you hit the publish button, you can visualize your Screens in all the applicable configurations at once: 

* Light mode
* Dark mode
* Offer mode.

You can also select the desired language and toggle on/off the various visibility conditions configured for the Screen.

By scanning the QR code below each rendering, you can visualize your Screen inside of your app directly. 

From SDK v5.6 onwards, it will apply the corresponding configuration automatically.

<Image align="center" border={false} src="https://files.readme.io/588da22e65aaebd5b048a0240d9cbecb4066a0717410e5efc03796682902c50f-preview.gif" />

<br />