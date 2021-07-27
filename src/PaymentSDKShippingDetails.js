export default class PaymentSDKShippingDetails {
    constructor(name, email, phone, addressLine, city, state, countryCode, zip) {
        this.name = name
        this.email = email
        this.phone = phone
        this.addressLine = addressLine
        this.city = city
        this.state = state
        this.countryCode = countryCode
        this.zip = zip
    }
}