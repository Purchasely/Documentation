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

> 🚧 Compatibility Notice
>
> Please note that this feature is not available for **`Cordova`** and **`Unity`**.

# Swift

Purchasely provides a [UIViewController](https://developer.apple.com/documentation/uikit/uiviewcontroller) instance, you can display it directly using the `present()` method. This UIViewController contains a [UIView](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621460-view) instance that you can use to integrate it in your own [UIView](https://developer.apple.com/documentation/uikit/uiview).

The UIViewController returned also provides the property `PresentationView` to display Purchasely Screen with your SwiftUI View

```coffeescript Swift
import Purchasely

var controller: UIViewController?

// Get the controller directly
let purchaselyController = Purchasely.presentationController(for: "onboarding")
// Or get it asynchronously with fetch method
Purchasely.fetchPresentation(for: "onboarding", 
                             fetchCompletion: { presentation, error in
   guard let presentation = presentation, error == nil else {
       print("Error while fetching presentation: \(error?.localizedDescription ?? "unknown")")
       return
   }
         
   let purchaselyController = presentation.controller
})


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
            
            purchaselyController?.PresentationView
                .frame(height: 400)
        }
    }
}


```

# Kotlin

Purchasely provides a View instance that you can add to your layout hierarchy. It is up to you to decide how to display it inside your own View, Fragment or Activity.

To use it with Jetpack Compose, you directly use the component [AndroidView](https://developer.android.com/develop/ui/compose/migrate/interoperability-apis/views-in-compose)

```c Kotlin
// Option 1 - Add the view to your layout
val purchaselyView: PLYPresentationView = Purchasely.presentationView(
  context = context,
  placement = "onboarding"
)
  
findViewById<FrameLayout>(R.id.container).addView(purchaselyView)

  
// Option 2 - Get the view asynchronously
Purchasely.fetchPresentation("onboarding") { presentation, error ->
    if(error != null) {
        Log.d("Purchasely", "Error fetching paywall", error)
        return@fetchPresentation
    }

    when(presentation?.type) {
        PLYPresentationType.NORMAL,
        PLYPresentationType.FALLBACK -> {
            val purchaselyView = presentation.buildView(
                context = context,
                properties = PLYPresentationProperties(
                    onClose = {
                        // TODO remove view from your layout
                    }
                )
            )
            
          // Display Purchasely paywall by adding purchaselyView to your layout
          findViewById<FrameLayout>(R.id.container).addView(purchaselyView)
        }
        else -> {
          //No presentation, it means an error was triggered
        }
    }
}  


// Option 3 - Add the view inside your Jetpack Compose Component
AndroidView(
  modifier = Modifier
  	.fillMaxSize()
  	.padding(0.dp, 5.dp), // Occupy the max size in the Compose UI tree
  factory = { context ->
    	val purchaselyView = Purchasely.presentationView(
    		context = context,
    		placementId = "onboarding",
    		properties = PLYPresentationProperties(
      		onClose = {
        		// remove this component to close Purchasely Screen,
      		}
   		  )
  	)
   		purchaselyView
  }
)
```

# Flutter

Flutter developers can nest Purchasely Screen using the `StatelessWidget` returned by `Purchasely.getPresentationView()`\
Full example below:

```c Flutter
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:purchasely_flutter/native_view_widget.dart';
import 'package:purchasely_flutter/purchasely_flutter.dart';

class PresentationScreen extends StatelessWidget {
  final Map<String, dynamic> properties;
  final Function(PresentPresentationResult)? callback;

  PresentationScreen({required this.properties, this.callback});

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
    PLYPresentationView? presentationView = Purchasely.getPresentationView(
        // you can also set the presentation instance from fetchPresentation
        //presentation: properties['presentation'],
        //presentationId: "my_paywall_1" you can also set presentation id directly
        placementId: "onboarding"
        contentId: null,
        callback: (PresentPresentationResult result) {
          print(
            'Presentation result:${result.result} - plan:${result.plan?.vendorId}');
        });

    return presentationView ?? Container();
  }
}
```

Since **PLYPresentationView** is a **StatelessWidget**, you can easily add it to your widget tree for display. For instance, you can embed it within a Center widget inside a Scaffold in your Flutter app to present the paywall view to the user.

# React Native

> 📘 Contribution appreciated
>
> We are working to make this feature available directly from our SDK without the need to manually copy the `PLYPresentationView.tsx` file.\
> However, we are currently facing an issue with react dependencies that we haven't been able to resolve.\
> You can test it by importing PLYPresentationViewBeta and using that view:\
> `import { PLYPresentationViewBeta } from 'react-native-purchasely';`
>
> We are primarily iOS and Android developers, so any help from the React Native community would be greatly appreciated!

## 1. Create the view component File

Create a file named **`PLYPurchaselyView.tsx `** in your project and add the following code:

```coffeescript React Native
import {useEffect, useRef, useCallback} from 'react';
import {Platform, UIManager, findNodeHandle, NativeModules, requireNativeComponent} from 'react-native';

import { type PresentPresentationResult } from 'react-native-purchasely';

export const PurchaselyView = requireNativeComponent('PurchaselyView');

interface PLYPresentationViewProps {
  placementId?: string; // Made optional
  presentation?: any; // Made optional
  onPresentationClosed: (result: PresentPresentationResult) => void;
  flex?: number;
}

const PLYPresentationView: React.FC<PLYPresentationViewProps> = ({
  placementId,
  presentation,
  onPresentationClosed,
  flex = 1,
}) => {
  const ref = useRef<any>(null);

  const handlePresentationClosed = useCallback(
    (result: PresentPresentationResult) => {
      if (onPresentationClosed) {
        onPresentationClosed(result);
      }
    },
    [onPresentationClosed],
  );

  NativeModules.PurchaselyView.onPresentationClosed().then(
    (result: PresentPresentationResult) => {
      handlePresentationClosed(result);
    },
  );

  if (Platform.OS === 'android') {
    const createFragment = (viewId: number) =>
      UIManager.dispatchViewManagerCommand(
        viewId,
        // @ts-ignore
        UIManager.PurchaselyView.Commands.create.toString(),
        [viewId],
      );

    useEffect(() => {
      const viewId = findNodeHandle(ref.current);
      if (viewId) {
        createFragment(viewId);
      }

      // Assuming you're setting up an event listener or similar for onPresentationClosed
      // Ensure the implementation here matches how your native module expects to handle this callback

      return () => {
        // Clean up any event listeners or other resources
      };
    }, []);
  }

  return (
    <PurchaselyView
      // @ts-ignore
      style={{flex}}
      placementId={placementId}
      presentation={presentation}
      {...(Platform.OS === 'android' && {ref: ref})}
    />
  );
};

export { PLYPresentationView };
```

## 2. Import PLYPresentationView in the Desired File

```coffeescript React Native
import React from 'react';
import { View, Text } from 'react-native';
import {PLYPresentationView} from './PLYPresentationView';
```

## 3. Display the PLYPresentationView

Use the **`PLYPresentationView`** component within your main file to display the nested paywall view:

```coffeescript React Native
var PaywallScreen = ({
  navigation,
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  route,
}: {
  navigation: NavigationProp<any>;
  route: any;
}) => {
  // Optionally, fetch the presentation before showing it
  fetchPresentation();

  // set a callback to know the result after the presentation is closed
  const callback = (result: PresentPresentationResult) => {
    console.log('### Paywall closed');
    console.log('### Result is ' + result.result);
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
    navigation.goBack();
  };

  return (
    <View style={{flex: 1}}>
      <PLYPresentationView
        placementId="ACCOUNT"
        // instead of setting a placementId, you can set a presentation instance directly 
        // from the result of fetchPresentation
        //presentation={presentationForComponent}
        onPresentationClosed={callback}
      />
    </View>
  );
};

const fetchPresentation = async () => {
  try {
    presentationForComponent = await Purchasely.fetchPresentation({
      placementId: 'Settings',
      contentId: null,
    });
    console.log('presentation fetched is %s', presentationForComponent?.id);
  } catch (e) {
    console.error(e);
  }
};
```

By following these guidelines, you can effectively nest the Purchasely paywall view within your app's interface, allowing for a customized display that fits your app's design and user experience requirements.
