---
title: Transferring Apple and Google account
excerpt: >-
  This article will guide you through process of transferring your Apple and
  Google account from one developer to another
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
## Transfer of Apple account

1. Identify which StoreKit version the app integrates:
   * **StoreKit 1** — verify that the shared app secret configured in App Store Connect matches the one set in the Purchasely console.
   * **StoreKit 2** — once the transfer is complete, create a new key in App Store Connect and add its credentials to the Purchasely console.
2. Allow 5-10 minutes of delay for the service to resume once credentials are updated.
3. Confirm that the StoreKit configuration on the new Apple developer account matches the one used previously.

<Image align="center" className="border" border={true} src="https://files.readme.io/518bcb7fc7294c0103a3877149e792441cfe27ca5b5f9c8648f3812fb6037ca5-image.png" />

4. Verify that the new Apple developer account has the Paid Applications Agreement signed and accepted. Without it, users will not see prices on paywalls.

## Transfer of Google account

Follow the standard account transfer instructions for step-by-step guidance.

To avoid a 24-48 hour delay for Google to accept the new account credentials:

1. When creating the new service account, complete only through step 6 of the procedure.
2. Invite the old service account to the new developer console and grant it permissions on both the new and old accounts.
3. Wait 48 hours, then complete step 7 of the procedure.

Keeping the old account active with the appropriate permissions during this window lets the transfer take effect without incurring the usual 24-48 hour delay.

If the Android development team manages this separately, share these instructions with them.