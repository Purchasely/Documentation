---
title: Getting Started
excerpt: >-
  Call the Purchasely Management API: base URL, authentication and your first
  request
api_config: getting-started
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The Purchasely Management API lets your backend, scripts and internal tools do over HTTPS what your team does in the Purchasely Console. Use it to manage your catalog, screens, targeting and A/B tests, look up users and subscriptions, and read your analytics.

All endpoints live under this base URL:

```text
https://api.purchasely.io/management/v1
```

Every request carries your Management API key as a bearer token:

```text
Authorization: Bearer pk_mgmt_live_xxx
```

Your first request lists the applications your key can access:

```shell
curl https://api.purchasely.io/management/v1/applications \
  -H "Authorization: Bearer pk_mgmt_live_xxx"
```

To create a key and learn about scopes, conventions (field selection, pagination, errors, confirmation) and rate limits, read the [Management API guide](https://docs.purchasely.com/docs/management-api).
