---
title: Authentication
excerpt: Authenticate your Management API requests with a bearer API key
api_config: authentication
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Management API keys are created in the Purchasely Console: open the account menu (your avatar, bottom left) and choose **Management API keys**. Only a team member who holds the **API keys · Manage** permission (`account.api_keys:manage`) can create one. The key is shown only once.

Send the key as a bearer token in the `Authorization` header of every request. Keys start with `pk_mgmt_live_`.

```text
Authorization: Bearer pk_mgmt_live_xxx
```

* `401 UNAUTHORIZED`: the key is missing, invalid, expired or revoked.
* `403 FORBIDDEN`: the key lacks the endpoint's **Required scope**, or does not cover the application in the URL.

To create, scope, rotate or revoke a key, see [Create an API key](https://docs.purchasely.com/docs/management-api#create-an-api-key) in the Management API guide.
