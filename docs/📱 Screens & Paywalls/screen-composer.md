---
title: Configuring a Screen with the Screen Composer (NEW)
excerpt: This section provides a complete overview of the Screen Composer
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# General overview

Purchasely Screen Composer provides an intuitive and flexible way to design custom screens for your app. 

The module integrates a comprehensive library of pre-built components, that users can simply drag and drop into their screen structure and organize in different layouts to best fit their needs.

Screens can be created either from a white slate or from a pre-configured template that can be customized as desired, and on which components can be added / removed or reordered.

Once components are placed, they can be easily reordered and individually configured to match the desired design and branding. The layout can be adjusted at any time, providing full flexibility to adapt your design as your needs evolve. This ensures a seamless and dynamic experience in creating personalized app screens.

<br />

> 🚧 Retro-compatibility considerations and fallback Screen for old versions of the SDK
>
> The Screen composer **requires the version 5.0.0 of the Purchasely SDK and above**. 
>
> This can be a problem as long as old versions of the app, integrating previous versions of the SDK (\< 5.0.0) are in the air.
>
> Be reassured, when creating a new Screen with the Screen composer, you can select a "legacy Screen" (built with the legacy Paywall Builder) and associate it with the new Screen.
>
> *Click on the dropdown containing the Screen name is the top bar, then select the fallback presentation / Screen to associate with this new Screen*
>
> <Image align="center" className="border" border={true} src="https://files.readme.io/d8cf0e26adc327d6fa783373615fada64494f8e3c74a2c73a31b1c0da7fea4d0-ezgif-2-1dbd824932.gif" />
>
> If an old version of the SDK (\< 5.0.0) tries to fetch the new Screen (built from the Screen composer) from a Placement, the fallback screen, compatible with the old version of the SDK, will be retrieved instead.
>
> ## Running A/B tests with new Screen
>
> You can include new Screens built with the Screen composer in A/B tests. In this case, old version of the SDK (5.0.0) will fallback on the legacy Screen associated to the new one and be excluded from the A/B test.
>
> If you run an A/B test between a legacy Screen and a new Screen, bare in mind that the balance (e.g.: 5°0-50 split) between the two variants might be affected by this fallback and exclusion rule: as old SDKs cannot display the new Screen and are therefore excluded from the A/B test, the new Screen variant is likely to have less unique viewers.

<br />

> 📘 Is this possible to migrate legacy Screen in the new Screen composer?
>
> Unfortunately it is not possible to edit your old Screens and Paywalls built with the legacy Screen Builder in the new Screen Composer. You will have to replicate them.

# Product Tour

<HTMLBlock>{`
<div style="position: relative; padding-bottom: 56.25%; height: 0;"><iframe src="https://www.loom.com/embed/fb7581e87de0480981df20143e2631c1?sid=5cb8fd65-c039-4658-84a2-06b72848dcd4" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></iframe></div>
`}</HTMLBlock>

<br />

# General process for creating a Screen

