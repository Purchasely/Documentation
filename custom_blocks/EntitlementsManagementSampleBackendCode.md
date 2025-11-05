---
name: Entitlements management - sample backend code
---
Sample backend code for:

* receiving webhook events
* extracting the relevant information
* updating the entitlements in the database
* acknowledging the processing of the events

```ruby Ruby
# This example uses Sinatra and ActiveRecord as ORM

#                                    CONTROLLER                                #
# ============================================================================ #
# Uses Sinatra

post '/webhook' do
  request.body.rewind
  payload = JSON.parse(request.body.read)

  entitlement = find_or_initialize_entitlement(payload)
  entitlement.attributes = {
    effective_next_renewal_at: ms_to_time(payload["effective_next_renewal_at_ms"]),
    status: payload["status"],
    store: payload["store"], # will never change
    type: payload["type"], # will never change
    last_payload: payload,
  }
  entitlement.save!

  # Acknowledges the processing of the event by answering a 200
  status 200
end


#                                      MODEL                                   #
# ============================================================================ #
# Uses ActiveRecord

# Entitlement
#
# For each purchase, it will keep track of:
#   - the purchase type
#   - the user owning it
#   - the plan bought
#   - the status of the sub (in short: active/not active)
#
# ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️
# ⚠️ Be sure to add a UNIQ CONSTRAINT on (purchasely_id, plan, anonymous_user_id, user_id) ⚠️
# ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️
class Entitlement < ActiveRecord::Base
  attr_accessor(
    :id,
    # filled in when the purchase is associated to a not logged in user
    :anonymous_user_id,
    # filled in when the purchase is associated to a logged in user
    :user_id,
    # RENEWING_SUBSCRIPTION | NON_RENEWING_SUBSCRIPTION |
    # CONSUMABLE | NON_CONSUMABLE
    :type, 
    # subs_xxx | otp_yyy
    :purchasely_id, 
    # Purchasely identifier of your plan, as defined in the Purchasely console
    # under the "id" input
    :plan, 
    # backup of the last payload sent
    :last_payload, 
    # At this date the user will loose their entitlement (it is equal to the max
    # between the next_renewal_at, grace_period_expires_at and defer_end_at)
    :effective_next_renewal_at,
    # AUTO_RENEWING | AUTO_RENEWING_CANCELED | IN_GRACE_PERIOD | ON_HOLD | PAUSED |
    # REVOKED | DEACTIVATED | UNPAID
    :status, 
    # APPLE_APP_STORE | GOOGLE_PLAY_STORE | STRIPE | HUAWEI_APP_GALLERY |
    # AMAZON_APP_STORE
    :store,
    :created_at,
    :updated_at
  )

  ACTIVE_STATUSES = %w[
    AUTO_RENEWING
    AUTO_RENEWING_CANCELED
    IN_GRACE_PERIOD
  ]
end


#                                     HELPERS                                  #
# ============================================================================ #

def find_or_initialize_entitlement(payload)
  Entitlement
    .find_or_initialize_by(
      payload.slice("anonymous_user_id", "plan", "purchasely_id", "user_id")
    ).last
end

def ms_to_time(time_in_ms)
  return nil unless time_in_ms

  Time.at(time_in_ms / 1000)
end
```
```javascript
const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const Entitlement = require('./models/entitlement');

app.use(bodyParser.json());


// Controller
// ============================================================================
// Uses Express

app.post('/webhook', async (req, res) => {
  const payload = req.body;

  const entitlement = await findOrInitializeEntitlement(payload);
  entitlement.effective_next_renewal_at = msToTime(payload.effective_next_renewal_at_ms);
  entitlement.status = payload.status;
  entitlement.store = payload.store; // will never change
  entitlement.type = payload.type; // will never change
  entitlement.last_payload = payload;

  await entitlement.save();

  // Acknowledges the processing of the event by answering a 200
  res.status(200).send();
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

const Entitlement = mongoose.model('Entitlement', EntitlementSchema);
module.exports = Entitlement;


// Helpers
// ============================================================================

async function findOrInitializeEntitlement(payload) {
  let entitlement = await Entitlement.findOne({
    anonymous_user_id: payload.anonymous_user_id,
    plan: payload.plan,
    purchasely_id: payload.purchasely_id,
    user_id: payload.user_id
  });

  if (!entitlement) {
    entitlement = new Entitlement({
      anonymous_user_id: payload.anonymous_user_id,
      plan: payload.plan,
      purchasely_id: payload.purchasely_id,
      user_id: payload.user_id
    });
  }

  return entitlement;
}

function msToTime(timeInMs) {
  if (!timeInMs) return null;
  return new Date(timeInMs);
}

module.exports = { findOrInitializeEntitlement, msToTime };
```

<br />

Proposed Database structure:

```sql
CREATE TABLE entitlements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type STRING NOT NULL,
    purchasely_id STRING NOT NULL,
    anonymous_user_id STRING,
    user_id STRING,
    plan STRING NOT NULL,
    status STRING NOT NULL,
    store STRING NOT NULL,
    effective_next_renewal_at DATETIME NOT NULL,
    last_payload JSONB NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_user UNIQUE (purchasely_id, user_id, anonymous_user_id)
);

```
