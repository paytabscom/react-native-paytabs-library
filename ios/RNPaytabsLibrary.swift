//
//  RNPaytabsLibrary.swift
//  react-native-paytabs-emulator
//
//  Created by Mohamed Adly on 16/03/2021.
//

import Foundation
import PaymentSDK

@objc(RNPaytabsLibrary)
class RNPaytabsLibrary: NSObject {
    var resolve: RCTPromiseResolveBlock?
    var reject: RCTPromiseRejectBlock?
    
    @objc(startCardPayment:withResolver:withRejecter:)
    func startCardPayment(paymentDetails: NSString,
                          resolve: @escaping RCTPromiseResolveBlock,
                          reject: @escaping RCTPromiseRejectBlock) -> Void {
        self.resolve = resolve
        self.reject = reject
        let data = Data((paymentDetails as String).utf8)
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
            let configuration = generateConfiguration(dictionary: dictionary)
            if let rootViewController = getRootController() {
                PaymentSDK.startCardPayment(on: rootViewController, configuration: configuration, delegate: self)
            }
        } catch let error {
            reject("", error.localizedDescription, error)
        }
    }
    
    @objc(startApplePayPayment:withResolver:withRejecter:)
    func startApplePayPayment(paymentDetails: NSString,
                          resolve: @escaping RCTPromiseResolveBlock,
                          reject: @escaping RCTPromiseRejectBlock) -> Void {
        self.resolve = resolve
        self.reject = reject
        let data = Data((paymentDetails as String).utf8)
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
            let configuration = generateConfiguration(dictionary: dictionary)
            if let rootViewController = getRootController() {
                PaymentSDK.startApplePayPayment(on: rootViewController, configuration: configuration, delegate: self)
            }
        } catch let error {
            reject("", error.localizedDescription, error)
        }
    }
    
    func getRootController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first
            let topController = keyWindow?.rootViewController
            return topController
        }
    
    private func generateConfiguration(dictionary: [String: Any]) -> PaymentSDKConfiguration {
        let configuration = PaymentSDKConfiguration()
        configuration.profileID = dictionary["profileID"] as? String ?? ""
        configuration.serverKey = dictionary["serverKey"] as? String ?? ""
        configuration.clientKey = dictionary["clientKey"] as? String ?? ""
        configuration.cartID = dictionary["cartID"] as? String ?? ""
        configuration.cartDescription = dictionary["cartDescription"] as? String ?? ""
        configuration.amount = dictionary["amount"] as? Double ?? 0.0
        configuration.currency =  dictionary["currency"] as? String ?? ""
        configuration.merchantName = dictionary["merchantName"] as? String ?? ""
        configuration.screenTitle = dictionary["screenTitle"] as? String
        configuration.merchantCountryCode = dictionary["merchantCountryCode"] as? String ?? ""
        configuration.merchantIdentifier = dictionary["merchantIdentifier"] as? String
        configuration.simplifyApplePayValidation = dictionary["simplifyApplePayValidation"] as? Bool ?? false
        configuration.theme = .default
        if let billingDictionary = dictionary["billingDetails"] as?  [String: Any] {
            configuration.billingDetails = generateBillingDetails(dictionary: billingDictionary)
        }
        return configuration
    }
    
    
    private func generateBillingDetails(dictionary: [String: Any]) -> PaymentSDKBillingDetails? {
        let billingDetails = PaymentSDKBillingDetails()
        billingDetails.name = dictionary["name"] as? String ?? ""
        billingDetails.phone = dictionary["phone"] as? String ?? ""
        billingDetails.email = dictionary["email"] as? String ?? ""
        billingDetails.addressLine = dictionary["addressLine"] as? String ?? ""
        billingDetails.countryCode = dictionary["countryCode"] as? String ?? ""
        billingDetails.city = dictionary["city"] as? String ?? ""
        billingDetails.state = dictionary["state"] as? String ?? ""
        billingDetails.zip = dictionary["zip"] as? String ?? ""
        return billingDetails
    }
    
}

extension RNPaytabsLibrary: PaymentSDKDelegate {
    func paymentSDK(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {
        if let error = error, let reject = reject {
            return reject("", error.localizedDescription, error)
        }
        
        if let resolve = resolve {
            resolve(transactionDetails)
        }
    }
}
