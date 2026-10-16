---
title: Management API
excerpt: >-
  Operate your Purchasely account programmatically: catalog, screens,
  targeting, experiments, look-ups and analytics, over a REST API
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The Purchasely Management API lets your backend, scripts and internal tools do over HTTPS what your team does in the Purchasely Console: read your dashboards, manage your catalog, build your targeting, run your A/B tests and look up your users.

It covers seven domains:

* **Analytics**: read the figures behind your dashboards (`Dashboard`, `Dashboard V2`).
* **Experiences**: manage your screens and what surrounds them (`Screens`, `Screen Versions`, `Category Tags`, `Web Activations`).
* **Targeting**: decide who sees what and where (`Placements`, `Audiences`, `Campaigns`).
* **Experimentation**: create, start and terminate your A/B tests, and read their results (`A/B Tests`).
* **Look-ups**: find a user, a subscription or a purchase, and triage SDK errors (`Users`, `Subscriptions`, `One-Time Purchases`, `Client Errors`).
* **Setup**: configure your applications and their catalog (`Applications`, `Products`, `Plans`, `Distributions`, `Platforms`, `Custom Events`, `Custom Event Properties`, `Custom Properties`, `Surveys`, `Answers`, `Fonts`, `Translations`).
* **Integrations**: configure your webhooks and inspect their deliveries (`Webhooks`, `Webhook Deliveries`).

