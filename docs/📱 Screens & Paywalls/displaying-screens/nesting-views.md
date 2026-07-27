---
title: Nesting views
excerpt: >-
  This section describes how to nest the screens displayed by the Purchasely SDK
  into your own views
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Overview

Purchasely SDK provides the capability to display paywalls that occupy the full screen. 

However, for develops who want to customize the size of their paywalls,such as displaying them in a half-screen format, the SDK allows nesting of the paywall view within their app's views. This feature provides enhanced flexibility, allowing for a more seamless integration and a tailored user experience.

Currently, this functionality is available for native technologies (`Swift` and `Kotlin`) as well as `Flutter` and `React Native`.

# Swift

Purchasely provides a [UIViewController](https://developer.apple.com/documentation/uikit/uiviewcontroller) instance, you can display it directly using the `present()` method. This UIViewController contains a [UIView](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621460-view) instance that you can use to integrate it in your own [UIView](https://developer.apple.com/documentation/uikit/uiview).

The preloaded presentation also provides the property `swiftUIView` to display Purchasely Screen with your SwiftUI View

```swift Swift
import Purchasely

var controller: UIViewController?

// Preload the presentation then read its controller
PLYPresentationBuilder.forPlacementId("onboarding").build().preload { presentation, error in
   guard let presentation = presentation, error == nil else {
       print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
       return
   }
         
   let purchaselyController = presentation.controller


// Option 1 - Display the controller directly
self.present(purchaselyController, animated: true, completion: nil)

// Option 2 - Display Purchasely UIView inside your own
let targetView = UIView()
let purchaselyView = purchaselyController?.view
targetView.addSubview(purchaselyView)
purchaselyView?.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    purchaselyView!.topAnchor.constraint(equalTo: targetView.topAnchor),
    purchaselyView!.bottomAnchor.constraint(equalTo: targetView.bottomAnchor),
    purchaselyView!.leadingAnchor.constraint(equalTo: targetView.leadingAnchor),
    purchaselyView!.trailingAnchor.constraint(equalTo: targetView.trailingAnchor)
])

// Option 3 - Display with SwiftUI
struct ContentView: View {
    var body: some View {
        VStack {
            Text("This is SwiftUI View")
                .padding()
            
            presentation.swiftUIView
                .frame(height: 400)
        }
    }
}

}
```

# Kotlin

Purchasely provides a View instance that you can add to your layout hierarchy. It is up to you to decide how to display it inside your own View, Fragment or Activity.

To use it with Jetpack Compose, you directly use the component [AndroidView](https://developer.android.com/develop/ui/compose/migrate/interoperability-apis/views-in-compose)

```c Kotlin
// Option 1 - Preload the presentation then add its view to your layout
PLYPresentation {
    placementId("onboarding")
}.preload { loaded, error ->
    if (error != null || loaded == null) return@preload
    val purchaselyView = loaded.buildView(context) { outcome -> }
    findViewById<FrameLayout>(R.id.container).addView(purchaselyView)
}


// Option 2 - Get the view asynchronously
PLYPresentation {
    placementId("onboarding")
    onCloseRequested {
        // TODO remove view from your layout
    }
}.preload { presentation, error ->
    if(error != null) {
        Log.d("Purchasely", "Error fetching paywall", error)
        return@preload
    }

    when(presentation?.type) {
        PLYPresentationType.NORMAL,
        PLYPresentationType.FALLBACK -> {
            val purchaselyView = presentation.buildView(context) { outcome -> }
            
          // Display Purchasely paywall by adding purchaselyView to your layout
          findViewById<FrameLayout>(R.id.container).addView(purchaselyView)
        }
        else -> {
          //No presentation, it means an error was triggered
        }
    }
}  


// Option 3 - Add the view inside your Jetpack Compose Component
// Preload the presentation first, then build the view inside AndroidView.
// `loaded` is the preloaded PLYPresentation.
AndroidView(
  modifier = Modifier
  	.fillMaxSize()
  	.padding(0.dp, 5.dp), // Occupy the max size in the Compose UI tree
  factory = { context ->
    	loaded.buildView(context) { outcome ->
      		// remove this component to close Purchasely Screen,
   		}
  }
)
```

# Flutter

Flutter developers can nest Purchasely Screen using the `PLYPresentationView` widget built from a `PresentationRequest`.\
Full example below:

```c Flutter
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:purchasely_flutter/native_view_widget.dart';
import 'package:purchasely_flutter/purchasely_flutter.dart';

class PresentationScreen extends StatelessWidget {
  PresentationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrap with SafeArea
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _buildPresentationView(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPresentationView() {
    final request = PLYPresentationBuilder.placement('onboarding')
        // you can also target a specific screen with PLYPresentationBuilder.screen('my_paywall_1')
        .onDismissed((outcome) {
          print('Presentation result:${outcome.purchaseResult} - plan:${outcome.plan}');
        })
        .build();

    return PLYPresentationView(request: request);
  }
}
```

Since **PLYPresentationView** is a **StatelessWidget**, you can easily add it to your widget tree for display. For instance, you can embed it within a Center widget inside a Scaffold in your Flutter app to present the paywall view to the user.

# React Native

React Native developers can nest a Purchasely Screen with the **`PLYPresentationView`** component shipped in `react-native-purchasely` (no need to copy any file into your project). Build a `PresentationRequest`, `preload()` it, then pass it to the component through the `request` prop — the native view resolves the loaded presentation by the request's `requestId`, so there is no second network fetch. Because it is a regular React component, you can place it anywhere in your view tree (for example inside a half-height container) to size the paywall as you like.

## Display the PLYPresentationView

```typescript React Native
import React, { useEffect, useState } from 'react';
import { View } from 'react-native';
import Purchasely, {
  PLYPresentationView,
  ProductResult,
  type PLYPresentationViewResult,
  type PLYPresentationRequest,
} from 'react-native-purchasely';

const PaywallScreen = ({ navigation }: { navigation: any }) => {
  const [request, setRequest] = useState<PLYPresentationRequest | null>(null);

  // Preload the presentation before rendering the view
  useEffect(() => {
    const preload = async () => {
      const req = Purchasely.presentation.placement('ACCOUNT').build();
      // you can also target a specific screen with Purchasely.presentation.screen('my_paywall_1')
      await req.preload();
      setRequest(req);
    };
    preload();
  }, []);

  // Called when the nested paywall is closed
  const onPresentationClosed = (result: PLYPresentationViewResult) => {
    switch (result.result) {
      case ProductResult.PRODUCT_RESULT_PURCHASED:
      case ProductResult.PRODUCT_RESULT_RESTORED:
        if (result.plan != null) {
          console.log('User purchased ' + result.plan.name);
        }
        break;
      case ProductResult.PRODUCT_RESULT_CANCELLED:
        console.log('User cancelled');
        break;
    }
    // Remove the component from your tree to close the Purchasely Screen
    navigation.goBack();
  };

  if (request == null) {
    return null; // or render your own loading indicator
  }

  return (
    <View style={{ flex: 1 }}>
      <PLYPresentationView
        request={request}
        flex={1}
        onPresentationClosed={onPresentationClosed}
      />
    </View>
  );
};

export default PaywallScreen;
```

> 📘 The embedded view reports `{ result, plan }`
>
> `onPresentationClosed` receives a `PLYPresentationViewResult`: `result` is a `ProductResult` (`PRODUCT_RESULT_PURCHASED` / `PRODUCT_RESULT_RESTORED` / `PRODUCT_RESULT_CANCELLED`) and `plan` is the purchased / restored plan (or `null` when the user simply closed the screen). This is the couple the native embedded view emits — **not** the 5-field `PLYPresentationOutcome` returned by a full-screen `display()`.

If you don't preload a request, you can pass a `placementId` directly (or a presentation you preloaded yourself via the `presentation` prop); the view falls back to these when no `request` is set.

```typescript React Native
<PLYPresentationView
  placementId="ACCOUNT"
  flex={1}
  onPresentationClosed={(result) => console.log('Closed:', result.result, result.plan)}
/>
```

By following these guidelines, you can effectively nest the Purchasely paywall view within your app's interface, allowing for a customized display that fits your app's design and user experience requirements.
