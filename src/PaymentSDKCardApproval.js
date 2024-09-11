export default class PaymentSDKCardApproval {
  constructor(validationUrl, binLength, blockIfNoResponse) {
    this.validationUrl = validationUrl;
    this.binLength = binLength;
    this.blockIfNoResponse = blockIfNoResponse;
  }
  }
