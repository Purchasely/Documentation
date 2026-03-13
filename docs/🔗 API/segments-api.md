---
title: Segments API
excerpt: >-
  Sync user segments from your CRM, CDP, or any third-party tool to Purchasely
  using the Client API
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages: []
---

The Segments API allows you to create and manage user segments in Purchasely programmatically. Unlike <Glossary>Audience</Glossary>s — which are rule-based and evaluated dynamically from user attributes — **Segments** are static lists of user identifiers that you sync from external tools such as Braze, Amplitude, or your own backend.

Once synced, Segments can be used in <Glossary>Placement</Glossary>s just like Audiences, allowing you to display different screens to specific groups of users.

> 📘 Segments vs Audiences
>
> **Audiences** are dynamic: they are defined by combining user attribute conditions (e.g. "iOS users in the US with an active subscription"). Membership is evaluated in real-time.
>
> **Segments** are static: they are explicit lists of user identifiers that you push to Purchasely via the API. Membership is determined by the list you provide.

# Prerequisites

## Feature access

The Segments feature requires activation on your Purchasely account. Contact your Purchasely account manager or support to enable it.

## API Key

All Client API requests require a **Bearer token** for authentication. You can create and manage API keys from the Purchasely Console:

1. Navigate to **Settings > Client API Keys** in your app
2. Click **Create API Key** and give it a name
3. Copy the token — it will only be displayed once

Include the token in the `Authorization` header of every request:

```
Authorization: Bearer YOUR_API_KEY
```

> 🚧 Keep your API key secret
>
> The API key grants full access to your app's Client API. Never expose it in client-side code or public repositories.

# Base URL

```
https://api.purchasely.io/client/mobile_applications/{app_id}
```

Replace `{app_id}` with your application's Purchasely ID (e.g. `app_xxxx`).

# Rate limits

The Client API enforces a rate limit of **60 requests per minute** per API key. Requests exceeding this limit will receive a `429 Too Many Requests` response.

The maximum request body size is **10 MB**.

# Managing Segments

## Create a segment

Creates a new segment for your application.

```
POST /client/mobile_applications/{app_id}/segments
```

**Request body:**

```json
{
  "segment": {
    "vendor_id": "premium_users",
    "name": "Premium Users",
    "identifier_type": "user_id"
  }
}
```

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `vendor_id` | string | Yes | Your unique identifier for this segment |
| `name` | string | Yes | A display name for the segment |
| `identifier_type` | string | Yes | The type of user identifier. One of: `user_id`, `anonymous_id`, `batch_custom_user_id`, `braze_user_id` |

**Response** `201 Created`:

```json
{
  "segment": {
    "id": "seg_xxxx",
    "vendor_id": "premium_users",
    "name": "Premium Users",
    "identifier_type": "user_id",
    "user_count": 0,
    "status": "ready",
    "last_synced_at": null,
    "last_job_result": null,
    "created_at": "2026-03-13T12:00:00.000Z",
    "updated_at": "2026-03-13T12:00:00.000Z"
  }
}
```

## List segments

Returns all active segments for your application.

```
GET /client/mobile_applications/{app_id}/segments
```

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `page` | integer | No | Page number for pagination (25 items per page) |

**Response** `200 OK`:

```json
{
  "segments": [
    {
      "id": "seg_xxxx",
      "vendor_id": "premium_users",
      "name": "Premium Users",
      "identifier_type": "user_id",
      "user_count": 15420,
      "status": "ready",
      "last_synced_at": "2026-03-13T12:30:00.000Z",
      "last_job_result": {
        "processed_count": 15420,
        "skipped_count": 3,
        "error_count": 0
      },
      "created_at": "2026-03-13T12:00:00.000Z",
      "updated_at": "2026-03-13T12:30:00.000Z"
    }
  ]
}
```

## Get a segment

Returns a single segment by its `vendor_id`.

```
GET /client/mobile_applications/{app_id}/segments/{vendor_id}
```

**Response** `200 OK`:

```json
{
  "segment": {
    "id": "seg_xxxx",
    "vendor_id": "premium_users",
    "name": "Premium Users",
    "identifier_type": "user_id",
    "user_count": 15420,
    "status": "ready",
    "last_synced_at": "2026-03-13T12:30:00.000Z",
    "last_job_result": null,
    "created_at": "2026-03-13T12:00:00.000Z",
    "updated_at": "2026-03-13T12:30:00.000Z"
  }
}
```

## Delete a segment

Archives a segment. The segment will no longer appear in the list but its data is retained.

```
DELETE /client/mobile_applications/{app_id}/segments/{vendor_id}
```

**Response** `200 OK`:

```json
{
  "segment": {
    "id": "seg_xxxx",
    "vendor_id": "premium_users",
    "name": "Premium Users",
    "identifier_type": "user_id",
    "user_count": 15420,
    "status": "ready",
    "last_synced_at": "2026-03-13T12:30:00.000Z",
    "last_job_result": null,
    "created_at": "2026-03-13T12:00:00.000Z",
    "updated_at": "2026-03-13T12:30:00.000Z"
  }
}
```

> 🚧 Cannot delete while processing
>
> If a mutation is currently processing for this segment, the deletion will be rejected with a `409 Conflict` error. Wait for the mutation to complete before retrying.