The Screen Composer can be accessed by clicking on the button `+ Composer` in the [Screens section of your Purchasely Console](https://console.purchasely.io/screens)

<Image align="center" className="border" border={true} src="https://files.readme.io/12fad2d83b20288c7e004b890f94598a6c2408657b74479b9da7a38c780aa838-image.png" />

### 1. Paywalls only: define the Plans

If the Screen configured is a Paywall, start by defining which Plans will be available on the Screen

<Image align="center" className="border" border={true} src="https://files.readme.io/947113816c65d4f86c06f4389c49bf586f5005539e5bd2ee27fe58761237f911-manage_plans.gif" />

One of the Plans must be defined as the default Plan.

For components which are not specifically mapped with a Plan (like a carousel, or a bulleted list), if Tags are used within the associated Text elements, the SDK will compute the Introductory Offer eligibility based on the default Plan.: 

* It will display the [Offer text](texts#regular-text-vs-offer-text) if the user is eligible to the Introductory Offer of the default Plan, and the Regular Offer otherwise.

<br />

### 2. Choose the layout

Select the desired layout among the ones available

<Image align="center" src="https://files.readme.io/0df654dc46cb477d91102a1954974c11fb4ba92c21309b819088085200fe3f37-layout.gif" />

See [Layouts](#layouts) for more details

<br />

### 3. Select the components

Add the desired components by clicking on the button "Add components" and drag & dropping the component in the Screen structure and reorder them the way you want

<Image align="center" className="border" border={true} src="https://files.readme.io/b88a907e6c857b7483150a4cb337c673446b5b85beb9de227bcebe4679627959-drag__drop.gif" />

<br />

### 4. Configure each component

Configure each component individually and integrate your copy, contents and branding (including custom fonts)

<Image align="center" className="border" border={true} src="https://files.readme.io/e5097860677bef53ec7e3047cd09ea8c90f1db820d452c1c398188ed83e55d15-configure.gif" />

<br />

### 5. Configure your Screen in dark mode (optional)

Each color (font, border, background etc...), image, video or animation can be set for dark mode

<Image align="center" className="border" border={true} src="https://files.readme.io/2e3ef6980123c3f3d74fa9ed8dd508586566ef3e9d855a53675b99867ef4e907-dark_mode.gif" />

### 6. Localize your Screen (if necessary)

Localize every text of your Screen

<Image align="center" className="border" border={true} src="https://files.readme.io/a9a1612c8d66419413bbfa15faaa468f35c0e3a63b22d58008fb370e26120d9c-localize.gif" />

<br />

### 7. Configure the Close button look and feel and behavior

[Close button configuration details are provided here](composer-close-button)

<br />

Then hit Publish and you're all set!

<br />

# Layouts

Layouts define the way the Purchasely SDK will organise and display the components on the device screen.

<Image align="center" src="https://files.readme.io/02b952a63a6563a3a231a65b4e504ffea90ec2d130d3542c64ee6985b1496e1e-layout2.gif" />

3 layouts are available for now:

* **Fill height**: all the components of the Screen must fit in the device screen. If necessary, the Purchasely will expand one component to fill the whole device screen or shrink it. With this layout, the Screen is not scrollable even if it exceeds the height of the device screen.\
  See Layout fill height - expand to fill a component for more details
* **Scroll**: this layout will stack the components from the top of of the device screen. No component will be expanded if they don't fill the height of the device screen and a scroll bar will be displayed if they exceed the height of the screen.
* **Sticky bottom**: this layout features 2 different "surfaces" to which components can be associated. The **Body** is scrollable and the **Sticky bottom** remains sticky at the bottom of the device screen. This layout is perfect for long paywalls to make the Call To Action always visible on the device even when the user scrolls down.

New layouts will be made available in the next few weeks/months.

## Surfaces

A layout is composed of 1 or several *surfaces* which are displayed in Bold in the Screen structure.

<Image align="center" className="border" border={true} src="https://files.readme.io/98f170bd26e7e7f4ed72f3c8a3e043ecf4a820ffa7173e73924b58b5c2e11072-image.png" />

Components can be dragged and dropped in the *surfaces* and reassigned from one surface to another one. Within a surface they can be reordered.

<Image align="center" className="border" border={true} src="https://files.readme.io/e6084fc32a1e0a94d3a590a0b13594a0487aab693f6382208e01c72d4602a7ff-assign_surfaces.gif" />

Components that haven't been assigned to any surface can be found in the **Unassigned** folder.

You can change the layout even after configuring the components, and reassign them to the different *surfaces* available in the new layout. 

When changing layout, all the components are put in the Unassigned folder and you must reassign them one by one to the surfaces of the new.

<Image align="center" className="border" border={true} src="https://files.readme.io/e49c059bc0ceeea9a7b093bf51d374f12658d43f5b4c0842eb74c6ef466ab927-change_layout.gif" />

By clicking on a *surface*, you can change its properties, such as its background and the padding

<Image align="center" className="border" border={true} src="https://files.readme.io/776dd7ef75d5de760c0cbd4b235e11f55c4899ecc14a328ee5786c71466e1f94-image.png" />

<br />

<br />

# Padding and margin

Padding and margin can now be adjusted with the Screen Composer. It provides you with much more flexibility to tailor your design as you desire.

<Image align="center" className="border" border={true} src="https://files.readme.io/d7ba88ef555399c6d5dedbeadcd0e46ea10c78ed918f1cd5e26891cc74511318-image.png" />

* **Padding** is the space inside a component, between its content and its border. It adds space around the content within the element. It can be defined for *surfaces* and *components*.
* **Margin** is the space outside a component, separating it from other elements. It adds space between the component's border and the surrounding elements. It can be defined only for *components*.

![](https://files.readme.io/b74c4aaaf66f57e8fb1432d9603fae8de2d6bc47a9ff7d5280cd140acc89dd59-image.png)

Both padding and margin control spacing but in different contexts: padding is inside, margin is outside.

<br />

# Library of components

The Screen Composer features a comprehensive list of *components* which can be customized in many different ways. Here is the list of components available today:

New components will be integrated in the next weeks and months.

<Image align="center" className="border" border={true} src="https://files.readme.io/1a01017c47eec06b2bde397ba294763b868ff9c9683423dd8274d33ac6e57971-image.png" />

<br />

Here are the capabilities offered by each Component

* [Texts](texts)
* [Caoursel](carousel)
* [Images](images)
* [Videos](videos-1)
* [Buttons](buttons)
* [Plan pickers vertical](plan-picker-vertical)
* [Plan pickers horizontal](plan-pickers-horizontal)
* [CTAs for Plan pickers](cta-plan-pickers)
* [Multiple Choice Questions](mcq)
* [CTAs for Multiple Choice Questions](mcq#5-configuring-the-cta-associated-to-the-mcq)
* [Bulleted list](bulleted-lists) 
* [Timeline vertical](timeline-vertical)(Blinkist component)
* [Carousel](carousel)
* [Footers](footer)

<br />

# Various features associated with the Screen composer

Adapting Screens to different devices

Localizing your Screen

Previewing your Screen on the device

[Importing your custom fonts](composer-custom-fonts)
