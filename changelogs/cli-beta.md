---
title: Purchasely CLI (beta)
author: Kevin Herembourg
hidden: false
metadata:
  robots: noindex
published_at: '2026-11-05T15:00:00.000Z'
type: added
---
The Purchasely CLI is now available in beta. The `purchasely` command line tool gives you the Management API in your terminal, your CI and your AI coding agent.

## Highlights

- Each Management API operation is a command: `purchasely <resource> <action>`
- The key metrics of an app in the terminal: `purchasely dashboard summary`
- The Purchasely AI Plugin in your coding agents: `purchasely ai install`
- Safe writes: explicit environment, dry run, confirmation, plan then apply, read-only mode
- A demo mode to try the CLI without a key: `PURCHASELY_DEMO=1`

***

## Get started

The CLI needs access to the Management API. This access is not enabled by default: ask your Purchasely Customer Success Manager or the Purchasely support team.

```shell
curl -fsSL https://cli.purchasely.com/install.sh | sh
purchasely auth login
```

Read the [CLI](https://docs.purchasely.com/docs/cli) page, and see [cli.purchasely.com](https://cli.purchasely.com/) for the full command reference.
