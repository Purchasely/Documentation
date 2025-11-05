---
title: Videos
excerpt: This section provides details on video configuration in the Screen composer
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# General Overview

Purchasely supports the integration of videos into your Screens, providing a rich and engaging user experience. You can incorporate either **HLS (HTTP Live Streaming)** or **MP4** video formats into your Screens. Each format has its advantages and specific considerations to keep in mind.

You can add video to the body element as a background and also as a header element. 

<Image align="center" className="border" width="300px" border={true} src="https://files.readme.io/c94fefe8809d7a21d6ef4dd2fdb1578047f4d5f67837e7d92a5afab8593bcf67-image.png" />

<br />

> ❗️ Specific Setup needed for Android
>
> If you run into issues playing videos on Android devices, make sure the video player dependencies are correctly setup, as outlined in our [doc](display-video-on-android)

<br />

# Video configuration

### Uploading a video

When configuring an video, you have to enter the public URL of the video in the Video tab that indicates to fill in the URL. 

To add a video cover, you can either upload the image or add the public URL of the image. 

<Image align="center" className="border" width="1000px" border={true} src="https://files.readme.io/e81487f309f351072de71ccfe5912eb924cfb53c3b7c53578b12b8195931a296-image.png" />

> 📘 If you use a public URL, make sure the infrastructure in charge of delivering the image and the video is sufficiently robust.

### Video height

Video height can be defined in px.

<br />

<Image align="center" className="border" border={true} src="https://files.readme.io/51d69027108bd38dc94d13b91f40f822032535765b891f203fd59cf3110a11d2-image.png" />

With the layout **Fill height**, the video height can adapt depending on the Screen size. To indicate to the Composer that the video should "fill the remaining height", right click on it in the Screen structure, and select "expand to fill".

<Image align="center" className="border" border={true} src="https://files.readme.io/ee0dc271035e5c1357ebf9da92c1bb4ceac18857fd06c414a6f9897b4ad127cc-image.png" />

<br />

* Without the expand to fill, the Screen layout looks like this:

<Image align="center" className="border" width="1500px" border={true} src="https://files.readme.io/1ffcefec37f68f03d72a9f84e90017a2c91a865b8c692b12aab7884a207c0029-image.png" />

<br />

* With the expand to fill enabled, the Screen layout looks like this:

<Image align="center" className="border" border={true} src="https://files.readme.io/3fd5b0e9a03ddfc2bc82270e35ed2242330b406ec907d8147eb1152a57a9f3a1-image.png" />

<br />

> 📘 When expand to fill is enabled, the video height parameter is disabled

<br />

### Corner radius

The corner radius can be used to round the corner of the video

<Image align="center" className="border" border={true} src="https://files.readme.io/6c04ec9625416748218f5937f1f450fada7a9c45c0288fb178cc658eaf52fa51-image.png" />

### Margin

**Margin** is the space outside the video, separating it from other elements. It adds space between the video border and the surrounding elements or the screen edge.

<Image align="center" className="border" border={true} src="https://files.readme.io/687f0ef105ab4ccf3692d2170a2fb598e024f7bba420c614cefefb958c285e57-image.png" />

<br />

### Light mode vs dark mode

Video can be overridden for dark mode. By default, every video has a placeholder for light mode and dark mode.

When configuring dark mode (by activating the dark mode button), check that all the video added have been properly configured in dark mode too.

<Image align="center" className="border" border={true} src="https://files.readme.io/2b2876fc24c6ff0b46124da97c4b04dbe35bc1927194a606f9d419c073899ede-Screen_Recording_2024-11-13_at_13.39.23.gif" />

<br />

# Background configuration for layout surfaces

It is also possible to use an video as a background of a surface. To do so, click on the surface and drag & drop (or upload) your video in the background section

<Image align="center" className="border" border={true} src="https://files.readme.io/e8c750ad09d70b079ef9308edd5fcf9e7af30f9fe1629d2386f3bfcf78e32b73-Screen_Recording_2024-11-13_at_13.53.07.gif" />
