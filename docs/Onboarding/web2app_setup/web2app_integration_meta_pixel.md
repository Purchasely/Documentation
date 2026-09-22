---
title: Web2App FAQ · Meta Pixel
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
# What does the Meta integration do?

It reports your funnel events to a dataset in Meta Events Manager, so your Facebook and Instagram campaigns can optimize on real conversions and build audiences. Step-by-step guide: [Meta Pixel & Conversions API](web2app-meta-pixel).

# Where do I find my Pixel ID?

In Meta Events Manager, open your dataset and its Settings tab: the Dataset ID is the Pixel ID, a number without letters. Create a dedicated dataset for your funnels if you do not have one.

# What is the Conversions API access token for?

It lets Purchasely send purchases again from its servers, so a conversion is never lost to an ad blocker or an in-app browser. Browser and server copies share the same event ID and Meta counts one conversion. Generate it in Events Manager, under Set up Conversions API → Set up manually. Optional but recommended.

# Purchases are counted twice

Browser and server events reach different datasets, or the Pixel ID here does not match the dataset of the token. Use the same dataset for both.

# Which events are sent to Meta?

Four funnel events, each of which you can switch off under **Front events**: Page View (once when the funnel opens), Screen Viewed (each Screen), Purchase Tapped (a purchase button opens the checkout) and Purchase (checkout completed, with amount and currency). The mapping to Meta event names is on [Meta Pixel & Conversions API](web2app-meta-pixel).

# Does this also track what happens in my app?

No. This integration covers the web funnel only. In-app events are forwarded by the integrations configured under App settings → Integrations.

# Do I need to add a pixel or tag to my funnel?

No. Purchasely loads the Meta tag on your funnels from the identifiers you enter here. Do not add it again through Custom JavaScript: events would be counted twice.

# When do changes apply?

Within minutes, on your live and sandbox funnels, without republishing.
