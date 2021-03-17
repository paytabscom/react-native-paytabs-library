export default class PaymentSDKConfiguration {
    constructor(profileID, 
        serverKey, 
        clientKey,
        transactionType, 
        transactionClass,
        cartID,
        currency,
        amount,
        cartDescription,
        languageCode,
        forceShippingInfo,
        showBillingInfo,
        showShippingInfo,
        billingDetails,
        shippingDetails,
        merchantCountryCode,
        screenTitle,
        merchantName,
        serverIP,
        tokeniseType,
        tokenFormat,
        hideCardScanner,
        merchantIdentifier,
        simplifyApplePayValidation,
        paymentNetworks,
        token,
        transactionReference,
        theme
        ) {
            this.profileID = profileID;
            this.serverKey = serverKey;
            this.clientKey = clientKey;
            this.transactionType = transactionType
            this.transactionClass = transactionClass
            this.cartID = cartID;
            this.currency = currency;
            this.amount = amount;
            this.cartDescription = cartDescription
            this.languageCode = languageCode
            this.forceShippingInfo = forceShippingInfo
            this.showBillingInfo = showBillingInfo
            this.showShippingInfo = showShippingInfo
            this.billingDetails = billingDetails
            this.shippingDetails = shippingDetails
            this.merchantCountryCode = merchantCountryCode
            this.screenTitle = screenTitle
            this.merchantName = merchantName
            this.serverIP = serverIP
            this.tokeniseType = tokeniseType
            this.tokenFormat = tokenFormat
            this.hideCardScanner = hideCardScanner
            this.merchantIdentifier = merchantIdentifier
            this.simplifyApplePayValidation = simplifyApplePayValidation
            this.paymentNetworks = paymentNetworks
            this.token = token
            this.transactionReference = transactionReference
            this.theme = theme
        }

        // toJSON() {
        //     return {
        //         profileID: this.profileID,
        //         serverKey:this.serverKey,
        //         clientKey: this.clientKey,
        //         // transactionType: this.transactionType,
        //         // transactionClass: this.transactionClass,
        //         cartID: this.cartID,
        //         currency: this.currency,
        //         // amount: this.amount,
        //         // cartDescription: this.cartDescription,
        //         // languageCode: this.anguageCode,
        //         // forceShippingInfo: this.forceShippingInfo,
        //         // showBillingInfo: this.showBillingInfo,
        //         // showShippingInfo: this.showShippingInfo,
        //         // billingDetails: this.billingDetails,
        //         // shippingDetails: this.shippingDetails,
        //         // merchantCountryCode: this.merchantCountryCode,
        //         // screenTitle: this.screenTitle,
        //         // merchantName: this.merchantName,
        //         // serverIP: this.serverIP,
        //         // tokeniseType: this.tokeniseType,
        //         // tokenFormat: this.tokenFormat,
        //         // hideCardScanner: this.hideCardScanner,
        //         // merchantIdentifier: this.merchantIdentifier,
        //         // simplifyApplePayValidation: this.simplifyApplePayValidation,
        //         // paymentNetworks: this.paymentNetworks,
        //         // token: this.token,
        //         // transactionReference: this.transactionReference,
        //         // theme: this.theme
        //     }
        // }

        // toDic() {
        //     return Object.getOwnPropertyNames(this).reduce((a, b) => {
        //       a[b] = this[b];
        //       return a;
        //     }, {});
        //   }
};


// profileID = "", 
//         serverKey = "", 
//         clientKey = "",
//         transactionType = null, 
//         transactionClass = null,
//         cartID = "",
//         currency = "",
//         amount = 0.0,
//         cartDescription = "",
//         languageCode = null,
//         forceShippingInfo = false,
//         showBillingInfo = false,
//         showShippingInfo = false,
//         billingDetails = null,
//         shippingDetails = null,
//         merchantCountryCode = "",
//         screenTitle = "",
//         merchantName = "",
//         serverIP = null,
//         tokeniseType = null,
//         tokenFormat = null,
//         hideCardScanner = false,
//         merchantIdentifier = null,
//         simplifyApplePayValidation = false,
//         paymentNetworks = null,
//         token = null,
//         transactionReference = null,
//         theme = null