# Managing Segment Users

All user mutation operations are **asynchronous**. They return `202 Accepted` immediately and process in the background. The segment's `status` field transitions to `"processing"` while the mutation is running, then back to `"ready"` (or `"failed"`) when complete.

> ❗️ One mutation at a time
>
> Only one mutation can run at a time per segment. If you attempt to start a mutation while one is already processing, the API will respond with a `409 Conflict` error.

## Add and remove users

Add and/or remove users from a segment in a single request.

```
POST /client/mobile_applications/{app_id}/segments/{vendor_id}/users
```

**Request body:**

```json
{
  "add": ["user_001", "user_002", "user_003"],
  "remove": ["user_004", "user_005"]
}
```

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `add` | array of strings | No* | User identifiers to add to the segment |
| `remove` | array of strings | No* | User identifiers to remove from the segment |

\* At least one of `add` or `remove` must be provided.

**Response** `202 Accepted`:

```json
{
  "segment": {
    "id": "seg_xxxx",
    "vendor_id": "premium_users",
    "status": "processing",
    "..."
  }
}
```

## Replace all users

Replaces the entire segment membership with the provided list. All existing users are removed and the new list is set.

```
PUT /client/mobile_applications/{app_id}/segments/{vendor_id}/users/replace
```

**Request body:**

```json
{
  "users": ["user_001", "user_002", "user_003"]
}
```

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `users` | array of strings | Yes | The complete list of user identifiers for the segment |

**Response** `202 Accepted`

## Clear all users

Removes all users from the segment.

```
DELETE /client/mobile_applications/{app_id}/segments/{vendor_id}/users/clear
```

**Response** `202 Accepted`

## List users

Returns the list of user identifiers currently in the segment, with cursor-based pagination.

```
GET /client/mobile_applications/{app_id}/segments/{vendor_id}/users
```

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `cursor` | string | No | Pagination cursor returned by the previous response |
| `limit` | integer | No | Number of results per page (1–10,000, default: 1,000) |

**Response** `200 OK`:

```json
{
  "users": ["user_001", "user_002", "user_003"],
  "next_cursor": "user_003",
  "has_more": true,
  "warning": null
}
```

> 📘 Listing users while processing
>
> If the segment is currently processing a mutation, the `users` array will be empty and a `warning` message will be returned: `"Segment is currently being updated"`.

# Segment status

The `status` field on a segment indicates its current state:

| Status | Description |
| --- | --- |
| `ready` | The segment is idle and ready for mutations |
| `processing` | A mutation is currently being processed |
| `failed` | The last mutation failed — check `last_job_result` for details |

After a successful mutation, `last_synced_at` is updated and `last_job_result` contains a summary:

```json
{
  "processed_count": 15420,
  "skipped_count": 3,
  "error_count": 0
}
```

Skipped users are those with invalid identifiers (empty, too long, or containing control characters).

# Error handling

All errors follow this format:

```json
{
  "error": {
    "code": "ERROR_CODE",
    "messages": ["Human-readable description"]
  }
}
```

| HTTP Status | Code | Description |
| --- | --- | --- |
| `401` | `UNAUTHORIZED` | Missing or invalid API key |
| `403` | `FORBIDDEN` | API key does not have access to this application |
| `404` | `SEGMENT_NOT_FOUND` | No segment found with this vendor_id |
| `409` | `MUTATION_IN_PROGRESS` | A mutation is already running for this segment |
| `409` | `CANNOT_ARCHIVE_WHILE_PROCESSING` | Cannot delete a segment while a mutation is processing |
| `413` | `PAYLOAD_TOO_LARGE` | Request body exceeds 10 MB |
| `422` | `VALIDATION_FAILED` | Missing or invalid required fields |
| `422` | `EMPTY_PAYLOAD` | No users provided in the mutation request |
| `422` | `INVALID_PAYLOAD` | `add`, `remove`, or `users` must be arrays of strings |
| `429` | - | Rate limit exceeded (60 requests/minute) |

# Example: full sync workflow

Here is a typical workflow to sync a segment from an external tool:

```bash
# 1. Create the segment
curl -X POST https://api.purchasely.io/client/mobile_applications/app_xxxx/segments \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "segment": {
      "vendor_id": "braze_high_value",
      "name": "High-Value Users (Braze)",
      "identifier_type": "user_id"
    }
  }'

# 2. Populate the segment with users
curl -X PUT https://api.purchasely.io/client/mobile_applications/app_xxxx/segments/braze_high_value/users/replace \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "users": ["uid_001", "uid_002", "uid_003"]
  }'

# 3. Check the segment status
curl https://api.purchasely.io/client/mobile_applications/app_xxxx/segments/braze_high_value \
  -H "Authorization: Bearer YOUR_API_KEY"

# 4. Later, incrementally update
curl -X POST https://api.purchasely.io/client/mobile_applications/app_xxxx/segments/braze_high_value/users \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "add": ["uid_004"],
    "remove": ["uid_001"]
  }'
```

Once your segment is synced, you can associate it with a <Glossary>Placement</Glossary> in the Purchasely Console to display a specific screen to users in that segment.
