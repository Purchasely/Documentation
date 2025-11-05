---
title: Stripe configuration
excerpt: Configuring Stripe with Purchasely
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
Configuration of Stripe with Purchase is performed in 4 steps

# I. Installing the Stripe App

Go to the Purchasely's app listing on [Stripe apps marketplace](https://marketplace.stripe.com/apps/purchasely)

<Image alt="Stripe app market place listing" align="center" border={true} src="https://files.readme.io/2d7320797b85d0456536dd4a303dd893a3de9ab56a33e863b7d233cd336b294b-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f616473253246394f42306866656a6f6839714e6c664c396.webp">
  Stripe app market place listing
</Image>

If you have more than one Stripe account (for each application) then connect the account you want to associate with the application.

> 🚧 One Stripe Account for One Purchasely Application
>
> A Stripe application combines a Stripe account with only one Purchasely Application. If your Stripe account works with more than one Purchasely Application, please contact our support team via Intercom.
>
> Read below on how to handle both Stripe "test" and "production" environments.

Click on install app.\
The list of authorizations required for the proper functioning of our application is then displayed.

<Image alt="Authorization validation" align="center" border={true} src="https://files.readme.io/89fb413034371dfec2dda3e490aed0a5881d78f19951c1c86b87c464b6b58ad2-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324661716d63664c6473385744665a4e624a6e5.webp">
  Authorization validation
</Image>

> 📘 Question?
>
> If you have a question about the use of an authorization, contact our support team via Intercom.

Validate the authorizations requested

<Image alt="Permission samples" align="center" border={true} src="https://files.readme.io/302f47eb88975820c1b4e7a831c3793dc08b2e8c4801ccf536cf37e608b3a4ca-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f616473253246445455547537656d576879586130556b4d71.png">
  Permission samples
</Image>

The installation is complete, you can proceed with the configuration.

<Image alt="Successful installation" align="center" border={true} src="https://files.readme.io/c3fec4dcd7f16991a9515c0d98ebfb72b674a3a0e30eedcfeb16784737a2a35e-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324642526e71644c486e7a7a425a3645666a534.webp">
  Successful installation
</Image>

# II. Configuration of the Stripe app

Once the Stripe Purchasely app is installed you need to configure it.\
Go to the Stripe console in **Settings > installed apps > Purchasely**.

<Image alt="Settings" align="center" border={true} src="https://files.readme.io/81ccb7f740946f73cfb2a11c63126a77761aa7e74264bce446e4904a78352a29-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f616473253246676f363035444f7a3449476155716a687045.png">
  Settings
</Image>

<Image alt="Settings > Installed apps" align="center" border={true} src="https://files.readme.io/6b97f65f745539c919c7de1f237f39c63292f048ce1a67ee05dafc9b7632e580-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f616473253246435279646b53697970494f49657a5173737.webp">
  Settings > Installed apps
</Image>

## Associate with Purchasely

Once on the app configuration you need to associate it with your Purchasely account and app. To do this, start by clicking on "SIGN IN".

<Image alt="Settings > installed apps > Purchasely" align="center" border={true} src="https://files.readme.io/ec97d4298e27c7b1a9efda0bd9f2ec09468ed39a2e5f9937501f6759c4839fee-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324635624a61315a4d587937686344696c324f3.webp">
  Settings > installed apps > Purchasely
</Image>

Select the Purchasely app you wish to link your Stripe account to.

Click on "NEXT".

> 📘 Configuration for Sandbox and Production
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

<Image alt="App Selection" align="center" border={true} src="https://files.readme.io/cf3641f59a32afbcf0871690886c1fd908a2b3a4aa3dfeaacc0bf1df63540509-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f6164732532464158773032777a486e5a5856713077344a4.webp">
  App Selection
</Image>

<Image alt="App Selected" align="center" border={true} src="https://files.readme.io/d15dc38f7a95d227b04132a663875bdf9301ce5eaf32deb0838b900e2b17fe68-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324674436b65633634543065546933436a36743.webp">
  App Selected
</Image>

## Confirm Stripe app link with your mobile application

