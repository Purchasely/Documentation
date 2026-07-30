---
title: Roles & permissions
excerpt: >-
  This section describes the roles you can assign to your team members and the
  permissions each one grants
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Now that your team is set up, you can set up your app
  pages:
    - type: basic
      slug: application-setup
      title: Application setup
---
A **permission** is the right to perform one precise action on one type of object in the Console — viewing your dashboards, publishing a screen, deleting a plan. Purchasely ships 84 of them, grouped into 8 categories.

You never have to assemble those 84 permissions yourself. A **role** is a ready-made bundle of permissions that you pick when you invite a teammate, chosen so that it matches how people actually work: someone who only needs to read reports, someone who builds and publishes paywalls, someone who wires up the SDK.

# The six roles

| Role | What it grants | Permissions | Plan |
| --- | --- | :-: | --- |
| **Read-only** | Can see everything across the Console — dashboards, screens, audiences, catalog, users — but cannot change anything. | 26 | All plans |
| **Support** | Can look up users, subscriptions and one-time purchases, and triage the SDK errors reported by client devices. Nothing else. | 5 | All plans |
| **Editor** | The growth role: builds, edits and publishes screens, flows and Web 2 App pages, runs audiences, campaigns and A/B tests, and manages the catalog. | 70 | All plans |
| **Developer** | Everything an Editor has, plus the technical setup: store and payment platform credentials, webhooks, web domains, API keys and team management. Excludes billing. | 83 | All plans |
| **Full admin** | Every permission, including billing — the plan, invoices and payment method. | 84 | All plans |
| **Custom** | You pick the permissions one by one instead of using a bundle. | Your choice | Enterprise |

# Assigning a role

Roles are managed from **Users & Access**: click your name in the bottom-left corner of the Console, then **Users & Access**.

You choose the role when you send the invitation, and you can change it at any time afterwards — the new role takes effect immediately, on the teammate's next request.

App-level access is a **separate** control that still applies on top of the role. For each team member you decide whether they reach all your apps (including apps created later) or only a specific list. A teammate only ever sees the apps they have access to, and their role then decides what they can do inside those apps. An Editor limited to one app can publish screens in that app and nowhere else.

# What each role can do

Below is the full list of permissions, grouped by category, with what each role grants.

Permissions in **bold** are *critical*: everything that permanently removes an object (**Delete**) and everything under **Account** (billing, team management, API keys, app creation). Grant them deliberately.

Internally each permission is identified by a `category.object:action` string — you will see this shape in the Management API, in MCP consent screens and in audit logs. In the Console you only deal with the human labels used below.

## Analytics

| Permission | Read-only | Support | Editor | Developer | Full admin |
| --- | :-: | :-: | :-: | :-: | :-: |
| Dashboards · View | ✓ | — | ✓ | ✓ | ✓ |

## Experiences

| Permission | Read-only | Support | Editor | Developer | Full admin |
| --- | :-: | :-: | :-: | :-: | :-: |
| Screens · View | ✓ | — | ✓ | ✓ | ✓ |
| Screens · Create | — | — | ✓ | ✓ | ✓ |
| Screens · Edit | — | — | ✓ | ✓ | ✓ |
| **Screens · Delete** | — | — | ✓ | ✓ | ✓ |
| Screens · Publish | — | — | ✓ | ✓ | ✓ |
| Category tags · View | ✓ | — | ✓ | ✓ | ✓ |
| Category tags · Create | — | — | ✓ | ✓ | ✓ |
| **Category tags · Delete** | — | — | ✓ | ✓ | ✓ |
| Web 2 App · View | ✓ | — | ✓ | ✓ | ✓ |
| Web 2 App · Create | — | — | ✓ | ✓ | ✓ |
| Web 2 App · Edit | — | — | ✓ | ✓ | ✓ |
| **Web 2 App · Delete** | — | — | ✓ | ✓ | ✓ |
| Web 2 App · Publish | — | — | ✓ | ✓ | ✓ |
| Flows · View | ✓ | — | ✓ | ✓ | ✓ |
| Flows · Create | — | — | ✓ | ✓ | ✓ |
| Flows · Edit | — | — | ✓ | ✓ | ✓ |
| **Flows · Delete** | — | — | ✓ | ✓ | ✓ |
| Flows · Publish | — | — | ✓ | ✓ | ✓ |

## Targeting

| Permission | Read-only | Support | Editor | Developer | Full admin |
| --- | :-: | :-: | :-: | :-: | :-: |
| Placements · View | ✓ | — | ✓ | ✓ | ✓ |
| Placements · Create | — | — | ✓ | ✓ | ✓ |
| Placements · Edit | — | — | ✓ | ✓ | ✓ |
| **Placements · Delete** | — | — | — | ✓ | ✓ |
| Audiences · View | ✓ | — | ✓ | ✓ | ✓ |
| Audiences · Create | — | — | ✓ | ✓ | ✓ |
| Audiences · Edit | — | — | ✓ | ✓ | ✓ |
| **Audiences · Delete** | — | — | ✓ | ✓ | ✓ |
| Campaigns · View | ✓ | — | ✓ | ✓ | ✓ |
| Campaigns · Create | — | — | ✓ | ✓ | ✓ |
| Campaigns · Edit | — | — | ✓ | ✓ | ✓ |
| **Campaigns · Delete** | — | — | — | ✓ | ✓ |

## Experimentation

