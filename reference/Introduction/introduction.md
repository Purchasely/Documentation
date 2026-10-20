---
title: Introduction
excerpt: >-
  Call the Purchasely Management API: base URL, API key, authentication and
  your first request
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The Purchasely Management API is a REST API for your backend, scripts and internal tools. It does what your team does in the Purchasely Console. Use it to manage your catalog, screens, targeting and A/B tests. Use it to look up users and subscriptions, and to read your analytics.

## Base URL

All endpoints live under this base URL:

```text
https://api.purchasely.io/management/v1
```

## Create an API key

Management API keys are created in the Purchasely Console. Open the account menu (your avatar, bottom left) and choose **Management API keys**. Only a team member who holds the **API keys · Manage** permission (`account.api_keys:manage`) can create one. The key is shown only once. Copy it right away and store it in a secret manager.

Each key has scopes that limit what it can do. A key expires after 90 days by default. You can set another expiration date when you create it. The step-by-step, the scope presets and the rotation and revocation of a key are in [Create an API key](https://docs.purchasely.com/docs/management-api#create-an-api-key).

## Authentication

Send the key as a bearer token in the `Authorization` header of every request. Keys start with `pk_mgmt_live_`.

```text
Authorization: Bearer pk_mgmt_live_xxx
```

* `401 UNAUTHORIZED`: the key is missing, invalid, expired or revoked.
* `403 FORBIDDEN`: the key lacks the endpoint's **Required scope**, or does not cover the application in the URL.

Each endpoint page in this reference shows the scope it requires.

## Your first request

List the applications your key can access:

```shell
curl https://api.purchasely.io/management/v1/applications \
  -H "Authorization: Bearer pk_mgmt_live_xxx"
```

The response holds your applications under `mobile_applications`; their `id` is the `application_id` that most endpoints take in their path:

```json
{
  "mobile_applications": [
    {
      "id": "app_xxx",
      "name": "My App",
      "default_language": "en"
    }
  ]
}
```

> 📘 Try it from this reference
>
> Every endpoint page has a **Try It** console. Paste your key in the **Bearer** field of its authentication panel. The console sends real requests to your account. Prefer a Read-only key while you explore.

## Going further

The [Management API guide](https://docs.purchasely.com/docs/management-api) explains scopes and rate limits. It also explains the conventions: field selection, pagination, errors and the confirmation flow for destructive writes.
