---
title: Stripe configuration
excerpt: Configuring Stripe with Purchasely - only for subscription apps
deprecated: false
hidden: false
metadata:
  title: ''
  description: >-
    The document outlines a four-step process for configuring Stripe with
    Purchasely, including installing the Stripe app, configuring it within
    Stripe settings, associating Stripe products with Purchasely plans, and
    linking Stripe subscriptions to Purchasely using webhooks and API calls.
  robots: index
next:
  description: ''
---
If your subscription app manages web subscriptions with Stripe, you can plug Stripe with Purchasely. The configuration of Stripe with Purchase is performed in 4 steps

# I. Installing the Stripe App

Go to the Purchasely's app listing on [Stripe apps marketplace](https://marketplace.stripe.com/apps/purchasely)

<Image align="center" alt="Stripe app market place listing" border={true} caption="Stripe app market place listing" src="https://files.readme.io/2d7320797b85d0456536dd4a303dd893a3de9ab56a33e863b7d233cd336b294b-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f616473253246394f42306866656a6f6839714e6c664c396.webp" />

If you have more than one Stripe account (for each application) then connect the account you want to associate with the application.

> 🚧 One Stripe Account for One Purchasely Application
>
> A Stripe application combines a Stripe account with only one Purchasely Application. If your Stripe account works with more than one Purchasely Application, please contact our support team via Intercom.
>
> Read below on how to handle Stripe "test", "sandbox", and "production" environments.

Click on install app.  
The list of authorizations required for the proper functioning of our application is then displayed.

<Image align="center" alt="Authorization validation" border={true} caption="Authorization validation" src="https://files.readme.io/89fb413034371dfec2dda3e490aed0a5881d78f19951c1c86b87c464b6b58ad2-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324661716d63664c6473385744665a4e624a6e5.webp" />

> 📘 Question?
>
> If you have a question about the use of an authorization, contact our support team via Intercom.

Validate the authorizations requested

<Image align="center" alt="Permission samples" border={true} caption="Permission samples" src="https://files.readme.io/302f47eb88975820c1b4e7a831c3793dc08b2e8c4801ccf536cf37e608b3a4ca-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f616473253246445455547537656d576879586130556b4d71.png" />

The installation is complete, you can proceed with the configuration.

<Image align="center" alt="Successful installation" border={true} caption="Successful installation" src="https://files.readme.io/c3fec4dcd7f16991a9515c0d98ebfb72b674a3a0e30eedcfeb16784737a2a35e-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324642526e71644c486e7a7a425a3645666a534.webp" />

# II. Configuration of the Stripe app

Once the Stripe Purchasely app is installed you need to configure it.  
Go to the Stripe console in **Settings > installed apps > Purchasely**.

<Image align="center" alt="Settings" border={true} caption="Settings" src="https://files.readme.io/81ccb7f740946f73cfb2a11c63126a77761aa7e74264bce446e4904a78352a29-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f616473253246676f363035444f7a3449476155716a687045.png" />

<Image align="center" alt="Settings > Installed apps" border={true} caption="Settings > Installed apps" src="https://files.readme.io/6b97f65f745539c919c7de1f237f39c63292f048ce1a67ee05dafc9b7632e580-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f616473253246435279646b53697970494f49657a5173737.webp" />

## Associate with Purchasely

Once on the app configuration you need to associate it with your Purchasely account and app. To do this, start by clicking on "SIGN IN".

<Image align="center" alt="Settings > installed apps > Purchasely" border={true} caption="Settings > installed apps > Purchasely" src="https://files.readme.io/ec97d4298e27c7b1a9efda0bd9f2ec09468ed39a2e5f9937501f6759c4839fee-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324635624a61315a4d587937686344696c324f3.webp" />

Select the Purchasely app you wish to link your Stripe account to.

Click on "NEXT".

> 📘 Configuration for Test and Production
>
> Once the app is installed, it needs to be configured both in the "test" and "production" Stripe environments for purchases to be tracked in those environments accordingly.
>
> The following configurations are supported :
>
> * 2 Purchasely applications
>   * My Purchasely App (staging) \<-> Stripe Account (test mode)
>   * My Purchasely App (production) \<-> Stripe Account (production mode)
> * 1 Purchasely application
>   * My Purchasely App \<-> Stripe Account (test + production mode)

