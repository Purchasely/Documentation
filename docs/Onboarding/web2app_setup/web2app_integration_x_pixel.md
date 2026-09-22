---
title: Web2App FAQ · X Pixel
excerpt: ''
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# What does the X integration do?

It reports your funnel events to X Ads Events Manager, from the visitor's browser, to measure and optimize your campaigns on X. Step-by-step guide: [X Pixel](web2app-x-pixel).

# Where do I find my Pixel ID and Event IDs?

In X Ads Manager, Tools → Events manager. The pixel ID is the five-character code shown next to your event source. Each event you create there (Purchase, Checkout initiated…) has its own Event ID in the form `tw-xxxxx-xxxxx`.

# Why do I need one Event ID per event?

X measures conversions per event you created in Events Manager. Paste each Event ID next to the matching event under Front events; events without an ID are not sent. At minimum, create and map Purchase.

# Are purchases sent server-side?

No. X receives browser events only, so ad blockers and some in-app browsers can block them. Compare with your Purchasely dashboards for the exact count.

# Which events are sent to X?

Four funnel events, each of which you can switch off under **Front events**: Page View (once when the funnel opens), Screen Viewed (each Screen), Purchase Tapped (a purchase button opens the checkout) and Purchase (checkout completed, with amount and currency). The mapping to X event names is on [X Pixel](web2app-x-pixel).

# Does this also track what happens in my app?

No. This integration covers the web funnel only. In-app events are forwarded by the integrations configured under App settings → Integrations.

# Do I need to add a pixel or tag to my funnel?

No. Purchasely loads the X tag on your funnels from the identifiers you enter here. Do not add it again through Custom JavaScript: events would be counted twice.

# When do changes apply?

Within minutes, on your live and sandbox funnels, without republishing.
