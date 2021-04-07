/**
 * Sample React Native App
 *
 * adapted from App.js generated by the following command:
 *
 * react-native init example
 *
 * https://github.com/facebook/react-native
 */

import React, { Component } from 'react';
import {Platform, StyleSheet, Text, Button, View } from 'react-native';
import {RNPaymentSDKLibrary, PaymentSDKConfiguration, PaymentSDKBillingDetails, PaymentSDKTheme} from '@paytabs/react-native-clickpay';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

export default class App extends Component {

  state = {
    message: '--'
  };
  
  constructor(props){
    super(props);
    this.state = { message: '' };
  }

  onPressPay(){
  
    let configuration = new PaymentSDKConfiguration();
    configuration.profileID = "profile id"
    configuration.serverKey= "server key"
    configuration.clientKey = "client key"
    configuration.cartID = "545454"
    configuration.currency = "SAR"
    configuration.cartDescription = "Flowers"
    configuration.merchantCountryCode = "sa"
    configuration.merchantName = "Flowers Store"
    configuration.amount = 20
    configuration.screenTitle = "Pay with Card"

    let billingDetails = new PaymentSDKBillingDetails(name= "Mohamed Adly",
                                  email= "m.adly@paytabs.com",
                                  phone= "+201113655936",
                                  addressLine= "Flat 1,Building 123, Road 2345",
                                  city= "Dubai",
                                  state= "Dubai",
                                  countryCode= "AE",
                                  zip= "1234")
    configuration.billingDetails = billingDetails
    let theme = new PaymentSDKTheme()
    // theme.backgroundColor = "a83297"
    configuration.theme = theme

    RNPaymentSDKLibrary.startCardPayment(JSON.stringify(configuration)).then( result => {
      if(result["PaymentDetails"] != null) {
        let paymentDetails = result["PaymentDetails"]
        console.log(paymentDetails)
      } else if(result["Event"] == "CancelPayment") {
        console.log("Cancel Payment Event")
      } 
     }, function(error) {
      console.log(error)
     });
    
  }
  onPressApplePay(){
    let configuration = new PaymentSDKConfiguration();
    configuration.profileID = "profile id"
    configuration.serverKey= "server key"
    configuration.clientKey = "client key"
    configuration.cartID = "545454"
    configuration.currency = "AED"
    configuration.cartDescription = "Flowers"
    configuration.merchantCountryCode = "ae"
    configuration.merchantName = "Sand Box"
    configuration.amount = 20
    configuration.merchantIdentifier = "merchant.com.bundleid"

    RNPaymentSDKLibrary.startApplePayPayment(JSON.stringify(configuration)).then( result => {
        if(result["PaymentDetails"] != null) {
          let paymentDetails = result["PaymentDetails"]
          console.log(paymentDetails)
        } else if(result["Event"] == "CancelPayment") {
          console.log("Cancel Payment Event")
        } 
     }, function(error) {
      console.log(error)
     });
  }
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome to ClickPay React Native!</Text>
        <Text style={styles.instructions}>To get started, edit App.js</Text>
        <Text style={styles.instructions}>{instructions}</Text>
        <Text style={styles.instructions}>{this.state.message}</Text>
        <Button
            onPress={this.onPressPay}
            title="Pay with Card"
            color="#c00"
          />
        <View style = {{height: 20}}></View>
        <Button
            onPress={this.onPressApplePay}
            title="Pay with Apple Pay"
            color="#c00"
            disabled = { Platform.OS != 'ios'}
          />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
