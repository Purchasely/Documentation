---
title: Custom fonts
excerpt: >-
  This section provides details on how to integrate custom fonts to Screens
  designed with the Purchasely Screen Builder
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
> 🚧 Native UI
> 
> Our SDK create Screen with native iOS and Android components, UI Kit and Android Views, for the best performance and compatibility.  
> It means that it can only find a font that is available in the iOS or Android project.  
> If you use a <<glossary:bridge sdk>> you need to add your font to the Android or iOS project as explained below.

## iOS

You must [follow Apple guide](https://developer.apple.com/documentation/uikit/text_display_and_fonts/adding_a_custom_font_to_your_app) to add your font to your project. Then copy the font name to paste it in Purchasely console (see below).

If you are not sure about the name of your font, use the method `UIFont.familyNames()` and then the `UIFont.fontNames(forFamilyName: familyName)` to identify the name and set that name in the console.

## Android

You can add your font to either:

- the `main/assets` folder of your project.
- the [resources/font folder](https://developer.android.com/develop/ui/views/text-and-emoji/fonts-in-xml) of your project (preferred way).

Copy the name of your font to paste it in Purchasely Console (see below).

If you are not sure about the name of your font, you can retrieve it with `ResourcesCompat.getFont(context, R.font.myfont)`, **myfont** being the name to set to check if it is the proper name (only available if you have added your font to your application resources).

## Purchasely Console

You can personalize texts used in your Screens with your custom fonts in the Purchasely Screen Composer.

### How to upload a custom font:

Navigate to_ **Settings** >** App settings** > **App custom fonts **> **Add a new font**_

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/1e29f85-image.png",
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

In the following screen, fill in the following fields:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/e42a917-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


1. `Displayed font name`: the name listed Font in the Screen builder dropdown (refer to the screenshot below).
2. `iOS font name`: the name of the font in your iOS application.
3. `Android font name`: the name of the font in your Android application.
4. `Font file`: you can upload or provide a link to your font file.  
   This will only be used for the preview in the Purchasely Screen Builder.  
   Supported file formats are: `.otf`,` .ttf`, `.woff`, `.woff2`.

<br />

Once you have added your custom font in the console and made the set up in your iOS and Android application, you can fetch the font in the Screen under any text box. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/6c918625e7e25148eef08c91305ce6f7910dfeddb4255c1f3d180b147535df3a-image.png",
        null,
        null
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]