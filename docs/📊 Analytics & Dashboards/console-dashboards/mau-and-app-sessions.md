# About this chart

The MAU & App Sessions page contains two charts that provide a high-level view of app engagement and Purchasely infrastructure performance. The first chart tracks Monthly Active Users and App starts over time. The second chart monitors Paywall Server Response Time, an operational metric for engineering teams.

Both charts rely on data collected through the Purchasely SDK. MAU and App starts are counted based on SDK sessions, not store-level or third-party analytics data.

# How to read the chart

## Chart 1: Monthly Active Users

This is a **combined bar and line chart** with two Y-axes.

| Element | Description |
|---------|-------------|
| **Blue bars** (left Y-axis) | Monthly Active Users count. Each unique user who opened the app at least once during the selected month is counted once, regardless of how many times they opened it. |
| **Black line** (right Y-axis) | App starts count. Each time the app is launched and the Purchasely SDK initializes, it counts as one app start. A single user opening the app 10 times generates 10 app starts but only 1 MAU. |
| **Headline number** | The total MAU for the most recent complete period (e.g., 610,979). |

The gap between the App starts line and the MAU bars indicates how frequently your average user opens the app. A large gap means high per-user session frequency.

## Chart 2: Paywall Server Response Time

This is a **multi-line chart** showing latency percentiles and request volume.

| Element | Description |
|---------|-------------|
| **P50 (green line)** | Median response time in milliseconds. Half of all paywall requests completed faster than this value. This represents the typical user experience. |
| **P95 (orange line)** | 95th percentile response time. 95% of requests completed within this time. Spikes here affect a meaningful portion of users. |
| **P99 (red line)** | 99th percentile response time. Only 1% of requests were slower than this. Useful for catching tail latency issues that affect edge cases. |
| **Requests (blue line)** (right Y-axis) | Total number of paywall server requests during the period. Helps correlate latency changes with traffic volume. |

A healthy chart shows stable, flat percentile lines with P50 well below P95 and P99. Sudden divergence between percentiles often indicates intermittent issues affecting a subset of requests.

# Controls

## Country filter

A dropdown defaulting to **All countries**. Select a specific country to filter both charts to traffic originating from that region. This is useful for identifying country-specific performance issues or understanding regional engagement patterns.

## Granularity toggle

Switch between time granularities to adjust the resolution of the data points displayed on the charts.

## Download CSV

Click the **Download CSV** button to export the currently displayed data. The export respects the active country filter, so you can extract region-specific datasets for further analysis.

# Common use cases

- **Track user growth trends** -- Compare MAU month over month to assess whether your user base is growing, stable, or declining. Pair this with App starts to understand if growth comes from new users or increased engagement from existing ones.
- **Measure engagement intensity** -- Divide App starts by MAU to compute the average number of sessions per user. An increasing ratio signals deeper engagement; a decreasing ratio may indicate retention issues even if MAU remains stable.
- **Diagnose regional latency problems** -- Use the Country filter on the Paywall Server Response Time chart to isolate regions with elevated P95 or P99 values. This helps engineering teams decide whether to investigate CDN configuration, regional infrastructure, or third-party dependencies.
- **Detect performance degradation after a release** -- Monitor the Paywall Server Response Time chart after deploying a new SDK version or backend change. A sudden increase in P95 or P99 that correlates with a release date signals a regression that needs investigation.
- **Correlate traffic spikes with latency** -- Overlay the Requests line with percentile lines to determine if latency increases are caused by traffic surges. If P95 and P99 spike while Requests remain flat, the issue is likely infrastructure-related rather than load-related.

# Frequently asked questions

## What counts as a Monthly Active User?

A Monthly Active User is any unique user whose app triggered at least one Purchasely SDK session during the calendar month. The count is deduplicated: a user who opens the app 50 times in a month is counted as 1 MAU. Users are identified by the Purchasely anonymous ID or, if set, the custom user ID provided via `Purchasely.userLogin()`.

## Why is MAU different from what I see in other analytics tools?

Purchasely MAU is based on SDK initialization events, not store downloads or third-party analytics sessions. Differences can arise because other tools may use different session definitions, attribution windows, or user identification methods. Purchasely counts a user as active only when the SDK successfully starts, which requires the app to fully launch and establish a connection.

## What does Paywall Server Response Time measure exactly?

It measures the time between the Purchasely SDK sending a request to fetch paywall configuration from the Purchasely server and receiving the full response. This includes network round-trip time, server processing, and payload transfer. It does not include local rendering time on the device after the response is received.

## Should I be concerned if P99 is high but P50 is normal?

Not necessarily. P99 captures the slowest 1% of requests, which often correspond to users on poor network connections, distant geographic regions, or devices with limited resources. However, if P99 trends upward over time while P50 remains stable, it may indicate an emerging issue that could eventually affect more users. Investigate by filtering by country to see if the latency is region-specific.

## Can I use this data to monitor the impact of SDK upgrades?

Yes. After rolling out a new SDK version, watch both charts. A sudden change in App starts might indicate initialization issues with the new version. Changes in Paywall Server Response Time percentiles could signal that the new SDK handles network requests differently. Compare the period before and after the rollout to assess impact.
