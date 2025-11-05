---
title: Implementing web payment for US customers
excerpt: >-
  This page provides details on linking web checkout flows to a Purchasely
  Paywall following the new App Store ruling
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Context

On May 1st 2025, Epic v. Apple judge Yvonne Gonzalez Rogers just ruled that, effective immediately, Apple is no longer allowed to collect fees on purchases made outside apps and blocks the company from restricting how developers can point users to where they can make purchases outside of apps. Apple says it will appeal the order.\_

📰 More details in this [article from the Verve](https://www.theverge.com/news/659246/apple-epic-app-store-judge-ruling-control)

Following the judge ruling, Apple updated their [App Store review guidelines](https://developer.apple.com/app-store/review/guidelines/#business) as follows (§3.1):

![](https://files.readme.io/385e0fa840709cf4289c13d2f0281bd6f6f3d686eb4a8a4a03f8383bb101d6a8-image.png)

<br />

# What are the consequences?

<br />

- Developers can now invite US users (i.e. iOS users of their app connected to the US App Store) to purchase digital goods without necessarily using In-App Purchase mechanisms
- Purchases performed by US users outside of the app will not generate App Store fees
- Linking from the App to a web funnel is no longer against the App Store review guidelines (which means you cannot get banned for that) and does [no longer require specific app entitlements](https://developer.apple.com/documentation/storekit/external-link-account) as it used to do.
- The new rules only apply for the United States. In other words, for all other territories (different for the US App Store), the rules remain unchanged.
- If the app is not a reader app, the app must continue to offer In-App Purchase alongside other options. This means that to remain compliant with the App Store Review guidelines, you cannot be content to propose ONLY the web checkout to US consumers. They need to have the choice.

<br />

<br />

# Implementation guide

The most basic implementation of web checkout with Purchasely is very straightforward. 

It simply consists in:

1. Creating a web Paywall and opening a web page from a Purchasely Screen
2. Targeting US consumers and mapping the web Paywall with them
3. Opening back the app after the checkout has been finalized

Let's dig into the details of each step.

## 1. Creating a web paywall & opening a web page from a Purchasely Screen

### Leveraging the action Web Page

The next step consists in creating a Purchasely Screen / Paywall, which integrates components linking to the web checkout flow.

The Screen composer allows you to associate different actions to the buttons / links / calls to action. Here is how to do it.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/b6ed24774726918effe1bf2008bb9348c46dfc1c3789b94a4733316518d00207-ezgif-7de77eb26af367.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


A first simple way to integrate an external link to the Screen composer is to integrate a **Button** to your Paywall and map it with the action `Web page`.

The same can be achieved with a **Text** component:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/c99ebb05dcaeb72ed127f96090ca84960fc93e730da37a144eaca9b5b9a3b769-ezgif-7732e2eb44dd17.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


<br />

You can finally leverage Plan Pickers to allow users to choose their Plan directly inside the application and be redirected to different URLs depending on the Plan they chose.

To do that:

1. map your pickers with the Action **Select action to perform**
2. choose the CTA action **Web page**
3. then enter the **Link URL** for each specific picker

=> Thanks to this, the web page URL opened when users click on the CTA for Plan Picker, will be the one associated to the picker.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/bf1caeb69d3bd215578978691dbbe279847e818c27466cda9ae9821a28007351-ezgif-58faccd81fef7f.gif",
        "",
        "The Yearly plan has been mapped with the URL <https://www.mywebsite.com/checkout/yearly> and the Monthly plan with the URL <https://www.mywebsite.com/checkout/monthly>. "
      ],
      "align": "center",
      "border": true,
      "caption": "The Yearly plan has been mapped with the URL <https://www.mywebsite.com/checkout/yearly> and the Monthly plan with the URL <https://www.mywebsite.com/checkout/monthly>. "
    }
  ]
}
[/block]


<br />

### Alternative method: leveraging the action Deeplink

