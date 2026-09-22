---
title: Web2App FAQ · TikTok Pixel
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
# What does the TikTok integration do?

It reports your funnel events to a pixel in TikTok Events Manager, so your TikTok Ads campaigns can optimize on purchases. Step-by-step guide: [TikTok Pixel & Events API](web2app-tiktok-pixel).

# Where do I find my Pixel ID and access token?

In TikTok Events Manager, connect a Web data source with Manual setup and TikTok Pixel + Events API. The guided setup shows the Pixel ID and lets you generate the access token on the Implement Events API step. Skip the code installation steps: Purchasely does that.

# What is the access token for?

It lets Purchasely send purchases from its servers through the Events API, so a conversion is never lost to an ad blocker or an in-app browser. Both copies share the same event ID and TikTok deduplicates them. Optional but recommended.

# Which TikTok event should my campaign optimize on?

`CompletePayment`: it is the event Purchasely sends when the checkout is completed.

# Which events are sent to TikTok?

Four funnel events, each of which you can switch off under **Front events**: Page View (once when the funnel opens), Screen Viewed (each Screen), Purchase Tapped (a purchase button opens the checkout) and Purchase (checkout completed, with amount and currency). The mapping to TikTok event names is on [TikTok Pixel & Events API](web2app-tiktok-pixel).

# Does this also track what happens in my app?

No. This integration covers the web funnel only. In-app events are forwarded by the integrations configured under App settings → Integrations.

# Do I need to add a pixel or tag to my funnel?

No. Purchasely loads the TikTok tag on your funnels from the identifiers you enter here. Do not add it again through Custom JavaScript: events would be counted twice.

# When do changes apply?

Within minutes, on your live and sandbox funnels, without republishing.
