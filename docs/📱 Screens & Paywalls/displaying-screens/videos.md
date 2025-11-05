---
title: Videos in Screens & Paywalls
excerpt: >-
  This section describes how to integrate and optimize video playback in
  Purchasely Screens
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: lottie-animations
      title: Lottie animations
---
# Overview

Purchasely supports the integration of videos into your Screens, providing a rich and engaging user experience. You can incorporate either **HLS (HTTP Live Streaming)** or **MP4** video formats into your Screens. Each format has its advantages and specific considerations to keep in mind.

Integrating video into your Purchasely Screens can significantly enhance the user experience. By choosing the appropriate video format (**HLS** or **MP4**) and optimizing your **MP4** files for fast playback, you can ensure a seamless and engaging experience for your users.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/3f45222-Jul-10-2024_14-38-41.gif",
        "",
        ""
      ],
      "align": "center",
      "sizing": "250px"
    }
  ]
}
[/block]


# Video Formats Supported

### **HLS** (HTTP Live Streaming)

**HLS** is an adaptive bitrate streaming protocol developed by _Apple_. It is highly suitable for delivering video content over the internet, especially to users with varying network conditions.

**Benefits:**

- **Adaptive Bitrate Streaming:** **HLS** automatically adjusts the video quality based on the user's internet speed, ensuring smooth playback even with fluctuating bandwidth.
- **Live Streaming:** Ideal for live video content, as it supports real-time broadcasting.

**Considerations:**

- **Server Configuration:** Requires a compatible server setup to segment and deliver the video content.

### MP4

**MP4** is a widely-used digital multimedia format most commonly used to store video and audio. While it is easy to implement, there are certain performance considerations when using **MP4** for online content.

**Benefits:**

- **Compatibility:** **MP4** is supported by virtually all media players and devices.
- **Ease of Use:** Simple to implement without the need for server-side configurations.

**Considerations:**

- **Startup Delay:** **MP4** videos might start slower compared to **HLS**, especially over slower network connections. This delay occurs because the entire file's metadata, stored in the **MOOV** atom, needs to be read before playback can begin.

# Understanding the **MOOV** Atom

The **MOOV** atom is a crucial part of an **MP4** file, containing metadata necessary for the video player to understand and play the video content. This metadata includes information about the file's structure, duration, and the codec used for each track.

## Importance of the **MOOV** Atom

When an **MP4** file is played, the video player needs to read the **MOOV** atom before starting the playback. If the **MOOV** atom is located at the end of the file, the player must download the entire video file to access this information, causing a delay in playback.

## Optimizing **MP4** Playback

To ensure quicker playback, especially for streaming over the internet, it's important to position the **MOOV** atom at the beginning of the **MP4** file. This allows the video player to access the necessary metadata immediately and start playback without significant delay.

### How to Optimize the **MOOV** Atom

Here are steps to optimize the **MOOV** atom placement:

1. **Using FFmpeg:**
   - You can use the FFmpeg tool to relocate the **MOOV** atom to the beginning of your **MP4** file. The following command achieves this:
     ```python Bash
     ffmpeg -i input.mp4 -movflags faststart output.mp4
     ```

2. **Using MP4Box:**
   - MP4Box is another tool that can be used to place the **MOOV** atom at the start of the file:
     ```python Bash
     MP4Box -add input.mp4 -new output.mp4
     ```

By ensuring the **MOOV** atom is positioned at the beginning of your **MP4** file, you enhance the playback experience, particularly for users with slower network connections.

# Implementation

For the Android platform, displaying video content requires the integration of a video player, you have two options:

- **Provide Your Own Video Player:** You can provide your own video player to integrate video content.
- **Use the Purchasely Video Player:** You can use the Purchasely video player implementation by adding the necessary dependency.

For detailed instructions on both approaches, please refer to [Display video on Android](display-video-on-android).

On iOS, the video player is provided directly by Purchasely SDK.