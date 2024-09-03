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
    paymentNetworks?: String[];
    token?: string;
    transactionReference?: string;
    samsungToken?: string;
    theme?: PaymentSDKTheme;
    alternativePaymentMethods?: Array<string>;
    cardDiscounts?: Array<PaymentSDKCardDiscount>;
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

  export class PaymentSDKCardDiscount {
    /**
     * discountCards: An array of strings representing the cards that the discount can be applied to.
     */
    discountCards: string[];

    /**
     * discountValue: The value of the discount. This could be a flat amount or a percentage depending on the value of 'isPercentage'.
     */
    discountValue: number;

    /**
     * discountTitle: The title or name of the discount.
     */
    discountTitle: string;

    /**
     * isPercentage: A boolean indicating whether the discount value is a percentage (true) or a flat amount (false).
     */
    isPercentage: boolean;
  }

  // Add PaymentSDKNetworks here
  export const PaymentSDKNetworks: {
    AMEX: 'amex',
    PAGO_BANCOMAT: 'pagoBancomat',
    BANCONTACT: 'bancontact',
    CARTES_BANCAIRES: 'cartesBancaires',
    CHINA_UNION_PAY: 'chinaUnionPay',
    DANKORT: 'dankort',
    DISCOVER: 'discover',
    EFTPOS: 'eftpos',
    ELECTRON: 'electron',
    ELO: 'elo',
    ID_CREDIT: 'idCredit',
    INTERAC: 'interac',
    JCB: 'JCB',
    MADA: 'mada',
    MAESTRO: 'maestro',
    MASTERCARD: 'masterCard',
    MIR: 'mir',
    PRIVATE_LABEL: 'privateLabel',
    QUIC_PAY: 'quicPay',
    SUICA: 'suica',
    VISA: 'visa',
    V_PAY: 'vPay',
    BARCODE: 'barcode',
    GIROCARD: 'girocard',
    WAON: 'waon',
    NANACO: 'nanaco',
    POST_FINANCE: 'postFinance',
    T_MONEY: 'tmoney',
    MEEZA: 'meeza',
  };
}