Every endpoint, with its parameters and responses, is listed in the [API Reference](https://docs.purchasely.com/reference). This page explains how to get a key and the rules every endpoint follows.

> 📘 Management API vs Client API
>
> The **Management API** operates your account: catalog, screens, targeting, experiments, analytics. The **Client API** syncs data from your CRM or CDP into Purchasely, for example with the [Custom Audiences API](https://docs.purchasely.com/docs/custom-audiences-api). They use different keys and different base URLs.

# Prerequisites

Management API keys are created in the Purchasely Console by a team member who holds the **API keys · Manage** permission. The **Editor**, **Developer** and **Full admin** roles include it. See [Roles & permissions](https://docs.purchasely.com/docs/roles-and-permissions) for what each role grants.

# Create an API key

1. In the Purchasely Console, open the account menu (your avatar, bottom left) and choose **Management API keys**.
2. Click **Create API key**.
3. Give the key a **Name** that tells you which integration uses it.
4. Choose the **applications** the key can reach: a specific list, or **All applications I can access (now and in the future)**. You can only pick applications you have access to yourself.
5. Choose the **Scopes** the key holds (see [Scopes](#scopes) below). You can only grant permissions you hold yourself, and **Account** permissions (billing, team management, API keys, app creation) can never be granted to a key.
6. Optionally set an **Expiration** date. Without one, the key expires after **90 days**.
7. Click **Create**, then copy the key.

> 🚧 The key is shown only once
>
> Purchasely stores a hash of the key, never the key itself, so it cannot be displayed again. Store it in your secret manager right away. If you lose it, rotate the key.

The **Management API keys** list shows each key's name, the first characters of the key, its scopes, applications, expiration date, last use and status (**Active**, **Expired** or **Revoked**). From this list you can:

* **Edit permissions**: change the key's scopes. Its applications and expiration date are fixed at creation.
* **Rotate**: issue a new key with the same scopes, applications and expiration date. The current key stops working immediately, so update your integration with the new one.
* **Revoke**: the key stops working immediately. This cannot be undone.

To edit, rotate or revoke a key, you need access to every application it covers. To rotate it, you also need to hold every scope it carries.

# Authentication

Send your key as a bearer token in the `Authorization` header of every request. Keys start with `pk_mgmt_live_`.

```text
Authorization: Bearer pk_mgmt_live_xxx
```

All endpoints live under this base URL:

```text
https://api.purchasely.io/management/v1
```

* A missing, invalid, expired or revoked key returns `401 UNAUTHORIZED`.
* A valid key that lacks the endpoint's required scope, or that does not cover the application in the URL, returns `403 FORBIDDEN`.

> 🚧 Keep your API key secret
>
> A Management API key can change your catalog, screens and targeting. Use it from your backend only: never ship it in a mobile app, a web page or a public repository. Grant each key only the scopes and applications its integration needs.

# Scopes

A scope is one permission on one type of object, written `category.object:verb`:

* the **category** is one of the domains above: `analytics`, `experiences`, `targeting`, `experimentation`, `lookups`, `setup`, `integrations`;
* the **object** is what the endpoint acts on, for example `products`, `placements` or `screens`;
* the **verb** is what it does: `view`, `create`, `edit`, `delete` or `publish`.

For example, `setup.products:view` lets a key list and read products, and `setup.products:delete` lets it delete them. These are the same permissions you grant your team members in the Console, and a key can never hold one its creator does not hold.

Each endpoint requires exactly one scope, shown as **Required scope** on the endpoint's page in the [API Reference](https://docs.purchasely.com/reference). A few examples:

| Endpoint | Required scope |
| --- | --- |
| `GET /applications` (list your applications) | `setup.apps:view` |
| `GET /applications/{application_id}/placements` | `targeting.placements:view` |
| `POST /applications/{application_id}/campaigns` | `targeting.campaigns:create` |
| `DELETE /applications/{application_id}/products/{id}` | `setup.products:delete` |

A request outside the key's scopes returns `403 FORBIDDEN`. To give a key more, edit its permissions in the Console. Picking scopes one by one follows the same plan rules as the **Custom** role described in [Roles & permissions](https://docs.purchasely.com/docs/roles-and-permissions).

# Your first request

List the applications your key can access (requires `setup.apps:view`):

```curl
curl https://api.purchasely.io/management/v1/applications \
  -H "Authorization: Bearer pk_mgmt_live_xxx"
```

**Response** `200 OK`:

```json
{
  "mobile_applications": [
    {
      "id": "app_xxxx",
      "name": "My App",
      "default_language": "en",
      "...": "..."
    }
  ],
  "meta": {
    "total_count": 1,
    "total_pages": 1,
    "current_page": 1
  }
}
```

The `id` of each application (`app_xxxx`) is the `{application_id}` used by every endpoint nested under `/applications/{application_id}/`.

# Conventions

### Field selection

Most endpoints accept a `fields` query parameter to control the size of the response. Pass an explicit list of field names to receive only those fields, or `*` (`fields[]=*`) for every field. Without it, the endpoint returns its default field set. Unknown field names are ignored.

```curl
curl -G https://api.purchasely.io/management/v1/applications \
  -H "Authorization: Bearer pk_mgmt_live_xxx" \
  --data-urlencode "fields[]=id" \
  --data-urlencode "fields[]=name"
```

### Pagination

Paginated list endpoints accept `page` (1-indexed, defaults to `1`) and `per_page` (defaults to `25`, capped at `100`). Their response carries a `meta` object next to the results, with `total_count`, `total_pages` and `current_page`. Some short lists, such as the versions of a screen, are returned in full, without pagination and without `meta`.

Each endpoint's page in the [API Reference](https://docs.purchasely.com/reference) shows whether it accepts `page` and `per_page`.

### Errors

Every error uses the same envelope:

```json
{
  "error": {
    "code": "VALIDATION_FAILED",
    "messages": ["name is required"]
  }
}
```

| HTTP status | Code | Meaning |
| --- | --- | --- |
| `401` | `UNAUTHORIZED` | Missing, invalid, expired or revoked API key |
| `403` | `FORBIDDEN` | The key lacks the required scope, or does not cover this application |
| `403` | `FEATURE_NOT_ENABLED` | The endpoint relies on a feature that is not enabled on your account |
| `403` | `CONFIRMATION_REQUIRED` | The `confirm_token` is invalid, expired, or was issued for a different request |
| `404` | `NOT_FOUND` | The resource does not exist, or belongs to another account |
| `422` | `VALIDATION_FAILED` | A parameter is missing or invalid |
| `422` | `CONFIRMATION_REQUIRED` | The request needs confirmation (see below) |
| `429` | `RATE_LIMITED` | A rate limit was exceeded (see [Rate limits](#rate-limits)) |

### Confirmation of destructive writes

Some destructive or high-impact writes require a confirmation, so that nothing is changed by accident. Some always ask for it, such as deleting a product. Others ask only in some cases: deleting a placement or a screen, for example, asks for a confirmation only when it is still linked to other objects, and otherwise happens immediately for an otherwise valid request. When a confirmation is required:

1. The first call changes nothing: the API returns `422` with the code `CONFIRMATION_REQUIRED` and a `confirm_token`.
2. Send the **identical** request again within 5 minutes, adding the `confirm_token` you received. The API verifies the confirmation, then attempts the change; validation or dependency checks can still reject it with `422 VALIDATION_FAILED`, for example when you delete a product that still has plans.

Handle `CONFIRMATION_REQUIRED` on any write. Never send a delete without a token as a dry run: when no confirmation is needed, an otherwise valid request is applied right away.

The token is valid for **5 minutes** and only for that exact request: the same endpoint, the same resource and the same parameters. A changed payload, an expired token or a token from another request returns `403 CONFIRMATION_REQUIRED`.

```curl
# 1. Ask to delete the product
curl -X DELETE https://api.purchasely.io/management/v1/applications/app_xxxx/products/prod_xxxx \
  -H "Authorization: Bearer pk_mgmt_live_xxx"
```

```json
{
  "error": {
    "code": "CONFIRMATION_REQUIRED",
    "messages": ["confirmation required to permanently delete this product"]
  },
  "confirm_token": "YOUR_CONFIRM_TOKEN"
}
```

```curl
# 2. Confirm within 5 minutes with the same request plus the token
curl -X DELETE "https://api.purchasely.io/management/v1/applications/app_xxxx/products/prod_xxxx?confirm_token=YOUR_CONFIRM_TOKEN" \
  -H "Authorization: Bearer pk_mgmt_live_xxx"
```

The endpoints that require confirmation say so on their page in the [API Reference](https://docs.purchasely.com/reference).

# Rate limits

Rate limits apply per API key, with separate counters for each resource (products, placements, campaigns…):

| Tier | Applies to | Limit |
| --- | --- | --- |
| Standard | Every request | 60 requests per minute |
| Write | Every `POST`, `PUT`, `PATCH` and `DELETE` request, in addition to the standard tier | 10 requests per minute |
| Heavy read | Large analytics reads, in addition to the standard tier: every `Dashboard` and `Dashboard V2` endpoint, the subscription and one-time purchase lists, A/B test variant stats, campaign stats and survey results | 10 requests per minute |

Rate-limit headers describe the limit of the request's category: the write limit for a write, the heavy read limit for a heavy read, and the standard limit otherwise. Successful responses and `429` responses carry these headers; other error responses may omit them.

| Header | Meaning |
| --- | --- |
| `X-RateLimit-Limit` | Requests allowed in the current window |
| `X-RateLimit-Remaining` | Requests left in the current window |
| `X-RateLimit-Reset` | When the window resets, as a Unix timestamp in seconds |

These headers are not necessarily the limit that refused a request. A request can still be refused by another limit that applies to it, for example a heavy read refused by the standard limit, so a `429` can show remaining capacity.

Past a limit, the API returns `429` with the code `RATE_LIMITED`. Retry after `X-RateLimit-Reset`, and when a `429` shows remaining capacity, slow down across all your requests.

# Reference

The [API Reference](https://docs.purchasely.com/reference) documents every Management API endpoint: its parameters, request body, responses and required scope, with a **Try it** console to send real requests with your key.
