---
title: Branch
excerpt: This Section describes how to integrate Branch with Purchasely
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Learn how to integrate Airship with Purchasely
  pages:
    - type: basic
      slug: airship
      title: Airship
---
# Integration

The integration of Branch requires 2 steps:

1. Associate the user to events by providing the Purchasely SDK with the customer user id provided to the Branch SDK
2. Activate the Branch integration in the Purchasely Console

> 🚧 Version compatibility
> 
> The minimal version of the Purchasely SDK supporting this integration is `v3.4.0`. 
> 
> If the Purchasely SDK integrated in your app is under the minimal version, please upgrade it.
> 
> The Branch SDK also needs to be integrated inside the app.

## 1. Associating users to events

To associate users, you will need to tell our SDK the `User ID` that is given to Branch SDK when using their `setIdentity()` method. 

Here are some links to the appropriate Branch documentation : [Android](https://help.branch.io/developers-hub/docs/android-advanced-features#track-users) and [iOS](https://help.branch.io/developers-hub/docs/ios-advanced-features#user-tracking)

Then, inform our SDK of the User ID used:

```coffeescript Swift
Purchasely.setAttribute(.branchUserDeveloperIdentity, value: "Actual Branch User ID")
```
```coffeescript Kotlin
Purchasely.setAttribute(Attribute.BRANCH_USER_DEVELOPER_IDENTITY, "Actual Branch User ID")

```
```coffeescript React Native
Purchasely.setAttribute(Attributes.BRANCH_USER_DEVELOPER_IDENTITY, "Actual Branch User ID");
```
```coffeescript Flutter

```
```coffeescript Cordova

```
```coffeescript Unity

```

## 2. Activating the Branch integration

### Retrieve your Branch API Key from Branch's dashboard

1. Follow the [Branch documentation](https://help.branch.io/using-branch/docs/profile-settings#branch-key-and-secret)
2. Write down your API Key

### Retrieve your Branch API Key from Branch's dashboard

1. Follow the [Branch documentation](https://help.branch.io/using-branch/docs/profile-settings#branch-key-and-secret)
2. Write down your API Secret

### Enabling the Branch integration in the Purchasely Console

1. Go in the "External integrations" section, and open the edition form for Branch:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/bf70b0d-Capture_decran_2024-07-15_a_11.54.21.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


2. Enable the integration

3. Set your Branch API Key

4. Set your Branch API Secret

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/327ba78-Capture_decran_2024-07-15_a_11.55.56.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


5. Enable the events you want to be sent to Branch
6. (Optional) Override the names of the events that will be sent to Branch

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/c8b9b3b-Capture_decran_2024-07-15_a_11.57.55.png",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


7. Save