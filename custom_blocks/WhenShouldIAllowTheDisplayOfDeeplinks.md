---
name: Can I control when deeplinks are displayed?
---
# Can I control when deeplinks are displayed?

By **default**, Purchasely deeplinks are displayed **immediately** when they are received, so you do not have to do anything.

If your app has a launch routine that must complete before a screen can be shown (splash screen, onboarding, login…), you can **temporarily prevent** the display with `Purchasely.allowDeeplink(false)` and re-enable it with `Purchasely.allowDeeplink(true)` once your app is ready. Any deeplink received meanwhile is then displayed. See the method referred on the left.

A preview deeplink is an exception: it always displays immediately, and it bypasses `Purchasely.allowDeeplink(false)`. Android does this in every 6.x build, and iOS does this from 6.1.0. An author who scans a QR code expects the Screen.
