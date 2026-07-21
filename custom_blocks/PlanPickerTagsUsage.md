---
name: Plan Picker - Leveraging Tags
---
## Leveraging tags

[Tags](tags) can be used inside Texts. You can either type them directly in plain text by putting them between pairs of curly brackets (eg: `{{PRICE}}` `{{AMOUNT}}` `{{DURATION}}`). You can also click on the **`{{TAGS}}`** button in the bar just above the text input.

If you want the tag to refer to the button mapped with the element, choose the option "Use element's plan / default plan" after selecting your tag:

<Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/d3f414ad991b1762ae6c9fce2a8bbbd43f05157bed88c6bdf74dafff06de766f-image.png" />

* In this case, the tag should appear without parameters when displayed in the text field.
* The advantage is that you will not need to update the tag if you update the Plan associated to the picker.

If you want the tag to refer to another Plan (eg: to strike through a former price), you can pick the desired Plan directly