> 📘 Limitations of the action Web Page
> 
> In the Screen composer, the action **Web Page**   only allows you to integrate a static URL, without contextual information specific to the user.
> 
> If you want to be able to A/B test the web checkout flow (vs an in-app purchase flow within the app) you will need to track the conversion in the Purchasely platform and therefore to pass contextual user information between the app and the website.

Instead of using the action **Web page**, you can use the action **Deeplink**. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/962a7fed8d44de715671243d730dcb62542eec1c49b886a367a8caa202f2cdbf-ezgif-89c4b032af5c29.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


This method is not fully no-code because it requires the app to manage the deeplink associated to the picker / link / button / CTA. You shall therefore need to involve your mobile engineers.

However it has more potential because it gives the opportunity to the app to enrich the web page opened with contextual information about the user, for instance to auto connect them when the arrive on the website and therefore avoid the need to login again, which might hurt the conversion.

<br />

<br />

## 2. Targeting US consumers and mapping them with the web Paywall

The new App Store Review Guidelines only apply to the _United State Storefront_. The Purchasely SDK provides 2 Built-In Attribute called `Store name` and `Store country` that allow you to target iOS users connected to the US storefront.

To do so, you need to create the following Audience:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/7b2470b8411782bfec069c50e41ba7239f3f26918880051003cd5fbc7e513a28-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

The last step simply consists in mapping the Audience "US Consumers" created during step 1 with the web Paywall created during the step 2.

1. On the desired Placement, click on the button "Customize for an audience"
2. Select the Audience "US consumers" and the Web Paywall created
3. That's it! You're all set

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/4c9d2b717129b277465135e9d773b5a1c96085e243db5570442c24ff051614b9-image.png",
        null,
        ""
      ],
      "align": "center",
      "sizing": "400px",
      "border": true
    }
  ]
}
[/block]


<br />

<br />

## 3. Opening back the app after the checkout has been finalized

To send the user back to the app once the transaction has been processed in the web browser, you can use a simple deeplink, managed by your app.

The screen associated to this deeplink should:

1. confirm that the payment has been successfully processed 
2. reload the entitlements from your backend to grant them access to their premium benefits

<br />

## Limitation of this basic implementation

This basic implementation offers the advantage to be very simple to set up, but it has a few limitations. 

Let us see them:

1. it is not possible to make the checkout flow totally seamless by enriching the web URL with the app context. As a result and depending on how your website works, users will most likely need to login
2. you cannot measure the conversion of this flow in the Purchasely Console since it's happening outside of the app itself
3. it does not allow you to A/B test the web checkout flow versus an in-app flow

In the next paragraphs, we explore the impact that web payments might have on your conversion and retention how to remove these limitations if you are using Stripe.

<br />

<br />

# Measuring the impact of web payments on your conversion

## Web checkout will impact your conversion and retention!

Depending on how your web checkout works and how seamless is your flow, you can expect a drop-off in the initial conversion rate between **10% to 40%**. 

Moreover, every stage of the funnel will be impacted:

- the conversion from free trial to paid might increase from 5% to 25% - mainly because it's more complex for subscribers to cancel their subscription.
- the long-term retention might also increase for the same reason.

Obviously, it's still very early to have significant data about this and we will communicate on market benchmarks when we will have gathered enough data.

## The necessity to have a seamless flow

Avoiding the App Store fees is tempting, but one of the core advantages of In-App Purchase is that it is fully trusted by consumers and seamless, which generally fosters a good conversion rate. 

On the other hand, sending users from the App to their web browser to finalize their checkout makes the whole flow much more complicated for the user, and can therefore impact the conversion rate in a significant manner:

- users might need to login again - and have probably forgotten their credentials
- they might be reluctant to provide their credit card details - do they trust your brand enough?
- and might simply get lost in their journeys between the app and the web browser

To overcome these challenges, the most seamless flow has the following characteristics:

