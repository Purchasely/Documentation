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
      slug: sdk-implementation-1
      title: SDK Implementation
---
<ReactnativeSdkInstallation />

## Huawei Mobile Services

To add Huawei as a store, you can use our NPM dependency

```shell
npm install @purchasely/react-native-purchasely-huawei --save
```

Then you must add Huawei in the list of stores

```typescript React Native
await Purchasely.start({
  apiKey: '<<X-API-KEY>>',
  storeKit1: false, // set to false to use StoreKit2, true to use StoreKit1,
  androidStores: ['Google','Huawei'] // you can use multiple stores
});
```

## Amazon In-App Purchases

To add Amazon as a store, you can use our NPM dependency

```shell
npm install @purchasely/react-native-purchasely-amazon --save
```

Then you must add Amazon in the list of stores

```typescript React Native
await Purchasely.start({
  apiKey: '<<X-API-KEY>>',
  storeKit1: false, // set to false to use StoreKit2, true to use StoreKit1,
  androidStores: ['Google','Amazon'] // you can use multiple stores
});
```