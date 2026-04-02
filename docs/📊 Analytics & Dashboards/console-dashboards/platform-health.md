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

#
