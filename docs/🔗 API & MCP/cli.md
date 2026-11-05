---
title: CLI
excerpt: >-
  Use the purchasely command line tool to operate your Purchasely account from
  your terminal, your CI and your AI coding agent
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
<Callout icon="🚧" theme="warn">
  ### Beta

  The Purchasely CLI is in beta. Commands, options and output formats can change between versions. Tell your Purchasely Customer Success Manager or the Purchasely support team about any problem or missing command.
</Callout>

The Purchasely CLI is the `purchasely` command line tool. It gives you the [Management API](https://docs.purchasely.com/docs/management-api) in your terminal and your CI. Your AI coding agent can use it too. Each Management API operation is a command, so you do not write HTTP requests yourself.

The CLI has its own website, with the installation, the full command reference and examples: [cli.purchasely.com](https://cli.purchasely.com/).

# Prerequisites

* **Access to the Management API.** The CLI sends its requests to the [Management API](https://docs.purchasely.com/docs/management-api), and this API is not enabled by default. Ask your Purchasely Customer Success Manager or the Purchasely support team to enable it on your account.
* **A Management API key.** Create the key in the Purchasely Console, as the [Management API](https://docs.purchasely.com/docs/management-api#create-an-api-key) page explains. The scopes and the applications of the key set what the CLI can read and change.
* **Node.js 22.12 or newer** on your computer or CI runner.

# Install and log in

Install the CLI:

```shell
curl -fsSL https://cli.purchasely.com/install.sh | sh
```

The installer does not use `sudo`. Open a new terminal if the shell does not find the `purchasely` command.

Log in with your Management API key. On macOS, the CLI keeps the key in the keychain. On other systems, it keeps the key in a file that only your user can read:

```shell
purchasely auth login
```

Make a first read:

```shell
purchasely applications list
```

The CLI updates itself in the background once a day. To update it immediately, run `purchasely update`.

> 📘 Try the CLI without a key
>
> Set `PURCHASELY_DEMO=1` to use the demo mode. The main read commands then return the sample data of a fictional app, `app_demo`. Other reads stop with exit code `6`. The CLI sends no Management API request, and it refuses all writes. Run `purchasely demo` to see the commands to try.

# What the CLI can do

## Read and change your account

Each Management API operation is a command, in the form `purchasely <resource> <action>`:

```shell
purchasely placements list --app app_xxx
purchasely placements get --app app_xxx --id <placement_id>
purchasely products list --app app_xxx --output table
```

The commands cover the same domains as the Management API: analytics, experiences, targeting, experimentation, look-ups, setup and integrations. The scopes of your key apply to each command.

* `purchasely --help` and `purchasely <resource> --help` show the commands and their options.
* `purchasely search "<words>"` finds the command for a task.
* `purchasely reference` prints the full command reference.
* `purchasely api GET /applications` calls a Management API endpoint directly, with the same safety rules.

## Read your key metrics

```shell
purchasely dashboard summary --app app_xxx --output table
```

This command shows the MRR, the active subscriptions, the paywall viewers and the conversions of an app, with a chart for each metric. Run `purchasely dashboard` alone to choose a dashboard from a menu.

![](https://files.readme.io/600e784f489121084c6104af59ae0bbf8098ca507339075ab127e6ff76ee7e0a-cli-dashboard-summary.gif)

<br />

## Give real data to your AI coding agent

```shell
purchasely ai install
```

This command installs the [Purchasely AI Plugin](https://docs.purchasely.com/docs/purchasely-ai-plugin) in the coding agents on your computer. It finds these agents: Claude Code, Codex, Copilot CLI, Gemini CLI, Cursor and OpenCode. The agent then uses the CLI to read the real placements, products, plans and custom events of your account. It writes your SDK integration with your real identifiers, not with example values.

The CLI does not return the SDK API key of an app. Copy the SDK API key from the Purchasely Console (App settings) into the configuration of your app.

## Write safely

* **Explicit environment.** Each write needs `--env prod` or `--env staging`.
* **Preview.** `--dry-run` shows the request and does not send it.
* **Confirmation.** A destructive change, for example the deletion of a placement that is in use, shows its impact and asks for a confirmation. In a script, add `--yes` to confirm.
* **Plan, then apply.** `--plan <file>` records the writes in a plan file and sends nothing. A team member reads the plan, then runs `purchasely apply <file>` to send the writes. With `apply`, `--yes` approves the plan only: a destructive change still asks for a confirmation in a terminal. Without a terminal, `apply` stops at that change.
* **Read-only mode.** Set `PURCHASELY_READ_ONLY=1` to refuse all writes, for example for an agent that must only read.
* **Write allow-list.** In `~/.config/purchasely/config.json`, list for each environment the apps that a write can change. Use it to keep an agent on a test app. An environment without a list has no limit. An empty list refuses all writes:

  ```json
  { "write_allowlist": { "prod": ["app_test"] } }
  ```

* **Rate limits.** The CLI limits the rate of its requests for the [rate limits](https://docs.purchasely.com/docs/management-api#rate-limits) of the Management API. After a `429`, it waits and tries the request again one time. A request can still fail with exit code `7`.

## Use the CLI in scripts and CI

* `--output json` (the default) gives a result that `jq` and other tools can read. `--output table` gives a result for a person.
* A JSON result larger than 200 KB goes to a file, and the CLI prints the path of the file. Add `--out -` to send the full result to the standard output.
* `--fields id,vendor_id` keeps only the fields that you need.
* The exit codes are stable: for example `3` for a refused key, `4` for a forbidden request (for example a missing scope), `7` for a rate limit and `10` for a write that a local safety rule refused. The [CLI website](https://cli.purchasely.com/) lists all the exit codes.
* In CI, give the key to `purchasely auth login` on the standard input. Do not use `--api-key`, because the key then stays in the shell history and the logs:

  ```shell
  printf '%s' "$PURCHASELY_MANAGEMENT_KEY" | purchasely auth login
  ```

* In CI, the CLI does not update itself.
* `purchasely doctor` checks the installation, the key, the network and the version.

# Limits

* The CLI gives access only to what the Management API gives.
* The CLI does not add permissions. A command that needs a scope that your key does not have stops with exit code `4`.
* The CLI is in beta. Commands and output formats can change between versions.

# Use cases

| Use case | Example |
| --- | --- |
| Integrate the SDK with the real identifiers of your account | `purchasely placements list --app app_xxx --fields id,vendor_id` |
| Let your AI coding agent integrate, review or debug the SDK | `purchasely ai install`, then ask your agent |
| Check the key metrics of an app without the Console | `purchasely dashboard summary --app app_xxx --output table` |
| Find a user or a subscription for a support request | `purchasely users --help` |
| Audit the configuration of your apps in CI, for example find a placement without a screen | `purchasely placements list --app app_xxx` and `jq` |
| Prepare a change with an agent, and let a team member approve it | `--plan changes.json`, then `purchasely apply changes.json` |
| Export data to your own tools | `purchasely <resource> list --output json` |

# CLI or Management API?

The CLI uses the Management API. It does not add permissions: your API key and its scopes set what the CLI can do.

| | CLI | Management API |
| --- | --- | --- |
| Best for | A person in a terminal, a script, a CI job, an AI coding agent | Your backend and your internal tools |
| Setup | One install command, then `purchasely auth login` | An HTTP client in your code |
| Request format | Generated from the API specification, no HTTP code to write | You write each request |
| Rate limits | Request rate limited by the CLI, one retry after a `429` | You handle `429` and `X-RateLimit-*` |
| Confirmation of destructive writes | The CLI asks, or `--yes` | You send the request again with the `confirm_token` |
| Safety for agents | Read-only mode, write allow-list, plan then apply | You build them |
| Key storage | macOS keychain, or a file that only your user can read | Your secret manager |

Use the Management API when a service must call Purchasely in production. Use the CLI for all other uses.

> 🚧 Keep your API key secret
>
> A Management API key can change your catalog, screens and targeting. Do not put the key in a shared script or a public repository. In CI, keep it in the secret store of your CI.