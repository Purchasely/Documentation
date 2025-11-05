---
title: >-
  Creating a post-paywall survey and gaining insights on why your users did not
  convert
excerpt: This
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Problematics

Some users dismiss the Paywall you present them but you don't know why?

You would like to gain insights on their reason and take an action tailored to their insights?

Purchasely has a solution for you!

Follow this step by step guide to implement a Post Paywall Survey and leverage it to improve your conversion rate!

<br />

# User journey

Step 1: Your Paywall

Step 2: The Survey

Step 3: The Action

<br />

# Implementation

<br />

## How to create a survey to understand why the user have dismissed the Paywall

<Image align="center" className="border" border={true} src="https://files.readme.io/7e330692a118670dd2a52928e793353043ba64c299a93ce3cbe88518d2ee0e73-image.png" />

### Survey Configuration

1. Survey ID:\
   *eg: post\_paywall\_survey*
2. Save answer in custom user attribute\
   *eg: dismiss\_reason / type: string*
3. Validation on selection: true

<br />

### Answers configuration

Each answer shall have a code

You can add a Second action linking to a new Screen taking action for that particular reason.

Eg: a promo-code if the user has an issue with the price

<br />

## How to open a survey when users dismiss your paywall?

Edit the settings of the Close button

Add a Secondary Action "Open Screen" linking
