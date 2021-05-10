import { NativeModules } from 'react-native';
const { RNPaymentSDKLibrary } = NativeModules;

const TokeniseType = Object.freeze({"none":"none", "merchantMandatory":"merchantMandatory","userMandatory":"userMandatory","userOptinoal":"userOptional"});
const TokeniseFromat = Object.freeze({"none":"1", "hex32": "2", "alphaNum20": "3", "digit22": "3", "digit16": "5", "alphaNum32": "6"});
const TransactionType = Object.freeze({"sale":"sale", "authorize": "auth"});
const TransactionClass = Object.freeze({"ecom":"ecom", "recurring":"recur"});

export {
    RNPaymentSDKLibrary,
};

export { default as PaymentSDKConfiguration} from './PaymentSDKConfiguration';
export { default as PaymentSDKBillingDetails} from './PaymentSDKBillingDetails';
export { default as PaymentSDKShippingDetails} from './PaymentSDKShippingDetails';
export { default as PaymentSDKTheme} from './PaymentSDKTheme';