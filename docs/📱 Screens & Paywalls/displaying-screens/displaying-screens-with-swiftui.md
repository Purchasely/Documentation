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
**Purchasely** paywalls can be displayed natively using UIKit, but for applications built with _SwiftUI_, the SDK provides a seamless way to integrate paywalls using a dedicated _SwiftUI_ component.

**Purchasely** automatically renders the view with native components, ensuring full compatibility across iOS devices. The integration is straightforward and requires minimal effort from developers.

## Displaying a Paywall in _SwiftUI_

For _SwiftUI_ applications, **Purchasely** provides a wrapper that allows rendering the paywall inside a _SwiftUI_ view hierarchy. This eliminates the need for manually handling UIKit view controllers.

## Usage

Simply access the _SwiftUI_ wrapper provided by **Purchasely** and integrate it into your _SwiftUI_ view hierarchy. The component ensures that the underlying UIKit view controller is properly managed within the _SwiftUI_ environment.

```Text Swift
Purchasely.presentationController(with: <paywallIdentifier>, contentId: <contentId>, loaded: { controller,_,_ in
      self.paywallView = controller?.PresentationView // Example
}, completion: nil)
```

> 🚧 Limitations
> 
> - Ensure your app targets **iOS 13.0** or later, as _SwiftUI_ support requires this minimum version.
> - The _SwiftUI_ wrapper does not modify** Purchasely**’s internal behavior; it only provides a bridge to integrate with _SwiftUI_.
> - When embedding inside _SwiftUI_ navigation flows, manage dismissal accordingly to ensure a smooth user experience.