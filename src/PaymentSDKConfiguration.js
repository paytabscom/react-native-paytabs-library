export default class PaymentSDKConfiguration {
  constructor(
    profileID,
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
    samsungToken,
    theme,
    isDigitalProduct,
    enableZeroContacts,
    expiryTime,
    cardDiscounts,
    cardApproval
  ) {
    this.profileID = profileID;
    this.serverKey = serverKey;
    this.clientKey = clientKey;
    this.transactionType = transactionType;
    this.transactionClass = transactionClass;
    this.cartID = cartID;
    this.currency = currency;
    this.amount = amount;
    this.cartDescription = cartDescription;
    this.languageCode = languageCode;
    this.forceShippingInfo = forceShippingInfo;
    this.showBillingInfo = showBillingInfo;
    this.showShippingInfo = showShippingInfo;
    this.billingDetails = billingDetails;
    this.shippingDetails = shippingDetails;
    this.merchantCountryCode = merchantCountryCode;
    this.screenTitle = screenTitle;
    this.merchantName = merchantName;
    this.serverIP = serverIP;
    this.tokeniseType = tokeniseType;
    this.tokenFormat = tokenFormat;
    this.hideCardScanner = hideCardScanner;
    this.merchantIdentifier = merchantIdentifier;
    this.simplifyApplePayValidation = simplifyApplePayValidation;
    this.paymentNetworks = paymentNetworks;
    this.token = token;
    this.transactionReference = transactionReference;
    this.theme = theme;
    this.samsungToken = samsungToken;
    this.isDigitalProduct = isDigitalProduct;
    this.enableZeroContacts = enableZeroContacts;
    this.expiryTime = expiryTime;
    this.cardDiscounts = cardDiscounts;
    this.cardApproval = cardApproval;
  }
}
