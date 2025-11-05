---
title: Configuring a Screen with the Screen Composer
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
> _Click on the dropdown containing the Screen name is the top bar, then select the fallback presentation / Screen to associate with this new Screen_
> 
> [block:image]{"images":[{"image":["https://files.readme.io/d8cf0e26adc327d6fa783373615fada64494f8e3c74a2c73a31b1c0da7fea4d0-ezgif-2-1dbd824932.gif","",""],"align":"center","border":true}]}[/block]
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

[block:html]
{
  "html": "<div style=\"position: relative; padding-bottom: 56.25%; height: 0;\"><iframe src=\"https://www.loom.com/embed/fb7581e87de0480981df20143e2631c1?sid=5cb8fd65-c039-4658-84a2-06b72848dcd4\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen style=\"position: absolute; top: 0; left: 0; width: 100%; height: 100%;\"></iframe></div>"
}
[/block]


<br />

# General process for creating a Screen

The Screen Composer can be accessed by clicking on the button `+ Composer` in the [Screens section of your Purchasely Console](https://console.purchasely.io/screens)

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/9b2ab461acaf918351a063f973032fdfc2ff42e0b7a539d2698ff12bbbd9fe7c-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

## 1. Paywalls only: define the Offerings

If the Screen configured is a Paywall or Subscription Landing Page, start by defining which Offerings available on the Screen.

An Offering includes:

- `reference`: a unique identifier (letters, numbers, \_ or -)
- `Plan`: choose one from the Plans configured in the Purchasely Console
- (Optional) `Promotional Offer`: choose one from the Promotional Offers configured in the Purchasely Console

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/b531e1b260bcfbdace0274df4f536de96addf3685124856e9ac816a61e3b1f5c-offerings.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


### Wrapping an Introductory Offer and a Promotional Offer in one unified Paywall

With Offerings, you can wrap an Introductory Offer and fallback on a Promotional Offer in one unified Paywall setup:

- The Offering is linked to a Plan that includes a Free Trial (via Intro Offer) and an Promotional Offer that mirrors it.

- The SDK will automatically evaluate and apply the appropriate offer:  
  ➕ If the user is eligible for the Intro Offer, it is applied.  
  ➖ If the user is not eligible, the Promotional Offer will be applied instead.

### Default Offering

One of the Offerings must be defined as the default one.

- For components which are not specifically mapped with a Plan (like a carousel, or a bulleted list), if Tags are used within the associated Text elements, the SDK will compute the Introductory Offer eligibility based on the default Plan.: 
- It will display the [Offer text](offer-mode) if the user is eligible to the Introductory Offer of the default Plan, and the Regular Offer otherwise.

<br />

## 2. Choose the layout

Select the desired layout among the ones available

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/0df654dc46cb477d91102a1954974c11fb4ba92c21309b819088085200fe3f37-layout.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


See [Layouts](#layouts) for more details

<br />

### 3. Select the components

Add the desired components by clicking on the button "Add components" and drag & dropping the component in the Screen structure and reorder them the way you want

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/b88a907e6c857b7483150a4cb337c673446b5b85beb9de227bcebe4679627959-drag__drop.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

## 4. Configure each component

Configure each component individually and integrate your copy, contents and branding (including custom fonts)

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/e5097860677bef53ec7e3047cd09ea8c90f1db820d452c1c398188ed83e55d15-configure.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

## 5. Configure your Screen in dark mode (optional)

Each color (font, border, background etc...), image, video or animation can be set for dark mode

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/2e3ef6980123c3f3d74fa9ed8dd508586566ef3e9d855a53675b99867ef4e907-dark_mode.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


## 6. Localize your Screen (if necessary)

Localize every text of your Screen

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/a9a1612c8d66419413bbfa15faaa468f35c0e3a63b22d58008fb370e26120d9c-localize.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

## 7. Configure the Close button look and feel and behavior

[Close button configuration details are provided here](composer-close-button)

Then hit Publish and you're all set!

# Layouts

Layouts define the way the Purchasely SDK will organise and display the components on the device screen.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/4a2413960881a5d07b29fe6570c1e9f4f38b3a1d5b72bbfe165a61ea1b5dbc8e-Screen_Recording_2025-07-24_at_19.37.53.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


9 layouts are available (and we will continue adding new ones regularly):

- **Fill height**: with this layout, the Screen is not scrollable even if it exceeds the height of the device screen and all the components must fit in the device screen. If necessary, the Purchasely SDK will expand one component to fill the whole device screen or shrink it.  The component to be expanded can be configured by right clicking on it in the Screen structure and selecting "Expand to fill"
- **Fill height multi-groups**: this layout allows you to organize components in several groups. It can be particularly useful for Survey Screens. The same expansion / shrinking rules apply with this layout.
- **Scroll**: this layout will stack the components from the top of of the device screen. No component will be expanded if they don't fill the height of the device screen and a scroll bar will be displayed if they exceed the height of the screen.
- **Scroll multi group**: This layout allows you to organize components in several groups. It can be particularly useful for Survey Screens. this layout will stack the components from the top of the device screen. No component will be expanded if they don't fill the height of the device screen and a scroll bar will be displayed if they exceed the height of the screen.
- **Sticky button**: this layout features 2 different "surfaces" to which components can be associated. The **Body** is scrollable and the **Bottom bar** remains sticky at the bottom of the device screen. This layout is perfect for long paywalls to make the Call To Action always visible on the device even when the user scrolls down.
- **Tabs**: this layout organizes components across multiple tabs or sections, providing a clear structure for displaying multi-tier subscription offers. This layout is particularly effective for showcasing the features and benefits associated with each subscription plan, helping users compare and select the option that best suits their needs.
- **Segmented controls**: this layout offers a similar organizational structure as Tabs but presents the sections in the form of horizontal segmented controls. This layout is ideal for a streamlined and compact interface, ensuring users can quickly switch between subscription tiers or options with minimal effort.
- **Carousel**: This layout offers up to 20 slides that can be used for onboarding, surveys, or quizzes. The component added to this layout can be expanded by right-clicking on it in the Screen Structure and selecting 'Expand to fill'.
- **Switch**: This layout works along with switch component. It offers a way where you can: Enable free trials for subscription plans, Offer instalment payments on Android, letting users pay monthly instead of all at once, Save user preferences by linking the Switch to custom user attributes - perfect for: Newsletter opt-ins,Privacy settings,Terms & conditions acceptance. With more control over offers and settings, the Switch helps boost both conversion rates and user experience.

## Surfaces

A layout is composed of 1 or several _surfaces_ which are displayed in Bold in the Screen structure.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/98f170bd26e7e7f4ed72f3c8a3e043ecf4a820ffa7173e73924b58b5c2e11072-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Components can be dragged and dropped in the _surfaces_ and reassigned from one surface to another one. Within a surface they can be reordered.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/e6084fc32a1e0a94d3a590a0b13594a0487aab693f6382208e01c72d4602a7ff-assign_surfaces.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Components that haven't been assigned to any surface can be found in the **Unassigned** folder.

You can change the layout even after configuring the components, and reassign them to the different _surfaces_ available in the new layout. 

When changing layout, all the components are put in the Unassigned folder and you must reassign them one by one to the surfaces of the new.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/e49c059bc0ceeea9a7b093bf51d374f12658d43f5b4c0842eb74c6ef466ab927-change_layout.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


By clicking on a _surface_, you can change its properties, such as its background and the padding

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/776dd7ef75d5de760c0cbd4b235e11f55c4899ecc14a328ee5786c71466e1f94-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


# Padding and margin

Padding and margin can now be adjusted with the Screen Composer. It provides you with much more flexibility to tailor your design as you desire.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/d7ba88ef555399c6d5dedbeadcd0e46ea10c78ed918f1cd5e26891cc74511318-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


- **Padding** is the space inside a component, between its content and its border. It adds space around the content within the element. It can be defined for _surfaces_ and _components_.
- **Margin** is the space outside a component, separating it from other elements. It adds space between the component's border and the surrounding elements. It can be defined only for _components_.

![](https://files.readme.io/b74c4aaaf66f57e8fb1432d9603fae8de2d6bc47a9ff7d5280cd140acc89dd59-image.png)

Both padding and margin control spacing but in different contexts: padding is inside, margin is outside.

<br />

# Library of components

The Screen Composer features a comprehensive list of _components_ which can be customized in many different ways. Here is the list of components available (and we will continue adding new ones regularly):

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/2f20731a2130c3d5b32e0809d635857b0f462a5822bc069fcd89c364059816bb-Screen_Recording_2025-07-24_at_21.19.44_1.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

Here are the capabilities offered by each Component

- [Texts](texts)
- [Carousel](carousel)
- [Images](images)
- [Videos](videos-1)
- [Buttons](buttons)
- [Plan pickers vertical](plan-picker-vertical)
- [Plan pickers horizontal](plan-pickers-horizontal)
- [CTAs for Plan pickers](cta-plan-pickers)
- [Multiple Choice Questions](mcq)
- [CTAs for Multiple Choice Questions](mcq#5-configuring-the-cta-associated-to-the-mcq)
- [Bulleted list](bulleted-lists) 
- [Timeline vertical](timeline-vertical)(Blinkist component)
- [Carousel](carousel)
- [Footers](footer)
- [Countdowns](countdown)
- [FAQ](FAQ)
- [Reviews](reviews)
- [Table comparison](table-comparison)
- [Spacers - Separators - Dividers](https://docs.purchasely.com/docs/spacers)
- [Vertical Stack](https://docs.purchasely.com/docs/vertical-stack)

<br />

# Various features associated with the Screen composer

[Defining offer specific copy with the Offer mode](https://docs.purchasely.com/docs/offer-mode)

[Adapting Screens to different devices](https://docs.purchasely.com/docs/composer-adapting-screens-to-devices)

[Localizing your Screen](https://docs.purchasely.com/docs/composer-localization)

[Previewing your Screen on the device](https://docs.purchasely.com/docs/preview)

[Copy/pasting components across Screens](https://docs.purchasely.com/docs/copy-paste)

[Importing your custom fonts](composer-custom-fonts)

[Configuring the Color Palette](https://docs.purchasely.com/docs/color-palette)

[Managing the display mode](display-mode)

[Activating the safe area](safe-area)