---
title: Countdown
excerpt: This page provides details on the count down component
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# General Overview

Countdowns are a popular feature in paywalls. They create a sense of urgency and encourage users to take action before time runs out.

# Benefits of Countdown

**Drive Revenue**

Countdowns can also be an effective way to drive revenue for your business. By creating a limited time offer, you can entice users to make a purchase and generate more sales.

**Increase Conversions**

One of the main benefits of using countdowns in paywalls is that they can significantly increase conversions. By setting a limited time offer, users are more likely to make a purchase as they don't want to miss out on the deal.

# Countdown Configuration

## Countdown structure:

<Image align="center" className="border" border={true} src="https://files.readme.io/f218fc152e45df88c76988e9c0d867e43d1f604ef27924684ea267b0fbb53087-image.png" />

It has only one main section called Countdown where you can customize everything about your count down. 

### Countdown configuration

<Image align="center" className="border" border={true} src="https://files.readme.io/1c9f8de22c610689af0397fe6114798b9bd610655413b1f33eb55bc3671b9c14-image.png" />

1. **Settings**: Here you can set up the type of the count down. The time zone, format (date, hours, minutes and seconds), alignment, colour and background. 

***Relative:*** Relative data start counting down when the paywall is displayed. Every time the Paywall is displayed again, the relative timer is reset to the value defined in the Console.

*When to use it?*\
This Paywall is useful for showing limited time offers. The countdown restarts from the value defined every time it is displayed. Therefore, this Paywall is not meant to keep the countdown consistency across different Placements / Paywalls or displays.

<Image align="center" className="border" border={true} src="https://files.readme.io/650d8236ceb881c3984372f82ccb585b4328e1e2d52982a3d7b1d31e9be53e30-image.png" />

***Absolute***: Absolute date allow you to define a common date for every users.

*When to use it*?\
This Paywall is useful for showing limited time offers bound to a specific date, like Black Friday. Contrary to the relative time, the absolute time continues counting down until the absolute date is reached when you reopen a Paywall and does not restart. When the absolute date associated to the countdown is reached, the countdown displays 00:00:00:00.

<Image align="center" className="border" border={true} src="https://files.readme.io/c6b8d8eb7f9184da3ae68a48497521865c6dc737441be386bb949de03c2aa112-image.png" />

***User***:  User centric countdown is set based on the user attribute. 

*When to use it?*\
User countdowns are a powerful tool to create dynamic scenarios based on user centric events.

They are particularly useful if you want to create limited time offers based on a user event such as the sign-up date.\
E.g.: get a 30% discount on the yearly subscription if you become a premium member within the 3 days following your sign-up

They rely on User Attributes (type: Date).

Any Built-in User Attribute or Custom User Attribute can be leveraged.

**General principle**\
The general principle consists in:

1. creating a Custom User Attribute (type: Date)
2. integrating a User countdown tag leveraging this attribute and defining the offset - optional
3. creating an Audience that will display the paywall only to the relevant users
4. mapping this Audience with the Paywall integrating the User countdown on the desired Placements

<Image align="center" className="border" border={true} src="https://files.readme.io/80beb9ab78badeb6a19d2dd0946c3ba780de69f0225338f3a8bb99161fb18462-image.png" />

2. **Unit:** This section lets you add the label to the units based on the format you have selected in the settings. 

<Image align="center" className="border" border={true} src="https://files.readme.io/39f5ea1a640d3b522a6a4eda1703ede4426269f7214536164dcff8872d90d000-image.png" />

3. **On tap**: you can choose the action you would like when someone clicks on the countdown. It can be either one of the [actions](https://docs.purchasely.com/docs/action-types). 
4. **Background**: In this section you can set the background of this countdown block. 
5. **Border**: Set the border, border radius and colour in this section. 
6. **Size**: Here you can set up the overall size of the countdown block.
7. **Padding and Margin**: Padding is the space between the content of an element and its border. Margin is the space outside the border of an element, pushing it away from surrounding elements.

<Image align="center" className="border" border={true} src="https://files.readme.io/d9a3bd5321abf8a5b013eb5e98d0653b4b4e3377f46aba77961f8d93afd0bbe0-image.png" />
