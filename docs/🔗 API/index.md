---
title: API
excerpt: >-
  Reference documentation for the Purchasely Management API and Client API
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: management-api
      title: Management API
    - type: basic
      slug: custom-audiences-api
      title: Custom Audiences API
---

Purchasely offers two APIs to interact with your Purchasely data programmatically:

* The **Management API** operates your account: your applications and catalog, your screens, your targeting (placements, audiences, campaigns), your A/B tests, user and subscription look-ups, and your analytics. See the [Management API](/docs/management-api) guide to create a key and send your first request, and the [API Reference](https://docs.purchasely.com/reference) for every endpoint.
* The **Client API** syncs data from your CRM, CDP, or backend systems, such as the audiences you build there. It is described below.

# Client API

The Purchasely Client API allows you to interact with your Purchasely data programmatically. Use it to sync data from your CRM, CDP, or backend systems.

## Authentication

All Client API requests require a **Bearer token**. Create and manage API keys from **Settings > Client API Keys** in the Purchasely Console.

```
Authorization: Bearer YOUR_API_KEY
```

## Base URL

```
https://api.purchasely.io/client/mobile_applications/{app_id}
```

## Available APIs

* [Custom Audiences API](custom-audiences-api) — Create and sync user custom audiences from external tools
