---
title: Displaying Screens with SwiftUI
excerpt: ''
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
**Purchasely** paywalls can be displayed natively using UIKit, but for applications built with *SwiftUI*, the SDK provides a seamless way to integrate paywalls using a dedicated *SwiftUI* component.

**Purchasely** automatically renders the view with native components, ensuring full compatibility across iOS devices. The integration is straightforward and requires minimal effort from developers.

## Displaying a Paywall in *SwiftUI*

For *SwiftUI* applications, **Purchasely** provides a wrapper that allows rendering the paywall inside a *SwiftUI* view hierarchy. This eliminates the need for manually handling UIKit view controllers.

## Usage

Simply access the *SwiftUI* wrapper provided by **Purchasely** and integrate it into your *SwiftUI* view hierarchy. The component ensures that the underlying UIKit view controller is properly managed within the *SwiftUI* environment.

```Text Swift
Purchasely.presentationController(with: <paywallIdentifier>, contentId: <contentId>, loaded: { controller,_,_ in
      self.paywallView = controller?.PresentationView // Example
}, completion: nil)
```

> 🚧 Limitations
>
> * Ensure your app targets **iOS 13.0** or later, as *SwiftUI* support requires this minimum version.
> * The *SwiftUI* wrapper does not modify **Purchasely**’s internal behavior; it only provides a bridge to integrate with *SwiftUI*.
> * When embedding inside *SwiftUI* navigation flows, manage dismissal accordingly to ensure a smooth user experience.
