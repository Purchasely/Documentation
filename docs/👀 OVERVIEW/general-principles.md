---
title: General principles
excerpt: This section describes the general principles of the Purchasely Platform
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The Purchasely Platform is composed of 3 major components: 

1. The mobile SDK that needs to be integrated to the mobile app
2. The Purchasely Cloud Platform that can be used as the Subscription Infrastructure
3. The Purchasely Console (web interface to configure the app, access the paywall & in-app screen builder and the dashboard)

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/004c51c-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


The Purchasely Platform can be used in 2 different setups:

1. `full mode`: in this mode, the Purchasely Platform is in charge of processing in-app transactions and managing entitlements. 
   - It plays the role of Subscription Infrastructure and avoids building your own
   - On top of that, it provides [subscription enablers](main-features) that can be used by marketing teams to grow their revenue  
     => This mode is particularly useful if you start your journey in subscription or want to migrate your current Subscription Infrastructure.
2. `paywallObserver mode`: in this mode, the Purchasely Platform works on top of an existing Subscription Infrastructure (either built in-house or using a 3rd party platform such as RevenueCat). 
   - In this mode, the transactions are not managed by Purchasely. They are just observed by the Purchasely SDK to feed the dashboard.
   - All the [no-code growth features](main-features) are available for marketers.  
     => This mode is particularly useful if you are happy with your existing Subscription Infrastructure or don't want to change it, and wish to use the Purchasely SDK to run growth experiments, create automated campaigns and optimize your funnel thanks to its no-code capabilities and native paywall & in-app screen builder.

[More details about the running modes](running-modes)