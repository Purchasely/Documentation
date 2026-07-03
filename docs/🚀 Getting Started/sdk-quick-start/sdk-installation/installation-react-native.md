---
title: React Native
excerpt: ''
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
      slug: sdk-initialization
      title: SDK initialization
---
<ReactnativeSdkInstallation />

## Huawei Mobile Services

To add Huawei as a store, you can use our NPM dependency

```shell
npm install @purchasely/react-native-purchasely-huawei@6.0.0-rc.2 --save
```

Then you must add Huawei in the list of stores when starting the SDK with the builder

```typescript React Native
await Purchasely.builder('<<X-API-KEY>>')
  .runningMode('full')
  .logLevel('error')
  .stores(['google', 'huawei']) // you can use multiple stores
  .storekitVersion('storeKit2') // iOS only: 'storeKit2' (default) | 'storeKit1'
  .start();
```

## Amazon In-App Purchases

To add Amazon as a store, you can use our NPM dependency

```shell
npm install @purchasely/react-native-purchasely-amazon@6.0.0-rc.2 --save
```

Then you must add Amazon in the list of stores when starting the SDK with the builder

```typescript React Native
await Purchasely.builder('<<X-API-KEY>>')
  .runningMode('full')
  .logLevel('error')
  .stores(['google', 'amazon']) // you can use multiple stores
  .storekitVersion('storeKit2') // iOS only: 'storeKit2' (default) | 'storeKit1'
  .start();
```
