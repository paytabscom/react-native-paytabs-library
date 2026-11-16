export default class PaymentSDKAftCustomer {
  constructor(
    firstName,
    middleName,
    lastName,
    identificationType,
    identificationValue,
    identificationCountry
  ) {
    this.firstName = firstName;
    this.middleName = middleName;
    this.lastName = lastName;
    this.identificationType = identificationType;
    this.identificationValue = identificationValue;
    this.identificationCountry = identificationCountry;
  }
}
