declare module '@paytabs/react-native-paytabs' {
  export class RNPaymentSDKLibrary {
    static startCardPayment(config): Promise<any>;

    static startApplePayPayment(config): Promise<any>;

    static startAlternativePaymentMethod(config): Promise<any>;

    static startTokenizedCardPayment(
      config,
      token,
      transactionRef,
    ): Promise<any>;

    static start3DSecureTokenizedCardPayment(
      config,
      savedCardInfo,
      token,
    ): Promise<any>;

    static startPaymentWithSavedCards(config, support3DS): Promise<any>;

    static cancelPayment(): Promise<any>
  }

  export class PaymentSDKConstants {
    static TokeniseType;
    static TokeniseFromat;
    static TransactionType;
    static TransactionClass;
    static AlternativePaymentMethod;
  }

  export class PaymentSDKConfiguration {
    profileID: string;
    serverKey: string;
    clientKey: string;
    transactionType?: string;
    transactionClass?: string;
    cartID: string;
    currency: string;
    amount: number;
    cartDescription: string;
    languageCode?: string;
    forceShippingInfo?: boolean;
    showBillingInfo?: boolean;
    showShippingInfo?: boolean;
    billingDetails?: PaymentSDKBillingDetails;
    shippingDetails?: PaymentSDKShippingDetails;
    merchantCountryCode: string;
    screenTitle?: string;
    merchantName?: string;
    serverIP?: string;
    tokeniseType?: string;
    tokenFormat?: string;
    hideCardScanner?: string;
    merchantIdentifier?: string;
    simplifyApplePayValidation?: string;
    paymentNetworks?: Array<string>;
    token?: string;
    transactionReference?: string;
    samsungToken?: string;
    theme?: PaymentSDKTheme;
    alternativePaymentMethods?: Array<string>;
  }

  export class PaymentSDKBillingDetails {
    name?: string;
    email?: string;
    phone?: string;
    addressLine?: string;
    city?: string;
    state?: string;
    countryCode?: string;
    zip?: string;
  }

  export class PaymentSDKShippingDetails {
    name?: string;
    email?: string;
    phone?: string;
    addressLine?: string;
    city?: string;
    state?: string;
    countryCode?: string;
    zip?: string;
  }

  export class PaymentSDKTheme {
    logoImage?: string;
    primaryColor?: string;
    primaryFontColor?: string;
    primaryFont?: string;
    secondaryColor?: string;
    secondaryFontColor?: string;
    secondaryFont?: string;
    strokeColor?: string;
    strokeThinckness?: number;
    inputsCornerRadius?: number;
    buttonColor?: string;
    buttonFontColor?: string;
    buttonFont?: string;
    titleFontColor?: string;
    titleFont?: string;
    backgroundColor?: string;
    placeholderColor?: string;
  }

  export class PaymentSDKSavedCardInfo {
    maskedCard?: string;
    cardType?: string;
  }
}
