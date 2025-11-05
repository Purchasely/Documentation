---
title: Google Play Store configuration
excerpt: >-
  This section describes how to connect the Google Play Store with the
  Purchasely Console
deprecated: false
hidden: false
metadata:
  title: ''
  description: >-
    This document provides instructions on how to connect your Google Play Store
    account with Purchasely by providing parameters such as Android App Bundle
    ID, App Scheme, and Access Key (JSON). It also includes steps for enabling
    the API on Google Cloud, creating a Service Account, and granting access to
    the Service Account in the Google Play Console.
  robots: index
next:
  description: ''
---
In order to connect your Google Play Store account with Purchasely, you have to provide the following parameters from the Play Store Console

1. [Android App Bundle ID](#1-android-app-bundle-id)
2. [App Scheme](#2-app-scheme)
3. [Access Key (JSON)](#3-access-key-json)

# 1. Android App Bundle ID

<PlayStoreAppBundleID />

<br />

# 2. App Scheme

<PlayStoreAppScheme />

# 3. Access Key (JSON)

<PlayStoreAccessKeyJSON />

<br />

### Enabling the API on Google Cloud

<EnableAPIOnGoogleCloud />

### Creating a new Service Account

<PlayStoreCreateANewServiceAccount />

7. In the Purchasely Console, fill in the field `Access key (JSON)` with this JSON file

<Image align="center" className="border" border={true} src="https://files.readme.io/1d5ec4b-image.png" />

<br />

### Granting access to the new Service Account

<PlayStoreGrantAccessToTheServiceAccount />

### Server to Server notifications

<PlayStoreS2SNotifications />
