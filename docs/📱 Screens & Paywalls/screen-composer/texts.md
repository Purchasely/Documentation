---
title: Texts
excerpt: >-
  This pages provides details on the capabilities of Texts in the Screen
  Composer
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Texts can be used inside a Screen. They can be either:

1. associated directly to the screen as standalone elements

   <Image align="center" className="border" border={true} src="https://files.readme.io/c1e3d8dbff7a96e3dd8b8b2ae1bf25b99776c143f87cb485798f6ff4164d4ae3-add_new_label_stand_alone.gif" />
2. or added as sub-elements of a component by clicking on the + button in the structure of the component

   <Image align="center" className="border" border={true} src="https://files.readme.io/78d8c953b949a972a0c5270697bc7d7af7d1ec5b96ffe3a2b99ab0ec53149289-add_new_label_sub_element.gif" />

<br />

### Text properties

A Text has the following properties:

* it is associated with one unique text alignement (left, centered, right) and font style (font-family, font weight, size, font color) 

<Image align="center" className="border" border={true} src="https://files.readme.io/a3f77732b535b3d3abb9926f580443a90c90fd698cc0312bef09eabf398d000a-image.png" />

<br />

* It can be multi-line. 
  * Press `Enter` to add a new paragraph (2 new lines) 
  * or `Shift + Enter` to add one single new line
* Within a Text, different text decorations can be applied (**Bold**, *Italic*, ~~Strike-through~~) and links can be inserted (web URL or deeplink)
* It is also possible to add [Tags](tags). If no plan is associated to the Tag, it will refer to the [default Plan](screen-composer#1-paywalls-only-define-the-plans) defined for the Screen

If you need to apply 2 different font styles, then you should insert 2 different Texts and apply a specific font style to each.

### Defining different styles depending on the state of the parent component

Some components (such as the Plans pickers and the MCQ) have a state and can be either `Selected` or `Unselected`. For them, 2 different style can be associated to the the Text. Depending on the state of the Text's parent component (whether it's selected or not), the SDK will apply the appropriate style. 

<Image alt="Style applied to the Text when the parent picker is `unselected`" align="center" border={true} src="https://files.readme.io/725b1f13d7d1f79340af35aee83919960a967cd80bc9df6486be57e5665bf8ab-image.png">
  Style applied to the Text when the parent picker is `unselected`
</Image>

<Image alt="Style applied to the Text when the parent picker is `selected`" align="center" border={true} src="https://files.readme.io/92d23e0efe02823013b6bcc4b260c9645363435ed0c67e566b607f0567b5240b-image.png">
  Style applied to the Text when the parent picker is `selected`
</Image>

<br />

The same principle applies for Call To Actions, that can be `Active` or `Disabled`.

<Image align="center" src="https://files.readme.io/b4a1033f98b8fa89f14e2269d91dee106bd933a2f1439a073303cda183ab9bf8-image.png" />

### Regular text vs Offer text

This features allows you to display alternative texts (called Offer text) anywhere in the Screen that depends on the eligibility of the user to an Offer 🤩

By default the value displayed is the Regular text. If you want to override it with a specific text referring to the Introductory Offer, you must activate the Offer Mode

<Image align="center" className="border" border={true} src="https://files.readme.io/92b5924cb8469dbb366882929eba5466fc16aa310006aa23e46557ff2aae725b-ezgif-5-a9e3df5d72.gif" />

The SDK business rules for displaying the Regular text or Offer text are the following:

* the alternative Offer text will be displayed instead of the Regular text, if an Introductory Offer has been set for the Plan AND if the user is eligible to the Introductory Offer 
  * The Plan taken into consideration is either the one directly mapped with the parent element (eg: for a button or a Plan picker), or the [default Plan](screen-composer#1-paywalls-only-define-the-plans)
* The Regular text will be displayed if one of the following conditions is met:
  * if no Introductory Offer has been associated to the Plan\
    or
  * if the user is not eligible to the Introductory Offer,\
    or 
  * if no Offer text has been set

### Displaying the Text inside a cartridge

Texts can be displayed inside a cartridge. You can set the background and border and adjust the padding (by default their opacity is 0%)

By switching ON the Full width toggle, you can make the cartridge fill all the space available horizontally.

<Image align="center" className="border" border={true} src="https://files.readme.io/1464c6c8ae60768410ea6c6de087b71d6af1d67b5350ff4bf5a2813c72d666b0-labels_bg.gif" />

### Associating an action to a Text

Texts as a stand-alone component can be associated to an action, that will be triggered when users tap on it.

You can define any [action](action-types) among the one listed below.

<Image align="center" className="border" border={true} src="https://files.readme.io/15617a1ac5247b9e221fb527802376c1246f526f7aa300b94f0930f26dc0c954-action.gif" />

<br />

<br />

<ActionList />

<CTAOverridingCTALabelsInPickers />
