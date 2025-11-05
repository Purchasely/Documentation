---
title: User deletion request
excerpt: This section provides details on how to delete data for a specific user
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Call this endpoint with the appropriate headers/body to delete data for a specific user.

**POST[https://s2s.purchasely.io/user\_deletion\_requests](https://s2s.purchasely.io/user_deletion_requests)**

**HEADERS**

| Name          | Type   | Description                                                                  |
| :------------ | :----- | :--------------------------------------------------------------------------- |
| X-API-KEY     | String | API Key associated to your application (available in the Purchasely console) |
| Authorization | String | Request signature (more details below)                                       |
| Content-Type  | String | `application/json`                                                           |

<br />

**JSON BODY**

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Name
      </th>

      <th>
        Type
      </th>

      <th>
        Description
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        user\_id
      </td>

      <td>
        String
      </td>

      <td>
        Identifier of your user as defined in your backend.  

        All the data associated to this user will be removed or pseudonymized
      </td>
    </tr>
  </tbody>
</Table>

<br />

Body example:

```json Body example
{
  "user_id": "12345"
}
```

<br />

The deletion is processed asynchronously (therefore, you may not see it disappear immediately in the Purchasely console).

A "deletion request identifier" is returned by this endpoint (it will allow our support team to debug any issue you may encounter, for a week).

```json 200
{ "id": "00001111-2222-3333-4444-555566667777" }
```
```json 401
{ "errors": ["Missing signature"] }
```
```json 400
{ "errors": ["user_id is missing"] }
```

<br />

Here are some requests examples:

```shell
curl --request POST \
  --url https://s2s.purchasely.io/user_deletion_requests \
  --header 'Authorization: 06d2310b2fd4576c7287a7be99e2450a12e0fc1f4d62b1f1ef54aa3a38836677' \
  --header 'Content-Type: application/json' \
  --header 'X-API-KEY: 00000000-1111-2222-3333-444444444444' \
  --data '{"user_id":"12345"}'
```
```ruby Ruby
require 'net/http'
require 'json'

# Url
url = URI('https://s2s.purchasely.io/user_deletion_requests')
request = Net::HTTP::Post.new(url)

# Headers
request['Content-Type'] = 'application/json'
request['X-API-KEY'] = '00000000-1111-2222-3333-444444444444'
request['Authorization'] = '06d2310b2fd4576c7287a7be99e2450a12e0fc1f4d62b1f1ef54aa3a38836677'

# Payload
payload = {
  user_id: "12345"
}
request.body = payload.to_json

# Send request
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
response = http.request(request)

# Response
case response.code
when '200'
  transaction_id = JSON.parse(response.body)['id']
when '403', '422'
  errors = JSON.parse(response.body)['errors']
end
```

<br />

> ❗️ Throttling
>
> You are limited to 50 requests per 10 minutes (if you need more, please contact us).
>
> In case this limit is reached, you'll get a `429` response and you will be blocked for 10 minutes.

## How to generate the Authorization header

You'll need your "Client shared secret" to sign the body of your request.

It is available here:

<Image align="center" src="https://files.readme.io/fba7003feee6da5c21cd6e555d4d5cd9aa36b35bde7f8d12bd33b6623388398d-Screenshot_2024-12-24_at_17.18.452x.png" />

<br />

And here are some code examples to generate the `Authorization` header:

```javascript JavaScript
const crypto = require("crypto");

// Please use the raw body sent to our servers.
const body = '{"user_id":"12345"}';
const webhookSharedSecret = "foobar";
const computedSignature = crypto
                          .createHmac("sha256", webhookSharedSecret)
                          .update(body)
                          .digest("hex"); // 06d2310b2fd4576c7287a7be99e2450a12e0fc1f4d62b1f1ef54aa3a38836677
```
```ruby
require 'openssl'

# Please use the raw body sent to our servers.
body = '{"user_id":"12345"}'
webhook_shared_secret = "foobar"
computed_signature = OpenSSL::HMAC.hexdigest('sha256', webhook_shared_secret, body)
# 06d2310b2fd4576c7287a7be99e2450a12e0fc1f4d62b1f1ef54aa3a38836677
```
```kotlin
import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec

// Please use the raw body sent to our servers.
val body = "{\"user_id\":\"12345\"}"
val webhookSharedSecret = "foobar"
val hmac = Mac.getInstance("HmacSHA256")
hmac.init(SecretKeySpec(webhookSharedSecret.toByteArray(), "HmacSHA256"))
val computedSignature = hmac.doFinal(body.toByteArray()).joinToString("") { "%02x".format(it) }
// 06d2310b2fd4576c7287a7be99e2450a12e0fc1f4d62b1f1ef54aa3a38836677
```