1. users don't need to choose their plan again if they already chose it within the app  
   => You can achieve that by mapping each picker in the Purchasely Paywall with a dedicated URL
2. users are automatically logged-in when they arrive on the web browser  
   => You can achieve that by enabling the Shared Web Credentials.  
   📚 Read Apple documentation about [Shared Web Credentials](https://developer.apple.com/documentation/security/shared-web-credentials)  
   📚 Read Stripe documentation about creating a [Checkout session](https://docs.stripe.com/mobile/digital-goods/checkout#open-checkout)
3. users can directly use Apple Pay for web payments  
   📚 Read Apple documentation about [Apple Pay on the Web](https://developer.apple.com/documentation/applepayontheweb) and [implementing Apple Pay](https://developer.apple.com/apple-pay/implementation/)  
   📚 Read Stripe documentation about [Apple Pay for web payments](https://docs.stripe.com/apple-pay?platform=web)

<br />

# Going further with Stripe

## Integrating Stripe with Purchasely

Web payments can be tracked in the Purchasely Dashboard if you are using Stripe.

The associated benefits are the following:

- track you subscriptions in one centralized dashboard - the Purchasely Console
- get the same Server Events for web subscribers as for in-app subscribers
- A/B test a web checkout flow VS an in-app purchase flow to assess which one performs best - see below
- [full mode only] leverage the Purchasely webhook to manage the entitlements in a unified way for web subscribers and in-app subscribers

📚 To configure the Stripe integration, follow [the guide](stripe-configuration)!

## Setting up the appropriate Stripe checkout flow

Stripe proposes several methods to configure the web checkout flow. 

📚 Read [Stripe documentation](https://docs.stripe.com/mobile/digital-goods) to understand which one best fits your needs

<br />

## A/B testing with Purchasely the web checkout flow VS the in-app purchase flow

> 🚧 Disclaimer about the current SDK capabilities (v5.2.0)
> 
> A/B testing web flows with the current version of the SDK v5.2.0 is low-code rather than 100% no-code because it relies on passing a user context from the app to the website, which requires to involve the mobile engineers.
> 
> In the following paragraphs, we describe low-code mechanisms and provide code sample, to give the possibility to track transactions performed outside of the application and A/B test different flows, with the current version of the SDK (v5.2.0).
> 
> In the weeks to come, we will release a new version of the Purchasely SDK which will make this tracking 100% no code and we will update this documentation accordingly and inform you. 
> 
> Stay tuned!

As mentioned in the introduction of this page, according to Apple and the review guidelines, users need to have the choice between In-App Purchases and other options.

This means that you are not supposed to A/B test:

- a web checkout flow  
  VS 
- an In-App Purchase flow 

but rather: 

- a flow integrating In-App Purchase along side web payment  
  VS 
- a flow integrating only In-App Purchase.

<br />

### Enriching the link opened with contextual user information

To enrich your URL with extra user data, you should use the action **Deep link** instead. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/e91368f32dd72e2816aa25d0c2a24995a61472eae601fab5b698917635fedfe2-ezgif-89c4b032af5c29.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Using a deeplink will allow to attach an in-app context (the `ply_context` parameter described below) to link the web transaction handled by Stripe to in-app flow that was initiated within the app.

To do so, follow this implementation guide:

1. Map each picker with a deeplink handled by the app.  
   E.g. _myappscheme://web_checkout/?plan_id=[stripe_price_id]_
2. When being called through the deeplink, the app makes the following processings:
   1. Extract the Deeplink data
   2. Generate the context data for the web platform and encode it in `base64` (parameter `ply_context`)  
      This data will be useful once the web transaction has been processed
   3. Append the parameter `ply_context` to the body of the HTTP POST request opening the web checkout URL

Swift code sample for each of these steps is available below 👇

```swift i. Deeplink Data Extract

// Implementation Sample Class
class WebCheckoutManager {
    
    func openDeeplink(with url: String) {
        
        guard let deeplinkURL = URL(string: "myappscheme://web_checkout/?plan_id=stripe.monthly_premium_123") else {
            print("Error: Could not create deeplinkURL.")
            return
        }
        
        guard let stripePriceId = extractDeeplinkData(deeplinkURL: deeplinkURL) else { return }
        
        self.handleDeeplink(stripePriceId: stripePriceId)
    }
    
    /// Extracts data from a deeplink URL.
    ///
    /// This function specifically looks for deeplinks matching the pattern:
    /// `your_scheme://web_checkout/?plan_id=[some_stripe_price_id]`
    ///
    ///   Returns `nil` if the deeplink does not match the expected pattern or if `plan_id` is missing.
    func extractDeeplinkData(deeplinkURL: URL) -> String? {
        print("Attempting to extract data from: \(deeplinkURL.absoluteString)")
        
        // Use URLComponents to parse the deeplink URL directly.
        // resolvingAgainstBaseURL should be false for deeplinks.
        guard let components = URLComponents(url: deeplinkURL, resolvingAgainstBaseURL: false) else {
            print("Error: Could not create URLComponents from deeplinkURL.")
            return nil
        }
        
        // 1. Check if the host is "web_checkout" (this is part of the path in `scheme://host/path...`)
        //    For deeplinks like "myappscheme://web_checkout/...", "web_checkout" is the host.
        guard components.host == "web_checkout" else {
            print("Deeplink host is not 'web_checkout'. Host: \(components.host ?? "nil")")
            return nil
        }
        
        // 2. Check if query items exist
        guard let queryItems = components.queryItems else {
            print("Deeplink contains 'web_checkout' host but no query parameters found.")
            return nil
        }
        
        // 3. Extract 'plan_id' value. This will be our stripePriceId.
        //    The '.value' property automatically handles percent decoding.
        let planIdValue = queryItems.first(where: { $0.name == "plan_id" })?.value
        
        // 4. Ensure the 'plan_id' parameter was found and is not empty
        if let extractedStripePriceId = planIdValue, !extractedStripePriceId.isEmpty {
            // Successfully matched and extracted the plan_id as stripePriceId.
            // For the new pattern, urlString and stripeObjectType are not present, so return empty strings.
            print("Matched deeplink pattern: stripe_price_id (from plan_id)='\(extractedStripePriceId)'")
            return extractedStripePriceId
        } else {
            print("'web_checkout' deeplink matched, but required query parameter 'plan_id' was missing or empty.")
            return nil
        }
    }    
}
```
```swift ii. Context data generation & encoding
    // --- Context data generation ---

    func handleDeeplink(stripePriceId: String) {
        let builtInAttributes = Purchasely.getBuiltInAttributes()
        
        let presentationId = builtInAttributes["ply_last_presentation_displayed"] as? String
        let placementId = builtInAttributes["ply_last_placement_displayed"] as? String
        let abTestId = builtInAttributes["ply_latest_abtest_id"] as? String
        let abTestVariantId = builtInAttributes["ply_latest_abtest_variant_id"] as? String
        
        let data = WebCheckoutData(presentationId: presentationId, placementId: placementId, abTestId: abTestId, abTestVariantId: abTestVariantId, stripePriceId: stripePriceId, stripeObjectType: "subscription", originalPlatform: "IOS")
        
        // Ensure CryptoKit is available before running the example logic
        if #available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *) {
            if let cypheredData = cypherData(data: data) {
                // At this stage, 'cypheredData' contains the encrypted binary data.
                // You can save them to a file, UserDefaults (if not too large), send over a network, etc.
                
                guard let url = URL(string: "https://your-endpoint.com") else {
                    return
                }
                
                sendEncryptedData(encryptedData: cypheredData,
                                  to: url) { result in
                    // Handle result
                }
                
            } else {
                print("Encryption failed.") // Changed string
            }
        } else {
            print("CryptoKit not available on this OS version.")
        }
    }

// --- Encoding ---
    @available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
    func cypherData(data: WebCheckoutData) -> Data? {
        do {
            // 1. Encode the struct to Data (JSON here, but could be something else)
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(data)

            return encodedData

        } catch {
            print("Error during encryption: \(error)") // Changed string
            return nil
        }
    }

/// Represents the data structure expected from the web checkout JSON payload.
struct WebCheckoutData: Codable, Equatable {
    
    // Properties matching the JSON keys (using camelCase)
    let presentationId: String?
    let placementId: String?
    let abTestId: String?
    let abTestVariantId: String?
    let stripePriceId: String
    let stripeObjectType: String
    let originalPlatform: String
    
    // CodingKeys enum to map JSON snake_case keys to Swift camelCase properties
    private enum CodingKeys: String, CodingKey {
        case presentationId = "presentation_id"
        case placementId = "placement_id"
        case abTestId = "ab_test_id"
        case abTestVariantId = "ab_test_variant_id"
        case stripePriceId = "stripe_price_id"
        case stripeObjectType = "stripe_object_type"
        case originalPlatform = "original_platform"
    }
}

```
```swift iii. HTTP POST Request
private struct RequestBody: Encodable {
    let ply_context: String // Property name matches the required JSON key
}

/// Sends raw Data, Base64 encoded and wrapped in a JSON object, via an HTTP POST request.
/// - Parameters:
///   - encryptedData: The `Data` object containing the payload to be encrypted and sent.
///   - url: The target `URL` for the POST request.
///   - completion: A closure called upon completion. It receives a `Result` containing
///                 optional response `Data` on success or an `Error` on failure.
///                 This closure is called on a background thread.
func sendEncryptedData(encryptedData: Data, to url: URL, completion: @escaping (Result<Data?, Error>) -> Void) {

    // 1. Create a URLRequest object with the target URL.
    var request = URLRequest(url: url)

    // 2. Set the HTTP method explicitly to POST.
    request.httpMethod = "POST"

    // 3. Prepare the JSON body.
    //    a. Base64 encode your encryptedData.
    let base64EncodedDataString = encryptedData.base64EncodedString()

    //    b. Create the RequestBody structure.
    let requestBodyPayload = RequestBody(ply_context: base64EncodedDataString)

    //    c. Encode the RequestBody structure to JSON Data.
    do {
        let jsonEncoder = JSONEncoder()
        // You can customize encoder settings if needed, e.g., outputFormatting
        // jsonEncoder.outputFormatting = .prettyPrinted // For debugging
        request.httpBody = try jsonEncoder.encode(requestBodyPayload)
    } catch {
        // If encoding the JSON body fails, call the completion handler with the error.
        print("HTTP Request Failed (JSON Encoding Error): \(error)")
        completion(.failure(error))
        return
    }

    // 4. Set the Content-Type header to "application/json" since the body is now JSON.
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

    // 5. (Optional) Add any other necessary headers.
    //    For example, an Authorization header or an Accept header if you expect a specific response type:

    // 6. Create a URLSession data task to perform the request.
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        // This completion handler executes on a background thread managed by URLSession.

        // 7. Handle the response. Always check for errors first.
        if let error = error {
            // Network error occurred (e.g., no connection, DNS lookup failure, timeout).
            print("HTTP Request Failed (Network Error): \(error)")
            completion(.failure(error))
            return
        }

        // 8. Check the HTTP response status code.
        guard let httpResponse = response as? HTTPURLResponse else {
            // This should ideally not happen if error is nil, but good practice to check.
            let unknownError = NSError(domain: "HTTPError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response object"])
            print("HTTP Request Failed (Invalid Response)")
            completion(.failure(unknownError))
            return
        }

        // Check if the status code indicates success (typically 200-299).
        if !(200...299).contains(httpResponse.statusCode) {
            // Server returned an error status code (e.g., 404 Not Found, 500 Server Error).
            print("HTTP Request Failed (Status Code: \(httpResponse.statusCode))")
            var errorInfo: [String: Any] = [NSLocalizedDescriptionKey: "HTTP status code: \(httpResponse.statusCode)"]
            if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                errorInfo["ServerErrorResponse"] = responseString // Include server response if available
            }
            let statusError = NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: errorInfo)
            completion(.failure(statusError))
            return
        }

        // 9. Request was successful.
        //    'data' contains the optional response body from the server.
        print("HTTP Request Succeeded (Status Code: \(httpResponse.statusCode))")
        completion(.success(data))
    }

    // 10. Start the network task. Tasks are created in a suspended state.
    print("Starting POST request to \(url) with JSON body.")
    task.resume()
}
```

> ❗️ Beware of the SDK version
> 
> Fetching the ab_test_id and ab_test_variant_id to generate the user context is only possible with SDK version v5.1 onwards. 
> 
> Do not forget to update the Purchasely SDK when you implement what's above and to add the minimal SDK version in your targetting
> 
> ![](https://files.readme.io/ddf7e1f068a020e93093489d312352a3abf70c59aaaf2738397826461b0a777c-image.png)

<br />

### Processing the Stripe transaction and notifying the Purchasely Platform

Once the checkout has been finalized,, the backend must call the `/receipt` endpoint of the Purchasely platform to notify the platform that a transaction has just happened.

Call this endpoint with the appropriate headers/body:

<APIreceipt />

<br />

To send us this information, simply call our API and provide it with:

- `stripe_object_id`: the Stripe subscription ID
- `stripe_price_id`: the Stripe Price Id for this subscription (ON STRIPE)
- `user_id`: the user_id associated with the purchase, the same as you enter in [the SDK during configuration.](https://docs.purchasely.com/quick-start-1/sdk-configuration/config-appendices/set-user-id)
- `stripe_object_type`: the type of Stripe object sent, currently we only accept `subscription`
- `ply_context`: the `ply_context` parameter fetched from the POST request described above encoded in `base64`.

<br />

```curl
curl \
  --request POST \
  -i \
  -H "Content-Type: application/json" \
  -H "X-API-KEY:{{YOUR_API_KEY}}" \
  -H "X-PLATFORM-TYPE:STRIPE" \
  --data '{"stripe_object_id":"{{STRIPE_SUBSCRIPTION_ID}}","stripe_price_id":"{{STRIPE_PRICE_ID_FOR_THIS_SUBSCRIPTION}}", "user_id":"{{SAME_ID_AS_IN_SDK_CONFIGURATION}}", "stripe_object_type":"subscription"}',"ply_context":[ply_context_encoded_in_base64] :  \
  https://s2s.purchasely.io/receipts
```

<br />

Example request:

```curl
curl \
  --request POST \
  -i \
  -H "Content-Type: application/json" \
  -H "X-API-KEY:AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE" \
  -H "X-PLATFORM-TYPE:STRIPE" \
  --data '{"stripe_object_id":"sub_1MluxqJaEiB9UwXB34gmtzCB","stripe_price_id":"price_1MbKJHJaEiB9UwXBPt0fFq4O", "user_id":"jdo-cus_Msq9YfCiFkFzVx", "stripe_object_type":"subscription"}', "ply_context":"eyJvcmlnaW5hbF9wbGF0Zm9ybSI6IklPUyIsInN0cmlwZV9wcmljZV9pZCI6InN0cmlwZS5tb250aGx5X3ByZW1pdW1fMTIzIiwic3RyaXBlX29iamVjdF90eXBlIjoic3Vic2NyaXB0aW9uIiwicHJlc2VudGF0aW9uX2lkIjoicHJlc19iUnpyVFY0NktvZzRua2JKa1oxcGNNbVNWaDV0bCJ9" \
  https://s2s.purchasely.io/receipts
```