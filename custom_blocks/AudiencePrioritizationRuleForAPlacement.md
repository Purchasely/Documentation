---
name: Audience - prioritization rule for a placement
---
* When displaying a <Glossary>Placement</Glossary>, the SDK will check to which audience the user belongs by starting with the audience with the highest priority (= lowest value in the `Priority` column = the one on top of the placement)
  * if the user belongs to it, the associated screen is displayed
  * if the user does not belong to it, the SDK repeats the same operation with the second highest priority audience and so on and so forth
  * if the user does not belong to any audience associated with the <Glossary>Placement</Glossary>, it will display the screen associated with the audience *Everyone else*.
