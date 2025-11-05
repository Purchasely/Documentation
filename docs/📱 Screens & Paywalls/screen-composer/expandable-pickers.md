---
title: Expandable Pickers
excerpt: >-
  This page illustrates what is an expandable picker and how to configure it for
  quiz or payment screen
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Expandable picker is a paywall component that allows users to view and select subscription Plans or one-time purchase options. User can choose which Plan they want to purchase and confirm it by clicking on a purchase CTA.You can use this picker in a screen when you want to display a plan to purchase or in a screen where you ask to a customer and collect their responses.

**Quiz example**:

<Image align="center" className="border" border={true} src="https://files.readme.io/b45b5c953fc390639d610c742c3fc95b787e5dcbff272bdbfebfb16a1ae7831d-ScreenRecording2025-07-30at16.40.05-ezgif.com-video-to-gif-converter.gif" />

**Payment screen example**:

<Image align="center" className="border" border={true} src="https://files.readme.io/e7a7714bf3cc8dcbadd11b7f107b45fc1b6c62a617a2555b81bcf37c9385dce6-ScreenRecording2025-08-12at18.26.55-ezgif.com-video-to-gif-converter.gif" />

These pickers are special in a way that you can include more details about a plan or an option and clicked upon which expands those description and collapses when another picker is selected. Hence you can configure the part for Expanded/selected picker and collapsed/unselected picker

# Configuration

## Expandable picker structure

The Expandable  picker has the following structure:

<Image align="center" className="border" border={true} src="https://files.readme.io/4d9f9fdfec9c3c3b30e5fea7f250e2032a80fb8e60da0a3f2c83d11c8c7a40da-image.png" />

The component is composed of:

* a parent element (highlighted on the picture above), where general configuration options valid for all the Expandable pickers can be defined
* child elements that represent what elements to display when the picker is collapsed or unselected and what elements to display when the picker is expanded or selected

## Configuring the general parameters of the component

Here are all the parameters that can be adjusted for the Expandable Plan picker:

**On Tap**

* Action: It can be either select plan for purchase action or select options for a quiz answer submission

  <Image align="center" className="border" border={true} src="https://files.readme.io/35c7ce40f7ed2e0b1410b2abf97d6806edc061aa01ae2b20cdaadf5697a2a613-image.png" />
* Plan picker id: Id of the plan picker, if you have same id for all your plan picker,  they work as same. If you select a plan or an answer. Like hive minds in Stranger things 😂 . In this case, only one picker will be active at a given time. 

  <Image align="center" className="border" border={true} src="https://files.readme.io/269bd102a9765b84e2ca899f769d678f645e87473a87b309b23ad9c7bb0bcec3-ScreenRecording2025-09-17at15.43.14-ezgif.com-video-to-gif-converter.gif" />

If you have given different names to the picker, they are independent. Our SDK has an new feature to recognize the selected choice, hence you have this ability to choose the Action as Select plans or actions. 

<Image align="center" className="border" border={true} src="https://files.readme.io/036470e6bd193ead2e7b986afe749bf9289b1a3e6393436ea8d3343e6b46435e-ScreenRecording2025-09-17at15.46.46-ezgif.com-video-to-gif-converter.gif" />

* Offering: When you have selected your picker action to be Select plan, then you choose which plan to be linked with this picker. 
* Default: If you turn on this radio button, this picker will be chosen by default when the screen is rendered to the user.

**Layout**

In this section, you can customize the overall layout of the picker like height, width and set icon. 

<Image align="center" className="border" border={true} src="https://files.readme.io/3483c6fa6500beca6e643122e02986d3d53830c373c39b9cdf926cc4de3d9fca-image.png" />

**Styles**: Set background color and border for your picker here.You can customize it for both selected and unselected mode.

**Padding and Margin**: Padding is the space between the content of an element and its border. Margin is the space outside the border of an element, pushing it away from surrounding elements.

<Image align="center" className="border" border={true} src="https://files.readme.io/4f75ed694a8afa2b8342e8da3488440227f68aef45597ff37af3b13a1fd6c603-image.png" />

**Collapsed(unselected) and Expanded(selected)**:

You can add any number of components. You can use Vertical stack to organize those elements in a Expandable picker. 

Inside Collapsed and Expanded section, you can adjust the padding. Rest of the configuration can be 

<Image align="center" className="border" border={true} src="https://files.readme.io/4cf3b5c62a38f96d9c66f3c07151893462a6042f9a0141e5188e912e3015346b-image.png" />

<br />

<Image align="center" className="border" border={true} src="https://files.readme.io/56960f407089bfe2030b7a4125da6d8e954dd4894ef99bfcf6104dbed9a53a9f-image.png" />
