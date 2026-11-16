export default class PaymentSDKAccountFunding {
  constructor(
    purpose,
    senderType,
    senderIsRecipient,
    sender,
    recipient,
    customer
  ) {
    this.purpose = purpose;
    this.senderType = senderType;
    this.senderIsRecipient = senderIsRecipient;
    this.sender = sender;
    this.recipient = recipient;
    this.customer = customer;
  }
}
