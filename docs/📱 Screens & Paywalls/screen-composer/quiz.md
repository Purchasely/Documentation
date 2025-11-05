---
title: Quiz
excerpt: This section provides details on design considerations for the component Quiz
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
The Quiz component allows you to fetch user insights in no-code.

This page explains how to design a Quiz component.

For more details on the basic configuration of the Quiz and its data model, follow the guide: [Leveraging Quizzes to fetch User Insights](user-insights)

<br />

# Integrating the Quiz component into your Screen

Simply drag and drop a Quiz component from the library of components offered by the Screen Composer.

# Associating the Quiz component to a data model

After integrating the Screen, you need to associate it with a data model (field `Quiz (data model)`) of the component

You can either select a [Quiz object created in the section User insights of the Console](user-insights#1-creating-a-quiz), or directly create a new Quiz from the Screen Composer by clicking on the button "+ Create new Quiz"

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/103e260523a0c4f2b4383ca2d3e3fafb3e77e279c64ec634ee0a07235db45d54-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

# Designing the Quiz component

### Configuring the Answers layout and style

**Answers styles**

Answers styles (except the Texts of the Answers) are common to all the answers and defined at the level of the parent element. They must be defined for both states: unselected and selected

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/4b250dacde748f1a9dc4f75f7ca062f16161cc188e4e5fadad3cab471805274d-answers_styles.gif",
        "",
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


<br />

**Answers icon**

- You can activate or deactivate the Icon. 
- If you activate it, by default the image applied will be the same to all the answers depending on their state: `unselected` / `selected`

  [block:image]{"images":[{"image":["https://files.readme.io/d61a145bf50d8c566c3397242cac6b3c63e0e295531a9ade459fce2162978bb5-answers_icon.gif","",""],"align":"center","border":true}]}[/block]
- Alternatively, you can also define a specific icon for each answer on the answers themselves.
- The `icon size`, `icon alignment` (`left` or `right`), icon vertical alignement (`top`, `middle`, `bottom`) and `vertical offset` can be adjusted
- By enabling `Text and Icon centered`, you can wrap the icon & the Texts inside button at the center of the button

  [block:image]{"images":[{"image":["https://files.readme.io/3dd6ac20fd3842db5ce1e80a836b1a32e40cf7dd060887b739297f05e6ba20c7-answers_layout.gif","",""],"align":"center","border":true}]}[/block]

<br />

**Answers layout**

- `Full width`: allows you to extend the answer to fit 100% of the width available. If deactivated, the width of the answer will hug its content.
- `Min height`: defines the minimum height for the picker. If the content overflows and does not fit in that height, the answer picker will extend its height.
- `Space between answers`: defines the spacing between the pickers

<br />

### 3. Configuring the Question Text(s)

In the Question section, you can add Texts and apply a style to each of them

### 4. Configuring the Answers available and associated Texts

For each Answer / Option displayed, you need to configure both a `Value` and the `Text(s)` you want to be displayed on the Screen.

- `Value` : select one of the unique language-independent values configured in the data model of the Quiz.  
  You can also add a new one by clicking on the button "+ Add a new answer".

  ![](https://files.readme.io/c9f05916fce0c1f755e9fe5e09b3845afde98be4f69c00f6dd2eae3b62eebd0e-image.png)

  <br />
- `Texts` can be added as sub-elements of the Answer. They are associated with specific styles and can be localized.  
  _2 users with different locales will see the Texts of the answers localized_

  [block:image]{"images":[{"image":["https://files.readme.io/50535cfa97285b8988d1865c0ae7210130c835b74915045aa08289b912a74bbe-image.png",null,""],"align":"center","border":true}]}[/block]

When the switch `Selected by default` is enabled, the corresponding Answer will be automatically selected by default when the Screen gets displayed, without needing an interaction from the user. This can be used for opt-outs options.

<br />

### 5. Configuring the CTA associated to the Quiz

If the Quiz is configured with the option "Validate on selection" deactivated or the option "Multiple answers" activated, you need to associate the Quiz with a CTA for Quiz

- if the survey is configured with the option `Validate on selection` **enabled** => no CTA is required, the answer will be automatically submitted as soon as the user selects it.
- if the survey is configured with the option `Validate on selection` **disabled** => you need to add a distinct composant `CTA for Quiz` to your screen so that users can submit their answers.

  ![](https://files.readme.io/890bb2d87d09a4993efd422515b669073a2a1844fa4328538eb949df78b4f385-image.png)

  <br />

  - In the latter case, click on Add component, then drag & drop the component `CTA for Quiz` into the desired surface  
    Note: This surface can be different from the one containing the Multiple choice question component.

To make the CTA and the Quiz work together, they need to be associated with the same `Quiz (data model)`.

This CTA for Quiz offers the same display and layout options as a standard button. 

**Status of the CTA for Quiz**:

- If the Quiz is skippable (parameter `Skippable` activated) or the minimum number of answers has not been selected (`Multiple answers` activated and `Minimum number of answers` > number of answers selected by the user), the CTA will be displayed in the state disabled and it will not be possible to submit the answer / go to the next screen.
- You can define 2 different styles for the CTA depending on its state: `active` / `disabled`

  [block:image]{"images":[{"image":["https://files.readme.io/e670fce11066c9da222f2de34dea5195330435b7d215a9350165f68a87e21110-cta_validation_styles.gif","",""],"align":"center","border":true}]}[/block]

<br />

You can also associate the CTA with a `second action (optional)` that will you Open a Screen, a Placement, a Deeplink or Simply close the current Screen after the answer has been submitted by the user.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/9aba25951b07140e3270b78022f5d8ffd0b57d745789f01f2f7450c41a5d571b-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]