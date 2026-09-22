---
title: Web2App FAQ · Google Ads
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
# What does the Google Ads integration do?

It reports your funnel events as Google Ads conversions, matched to the ad click through the click ID that auto-tagging adds to your URLs. Step-by-step guide: [Google Ads](web2app-google-ads).

# Where do I find the Conversion ID and the labels?

In Google Ads, create a conversion action (Goals → Conversions → Summary → Create conversion action, source Website). In its tag setup, choose Use Google Tag Manager: the Conversion ID (`AW-…`) and the Conversion label are displayed. The Conversion ID is the same for all actions; each action has its own label.

# Why is nothing sent for an event?

Only events with a conversion label are sent. Create one action per event you want to measure and paste its label next to the event under Front events. At minimum, set a label on Purchase.

# Do I need auto-tagging?

Yes. Without it, Google cannot attribute the conversion to the click. Enable it in Admin → Account settings.

# Which events are sent to Google Ads?

Four funnel events, each of which you can switch off under **Front events**: Page View (once when the funnel opens), Screen Viewed (each Screen), Purchase Tapped (a purchase button opens the checkout) and Purchase (checkout completed, with amount and currency). The mapping to Google Ads event names is on [Google Ads](web2app-google-ads).

# Does this also track what happens in my app?

No. This integration covers the web funnel only. In-app events are forwarded by the integrations configured under App settings → Integrations.

# Do I need to add a pixel or tag to my funnel?

No. Purchasely loads the Google Ads tag on your funnels from the identifiers you enter here. Do not add it again through Custom JavaScript: events would be counted twice.

# When do changes apply?

Within minutes, on your live and sandbox funnels, without republishing.
