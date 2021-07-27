import { StatusBar } from 'expo-status-bar';
import React, { Component } from 'react';
import { StyleSheet, Button, View, Text, Alert, Platform} from 'react-native';
import {RNPaymentSDKLibrary,PaymentSDKConfiguration, PaymentSDKBillingDetails, PaymentSDKTheme, PaymentSDKConstants} from '@paytabs/react-native-paytabs';

export default class App extends Component{
  render() {
    return (
    <View style={styles.container}>
      <Text>
          Expo Sample App.
        </Text>
        <View style = {{height: 20}}></View>
        <Button title="Pay with Card" onPress={() => this.payWithCard()} />
        <View style = {{height: 20}}></View>
        <Button title="Pay with ApplePay" onPress={() => this.payWithApplePay()} disabled = { Platform.OS != 'ios'} />
        <View style = {{height: 20}}></View>
        <Button title="Alternative Payment Method" onPress={() => this.payWithAPM()} />
      <StatusBar style="auto" />
    </View>
    );
  }

  payWithCard(){
    var billingDetails: PaymentSDKBillingDetails = {
      name: "John Smith",
      email: "email@domain.com",
      phone: "+97311111111",
      addressLine: "Flat 1,Building 123, Road 2345",
      city: "Dubai",
      state: "Dubai",
      countryCode: "AE",
      zip: "1234"
    };

    var configuration: PaymentSDKConfiguration = {
      profileID: "*Profile Id*",
      serverKey: "*Server Key*",
      clientKey: "*Client Key*",
      cartID: "12345",
      currency: "AED",
      cartDescription: "Flowers",
      merchantCountryCode: "ae",
      merchantName: "Flowers Store",
      amount: 20,
      screenTitle:"Pay with Card",
      billingDetails: billingDetails
    }; 

    // var theme: PaymentSDKTheme = {
    //   backgroundColor: "colorHex"
    // };

    // configuration.theme = theme

    RNPaymentSDKLibrary.startCardPayment(JSON.stringify(configuration)).then( result => {
      this.showPaymentResult(result);
     }).catch( error => {
       Alert.alert("Expo App", error);
     });

  }

  payWithAPM(){
    var billingDetails: PaymentSDKBillingDetails = {
      name: "John Smith",
      email: "email@domain.com",
      phone: "+97311111111",
      addressLine: "Flat 1,Building 123, Road 2345",
      city: "Dubai",
      state: "Dubai",
      countryCode: "AE",
      zip: "1234"
    };

    var configuration: PaymentSDKConfiguration = {
      profileID: "*Profile Id*",
      serverKey: "*Server Key*",
      clientKey: "*Client Key*",
      cartID: "12345",
      currency: "AED",
      cartDescription: "Flowers",
      merchantCountryCode: "ae",
      merchantName: "Flowers Store",
      amount: 1000,
      screenTitle:"Pay with Card",
      billingDetails: billingDetails
    }; 

    configuration.alternativePaymentMethods = [PaymentSDKConstants.AlternativePaymentMethod.valu, PaymentSDKConstants.AlternativePaymentMethod.fawry];
    
    RNPaymentSDKLibrary.startAlternativePaymentMethod(JSON.stringify(configuration)).then( result => {
      this.showPaymentResult(result);
     }).catch( error => {
       Alert.alert("Expo App", error);
     });
  }

  payWithApplePay(){
    var billingDetails: PaymentSDKBillingDetails = {
      name: "John Smith",
      email: "email@domain.com",
      phone: "+97311111111",
      addressLine: "Flat 1,Building 123, Road 2345",
      city: "Dubai",
      state: "Dubai",
      countryCode: "AE",
      zip: "1234"
    };

    var configuration: PaymentSDKConfiguration = {
      profileID: "*Profile Id*",
      serverKey: "*Server Key*",
      clientKey: "*Client Key*",
      cartID: "12345",
      currency: "AED",
      cartDescription: "Flowers",
      merchantCountryCode: "ae",
      merchantName: "Flowers Store",
      amount: 1000,
      screenTitle:"Pay with Card",
      billingDetails: billingDetails
    }; 

    configuration.merchantIdentifier = "merchant.com.applepayid"

    RNPaymentSDKLibrary.startApplePayPayment(JSON.stringify(configuration)).then( result => {
      this.showPaymentResult(result);
     }).catch( error => {
       Alert.alert("Expo App", error);
     });

  }

  showPaymentResult(result: any) {
    if(result["PaymentDetails"] != null) {
      let paymentDetails = result["PaymentDetails"]
      console.log(paymentDetails)

      if(paymentDetails != null) {
        let paymentResult = paymentDetails["paymentResult"];
        let message = "responseCode:" + paymentResult["responseCode"];
        message = message + '\n' + "responseMessage:" + paymentResult["responseMessage"];
        message = message + '\n' + "responseStatus:" + paymentResult["responseStatus"];
        message = message + '\n' + "transactionTime:" + paymentResult["transactionTime"];
        Alert.alert("Expo App","Payment Result\n" + message);
      }
    } else if(result["Event"] == "CancelPayment") {
      Alert.alert("Expo App","Cancel Payment Event");
    };
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
