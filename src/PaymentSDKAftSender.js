export default class PaymentSDKAftSender {
  constructor(
    accountNumber,
    accountType,
    referenceNumber,
    sourceOfFunds,
    address,
    state,
    zip,
    city,
    country,
    firstName,
    middleName,
    lastName,
    phone,
    personalIdType,
    taxType,
    identificationNumber,
    dateOfBirth
  ) {
    this.accountNumber = accountNumber;
    this.accountType = accountType;
    this.referenceNumber = referenceNumber;
    this.sourceOfFunds = sourceOfFunds;
    this.address = address;
    this.state = state;
    this.zip = zip;
    this.city = city;
    this.country = country;
    this.firstName = firstName;
    this.middleName = middleName;
    this.lastName = lastName;
    this.phone = phone;
    this.personalIdType = personalIdType;
    this.taxType = taxType;
    this.identificationNumber = identificationNumber;
    this.dateOfBirth = dateOfBirth;
  }
}
