---
name: Tags - Timer - User countdown configuration
---
To use this tag, click on the tags and choose **Timer**

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/1938c1c-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Select the **User countdown**

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/e727cd8-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


1. Select the **user attribute** to set a countdown dynamically from the app. 
2. The **countdown in second** you choose is also the number of seconds that will be added to the one you set in the attribute. So the final countdown is attribute + countdown in seconds

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/3087176-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


3. When leveraging a Custom User Attribute for the count down (e.g.: _promotionStartDate, type:Date_) if it has not been set when the paywall is displayed, the SDK will automatically initialize it with the current date - `now()` - when the Screen is being displayed for the first time.