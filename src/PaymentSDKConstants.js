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
  static TransactionType = {
    sale: 'sale',
    authorize: 'auth',
    register: 'Register',
  };
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
    urpay: 'urpay',
    applePay: 'applePay',
    souhoola: 'souhoola',
    tabby: 'tabby',
    tru: 'tru',
    tamara: 'tamara',
    forsa: 'forsa',
  };

  static PaymentSDKNetworks = {
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
