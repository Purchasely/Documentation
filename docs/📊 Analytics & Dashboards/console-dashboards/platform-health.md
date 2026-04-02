---
title: Platform health
deprecated: false
hidden: false
metadata:
  robots: index
---
# About this chart

The Platform health page provides a high-level view of Purchasely infrastructure performance. The chart monitors Screen Server Response Time, an operational metric for engineering teams.

The chart relies on data collected through the the CloudFlare CDN. 

# How to read the chart

This is a **multi-line chart** showing latency percentiles and request volume.

| Element                            | Description                                                                                                                                      |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **P50**                            | Median response time in milliseconds. Half of all Screen requests completed faster than this value. This represents the typical user experience. |
| **P95**                            | 95th percentile response time. 95% of requests completed within this time. Spikes here affect a meaningful portion of users.                     |
| **P99**                            | 99th percentile response time. Only 1% of requests were slower than this. Useful for catching tail latency issues that affect edge cases.        |
| **Requests (bars)** (right Y-axis) | Total number of Screen server requests during the period. Helps correlate latency changes with traffic volume.                                   |

A healthy chart shows stable, flat percentile lines with P50 well below P95 and P99. Sudden divergence between percentiles often indicates intermittent issues affecting a subset of requests.

# Common use cases

* **Diagnose regional latency problems** -- Use the Country filter on the Screen Server Response Time chart to isolate regions with elevated P95 or P99 values. This helps engineering teams decide whether to investigate CDN configuration, regional infrastructure, or third-party dependencies.
* **Detect performance degradation after a release** -- Monitor the Screen Server Response Time chart after deploying a new SDK version or backend change. A sudden increase in P95 or P99 that correlates with a release date signals a regression that needs investigation.
* **Correlate traffic spikes with latency** -- Overlay the Requests line with percentile lines to determine if latency increases are caused by traffic surges. If P95 and P99 spike while Requests remain flat, the issue is likely infrastructure-related rather than load-related.

# Frequently asked questions

### What does Paywall Server Response Time measure exactly?

It measures the time between the Purchasely SDK sending a request to fetch paywall configuration from the Purchasely server and receiving the full response. This includes network round-trip time, server processing, and payload transfer. It does not include local rendering time on the device after the response is received.

### Should I be concerned if P99 is high but P50 is normal?

Not necessarily. P99 captures the slowest 1% of requests, which often correspond to users on poor network connections, distant geographic regions, or devices with limited resources. However, if P99 trends upward over time while P50 remains stable, it may indicate an emerging issue that could eventually affect more users. Investigate by filtering by country to see if the latency is region-specific.
