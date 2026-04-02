---
title: Active users and app sessions
---
# About this chart

The MAU & App Sessions page contains two charts that provide a high-level view of app engagement and Purchasely infrastructure performance. The first chart tracks Monthly Active Users and App starts over time. The second chart monitors Screen Server Response Time, an operational metric for engineering teams.

MAU and App starts are counted based on SDK sessions, not store-level or third-party analytics data. More precisely, these metrics rely on the [UI / SDK event](ui-sdk-event) called `APP_STARTED`.

# How to read the chart

This is a **combined bar and line chart** with two Y-axes.

| Element                       | Description                                                                                                                                                                                                                                                                   |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Blue bars** (left Y-axis)   | Active Users count. Each unique user who opened the app at least once during the selected period is counted once, regardless of how many times they opened it.                                                                                                                |
| **Black line** (right Y-axis) | App starts represent SDK sessions. A new session is created each time the Purchasely SDK get initialized by the app, or after 30 minutes of user inactivity. A single user opening the app 10 times in a day generates 10 app starts, but counts as only 1 daily active user. |

The gap between the App starts line and the MAU bars indicates how frequently your average user opens the app. A large gap means high per-user session frequency.

<br />

# Common use cases

* **Track user growth trends** -- Compare MAU month over month to assess whether your user base is growing, stable, or declining. Pair this with App starts to understand if growth comes from new users or increased engagement from existing ones.
* **Measure engagement intensity** -- Divide App starts by MAU to compute the average number of sessions per user. An increasing ratio signals deeper engagement; a decreasing ratio may indicate retention issues even if MAU remains stable.

<br />

# Frequently asked questions

### What counts as an Active User?

An Active User is any unique user whose app triggered at least one Purchasely SDK session during a given period. The count is deduplicated: a user who opens the app 50 times in a month is counted as 1 MAU. Users are identified by the Purchasely anonymous ID or, if set, the custom user ID provided via `Purchasely.userLogin()`.

### Why is MAU different from what I see in other analytics tools?

Purchasely MAU is based on the SDK event APP_STARTED, not store downloads or third-party analytics sessions. Differences with other tools can arise from different session definitions, attribution windows, or user identification methods. Purchasely counts a user as active only when the SDK successfully initializes — which requires the app to fully launch and establish a connection. If the SDK is initialized late in the app startup routine, users who open the app but close it before the SDK starts will not be counted.

<br />

<br />
