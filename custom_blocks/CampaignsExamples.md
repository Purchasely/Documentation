---
name: Campaigns examples
---
# Examples of Campaigns

<Table align={["left","left","left"]}>
  <thead>
    <tr>
      <th style={{ textAlign: "left" }}>
        Type
      </th>

      <th style={{ textAlign: "left" }}>
        Name
      </th>

      <th style={{ textAlign: "left" }}>
        Description
      </th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td style={{ textAlign: "left" }}>
        Special offer / conversion
      </td>

      <td style={{ textAlign: "left" }}>
        Free user conversion
      </td>

      <td style={{ textAlign: "left" }}>
        Displays a specific paywall to free users who are challenging to convert into loyal subscribers  

        🎯 : targets non active subscribers with the Built-in User `Attribute Total number of Screen dismissed` above a specific threshold (eg: 20).  

        🗓️ : To create a fear of missing out, the campaign can be configured as a one time offer by adjusting the `impression cap` to `1 display per user`.
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        Special offer / conversion
      </td>

      <td style={{ textAlign: "left" }}>
        Black Friday Offer
      </td>

      <td style={{ textAlign: "left" }}>
        Displays a Black Friday Paywall featuring discounted offers.  

        🎯 : targets every user who is not already an active subscriber.  

        🗓️ : The campaign is scheduled in advance by defining start / end date & time => it will automatically get activated when the start date is reached, and deactivated when the end date is reached.
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        Special offer / conversion
      </td>

      <td style={{ textAlign: "left" }}>
        Limited time offer following the account creation
      </td>

      <td style={{ textAlign: "left" }}>
        Incentive users to try the premium product by displaying a limited time offer following their registration.  

        🎯 : target all users after they created their account.  

        🎚️: Configure the campaign as follows  

        1. Configure the exposure window to **3 days** after the first display.
        2. Set the frequency capping parameter to "Trigger campaign every 1 app session"
        3. Add a [countdown](https://docs.purchasely.com/docs/countdown) to the paywall, configure it as a user countdown and map it with a custom user attribute (e.g.: `signup_date`, type: Date), define the offset to **3 days** too. This type of timer remains consistent from one screen display to the other, like if you had not closed the Screen: the counting continues until the end date is reached.=> When the paywall is displayed for the first time, it initializes both the Campaign `exposure window`, and the Custom User Attribute `signup_date` with the current date.As a result, the paywall countdown and the `exposure window` are perfectly synchronized. The user will get out of the exposure window and therefore not be eligible to the campaign anymore when the countdown will reach 0.
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        Engagement
      </td>

      <td style={{ textAlign: "left" }}>
        User preferences
      </td>

      <td style={{ textAlign: "left" }}>
        Display a sequence of surveys during the onboarding to fetch user preference and personalize the user experience  

        🎯 : targets every user who hasn't answered the survey. You can do that by associating a Custom User Attribute to the survey
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        Retention
      </td>

      <td style={{ textAlign: "left" }}>
        Cancellation survey
      </td>

      <td style={{ textAlign: "left" }}>
        Displays a cancellation survey to get user insights on the cancellation reasons  

        🎯 : targets active subscribers with the Built-in User Attribute `Subscription status` = `Auto-renewing disabled`.\
        If you want to exclude free trial / intro offer users who directly cancel the renewing of their subscription right after starting it out of security, you can either exclude them (`Active Offer Type` ≠ `Free Trial`l & `Active Offer Type` ≠ `Intro Offer`) or leverage the attribute `Next renewal date` (`Next renewal date` is in `less than X days from now`)🔂 : to prevent user fatigue and overexposure, the `impression cap` can be set to one display per user or the `frequency cap` can be set to `once per 30 days`.
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        Engagement
      </td>

      <td style={{ textAlign: "left" }}>
        Free trial extension
      </td>

      <td style={{ textAlign: "left" }}>
        Display a free trial extension paywall to free trial users who have cancelled the auto-renewing of their subscription to give them a second chance to engage with your app and potentially form a habit.  

        🎯: You can target the active subscribers with the following attributes:\
        `Subscription status` = `Auto-renewing disabled`  & `Active Offer Type` = `Free trial` or `Intro Offer`  

        If you want to exclude free trial / intro offer users who directly cancel the renewing of their subscription right after starting it out of security, you can leverage the attribute `Next renewal date` (`Next renewal date` is in `less than X days from now`)
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        Conversion to paid
      </td>

      <td style={{ textAlign: "left" }}>
        Temporary discounted offer following a free trial
      </td>

      <td style={{ textAlign: "left" }}>
        Some users cancel their subscription during the free trial because they find the regular price too expensive. It's sometimes worth offering them a discount limited in time to bridge the gap between the introductory offer price and the regular price, in order to get them used to your app and accept to pay for it.  

        🎯: Target active subscribers with the following attributes:\
        `Subscription status` = `Auto-renewing disabled`  & `Active Offer Type` = `Free trial` or `Intro Offer`  

        If you want to exclude free trial / intro offer users who directly cancel the renewing of their subscription right after starting it out of security, you can leverage the attribute `Next renewal date` (`Next renewal date` is in `less than X days from now`)  

        ℹ️: by adjusting the frequency capping, impression cap and the priority, you can alternate between this campaign and a free trial extension campaign, proposing one then the other or making them get display alternatively.  

        ℹ️ ℹ️: you can also display this campaign only for users who gave the reason "The subscription is too expensive" when they are exposed to a cancellation survey. To achieve that: (i) [map your cancellation survey](mcq#1-configuring-the-survey) with a custom user attribute (e.g.: `cancellation_survey` - type: String) and leverage this custom user attribute in your audience by adding the condition `cancellation_survey` = `too_expensive`). You can also create a conditional [user flow to present the retention offer right after the cancellation survey](user-surveys#how-to-create-journeys-composed-of-several-questions).
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        Retention / voluntary churn
      </td>

      <td style={{ textAlign: "left" }}>
        Discounted offers to paid subscribers about to churn
      </td>

      <td style={{ textAlign: "left" }}>
        Display a retention paywall reminding the subscription benefits and leveraging promotional offers to propose a discounted price to a subscriber about to churn.  

        🎯: Target active subscribers with the following attributes:\
        `Subscription status` = `Auto-renewing disabled`  & `Active Offer Type` ≠ `Free trial` and  `Active Offer Type` ≠`Intro Offer`  

        ℹ️ ℹ️: you can also display this campaign only for users who gave the reason "The subscription is too expensive" when they are exposed to a cancellation survey. To achieve that: (i) [map your cancellation survey](mcq#1-configuring-the-survey)  with a custom user attribute (e.g.: `cancellation_survey` - type: String) and leverage this custom user attribute in your audience by adding the condition `cancellation_survey` = `too_expensive`). You can also create a conditional [user flow to present the retention offer right after the cancellation survey](user-surveys#how-to-create-journeys-composed-of-several-questions) .
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        Retention / involuntary churn
      </td>

      <td style={{ textAlign: "left" }}>
        Billing detail update for subscribers in grace period
      </td>

      <td style={{ textAlign: "left" }}>
        Display a Screen informing users that their subscription could not be renewed because of a billing issue, reminding them about premium membership benefits and inviting them to update their billing details to avoid losing them.  

        🎯: Target active subscribers with the following attributes:\
        `Subscription status` = `Grace period`  

        🔂 : to maximize the chances to recover the subscription, this campaign should be displayed every time the app is started.
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        Retention / involuntary churn
      </td>

      <td style={{ textAlign: "left" }}>
        Yearly subscribers about to churn
      </td>

      <td style={{ textAlign: "left" }}>
        Context:\
        25% of the yearly subscribers directly cancel the auto-renewing of their subscription out of security, because they want to be sure to get enough value for the money they paid upfront before renewing the subscription. But half of them forget the date of renewing and go past it without reactivating the subscription. As a result, they churn even though they did not mean to.  

        To avoid that, you should remind them to reactivate their auto-renewing to avoid losing their premium benefits.  

        For this scenario, you can create a set of campaigns that will get triggered over the last month before the end of the billing cycle, that will display paywalls with progressive discounts.  

        **Campaign 1: Simple reminder with premium membership benefits**\
        🎯: Target active subscribers with the Built-in User Attribute `Active Subscription Plan` = `[ID of the yearly plan]` & `Subscription status`=`Auto-renewing disabled` & `Next renewal date` is in `less than 30 days from now` and `more than 15 days from now`.\
        📱: The paywall features a button "Reactivate my subscription" (a simple Purchase Button mapped with their current Plan) that will reactivate the reset the `Subscription status` to `Auto-renewing` if they click on it.  

        **Campaign 2: Paywall with a limited discount to reward their loyalty**\
        🎯: Target active subscribers with the Built-in User Attribute `Active Subscription Plan` = `[ID of the yearly plan]` & `Subscription status`=`Auto-renewing disabled` & `Next renewal date` is in `less than 15 days from now` and `more than 5 days from now`\
        📱: The paywall features a promotional a 10% promotional offer. If they take it, their subscription status will be reset to Auto-renewing and the promotion will apply upon its renewing.  

        **Campaign 3: Paywall with an aggressive 30% discount limited in time**\
        🎯: Target active subscribers with the Built-in User Attribute `Active Subscription Plan` = `[ID of the yearly plan]` & `Subscription status`=`Auto-renewing disabled` & `Next renewal date` is in `less than 5 days from now`\
        📱: The paywall features a promotional an agressive 30% promotional offer and a countdown to create a sentiment of urgency. If they take it, their subscription status will be reset to Auto-renewing and the promotion will apply upon its renewing.
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        Win-back / involuntary churn
      </td>

      <td style={{ textAlign: "left" }}>
        Billing detail update for subscribers in billing retry
      </td>

      <td style={{ textAlign: "left" }}>
        Display a Screen informing users that their subscription has been cancelled because of a billing issue, reminding them about premium membership benefits and inviting them to update their billing details to reactivate them.  

        🎯: Target lapsed subscribers with the following attributes:\
        `Expired Subscription status` = `Billing retry`.
      </td>
    </tr>

    <tr>
      <td style={{ textAlign: "left" }}>
        Win-back / voluntary churn
      </td>

      <td style={{ textAlign: "left" }}>
        Discounted offers to lapsed subscribers to win them back
      </td>

      <td style={{ textAlign: "left" }}>
        Display a win-back paywall feature a promotional offer to lapsed subscribers.  

        🎯: Target lapsed subscribers with the following attributes:\
        `Active subscription` = `false` & `Exp. subscription` = `true`  

        You can leverage the [Built-in Exp. Subscription Attributes](user-attributes-list#built-in-expired-subscription-attributes) to target more precisely these lapsed subscribers depending on their `Expired Sub. Status` (= `Deactivated` means it was voluntary churn), the plan they used to have (`Expired sub. Plan`) the cumulated revenue they generated (`Expired sub. cumulated revenue (USD)` or `Cumulated revenue (USD)`) and their `Expired sub. expiry date`.  

        🗓️ : Limited-time offers are most efficient with agressive discount are the most efficient to win-back lapsed subscribers. Leverage the parameter `Exposure window`  combined with a countdown component inside the paywall to make to create a FOMO.
      </td>
    </tr>
  </tbody>
</Table>
