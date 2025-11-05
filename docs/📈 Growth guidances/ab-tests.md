---
title: Running A/B tests
excerpt: >-
  This section provides an overview on the A/B test feature, details on how it
  works and general advices to run them
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Follow the guide to configure your first A/B test!
  pages:
    - type: basic
      slug: ab-test-configuration
      title: Configuring an A/B test
---
# What is an A/B test?

A/B tests are a powerful tool to help you run growth experiments on your Screens and Paywalls.

It is a method used to compare two versions of a Paywall to determine which one performs better in achieving a specific goal. 

It involves creating two variations (A and B) where A is the control (existing version) and B is the variant (modified version). 

Users are randomly assigned to one of these variations, and their interactions are measured to see which version yields better results.

# How do Purchasely A/B tests work?

## How is Cohort Assignment done?

Cohort assignment refers to the process of dividing users into groups (cohorts) that will experience either the control or the variant. This should be done as follows:

1. **Random Assignment**: Users should be randomly assigned to either the control or the variant group. This ensures that the groups are comparable and that any differences in outcomes can be attributed to the variations being tested rather than other factors.
2. **Consistent Experience**: Once a user is assigned to a cohort, they should consistently experience the same version throughout the testing period. This avoids contamination of results and ensures that the user’s behavior is influenced by only one version.
3. **Balanced Distribution**: Efforts should be made to ensure that the groups are balanced in terms of size and demographics, which helps in obtaining statistically significant results.

<br />

## Why is Randomization Important?

Randomization is crucial for the following reasons:

1. **Eliminates bias**: Randomly assigning users to groups eliminates selection bias, ensuring that each cohort is representative of the overall population.
2. **Ensures fair comparison**: Randomization ensures that any external factors are equally distributed across both groups, making it possible to attribute any differences in outcomes to the variations being tested rather than to confounding variables.
3. **Statistical validity**: Randomization is fundamental to the statistical methods used to analyze A/B test results. It underpins the assumptions of many statistical tests, allowing for valid inferences and conclusions.

## What is the randomization process in Purchasely

In Purchasely, when an end user is exposed to an A/B test, the cohort is assigned to the user by leveraging the `user ID` (if the user is logged-in) or the `anonymous user ID` otherwise. The Purchasely Platform is in charge of this assignment.

The `user bucket value` is a number between 0 and 99, associated with the current `user ID` / `anonymous ID`, computed as follows:

```php User bucket value computation
user_id = "abcd-efgh-ijkl-mnop"  
Compute MD5Hash("abcd-efgh-ijkl-mnop") => 0x6ee2661c8970b107aa7ebce3ecc303fd  
Take the first 8 hex digits of 0x6ee2661c8970b107aa7ebce3ecc303fd => 0x6ee2661c  
Convert 0x6ee2661c from HEX to INT => 1860331036  
Apply 1860331036 MODULO 100 => 36
user_bucket_value = 36
  
```

[block:embed]
{
  "html": "<iframe class=\"embedly-embed\" src=\"//cdn.embedly.com/widgets/media.html?url=https%3A%2F%2Fjsfiddle.net%2Fhq1gauL4%2F2%2Fembedded%2Fresult&type=text%2Fhtml&schema=jsfiddle&display_name=jsFiddle&src=https%3A%2F%2Fjsfiddle.net%2Fhq1gauL4%2F2%2Fembedded%2Fresult\" width=\"600\" height=\"400\" scrolling=\"no\" title=\"jsFiddle embed\" frameborder=\"0\" allow=\"autoplay; fullscreen; encrypted-media; picture-in-picture;\" allowfullscreen=\"true\"></iframe>",
  "url": "https://jsfiddle.net/hq1gauL4/2/embedded/result",
  "provider": "jsfiddle.net",
  "href": "https://jsfiddle.net/hq1gauL4/2/embedded/result",
  "typeOfEmbed": "jsfiddle"
}
[/block]


<br />

Because the `user ID` / `anonymous ID` remain consistent over time, this user will remain assigned the same `user bucket value` as long as they don't:

- sign-out or sign-in with a different user account for logged-in users
- uninstall / reinstall the app for an anonymous user

The cohort assignment by the Purchasely Platform works as follows:

