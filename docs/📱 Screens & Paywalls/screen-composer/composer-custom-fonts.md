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

### Why Simply Renaming a Font Doesn’t Work in iOS

When using custom fonts in iOS, the system does not recognize fonts based on their filename or any manually assigned name in the code. Instead, iOS relies on the internal metadata of the font file itself.  

#### **1. Fonts Are Identified by Their Internal Metadata**

Each font file contains specific metadata, including:  

- A **PostScript name** (used by the system to reference the font)  
- A **Font Family name** (grouping multiple styles like Regular, Bold, Italic)  
- A **Style name** (such as Regular, Bold, or Light)  

iOS does not look at the filename when loading a font. Instead, it requires the correct PostScript name that is embedded within the font file.  

#### **2. Custom Fonts Must Be Properly Registered**

Simply renaming a font file or attempting to use a different name in the code does not make iOS recognize it. The system only acknowledges fonts that are explicitly registered in the app’s `Info.plist` under `UIAppFonts`, and even then, they must be referenced using their correct internal PostScript names.  

#### **3. Font Name Changes Require File Modification**

If a font needs to be referenced under a different name, modifying the reference in code is not enough. The actual font file must be edited using font design software to update its internal metadata, ensuring that iOS can properly load and recognize it.  

Without these steps, attempts to use a renamed font will result in the system falling back to a default font, as the requested name does not exist in iOS’s font registry.

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



Once you have added your custom font in the console and made the set up in your iOS and Android application, you can fetch the font in the Screen under any text box. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/6c918625e7e25148eef08c91305ce6f7910dfeddb4255c1f3d180b147535df3a-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]