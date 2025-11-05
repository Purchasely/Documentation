---
name: Deeplinks - supported deeplinks
---
# What are the supported deeplinks?

The Purchasely SDK manages deeplinks for:

* **Screens & Paywalls**\
  You can copy the deeplink of a screen by clicking on the 🔗 button of the Screen in the [Paywalls & Screens](https://console.purchasely.io/screen) section  of the Purchasely Console

  <Image align="center" className="border" border={true} src="https://files.readme.io/6f25cd0-image.png" />

  They have the shape `app_scheme://ply/presentations/[screen_id]`

<br />

* **Placements**\
  You can copy the deeplink of a <Glossary>placement</Glossary> by clicking on the 🔗 button of the <Glossary>placement</Glossary> in the [Placements](https://console.purchasely.io/placements) section of the Purchasely Console

  <Image align="center" className="border" border={true} src="https://files.readme.io/be1c577-image.png" />

  They have the shape `app_scheme://ply/placements/[placement_id]`

<br />

* **Update billing**\
  This deeplink `app_scheme://ply/update_billing` can be used to open the App Store / Play Store setttings to update credit card after a payment error
