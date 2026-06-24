---
title: Transactions processing
excerpt: >-
  This sections provides an overview of how transactions are managed in the
  different running modes
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: Follow the guide associated with your running mode
  pages:
    - type: basic
      slug: process-transactions-with-paywall-action-interceptor
      title: observer - using the Action Interceptor
    - type: basic
      slug: process-transactions-full-mode
      title: full mode
---
Transaction processing differs depending on the SDK running mode.

# `observer` mode

In `observer` mode, you manually process the transaction after intercepting the click on the purchase button thanks to the <Glossary>Action Interceptor</Glossary>.\
\=> [Implementation guide for processing transactions using the Action Interceptor](process-transactions-with-paywall-action-interceptor)

# `full` mode

In `full` mode, transactions are processed automatically by the Purchasely SDK.

\=> [Implementation guide for processing transactions in `full` mode](process-transactions-full-mode)
