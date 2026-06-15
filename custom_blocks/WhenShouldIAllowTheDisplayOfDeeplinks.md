---
name: Can I control when deeplinks are displayed?
---
# Can I control when deeplinks are displayed?

By **default**, Purchasely deeplinks are displayed **immediately** when they are received — you don't have to do anything.

If your app has a launch routine that must complete before a screen can be shown (splash screen, onboarding, login…), you can **temporarily prevent** the display with `Purchasely.allowDeeplink(false)` and re-enable it with `Purchasely.allowDeeplink(true)` once your app is ready. Any deeplink received meanwhile is then displayed. See the method referred on the left.
