---
title: SDK versions
---
# About this chart

The SDK Versions chart shows the distribution of Purchasely SDK versions across your user base over time, broken down by platform. It displays two stacked bar charts -- one for iOS and one for Android -- so you can see at a glance which SDK versions your users are running and how adoption shifts day by day.

This is critical for planning SDK deprecation, validating feature rollouts, and ensuring your users have access to the latest screen designs and capabilities.

# How to read the chart

The page contains two separate **stacked bar charts**, displayed vertically:

| Chart                    | Description                                                                                          |
| ------------------------ | ---------------------------------------------------------------------------------------------------- |
| **iOS SDK versions**     | Distribution of Purchasely SDK versions across your iOS users. Labeled "SDK" in the top-left corner. |
| **Android SDK versions** | Same format, showing distribution across your Android users.                                         |

In each chart:

* The **X-axis** represents time (dates).
* The **Y-axis** represents user counts.
* Each **color** in the stacked bar corresponds to a specific SDK version (e.g., 5.0.1, 5.0.2, 5.1.0, 5.1.4). The legend at the bottom maps colors to version numbers.
* The **height of each colored segment** shows how many users are running that SDK version on a given day.
* The **total height of each bar** represents the total number of active users on that platform for that day.

A version that shrinks over time indicates users are updating their app. A version that appears suddenly means a new app release is rolling out.

<br />

# Common use cases

* **Plan SDK version deprecation** -- Monitor the percentage of users still on older SDK versions. When a legacy version drops below a meaningful threshold, you can safely deprecate it and simplify your codebase.
* **Validate an app release rollout** -- After shipping a new app version with an updated SDK, watch the new SDK version appear and grow in the chart. If adoption stalls, investigate whether the rollout is paused or users are not updating.
* **Ensure latest features compatibility** -- Use the chart to verify what share of your users have access to the latest features released in the SDK.
* **Measure app update campaign effectiveness** -- If you run in-app prompts, push notifications, or other campaigns encouraging users to update, compare the version distribution before and after the campaign to quantify its impact.
* **Detect platform-specific adoption gaps** -- Compare iOS and Android charts side by side. One platform may lag behind due to slower store review, staged rollouts, or different user behavior. This helps you decide whether to delay a feature that depends on a newer SDK version.

# Frequently asked questions

## Why do I see SDK versions I don't recognize?

The chart shows the exact SDK version string reported by the Purchasely SDK embedded in your app. If you see unexpected versions, check which Purchasely SDK version was bundled with each of your app releases. A mapping between your app version and the Purchasely SDK version is not maintained by Purchasely -- you need to track this in your own release notes or dependency files.

[SDK changelog](https://docs.purchasely.com/docs/changelog)

## Why are some users still on very old SDK versions?

Users who have not updated your app will continue running the SDK version that was bundled with the version they installed. Some users disable automatic updates or remain on older OS versions that prevent them from updating. This is normal and is exactly why this chart exists -- it helps you quantify how many users are affected.

## Can users on older SDK versions see my new paywalls?

It depends on the SDK version. Screen Composer screens require SDK 5.0.0 or later. Users on older versions will see the legacy fallback screen you configured in the Console (if any). If no fallback is set, those users will not see a paywall at all. Always configure a fallback screen when a significant portion of your user base is still on pre-5.0.0 versions.

## Why does the total user count fluctuate between days?

The chart reflects daily active users who triggered the SDK. Variations are normal and reflect natural fluctuations in app usage. Weekends, holidays, and seasonality all affect daily active user counts.
