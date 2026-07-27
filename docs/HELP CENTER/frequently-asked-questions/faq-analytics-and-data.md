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

| Channel                                      | What it gives you                                                                                                                                                                                                 |
| :------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **[S2S webhooks](webhook)**                  | Real-time JSON on the whole subscription lifecycle — entitlement events, 27 lifecycle events, offer events, `TRANSACTION_PROCESSED`. The most complete channel: you replicate the data on your side continuously. |
| **[Third-party forwarding](engagement-crm)** | Automatic forwarding of server events and subscription attributes to your analytics and CRM tools.                                                                                                                |
| **CSV exports**                              | **Download CSV** on the [Dashboards](subscription-base-evolution), respecting the active filters and granularity.                                                                                                 |

📚 [Purchasely Analytics overview](purchasely-analytics)

<br />

# What is the difference between Server Events and UI / SDK Events?

| Family                               | Where it comes from     | What it is for                                                                                     |
| :----------------------------------- | :---------------------- | :------------------------------------------------------------------------------------------------- |
| **[Server Events](server-events)**   | Our backend             | Entitlements, subscription lifecycle, offers, revenue. Reliable, retried, and the source of truth. |
| **[UI / SDK Events](ui-sdk-events)** | The SDK, inside the app | Paywall views, interactions, conversion funnels, quiz answers.                                     |

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

# Why doesn't my revenue match the store's own report?

Because the two measure different things. The Purchasely **Revenue** chart shows **gross** revenue:

- it is **what the user paid**, VAT included,
- **before** the store commission (typically 15–30%) is deducted,
- attributed to the **transaction date**,
- and it is **not MRR** — a yearly subscription shows its full amount on the day of the transaction, not spread over 12 months.

A Google Play or App Store payout report is net of commission and often net of tax, and it is attributed to a settlement period rather than a transaction date. Those two numbers are not supposed to be equal.

Before opening a ticket, reconcile in this order: same date range → same platform filter → gross vs net → transaction date vs payout period → refunds (which land in a later period on the store side).

📚 [Revenue](revenue) · [MRR](mrr) · [Subscription refunds](subscription-refunds)

<br />

# Why aren't my A/B test variants split 50/50?

Several reasons, and most of them are by design:

- **Weights are configurable.** Each variant carries a weight, and the total must equal 100. Use **Equalize** in the Console if you want an even split — the defaults are not necessarily what you want.
- **Assignment is deterministic, not balanced in real time.** A user is bucketed by a hash of their identifier (0–99), so a given user always sees the same variant. Over a small sample that hash does not produce an exactly even split.
- **Unique Viewers counts&#x20;**`PRESENTATION_VIEWED`**&#x20;events**, not assignments. If one variant is a Flow and the other a single Screen, or if one variant is slower to render, exposure counts can diverge even with identical weights.
- **Anonymous users reinstalling** get a new identifier, and therefore a new bucket.

A large, persistent imbalance that none of the above explains is worth reporting with the test ID, the weights configured and the observed counts.

<br />

# How do I run an A/B test with a real control group?

Two structures, depending on what you want to measure:

- **Screen A vs Screen B** — the standard case. Keep the test **type** consistent: a UI test changes the Screen, a Price test changes the Plans. Mixing the two makes the result uninterpretable.
- **Paywall vs no paywall** — the variant serves no Screen, so the SDK returns a _deactivated_ presentation and your app shows nothing. That is how you measure the paywall's own impact rather than one design against another.

Constraints to know up front:

- **One Placement per test.** A Placement already used by another test cannot be reused.
- **One test per Audience + Placement combination.**
- An **Audience ID cannot be changed** once it has been associated with an A/B test or a transaction.

📚 [A/B test configuration](ab-test-configuration) · [A/B test results](ab-test-results)

<br />

# When can I read an A/B test result?

The Console computes Bayesian significance, so wait for it rather than eyeballing the numbers. Practically:

- run for **1 to 2 weeks minimum**, to cover a full weekly cycle,
- aim for **95%+** significance,
- watch **View to Paid** (subscriptions started + trials converted, over unique viewers) rather than raw counts,
- remember that **Trial Ongoing** users have not resolved yet — a test read before the trials mature will overstate whichever variant pushed trials hardest.

Revenue, ARPU and ARPPU stay live even after the test is stopped.

📚 [A/B test results](ab-test-results)

<br />

# Can I export subscriptions or automate reporting?

- **Ad hoc** — every [Dashboard](subscription-base-evolution) has a **Download CSV** on its data table.
- **Continuous** — the webhook is the right channel. Replicate the events into your own warehouse and you can build any report without depending on our UI.
- **Programmatic** — the Client API covers configuration and audience operations today. If you need a specific dataset pulled on a schedule, raise it with your account team so it is prioritized against the API roadmap.

<br />

# Which dashboards should I look at?

| Question                                     | Dashboard                                                                                                               |
| :------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------- |
| Is my subscriber base growing?               | [Subscription base evolution](subscription-base-evolution) · [Paid subscription movements](paid-subscription-movements) |
| How healthy is my base?                      | [Subscription status](subscription-status) · [Subscription retention](subscription-retention)                           |
| How much revenue am I making?                | [MRR](mrr) · [Revenue](revenue)                                                                                         |
| Do my paywalls convert?                      | [Screens and conversions](screens-and-conversions) · [Funnel](funnel)                                                   |
| Which SDK versions are actually in the wild? | [SDK versions](sdk-versions)                                                                                            |
| Is the platform healthy right now?           | [Platform health](platform-health)                                                                                      |
| How many active users do I have?             | [Active users and app sessions](active-users-and-app-sessions)                                                          |

<br />

# Do you forward events to my analytics and CRM tools?

Yes, natively:

- **Attribution / MMPs** — Adjust, AppsFlyer, Branch
- **Analytics** — Amplitude, Mixpanel, Google Analytics for Firebase, Piano (AT Internet), Segment, CleverTap
- **Engagement / CRM** — Airship, Braze, Batch, Customer.io, Iterable, MoEngage, OneSignal, Brevo
- **Other** — Firebase, Slack, RevenueCat

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
