---
title: Driving engagement and retention with Campaigns
excerpt: This page provides details about the Campaigns feature
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The **Campaigns** feature lets you create powerful no-code automations that will display a Purchasely Screen for a particular Audience at the App start.

They are particularly useful to:

- Convert users by proposing limited-time offers or discounts
- Implement retention strategies leveraging Promotional Offers targeting active subscribers about to Churn (voluntarily or involuntarily)
- Create win-back strategies leveraging Promotional Offer for lapsed subscribers
- Run user research or collect user insights by publishing surveys to targeted users

<br />

**⚠️ The Minimum SDK version required to use this feature is 5.1.0**

# Configuring a Campaign

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/b58b9618f19b5bb0cb900db6d8ccf2f6d047d4fca6ee9b97bf743f8bc97fe520-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


## How to set up a Campaign ?

For each campaign, you can define:

- **WHO** will be targeted by associating it with an Audience
- **WHEN** the campaign should trigger and define capping parameters
- **WHAT** Screen(s) should be displayed by selecting a Purchasely Screen or running an A/B test.

<br />

### Name and ID:

Set the name of your campaign and id. The name and ID you set here, helps you track the campaign performance within Purchasely. 

💡Adding a category lets you better organize the list of campaigns. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/8aefde9f6d1dbf09521a0caed643b7fe47d47dac5d0b1b16c1cccf7d609eb1ce-Screen_Recording_2025-03-17_at_08.18.47.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


### WHO - Audience:

Choose the [audience](https://docs.purchasely.com/docs/audiences) whom you would like to run this campaign for.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/39f15535bfa0e07b78da0bb8dd36249eebe44661cc65c629cbf5d5d0bea21add-who.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


If you haven't configured the desired audience yet, you can click on `+ Create new audience` and define your audience in the modale.

<br />

### When: Scheduling,Trigger, Capping

You can customize the following parameters to fine-tune your campaign behavior:

1. **Start date and time & end date & time** : Define the campaign’s activation and expiration times to automate promotional events (e.g., Black Friday sales) without requiring manual intervention in the Purchasely Console.  
   All times are expressed in UTC/GMT.
2. **Trigger**:By default, a campaign starts when the APP_STARTED event is triggered. This event occurs:
   - When the app is launched for the first time.
   - After the app is restarted following termination by the operating system (typically due to prolonged inactivity).
   - When the user manually relaunches the app.
     > ℹ️ `APP_STARTED` and other events
     > 
     > For now, the `APP_STARTED` event is the only one allowed but new events will be possible to use as a trigger in the months to come.
3. **Frequency cap**: Control how often the campaign is displayed to prevent overexposure and user fatigue. This configuration ensures a seamless and non-intrusive campaign experience for users while maximizing engagement.  
   The frequency cap can be configured in two ways:

   - **Session-based**: Limits campaign display based on app session count. 

     _Example: If set to trigger every 3 sessions, the campaign will appear at most once every 3 app launches._

     [block:image]{"images":[{"image":["https://files.readme.io/79a76de98e475eeb7b6f87a7cf4502b584181da11166167e052555be65036a62-image.png",null,""],"align":"center","border":true}]}[/block]

     Note: the SDK generates a new session after 30 minutes of inactivity
   - **Period-based**: Enforces a minimum time gap between consecutive displays.

     _Example: If set to a 2-day interval, the campaign will not be shown again until at least 48 hours have passed since the last display._

     [block:image]{"images":[{"image":["https://files.readme.io/eac0d395868e99e591d7f9062d723345a35d57545e56d88ebb2b9edfb0a1e008-image.png",null,""],"align":"center","border":true}]}[/block]

     <br />
4. **Impression cap**: Restricts the total number of times a user can see the campaign throughout its duration.

   _Example: If set to 3, the campaign will not be displayed to a user after they have seen it three times, regardless of triggers or frequency cap settings._

   [block:image]{"images":[{"image":["https://files.readme.io/131318f1eb1915ffaf86d87db20f74746d78bd086982a539b789fbfb986ff9cc-image.png",null,""],"align":"center","border":true}]}[/block]

   <br />
5. **Exposure window**: Defines the maximum time a user remains eligible to see the campaign after their first exposure. This is particularly useful for creating limited-time offers that expire after a defined period.

   It can be combined with a [countdown](countdown) component integrated into the Campaign Screen to reinforce urgency.

   _Example: If set to 24 hours, the campaign will only be available to a user for 24 hours after their first exposure, even if the overall campaign period is longer._

   [block:image]{"images":[{"image":["https://files.readme.io/d8a6662f73141d9eb4541c10a897b8115b2d43113764eebd1e6cec850129e14e-image.png",null,""],"align":"center","border":true}]}[/block]

   <br />

All the above-mentioned parameters can be combined to create highly customized campaign behaviors, allowing precise control over timing, frequency, exposure limits, and user experience.

### What: screen, A/B test:

In this section, you set up the Screen to be displayed or the you can run an A/B test.

This Screen does not need to be necessarily a Paywall. It can also be an onboarding Screen, a User Survey or any type of Screen

 For an A/B test, it can be either UI or Price A/B test. The following illustration shows how to choose a screen to display for this campaign. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/4b17afabacd455129049496f3408d5a87f06c5e46308b2fba51ae0082883408c-Screen_Recording_2025-03-17_at_09.15.05.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Once you are completed with your set up, click the Start button at the end of this page, to start the campaign.

Once a campaign has been started, you can still adjust the capping parameters (**start/end date & time**, **frequency capping**, **impression cap**, **exposure window**) but you **can't change** the **campaign's name** or **campaign's ID**  nor the associated **Audience** or **Screen**.

The results of the A/B test can be consulted in the [A/B test section of the Console](https://console.purchasely.io/ab-tests).

<br />

# Examples of Campaigns

| Type          | Name                        | Description |
| :------------ | :-------------------------- | :---------- |
| Conversion    |                             |             |
| Special offer | Black Friday Offer          |             |
| Engagement    | Collecting user preferences |             |
| Retention     |                             |             |
| Retention     |                             |             |
|               |                             |             |
|               |                             |             |