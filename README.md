
# react-native-paytabs
![Version](https://img.shields.io/badge/React%20Native%20Paytabs-v2-green)

React native paytabs library is a wrapper for the native PayTabs Android and iOS SDKs, It helps you integrate with PayTabs seamlessly.

Library Support:

* [x] iOS
* [x] Android

# Installation

```sh
$ npm install @paytabs/react-native-paytabs@2.3.4 --save --force
```

### Expo

```sh
expo install @paytabs/react-native-paytabs
```

### Follow the below steps to complete the installation

* Android
	* Add dependencies to project `build.gradle` file
	
	```
	allprojects {
	repositories {
    ...
	    maven { url "http://pay.cards/maven" }
		}
	}
	```
	
	* Add `packagingOptions` to module `build.gradle` file
	
	```
	android {
    ...
		packagingOptions {
        	pickFirst '**/*.so'
    	}
	}
	```
* iOS

	* Add `libswiftWebKit.tbd` to your **Link Binary With Libraries**
	* Navigate to the iOS folder and run the following command: 
	
	```
	pod install
	```

## Usage

Import `@paytabs/react-native-paytabs`

```javascript
import {RNPaymentSDKLibrary, PaymentSDKConfiguration, PaymentSDKBillingDetails, PaymentSDKTheme, PaymentSDKConstants} from '@paytabs/react-native-paytabs';
```

### Pay with Card

1. Configure the billing & shipping info, the shipping info is optional

```javascript
let billingDetails = new PaymentSDKBillingDetails(name= "John Smith",
                                  email= "email@test.com",
                                  phone= "+2011111111",
                                  addressLine= "address line",
                                  city= "Dubai",
                                  state= "Dubai",
                                  countryCode= "ae", // ISO alpha 2
                                  zip= "1234")

let shippingDetails = new PaymentSDKShippingDetails(name= "John Smith",
                                  email= "email@test.com",
                                  phone= "+2011111111",
                                  addressLine= "address line",
                                  city= "Dubai",
                                  state= "Dubai",
                                  countryCode= "ae", // ISO alpha 2
                                  zip= "1234")
                                              
```

2. Create object of `PaymentSDKConfiguration` and fill it with your credentials and payment details.

```javascript

let configuration = new PaymentSDKConfiguration();
    configuration.profileID = "*your profile id*"
    configuration.serverKey= "*server key*"
    configuration.clientKey = "*client key*"
    configuration.cartID = "545454"
    configuration.currency = "AED"
    configuration.cartDescription = "Flowers"
    configuration.merchantCountryCode = "ae"
    configuration.merchantName = "Flowers Store"
    configuration.amount = 20
    configuration.screenTitle = "Pay with Card"
    configuration.billingDetails = billingDetails
	 configuration.forceShippingInfo = false
```

Options to show billing and shipping ifno

```javascript

	configuration.showBillingInfo = true
	configuration.showShippingInfo = true
	
```

3. Start payment by calling `startCardPayment` method and handle the transaction details 

```javascript

RNPaymentSDKLibrary.startCardPayment(JSON.stringify(configuration)).then( result => {
      if(result["PaymentDetails"] != null) { // Handle transaction details
        let paymentDetails = result["PaymentDetails"]
        console.log(paymentDetails)
      } else if(result["Event"] == "CancelPayment") { // Handle events
        console.log("Cancel Payment Event")
      } 
     }, function(error) { // Handle error
      console.log(error)
     });
     
```

### Pay with Apple Pay

1. Follow the guide [Steps to configure Apple Pay][applepayguide] to learn how to configure ApplePay with PayTabs.

2. Do the steps 1 and 2 from **Pay with Card** although you can ignore Billing & Shipping details and Apple Pay will handle it, also you must pass the **merchant name** and **merchant identifier**.

```javascript

let configuration = new PaymentSDKConfiguration();
    configuration.profileID = "*your profile id*"
    configuration.serverKey= "*server key*"
    configuration.clientKey = "*client key*"
    configuration.cartID = "545454"
    configuration.currency = "AED"
    configuration.cartDescription = "Flowers"
    configuration.merchantCountryCode = "ae"
    configuration.merchantName = "Flowers Store"
    configuration.amount = 20
    configuration.screenTitle = "Pay with Card"
    configuration.merchantIdentifier = "merchant.com.bundleID"

```

3. To simplify ApplePay validation on all user's billing info, pass **simplifyApplePayValidation** parameter in the configuration with **true**.

```javascript

configuration.simplifyApplePayValidation = true

```

4. Call `startApplePayPayment` to start payment

```javascript
RNPaymentSDKLibrary.startApplePayPayment(JSON.stringify(configuration)).then( result => {
        if(result["PaymentDetails"] != null) { // Handle transaction details
          let paymentDetails = result["PaymentDetails"]
          console.log(paymentDetails)
        } else if(result["Event"] == "CancelPayment") { // Handle events
          console.log("Cancel Payment Event")
        } 
     }, function(error) { // handle errors
      console.log(error)
     });
```

### Pay with Samsung Pay

Pass Samsung Pay token to the configuration and call `startCardPayment`

```javascript
configuration.samsungToken = "token"
```

### Pay with Alternative Payment Methods

It becomes easy to integrate with other payment methods in your region like STCPay, OmanNet, KNet, Valu, Fawry, UnionPay, and Meeza, to serve a large sector of customers.

1. Do the steps 1 and 2 from **Pay with Card**.

2. Choose one or more of the payment methods you want to support.

```javascript
configuration.alternativePaymentMethods = [PaymentSDKConstants.AlternativePaymentMethod.stcPay]
```

3. Start payment by calling `startAlternativePaymentMethod` method and handle the transaction details 

```javascript

RNPaymentSDKLibrary.startAlternativePaymentMethod(JSON.stringify(configuration)).then( result => {
      if(result["PaymentDetails"] != null) { // Handle transaction details
        let paymentDetails = result["PaymentDetails"]
        console.log(paymentDetails)
      } else if(result["Event"] == "CancelPayment") { // Handle events
        console.log("Cancel Payment Event")
      } 
     }, function(error) { // Handle error
      console.log(error)
     });
     
```

## Tokenisation

Follow the below instructions to enable tokenisation feature.

1. Request token

```javascript
configuration.tokeniseType = PaymentSDKConstants.TokeniseType.userOptinoal // read more about the tokeniseType in the enums section 
configuration.tokenFormat = PaymentSDKConstants.TokeniseFormat.hex32 // read more about the tokenFormat in the enums section  

```
After passing those parameters, you will receive a token and transaction reference in the result callback, save them for future usage.

2. Pass the token & transaction reference

```javascript
configuration.token = token
configuration.transactionReference = transactionreference
```


## Enums

Those enums will help you in customizing your configuration.

* Tokenise types

 The default type is none

```javascript
TokeniseType = {
"none":"none", // tokenise is off
"merchantMandatory":"merchantMandatory", // tokenise is forced
"userMandatory":"userMandatory", // tokenise is forced as per user approval
"userOptinoal":"userOptional" // tokenise if optional as per user approval
};
```

```javascript
configuration.tokeniseType = PaymentSDKConstants.TokeniseType.userOptinoal
```

* Token formats

The default format is hex32

```javascript
TokeniseFormat = {"none":"1", 
"hex32": "2", 
"alphaNum20": "3", 
"digit22": "3", 
"digit16": "5", 
"alphaNum32": "6"
};
```
```javascript
configuration.tokenFormat = PaymentSDKConstants.TokeniseFromat.hex32
```

* Transaction types

The default type is sale

```javascript
TransactionType = {"sale":"sale", 
"authorize": "auth"};
```

```javascript
configuration.transactionType = PaymentSDKConstants.TransactionType.sale
```

* Alternative payment methods

```javascript
AlternativePaymentMethod = {"unionPay":"unionpay", "stcPay":"stcpay", "valu": "valu", "meezaQR": "meezaqr", "omannet": "omannet", "knetCredit": "knetcredit", "knetDebit": "knetdebit", "fawry": "fawry"};
```

```javascript
configuration.alternativePaymentMethods = [PaymentSDKConstants.AlternativePaymentMethod.stcPay, ...]
```

## Show/Hide Card Scanner

```javascript
configuration.hideCardScanner = true
```

## Theme Customization

![UI guide](https://user-images.githubusercontent.com/13621658/109432213-d7981380-7a12-11eb-9224-c8fc12b0024d.jpg)

### iOS

- **Theme**: <br />Create an instance from the class `PaymentTheme` and customize the theme.

```javascript
let theme = new PaymentSDKTheme()
theme.backgroundColor = "a83297"
theme.primaryColor = "956596"
// Set the merchant logo
const merchantLogo = require('./Logo.png');
const resolveAssetSource = require('react-native/Libraries/Image/resolveAssetSource');
const resolvedMerchantLogo = resolveAssetSource(merchantLogo);
theme.merchantLogo = resolvedMerchantLogo

configuration.theme = theme
```

- **Localization**:
<br />Use the keys from our localization string files ([English][iosenglish], [Arabic][iosarabic]), then add the same key to your app localizable string file and add your custom string.

### Android

- **Theme**: <br />Edit your `styles.xml` to customize the theme.

````xml
<resources>
  // to override colors
     <color name="payment_sdk_primary_color">#5C13DF</color>
     <color name="payment_sdk_secondary_color">#FFC107</color>
     <color name="payment_sdk_primary_font_color">#111112</color>
     <color name="payment_sdk_secondary_font_color">#6D6C70</color>
     <color name="payment_sdk_separators_color">#FFC107</color>
     <color name="payment_sdk_stroke_color">#673AB7</color>
     <color name="payment_sdk_button_text_color">#FFF</color>
     <color name="payment_sdk_title_text_color">#FFF</color>
     <color name="payment_sdk_button_background_color">#3F51B5</color>
     <color name="payment_sdk_background_color">#F9FAFD</color>
     <color name="payment_sdk_card_background_color">#F9FAFD</color> 
   
  // to override dimens
     <dimen name="payment_sdk_primary_font_size">17sp</dimen>
     <dimen name="payment_sdk_secondary_font_size">15sp</dimen>
     <dimen name="payment_sdk_separator_thickness">1dp</dimen>
     <dimen name="payment_sdk_stroke_thickness">.5dp</dimen>
     <dimen name="payment_sdk_input_corner_radius">8dp</dimen>
     <dimen name="payment_sdk_button_corner_radius">8dp</dimen>
     
</resources>
````
- **Merchant Logo**:

```javascript
let theme = new PaymentSDKTheme()

// Set the merchant logo
const merchantLogo = require('./Logo.png');
const resolveAssetSource = require('react-native/Libraries/Image/resolveAssetSource');
const resolvedMerchantLogo = resolveAssetSource(merchantLogo);
theme.merchantLogo = resolvedMerchantLogo

configuration.theme = theme
```

- **Localization**:
To override your strings you can find the keys with the default values here
[English][english], [Arabic][arabic].

## Demo application

Check our complete examples ([React-Native][example], [Expo][expoexample]).

<img src="https://user-images.githubusercontent.com/13621658/109432386-905e5280-7a13-11eb-847c-63f2c554e2d1.png" width="370">

## License

See [LICENSE][license].

## Paytabs

[Support][1] | [Terms of Use][2] | [Privacy Policy][3]

 [1]: https://www.paytabs.com/en/support/
 [2]: https://www.paytabs.com/en/terms-of-use/
 [3]: https://www.paytabs.com/en/privacy-policy/
 [license]: https://github.com/paytabscom/react-native-paytabs-library/blob/master/LICENSE
 [applepayguide]: https://github.com/paytabscom/react-native-paytabs-library/blob/master/ApplePayConfiguration.md
 [example]: https://github.com/paytabscom/react-native-paytabs-library/tree/master/example
 [expoexample]: https://github.com/paytabscom/react-native-paytabs-library/tree/master/expo-example
[english]: https://github.com/paytabscom/paytabs-android-library-sample/blob/master/res/strings.xml
 [arabic]: https://github.com/paytabscom/paytabs-android-library-sample/blob/master/res/strings-ar.xml
 [iosenglish]: https://github.com/paytabscom/paytabs-ios-library-sample/blob/master/en.strings
 [iosarabic]: https://github.com/paytabscom/paytabs-ios-library-sample/blob/master/ar.strings
 
