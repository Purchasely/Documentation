---
title: Lottie animations
excerpt: How to make Lottie animations work on your paywalls
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Lightweight, vectorial with a huge community, [Lottie](https://lottiefiles.com) has become the leading technology to create animations in applications.

From now on you can add Lottie animations in Purchasely paywalls but it requires a little setup from your mobile developers.

> 📘 Availability on Purchasely console
>
> This Lottie option is being added template by template. Don't hesitate to contact support to request a specific addition where you need it.

## Why is there any setup?

At Purchasely we value having a lightweight SDK (\< 2Mb) with no external dependencies.

Thus, when we wanted to offer Lottie animations we didn't want to add it as a direct dependency of our SDK. This would have multiplied by 5 the weight of our SDK and users who didn't use it would have had to have to pay that extra cost.

This is how we ended up doing a weak dependency.

## How does it work?

At runtime, our SDKs will be looking at Lottie's presence and will add the view to its paywall. It will be able to configure the aspect (fill / fit) and wether or not the animation repeats.

As Purchasely SDK will be calling methods it needed a stable interface to avoid calling a method that wouldn't exist (and crash). This is why we created an interface to Lottie that will remain stable and will embed calls to Lottie framework so that we don't need to rely on them.

You will need to add this interface to your code and Lottie SDK in your dependencies.

## Configuration

### iOS

1. First you need to [add the Lottie dependency](https://github.com/airbnb/lottie-ios#installing-lottie) (if not already in your app)
2. Then add the following Swift class to your code

```swift PLYLottieBridge.swift
//
//  PLYLottieBridge.swift
//  Purchasely
//
//  Created by Jean-François GRANG on 03/08/2021.
//  Copyright © 2021 Purchasely. All rights reserved.
//

import UIKit
import Lottie

@objc(PLYLottieBridge)
class PLYLottieBridge: NSObject {

	var animationView: LottieAnimationView?

	override init() {
		super.init()
	}

	@objc class func bridge(with animationURL: URL) -> PLYLottieBridge? {
		let result = PLYLottieBridge()
		result.animationView = LottieAnimationView(url: animationURL, closure: { _ in
			result.animationView?.play()
		}, animationCache: nil)
		result.animationView?.loopMode = .loop
		return result
	}

	@objc func view() -> UIView? {
		return animationView
	}

	@objc func loop(_ loop: Bool) {
		animationView?.loopMode = loop ? .loop : .playOnce
	}

	@objc func fill(_ fill: Bool) {
		animationView?.contentMode = fill ? .scaleAspectFill : .scaleAspectFit
	}

	@objc func play() {
		animationView?.play{ (finished) in
		}
	}

	@objc func pause() {
		animationView?.pause()
	}

	@objc func stop() {
		animationView?.stop()
	}
}

```

**🎉 You are all set!**

### Android

> 🚧 SDK 3.6.0 and up
>
> Lottie integration requires our SDK version 3.6.0 minimum

* First you need to [add the Lottie dependency](http://airbnb.io/lottie/#/android) (if not already in your app)
* Then implements `PLYLottieInterface`, you can copy the following sample `AnimationView` class
* Finally add it to Purchasely with 

  ```
  Purchasely.lottieView = { AnimationView(context) }
  ```

```kotlin AnimationView.kt
import android.animation.ValueAnimator
import android.content.Context
import android.widget.ImageView
import androidx.annotation.Keep
import com.airbnb.lottie.LottieAnimationView
import com.airbnb.lottie.LottieDrawable
import io.purchasely.views.presentation.interfaces.PLYLottieInterface

@Keep
class AnimationView(context: Context) : LottieAnimationView(context), PLYLottieInterface {

    override fun setup(url: String, repeat: Boolean, scaleType: ImageView.ScaleType) {
        setAnimationFromUrl(url)
        enableMergePathsForKitKatAndAbove(true)
        repeatMode = LottieDrawable.RESTART
        repeatCount = if (repeat) ValueAnimator.INFINITE else 0

        this.scaleType = scaleType
      
       // We strongly suggest to add this to avoir crashes with Lottie
      	setFailureListener { error ->
           Log.e(TAG, "Unable to load Lottie animation", error)
        }

        play()
    }

    override fun play() {
        playAnimation()
    }

    override fun stop() {
        pauseAnimation()
    }
}
```

**🎉 You are all set!**
