---
name: Play Store - App Scheme
---
The `App Scheme` is required to make the paywall preview work.\
You need to handle [deeplinks](deeplinks-management) as well for your application to give it the SDK to open the paywall preview.\
We support scheme such as `myapp://` but also universal link like `https://myapp.io`

You can configure it for your Android app by referring to the [following document](https://developer.android.com/training/app-links/deep-linking)

1. Paste your `App scheme`  in the Purchasely Console in the field `App Scheme`

<Image align="center" className="border" border={true} src="https://files.readme.io/4eea930-image.png" />
