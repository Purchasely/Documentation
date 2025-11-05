---
title: Security - Main
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
# VERIFYING SIGNATURE WITH THE KEY (RECOMMENDED)

<BackendEntitlementsSecurity />

<br />

The authentication information is contained in the HEADER of the HTTP request :

* X-PURCHASELY-REQUEST-SIGNATURE : request signature
* X-PURCHASELY-TIMESTAMP : request timestamp

⚠️ Depending on your framework, you may receive the headers under another format:

* Ruby on Rails: HTTP\_X\_PURCHASELY\_REQUEST\_SIGNATURE
* NestJS: x-purchasely-request-signature

⚠️ Do not use the deprecated X-PURCHASELY-SIGNATURE header

Sample codes for signature verification:

```javascript JavaScript
const crypto = require("crypto");

// Request headers
// ---------------
const xPurchaselyRequestSignature = "f3c2a452e9ea72f41107321aeaf7999f1054148866a710c9b23f9f501785e2a4";
const xPurchaselyTimestamp = "1698322022";

// Request body
// ------------
const body = "{\"a_random_key\":\"a_random_value_ad\"}";

// Signature verification
// ----------------------
const webhookSharedSecret = "foobar";
const dataToSign = xPurchaselyTimestamp + body;
const computedSignature = crypto
                          .createHmac("sha256", webhookSharedSecret)
                          .update(dataToSign)
                          .digest("hex");

if (computedSignature === xPurchaselySignature) {
  // request authenticated
}
```
```ruby
require 'openssl'

# Request headers
# ---------------
x_purchasely_signature = "f3c2a452e9ea72f41107321aeaf7999f1054148866a710c9b23f9f501785e2a4"
x_purchasely_timestamp = "1698322022"

# Request body
# ------------
body = "{\"a_random_key\":\"a_random_value_ad\"}"

# Signature verification
# ----------------------
webhook_shared_secret = "foobar"
data_to_sign = x_purchasely_timestamp + body
computed_signature = OpenSSL::HMAC.hexdigest('sha256', webhook_shared_secret, data_to_sign)

if (computed_signature == x_purchasely_signature) {
  # request authenticated
}
```
```kotlin
// Imports
// -------
import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec

// Request headers
// ---------------
val xPurchaselySignature = "f3c2a452e9ea72f41107321aeaf7999f1054148866a710c9b23f9f501785e2a4"
val xPurchaselyTimestamp = "1698322022"

// Request body
// ------------
val body = "{\"a_random_key\":\"a_random_value_ad\"}"

// Signature verification
// ----------------------
val webhookSharedSecret = "foobar"
val dataToSign = xPurchaselyTimestamp + body
val hmac = Mac.getInstance("HmacSHA256")
hmac.init(SecretKeySpec(webhookSharedSecret.toByteArray(), "HmacSHA256"))
val computedSignature = hmac.doFinal(dataToSign.toByteArray()).joinToString("") { "%02x".format(it) }

if (computedSignature == xPurchaselySignature) {
    // request authenticated
}
```

You can also compute the difference between the current timestamp and the received timestamp, then decide if the difference is within your tolerance.