```php Cohort assignment
Case 1/
  Split Variants A/B = 50/50
  => Variant A range = [0-49]
  => Variant B range = [50-99]
  users with user_bucket_value = 21 are assigned to Variant A
  users with user_bucket_value = 51 are assigned to Variant B

Case 2/
  Split Variants A/B/C = 33/33/34
  => Variant A range = [0-32]
  => Variant B range = [33-65]
  => Variant C range = [66-99]
  users with user_bucket_value = 21 are assigned to Variant A
  users with user_bucket_value = 51 are assigned to Variant B
  users with user_bucket_value = 71 are assigned to Variant C
    
```

### Maintaining variant consistency when users sign-in

Since the randomization process depends on different IDs based on whether the user is signed in (`user ID`) or not (`anonymous user ID`), an anonymous user who later signs in may be assigned a new `user bucket value`, potentially placing them in a different variant group.

To prevent this and ensure that the user consistently remains in the same cohort, regardless of their login status, you can set a custom value using a [Custom User Attribute](custom-user-attributes) called `ply_ab_test_user_id` (no need to declare it in the Console):

- If you are using a third-party A/B testing platform, you can set the attribute `ply_ab_test_user_id` with the value of the `3rd-party user ID` or `3rd-party variant ID`.
- If you wish to continue using the `anonymous user ID` even after the user signs in, you can assign the Purchasely `anonymous user ID` to it:

  <br />

  ```swift Swift
    //Set one attribute by key and value
    Purchasely.setUserAttribute(withStringValue: Purchasely.anonymousUserId, forKey: "ply_ab_test_user_id")
  ```
  ```coffeescript Kotlin
  //Set one attribute by key and value
  Purchasely.setUserAttribute("ply_ab_test_user_id",  Purchasely.anonymousUserId)
  ```
  ```typescript React Native
  //Set one attribute by key and value
  Purchasely.setUserAttributeWithString("ply_ab_test_user_id", Purchasely.getAnonymousUserId());
  ```
  ```coffeescript Flutter
  //Set one attribute by key and value
  String anonymousId = await Purchasely.anonymousUserId;
  Purchasely.setUserAttributeWithString("ply_ab_test_user_id", anonymousId);
  ```
  ```csharp Unity
  private PurchaselyRuntime.Purchasely _purchasely;

  //Set one attribute by key and value
  _purchasely.SetUserAttribute("ply_ab_test_user_id", Purchasely.getAnonymousUserId());
  ```
  ```javascript Cordova
  //Set one attribute by key and value	
  Purchasely.setUserAttributeWithString("ply_ab_test_user_id", Purchasely.getAnonymousUserId());
  ```

<br />

When set, the `ply_ab_test_user_id` will be used by the platform to compute the `user bucket value` and determine the associated cohort.

## How does randomization work with multiple A/B tests?

When running multiple A/B tests, the operations performed are the same for each A/B test. The user bucket value used is the same for all the A/B tests.

In other words, if you run several A/B tests with the same weight for each variant (e.g.: 50/50), a user who is assigned to cohort A for the first A/B test will also be assigned to cohort A for the second A/B test. However, if the weight of each variant or the number of variants is not consistent across the different A/B tests, a user might be assigned to different cohort.

```php Cohort assignment
Case 1/
  AB Test 1 - Split Variants A/B = 50/50
  => Variant A range = [0-49]
  => Variant B range = [50-99]
  AB Test 2 - Split Variants A/B = 50/50
  => Variant A range = [0-49]
  => Variant B range = [50-99]
  users with user_bucket_value = 21 are assigned to Variant A for both A/B tests
  users with user_bucket_value = 51 are assigned to Variant B for both A/B tests

Case 2/
  AB Test 1 - Split Variants A/B = 50/50
  => Variant A range = [0-49]
  => Variant B range = [50-99]
  AB Test 2 - Split Variants A/B/C = 30/30/40
  => Variant A range = [0-29]
  => Variant B range = [30-59]
  => Variant C range = [60-99]
  users with user_bucket_value = 21 are assigned to Variant A for both A/B tests
  users with user_bucket_value = 61 are assigned to Variant B for A/B Test 1 and to Variant C for A/B Test 2
 
    
```

<br />

# How are Purchasely A/B tests results computed?

The Purchasely Platform leverages its analytics to determine the performance of each variant.

## Events captured

The following events are captured:

[UI / SDK Events](ui-sdk-events-list):

- `PRESENTATION_VIEWED`

[Lifecycle Events](lifecycle-events):

