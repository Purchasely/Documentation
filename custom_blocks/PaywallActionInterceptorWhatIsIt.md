---
name: Paywall Action Interceptor - What is it?
---
# What is the Paywall Action Interceptor?

The Paywall Action Interceptor allows to intercept and override every interaction the users have with a Purchasely Screen.

This can be used to:

- Intercept purchase and restore actions to perform them using your own code or another third-party SDK
- Intercept the login button tapped to display your login form
- Force the explicit acceptance of terms and conditions before a purchase
- Intercept the call to a webview to inject credentials and be directly logged in
- Block purchases in Kids category apps to add a parental permission gate
- Block direct access to external content (webview or link to Safari) in Kids category apps to add a parental permission gate

With the action interceptor, you get everything you need to:

- Get the action (purchase, login, ...) and context (Plan purchased for instance)
- Display views, errors, messages, … above the Purchasely Screens
- Choose if Purchasely should continue the action or not

<br />

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/92ecc79-image.png",
        null,
        "Example of use of the Paywall Action Interceptor: when a user clicks on the Purchase button, the SDK hands over to the app that displays a modal to make the user accept the T&C. The same principle is used to make the app process the transaction with an already-in-place transaction infrastructure"
      ],
      "align": "center",
      "border": true,
      "caption": "Example of use of the Paywall Action Interceptor: when a user clicks on the Purchase button, the SDK hands over to the app that displays a modal to make the user accept the T&C. The same principle is used to make the app process the transaction with an already-in-place transaction infrastructure"
    }
  ]
}
[/block]