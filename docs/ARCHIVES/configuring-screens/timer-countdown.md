---
title: Countdown paywalls and timers
excerpt: >-
  This section provides details on Countdown Paywalls and how to leverage timer
  tags inside Paywalls
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
Countdowns and timers are very useful to create a sentiment of urgency for the User and can therefore contribute to increasing conversion.

The Purchasely Platform propose 2 templates integrating countdowns:

- [Countdown](#countdown-paywall)
- [Countdown absolute & Feature list](#countdown-absolute--feature-list-paywall)

In this section, we also explore [how to create advanced scenario for limited time offers by leveraging user countdowns](#user-countdowns).

# Countdown Paywall

The Paywall called **Countdown** allows you to leverage a _relative timer_.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/54d3fb5-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


> 📘 This Paywall requires the version `3.4.0` of the SDK and above

### When to use it?

This Paywall is useful for showing limited time offers. The countdown restarts from the value defined every time it is displayed. Therefore, this Paywall is not meant to keep the countdown consistency across different Placements / Paywalls or displays.

### Display

This relative timer start counting down when the paywall is displayed. Every time the Paywall is displayed again, the relative timer is reset to the value defined in the Console.

### Configuration

The value of the relative countdown is defined  in the section **Countdown** of the Paywall (in seconds):

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/3cc87fc-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


# Countdown absolute & Feature list paywall

The Paywall called **Countdown absolute & Feature list** allows you to leverage an _absolute timer_. Absolute date allow you to define a common date for every users.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/58f5750-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


> 📘 This Paywall requires the version `4.1.0` of the SDK and above

### When to use it?

This Paywall is useful for showing limited time offers bound to a specific date, like Black Friday. Contrary to the relative time, the absolute time continues counting down until the absolute date is reached when you reopen a Paywall and does not restart. When the absolute date associated to the countdown is reached, the countdown displays 00:00:00:00.

### Configuration

The value of the absolute countdown can be configured by leverage a set of TIMER tags that you can put in the available fields of the Countdown section.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/7ddbadd-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


Here is how it works.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/f1acf1a-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


1. Put the cursor in the field `DIGITAL DAYS`
2. Click on the + Add Tags button that appears below the field
3. Add a TIMER
4. Choose Absolute countdown

   [block:image]{"images":[{"image":["https://files.readme.io/ddf704a-image.png",null,""],"align":"center","border":true}]}[/block]
5. Set the desired `Countdown date` (with the `hour`), `timezone` and choose the format `DD:hh:mm:ss`

   [block:image]{"images":[{"image":["https://files.readme.io/97965f9-image.png",null,""],"align":"center","border":true}]}[/block]
6. Click on the `OK` button
7. The tags associated to your date appear in the field

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/9d46926-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


8. Only keep the Tag `TIMER(DAYS)` in the field and remove all the remaining text including the tags `TIMER(HOURS)`, `TIMER(MINUTES)`, `TIMER(SECONDS)`
9. Repeat operations 1 to 8 for the fields `DIGITALS HOURS`, `DIGITAL MINUTES`, `DIGITAL SECONDS`

- For each field, choose the exact same date and timezone (the one you copied at step 6)
- Only keep the matching tag  
  _E.g.: `TIMER(HOURS)` for the field `DIGITAL HOURS` and remove the remaining text_

  [block:image]{"images":[{"image":["https://files.readme.io/060e405-image.png",null,""],"align":"center","border":true}]}[/block]

  <br />

# User countdowns

### When to use it?

**User countdowns** are a powerful tool to create dynamic scenarios based on user centric events.

They are particularly useful if you want to create limited time offers based on a user event such as the sign-up date.  
_E.g.: get a 30% discount on the yearly subscription if you become a premium member within the 3 days following your sign-up_

They rely on [User Attributes](user-attributes-list) (type: Date). 

Any Built-in User Attribute or [Custom User Attribute](custom-user-attributes) can be leveraged.

### General principle

The general principle consists in:

1. creating a [Custom User Attribute](custom-user-attributes#creating-a-new-customer-user-attribute) (type: Date)
2. integrating a User countdown tag leveraging this attribute and defining the offset - optional
3. creating an Audience that will display the paywall only to the relevant users
4. mapping this Audience with the Paywall integrating the User countdown on the desired Placements

### Configuration

1. Create the Custom User Attribute in the Purchasely Console

   [block:image]{"images":[{"image":["https://files.readme.io/0b22066-image.png",null,""],"align":"center","border":true}]}[/block]

   2 options are possible to set the Custom User Attribute value:

   1. Setting the value in the App code ([follow the guide for more details](custom-user-attributes)) 
   2. Letting the Paywall set the current date and hour when the Paywall will be displayed for the first time.  
      _When a Paywall containing a User Countdown leveraging an unset attribute is displayed, the Paywall automatically sets the value of the attribute to the current date and hour - `now()`._
2. Create a new Paywall and integrate a User countdown leveraging this attribute

   [block:image]{"images":[{"image":["https://files.readme.io/136d098-image.png",null,"The `Countdown in seconds` will be added to the date contained in the User Attribute. To configure 3 days following the sign-up date, we therefore set a Countdown of 259200 seconds (3 days in seconds)"],"align":"center","border":true,"caption":"The `Countdown in seconds` will be added to the date contained in the User Attribute. To configure 3 days following the sign-up date, we therefore set a Countdown of 259200 seconds (3 days in seconds)"}]}[/block]

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/2c235af-image.png",
        null,
        "Note: the User countdown might not display dynamically in the Preview (it will in the App)"
      ],
      "align": "center",
      "border": true,
      "caption": "Note: the User countdown might not display dynamically in the Preview (it will in the App)"
    }
  ]
}
[/block]


