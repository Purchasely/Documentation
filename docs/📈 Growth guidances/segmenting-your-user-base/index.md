---
title: Segmenting your user base
excerpt: >-
  This section describes how to segment your user base in different cohorts
  using the Audience feature
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
  pages:
    - type: basic
      slug: audiences
      title: Managing Audiences
---
Purchasely allows to segment your user base into different segments by creating audiences and tailoring the screens displayed for each audience.

# General functioning

1. The Purchasely SDK handles <Glossary>User Attribute</Glossary>s. There are two sets of user attributes:
   * **Built-in user attributes**: they are natively managed by the SDK and work without requiring any particular development.\
     *Eg: app version, platform name, active subscription status, active subscription plan, user id, IP country, app sessions*\
     [View the full list of built-in user attributes](user-attributes-list)
   * **Custom user attributes**: they are additional user properties that can be injected by the app into the Purchasely Platform through an API of the SDK. These custom user properties can be collected by the app during the onboarding or when users interact with the app.\
     *Eg: gender, sign-up date, age, intent, current location, contents read, favorite team*\
     [How to manage Custom User Attributes](custom-user-attributes)
2. These <Glossary>User Attribute</Glossary>s can be combined together with boolean operators to create an <Glossary>Audience</Glossary>.\
   [Build Audiences to segment your user base and tailor the screen displayed for each audience](audiences)
   * All the users belonging to a same <Glossary>Audience</Glossary> share a common set of \{attribute, value}
   * One user can belong to several audiences at the same time
3. For each <Glossary>Placement</Glossary>, you can customize the screen displayed for a particular audience. Each audience can be prioritised.

   <Image alt="In the example above, iOS users in the US will see the &#x22;Screen Guided tour /6&#x22;, whereas Android users in France will be exposed to an A/B test. Users who don't belong to any of the audiences associated will not see any screen displayed (NONE)." align="center" border={true} src="https://files.readme.io/caed4d3-image.png">
     In the example above, iOS users in the US will see the "Screen Guided tour /6", whereas Android users in France will be exposed to an A/B test. Users who don't belong to any of the audiences associated will not see any screen displayed (NONE).
   </Image>

<AudiencePrioritizationRuleForAPlacement />

<br />

[A/B tests](ab-tests) can also be configured specifically for a particular <Glossary>audience</Glossary>.

# Syncing external user lists

If you wish to reuse user lists or cohorts created in 3rd-party tools (such as Braze, Amplitude, or your own backend), you have two options:

1. **Custom Audiences API** (recommended): Use the [Custom Audiences API](custom-audiences-api) to sync static lists of user identifiers directly from your external tools to Purchasely. Custom Audiences can then be used in <Glossary>Placement</Glossary>s just like Audiences.
2. **Custom User Attributes**: Alternatively, the app can fetch a cohort identifier from the 3rd-party platform and inject it into the Purchasely SDK using a [Custom User Attribute](custom-user-attributes), then create an Audience matching that attribute.

<br />

# Sample audiences

[Concrete examples of how you can leverage attributes and audiences to increase subscribers' retention](https://www.purchasely.com/hubfs/7892638/Leveraging_Subscription_Attributes_and_Audiences_to_increase_Retention.pdf)
