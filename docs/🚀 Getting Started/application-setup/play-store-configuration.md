---
title: Google Play Store configuration
excerpt: >-
  This section describes how to connect the Google Play Store with the
  Purchasely Console
deprecated: false
hidden: false
link:
  new_tab: false
metadata:
  title: ''
  description: >-
    This document provides instructions on how to connect your Google Play Store
    account with Purchasely by providing parameters such as Android App Bundle
    ID, App Scheme, and Access Key (JSON). It also includes steps for enabling
    the API on Google Cloud, creating a Service Account, and granting access to
    the Service Account in the Google Play Console.
  robots: index
---
To connect your Google Play Store account with Purchasely, you need to provide the following parameters from the Play Store Console:

1. [Android App Bundle ID](#1-android-app-bundle-id)
2. [App Scheme](#2-app-scheme)
3. [Access Key (JSON)](#3-access-key-json)

## 1. Android App Bundle ID

<PlayStoreAppBundleID />

<br />

## 2. App Scheme

<PlayStoreAppScheme />

## 3. Access Key (JSON)

<PlayStoreAccessKeyJSON />

<br />

### Enabling the API on Google Cloud

<EnableAPIOnGoogleCloud />

### Creating a New Service Account

<PlayStoreCreateANewServiceAccount />

7. In the Purchasely Console, fill in the `Access key (JSON)` field with this JSON file.

<Image align="center" border={true} src="https://files.readme.io/1d5ec4b-image.png" className="border" />

<br />

### Granting Access to the New Service Account

<PlayStoreGrantAccessToTheServiceAccount />

### Server-to-Server Notifications

<PlayStoreS2SNotifications />