> 📘 Sandbox support
>
> Since version 0.0.22 of the Purchasely Stripe App, you can also install Purchasely in a Stripe [sandbox](https://docs.stripe.com/sandboxes) environment.
>
> The installation flow is identical to test and production modes: install Purchasely from the marketplace while your Stripe dashboard is switched to your sandbox, then follow the setup wizard. Purchasely automatically detects that you are in a sandbox and links the account accordingly.
>
> > 🚧 Switching from test mode to sandbox on the same Purchasely application
> >
> > Sandbox and test mode are **separate Stripe environments** with distinct account identifiers. A Purchasely application can only be linked to one of them at a time.
> >
> > If your Purchasely application is already linked to a Stripe account in test mode and you want to switch to sandbox, you must first **unlink the test mode connection** before installing the app in your sandbox:
> >
> > 1. In your Stripe dashboard, open the Purchasely app settings in test mode and click "Disconnect" (or uninstall the app).
> > 2. Switch to your sandbox in the Stripe dashboard.
> > 3. Install the Purchasely app from the marketplace and follow the setup wizard.
> >
> > Your historical test mode data (subscriptions, receipts) remains attached to the previous test mode link but will no longer receive new events.

<Image align="center" alt="App Selection" border={true} caption="App Selection" src="https://files.readme.io/cf3641f59a32afbcf0871690886c1fd908a2b3a4aa3dfeaacc0bf1df63540509-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f6164732532464158773032777a486e5a5856713077344a4.webp" />

<Image align="center" alt="App Selected" border={true} caption="App Selected" src="https://files.readme.io/d15dc38f7a95d227b04132a663875bdf9301ce5eaf32deb0838b900e2b17fe68-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324674436b65633634543065546933436a36743.webp" />

## Confirm Stripe app link with your mobile application

Once you have selected the application, you will be redirected to Stripe to finalise the configuration by clicking on "CONFIRM".

<Image align="center" alt="Confirmation screen" border={true} caption="Confirmation screen" src="https://files.readme.io/775e8876a538618377f96e4db6448bfee4de0b45142c03efe1b4c42a40df2936-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f6164732532466c6b4e6d37414d50316f46536d46646f716.webp" />

The app will appear as below when properly configured in Purchasely and Stripe.

<Image align="center" alt="Purchasely App Settings" border={true} caption="Purchasely App Settings" src="https://files.readme.io/dde0e8a6e330842b03c998ecaeb8a6c4dab374f0691e24e13ca601f0b38b722a-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324678464264694b70397250646364634253427.webp" />

<Image align="center" alt="Stripe App Settings - Configured" border={true} caption="Stripe App Settings - Configured" src="https://files.readme.io/2baa62347e9e667c2c2e485952f390e526a94cc8bc7abd0e0107d0e863207a98-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324645637a6e49314e64436f374854303850515.webp" />

# III. Configuration of plans

In order for Purchasely to associate Stripe products, they must be defined in the plans. Also you must associate each **Pricing** Stripe to a Purchasely Plan otherwise the purchase will not be taken into account by Purchasely.

From the Stripe console, copy the API ID (price) ...

<Image align="center" border={true} src="https://files.readme.io/707172e572ab0303d6bcbd9473e414c30e281aa9b8e222d598613f18a841246f-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f6164732532466f564b744b756c7a6949486558446c6e486.webp" className="border" />

Then paste this ID into the corresponding plan:

<Image align="center" border={true} src="https://files.readme.io/22ece29bcb9c011a219d5c959e784febdcb3ac235e7edef1d6bab0a6eaee22d4-image_2_1.png" className="border" />

Purchasely allows you to associate more than one Stripe Price to one given Purchasely plan, to handle cases where there exists several Stripe Prices tied to the same "plan" but with a different currency.

> 🚧 Different Stripe Price
>
> Do not associate more than one Stripe Price to one given Purchasely plan if the Stripe Prices have different periodicity, or different level of entitlement.
>
> For such use cases, create another plan.

# IV. Associating Stripe subscriptions to Purchasely

This last step allows Purchasely to retrieve and associate a purchase with a user.

> ❗️ This step is mandatory, otherwise we won't track the subscription
>
> We need to know the association between the Stripe Subscription and your User ID
>
> Otherwise we would track the subscription but wouldn't know to which user in your app to associate it with

[The principle is the same as for the migration of an existing subscriber](https://docs.purchasely.com/faq/migration-guides/migrate-from-an-existing-setup#2.-send-us-every-new-subscription-created-on-you-side-with-a-call-on-our-api)

<APIreceiptStripe />

```curl
curl \
  --request POST \
  -i \
  -H "Content-Type: application/json" \
  -H "X-API-KEY:{{YOUR_API_KEY}}" \
  -H "X-PLATFORM-TYPE:STRIPE" \
  --data '{"stripe_object_id":"{{STRIPE_SUBSCRIPTION_ID}}","stripe_price_id":"{{STRIPE_PRICE_ID_FOR_THIS_SUBSCRIPTION}}", "user_id":"{{SAME_ID_AS_IN_SDK_CONFIGURATION}}", "stripe_object_type":"subscription"}' \
  https://s2s.purchasely.io/receipts
```

Example request:

```curl
curl \
  --request POST \
  -i \
  -H "Content-Type: application/json" \
  -H "X-API-KEY:AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE" \
  -H "X-PLATFORM-TYPE:STRIPE" \
  --data '{"stripe_object_id":"sub_1MluxqJaEiB9UwXB34gmtzCB","stripe_price_id":"price_1MbKJHJaEiB9UwXBPt0fFq4O", "user_id":"jdo-cus_Msq9YfCiFkFzVx", "stripe_object_type":"subscription"}' \
  https://s2s.purchasely.io/receipts
```

> 🚧 Cross-platform subscriptions are not deduplicated
>
> Sending a Stripe receipt for a `user_id` that already has an active App Store / Play Store subscription does **not** deactivate the existing subscription. Both will coexist as active in Purchasely (each emitting its own events), and the user will be billed by each store.
>
> If you want to prevent this, check the user's current subscription status (via [webhooks](server-events) or the SDK) before triggering a Stripe checkout, and ask the user to cancel their existing store subscription first.

## Passing integration attributes (optional)

You can include `integration_*` fields in the JSON body so that Purchasely associates the subscriber with your analytics and engagement platforms (Amplitude, Mixpanel, Airship, Adjust, etc.). This lets those platforms receive subscription lifecycle events automatically.

```curl
curl \
  --request POST \
  -i \
  -H "Content-Type: application/json" \
  -H "X-API-KEY:{{YOUR_API_KEY}}" \
  -H "X-PLATFORM-TYPE:STRIPE" \
  --data '{
    "stripe_object_id":"sub_1MluxqJaEiB9UwXB34gmtzCB",
    "stripe_price_id":"price_1MbKJHJaEiB9UwXBPt0fFq4O",
    "user_id":"jdo-cus_Msq9YfCiFkFzVx",
    "stripe_object_type":"subscription",
    "integration_amplitude_user_id":"amp-12345",
    "integration_adjust_id":"adj-67890",
    "integration_mixpanel_distinct_id":"mx-abcde"
  }' \
  https://s2s.purchasely.io/receipts
```

> All fields are optional. Include only the ones for the platforms you use.

| Platform | Field(s) |
|---|---|
| Adjust | `integration_adjust_id` |
| Airship | `integration_airship_channel_id`, `integration_airship_user_id` |
| Amplitude | `integration_amplitude_user_id`, `integration_amplitude_device_id`, `integration_amplitude_session_id` |
| Appsflyer | `integration_appsflyer_id` |
| AT Internet | `integration_at_internet_id_client` |
| Batch | `integration_batch_installation_id`, `integration_batch_custom_user_id` |
| Branch | `integration_branch_user_developer_identity` |
| CleverTap | `integration_clevertap_id` |
| Customer.io | `integration_customerio_user_id`, `integration_customerio_user_email` |
| Firebase / Google Analytics | `integration_firebase_app_instance_id` |
| Iterable | `integration_iterable_user_email`, `integration_iterable_user_id` |
| Mixpanel | `integration_mixpanel_distinct_id` |
| MoEngage | `integration_moengage_unique_id` |
| mParticle | `integration_mparticle_user_id` |
| OneSignal | `integration_one_signal_player_id`, `integration_one_signal_user_id`, `integration_one_signal_external_id`, `integration_one_signal_external_user_id` |
| Sendinblue (Brevo) | `integration_sendinblue_user_email` |

> 👍 Real-Time Events
>
> Purchasely relies on Stripe [webhooks](https://docs.stripe.com/webhooks) to get the information about a known subscription in real time. This information is processed by our system to create Purchasely [events](server-events) and then sent to your webhook, if [configured](backend-entitlements#configuring-the-webhook).

> 📘 Export
>
> You can export a list of your Stripe's subscriptions with their associated prices from your Stripe Stripe dashboard.  
> On Stripe go under:  
> Billing > Subscription > Export  
> Select: Custom and keep only "ID" and "Plan"

<Image align="center" border={true} src="https://files.readme.io/766576c779b80ccf88205fd8644984d6b00edf41d07f839bd6d4e8b90a206bbb-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324653467369424c4a316545427678674d65513.webp" className="border" />
