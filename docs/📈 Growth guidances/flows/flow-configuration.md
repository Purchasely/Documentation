---
title: Building a Flow with the Flow Composer
excerpt: >-
  This pages provides details on Flows configuration and integration into your
  app
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: In the next section, we will explain how to integrate a a Flow into your app
  pages:
    - type: basic
      slug: flow-integration
      title: Integrating a Flow into your app
---
> 🚧 SDK v5.5.0+ recommended
> 
> Flows require to integrate SDK v5.3 and above. They are supported since this version, but we recommend v5.5.0 for a better stability and data consistency.

# Building a Flow

Let’s explore how to build a Flow with Purchasely.

[block:html]
{
  "html": "<div style=\"margin: 30px 0; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(0,0,0,0.08);\">\n  <div style=\"position: relative; padding-bottom: 56.25%; height: 0;\">\n    <iframe \n      src=\"https://www.loom.com/embed/0e5369b8c0b04a60aa1528ee345d0aca\"\n      frameborder=\"0\"\n      allowfullscreen\n      webkitallowfullscreen\n      mozallowfullscreen\n      style=\"position: absolute; top: 0; left: 0; width: 100%; height: 100%;\">\n    </iframe>\n  </div>\n</div>\n\n<p style=\"text-align:center; font-size:14px; color:#777; margin-top:8px;\">\n  🎥 Tutorial — Create your first Flow in minutes\n</p>\n"
}
[/block]


The **Flow Composer** lets you:

1. drag and drop Screens built with the Purchasely Screen Composer, 
2. organize them inside a canvas
3. link them together with _Transitions_

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/ee8bf7617c07c37e33cb033a1158aa82757b63bbcc52334ebd21b604607cb579-flow_building.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


_Transitions_ allow you to link a component from a source Screen to the next Screen in the Flow. They can be defined for any interactive component - such as buttons, links, pickers or call-to-action elements - as long as they have an active action (i.e., an action other than “none” or "close"). These transitions allow you to override the default action configured at the Screen level. This makes it possible to reuse the same Screen across multiple Flows while customizing behavior as needed, significantly reducing duplication and improving maintainability.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/9001640f6472fc7bbc3d0de39f1677d2a16279e26f6710c89cf5a26c6cef9d3e-transitions.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


The components names that appear in the cartridges next to the Screen in the Flow Composer are the names defined for each component in the Screen structure (in the left column of the Screen Composer). 

You can rename a component by double-clicking on it in the Screen structure.

Both the _Main action_ and the _Second action_ of a component can be re-mapped / overridden with a transition only if they are associated with one of the following values:

- Open Screen
- Open Placement
- Deeplink
- Web Page

For the sake of clarity, if they are associated with any other action value than the ones listed above, they are ignored.

> 🚧 I can't see a cartridge matching my Screen component
> 
> When drag & dropping a Screen into the Flow canvas, if you don't see the cartridge corresponding to one of the Screen Components, it's probably because the component isn't mapped with one of the authorized actions.
> 
> In this case, simply edit the Screen by clicking on its name in the Flow canvas, then map the component with a compatible action (Open Screen, Open Placement, Web Page or Deeplink) and save.
> 
> [block:image]{"images":[{"image":["https://files.readme.io/a1b52740943773d2e38450aa95983e15deab83ee22596d3df0aa0ae14150f28b-no_action.gif","",""],"align":"center"}]}[/block]

A _Transition_ can be associated with a "Type", 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/aa98a791feb3d414337b700ab268ddeb39f0149f6a793409bdb69a16b144d5d3-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


The transition type can take the following values:

- `Push`
- `Modal`
- `Drawer`
- `Pop-in`
- `Full screen`

Here is how each Transition type looks like:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/4a3d4c0e5e7ea20876ed959f203e623858cd7e12ac9de95c8c9c6556382ee770-types.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


For drawers and popins, you can set the desired height:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/b355f6c38b89ae7c02b022e86cfdcc9c96aea71d57cc3ae9d7fee408efb7cf69-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


To ensure a seamless user experience, the Flow Composer associate the background color of the destination Screen to the Transition (for both light mode and dark mode), but you can change that color if needed.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/8664a427ae09322cc531333e73d901013b6da9fdd6f1fcfe1b5acbf7c9a31dcb-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]