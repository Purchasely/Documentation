---
title: Analytics & data
excerpt: >-
  Events, webhooks, exports, dashboard discrepancies, third-party forwarding and
  subscriber base import.
deprecated: false
hidden: false
metadata:
  title: 'FAQ: Analytics & data'
  description: >-
    What data Purchasely produces, how to get it out (webhooks, forwarding,
    Client API, CSV exports), why a dashboard number may differ from your own,
    and how to import an existing subscriber base.
  robots: index
next:
  description: ''
---
# What data does Purchasely produce, and how do I get it out?

Four channels, in decreasing order of completeness:

| Channel                                                        | What it gives you                                                                                                                                                                 |
| :------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **[S2S webhooks](webhook)**                                    | Real-time JSON on the whole subscription lifecycle — entitlement events, 27 lifecycle events, offer events, `TRANSACTION_PROCESSED`. The most complete channel: you replicate the data on your side continuously. |
| **[Third-party forwarding](engagement-crm)**           | Automatic forwarding of server events and subscription attributes to your analytics and CRM tools.                                                                                  |
| **Client API**                                                 | Programmatic access at `https://api.purchasely.io/client/mobile_applications/{app_id}` with a Bearer token created in **Settings > Client API Keys**. See the [Custom Audiences API](custom-audiences-api). |
| **CSV exports**                                                | **Download CSV** on the [Dashboards](subscription-base-evolution), respecting the active filters and granularity.                                                                             |

📚 [Purchasely Analytics overview](purchasely-analytics)

<br />

# What is the difference between Server Events and UI / SDK Events?

| Family                                    | Where it comes from        | What it is for                                                                                    |
| :---------------------------------------- | :------------------------- | :------------------------------------------------------------------------------------------------ |
| **[Server Events](server-events)**        | Our backend                | Entitlements, subscription lifecycle, offers, revenue. Reliable, retried, and the source of truth. |
| **[UI / SDK Events](ui-sdk-events)**      | The SDK, inside the app    | Paywall views, interactions, conversion funnels, quiz answers.                                    |

The distinction matters when a number looks wrong: revenue and subscription counts come from Server Events, while everything about **paywall exposure and conversion** comes from UI / SDK Events emitted by the app.

📚 [Entitlement events](entitlement-events) · [Lifecycle events](lifecycle-events) · [Offer events](offer-events) · [Transactional event](transactional-event) · [UI / SDK events list](ui-sdk-events-list)

<br />

# Can I configure several webhook URLs for one app?

No — one webhook endpoint per app. If you need to fan out, receive the event on a single endpoint of yours and dispatch downstream, or use the [third-party integrations](engagement-crm) for tools we already support.

Our platform retries any event you do not acknowledge with an HTTP 200, so a temporary outage on your side does not lose data.

📚 [Webhook](webhook)

<br />

# Why does a dashboard number not match what I compute myself?

Before assuming a bug, check these in order:

1. **Which event family the metric is built on.** Paywall views, conversion rates and A/B test exposure come from UI / SDK events. If those events are not being collected — for example because [`revokeDataProcessingConsent([.analytics])`](privacy-settings) is set — the numbers are structurally incomplete while revenue stays correct.
2. **Unknown users.** Purchases that arrive only through store notifications appear in subscription listings but not in paywall dashboards, and generate no webhook. See [Understanding user types](understanding-user-types).
3. **Time zone and granularity.** Dashboards aggregate on their own period boundaries; a daily comparison against your own UTC-based query will drift at the edges.
4. **Unique viewer counts.** Unique-user metrics are approximate by construction at scale, so they will not reconcile to the exact row count of a raw event export.
5. **Filters still applied.** Exports respect the filters visible on screen, which is easy to miss when comparing two exports.

If the gap survives all five, open a support request with the dashboard, the date range, the filters and your own figure — a screenshot of the dashboard plus the query you compared it against is what makes it reproducible.

<br />

# Can I export subscriptions or automate reporting?

* **Ad hoc** — every [Dashboard](subscription-base-evolution) has a **Download CSV** on its data table.
* **Continuous** — the webhook is the right channel. Replicate the events into your own warehouse and you can build any report without depending on our UI.
* **Programmatic** — the Client API covers configuration and audience operations today. If you need a specific dataset pulled on a schedule, raise it with your account team so it is prioritized against the API roadmap.

<br />

# Which dashboards should I look at?

| Question                                        | Dashboard                                                                       |
| :---------------------------------------------- | :------------------------------------------------------------------------------ |
| Is my subscriber base growing?                  | [Subscription base evolution](subscription-base-evolution) · [Paid subscription movements](paid-subscription-movements) |
| How healthy is my base?                         | [Subscription status](subscription-status) · [Subscription retention](subscription-retention)                          |
| How much revenue am I making?                   | [MRR](mrr) · [Revenue](revenue)                                                 |
| Do my paywalls convert?                         | [Screens and conversions](screens-and-conversions) · [Funnel](funnel)           |
| Which SDK versions are actually in the wild?    | [SDK versions](sdk-versions)                                                    |
| Is the platform healthy right now?              | [Platform health](platform-health)                                              |
| How many active users do I have?                | [Active users and app sessions](active-users-and-app-sessions)                  |

<br />

# Do you forward events to my analytics and CRM tools?

Yes, natively:

* **Attribution / MMPs** — Adjust, AppsFlyer, Branch
* **Analytics** — Amplitude, Mixpanel, Google Analytics for Firebase, Piano (AT Internet), Segment, CleverTap
* **Engagement / CRM** — Airship, Braze, Batch, Customer.io, Iterable, MoEngage, OneSignal, Brevo
* **Other** — Firebase, Slack, RevenueCat

Most integrations are server-side (S2S), which means they keep working even if the app is closed. Check the specific integration page for whether it also uses client-side SDK events.

You can disable all forwarding with `revokeDataProcessingConsent([.thirdPartyIntegrations])` — see [Managing user privacy](privacy-settings).

📚 [Analytics integrations](analytics-3rd-party) · [Engagement & CRM integrations](engagement-crm)

<br />

# Why is my S2S integration not receiving anything?

The usual causes, in order:

1. **Store server notifications are not configured.** Purchasely needs to be the notification target on the store side. See [App Store S2S](app-store-configuration) and [Play Store server-to-server notifications](play-store-configuring-server-to-server-notifications).
2. **The events concern unknown users**, for which no webhook is sent by default (this can be enabled on request).
3. **Your endpoint is not returning HTTP 200**, so the events are being retried rather than delivered.
4. **The integration is enabled on a different app** than the one generating the transactions.

<br />

# Can I import my existing subscriber base?

Yes — that is how most migrations onto Purchasely start, so that historical subscribers get entitlements and appear in dashboards from day one.

📚 [Subscribers base import](subscribers-base-import) · [Catalogue import](catalogue-import)

<br />

# How do I delete or export the data of one specific user?

Through the user deletion request API, and through the webhook stream for export. See [Privacy, security & compliance](faq-privacy-and-compliance) and [User deletion request](user-deletion-request).
