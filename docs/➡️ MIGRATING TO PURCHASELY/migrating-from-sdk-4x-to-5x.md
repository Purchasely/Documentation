---
title: Migrating from SDK 4.X to 5.X
excerpt: >-
  This page provides an overview on everything you need to know to migrate from
  SDK v4 to v5
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Version 5.0 is a major update of the Purchasely SDK as it introduces support for the new [Screen Composer](screen-composer), which provides an intuitive and flexible way to design custom screens for your app. 

Here is everything you need to know about the upgrade from SDK v4.X to v5.

![](https://files.readme.io/8ece2df7213adc7537f68cf664ce919e39b2c9f53f4013a9e653dcfa00005cfd-image.png)

## What are the main differences between the Paywall Builder and the Screen Composer?

The legacy **Paywall Builder** was mainly meant to create paywalls. It was based on a system of Templates and was limited regarding the customization capabilities. Here is a summary of the capabilities

<br />

[block:parameters]
{
  "data": {
    "h-0": "",
    "h-1": "Paywall Builder  \n(legacy)",
    "h-2": "Screen Composer  \n(new)",
    "0-0": "Type",
    "0-1": "**Template based**  \n=> less flexible",
    "0-2": "**Components based**  \n=> much more flexible and [new components](https://docs.purchasely.com/docs/screen-composer#library-of-components) will be regularly added.",
    "1-0": "Type of Screens",
    "1-1": "**Mainly paywalls**  \nlimited for other types of Screens. No surveys",
    "1-2": "Any type of Screens including [Surveys](https://docs.purchasely.com/docs/mcq).",
    "2-0": "Flexibility to add and remove components",
    "2-1": "❌",
    "2-2": "✅  \nSimply drag & drop them from the library of components into your Screen",
    "3-0": "Change layout",
    "3-1": "❌",
    "3-2": "✅  \nChange the layout any time even after configuring the components",
    "4-0": "Reorder components",
    "4-1": "❌",
    "4-2": "✅  \nDrag & drop components within the Screen structure to change their order",
    "5-0": "Adjust margin and padding",
    "5-1": "❌",
    "5-2": "✅  \nAdjust the padding & margin of every surface, component or text element",
    "6-0": "Text elements within a component",
    "6-1": "**Limited to 2 **  \nonly a title and a subtitle are available",
    "6-2": "**Flexible**  \nText elements can be added or removed",
    "7-0": "Rich text within a text element",
    "7-1": "❌",
    "7-2": "**Compatible with markdown**  \nItalic, Bold, Strikethrough and links",
    "8-0": "Copy & past of components from one Screen to the other",
    "8-1": "❌",
    "8-2": "✅  \nRight click on an individual component to copy it or on a surface to copy all the components it contains.  \nThen simply paste it into another Screen or surface"
  },
  "cols": 3,
  "rows": 9,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


<br />

## Is the SDK v5 able to display my existing Paywalls built with the legacy Paywall Builder?

**YES.**

The SDK v5 is fully compatible with Paywalls built using the [Legacy Paywall Builder](configuring-screens) and can display them.  
=> This means you do not need to migrate or replicate your legacy Paywalls in the Screen Composer, they will still be displayed properly. 

- You can continue building Paywalls with the legacy Screen Builder until its official deprecation which will happen on March 30th 2025.
- Paywalls built with the Screen Builder will remain modifiable even after its deprecation, but from April 1st 2025 onwards, it will not be possible to create new Paywalls with the legacy Paywall Builder.
- Given the additional capabilities brought by the Screen Composer, we strongly encourage you to start using it ASAP. We are sure you will just love it.

> 🤔 Not convinced yet?
> 
> Take the short Product Tour to get an overview of the possibilities offered by the new Screen Composer
> 
> [block:html]{"html":"<div style=\"position: relative; padding-bottom: 56.25%; height: 0;\"><iframe src=\"https://www.loom.com/embed/fb7581e87de0480981df20143e2631c1?sid=5cb8fd65-c039-4658-84a2-06b72848dcd4\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen style=\"position: absolute; top: 0; left: 0; width: 100%; height: 100%;\"></iframe></div>"}[/block]

> 🚧 Check thoroughly your legacy Screens during the QA phase
> 
> The major modification brought to the SDK v5 concerns the native rendering engine embedded in the SDK. 
> 
> When integrating the new version of the SDK we invite you to be vigilant to how your legacy Paywalls get displayed, by checking them on a Staging / Test Flight / Firebase Tester app before releasing it into production.
> 
> In case you notice any glitch (which should not happen), reach out to the Customer Success team so that we can fix it quickly!

<br />

## What is the changelog of the version 5?

A few methods have been deprecated or renamed but the upgrade from v4.X to v5 does not require many code changes on the app side. Just a matter of a couple hours of work for the developers.

The details of the changelog are accessible here: <https://docs.purchasely.com/changelog/500>

<br />

## How to display new Screens built with the Screen Composer for users who have not updated their app? (SDK version \< 5.0)

**You can't**, as the v4.X of the SDK does not render new Screens built with the Screen Composer properly.

**BUT**, we've thought of you and made your life easy by implementing a **fallback feature** 🤩!

1. When creating a Screen with the Screen composer, you can associate it with a **Fallback Screen** (compatible with older versions of the SDK 4.X)

   [block:image]{"images":[{"image":["https://files.readme.io/850b67ab9af59df40e1c0a79183915c6b6a7af8cbac4f246aadc7aee566aaf7e-image.png",null,""],"align":"center","border":true}]}[/block]

   <br />
2. If an old version of your app integrating a version of the SDK which is not compatible with the new Gen Screen (SDK version \< v5), it will automatically fall-back on the associated Screen, which means that the Screen will be properly rendered.

**Benefit for you**: you do not need to create complex audiences to target new Screens only for latest versions of your app: the Screen rendered by the SDK will always display properly.