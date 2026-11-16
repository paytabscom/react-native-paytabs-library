export default class PaymentSDKAftRecipient {
  constructor(accountIdentifier, accountType, fundingMethod) {
    this.accountIdentifier = accountIdentifier;
    this.accountType = accountType;
    this.fundingMethod = fundingMethod;
  }
}