Once you have selected the application, you will be redirected to Stripe to finalise the configuration by clicking on "CONFIRM".

<Image alt="Confirmation screen" align="center" border={true} src="https://files.readme.io/775e8876a538618377f96e4db6448bfee4de0b45142c03efe1b4c42a40df2936-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f6164732532466c6b4e6d37414d50316f46536d46646f716.webp">
  Confirmation screen
</Image>

The app will appear as below when properly configured in Purchasely and Stripe.

<Image alt="Purchasely App Settings" align="center" border={true} src="https://files.readme.io/dde0e8a6e330842b03c998ecaeb8a6c4dab374f0691e24e13ca601f0b38b722a-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324678464264694b70397250646364634253427.webp">
  Purchasely App Settings
</Image>

<Image alt="Stripe App Settings - Configured" align="center" border={true} src="https://files.readme.io/2baa62347e9e667c2c2e485952f390e526a94cc8bc7abd0e0107d0e863207a98-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324645637a6e49314e64436f374854303850515.webp">
  Stripe App Settings - Configured
</Image>

# III. Configuration of plans

In order for Purchasely to associate Stripe products, they must be defined in the plans. Also you must associate each **Pricing** Stripe to a Purchasely Plan otherwise the purchase will not be taken into account by Purchasely.

From the Stripe console, copy the API ID (price) ...

<Image align="center" className="border" border={true} src="https://files.readme.io/707172e572ab0303d6bcbd9473e414c30e281aa9b8e222d598613f18a841246f-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f6164732532466f564b744b756c7a6949486558446c6e486.webp" />

Then paste this ID into the corresponding plan:

<Image align="center" className="border" border={true} src="https://files.readme.io/22ece29bcb9c011a219d5c959e784febdcb3ac235e7edef1d6bab0a6eaee22d4-image_2_1.png" />

Purchasely allows you to associate more than one Stripe Price to one given Purchasely plan, to handle cases where there exists several Stripe Prices tied to the same "plan" but with a different currency.

> 🚧 Different Stripe Price
>
> Do not associate more than one Stripe Price to one given Purchasely plan if the Stripe Prices have different periodicity, or different level of entitlement.
>
> For such use cases, create another plan.

# IV. Associating Stripe subscriptions to Purchasely

This last step allows Purchasely to retrieve and associate a purchase with a user.

[The principle is the same as for the migration of an existing subscriber](https://docs.purchasely.com/faq/migration-guides/migrate-from-an-existing-setup#2.-send-us-every-new-subscription-created-on-you-side-with-a-call-on-our-api)

To send us this information, simply call our API and provide it with

* `stripe_object_id`: the Stripe subscription ID
* `stripe_price_id`: the Stripe Price Id for this subscription (ON STRIPE)
* `user_id`: the user\_id associated with the purchase, the same as you enter in [the SDK during configuration.](https://docs.purchasely.com/quick-start-1/sdk-configuration/config-appendices/set-user-id)
* `stripe_object_type`: the type of Stripe object sent, currently we only accept `subscription`

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

> 👍 Real-Time Events
>
> Purchasely relies on Stripe [webhooks](https://docs.stripe.com/webhooks) to get the information about a known subscription in real time. This information is processed by our system to create Purchasely [events](server-events) and then sent to your webhook, if [configured](backend-entitlements#configuring-the-webhook).

> 📘 Export
>
> You can export a list of your Stripe's subscriptions with their associated prices from your Stripe Stripe dashboard.\
> On Stripe go under:\
> Billing > Subscription > Export\
> Select: Custom and keep only "ID" and "Plan"

<Image align="center" className="border" border={true} src="https://files.readme.io/766576c779b80ccf88205fd8644984d6b00edf41d07f839bd6d4e8b90a206bbb-68747470733a2f2f66696c65732e676974626f6f6b2e636f6d2f76302f622f676974626f6f6b2d782d70726f642e61707073706f742e636f6d2f6f2f737061636573253246476755644f7a68716130377568376e4232695a4125324675706c6f61647325324653467369424c4a316545427678674d65513.webp" />