- `SUBSCRIPTION_STARTED`
- `SUBSCRIPTION_RENEWED`
- `SUBSCRIPTION_TERMINATED`
- `SUBSCRIPTION_REFUNDED_REVOKED`

[Offer Events](offer-events):

- `TRIAL_STARTED` / `INTRO_STARTED`
- `TRIAL_CONVERTED` / `INTRO_CONVERTED`
- `TRIAL_NOT_CONVERTED` / `INTRO_NOT_CONVERTED`

[Transactional Event](transactional-event):

- `TRANSACTION_PROCESSED`

<br />

## Attributes `ab_test_id` and `ab_test_variant_id`

When configuring your A/B test, you can define an `ab_test_id` and `ab_test_variant_id` for each variant. 

All the events listed above will carry the attributes `ab_test_id` and `ab_test_variant_id` when they are triggered from a {<<glossary:Placement>>, <<glossary:Audience>>} on which an A/B test is active. 

The SDK and the backend are in charge of keeping things consistent:

- On the backend side, every lifecycle, transactional or offer event following a subscription that started from an A/B test will carry the attributes.
- On the SDK side, the attributes are attached to the `PRESENTATION_VIEWED`. They will be automatically forwarded for all the sub-sequent Paywalls / Screens that might be opened directly from this first Screen
  - E.g.: if a second Paywall presenting all the plans is accessed by the User by clicking on a link “See all plans” from the first Paywall, the second Paywall will be considered as associated to the A/B test.
  - However, if the user closes the Paywall, continues browsing the app and opens another Paywall from a different placement on which no A/B testis currently active, the events (both SDK side and server side) will not carry the attributes and therefore will not be counted in the A/B test data.

## What is the Statistical Significance?

Statistical Significance is a mathematical measure used to determine whether the observed effect in an A/B test is likely to be due to something other than random chance. 

It helps in making inferences about the population based on sample data. 

When an experiment’s results are statistically significant, it implies that the observed differences are likely reflective of true differences in the population rather than random variability.

## How is the Statistical Significance computed?

The Purchasely Platform uses a Bayesian test to compute the statistical significance for the A/B test run on the platform, **only for A/B tests with 2 variants**. 

In other words, the Statistical Significance is not computed by the Purchasely Platform when 3 variants or more have been created.

The precise algorithm implemented is this one: <https://www.evanmiller.org/bayesian-ab-testing.html#mjx-eqn-binary_ab_pr_alpha_b>

It computes the likelihood of a variant to beat the other. For the sake of transparency, here is the code implementation of this algorithm on the Purchasely Platform:

```javascript Statistical Significance implementation
// implementation of https://www.evanmiller.org/bayesian-ab-testing.html#mjx-eqn-binary_ab_pr_alpha_b
export function getBestProbWithBayesianMethod(
  variantA: Variant,
  variantB: Variant
) {
  if (
    !variantA.viewers ||
    !variantB.viewers ||
    !(variantA.count > 0 && variantB.count > 0) ||
    variantA.count > variantA.viewers ||
    variantB.count > variantB.viewers
  ) {
    return null;
  }

  const cvr = {
    a: variantA.count / variantA.viewers,
    b: variantB.count / variantB.viewers,
  };
  const isVariantATheBest = cvr.a > cvr.b; // so result will keep being the same if we switch a and b

  const alpha = {
    a: (isVariantATheBest ? variantB.count : variantA.count) + 1,
    b: (isVariantATheBest ? variantA.count : variantB.count) + 1,
  };
  const beta = {
    a:
      (isVariantATheBest
        ? variantB.viewers - variantB.count
        : variantA.viewers - variantA.count) + 1,
    b:
      (isVariantATheBest
        ? variantA.viewers - variantA.count
        : variantB.viewers - variantB.count) + 1,
  };

  let prob = 0.0;
  for (let i = 0; i < alpha.b - 1; i++) {
    prob += Math.exp(
      betaln(alpha.a + i, beta.b + beta.a) -
        Math.log(beta.b + i) -
        betaln(1 + i, beta.b) -
        betaln(alpha.a, beta.a)
    );
  }

  return (prob > 0.5 ? prob : 1 - prob) * 100;
}

```

<br />

The `Statistical Significance` is computed by computing a `p-value` based on the number of occurrences for each variant of the same event.

