---
title: Configuring Audiences
excerpt: >-
  This section describes how to create audiences and use them for tailoring the
  screen displayed or running A/B tests
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Learn more about Built-in User Attributes and Customer User Attributes
  pages:
    - type: basic
      slug: user-attributes-list
      title: Understanding the different types of User Attributes
    - type: basic
      slug: custom-user-attributes
      title: Leveraging Custom User Attributes
---
An <Glossary>audience</Glossary> is a group that combines different user attributes using boolean operators. It is used to segment your users.

# Creating an audience

1. Navigate to the section [Audiences of your Purchasely Console](https://console.purchasely.io/audiences)
2. Click on the button **`+ New audience`** in the upper right corner

   <Image align="center" className="border" border={true} src="https://files.readme.io/660c1e7-image.png" />

   <br />
3. Fill in the following form by setting the following values:

   <Image align="center" className="border" border={true} src="https://files.readme.io/2eaef4c-image.png" />

   * `Name`: only displayed in the Purchasely Console
   * `ID`: internal unique identifier for the Audience. When an event ([UI/SDK event](ui-sdk-events) or [Server event)](server-events) will be generated for a user belonging to a particular audience, the property `audience_id` will be automatically attached to that event (see below).\
     **⚠️ The audience ID cannot be changed once the audience has been associated with an A/B test or a transaction**
   * `Tags`: as for other assets, you can associate different categories (`CONVERSION`, `RETENTION` etc...) with the audiences to be able to find them more easily in your Purchasely Console.
4. Combine together the desired \{user attributes, values} with boolean operators to create the conditions for a user to match the audience

   <Image align="center" className="border" border={true} src="https://files.readme.io/6bae80b-image.png" />

   * You can use and combine together both [built-in user attributes](user-attributes-list) and [custom user attributes](custom-user-attributes)
   * The boolean operators `AND` or `OR` can be used.\
     \=> Choose the main boolean operator you want to use for the audience by clicking the **`AND`** or **`OR`** buttons on the left side of the screen

     <Image align="center" className="border" border={true} src="https://files.readme.io/1f43c63-image.png" />
   * Subgroups can be created by clicking on the button **`+ AND/OR`** to allow different values for a same attribute or nest different conditions together\
     \=> Choose which boolean operator to apply to the subgroup you want to use for the audience by click on the button **`AND`** or **`OR`** on the left side of the modale.

     <Image align="center" className="border" border={true} src="https://files.readme.io/47e8035-image.png" />

     <br />
5. To remove a condition, click on the X button on its right

   <Image align="center" className="border" border={true} src="https://files.readme.io/b99cdbf-image.png" />
6. Save your audience by clicking on the **`Save`** button in the bottom right corner of the screen

<br />

> 📘 Understanding dates
>
> <Image align="center" src="https://files.readme.io/4db3b5f48d26d172e21de6297fe3858fa3248addecb1a745ca562fed9accaf9e-from_now_and_ago_2.jpg" />

<br />

# Modifying an existing audience

To modify an existing <Glossary>audience</Glossary>:

1. click on the **`⋮`** button on the right of the audience
2. then on `Edit`

   <Image align="center" className="border" border={true} src="https://files.readme.io/3cdcd45-image.png" />
3. make your modifications then click on the **`Save`** button in the bottom right corner of the screen

# Duplicating an existing audience

To duplicate an existing <Glossary>audience</Glossary>:

1. click on the **`⋮`** button on the right of the audience
2. then on `Duplicate`

   <Image align="center" className="border" border={true} src="https://files.readme.io/62bd6ae-image.png" />
3. then Edit the duplicated audience and adjust the auto-generated ID
4. and **`Save`** your modifications

# Deleting an audience

To delete an existing <Glossary>audience</Glossary>:

1. click on the **`⋮`** button on the right of the audience
2. then on `Delete`

   <Image align="center" className="border" border={true} src="https://files.readme.io/06a0e4a-image.png" />
3. Confirm your choice by ticking the check box and clicking on the **`Confirm`** button

   <Image align="center" className="border" border={true} src="https://files.readme.io/aa12ca5-image.png" />

> 🚧 Audiences cannot be deleted if they are associated with a running A/B test
>
> You need to stop all the A/B tests associated with the audience before deleting it.

> ❗️ Audience deletion cannot be undone
>
> In each placement in which the audience was used to display a particular screen, the association \{placement, audience, screen} will simply be removed.

# Leveraging Audiences

[More details on how to leverage Audiences to display different Screens and how to find them in Purchasely Analytics](leveraging-audiences)