3. Create an Audience to define the conditions under which the Paywall must be displayed

   1. **Case 1: Custom Attribute set by the app code**  
      The first possibility is to [have the attribute set by the app code](custom-user-attributes#setting-custom-user-attributes) (which is our case for a sign-up date). In this the following condition is enough.

      [block:image]{"images":[{"image":["https://files.readme.io/422b236-image.png",null,"Users will belong to this Audience only if their sign-up date was less than 4 days ago. In other words, during the 3 days following their sign-up date"],"align":"center","border":true,"caption":"Users will belong to this Audience only if their sign-up date was less than 4 days ago. In other words, during the 3 days following their sign-up date"}]}[/block]
   2. **Case 2: Custom Attribute automatically set when the Paywall is displayed for the first time**  
      The second possibility is to let the Paywall set the date to the current date - `now()` - when it is displayed for the first time. In this case, you configure the Audience as follows:

      [block:image]{"images":[{"image":["https://files.readme.io/c21ab55-image.png",null,"For all the Users, the attribute `promotion Start Date`  is initially not set. Therefore, they will match the Audience and see the associated Paywall. Once they see it, the Paywall automatically sets the attribute to the current date and hour - `now()`. Then, they will match the Audience for the 3 following days and will stop matching it (and thus access the Paywall) once the countdown is finished."],"align":"center","border":true,"caption":"For all the Users, the attribute `promotion Start Date`  is initially not set. Therefore, they will match the Audience and see the associated Paywall. Once they see it, the Paywall automatically sets the attribute to the current date and hour - `now()`. Then, they will match the Audience for the 3 following days and will stop matching it (and thus access the Paywall) once the countdown is finished."}]}[/block]

      <br />
4. Map the Paywall and Audience on the desired Placement  
   _Users who are in the 3 days following their sign-up date will see the paywall Discount 30% following the signup Date, which integrates the User countdown of 3 days we configured above_

   [block:image]{"images":[{"image":["https://files.readme.io/3129339-image.png",null,"This Placement is automatically called by the app at the app launch. As it is associated to NONE for the Audience Everyone else, users which are not concerned by a promotion will not see any Paywall. "],"align":"center","caption":"This Placement is automatically called by the app at the app launch. As it is associated to NONE for the Audience Everyone else, users which are not concerned by a promotion will not see any Paywall. "}]}[/block]