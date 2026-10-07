---
title: Tags
excerpt: >-
  This section provides details about the Price Tags available in the Screen &
  Paywall Builder
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# What are tag used for?

Purchasely has a tagging system to fetch information about the price and duration of subscriptions and one-time purchases, as well as the Introductory Offer (for user acquisition) and Promotional Offer (winback/retention) prices and durations.

Thanks to these tags, you don't have to hard code price for each and every stores in your screens and paywalls.

Using these tags will also ease to make your paywall compliant with the App Store Guidelines.

> 📘 You should be transparent about the plan price in your Paywalls. If you have any introductory offer or promotional offer, you should mention how much the user will pay after the offer ended.

## Where can you use tags?

Tags can be used in any label on a Screen. You can add them by simply clicking on the `{{TAG}}` button of the text field.

<Image align="center" border={false} src="https://files.readme.io/1a358a8da1b12806e775d9a6030a7bdbe95a4c8076d0fc112c949c888315daf1-tags.gif" />

You can also directly type them in plain text. To do so, put the name of the tag between 2 pairs of curly brackets. Eg: `{{PRICE}}`

<br />

## What are the options when using tags?

You can use 2 types of tags.

* Tags with no parameters refer to the Plan directly mapped with the parent element (eg: the picker to which the text belongs or the purchase button) or to the default Plan configured for this Screen. 

  => This way, if you change the Plan associated with the button / picker (or run an Price A/B test), you won't need to update the tag.
* Tags with parameters are mapped with a specific Plan. They appear with the reference of the Plan selected between brackets. If you want to use them, simply select the desired Plan in the widget.

  <Image align="center" border={true} src="https://files.readme.io/e8418dc4efcb59916fd79b06f439868751db70af03bb0e5697b8f1dcb168a0ab-tags_parameters.gif" className="border" />

  They can be used to reference another Plan in a picker or button than the one which it is mapped with, or to associate a Plan which is not the default one.

<Image align="center" alt="The tag $59.99 references a different Plan than the one associated to the plan picker" border={true} caption="The strikethrough price is a reference to another Plan than the one associated with the picker" src="https://files.readme.io/3d21534-image.png" />

<br />

