---
name: limitations synchronous display
---
Displaying a Screen as described above is synchronous, as such it always returns a View to be displayed. Consequently it carries a few limitations:

* You cannot pre-fetch the Screen
* A loading indicator is displayed until the network call is executed and the view fully rendered
* You cannot <Glossary>deactivate a placement</Glossary> to not display a Purchasely Screen, your default Screen will be displayed
* You cannot display [your own screen](leveraging-meta-data-with-your-own-paywall), your default Purchasely screen will be displayed

To overcome those limitations, you should consider using the [asynchronous](pre-fetching) method that allows you to pre-fetch the presentation and chose not to display a Screen for a specific placement.
