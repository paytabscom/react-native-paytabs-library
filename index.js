import { NativeModules } from 'react-native';
const { RNPaytabsLibrary } = NativeModules;

const TokeniseType = Object.freeze({"none":0, "merchantMandatory":1,"userMandatory":2,"userOptinoal":3});
const TokeniseFromat = Object.freeze({"none":"1", "hex32": "2", "alphaNum20": "3", "digit22": "3", "digit16": "5", "alphaNum32": "6"});
const TransactionType = Object.freeze({"sale":"sale"});
const TransactionClass = Object.freeze({"ecom":"ecom", "recurring":"recur"});

export {
    RNPaytabsLibrary,
};

export { default as PaymentSDKConfiguration} from './PaymentSDKConfiguration';
export { default as PaymentSDKBillingDetails} from './PaymentSDKBillingDetails';
export { default as PaymentSDKShippingDetails} from './PaymentSDKShippingDetails';
export { default as PaymentSDKTheme} from './PaymentSDKTheme';
