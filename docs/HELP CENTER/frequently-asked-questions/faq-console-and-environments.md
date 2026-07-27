---
title: Console & environments
excerpt: >-
  Moving a Screen between apps or environments, why a Plan refuses to be deleted,
  roles and access, and "I don't see any data".
deprecated: false
hidden: false
metadata:
  title: 'FAQ: Console & environments'
  description: >-
    How to copy a Screen from staging to production in the Purchasely Console,
    why deprecated Products and Plans cannot be deleted, how roles and per-app
    access work, and what to check when the Console shows no data.
  robots: index
next:
  description: ''
---
# How do I move a Screen from one environment to another (staging → production)?

Use **Duplicate** from the Screens **list** view — not from inside the Composer.

1. Go to **Screens** in the source app (the list, not the editor).
2. Hover the Screen you want to copy and open the **`⋮`** row actions.
3. Click **Duplicate**.
4. Select the **target app** as the destination.
5. Open the duplicate in the target app and **replace the Plans** in its Offering — Plan IDs are not the same across apps.
6. **Publish** in the target app when you are satisfied.

> ❗️ There is no "Promote" action for Screens
>
> Duplicate-to-another-app is the supported path. There is no automated export / import of Screens between environments, so if you do not see **Duplicate** on the row, check your Console role rather than looking for a Promote button.

Two things Duplicate does **not** carry over, and that you have to wire up in the target app:

* the **Placement** that displays the Screen,
* the **Audiences**, A/B tests and Campaigns that point at it.

📚 [Screen Composer](screen-composer) · [Copy & paste inside the Composer](copy-paste) · [Preview](preview)

<br />

# Why can't I delete a deprecated Product or Plan?

Because deleting it would break the history of the subscribers attached to it. In practice, a Plan or Product that has any purchase history — **including sandbox and test transactions** — cannot be removed from the Console.

The supported way to retire a Plan is to **stop referencing it**:

1. Remove it from the Offering of every Screen that still uses it.
2. Remove it from any A/B test or Campaign variant.
3. Publish those Screens.

Existing subscribers keep their subscription untouched, and no new user is ever offered the Plan again. If you genuinely need a Console-level cleanup — typically a Product created by mistake with no production purchase behind it — open a support request with the exact Product / Plan IDs and the error message you get.

📚 [Products & Plans setup](product-plans-setup) · [Catalogue import](catalogue-import)

<br />

# I just got access but the Console shows no data

Almost always an access-scope problem rather than a data problem:

1. **No app is granted to your user.** Access is controlled per app. A team member can be created without being attached to any app, in which case the Console has nothing to show.
2. **The wrong app is selected.** Staging and production are separate apps with separate data.
3. **The app has no traffic yet.** A freshly created app with no SDK integration in the wild is genuinely empty — check the [SDK versions](sdk-versions) dashboard, which is the fastest way to tell whether any SDK has ever reported in.

Ask an `Admin` on your account to open **Settings** and confirm which apps your user is allowed to see.

<br />

# What roles exist, and who can invite people?

| Role       | Can invite other users | Notes                                                       |
| :--------- | :--------------------- | :---------------------------------------------------------- |
| **Admin**  | Yes                    | Manages team members and their per-app access.               |
| **Member** | No                     | Same product access, no user management.                     |

For every team member you also choose **which apps** they can access — individually, or **All apps** to include apps created later.

The very first access to a Purchasely account is granted by the Purchasely team. The invitation email comes from **account-update\[at]purchasely.io** with the subject "You've been invited to Purchasely" — check your spam folder if it does not arrive.

📚 [Account setup](account-setup)

<br />

# Can I have separate staging and production setups?

Yes, and it is the recommended pattern: one Purchasely app per environment, each with its own API key, its own catalogue and its own Screens. Your app passes the API key matching its build configuration.

Consequences worth planning for:

* **Plan IDs differ** between apps, so a duplicated Screen always needs its Offering remapped.
* **Dashboards are per app**, so staging traffic never pollutes your production numbers.
* **Webhook endpoints are per app**, so you can point staging at a test endpoint.

<br />

# A published change is not visible in the app

See [Screens & paywalls](faq-screens-and-paywalls#i-published-a-change-in-the-console-but-the-app-still-shows-the-old-screen) — the usual causes are a draft that was saved but not published, the SDK's Screen cache, or an Audience or A/B test resolving to a different Screen than the default.

<br />

# The Console is slow or a tab times out

Some views aggregate over your full subscription history, so a very large base with a wide date range can time out. Narrow the date range and the filters first. If a specific tab times out consistently on a reasonable range, report it with the app name, the tab and the filters applied — that is a bug on our side, not something you can configure around.
