---
title: Display video on Android
excerpt: >-
  This section provides a guide for displaying Screens with video in your
  Android application.
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Learn how to make Lottie animations work with your Screens
  pages:
    - type: basic
      slug: lottie-animations
      title: Lottie animations
---
# Overview

This section provides a comprehensive guide for displaying Screens with video in your Android application using the Purchasely SDK. It covers the necessary steps to integrate a video player, either by using the Purchasely player dependency or implementing your own video player.

# Important Notice

Purchasely Android SDK does not include by default a video player starting with version `3.1.0` to avoid dependency conflicts in your project.

If you have added a video to your Screen, you need to include our player dependency or implement **`PLYPlayerInterface`**.

> 📘 Compatibility
>
> Our implementation utilizes version `1.1.1` of **[Jetpack Media3](https://developer.android.com/media/media3)**. If your project uses a different version of **Exoplayer/Media3** that is not compatible with this version, you will need to provide a custom class to the Purchasely SDK.

# Purchasely video player

The easiest way to add video support is by including the Purchasely player dependency. The SDK will automatically detect and use it to play videos in the Screen.

## Android native

```coffeescript Gradle
implementation 'io.purchasely:player:<<current_version>>'
```

## React Native

```coffeescript npm
npm install @purchasely/react-native-purchasely-android-player --save
```

## Flutter

```coffeescript Flutter
flutter pub add purchasely_android_player
```

## Cordova

Add the native android dependency in the `build.gradle` file of your android project:

```coffeescript Gradle
implementation 'io.purchasely:player:<<current_version>>'
```

## Unity

Already included in the SDK.

# Custom video player

> 🚧 Native only
>
> A custom video player can only be provided natively. If you use one of our <Glossary>bridge sdk</Glossary> you can only provide a native custom video player.

You can use your own video player for Purchasely Screens.\
This player needs to be a `View` and must implement `PLYPlayerInterface`.

```coffeescript Kotlin
interface PLYPlayerInterface {  
  fun setup(url: String, contentMode: String, isMuted: Boolean)  
  fun play()  
  fun pause()  
  fun release()  
}
```

You can declare it to the SDK either by specifying the path to your class:\
(**Notice**: your class must **have a constructor** with `android.content.Context` as **unique parameter**)

```coffeescript Kotlin
Purchasely.playerView = "com.myapp.ui.player.MyPlayerView"
```

Or by providing an instance of your class:\
(**Notice**: you should set it to null when the player is no longer needed to avoid memory leaks)

```coffeescript Kotlin
Purchasely.playerView = MyPlayerView(context)
```

## A sample of implementation of `PLYPlayerInterface`:

```coffeescript Kotlin - Media3
@OptIn(UnstableApi::class)
class Media3PlayerView(context: Context) : PlayerView(context), PLYPlayerInterface {

    private var exoPlayer = ExoPlayer
        .Builder(context)
        .build()

    override fun setup(url: String, contentMode: String, isMuted: Boolean, repeat: Boolean) {
        val mediaItem = MediaItem.fromUri(Uri.parse(url))
        exoPlayer.addMediaItem(mediaItem)
        exoPlayer.playWhenReady = false
        exoPlayer.prepare()

        resizeMode = when (contentMode) {
            "fill" -> AspectRatioFrameLayout.RESIZE_MODE_ZOOM
            "fit" -> AspectRatioFrameLayout.RESIZE_MODE_FIT
            else -> AspectRatioFrameLayout.RESIZE_MODE_ZOOM
        }

        player = exoPlayer
        controllerAutoShow = false

        if (isMuted) {
            exoPlayer.volume = 0f
        } else {
            exoPlayer.volume = 1f
        }

        exoPlayer.repeatMode = Player.REPEAT_MODE_ALL
        hideController()
    }

    override fun play() {
        exoPlayer.play()
    }

    override fun pause() {
        exoPlayer.pause()
    }

    override fun release() {
        exoPlayer.release()
    }
}
```
```coffeescript Kotlin - ExoPlayer
class PurchaselyPlayerView(context: Context) : PlayerView(context), PLYPlayerInterface {
  private var exoPlayer: SimpleExoPlayer = SimpleExoPlayer.Builder(context).build()

  override fun setup(url: String, contentMode: String, isMuted: Boolean) {
      val mediaItem = MediaItem.fromUri(Uri.parse(url))
      exoPlayer.addMediaItem(mediaItem)
      exoPlayer.playWhenReady = false
      exoPlayer.prepare()

      resizeMode = when (contentMode) {
          "fill" -> AspectRatioFrameLayout.RESIZE_MODE_ZOOM
          "fit" -> AspectRatioFrameLayout.RESIZE_MODE_FIT
          else -> AspectRatioFrameLayout.RESIZE_MODE_ZOOM
      }

      player = exoPlayer
      controllerAutoShow = false

      if (isMuted) {
          exoPlayer.volume = 0f
      } else {
          exoPlayer.volume = 1f
      }

      exoPlayer.repeatMode = Player.REPEAT_MODE_ALL
      hideController()
  }

  override fun play() {
      exoPlayer.play()
  }

  override fun pause() {
      exoPlayer.pause()
  }

  override fun release() {
      exoPlayer.release()
  }
}
```
