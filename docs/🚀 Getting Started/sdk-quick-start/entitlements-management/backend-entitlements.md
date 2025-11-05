---
title: Backend entitlements
excerpt: >-
  This section provides details on how to manage entitlements with your own
  backend
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: >-
    You're all set with managing the entitlements! Now learn how to test your
    integration
  pages:
    - type: basic
      slug: testing
      title: Testing
---
# Architecture & general functionning

Managing entitlements with your own backend is the most secure approach.

<br />

In this setup, responsibilities are shared between your servers and Purchasely’s servers.

The **Purchasely's servers** are in charge of:

* processing and verifying transactions
* notifying your servers of any update concerning a user's entitlement (*eg: a subscription is renewed*)
* notifying the SDK and your app of such entitlements updates

<br />

The **developer's servers** are responsible for:

* listening to, processing and acknowledging [Entitlement Events](entitlement-events) sent through the Purchasely webhook
* granting/revoking entitlements to the users based on these events
* securing contents themselves (eg: with DRM for streaming platform) and managing accesses to contents depending on users' entitlements

<br />

A typical timeline is as follows:

* The user opens a Purchasely paywall and makes a purchase.
* This purchase is made through the store, which returns a receipt to the Purchasely SDK.
* The receipt is sent by the SDK to Purchasely’s servers for verification and recording of the purchase.
* The information about this purchase (user, plan, renewal date, etc.) is then sent to your servers via our webhook.
* Your servers record the purchase information and confirm to our servers that they have acknowledged the purchase.
* Our servers then pass the verified purchase information back to our SDK.
* Finally, our SDK hands control back to your application

<br />

To fully implement this process, we'll go step by step:

1. Configuring the webhook
2. Listening to webhook events
3. Authenticating messages (optional but recommended)
4. Updating users entitlements
5. Providing an API to the app to fetch users' entitlements

<br />

# Configuring the webhook

Purchasely’s servers will make HTTP calls to your servers to pass informations concerning new/updated entitlements: this calls are called "webhooks".

Here is how to configure them.

1. Fill in [Client webhook URL in your Purchasely Console](https://console.purchasely.io/webhooks) (this is the URL that will be called to send you the webhooks)\
   *Purchasely Console >[YOUR APP] > Webhooks*

   <Image align="center" className="border" border={true} src="https://files.readme.io/45bca19-image.png" />
2. Enable [Entitlement Events](entitlement-events) (`ACTIVATE` & `DEACTIVATE`)

   <Image align="center" className="border" border={true} src="https://files.readme.io/433dcbd-image.png" />

<br />

> 📘 Event acknowledgement expected
>
> As soon as you have configured a Client webhook URL, the Purchasely Platform will expect an acknowledgement for the all events sent on the webhook. 
>
> You can start by implementing a simple `HTTP 200` response for every message sent on the webhook.

<br />

# Managing webhook messages on your backend

Managing entitlements on your backend require 4 steps:

1. Listening to [Entitlement Events](entitlement-events) sent on the Purchasely Webhook and acknowledging them to confirm that:
   1. they have been processed
   2. the corresponding entitlements have been updated
2. Authenticating messages (optional but recommended)
3. Updating users entitlements in your database by extracting the relevant information from the Entitlement Events
4. Providing an API to your app to fetch the users' entitlements

<br />

### 1. Listening to webhook events

Even if a lot of different events can be sent in the webhook, you should only listen to the `ACTIVATE` and `DEACTIVATE` events to manage your entitlements.

<Image align="center" className="border" width="500px" border={true} src="https://files.readme.io/9e51f51-image.png" />

<BackendEntitlementsAcknowledgingMessages />

<br />

### 2. Authenticating messages (optional but recommended)

This step is optional and can be implemented later on. However, we strongly encourage to authenticate webhook messages to avoid attacks such as Man in the middle.

<BackendEntitlementsSecurity />

<br />

### 3. Updating users entitlements

<BackendEntitlementsUpdatingEntitlements />

[More details on Entitlement Events](entitlement-events)

<br />

<EntitlementsManagementSampleBackendCode />

<br />

### 4. Providing an API to the app to fetch users' entitlements

<BackendEntitlementsFetchingEntitlementsFromTheBackendAPI />

Sample backend code for managing the backend API:

```ruby Ruby
#                                    CONTROLLER                                #
# ============================================================================ #
# Uses Sinatra

# API endpoint to fetch user entitlements
get '/entitlements' do
  anonymous_user_id = params['anonymous_user_id'].presence
  user_id = params['user_id'].presence
  if anonymous_user_id.nil? && user_id.nil?
    status 400
    return json({error: 'user_id or anonymous_user_id is required'})
  end

  entitlements =
    Entitlement
      .where(anonymous_user_id:, user_id:) # filter on the current user
      .where(status: Entitlement::ACTIVE_STATUSES) # only retrieve the active statuses
      .to_a
  status 200
  json entitlements.map { |e| {plan: e.plan} }
end


#                                SIMPLIFIED MODEL                              #
# ============================================================================ #
# Uses ActiveRecord

class Entitlement < ActiveRecord::Base
  attr_accessor(
    # AUTO_RENEWING | AUTO_RENEWING_CANCELED | IN_GRACE_PERIOD | ON_HOLD | PAUSED |
    # REVOKED | DEACTIVATED | UNPAID
    :status, 
  )
  
  ACTIVE_STATUSES = %w[
    AUTO_RENEWING
    AUTO_RENEWING_CANCELED
    IN_GRACE_PERIOD
  ]
end
```
```javascript
// Controller
// ============================================================================
// Uses Express

const express = require('express');
const app = express();
const Entitlement = require('./models/entitlement');

app.get('/entitlements', async (req, res) => {
  const { anonymous_user_id, user_id } = req.query;

  if (!anonymous_user_id && !user_id) {
    return res.status(400).json({ error: 'user_id or anonymous_user_id is required' });
  }

  try {
    const entitlements = await Entitlement.find({
      $or: [
        { anonymous_user_id: anonymous_user_id || null },
        { user_id: user_id || null }
      ],
      status: { $in: Entitlement.ACTIVE_STATUSES }
    }).exec();

    res.status(200).json(entitlements.map(e => ({ plan: e.plan })));
  } catch (err) {
    res.status(500).json({ error: 'An error occurred while fetching entitlements' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});


// Model
// ============================================================================
// Uses Mongoose

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const EntitlementSchema = new Schema({
  anonymous_user_id: { type: String, index: true },
  user_id: { type: String, index: true },
  type: { type: String, required: true },
  purchasely_id: { type: String, required: true },
  plan: { type: String, required: true },
  last_payload: { type: Object, required: true },
  effective_next_renewal_at: { type: Date },
  status: { type: String, required: true },
  store: { type: String, required: true },
  created_at: { type: Date, default: Date.now },
  updated_at: { type: Date, default: Date.now }
}, {
  timestamps: true
});

EntitlementSchema.index({ anonymous_user_id: 1, plan: 1, purchasely_id: 1, user_id: 1 }, { unique: true });

EntitlementSchema.statics.ACTIVE_STATUSES = [
  'AUTO_RENEWING',
  'AUTO_RENEWING_CANCELED',
  'IN_GRACE_PERIOD'
];

const Entitlement = mongoose.model('Entitlement', EntitlementSchema);
module.exports = Entitlement;
```
