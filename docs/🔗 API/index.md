---
title: API
excerpt: >-
  Reference documentation for the Purchasely Client API
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
      slug: segments-api
      title: Segments API
---

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

* [Segments API](segments-api) — Create and sync user segments from external tools