| Permission | Read-only | Support | Editor | Developer | Full admin |
| --- | :-: | :-: | :-: | :-: | :-: |
| A/B tests · View | ✓ | — | ✓ | ✓ | ✓ |
| A/B tests · Create | — | — | ✓ | ✓ | ✓ |
| A/B tests · Edit | — | — | ✓ | ✓ | ✓ |
| **A/B tests · Delete** | — | — | ✓ | ✓ | ✓ |
| Experiments · View | ✓ | — | ✓ | ✓ | ✓ |
| Experiments · Create | — | — | ✓ | ✓ | ✓ |
| Experiments · Edit | — | — | ✓ | ✓ | ✓ |
| **Experiments · Delete** | — | — | ✓ | ✓ | ✓ |

## Look-ups

| Permission | Read-only | Support | Editor | Developer | Full admin |
| --- | :-: | :-: | :-: | :-: | :-: |
| Users · View | ✓ | ✓ | ✓ | ✓ | ✓ |
| Subscriptions · View | ✓ | ✓ | ✓ | ✓ | ✓ |
| One-time purchases · View | ✓ | ✓ | ✓ | ✓ | ✓ |
| Client errors · View | ✓ | ✓ | ✓ | ✓ | ✓ |
| Client errors · Edit | — | ✓ | ✓ | ✓ | ✓ |

## Setup

| Permission | Read-only | Support | Editor | Developer | Full admin |
| --- | :-: | :-: | :-: | :-: | :-: |
| Products · View | ✓ | — | ✓ | ✓ | ✓ |
| Products · Create | — | — | ✓ | ✓ | ✓ |
| Products · Edit | — | — | ✓ | ✓ | ✓ |
| **Products · Delete** | — | — | ✓ | ✓ | ✓ |
| Plans · View | ✓ | — | ✓ | ✓ | ✓ |
| Plans · Create | — | — | ✓ | ✓ | ✓ |
| Plans · Edit | — | — | ✓ | ✓ | ✓ |
| **Plans · Delete** | — | — | ✓ | ✓ | ✓ |
| Apps · View | ✓ | — | ✓ | ✓ | ✓ |
| Apps · Create | — | — | ✓ | ✓ | ✓ |
| Apps · Edit | — | — | ✓ | ✓ | ✓ |
| Platforms · View | — | — | — | ✓ | ✓ |
| Platforms · Edit | — | — | — | ✓ | ✓ |
| Custom events · View | ✓ | — | ✓ | ✓ | ✓ |
| Custom events · Create | — | — | ✓ | ✓ | ✓ |
| Custom events · Edit | — | — | ✓ | ✓ | ✓ |
| Custom user attributes · View | ✓ | — | ✓ | ✓ | ✓ |
| Custom user attributes · Create | — | — | ✓ | ✓ | ✓ |
| Custom user attributes · Edit | — | — | ✓ | ✓ | ✓ |
| Surveys · View | ✓ | — | ✓ | ✓ | ✓ |
| Surveys · Create | — | — | ✓ | ✓ | ✓ |
| Surveys · Edit | — | — | ✓ | ✓ | ✓ |
| Fonts · View | ✓ | — | ✓ | ✓ | ✓ |
| Fonts · Create | — | — | — | ✓ | ✓ |
| Fonts · Edit | — | — | — | ✓ | ✓ |
| Translations · View | ✓ | — | ✓ | ✓ | ✓ |
| Translations · Edit | — | — | ✓ | ✓ | ✓ |
| Web domains · View | ✓ | — | ✓ | ✓ | ✓ |
| Web domains · Create | — | — | — | ✓ | ✓ |
| Web domains · Edit | — | — | — | ✓ | ✓ |
| **Web domains · Delete** | — | — | — | ✓ | ✓ |

## Integrations

| Permission | Read-only | Support | Editor | Developer | Full admin |
| --- | :-: | :-: | :-: | :-: | :-: |
| Webhooks · View | ✓ | — | — | ✓ | ✓ |
| Webhooks · Edit | — | — | — | ✓ | ✓ |
| Webhook deliveries · View | ✓ | — | ✓ | ✓ | ✓ |
| Connectors · View | ✓ | — | ✓ | ✓ | ✓ |
| Connectors · Edit | — | — | ✓ | ✓ | ✓ |

## Account

| Permission | Read-only | Support | Editor | Developer | Full admin |
| --- | :-: | :-: | :-: | :-: | :-: |
| **Billing · Manage** | — | — | — | — | ✓ |
| **Administrators · Manage** | — | — | — | ✓ | ✓ |
| **API keys · Manage** | — | — | ✓ | ✓ | ✓ |
| **App creation · Create** | — | — | — | ✓ | ✓ |

> 📘 Custom permissions require an Enterprise plan
>
> The five ready-made roles above — Read-only, Support, Editor, Developer and Full admin — are available on **every plan**, at no extra cost. Picking permissions one by one — the **Custom** role — is an **Enterprise** feature. If you need a bundle that none of the five presets covers, please contact our team to enable it on your account.

# Guardrails

A few rules apply whatever role you use:

* **You can only grant permissions you hold yourself.** You cannot give a teammate — or an API key — a permission that is not in your own set. A Developer cannot promote someone to Full admin, because a Developer does not hold the billing permission.
* **Critical permissions are flagged.** Deletes and everything under **Account** are marked as critical in the permissions editor, so an over-broad grant is visible before you confirm it.
* **Read-only account access is reversible.** An account can be switched to read-only, which narrows every one of its administrators to view-only across the whole Console, whatever their role. Their stored permissions are untouched — they are only ignored while the switch is on, so turning it back off restores everyone's write access exactly as it was. This is how we make sure nothing is ever written to your Console during a support investigation.
* **Changing a teammate's role rewrites their whole permission set.** Roles are bundles, not additions. Moving someone from Developer to Support replaces their 83 permissions with the 5 in Support.
