---
title: Trash - Web Payment A/B test
excerpt: ''
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Jamais implémenté côté Back pour le ply_content, je remets la doc ici au cas où on souhaite garder une trace

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

### Processing the Stripe transaction and notifying the Purchasely Platform

Once the checkout has been finalized,, the backend must call the `/receipt` endpoint of the Purchasely platform to notify the platform that a transaction has just happened.

Call this endpoint with the appropriate headers/body:

<APIreceipt />

To send us this information, simply call our API and provide it with:

- `stripe_object_id`: the Stripe subscription ID
- `stripe_price_id`: the Stripe Price Id for this subscription (ON STRIPE)
- `user_id`: the user_id associated with the purchase, the same as you enter in [the SDK during configuration.](https://docs.purchasely.com/quick-start-1/sdk-configuration/config-appendices/set-user-id)
- `stripe_object_type`: the type of Stripe object sent, currently we only accept `subscription`
- `ply_context`: the `ply_context` parameter fetched from the POST request described above encoded in `base64`.

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