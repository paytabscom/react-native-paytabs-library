import { NativeModules } from 'react-native';

export default class RNPaymentSDKLibrary {
    static startCardPayment(config) {
        return new Promise((resolver, reject) => {
            const RNPaymentManager = NativeModules.RNPaymentManager;
            RNPaymentManager.startCardPayment(config).then( result => {
                resolver(result); 
               }, function(error) {
                reject(error);
               });
        })
    };

    static startApplePayPayment(config) {
        return new Promise((resolver, reject) => {
            const RNPaymentManager = NativeModules.RNPaymentManager;
            RNPaymentManager.startApplePayPayment(config).then( result => {
                resolver(result); 
               }, function(error) {
                reject(error);
               });
        })
    };

    static startAlternativePaymentMethod(config) {
        return new Promise((resolver, reject) => {
            const RNPaymentManager = NativeModules.RNPaymentManager;
            RNPaymentManager.startAlternativePaymentMethod(config).then( result => {
                resolver(result); 
               }, function(error) {
                reject(error);
               });
        })
    };
}