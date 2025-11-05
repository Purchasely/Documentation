---
title: Images
excerpt: This section provides details on image configuration in the screen composer
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

Images exist as stand-alone components of the Screen Composer, or as parameters or other components or Screen Layout Surfaces

# Image configuration

### Uploading an image VS configuring an image URL

When configuring an image, you have 2 choices:

- either you upload it by clicking on the **upload** link or drag and dropping the file in the appropriate zone

  [block:image]{"images":[{"image":["https://files.readme.io/432901f367c640b7d32797b5d5c70b3bdd27042d824ce992abd5a08ece128428-image.png",null,""],"align":"center","border":true}]}[/block]
- either you enter the public URL of the image by selecting the `🔗` tab then entering  URL of the image

  [block:image]{"images":[{"image":["https://files.readme.io/f683f58fdad752e17e89f12a202956a20eb9fdff3259464e3a82e335f35f60bd-image.png",null,""],"align":"center","border":true}]}[/block]

If you use a public URL, make sure the infrastructure in charge of delivering the image is sufficiently robust.

To optimize loading time (which can impact significantly the Screen conversion), avoid using images which weight more than 1.5Mb to 2Mb

<br />

### Image height

Image height can be defined in px.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/51d69027108bd38dc94d13b91f40f822032535765b891f203fd59cf3110a11d2-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


With the layout **Fill height**, the image height can adapt depending on the Screen size. To indicate to the Composer that the image should "fill the remaining height", right click on it in the Screen structure, and select "expand to fill".

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/90930ce7cdf42f3083830bdd72f985867ebc4bb5e5118848ccf19a7535acc7bd-image.png",
        null,
        "Expand to fill"
      ],
      "align": "center",
      "border": true,
      "caption": "Expand to fill"
    }
  ]
}
[/block]


- Without the expand to fill, the Screen layout looks like this:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/de06bad859a0f2e2199535a7b2307d6fc62a8d4b7c5ad9cc974fc76a09f1f1be-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


- With the expand to fill enabled, the Screen layout looks like this:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/e4e61f2cd65af5db28f3dd7d1be7e2daf0f302d5ca99ca4989d05de206b8e37e-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


When expand to fill is enabled, the image height parameter is disabled

### Fit vs Fill

The `Fit` mode and `Fill` mode for an image refer to how an image is adjusted within the component. You can modify it as follows:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/15480547d94e1749a5a062163f1ed813c1678f4ed7b9da207ac38bad3c7b2808-fit_vs_fill.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


- In `Fit` mode, the image is resized to ensure the entire image is visible, maintaining its aspect ratio without cropping. This may leave empty spaces around the image if the frame and image have different aspect ratios

  [block:image]{"images":[{"image":["https://files.readme.io/ef72e993f80238f410b856397241638d7d0ddac4e0ec181a90ac49980ab2ab81-image.png",null,"Image in `Fit` mode: it is entirely visible. Depending on the ratio of the image and the size defined for the component it leaves empty space on the left & right of the image (pillar box) or on the bottom and top (letterbox)"],"align":"center","border":true,"caption":"Image in `Fit` mode: it is entirely visible. Depending on the ratio of the image and the size defined for the component it leaves empty space on the left & right of the image (pillar box) or on the bottom and top (letterbox)"}]}[/block]

  <br />
- In `Fill` mode, the image gets resized and cropped as needed to cover the entire component without leaving empty spaces, which ensures the frame is fully covered but may cut off parts of the image, especially at the edges
- [block:image]{"images":[{"image":["https://files.readme.io/c4b7b5e29b9c350245cc5fa084eb97b66c895bf351291f2083a3e5b0feba4508-image.png",null,"Image in Fill mode: it covers 100% of the component. Depending on the ratio of the image and size defined for the component, it will crop the image on the left and right side or on top and bottom."],"align":"center","border":true,"caption":"Image in Fill mode: it covers 100% of the component. Depending on the ratio of the image and size defined for the component, it will crop the image on the left and right side or on top and bottom."}]}[/block]

  <br />

### Corner radius

The corner radius can be used to round the corner of the image

### Margin

**Margin** is the space outside the image, separating it from other elements. It adds space between the image border and the surrounding elements or the screen edge.

### Light mode vs dark mode

Images can be overridden for dark mode. By default, every image has a placeholder for light mode and dark mode.

When configuring dark mode (by activating the dark mode button), check that all the images added have been properly configured in dark mode too.

If you don't have a specific image for dark mode, then remove the dark placeholder image.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/55a0c8929ccc4c02b251049e13c98dbc0080152ff42050a9946cc84eb9329730-dark_mode.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


### Select vs unselected

Some components (eg: pickers) have a state that can be : `selected` / `unselected` or `active` / `disabled`. In this case, 2 different images can be associated. The SDK will display the relevant image depending on the parent component state.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/f6d18d7787e677402d8f0b5225c942c1c1200a6b99f8629264d6effcc2430f78-image_selected.gif",
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

# Background configuration for layout surfaces

It is also possible to use an image as a background of a surface. To do so, click on the surface and drag & drop (or upload) your image in the background section

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/49b0d1e9f8a564436cdf90d2deaa899c212f022d637efc6b29262c43e60be671-background.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


When used as a background images are fixed.