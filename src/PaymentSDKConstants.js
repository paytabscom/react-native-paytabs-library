export default class PaymentSDKConstants {
  static TokeniseType = {
    none: 'none',
    merchantMandatory: 'merchantMandatory',
    userMandatory: 'userMandatory',
    userOptional: 'userOptional',
    userOptionalDefaultOn: 'userOptionalDefaultOn',
  };
  static TokeniseFormat = {
    none: '1',
    hex32: '2',
    alphaNum20: '3',
    digit22: '3',
    digit16: '5',
    alphaNum32: '6',
  };
  static TransactionType = { sale: 'sale', authorize: 'auth' };
  static TransactionClass = { ecom: 'ecom', recurring: 'recur' };
  static AlternativePaymentMethod = {
    unionPay: 'unionpay',
    stcPay: 'stcpay',
    valu: 'valu',
    meezaQR: 'meezaqr',
    omannet: 'omannet',
    knetCredit: 'knetcredit',
    knetDebit: 'knetdebit',
    fawry: 'fawry',
    aman: 'aman',
    urpay:  "urpay",
    applePay: "applePay",
    souhoola: "souhoola",
    tabby: "tabby"
  };
}