_E.g.: `# TRIAL_CONVERTED[variant A]` VS `# TRIAL_CONVERTED[variant B]`_ 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/a911258-image.png",
        null,
        "When the line Significance is in green, it means the p-value \\< 0.05. In this case, the winning variant appears in green too."
      ],
      "align": "center",
      "border": true,
      "caption": "When the line Significance is in green, it means the p-value \\< 0.05. In this case, the winning variant appears in green too."
    }
  ]
}
[/block]


The Purchasely Console considers that an experiment is statistically significant when the `p-value` \< 0.05 and will put the winning variant and the statistical significance for the KPI in green.

The Confidence Interval, which gives a range of values that is likely to contain the true effect of the variant and provides a sense of the precision of the estimated effect, is NOT computed by the Purchasely Platform.

The `Revenue` is computed by aggregating the revenue carried by the all the sub-sequent `TRANSACTION_PROCESSED` events for each variant (carrying the attributes `ab_test_id` and `ab_test_variant_id`). `Revenue` include the VAT and App store fees.

The `ARPU` (Average Revenue Per User) is computed by dividing the aggregated revenue by the number of unique viewers exposed to each variant.

The `ARPPU` (Average Revenue Per Paying User) is computed by dividing the aggregated revenue by the number of paying users associated with each variant.

# What kind of A/B tests can be run using Purchasely?

The Purchasely Platform allow you to run the following A/B tests:

- `UI A/B tests`: these are tests which involve different Screens.  
  These Screens can be:
  - either configured via the Purchasely Screen Builder and rendered by the Purchasely SDK
  - either handled directly by your app, such as your existing / legacy Paywall, by leveraging the feature [Use Your Own Paywall](use-your-own-paywall).  
    [More information on UI A/B tests here](ab-test-configuration#ui-ab-tests).
- `Price A/B tests`: these are tests leveraging the same Screen, where it is possible to remap the Plans associated to the each variants, allowing to associate SKU with different Regular Price or Introductory Offers.  
  [More information on Price A/B tests here](ab-test-configuration#price-ab-tests).

> 📘 A/B tests results must be based on transactions
> 
> Whatever A/B test you decide to run, the KPIs which will be used to compute the performance of each variant must be transaction related. 
> 
> With the version 4.4 of the SDK, it is not possible yet to asset variants performances on KPIs which are not related to an In-App Transaction (purchase of a One-Time Purchase or of an In-App Subscription).

<br />

# A/B Test best practices

When running A/B test, we advise you to:

1. **Define hypothesis on what you are looking to validate**.  
   By doing so, you will learn even when experiments fail (e.g.: variant B fails to beat variant A) or when it can't reach the Statistical Significance.  
   _E.g.:_
   1. \__We make the hypothesis that a Blinkist-like Paywall leveraging the Steps components might help build trust by reassure users and might therefore increase the conversion to trial and the conversion to paid._
   2. _We make the hypothesis that adding social proof to the Paywall (reviews) might increase the conversion to trial and the conversion to paid._
   3. _We make the hypothesis that increasing the price for the Yearly Plan by X% might decrease a the conversion by Y% but increase the ARPU (Average Revenue Per User) or ARPPU (Average Revenue Per Paying User) by Z%._
2. **Be bold in your hypothesis but do not change everything**  
   What you are trying to do at first, is to move the needle. Try to have substantial differences between the different variants of your Screen or between your Offers / Prices.  
   When differences are too subtle, the Statistical Significance might be harder to get to, which will slow down your learning and growth pace.  
   Start with bold choices and refine in a second time once you are sure that you've been able to move the needle and you know that you are working in the good direction.  
   On the other hand, don't change everything between the different paywalls you are testing. If you do that, you will not be able to determine what was the key thing that you changed that made the difference.
3. **Only configure 2 variants per A/B test**.  
   => If you have more than 2 variants to test, run several A/B tests sequentially in time. Each new A/B test will try to beat the last winning variant.
4. **Wait until you reach a statistical significance above 95%**.  
   As long as the p-value is above 0.05%, the. fluctuations in the performance of each variant might be due to chance.  
   Note: the time it takes to reach this depends on 2 things:

- the number of Users exposed to each variant - the bigger the sample the smaller the p-value.
- the gap of performance between the 2 variants - the bigger the gap, the smaller the p-value.

5. **Make sure that you run your A/B test on a period of time which is sufficiently representative of a typical business cycle**.  
   Even if you reach the statistical significance quickly, we advise you to wait between 1 and 2 extra weeks before making conclusions.  
   In the best case scenario, wait until the Introductory Offer is finished for most of the users.