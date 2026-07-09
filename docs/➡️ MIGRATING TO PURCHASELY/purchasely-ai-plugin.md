---
title: Purchasely AI Plugin
excerpt: Install and use the Purchasely AI Plugin to implement, review, debug and migrate your SDK integration
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
---
[Open the Purchasely AI Plugin on GitHub](https://github.com/Purchasely/Purchasely-AI-Plugin)

The Purchasely AI Plugin helps AI coding assistants understand Purchasely SDK integrations across iOS, Android, React Native, Flutter and Cordova. It gives your assistant Purchasely-specific playbooks, references and commands so it can implement the SDK, review an existing integration, debug common issues and migrate older SDK code.

Use it when you want to:

* implement Purchasely in a new app
* check whether an existing integration follows the recommended setup
* debug paywall display, purchase, deeplink or synchronization issues
* migrate an app from SDK v5 to SDK v6
* ask detailed SDK questions inside your coding assistant

The plugin is updated for every new SDK version. It is also updated between SDK releases when new integration topics, edge cases or questions come up with the Purchasely team, so the AI assistant can reference newer guidance faster than a full documentation cycle.

***

## What the plugin includes

The complete Claude Code plugin includes slash commands, skills, hooks, references and a Purchasely SDK expert agent. Other AI coding tools can install the portable skills and use the same implementation playbooks.

| Capability | Use it for |
|------------|------------|
| `purchasely-integrate` / `/purchasely:integrate` | Implement the SDK from scratch: install dependencies, initialize the SDK, display paywalls, configure deeplinks and set up transaction handling |
| `purchasely-review` / `/purchasely:review` | Scan an existing integration and report missing setup, deprecated APIs, risky patterns and recommended fixes |
| `purchasely-debug` / `/purchasely:debug` | Investigate common issues such as blank paywalls, screens closing unexpectedly, purchase failures, deeplink problems or synchronization errors |
| `purchasely-migrate` / `/purchasely:migrate` | Upgrade an existing integration to a newer SDK version, including the v5 to v6 builder APIs |
| `purchasely-sdk-expert` | Ask SDK questions and get platform-specific implementation guidance |

***

## Install it

Pick the installation path that matches your AI coding tool.

<Tabs>
  <Tab title="Claude">

    ```text
    /plugin marketplace add Purchasely/Purchasely-AI-Plugin
    /plugin install purchasely@Purchasely-AI-Plugin
    ```

    Claude Code gets the full plugin experience, including slash commands, skills, hooks, references and the SDK expert agent.

  </Tab>
  <Tab title="Codex">

    ```shell
    codex plugin marketplace add Purchasely/Purchasely-AI-Plugin
    ```

    Then open `/plugins`, search for `purchasely`, and install the plugin.

  </Tab>
  <Tab title="Other">

    ```shell
    npx skills add Purchasely/Purchasely-AI-Plugin
    ```

    This installs the portable Purchasely skills for AI assistants that support skills. It does not install Claude-only slash commands, hooks or the Claude SDK expert agent.

  </Tab>
</Tabs>

***

## Use it for a new implementation

After installing the plugin, ask your AI assistant to implement Purchasely for your platform and point it at the app module where the SDK should be installed.

<Tabs>
  <Tab title="Claude">

    ```text
    /purchasely:integrate ios
    /purchasely:integrate android
    /purchasely:integrate react-native
    /purchasely:integrate flutter
    /purchasely:integrate cordova
    ```

  </Tab>
  <Tab title="Codex / Other">

    ```text
    Use the purchasely-integrate skill to implement Purchasely in this app.
    Start by detecting the platform, then install the SDK, initialize it,
    display a first paywall and list anything I still need to configure
    in the Purchasely Console.
    ```

  </Tab>
</Tabs>

The assistant should inspect your project before editing it, follow the platform guide, and verify the resulting integration where possible.

***

## Use it to review an integration

Use the review skill once the SDK is implemented, before shipping to production or before asking Purchasely Support to investigate an issue.

<Tabs>
  <Tab title="Claude">

    ```text
    /purchasely:review
    ```

  </Tab>
  <Tab title="Codex / Other">

    ```text
    Use the purchasely-review skill to check this Purchasely integration.
    Verify SDK initialization, running mode, deeplink handling, paywall display,
    transaction handling, user identification and any deprecated APIs.
    ```

  </Tab>
</Tabs>

The review does not replace real sandbox testing, but it catches many implementation mistakes before you test purchases on a device.

***

## Use it to migrate to SDK v6

For SDK upgrades, ask the assistant to run the migration skill on the files that initialize Purchasely, display paywalls, preload presentations or intercept paywall actions.

<Tabs>
  <Tab title="Claude">

    ```text
    /purchasely:migrate
    ```

  </Tab>
  <Tab title="Codex / Other">

    ```text
    Use the purchasely-migrate skill to migrate this app to Purchasely SDK v6.
    Focus on SDK start, presentation builder usage, preload/display flows,
    action interception, deeplink renames and default running mode changes.
    ```

  </Tab>
</Tabs>

For the full v5 to v6 checklist, also read the [SDK 5 to 6 migration guide](migrating-from-sdk-5-to-6).
