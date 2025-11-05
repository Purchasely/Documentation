---
title: Backend entitlements (old)
excerpt: >-
  This section provides details on how to manage entitlements with your own
  backend
deprecated: false
hidden: true
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Architecture & general functionning

Managing entitlements with your own backend is the most secure approach.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/89f01ba-image.png",
        null,
        ""
      ],
      "align": "center",
      "border": true
    }
  ]
}
[/block]


The Purchasely Platform is in charge of:

- processing transactions and sending [Entitlement Events](entitlement-events) on the webhook interface every time entitlements should be updated for a user  
  _Eg: when a subscription starts, is renewed, is terminated or refunded_
- notifying the SDK and the app when entitlements have been properly updated by the backend

The developer's backend is responsible of:

- listening to Entitlement Events on Purchasely webhook, processing them and acknowledging them
- granting / revoking entitlements to the users based on these events
- providing an interface that the app can fetch to update users' entitlements
- securing contents themselves (eg: with DRM for streaming platform) and managing accesses to contents depending on users' entitlements

<br />

# Configuring the webhook

To configure the webhoow follow these steps:

1. Fill in [Client webhook URL in your Purchasely Console](https://console.purchasely.io//webhooks)  
   _Purchasely Console > [YOUR APP] > Webhook_

   [block:image]{"images":[{"image":["https://files.readme.io/45bca19-image.png",null,""],"align":"center","border":true}]}[/block]
2. Enable [Entitlement Events](entitlement-events) (`ACTIVATE` & `DEACTIVATE`)

   [block:image]{"images":[{"image":["https://files.readme.io/433dcbd-image.png",null,""],"align":"center","border":true}]}[/block]

<br />

> 📘 Event acknowledgement expected
> 
> As soon as you have configured a Client webhook URL, the Purchasely Platform will expect an acknowledgement for the all events sent on the webhook. 
> 
> You can start by implementing a simple `HTTP 200` response for every message sent on the webhook.

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

Every entitlement update is sent on the webhook through 2 messages: `ACTIVATE` / `DEACTIVATE`.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/9e51f51-image.png",
        null,
        ""
      ],
      "align": "center",
      "sizing": "500px",
      "border": true
    }
  ]
}
[/block]


<BackendEntitlementsAcknowledgingMessages />

### 2. Authenticating messages (optional but recommended)

This step is optional and can be implemented later on. However, we strongly encourage to authenticate webhook messages to avoid attacks such as Man in the middle.

<BackendEntitlementsSecurity />

### 3. Updating users entitlements

<BackendEntitlementsUpdatingEntitlements />

[More details on Entitlement Events](entitlement-events)

<br />

<EntitlementsManagementSampleBackendCode />

### 4. Providing an API to the app to fetch users' entitlements

<BackendEntitlementsFetchingEntitlementsFromTheBackendAPI />

Sample backend code for managing the backend API:

```javascript
const express = require('express');
const bodyParser = require('body-parser');
const { Sequelize, DataTypes, Model } = require('sequelize');

// Initialize Express app
const app = express();
app.use(bodyParser.json());

// Connect to SQLite database
const sequelize = new Sequelize({
  dialect: 'sqlite',
  storage: 'entitlements.db'
});

// Define the Entitlement model
class Entitlement extends Model {}
Entitlement.init({
  userId: {
    type: DataTypes.STRING,
    allowNull: true
  },
  anonymousUserId: {
    type: DataTypes.STRING,
    allowNull: true
  },
  plan: {
    type: DataTypes.STRING,
    allowNull: false
  },
  store: {
    type: DataTypes.STRING,
    allowNull: false
  },
  activatedAt: {
    type: DataTypes.DATE,
    allowNull: false
  },
  deactivatedAt: {
    type: DataTypes.DATE,
    allowNull: true
  }
}, {
  sequelize,
  modelName: 'Entitlement',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at'
});

// Sync the database
sequelize.sync();

// API endpoint to fetch user entitlements
app.get('/entitlements', async (req, res) => {
  const { user_id, anonymous_user_id } = req.query;

  if (!user_id && !anonymous_user_id) {
    return res.status(400).json({ error: 'user_id or anonymous_user_id is required' });
  }

  try {
    const entitlements = await Entitlement.findAll({
      where: {
        [Sequelize.Op.or]: [
          { userId: user_id },
          { anonymousUserId: anonymous_user_id }
        ]
      }
    });

    res.status(200).json(entitlements);
  } catch (error) {
    res.status(500).json({ error: 'An error occurred while fetching entitlements' });
  }
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

```
```ruby Ruby
require 'sinatra'
require 'sequel'
require 'json'

# Connect to SQLite database
DB = Sequel.connect('sqlite://entitlements.db')

# Define the entitlements table if it doesn't exist
DB.create_table? :entitlements do
  primary_key :id
  String :user_id
  String :anonymous_user_id
  String :plan
  String :store
  DateTime :activated_at
  DateTime :deactivated_at
  DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
  DateTime :updated_at, default: Sequel::CURRENT_TIMESTAMP
end

# Define the Entitlement model
class Entitlement < Sequel::Model
end

# API endpoint to fetch user entitlements
get '/entitlements' do
  user_id = params['user_id']
  anonymous_user_id = params['anonymous_user_id']

  if user_id.nil? && anonymous_user_id.nil?
    status 400
    return { error: 'user_id or anonymous_user_id is required' }.to_json
  end

  entitlements = Entitlement.where(Sequel.|({ user_id: user_id }, { anonymous_user_id: anonymous_user_id })).all
  status 200
  entitlements.to_json
end

# Start the Sinatra server
run! if app_file == $0

```