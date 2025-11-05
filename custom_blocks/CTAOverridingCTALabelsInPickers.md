---
name: CTA - overriding CTA Texts in Pickers
---
## Overriding the Texts of the CTA

In the Plan Picker, the collections starting with `CTA` allow to override the Texts of the CTA depending on which picker is currently selected:

- When the Picker will be selected by the user, the Texts in these collections will override the default Texts associated at the Purchase CTA level.
- Overriding the Texts is optional but if you override one of them, you must override them all.

Example:

- The default Text defined for the CTA is "Start my premium membership"
- This Text is overridden for each picker: 
  - "Start my **weekly** membership" for the Picker associated to the Weekly Plan
  - "Start my **monthly** membership" for the Picker associated to the Monthly Plan
  - "Start my **yearly** membership" for the Picker associated to the Yearly Plan

    [block:image]{"images":[{"image":["https://files.readme.io/845cfeb066c30d512d2707803e55f2051e87b9a686c677ef1068d9032c95123a-ezgif-3-edb54ad6cd.gif","",""],"align":"center","border":true}]}[/block]
- When a Picker is selected, the Text inside the CTA changes to match the value defined at the picker level