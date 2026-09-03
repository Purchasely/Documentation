---
title: Custom User Attributes Implementation
excerpt: >-
  This page provides an overview of how to leverage Custom User Attributes to
  personalize the user journey and target specific user segments
deprecated: false
hidden: false
metadata:
  robots: index
---
<CustomUserAttributesDefinition />

<br />

<CustomUserAttributesImplementation />

> 📘 Attributes restored by a Web2App redemption (SDK 6.1.0)
>
> A successful [Web2App](web2app) redemption can carry a versioned `purchase_context` from the web funnel. The SDK restores the built-in and the custom user attributes of that context into its own stores.
>
> The SDK writes these attributes **before** it refreshes the entitlements. Every event that follows the redemption therefore already carries them. You do not have to set them again.

<br />