> 🚧 Why does the preview display a `$XX.XX` instead of the actual price?
>
> In some cases, tags cannot be displayed properly in the preview of the Console. They are replaced by `X.XX`
>
> 📚 More information: [Prices in the Console preview](preview#prices-in-the-console-preview)

# Types of tags

## General tags:

These tags are most common tags that used in all the paywalls. 

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Tag
      </th>

      <th>
        Usage
      </th>

      <th>
        Example
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        `PRICE`
      </td>

      <td>
        Full price with period (e.g., $9.99/month)
      </td>

      <td>
        "Subscription will be renewed at \{\{PRICE\}\}"
      </td>
    </tr>

    <tr>
      <td>
        `AMOUNT`
      </td>

      <td>
        Price without period (e.g., $9.99)
      </td>

      <td>
        "Your lifetime plan costs \{\{AMOUNT\}\}"  
      </td>
    </tr>

    <tr>
      <td>
        `PERIOD`
      </td>

      <td>
        Billing period unit (e.g., month, year)
      </td>

      <td>
        Billed every \{\{PERIOD\}\}
      </td>
    </tr>

    <tr>
      <td>
        `DURATION`
      </td>

      <td>
        Total duration   
        (e.g., 1 month, 1 year).
      </td>

      <td>
        Access for \{\{DURATION\}\}
      </td>
    </tr>
  </tbody>
</Table>

<br />

## Duration tags

These tags help you display the subscription duration in days, weeks , months and etc.

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Name
      </th>

      <th>
        Usage
      </th>

      <th>
        Example
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        `DAYS_DURATION`
      </td>

      <td>
        Duration in days
      </td>

      <td>
        For a renewing plan:

        * Subscription starting from **\{\{PRICE}}** is **\{\{DAILY_AMOUNT}}**/day during **\{\{DAYS_DURATION}}**.
        * The output will be:  
          _Subscription starting from $6.99/week is $0.99/day only during 7 days._
      </td>
    </tr>

    <tr>
      <td>
        `WEEKS_DURATION`
      </td>

      <td>
        Duration in weeks
      </td>

      <td>
        For a renewing plan:

        * Subscription starting from **\{\{PRICE}}** is **\{\{WEEKLY_AMOUNT}}**/week during **\{\{WEEKS_DURATION}}**.
        * The output will be:  
          _Subscription starting from $6.99/month is $1.75/week during 4 weeks._
      </td>
    </tr>

    <tr>
      <td>
        `MONTHS_DURATION`
      </td>

      <td>
        Duration in months
      </td>

      <td>
        For a renewing plan:

        * Subscription starting from **\{\{PRICE}}** is **\{\{MONTHLY_AMOUNT}}**/month during **\{\{MONTHS_DURATION}}**.
        * The output will be:  
          _Subscription starting from $24.99/year is $2.08/month only during 12 months._
      </td>
    </tr>

    <tr>
      <td>
        `QUARTERS_DURATION`
      </td>

      <td>
        Duration in quarters
      </td>

      <td>
        For a renewing plan:  
        _Subscription starting from**\{\{PRICE}}** is **\{\{QUARTERLY_AMOUNT}}**/quarter during **\{\{QUARTERS_DURATION}}**._

        The output will be:  
        _Subscription starting from 24€99/year is $6.24/quarter only during 4 quarters._
      </td>
    </tr>

    <tr>
      <td>
        `YEARS_DURATION`
      </td>

      <td>
        Duration in years.
        If the subscription is less than a year, the output will be 0.
      </td>

      <td>
        For a renewing plan:  
        _Subscription starting from**\{\{PRICE}}** is **\{\{YEARLY_AMOUNT}}**/year for **\{\{YEARS_DURATION}}**._

        The output will be:  
        _Subscription starting from $119.99/year is $119.99/year only for 1 year._
      </td>
    </tr>
  </tbody>
</Table>

<br />

## Subscription cost per duration tags

Perfect for showing equivalent cost breakdowns, useful when comparing plans.

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Name
      </th>

      <th>
        Usage
      </th>

      <th>
        Example
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        `DAILY_AMOUNT`
      </td>

      <td>
        Cost per day
      </td>

      <td>
        For a renewing plan:

        * Subscription costs **\{\{DAILY_AMOUNT}}** only per day.
        * The output will be:  
          _Subscription costs $0.49 only per day._
      </td>
    </tr>

    <tr>
      <td>
        `WEEKLY_AMOUNT`
      </td>

      <td>
        Cost per week
      </td>

      <td>
        For a renewing plan:  
        _Subscription costs**\{\{WEEKLY_AMOUNT}}** only per week._

        The output will be:  
        _Subscription that costs $2.78 only per week._
      </td>
    </tr>

    <tr>
      <td>
        `MONTHLY_AMOUNT`
      </td>

      <td>
        Cost per month
      </td>

      <td>
        For a renewing plan:

        * Subscription costs **\{\{MONTHLY_AMOUNT}}**only per month.
        * The output will be:  
          _Subscription costs $6.99 only per month._
      </td>
    </tr>

    <tr>
      <td>
        `QUARTERLY_AMOUNT`
      </td>

      <td>
        Cost per quarter
      </td>

      <td>
        For a renewing plan:  
        _Subscription costs**\{\{QUARTERLY_AMOUNT}}** only per quarter._

        The output will be:  
        _Subscription costs $18.99 only per quarter._
      </td>
    </tr>

    <tr>
      <td>
        `YEARLY_AMOUNT`
      </td>

      <td>
        Cost per year
      </td>

      <td>
        For a renewing plan:

        * Subscription costs **\{\{YEARLY_AMOUNT}}** only per year.
        * The output will be:  
          _Subscription costs $25.99 only per year._
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_DAILY_AMOUNT`
      </td>

      <td>
        Displays the cost of the Introductory Offer or Promotional Offer of a Plan per day.
      </td>

      <td>
        For a renewing plan:

        * Special offer: **\{\{OFFER_DAILY_AMOUNT}}** only per day.
        * The output will be:  
          _Special offer: $0.49 only per day._
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_WEEKLY_AMOUNT`
      </td>

      <td>
        Displays the cost of the Introductory Offer or Promotional Offer of a Plan per week.
      </td>

      <td>
        For a renewing plan:  
        _Subscription costs**\{\{OFFER_WEEKLY_AMOUNT}}** only per week._

        The output will be:  
        _Subscription that costs $2.78 only per week._
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_MONTHLY_AMOUNT`
      </td>

      <td>
        Displays the cost of the Introductory Offer or Promotional Offer of a Plan per month.
      </td>

      <td>
        For a renewing plan:

        * Subscription costs **\{\{OFFER_MONTHLY_AMOUNT}}**only per month.
        * The output will be:  
          _Subscription costs $6.99 only per month._
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_QUARTERLY_AMOUNT`
      </td>

      <td>
        Displays the cost of the Introductory Offer or Promotional Offer of a Plan per quarter.
      </td>

      <td>
        For a renewing plan:  
        _Subscription costs**\{\{OFFER_QUARTERLY_AMOUNT}}** only per quarter._

        The output will be:  
        _Subscription costs $18.99 only per quarter._
      </td>
    </tr>

    <tr>
      <td>
        `OFFER_YEARLY_AMOUNT`
      </td>

      <td>
        Displays the cost of the Introductory Offer or Promotional Offer of a Plan per year.
      </td>

      <td>
        For a renewing plan:

        * Subscription costs **\{\{OFFER_YEARLY_AMOUNT}}** only per year.
        * The output will be:  
          _Subscription costs $25.99 only per year._
      </td>
    </tr>
  </tbody>
</Table>

<br />

## Price & Percentage comparison tags

These tags comes handy for your to calculate percentage difference and the price difference between 2 different plans and show them automatically in the respective currency.

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th>
        Name
      </th>

      <th>
        Usage
      </th>

      <th>
        Example
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>
        `PERCENTAGE_COMPARISON`
      </td>

      <td>
        Compares the first plan against the second one
      </td>

      <td>
        With:

        * yearly: $99.99/year
        * monthly: $9.99/month
          * **\{\{PERCENTAGE_COMPARISON(YEARLY,MONTHLY)}}** will display 17%
          * **\{\{PERCENTAGE_COMPARISON(MONTHLY,YEARLY)}}** will display 20%
      </td>
    </tr>

    <tr>
      <td>
        `DISCOUNT_PERCENTAGE`
      </td>

      <td>
        Discount % between two plans.  
        The first plan is the one being described. The second is the one to compare it with.   
        The order in which the plans are selected matters.
      </td>

      <td>
        With:

        * yearly: $99.99/year
        * monthly: $9.99/month
          * **\{\{DISCOUNT_PERCENTAGE(YEARLY,MONTHLY)}}** will display 17%
          * **\{\{DISCOUNT_PERCENTAGE(MONTHLY,YEARLY)}}** will display 17%
      </td>
    </tr>

    <tr>
      <td>
        `RAISE_PERCENTAGE`
      </td>

      <td>
        % increase between plans. 
        The order in which the plans are selected **does not** matter.
      </td>

      <td>
        With:

        * yearly: $99.99/year
        * monthly: $9.99/month

          * The output will be:
          * **\{\{RAISE_PERCENTAGE(YEARLY,MONTHLY)}}** will display 20%
          * **\{\{RAISE_PERCENTAGE(MONTHLY,YEARLY)}}** will display 20%
      </td>
    </tr>

    <tr>
      <td>
        `PRICE_COMPARISON`
      </td>

      <td>
        Raw price difference.  
        The price difference is computed with the periodicity of the first plan selected.
      </td>

      <td>
        With:

        * yearly: $99.99/year
        * monthly: $9.99/month

          * The output will be:
          * **\{\{PRICE_COMPARISON(YEARLY,MONTHLY)}}** will display $19.89  
            => the monthly plan costs $19.89 more than the yearly plan on a yearly base
          * **\{\{PRICE_COMPARISON(MONTHLY,YEARLY)}}** will display $1.66  
            => the monthly plan costs $1.66 more than the yearly plan on a monthly base
      </td>
    </tr>
  </tbody>
</Table>

<br />

## Offer tags

These tags can be used to display the price and duration of the both introductory/new user acquisition offers and Winback/retention offers you have created in the stores and declared in the Purchasely console.

<TagsPromotionOffersTags />

## Countdown tag

These set of tags are very useful to create dynamic countdowns. You can integrate them in any label of your Screen. 3 different types of Timers are offered:

* Relative countdown
* Absolute countdown
* User countdown

Timers are not only a simple tag but rather a _set of tags_ composed of different sub-tags (`TIMER(MONTHS)`, `TIMER(DAYS)`, `TIMER(MINUTES)`, `TIMER(SECONDS)`) that can be manipulated independently.

Depending on the format you associate to the Tag, they will appear in the text field with the following format:

<Image align="center" border={true} src="https://files.readme.io/fd75492fac841c3cab8c4e8944bd4b21ca81813e0fa640520a6645ada12e34d2-image.png" className="border" />

They are actually a composition of several tags. In the case above:

* one for hours
* one for minutes
* one for seconds

By default, the tags are separated by colon (":"). You can replace the colons by any string you want directly in the text field:

<Image align="center" border={true} src="https://files.readme.io/e64ffadbb3bef77f124e4b896f6349365761e55b1bd7d8d3d255c2c11c102801-image.png" className="border" />

<br />

For more information and capabilities about Countdowns. have a look at the [Countdown component](countdown)

## User attribute tags

User attribute tags show the value of a [Custom User Attribute](custom-user-attributes) in a label. Your app sends the value, and the Screen shows it. For example, use them to greet the user by name or to show a number of articles read.

> 📘 Available from SDK 6.0.0
>
> User attribute tags need the native SDK 6.0.0 or higher on iOS and Android. This also applies to the React Native, Flutter and Cordova SDKs, which use the native SDKs. Older SDK versions do not replace these tags.

### Syntax

A user attribute tag uses the [Liquid](https://shopify.github.io/liquid/) syntax:

```liquid
{{ user.<attribute_key> | default: "<fallback>" | <filter> }}
```

* `user.<attribute_key>` is the key of the attribute, as declared in the [User Attributes](https://console.purchasely.io/user-attributes) section of the Console.
* `default` is the text to show when the user does not have a value for this attribute.
* The filters are optional. They change the format of the value. You can chain them.

Examples:

```liquid
Hello {{ user.firstname | default: "friend" | capitalize }}!
```

* If `firstname` is `"julie"`, the device shows: Hello Julie!
* If `firstname` is not set, the device shows: Hello Friend!

```liquid
You read {{ user.articles_read | default: "0" }} articles this month
```

* If `articles_read` is `12`, the device shows: You read 12 articles this month

You can mix user attribute tags with the other tags in the same label, for example `{{ user.firstname | default: "" }}, get 1 year for {{PRICE}}`.

### Add a user attribute tag in the Screen Composer

1. Select a text component. In the **Text** section, click the `{{TAG}}` button of the text field.
2. In the **User attributes** category, click `USER_ATTRIBUTE`. Type `user` in the search field to find it quickly.

   <!-- TODO(screenshot): upload tmp/user-attribute-tags/1-tag-menu.png to ReadMe and replace the src -->
   <Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="The tag menu of a text field, filtered on the User attributes category" />

3. **PARAM 1**: select the attribute. The list shows:
   * your Custom User Attributes of type `String`, `Int`, `Float` and `Date`,
   * the Insight Attributes of type `String`,
   * the start and renewal dates of the active subscription, and the dates of the expired subscription.

   To declare a new attribute, click **Create new Custom User Attribute** at the bottom of the list.

   <!-- TODO(screenshot): upload tmp/user-attribute-tags/2-choose-attribute.png to ReadMe and replace the src -->
   <Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="PARAM 1 - choose the user attribute" />

4. **PARAM 2**: type the default value. The Screen shows this value when the user does not have a value for the attribute. Click **Next**.

   <!-- TODO(screenshot): upload tmp/user-attribute-tags/3-default-value.png to ReadMe and replace the src -->
   <Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="PARAM 2 - type the default value" />

5. **PARAM 3** (optional): click one or more formatters to add them to the chain. The **Preview** line shows the result with the default value.

   <!-- TODO(screenshot): upload tmp/user-attribute-tags/4-filters.png to ReadMe and replace the src -->
   <Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="PARAM 3 - a chain of two formatters, round and append, with its preview" />

6. Click **Save** to insert the tag with its formatters, or **Skip** to insert it without formatters.

The Console preview has no user, so it shows the default value.

<!-- TODO(screenshot): upload tmp/user-attribute-tags/5-inserted.png to ReadMe and replace the src -->
<Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="The tag in the text field, and the result in the Console preview" />

### Available formatters (filters)

| Type | Filters |
| :-- | :-- |
| Text | `capitalize`, `upcase`, `downcase`, `strip`, `reverse` |
| Format | `truncate`, `truncatewords`, `slice`, `append`, `prepend`, `replace`, `remove` |
| Number | `round`, `floor`, `ceil`, `abs`, `plus`, `minus`, `times`, `divided_by`, `at_least`, `at_most` |
| HTML / URL | `escape`, `strip_html`, `newline_to_br`, `url_encode` |

The Composer shows only the formatters that apply to the type of the attribute.

> 🚧 Date attributes
>
> The SDK shows a `Date` attribute in the ISO 8601 format, for example `2026-10-07T10:30:00Z`. The `date` filter does not format these values on the device yet. Test a date tag on a real device before you publish the Screen.

### Set the attribute in your app

The SDK reads the value from the user attributes of the device when it displays the Screen. Set the attribute **before** you display the Screen. If you change the value while the Screen is open, the label does not change.

```swift Swift
Purchasely.setUserAttribute(withStringValue: "julie", forKey: "firstname")
Purchasely.setUserAttribute(withIntValue: 12, forKey: "articles_read")
```
```kotlin Kotlin
Purchasely.setUserAttribute("firstname", "julie")
Purchasely.setUserAttribute("articles_read", 12)
```
```typescript React Native
Purchasely.setUserAttributeWithString('firstname', 'julie');
Purchasely.setUserAttributeWithNumber('articles_read', 12);
```
```dart Flutter
Purchasely.setUserAttributeWithString('firstname', 'julie');
Purchasely.setUserAttributeWithInt('articles_read', 12);
```
```javascript Cordova
Purchasely.setUserAttributeWithString('firstname', 'julie');
Purchasely.setUserAttributeWithInt('articles_read', 12);
```

More information: [Setting Custom User Attributes](custom-user-attributes#setting-custom-user-attributes).

> 🚧 `Purchasely.userLogout()` clears the custom user attributes, unless you call `Purchasely.userLogout(false)`. After a logout, the tags show their default value until your app sets the attributes again.
