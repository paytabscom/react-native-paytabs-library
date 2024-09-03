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
import { Platform, StyleSheet, Text, Button, View } from 'react-native';
import {
  RNPaymentSDKLibrary,
  PaymentSDKConfiguration,
  PaymentSDKBillingDetails,
  PaymentSDKSavedCardInfo,
  PaymentSDKCardDiscount,
  PaymentSDKNetworks,
} from '@paytabs/react-native-paytabs';
import { PaymentSDKConstants, PaymentSDKTheme } from '../../lib/module';
import { delay } from 'react-native/Libraries/Animated/AnimatedImplementation';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android: 'Double tap R on your keyboard to reload,\n' + 'Shake or press menu button for dev menu',
});
let configuration = new PaymentSDKConfiguration();
configuration.profileID = '****';
configuration.serverKey = '****';
configuration.clientKey = '****';
configuration.cartID = '****';
configuration.currency = 'SAR';
configuration.cartDescription = 'Flowers';
configuration.merchantCountryCode = 'AE';
configuration.merchantName = 'Flowers Store2';
configuration.amount = 20;
configuration.screenTitle = 'Pay using Card';
configuration.expiryTime = 65;

let billingDetails = new PaymentSDKBillingDetails('Jones Smith', 'email@domain.com', '97311111111', 'Flat 1,Building 123, Road 2345', 'Dubai', 'Dubai', 'AE', '1234');
configuration.billingDetails = billingDetails;

const selectedNetworks = [PaymentSDKNetworks.VISA, PaymentSDKNetworks.MASTERCARD];

configuration.paymentNetworks = selectedNetworks;

let theme = new PaymentSDKTheme();
theme.backgroundColor = 'a83297';
theme.primaryColor = '956596';
// Set the merchant logo
//const merchantLogo = require('./Logo.png');
//const resolveAssetSource = require('react-native/Libraries/Image/resolveAssetSource');
//const resolvedMerchantLogo = resolveAssetSource(merchantLogo);
//theme.merchantLogo = resolvedMerchantLogo

configuration.theme = theme;

export default class App extends Component {
  state = {
    message: '--',
  };

  constructor(props) {
    super(props);
    this.state = { message: '' };
  }

  onPressPay() {
    RNPaymentSDKLibrary.startCardPayment(JSON.stringify(configuration)).then((result) => {
      if (result.PaymentDetails != null) {
        let paymentDetails = result.PaymentDetails;
        console.log(paymentDetails);
      } else if (result.Event === 'CancelPayment') {
        console.log('Cancel Payment Event');
      }
    }, function(error) {
      console.log(error);
    });
  }

  onPressTokenizedPayment() {
    RNPaymentSDKLibrary.startTokenizedCardPayment(JSON.stringify(configuration), 'Token', 'TransactionReference').then((result) => {
      if (result.PaymentDetails != null) {
        let paymentDetails = result.PaymentDetails;
        console.log(paymentDetails);
      } else if (result.Event == 'CancelPayment') {
        console.log('Cancel Payment Event');
      }
    }, function(error) {
      console.log(error);
    });
  }

  onPress3DsPayment() {
    let cardInfo = new PaymentSDKSavedCardInfo('4111 11## #### 1111', 'visa');
    RNPaymentSDKLibrary.start3DSecureTokenizedCardPayment(JSON.stringify(configuration), JSON.stringify(cardInfo), 'Token').then((result) => {
      if (result.PaymentDetails != null) {
        let paymentDetails = result.PaymentDetails;
        console.log(paymentDetails);
      } else if (result.Event == 'CancelPayment') {
        console.log('Cancel Payment Event');
      }
    }, function(error) {
      console.log(error);
    });
  }

  onPressSavedCardPayment() {
    RNPaymentSDKLibrary.startPaymentWithSavedCards(JSON.stringify(configuration), false).then((result) => {
      if (result.PaymentDetails != null) {
        let paymentDetails = result.PaymentDetails;
        console.log(paymentDetails);
      } else if (result.Event === 'CancelPayment') {
        console.log('Cancel Payment Event');
      }
    }, function(error) {
      console.log(error);
    });
  }

  onPressApplePay() {
    RNPaymentSDKLibrary.startApplePayPayment(JSON.stringify(configuration)).then((result) => {
      if (result.PaymentDetails != null) {
        let paymentDetails = result.PaymentDetails;
        console.log(paymentDetails);
      } else if (result.Event === 'CancelPayment') {
        console.log('Cancel Payment Event');
      }
    }, function(error) {
      console.log(error);
    });
  }

  sleeper(ms) {
    return function(x) {
      return new Promise(resolve => setTimeout(() => resolve(x), ms));
    };
  }

  render() {
    return (<View style={styles.container}>
      <Text style={styles.welcome}>Welcome to Paytabs React-Native!</Text>
      <Text style={styles.instructions}>To get started, edit App.js</Text>
      <Text style={styles.instructions}>{instructions}</Text>
      <Text style={styles.instructions}>{this.state.message}</Text>
      <Button onPress={this.onPressPay} title='Pay with Card' color='#c00' />
      <View style={{ height: 20 }} />
      <Button
        onPress={this.onPressTokenizedPayment}
        title='Start tokenized payment'
        color='#c00'
      />
      <View style={{ height: 20 }} />
      <Button
        onPress={this.onPress3DsPayment}
        title='Start 3DS Tokenized Card payment'
        color='#c00'
      />
      <View style={{ height: 20 }} />
      <Button
        onPress={this.onPressSavedCardPayment}
        title='Start saved card payment'
        color='#c00'
      />
      <View style={{ height: 20 }} />
      <Button
        onPress={this.onPressApplePay}
        title='Pay with Apple Pay'
        color='#c00'
        disabled={Platform.OS !== 'ios'}
      />
      <View style={{ height: 20 }} />
      <Button
        onPress={async () => {
          console.log('Cancel payment');
          setTimeout(() => {
            RNPaymentSDKLibrary.cancelPayment();
          }, 3000);
        }}
        title='Cancel Payment'
        color='#c00'
      />
      <View style={{ height: 20 }} />
      <Button
        onPress={this.onPressSTCPay}
        title='Pay with STC Pay'
        color='#c00'
      />
    </View>);
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1, justifyContent: 'center', alignItems: 'center', backgroundColor: '#F5FCFF',
  }, welcome: {
    fontSize: 20, textAlign: 'center', margin: 10,
  }, instructions: {
    textAlign: 'center', color: '#333333', marginBottom: 5,
  },
});
